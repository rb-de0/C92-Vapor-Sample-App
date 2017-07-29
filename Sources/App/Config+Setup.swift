import LeafProvider
import MySQLProvider
import AuthProvider
import RedisProvider
import Sessions

extension Config {
    
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [JSON.self, Node.self]

        try setupConfiguable()
        try setupProviders()
        try setupPreparations()
    }
    
    private func setupConfiguable() throws {
        let redisCache = try RedisCache(config: self)
        let sessions = CacheSessions(redisCache)
        
        addConfigurable(middleware: { _ in SessionsMiddleware(sessions) }, name: "redis-sessions")
        addConfigurable(middleware: { _ in PersistMiddleware(User.self) }, name: "persist-user")
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(LeafProvider.Provider.self)
        try addProvider(MySQLProvider.Provider.self)
        try addProvider(AuthProvider.Provider.self)
    }
    
    private func setupPreparations() throws {
        preparations.append(User.self)
    }
}
