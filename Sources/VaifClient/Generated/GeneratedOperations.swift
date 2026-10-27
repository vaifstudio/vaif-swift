// Generated from the VAIF Studio API's OpenAPI document. Do not edit by hand.
// Spec sha256:615e77b7a0789543; 801 operations generated, 142 not generated (see OperationsClient.ungenerated).
import Foundation

extension OperationsClient {
    /// How many operations this file was generated with (801).
    public static let generatedCount = 801

    /// Every generated operation, from the API's OpenAPI document.
    public static let all: [String: OperationDescriptor] = {
        var ops: [String: OperationDescriptor] = [:]
        ops["deleteAiCopilotSessionBySessionId"] = OperationDescriptor(method: "DELETE", path: "/ai/copilot/session/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteAlertRulesByRuleId"] = OperationDescriptor(method: "DELETE", path: "/alert-rules/{ruleId}", pathParameters: ["ruleId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteAuthMeLinkedAccountsByProvider"] = OperationDescriptor(method: "DELETE", path: "/auth/me/linked-accounts/{provider}", pathParameters: ["provider"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteAuthSessionsById"] = OperationDescriptor(method: "DELETE", path: "/auth/sessions/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteBillingOrgByOrgIdAddonsByAddonId"] = OperationDescriptor(method: "DELETE", path: "/billing/org/{orgId}/addons/{addonId}", pathParameters: ["orgId", "addonId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteBillingOrgByOrgIdContactsByContactId"] = OperationDescriptor(method: "DELETE", path: "/billing/org/{orgId}/contacts/{contactId}", pathParameters: ["orgId", "contactId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteBillingOrgByOrgIdUsageAlertsByAlertId"] = OperationDescriptor(method: "DELETE", path: "/billing/org/{orgId}/usage-alerts/{alertId}", pathParameters: ["orgId", "alertId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteBucketsByBucketId"] = OperationDescriptor(method: "DELETE", path: "/buckets/{bucketId}", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteBucketsByBucketIdFiles"] = OperationDescriptor(method: "DELETE", path: "/buckets/{bucketId}/files", pathParameters: ["bucketId"], requiredQuery: ["key"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDatabaseExtensionsProjectByProjectIdByExtensionId"] = OperationDescriptor(method: "DELETE", path: "/database/extensions/project/{projectId}/{extensionId}", pathParameters: ["projectId", "extensionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDatabaseWrappersProjectByProjectIdByWrapperId"] = OperationDescriptor(method: "DELETE", path: "/database/wrappers/project/{projectId}/{wrapperId}", pathParameters: ["projectId", "wrapperId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsApiEndpointsById"] = OperationDescriptor(method: "DELETE", path: "/docs/api-endpoints/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsChangelogById"] = OperationDescriptor(method: "DELETE", path: "/docs/changelog/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsExamplesById"] = OperationDescriptor(method: "DELETE", path: "/docs/examples/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsSdkExamplesById"] = OperationDescriptor(method: "DELETE", path: "/docs/sdk-examples/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsSdksById"] = OperationDescriptor(method: "DELETE", path: "/docs/sdks/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteDocsV2PagesById"] = OperationDescriptor(method: "DELETE", path: "/docs/v2/pages/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteFlagsByKey"] = OperationDescriptor(method: "DELETE", path: "/flags/{key}", pathParameters: ["key"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteFunctionsByFunctionId"] = OperationDescriptor(method: "DELETE", path: "/functions/{functionId}", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteFunctionsByFunctionIdSchedule"] = OperationDescriptor(method: "DELETE", path: "/functions/{functionId}/schedule", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteFunctionsSecretsBySecretId"] = OperationDescriptor(method: "DELETE", path: "/functions/secrets/{secretId}", pathParameters: ["secretId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteFunctionsTriggersByTriggerId"] = OperationDescriptor(method: "DELETE", path: "/functions/triggers/{triggerId}", pathParameters: ["triggerId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteGeneratedByTableBulk"] = OperationDescriptor(method: "DELETE", path: "/generated/{table}/bulk", pathParameters: ["table"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteGeneratedByTableById"] = OperationDescriptor(method: "DELETE", path: "/generated/{table}/{id}", pathParameters: ["table", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteIntegrationsSubscriptionsById"] = OperationDescriptor(method: "DELETE", path: "/integrations/subscriptions/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteMcpConnectionsById"] = OperationDescriptor(method: "DELETE", path: "/mcp/connections/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteMongodbByCollectionIndexesByIndexName"] = OperationDescriptor(method: "DELETE", path: "/mongodb/{collection}/indexes/{indexName}", pathParameters: ["collection", "indexName"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteMongodbCollectionsByName"] = OperationDescriptor(method: "DELETE", path: "/mongodb/collections/{name}", pathParameters: ["name"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteOauthOrgByOrgIdProviderByProvider"] = OperationDescriptor(method: "DELETE", path: "/oauth/org/{orgId}/provider/{provider}", pathParameters: ["orgId", "provider"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteOrgsByOrgIdInvitesByInviteId"] = OperationDescriptor(method: "DELETE", path: "/orgs/{orgId}/invites/{inviteId}", pathParameters: ["orgId", "inviteId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteOrgsByOrgIdLeaveRequestsMine"] = OperationDescriptor(method: "DELETE", path: "/orgs/{orgId}/leave-requests/mine", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteOrgsByOrgIdMembersByUserId"] = OperationDescriptor(method: "DELETE", path: "/orgs/{orgId}/members/{userId}", pathParameters: ["orgId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteOrgsByOrgIdTransfersById"] = OperationDescriptor(method: "DELETE", path: "/orgs/{orgId}/transfers/{id}", pathParameters: ["orgId", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdAuthOauthAppsByProvider"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/auth/oauth-apps/{provider}", pathParameters: ["projectId", "provider"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdAuthSessions"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/auth/sessions", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdAuthSessionsById"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/auth/sessions/{id}", pathParameters: ["projectId", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdBranchesByBranchName"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/branches/{branchName}", pathParameters: ["projectId", "branchName"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdDatabaseDedicated"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/database/dedicated", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdEnvVarsByEnvVarId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/env-vars/{envVarId}", pathParameters: ["projectId", "envVarId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdEnvironmentsByEnvId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/environments/{envId}", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/environments/{envId}/domains/{domainId}", pathParameters: ["projectId", "envId", "domainId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdGithubDisconnect"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/github/disconnect", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdInfrastructureByInstanceId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/infrastructure/{instanceId}", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdMembersByUserId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/members/{userId}", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdUsersByUserId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/users/{userId}", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteProjectsByProjectIdUsersByUserIdSessionsBySessionId"] = OperationDescriptor(method: "DELETE", path: "/projects/{projectId}/users/{userId}/sessions/{sessionId}", pathParameters: ["projectId", "userId", "sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteRlsPoliciesByPolicyId"] = OperationDescriptor(method: "DELETE", path: "/rls/policies/{policyId}", pathParameters: ["policyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSchemaEngineSnippetsByProjectIdBySnippetId"] = OperationDescriptor(method: "DELETE", path: "/schema-engine/snippets/{projectId}/{snippetId}", pathParameters: ["projectId", "snippetId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteServicesByServiceId"] = OperationDescriptor(method: "DELETE", path: "/services/{serviceId}", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteServicesByServiceIdDomainsByDomainId"] = OperationDescriptor(method: "DELETE", path: "/services/{serviceId}/domains/{domainId}", pathParameters: ["serviceId", "domainId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteServicesByServiceIdGitConnect"] = OperationDescriptor(method: "DELETE", path: "/services/{serviceId}/git/connect", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdConnectionsByConnectionId"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/connections/{connectionId}", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertId"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/connections/{connectionId}/certificates/{certId}", pathParameters: ["orgId", "connectionId", "certId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdConnectionsByConnectionIdIdentitiesByUserId"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/connections/{connectionId}/identities/{userId}", pathParameters: ["orgId", "connectionId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdConnectionsByConnectionIdScimTokensByTokenId"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/connections/{connectionId}/scim/tokens/{tokenId}", pathParameters: ["orgId", "connectionId", "tokenId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdOutsideMembersAllowByAllowId"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/outside-members/allow/{allowId}", pathParameters: ["orgId", "allowId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteSsoOrgByOrgIdSecurityContact"] = OperationDescriptor(method: "DELETE", path: "/sso/org/{orgId}/security-contact", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteStorageBucketsByBucketIdPoliciesByPolicyId"] = OperationDescriptor(method: "DELETE", path: "/storage/buckets/{bucketId}/policies/{policyId}", pathParameters: ["bucketId", "policyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteTemplatesById"] = OperationDescriptor(method: "DELETE", path: "/templates/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteV1DataByProjectIdByTableBulk"] = OperationDescriptor(method: "DELETE", path: "/v1/data/{projectId}/{table}/bulk", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["deleteV1DataByProjectIdByTableById"] = OperationDescriptor(method: "DELETE", path: "/v1/data/{projectId}/{table}/{id}", pathParameters: ["projectId", "table", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["get"] = OperationDescriptor(method: "GET", path: "/", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getActivationOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/activation/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotAutocomplete"] = OperationDescriptor(method: "GET", path: "/ai/copilot/autocomplete", pathParameters: [], requiredQuery: ["projectId"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotContextSummaryByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/context-summary/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotCreditStatusByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/credit-status/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotDeployByDeployId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/deploy/{deployId}", pathParameters: ["deployId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotDeployHistoryByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/deploy/history/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotExecutionByExecutionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/execution/{executionId}", pathParameters: ["executionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotExecutionsBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/executions/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotGitBranchesBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/git/branches/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotGitFilesBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/git/files/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotGitLogBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/git/log/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotGitStatusBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/git/status/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotJobByJobId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/job/{jobId}", pathParameters: ["jobId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotManifestByManifestId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/manifest/{manifestId}", pathParameters: ["manifestId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotMetricsByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/metrics/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotMetricsOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/metrics/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotModelsByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/models/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/session/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionBySessionIdEditorFiles"] = OperationDescriptor(method: "GET", path: "/ai/copilot/session/{sessionId}/editor-files", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionBySessionIdWorkspaceExport"] = OperationDescriptor(method: "GET", path: "/ai/copilot/session/{sessionId}/workspace/export", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionBySessionIdWorkspaceStatus"] = OperationDescriptor(method: "GET", path: "/ai/copilot/session/{sessionId}/workspace/status", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionBySessionIdWorkspaceTypes"] = OperationDescriptor(method: "GET", path: "/ai/copilot/session/{sessionId}/workspace/types", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotSessionsByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/sessions/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotStats"] = OperationDescriptor(method: "GET", path: "/ai/copilot/stats", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotUsageByProjectId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/usage/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotUsageOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/usage-org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotVersionByVersionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/version/{versionId}", pathParameters: ["versionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotVersionByVersionIdDiffByCompareVersionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/version/{versionId}/diff/{compareVersionId}", pathParameters: ["versionId", "compareVersionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiCopilotVersionsBySessionId"] = OperationDescriptor(method: "GET", path: "/ai/copilot/versions/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdBreakdown"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/breakdown", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdExhaustionEvents"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/exhaustion-events", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdHistory"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/history", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdRecent"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/recent", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdRollups"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/rollups", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdSummary"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/summary", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAiUsageOrgByOrgIdVerament"] = OperationDescriptor(method: "GET", path: "/ai-usage/org/{orgId}/verament", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAlertRulesProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/alert-rules/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAnnouncements"] = OperationDescriptor(method: "GET", path: "/announcements", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuditOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/audit/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuditProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/audit/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthMe"] = OperationDescriptor(method: "GET", path: "/auth/me", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthMeAdmin"] = OperationDescriptor(method: "GET", path: "/auth/me/admin", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthMeContext"] = OperationDescriptor(method: "GET", path: "/auth/me/context", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthMeLinkedAccounts"] = OperationDescriptor(method: "GET", path: "/auth/me/linked-accounts", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthMfaStatus"] = OperationDescriptor(method: "GET", path: "/auth/mfa/status", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthOauthProviders"] = OperationDescriptor(method: "GET", path: "/auth/oauth/providers", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthSession"] = OperationDescriptor(method: "GET", path: "/auth/session", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthSessions"] = OperationDescriptor(method: "GET", path: "/auth/sessions", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getAuthTenantSession"] = OperationDescriptor(method: "GET", path: "/auth/tenant/session", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingAddonsCatalog"] = OperationDescriptor(method: "GET", path: "/billing/addons/catalog", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingCheckoutVerifyBySessionId"] = OperationDescriptor(method: "GET", path: "/billing/checkout/verify/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingCreditsPackages"] = OperationDescriptor(method: "GET", path: "/billing/credits/packages", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingCreditsRates"] = OperationDescriptor(method: "GET", path: "/billing/credits/rates", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingFoundersWall"] = OperationDescriptor(method: "GET", path: "/billing/founders/wall", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdAddons"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/addons", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdCardCheck"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/card-check", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdContacts"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/contacts", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdCostBreakdown"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/cost-breakdown", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdCreditsAutoTopup"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/credits/auto-topup", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdCreditsTransactions"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/credits/transactions", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdFounder"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/founder", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdHosting"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/hosting", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdInfrastructure"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/infrastructure", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdInvoices"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/invoices", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdOverages"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/overages", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdOveragesHistory"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/overages/history", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdSubscription"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/subscription", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdSummary"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/summary", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdTaxInfo"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/tax-info", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsage"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsageAlerts"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage-alerts", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsageAlertsConfigured"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage-alerts/configured", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsageAlertsHistory"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage-alerts/history", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsageHistory"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage/history", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingOrgByOrgIdUsageRealtime"] = OperationDescriptor(method: "GET", path: "/billing/org/{orgId}/usage/realtime", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBillingPlans"] = OperationDescriptor(method: "GET", path: "/billing/plans", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBootstrap"] = OperationDescriptor(method: "GET", path: "/bootstrap", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBucketsByBucketId"] = OperationDescriptor(method: "GET", path: "/buckets/{bucketId}", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBucketsByBucketIdFiles"] = OperationDescriptor(method: "GET", path: "/buckets/{bucketId}/files", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getBucketsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/buckets/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsCareers"] = OperationDescriptor(method: "GET", path: "/cms/careers", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsFaqsByPageSlug"] = OperationDescriptor(method: "GET", path: "/cms/faqs/{pageSlug}", pathParameters: ["pageSlug"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsPagesBySlug"] = OperationDescriptor(method: "GET", path: "/cms/pages/{slug}", pathParameters: ["slug"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsPartners"] = OperationDescriptor(method: "GET", path: "/cms/partners", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsTeam"] = OperationDescriptor(method: "GET", path: "/cms/team", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCmsTestimonials"] = OperationDescriptor(method: "GET", path: "/cms/testimonials", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCreditsOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/credits/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getCreditsOrgByOrgIdBalance"] = OperationDescriptor(method: "GET", path: "/credits/org/{orgId}/balance", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseConnectorByProjectIdTables"] = OperationDescriptor(method: "GET", path: "/database/connector/{projectId}/tables", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseExtensionsAvailable"] = OperationDescriptor(method: "GET", path: "/database/extensions/available", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseExtensionsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/database/extensions/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseTiers"] = OperationDescriptor(method: "GET", path: "/database/tiers", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseWrappersAvailable"] = OperationDescriptor(method: "GET", path: "/database/wrappers/available", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDatabaseWrappersProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/database/wrappers/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDeploymentsByDeploymentId"] = OperationDescriptor(method: "GET", path: "/deployments/{deploymentId}", pathParameters: ["deploymentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDeploymentsByDeploymentIdSteps"] = OperationDescriptor(method: "GET", path: "/deployments/{deploymentId}/steps", pathParameters: ["deploymentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDeploymentsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/deployments/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDeploymentsProjectByProjectIdStats"] = OperationDescriptor(method: "GET", path: "/deployments/project/{projectId}/stats", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDeploymentsTokensProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/deployments/tokens/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsAiSearch"] = OperationDescriptor(method: "GET", path: "/docs/ai-search", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsApiEndpoints"] = OperationDescriptor(method: "GET", path: "/docs/api-endpoints", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsApiEndpointsById"] = OperationDescriptor(method: "GET", path: "/docs/api-endpoints/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsCategories"] = OperationDescriptor(method: "GET", path: "/docs/categories", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsChangelog"] = OperationDescriptor(method: "GET", path: "/docs/changelog", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsChangelogById"] = OperationDescriptor(method: "GET", path: "/docs/changelog/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsExamples"] = OperationDescriptor(method: "GET", path: "/docs/examples", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsExamplesBySlug"] = OperationDescriptor(method: "GET", path: "/docs/examples/{slug}", pathParameters: ["slug"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsProjectByProjectIdQuickstart"] = OperationDescriptor(method: "GET", path: "/docs/project/{projectId}/quickstart", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsSdks"] = OperationDescriptor(method: "GET", path: "/docs/sdks", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsSdksByPlatform"] = OperationDescriptor(method: "GET", path: "/docs/sdks/{platform}", pathParameters: ["platform"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsSdksBySdkIdExamples"] = OperationDescriptor(method: "GET", path: "/docs/sdks/{sdkId}/examples", pathParameters: ["sdkId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsSearch"] = OperationDescriptor(method: "GET", path: "/docs/search", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsV2Pages"] = OperationDescriptor(method: "GET", path: "/docs/v2/pages", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getDocsV2PagesBySlug"] = OperationDescriptor(method: "GET", path: "/docs/v2/pages/{slug}", pathParameters: ["slug"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEarlyByNumber"] = OperationDescriptor(method: "GET", path: "/early/{number}", pathParameters: ["number"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEarlyWall"] = OperationDescriptor(method: "GET", path: "/early/wall", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdContract"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/contract", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdInvoices"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/invoices", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdOnboarding"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/onboarding", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdSpend"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/spend", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdUsage"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/usage", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdUsageHistory"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/usage/history", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseOrgByOrgIdUsageProjects"] = OperationDescriptor(method: "GET", path: "/enterprise/org/{orgId}/usage/projects", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterprisePricing"] = OperationDescriptor(method: "GET", path: "/enterprise/pricing", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEnterpriseQuotesByQuoteId"] = OperationDescriptor(method: "GET", path: "/enterprise/quotes/{quoteId}", pathParameters: ["quoteId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getEntitlementsOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/entitlements/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFlags"] = OperationDescriptor(method: "GET", path: "/flags", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionId"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdDeployStatus"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/deploy-status", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdInvocations"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/invocations", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdLogs"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/logs", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdMetrics"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/metrics", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdSchedule"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/schedule", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsByFunctionIdTriggers"] = OperationDescriptor(method: "GET", path: "/functions/{functionId}/triggers", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsInvocations"] = OperationDescriptor(method: "GET", path: "/functions/invocations", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsInvocationsFunctionByFunctionId"] = OperationDescriptor(method: "GET", path: "/functions/invocations/function/{functionId}", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/functions/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsProjectByProjectIdNameByFunctionName"] = OperationDescriptor(method: "GET", path: "/functions/project/{projectId}/name/{functionName}", pathParameters: ["projectId", "functionName"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsProjectByProjectIdSummary"] = OperationDescriptor(method: "GET", path: "/functions/project/{projectId}/summary", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsSchedulePreview"] = OperationDescriptor(method: "GET", path: "/functions/schedule/preview", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getFunctionsSecretsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/functions/secrets/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getGeneratedByTable"] = OperationDescriptor(method: "GET", path: "/generated/{table}", pathParameters: ["table"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getGeneratedByTableAggregate"] = OperationDescriptor(method: "GET", path: "/generated/{table}/aggregate", pathParameters: ["table"], requiredQuery: ["fn"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getGeneratedByTableById"] = OperationDescriptor(method: "GET", path: "/generated/{table}/{id}", pathParameters: ["table", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getGeneratedByTableSearch"] = OperationDescriptor(method: "GET", path: "/generated/{table}/search", pathParameters: ["table"], requiredQuery: ["q"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getGithubOauthAuthorize"] = OperationDescriptor(method: "GET", path: "/github/oauth/authorize", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIncidentsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/incidents/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getInfrastructureSizes"] = OperationDescriptor(method: "GET", path: "/infrastructure/sizes", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsAnalyticsProjectByProjectIdEvents"] = OperationDescriptor(method: "GET", path: "/integrations/analytics/project/{projectId}/events", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsAnalyticsProjectByProjectIdStats"] = OperationDescriptor(method: "GET", path: "/integrations/analytics/project/{projectId}/stats", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsDeliveriesEventByEventId"] = OperationDescriptor(method: "GET", path: "/integrations/deliveries/event/{eventId}", pathParameters: ["eventId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsDeliveriesProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/integrations/deliveries/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsDeliveriesProjectByProjectIdSummary"] = OperationDescriptor(method: "GET", path: "/integrations/deliveries/project/{projectId}/summary", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsDeliveriesSubscriptionBySubscriptionId"] = OperationDescriptor(method: "GET", path: "/integrations/deliveries/subscription/{subscriptionId}", pathParameters: ["subscriptionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsDlqProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/integrations/dlq/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsEvents"] = OperationDescriptor(method: "GET", path: "/integrations/events", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getIntegrationsSubscriptionsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/integrations/subscriptions/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getJobsDlqProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/jobs/dlq/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getJobsWebhooksDeliveryByDeliveryId"] = OperationDescriptor(method: "GET", path: "/jobs/webhooks/delivery/{deliveryId}", pathParameters: ["deliveryId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getJobsWebhooksProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/jobs/webhooks/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getLogsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/logs/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getLogsProjectByProjectIdFeed"] = OperationDescriptor(method: "GET", path: "/logs/project/{projectId}/feed", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMaintenance"] = OperationDescriptor(method: "GET", path: "/maintenance", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMcpConnections"] = OperationDescriptor(method: "GET", path: "/mcp/connections", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMcpOauthRequestsByRequestId"] = OperationDescriptor(method: "GET", path: "/mcp/oauth/requests/{requestId}", pathParameters: ["requestId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMcpSession"] = OperationDescriptor(method: "GET", path: "/mcp/session", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMeBadges"] = OperationDescriptor(method: "GET", path: "/me/badges", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMeCreator"] = OperationDescriptor(method: "GET", path: "/me/creator", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMetricsOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/metrics/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMetricsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/metrics/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMetricsProjectByProjectIdOverview"] = OperationDescriptor(method: "GET", path: "/metrics/project/{projectId}/overview", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMetricsProjectByProjectIdReport"] = OperationDescriptor(method: "GET", path: "/metrics/project/{projectId}/report", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMongodbByCollectionEstimatedCount"] = OperationDescriptor(method: "GET", path: "/mongodb/{collection}/estimatedCount", pathParameters: ["collection"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMongodbByCollectionFindByIdById"] = OperationDescriptor(method: "GET", path: "/mongodb/{collection}/findById/{id}", pathParameters: ["collection", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMongodbByCollectionIndexes"] = OperationDescriptor(method: "GET", path: "/mongodb/{collection}/indexes", pathParameters: ["collection"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getMongodbCollections"] = OperationDescriptor(method: "GET", path: "/mongodb/collections", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOauthOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/oauth/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOauthOrgByOrgIdProviderByProviderAuthorize"] = OperationDescriptor(method: "GET", path: "/oauth/org/{orgId}/provider/{provider}/authorize", pathParameters: ["orgId", "provider"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOnboardingOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/onboarding/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOpenapiProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/openapi/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOpenapiYaml"] = OperationDescriptor(method: "GET", path: "/openapi.yaml", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgs"] = OperationDescriptor(method: "GET", path: "/orgs", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdAccessMatrix"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/access-matrix", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdBlueprintDefaults"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/blueprint-defaults", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdChangeRequests"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/change-requests", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdDataRegion"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/data-region", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdIdentitySummary"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/identity/summary", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdInvites"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/invites", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdLeaveRequests"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/leave-requests", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdLeaveRequestsMine"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/leave-requests/mine", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdManagedDomains"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/managed-domains", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdManagedSummary"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/managed-summary", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdMembers"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/members", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdMembership"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/membership", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdProfile"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/profile", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdRoles"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/roles", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSecurity"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/security", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSecurityPosture"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/security/posture", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSupportSlaReport"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/support/sla-report", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSupportSummary"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/support/summary", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSupportTerms"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/support/terms", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSupportTickets"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/support/tickets", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdSupportTicketsByNumber"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/support/tickets/{number}", pathParameters: ["orgId", "number"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsByOrgIdTransfers"] = OperationDescriptor(method: "GET", path: "/orgs/{orgId}/transfers", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsInvitesLookup"] = OperationDescriptor(method: "GET", path: "/orgs/invites/lookup", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getOrgsTransfersPreview"] = OperationDescriptor(method: "GET", path: "/orgs/transfers/preview", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPlansByPlanId"] = OperationDescriptor(method: "GET", path: "/plans/{planId}", pathParameters: ["planId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPlansOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/plans/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPricingAiFeatures"] = OperationDescriptor(method: "GET", path: "/pricing/ai-features", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPricingCompare"] = OperationDescriptor(method: "GET", path: "/pricing/compare", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPricingEnterprise"] = OperationDescriptor(method: "GET", path: "/pricing/enterprise", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPricingPlans"] = OperationDescriptor(method: "GET", path: "/pricing/plans", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getPricingPlansByPlan"] = OperationDescriptor(method: "GET", path: "/pricing/plans/{plan}", pathParameters: ["plan"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjects"] = OperationDescriptor(method: "GET", path: "/projects", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByIdInsights"] = OperationDescriptor(method: "GET", path: "/projects/{id}/insights", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectId"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdApiKeys"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/api-keys", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthActivity"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/activity", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthMe"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/me", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthOauthApps"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/oauth-apps", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthOauthProviders"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/oauth/providers", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthSessions"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/sessions", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdAuthSettings"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/auth/settings", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdBranches"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/branches", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdBranchesByBranchNameUrl"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/branches/{branchName}/url", pathParameters: ["projectId", "branchName"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdDatabaseDedicated"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/database/dedicated", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdDatabaseDedicatedConnection"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/database/dedicated/connection", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdDatabaseDedicatedStatus"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/database/dedicated/status", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdDeletionPreview"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/deletion-preview", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvVars"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/env-vars", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvironments"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/environments", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvironmentsByEnvIdDomainStatus"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/environments/{envId}/domain-status", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvironmentsByEnvIdDomainVerification"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/environments/{envId}/domain-verification", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvironmentsByEnvIdDomains"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/environments/{envId}/domains", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdEnvironmentsPromotionOrder"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/environments/promotion-order", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdFrontend"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/frontend", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdGettingStarted"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/getting-started", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdGithubBranches"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/github/branches", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdGithubRepos"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/github/repos", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdGithubStatus"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/github/status", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdGithubTrackedRepos"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/github/tracked-repos", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructure"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureByInstanceIdMetrics"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/{instanceId}/metrics", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureByInstanceIdReplicas"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/{instanceId}/replicas", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureByInstanceIdUpgradeOptions"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/{instanceId}/upgrade-options", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureMigrationProgress"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/migration/progress", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureMigrationStatus"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/migration-status", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdInfrastructureRestores"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/infrastructure/restores", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdMembers"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/members", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdPromotions"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/promotions", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdPromotionsDiff"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/promotions/diff", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdRegion"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/region", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSecurityAdvisor"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/security/advisor", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSettings"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/settings", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSettingsAddons"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/settings/addons", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSettingsApi"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/settings/api", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSettingsCompute"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/settings/compute", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdSettingsJwt"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/settings/jwt", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdStorageSettings"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/storage/settings", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdUsers"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/users", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdUsersByUserId"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/users/{userId}", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdUsersByUserIdSessions"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/users/{userId}/sessions", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsByProjectIdUsersStats"] = OperationDescriptor(method: "GET", path: "/projects/{projectId}/users/stats", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getProjectsSlugAvailable"] = OperationDescriptor(method: "GET", path: "/projects/slug-available", pathParameters: [], requiredQuery: ["orgId", "slug"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getQuickstartProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/quickstart/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getQuickstartProjectByProjectIdJson"] = OperationDescriptor(method: "GET", path: "/quickstart/project/{projectId}/json", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRealtimeConnectionsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/realtime/connections/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRealtimeEventsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/realtime/events/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRealtimeStatsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/realtime/stats/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRealtimeStatusProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/realtime/status/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRealtimeSubscriptionsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/realtime/subscriptions/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRefundsById"] = OperationDescriptor(method: "GET", path: "/refunds/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRefundsOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/refunds/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRegions"] = OperationDescriptor(method: "GET", path: "/regions", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRegionsAll"] = OperationDescriptor(method: "GET", path: "/regions/all", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRegionsByKey"] = OperationDescriptor(method: "GET", path: "/regions/{key}", pathParameters: ["key"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRegionsByKeyMetrics"] = OperationDescriptor(method: "GET", path: "/regions/{key}/metrics", pathParameters: ["key"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRegionsHealth"] = OperationDescriptor(method: "GET", path: "/regions/health", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getRlsPoliciesByProjectId"] = OperationDescriptor(method: "GET", path: "/rls/policies/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineByProjectIdChanges"] = OperationDescriptor(method: "GET", path: "/schema-engine/{projectId}/changes", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineEditorSessionsByProjectIdCapabilities"] = OperationDescriptor(method: "GET", path: "/schema-engine/editor-sessions/{projectId}/capabilities", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineIntrospectByProjectId"] = OperationDescriptor(method: "GET", path: "/schema-engine/introspect/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineMigrationsByProjectIdByMigrationIdDiff"] = OperationDescriptor(method: "GET", path: "/schema-engine/migrations/{projectId}/{migrationId}/diff", pathParameters: ["projectId", "migrationId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineMigrationsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/schema-engine/migrations/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineSnapshotsProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/schema-engine/snapshots/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemaEngineSnippetsByProjectId"] = OperationDescriptor(method: "GET", path: "/schema-engine/snippets/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSchemasProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/schemas/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSecurityAuditByProjectId"] = OperationDescriptor(method: "GET", path: "/security/audit/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSecurityOverviewByProjectId"] = OperationDescriptor(method: "GET", path: "/security/overview/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSecurityVariablesProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/security/variables/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceId"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdDeploymentsByDeploymentIdBuildLogs"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/deployments/{deploymentId}/build-logs", pathParameters: ["serviceId", "deploymentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdDeploymentsByDeploymentIdStatus"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/deployments/{deploymentId}/status", pathParameters: ["serviceId", "deploymentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdDomains"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/domains", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdGitConnect"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/git/connect", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdLogs"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/logs", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesByServiceIdStatus"] = OperationDescriptor(method: "GET", path: "/services/{serviceId}/status", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/services/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getServicesProjectByProjectIdSummary"] = OperationDescriptor(method: "GET", path: "/services/project/{projectId}/summary", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoMePausedAccess"] = OperationDescriptor(method: "GET", path: "/sso/me/paused-access", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgId"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/break-glass", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdCertificates"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/certificates", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/group-mappings", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdRequire"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/require", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdScimReconciliation"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/scim/reconciliation", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdConnectionsByConnectionIdScimTokens"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/connections/{connectionId}/scim/tokens", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdOutsideMembers"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/outside-members", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdOutsideMembersBlocked"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/outside-members/blocked", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getSsoOrgByOrgIdSecurityContact"] = OperationDescriptor(method: "GET", path: "/sso/org/{orgId}/security-contact", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatus"] = OperationDescriptor(method: "GET", path: "/status", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusAtom"] = OperationDescriptor(method: "GET", path: "/status/atom", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusIncidents"] = OperationDescriptor(method: "GET", path: "/status/incidents", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusRss"] = OperationDescriptor(method: "GET", path: "/status/rss", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusSubscribersCount"] = OperationDescriptor(method: "GET", path: "/status/subscribers/count", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusUnsubscribeByToken"] = OperationDescriptor(method: "GET", path: "/status/unsubscribe/{token}", pathParameters: ["token"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStatusUptimeByComponentId"] = OperationDescriptor(method: "GET", path: "/status/uptime/{componentId}", pathParameters: ["componentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStorageBuckets"] = OperationDescriptor(method: "GET", path: "/storage/buckets", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStorageBucketsByBucketIdPolicies"] = OperationDescriptor(method: "GET", path: "/storage/buckets/{bucketId}/policies", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStorageDownload"] = OperationDescriptor(method: "GET", path: "/storage/download", pathParameters: [], requiredQuery: ["key"], bodyKind: "none", bodyRequired: false, transport: "binary")
        ops["getStorageFilesByBucketIdMetadata"] = OperationDescriptor(method: "GET", path: "/storage/files/{bucketId}/metadata", pathParameters: ["bucketId"], requiredQuery: ["key"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStorageMultipartListPending"] = OperationDescriptor(method: "GET", path: "/storage/multipart/list-pending", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getStorageUsageProjectByProjectId"] = OperationDescriptor(method: "GET", path: "/storage/usage/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getTemplates"] = OperationDescriptor(method: "GET", path: "/templates", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getTemplatesBySlug"] = OperationDescriptor(method: "GET", path: "/templates/{slug}", pathParameters: ["slug"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getTemplatesInstalls"] = OperationDescriptor(method: "GET", path: "/templates/installs", pathParameters: [], requiredQuery: ["projectId"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getTenantBranding"] = OperationDescriptor(method: "GET", path: "/tenant/branding", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getUsersMe"] = OperationDescriptor(method: "GET", path: "/users/me", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getUsersMePreferences"] = OperationDescriptor(method: "GET", path: "/users/me/preferences", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1DataByProjectIdByTable"] = OperationDescriptor(method: "GET", path: "/v1/data/{projectId}/{table}", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1DataByProjectIdByTableAggregate"] = OperationDescriptor(method: "GET", path: "/v1/data/{projectId}/{table}/aggregate", pathParameters: ["projectId", "table"], requiredQuery: ["fn"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1DataByProjectIdByTableById"] = OperationDescriptor(method: "GET", path: "/v1/data/{projectId}/{table}/{id}", pathParameters: ["projectId", "table", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1DataByProjectIdByTableSearch"] = OperationDescriptor(method: "GET", path: "/v1/data/{projectId}/{table}/search", pathParameters: ["projectId", "table"], requiredQuery: ["q"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1Health"] = OperationDescriptor(method: "GET", path: "/v1/health", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getV1Project"] = OperationDescriptor(method: "GET", path: "/v1/project", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["getWellKnownOauthAuthorizationServer"] = OperationDescriptor(method: "GET", path: "/.well-known/oauth-authorization-server", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["patchAiCopilotSessionBySessionId"] = OperationDescriptor(method: "PATCH", path: "/ai/copilot/session/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchAuthMe"] = OperationDescriptor(method: "PATCH", path: "/auth/me", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchBillingOrgByOrgIdAddonsByAddonId"] = OperationDescriptor(method: "PATCH", path: "/billing/org/{orgId}/addons/{addonId}", pathParameters: ["orgId", "addonId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchBillingOrgByOrgIdContactsByContactId"] = OperationDescriptor(method: "PATCH", path: "/billing/org/{orgId}/contacts/{contactId}", pathParameters: ["orgId", "contactId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchBillingOrgByOrgIdUsageAlertsByAlertId"] = OperationDescriptor(method: "PATCH", path: "/billing/org/{orgId}/usage-alerts/{alertId}", pathParameters: ["orgId", "alertId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDatabaseWrappersProjectByProjectIdByWrapperId"] = OperationDescriptor(method: "PATCH", path: "/database/wrappers/project/{projectId}/{wrapperId}", pathParameters: ["projectId", "wrapperId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDocsApiEndpointsById"] = OperationDescriptor(method: "PATCH", path: "/docs/api-endpoints/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDocsChangelogById"] = OperationDescriptor(method: "PATCH", path: "/docs/changelog/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDocsExamplesById"] = OperationDescriptor(method: "PATCH", path: "/docs/examples/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDocsSdksById"] = OperationDescriptor(method: "PATCH", path: "/docs/sdks/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchDocsV2PagesById"] = OperationDescriptor(method: "PATCH", path: "/docs/v2/pages/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchEnterpriseOrgByOrgIdOnboarding"] = OperationDescriptor(method: "PATCH", path: "/enterprise/org/{orgId}/onboarding", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchFunctionsByFunctionId"] = OperationDescriptor(method: "PATCH", path: "/functions/{functionId}", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchFunctionsTriggersByTriggerId"] = OperationDescriptor(method: "PATCH", path: "/functions/triggers/{triggerId}", pathParameters: ["triggerId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchGeneratedByTableBulk"] = OperationDescriptor(method: "PATCH", path: "/generated/{table}/bulk", pathParameters: ["table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchGeneratedByTableById"] = OperationDescriptor(method: "PATCH", path: "/generated/{table}/{id}", pathParameters: ["table", "id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchIntegrationsSubscriptionsById"] = OperationDescriptor(method: "PATCH", path: "/integrations/subscriptions/{id}", pathParameters: ["id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOauthOrgByOrgIdProviderByProvider"] = OperationDescriptor(method: "PATCH", path: "/oauth/org/{orgId}/provider/{provider}", pathParameters: ["orgId", "provider"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgId"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgIdBlueprintDefaults"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/blueprint-defaults", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgIdDataRegion"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/data-region", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgIdMembersByUserIdRole"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/members/{userId}/role", pathParameters: ["orgId", "userId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgIdMembersRoles"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/members/roles", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchOrgsByOrgIdProfile"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/profile", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchOrgsByOrgIdSecurity"] = OperationDescriptor(method: "PATCH", path: "/orgs/{orgId}/security", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchProjectsByProjectId"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchProjectsByProjectIdApiKeysByKeyId"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/api-keys/{keyId}", pathParameters: ["projectId", "keyId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchProjectsByProjectIdAuthSettings"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/auth/settings", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchProjectsByProjectIdEnvVarsByEnvVarId"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/env-vars/{envVarId}", pathParameters: ["projectId", "envVarId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdEnvironmentsByEnvId"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/environments/{envId}", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdSettingsAddons"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/settings/addons", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdSettingsApi"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/settings/api", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdSettingsCompute"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/settings/compute", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdSettingsJwt"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/settings/jwt", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchProjectsByProjectIdStorageSettings"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/storage/settings", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchProjectsByProjectIdUsersByUserId"] = OperationDescriptor(method: "PATCH", path: "/projects/{projectId}/users/{userId}", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchRegionsByKey"] = OperationDescriptor(method: "PATCH", path: "/regions/{key}", pathParameters: ["key"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchRlsPoliciesByPolicyId"] = OperationDescriptor(method: "PATCH", path: "/rls/policies/{policyId}", pathParameters: ["policyId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchSchemaEngineSnippetsByProjectIdBySnippetId"] = OperationDescriptor(method: "PATCH", path: "/schema-engine/snippets/{projectId}/{snippetId}", pathParameters: ["projectId", "snippetId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchServicesByServiceIdHostname"] = OperationDescriptor(method: "PATCH", path: "/services/{serviceId}/hostname", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchServicesByServiceIdRuntimeClass"] = OperationDescriptor(method: "PATCH", path: "/services/{serviceId}/runtime-class", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchSsoOrgByOrgIdConnectionsByConnectionId"] = OperationDescriptor(method: "PATCH", path: "/sso/org/{orgId}/connections/{connectionId}", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchStorageFilesByBucketIdMetadata"] = OperationDescriptor(method: "PATCH", path: "/storage/files/{bucketId}/metadata", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchUsersMe"] = OperationDescriptor(method: "PATCH", path: "/users/me", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchUsersMePreferences"] = OperationDescriptor(method: "PATCH", path: "/users/me/preferences", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["patchV1DataByProjectIdByTableBulk"] = OperationDescriptor(method: "PATCH", path: "/v1/data/{projectId}/{table}/bulk", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["patchV1DataByProjectIdByTableById"] = OperationDescriptor(method: "PATCH", path: "/v1/data/{projectId}/{table}/{id}", pathParameters: ["projectId", "table", "id"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotAlertRuleSuggestion"] = OperationDescriptor(method: "POST", path: "/ai/copilot/alert-rule-suggestion", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotAlertRuleSuggestionEstimate"] = OperationDescriptor(method: "POST", path: "/ai/copilot/alert-rule-suggestion/estimate", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotChat"] = OperationDescriptor(method: "POST", path: "/ai/copilot/chat", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotChatStream"] = OperationDescriptor(method: "POST", path: "/ai/copilot/chat/stream", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "sse")
        ops["postAiCopilotExecute"] = OperationDescriptor(method: "POST", path: "/ai/copilot/execute", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotExecutionByExecutionIdPause"] = OperationDescriptor(method: "POST", path: "/ai/copilot/execution/{executionId}/pause", pathParameters: ["executionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotExecutionByExecutionIdResume"] = OperationDescriptor(method: "POST", path: "/ai/copilot/execution/{executionId}/resume", pathParameters: ["executionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotExecutionByExecutionIdRollback"] = OperationDescriptor(method: "POST", path: "/ai/copilot/execution/{executionId}/rollback", pathParameters: ["executionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotExportByVersionId"] = OperationDescriptor(method: "POST", path: "/ai/copilot/export/{versionId}", pathParameters: ["versionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotExportGithub"] = OperationDescriptor(method: "POST", path: "/ai/copilot/export/github", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotFeedback"] = OperationDescriptor(method: "POST", path: "/ai/copilot/feedback", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotGenerationByManifestIdCancel"] = OperationDescriptor(method: "POST", path: "/ai/copilot/generation/{manifestId}/cancel", pathParameters: ["manifestId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitBranch"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/branch", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitClone"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/clone", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitCommit"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/commit", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitInit"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/init", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitPull"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/pull", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitPush"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/push", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotGitWrite"] = OperationDescriptor(method: "POST", path: "/ai/copilot/git/write", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotJob"] = OperationDescriptor(method: "POST", path: "/ai/copilot/job", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotJobByJobIdCancel"] = OperationDescriptor(method: "POST", path: "/ai/copilot/job/{jobId}/cancel", pathParameters: ["jobId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotJobByJobIdRetry"] = OperationDescriptor(method: "POST", path: "/ai/copilot/job/{jobId}/retry", pathParameters: ["jobId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotManifestByManifestIdPause"] = OperationDescriptor(method: "POST", path: "/ai/copilot/manifest/{manifestId}/pause", pathParameters: ["manifestId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAiCopilotMemoriesByMemoryIdPromote"] = OperationDescriptor(method: "POST", path: "/ai/copilot/memories/{memoryId}/promote", pathParameters: ["memoryId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotRateByMessageId"] = OperationDescriptor(method: "POST", path: "/ai/copilot/rate/{messageId}", pathParameters: ["messageId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotSessionBySessionIdArtifactBody"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/artifact-body", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotSessionBySessionIdBrainstormStop"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/brainstorm/stop", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceEnv"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/env", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceFix"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/fix", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceHeartbeat"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/heartbeat", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceInstall"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/install", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspacePrepare"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/prepare", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceRelease"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/release", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceRepairsApply"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/repairs/apply", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceRestore"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/restore", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceRun"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/run", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessionBySessionIdWorkspaceStop"] = OperationDescriptor(method: "POST", path: "/ai/copilot/session/{sessionId}/workspace/stop", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAiCopilotSessions"] = OperationDescriptor(method: "POST", path: "/ai/copilot/sessions", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotTableFilters"] = OperationDescriptor(method: "POST", path: "/ai/copilot/table-filters", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotTableFiltersEstimate"] = OperationDescriptor(method: "POST", path: "/ai/copilot/table-filters/estimate", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAiCopilotTrainingConsentBySessionId"] = OperationDescriptor(method: "POST", path: "/ai/copilot/training-consent/{sessionId}", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAlertRulesProjectByProjectId"] = OperationDescriptor(method: "POST", path: "/alert-rules/project/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthAccountSetup"] = OperationDescriptor(method: "POST", path: "/auth/account-setup", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthAccountSetupCheck"] = OperationDescriptor(method: "POST", path: "/auth/account-setup/check", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthCliAuthorize"] = OperationDescriptor(method: "POST", path: "/auth/cli/authorize", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthCliCallback"] = OperationDescriptor(method: "POST", path: "/auth/cli/callback", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthCliDeny"] = OperationDescriptor(method: "POST", path: "/auth/cli/deny", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthCliLogin"] = OperationDescriptor(method: "POST", path: "/auth/cli/login", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthCliRequestsCheck"] = OperationDescriptor(method: "POST", path: "/auth/cli/requests/check", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthCliToken"] = OperationDescriptor(method: "POST", path: "/auth/cli/token", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthForgotPassword"] = OperationDescriptor(method: "POST", path: "/auth/forgot-password", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthLogin"] = OperationDescriptor(method: "POST", path: "/auth/login", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthLogout"] = OperationDescriptor(method: "POST", path: "/auth/logout", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthLogoutAll"] = OperationDescriptor(method: "POST", path: "/auth/logout-all", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthMeLinkedAccountsByProviderStart"] = OperationDescriptor(method: "POST", path: "/auth/me/linked-accounts/{provider}/start", pathParameters: ["provider"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthMfaDisable"] = OperationDescriptor(method: "POST", path: "/auth/mfa/disable", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthMfaEnrollConfirm"] = OperationDescriptor(method: "POST", path: "/auth/mfa/enroll-confirm", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthMfaEnrollStart"] = OperationDescriptor(method: "POST", path: "/auth/mfa/enroll-start", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthMfaRegenerateCodes"] = OperationDescriptor(method: "POST", path: "/auth/mfa/regenerate-codes", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthMfaVerify"] = OperationDescriptor(method: "POST", path: "/auth/mfa/verify", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postAuthReauthenticate"] = OperationDescriptor(method: "POST", path: "/auth/reauthenticate", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthRefresh"] = OperationDescriptor(method: "POST", path: "/auth/refresh", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthResetPassword"] = OperationDescriptor(method: "POST", path: "/auth/reset-password", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthResetPasswordCheck"] = OperationDescriptor(method: "POST", path: "/auth/reset-password/check", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthSessionDevice"] = OperationDescriptor(method: "POST", path: "/auth/session/device", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthSessionToken"] = OperationDescriptor(method: "POST", path: "/auth/session/token", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthSignup"] = OperationDescriptor(method: "POST", path: "/auth/signup", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthSsoRestart"] = OperationDescriptor(method: "POST", path: "/auth/sso/restart", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthTenantHandoff"] = OperationDescriptor(method: "POST", path: "/auth/tenant/handoff", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthTenantLogin"] = OperationDescriptor(method: "POST", path: "/auth/tenant/login", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthTenantLogout"] = OperationDescriptor(method: "POST", path: "/auth/tenant/logout", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthTenantMfaVerify"] = OperationDescriptor(method: "POST", path: "/auth/tenant/mfa/verify", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthTenantRefresh"] = OperationDescriptor(method: "POST", path: "/auth/tenant/refresh", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postAuthTenantSsoStart"] = OperationDescriptor(method: "POST", path: "/auth/tenant/sso/start", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthVerifyEmailConfirm"] = OperationDescriptor(method: "POST", path: "/auth/verify-email/confirm", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthVerifyEmailResend"] = OperationDescriptor(method: "POST", path: "/auth/verify-email/resend", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postAuthVerifyEmailSend"] = OperationDescriptor(method: "POST", path: "/auth/verify-email/send", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postBillingCheckout"] = OperationDescriptor(method: "POST", path: "/billing/checkout", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingEnterpriseInquiry"] = OperationDescriptor(method: "POST", path: "/billing/enterprise/inquiry", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingHostingCheckout"] = OperationDescriptor(method: "POST", path: "/billing/hosting/checkout", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdAddons"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/addons", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdAddonsByAddonIdPreview"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/addons/{addonId}/preview", pathParameters: ["orgId", "addonId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdAddonsPreview"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/addons/preview", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdCancel"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/cancel", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdCardCheckConfirm"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/card-check/confirm", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdCardCheckSession"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/card-check/session", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdChangePlan"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/change-plan", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdChangePlanPreview"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/change-plan/preview", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdContacts"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/contacts", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdCreditsPurchase"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/credits/purchase", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingOrgByOrgIdPause"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/pause", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdPortal"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/portal", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdReactivate"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/reactivate", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdResume"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/resume", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postBillingOrgByOrgIdUsageAlerts"] = OperationDescriptor(method: "POST", path: "/billing/org/{orgId}/usage-alerts", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingPromoCodesValidate"] = OperationDescriptor(method: "POST", path: "/billing/promo-codes/validate", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingRedeemPromo"] = OperationDescriptor(method: "POST", path: "/billing/redeem-promo", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postBillingWebhook"] = OperationDescriptor(method: "POST", path: "/billing/webhook", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postBucketsByBucketIdSignedUrl"] = OperationDescriptor(method: "POST", path: "/buckets/{bucketId}/signed-url", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postBucketsByBucketIdUpload"] = OperationDescriptor(method: "POST", path: "/buckets/{bucketId}/upload", pathParameters: ["bucketId"], requiredQuery: ["key"], bodyKind: "binary", bodyRequired: true, transport: "json")
        ops["postBucketsByBucketIdUploadUrl"] = OperationDescriptor(method: "POST", path: "/buckets/{bucketId}/upload-url", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postContact"] = OperationDescriptor(method: "POST", path: "/contact", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDatabaseConnectorByProjectIdQuery"] = OperationDescriptor(method: "POST", path: "/database/connector/{projectId}/query", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDatabaseConnectorByProjectIdTest"] = OperationDescriptor(method: "POST", path: "/database/connector/{projectId}/test", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDatabaseExtensionsProjectByProjectIdInstall"] = OperationDescriptor(method: "POST", path: "/database/extensions/project/{projectId}/install", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDatabaseWrappersProjectByProjectIdInstall"] = OperationDescriptor(method: "POST", path: "/database/wrappers/project/{projectId}/install", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDeploymentsByDeploymentIdRollback"] = OperationDescriptor(method: "POST", path: "/deployments/{deploymentId}/rollback", pathParameters: ["deploymentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postDeploymentsPromote"] = OperationDescriptor(method: "POST", path: "/deployments/promote", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDeploymentsTokens"] = OperationDescriptor(method: "POST", path: "/deployments/tokens", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDeploymentsTokensByTokenIdRevoke"] = OperationDescriptor(method: "POST", path: "/deployments/tokens/{tokenId}/revoke", pathParameters: ["tokenId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postDeploymentsTrigger"] = OperationDescriptor(method: "POST", path: "/deployments/trigger", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postDocsApiEndpoints"] = OperationDescriptor(method: "POST", path: "/docs/api-endpoints", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDocsChangelog"] = OperationDescriptor(method: "POST", path: "/docs/changelog", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDocsExamples"] = OperationDescriptor(method: "POST", path: "/docs/examples", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDocsFeedback"] = OperationDescriptor(method: "POST", path: "/docs/feedback", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postDocsSdkExamples"] = OperationDescriptor(method: "POST", path: "/docs/sdk-examples", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDocsSdks"] = OperationDescriptor(method: "POST", path: "/docs/sdks", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postDocsSearchClick"] = OperationDescriptor(method: "POST", path: "/docs/search-click", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postDocsV2Pages"] = OperationDescriptor(method: "POST", path: "/docs/v2/pages", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postEnterpriseContracts"] = OperationDescriptor(method: "POST", path: "/enterprise/contracts", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postEnterpriseContractsByContractIdInvoice"] = OperationDescriptor(method: "POST", path: "/enterprise/contracts/{contractId}/invoice", pathParameters: ["contractId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postEnterpriseInquire"] = OperationDescriptor(method: "POST", path: "/enterprise/inquire", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postEnterpriseInvoicesByInvoiceIdPaid"] = OperationDescriptor(method: "POST", path: "/enterprise/invoices/{invoiceId}/paid", pathParameters: ["invoiceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postEnterpriseInvoicesByInvoiceIdSend"] = OperationDescriptor(method: "POST", path: "/enterprise/invoices/{invoiceId}/send", pathParameters: ["invoiceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postEnterpriseQuotesByQuoteIdAccept"] = OperationDescriptor(method: "POST", path: "/enterprise/quotes/{quoteId}/accept", pathParameters: ["quoteId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postEntitlementsOrgByOrgIdCheck"] = OperationDescriptor(method: "POST", path: "/entitlements/org/{orgId}/check", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postFlags"] = OperationDescriptor(method: "POST", path: "/flags", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postFunctions"] = OperationDescriptor(method: "POST", path: "/functions", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postFunctionsByFunctionIdOrNameInvoke"] = OperationDescriptor(method: "POST", path: "/functions/{functionIdOrName}/invoke", pathParameters: ["functionIdOrName"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postFunctionsByFunctionIdTriggers"] = OperationDescriptor(method: "POST", path: "/functions/{functionId}/triggers", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postFunctionsSecrets"] = OperationDescriptor(method: "POST", path: "/functions/secrets", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postGeneratedByTable"] = OperationDescriptor(method: "POST", path: "/generated/{table}", pathParameters: ["table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postGeneratedByTableBulk"] = OperationDescriptor(method: "POST", path: "/generated/{table}/bulk", pathParameters: ["table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postGeneratedByTableQuery"] = OperationDescriptor(method: "POST", path: "/generated/{table}/query", pathParameters: ["table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postIncidents"] = OperationDescriptor(method: "POST", path: "/incidents", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postIncidentsBulk"] = OperationDescriptor(method: "POST", path: "/incidents/bulk", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postIncidentsByIncidentIdAck"] = OperationDescriptor(method: "POST", path: "/incidents/{incidentId}/ack", pathParameters: ["incidentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postIncidentsByIncidentIdResolve"] = OperationDescriptor(method: "POST", path: "/incidents/{incidentId}/resolve", pathParameters: ["incidentId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postInfrastructurePollStatus"] = OperationDescriptor(method: "POST", path: "/infrastructure/poll-status", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postIntegrationsDeliveriesByDeliveryIdRetry"] = OperationDescriptor(method: "POST", path: "/integrations/deliveries/{deliveryId}/retry", pathParameters: ["deliveryId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postIntegrationsSubscriptions"] = OperationDescriptor(method: "POST", path: "/integrations/subscriptions", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postIntegrationsSubscriptionsByIdTest"] = OperationDescriptor(method: "POST", path: "/integrations/subscriptions/{id}/test", pathParameters: ["id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postMcpAudit"] = OperationDescriptor(method: "POST", path: "/mcp/audit", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postMcpOauthRegister"] = OperationDescriptor(method: "POST", path: "/mcp/oauth/register", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postMcpOauthRequestsByRequestIdApprove"] = OperationDescriptor(method: "POST", path: "/mcp/oauth/requests/{requestId}/approve", pathParameters: ["requestId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postMcpOauthRequestsByRequestIdDeny"] = OperationDescriptor(method: "POST", path: "/mcp/oauth/requests/{requestId}/deny", pathParameters: ["requestId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postMcpOauthRevoke"] = OperationDescriptor(method: "POST", path: "/mcp/oauth/revoke", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postMcpOauthToken"] = OperationDescriptor(method: "POST", path: "/mcp/oauth/token", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postMeEarlyWelcomeSeen"] = OperationDescriptor(method: "POST", path: "/me/early/welcome-seen", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionAggregate"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/aggregate", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionAggregateCursor"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/aggregate/cursor", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionBulkWrite"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/bulkWrite", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionCount"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/count", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionCursorByCursorIdClose"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/cursor/{cursorId}/close", pathParameters: ["collection", "cursorId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionCursorByCursorIdNext"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/cursor/{cursorId}/next", pathParameters: ["collection", "cursorId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionDeleteMany"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/deleteMany", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionDeleteOne"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/deleteOne", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionDistinct"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/distinct", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFind"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/find", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFindCursor"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/find/cursor", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFindOne"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/findOne", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFindOneAndDelete"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/findOneAndDelete", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFindOneAndReplace"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/findOneAndReplace", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionFindOneAndUpdate"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/findOneAndUpdate", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionIndexes"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/indexes", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionInsertMany"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/insertMany", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionInsertOne"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/insertOne", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionReplaceOne"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/replaceOne", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionUpdateMany"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/updateMany", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbByCollectionUpdateOne"] = OperationDescriptor(method: "POST", path: "/mongodb/{collection}/updateOne", pathParameters: ["collection"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbCollections"] = OperationDescriptor(method: "POST", path: "/mongodb/collections", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbCollectionsByNameRename"] = OperationDescriptor(method: "POST", path: "/mongodb/collections/{name}/rename", pathParameters: ["name"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postMongodbCommand"] = OperationDescriptor(method: "POST", path: "/mongodb/command", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOauthCallback"] = OperationDescriptor(method: "POST", path: "/oauth/callback", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOauthOrgByOrgIdConfigure"] = OperationDescriptor(method: "POST", path: "/oauth/org/{orgId}/configure", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOauthOrgByOrgIdProviderByProviderRefresh"] = OperationDescriptor(method: "POST", path: "/oauth/org/{orgId}/provider/{provider}/refresh", pathParameters: ["orgId", "provider"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOnboardingOrgByOrgIdAutoSetup"] = OperationDescriptor(method: "POST", path: "/onboarding/org/{orgId}/auto-setup", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOnboardingOrgByOrgIdCompleteStep"] = OperationDescriptor(method: "POST", path: "/onboarding/org/{orgId}/complete-step", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgs"] = OperationDescriptor(method: "POST", path: "/orgs", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdChangeRequests"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/change-requests", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdInvitesByInviteIdResend"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/invites/{inviteId}/resend", pathParameters: ["orgId", "inviteId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdLeaveRequests"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/leave-requests", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOrgsByOrgIdLeaveRequestsByRequestIdApprove"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/leave-requests/{requestId}/approve", pathParameters: ["orgId", "requestId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOrgsByOrgIdLeaveRequestsByRequestIdDecline"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/leave-requests/{requestId}/decline", pathParameters: ["orgId", "requestId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOrgsByOrgIdMembersInvite"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/members/invite", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdSupportTickets"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/support/tickets", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOrgsByOrgIdSupportTicketsByNumberMessages"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/support/tickets/{number}/messages", pathParameters: ["orgId", "number"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postOrgsByOrgIdSupportTicketsByNumberReopen"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/support/tickets/{number}/reopen", pathParameters: ["orgId", "number"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdSupportTicketsByNumberResolve"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/support/tickets/{number}/resolve", pathParameters: ["orgId", "number"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdTransfer"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/transfer", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsByOrgIdTransfersByIdResend"] = OperationDescriptor(method: "POST", path: "/orgs/{orgId}/transfers/{id}/resend", pathParameters: ["orgId", "id"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOrgsFirst"] = OperationDescriptor(method: "POST", path: "/orgs/first", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postOrgsInvitesAccept"] = OperationDescriptor(method: "POST", path: "/orgs/invites/accept", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsInvitesDecline"] = OperationDescriptor(method: "POST", path: "/orgs/invites/decline", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsTransfersAccept"] = OperationDescriptor(method: "POST", path: "/orgs/transfers/accept", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postOrgsTransfersDecline"] = OperationDescriptor(method: "POST", path: "/orgs/transfers/decline", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postPlansApply"] = OperationDescriptor(method: "POST", path: "/plans/apply", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postPlansSave"] = OperationDescriptor(method: "POST", path: "/plans/save", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjects"] = OperationDescriptor(method: "POST", path: "/projects", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdApiKeys"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/api-keys", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdApiKeysByKeyIdReveal"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/api-keys/{keyId}/reveal", pathParameters: ["projectId", "keyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdApiKeysByKeyIdRevoke"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/api-keys/{keyId}/revoke", pathParameters: ["projectId", "keyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdApiKeysByKeyIdRotate"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/api-keys/{keyId}/rotate", pathParameters: ["projectId", "keyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdApiKeysSplit"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/api-keys/split", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdAuthForgotPassword"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/forgot-password", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthLogin"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/login", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthLogout"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/logout", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdAuthMagicSend"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/magic/send", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthMfaDisable"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/mfa/disable", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthMfaEnrollConfirm"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/mfa/enroll-confirm", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthMfaEnrollStart"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/mfa/enroll-start", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdAuthMfaRegenerateCodes"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/mfa/regenerate-codes", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthMfaVerify"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/mfa/verify", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthOauthByProviderStart"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/oauth/{provider}/start", pathParameters: ["projectId", "provider"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthOauthToken"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/oauth/token", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthRefresh"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/refresh", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdAuthResetPassword"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/reset-password", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthSignup"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/signup", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthSyncUsers"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/sync-users", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdAuthVerifyEmailConfirm"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/verify-email/confirm", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdAuthVerifyEmailSend"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/auth/verify-email/send", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdBranches"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/branches", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdDatabaseDedicated"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/database/dedicated", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdDatabaseDedicatedRestart"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/database/dedicated/restart", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdDbReset"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/db/reset", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdEnvVars"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/env-vars", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdEnvironments"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsBackfillUrls"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/backfill-urls", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsBootstrap"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/bootstrap", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainIdVerify"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/{envId}/domains/{domainId}/verify", pathParameters: ["projectId", "envId", "domainId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsByEnvIdProvisionSsl"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/{envId}/provision-ssl", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsByEnvIdVerifyCname"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/{envId}/verify-cname", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdEnvironmentsByEnvIdVerifyDomain"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/environments/{envId}/verify-domain", pathParameters: ["projectId", "envId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdGithubBranch"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/github/branch", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdGithubConnect"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/github/connect", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdGithubPull"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/github/pull", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdGithubPush"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/github/push", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdMigrateNow"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/migrate-now", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdReplica"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/replica", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdReplicaPreview"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/replica-preview", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdResize"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/resize", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdResizeCustom"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/resize-custom", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdStart"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/start", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdStop"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/stop", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureByInstanceIdSwitch"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/{instanceId}/switch", pathParameters: ["projectId", "instanceId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureIncludedRetry"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/included/retry", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureMigrationRetry"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/migration/retry", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureMigrationRollback"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/migration/rollback", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureProvision"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/provision", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureProvisionCustom"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/provision-custom", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureProvisionPreview"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/provision-preview", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdInfrastructureRestoresPreview"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/infrastructure/restores/preview", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdMembers"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/members", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdPromotions"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/promotions", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdRegion"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/region", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdSettingsJwtRotate"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/settings/jwt/rotate", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdUsers"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/users", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdUsersByUserIdBan"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/users/{userId}/ban", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postProjectsByProjectIdUsersByUserIdSendMagicLink"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/users/{userId}/send-magic-link", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdUsersByUserIdSessionsRevokeAll"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/users/{userId}/sessions/revoke-all", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postProjectsByProjectIdUsersByUserIdUnban"] = OperationDescriptor(method: "POST", path: "/projects/{projectId}/users/{userId}/unban", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postRealtimeConsoleToken"] = OperationDescriptor(method: "POST", path: "/realtime/console-token", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postRealtimeEnableAll"] = OperationDescriptor(method: "POST", path: "/realtime/enable-all", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postRealtimeInstall"] = OperationDescriptor(method: "POST", path: "/realtime/install", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postRealtimeToken"] = OperationDescriptor(method: "POST", path: "/realtime/token", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postRealtimeUninstall"] = OperationDescriptor(method: "POST", path: "/realtime/uninstall", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postRegions"] = OperationDescriptor(method: "POST", path: "/regions", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postRegionsHealthCheck"] = OperationDescriptor(method: "POST", path: "/regions/health/check", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postRlsPoliciesByPolicyIdToggle"] = OperationDescriptor(method: "POST", path: "/rls/policies/{policyId}/toggle", pathParameters: ["policyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postRlsPoliciesByProjectId"] = OperationDescriptor(method: "POST", path: "/rls/policies/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSchemaEngineAnalyzeByProjectId"] = OperationDescriptor(method: "POST", path: "/schema-engine/analyze/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEngineApply"] = OperationDescriptor(method: "POST", path: "/schema-engine/apply", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEngineEditorSessionsByProjectId"] = OperationDescriptor(method: "POST", path: "/schema-engine/editor-sessions/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSchemaEngineEditorSessionsByProjectIdClose"] = OperationDescriptor(method: "POST", path: "/schema-engine/editor-sessions/{projectId}/close", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEngineMigrationsByProjectIdByMigrationIdRollback"] = OperationDescriptor(method: "POST", path: "/schema-engine/migrations/{projectId}/{migrationId}/rollback", pathParameters: ["projectId", "migrationId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSchemaEnginePreview"] = OperationDescriptor(method: "POST", path: "/schema-engine/preview", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEnginePushByProjectId"] = OperationDescriptor(method: "POST", path: "/schema-engine/push/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEngineQueryByProjectId"] = OperationDescriptor(method: "POST", path: "/schema-engine/query/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemaEngineSnippetsByProjectId"] = OperationDescriptor(method: "POST", path: "/schema-engine/snippets/{projectId}", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postSchemas"] = OperationDescriptor(method: "POST", path: "/schemas", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServices"] = OperationDescriptor(method: "POST", path: "/services", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServicesByServiceIdDeploy"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/deploy", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postServicesByServiceIdDomains"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/domains", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServicesByServiceIdDomainsByDomainIdVerify"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/domains/{domainId}/verify", pathParameters: ["serviceId", "domainId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postServicesByServiceIdGitConnect"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/git/connect", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServicesByServiceIdPromote"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/promote", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServicesByServiceIdRollback"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/rollback", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postServicesByServiceIdStop"] = OperationDescriptor(method: "POST", path: "/services/{serviceId}/stop", pathParameters: ["serviceId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConfigure"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/configure", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdCertificates"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/certificates", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertIdPromote"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/certificates/{certId}/promote", pathParameters: ["orgId", "connectionId", "certId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdDisable"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/disable", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdEnable"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/enable", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdMetadataImport"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/metadata/import", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdReleaseAccount"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/release-account", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdScimTokens"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/scim/tokens", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdTest"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/test", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdConnectionsByConnectionIdVerifyDomain"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/connections/{connectionId}/verify-domain", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postSsoOrgByOrgIdOutsideMembersBlockedByUserIdRestore"] = OperationDescriptor(method: "POST", path: "/sso/org/{orgId}/outside-members/blocked/{userId}/restore", pathParameters: ["orgId", "userId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postStatusSubscribe"] = OperationDescriptor(method: "POST", path: "/status/subscribe", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageBuckets"] = OperationDescriptor(method: "POST", path: "/storage/buckets", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageBucketsByBucketIdPolicies"] = OperationDescriptor(method: "POST", path: "/storage/buckets/{bucketId}/policies", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageBucketsByBucketIdPoliciesByPolicyIdToggle"] = OperationDescriptor(method: "POST", path: "/storage/buckets/{bucketId}/policies/{policyId}/toggle", pathParameters: ["bucketId", "policyId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postStorageBucketsByBucketIdPoliciesSimulate"] = OperationDescriptor(method: "POST", path: "/storage/buckets/{bucketId}/policies/simulate", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageDownloadUrl"] = OperationDescriptor(method: "POST", path: "/storage/download-url", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageFilesCopy"] = OperationDescriptor(method: "POST", path: "/storage/files/copy", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageFilesDeleteBatch"] = OperationDescriptor(method: "POST", path: "/storage/files/delete-batch", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageFilesMove"] = OperationDescriptor(method: "POST", path: "/storage/files/move", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageMultipartByUploadIdAbort"] = OperationDescriptor(method: "POST", path: "/storage/multipart/{uploadId}/abort", pathParameters: ["uploadId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageMultipartByUploadIdComplete"] = OperationDescriptor(method: "POST", path: "/storage/multipart/{uploadId}/complete", pathParameters: ["uploadId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageMultipartByUploadIdPartUrl"] = OperationDescriptor(method: "POST", path: "/storage/multipart/{uploadId}/part-url", pathParameters: ["uploadId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageMultipartCreate"] = OperationDescriptor(method: "POST", path: "/storage/multipart/create", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageMultipartResume"] = OperationDescriptor(method: "POST", path: "/storage/multipart/resume", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageUpload"] = OperationDescriptor(method: "POST", path: "/storage/upload", pathParameters: [], requiredQuery: ["key"], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postStorageUploadBase64"] = OperationDescriptor(method: "POST", path: "/storage/upload-base64", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postStorageUploadFromUrl"] = OperationDescriptor(method: "POST", path: "/storage/upload-from-url", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postStorageUploadUrl"] = OperationDescriptor(method: "POST", path: "/storage/upload-url", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postTemplates"] = OperationDescriptor(method: "POST", path: "/templates", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postTemplatesCreateProject"] = OperationDescriptor(method: "POST", path: "/templates/create-project", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postTemplatesFromProject"] = OperationDescriptor(method: "POST", path: "/templates/from-project", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postTemplatesFromProjectPreview"] = OperationDescriptor(method: "POST", path: "/templates/from-project/preview", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postTemplatesInstallApply"] = OperationDescriptor(method: "POST", path: "/templates/install/apply", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postTemplatesInstallByInstallIdRollback"] = OperationDescriptor(method: "POST", path: "/templates/install/{installId}/rollback", pathParameters: ["installId"], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postTemplatesInstallPreview"] = OperationDescriptor(method: "POST", path: "/templates/install/preview", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postUsersMeChangePassword"] = OperationDescriptor(method: "POST", path: "/users/me/change-password", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["postUsersMeRequestAccountDelete"] = OperationDescriptor(method: "POST", path: "/users/me/request-account-delete", pathParameters: [], requiredQuery: [], bodyKind: "none", bodyRequired: false, transport: "json")
        ops["postV1DataByProjectIdByTable"] = OperationDescriptor(method: "POST", path: "/v1/data/{projectId}/{table}", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postV1DataByProjectIdByTableBulk"] = OperationDescriptor(method: "POST", path: "/v1/data/{projectId}/{table}/bulk", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postV1DataByProjectIdByTableQuery"] = OperationDescriptor(method: "POST", path: "/v1/data/{projectId}/{table}/query", pathParameters: ["projectId", "table"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["postWebhooksGithub"] = OperationDescriptor(method: "POST", path: "/webhooks/github", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putAiCopilotSessionBySessionIdEditorFiles"] = OperationDescriptor(method: "PUT", path: "/ai/copilot/session/{sessionId}/editor-files", pathParameters: ["sessionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putAlertRulesByRuleId"] = OperationDescriptor(method: "PUT", path: "/alert-rules/{ruleId}", pathParameters: ["ruleId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putBillingOrgByOrgIdCreditsAutoTopup"] = OperationDescriptor(method: "PUT", path: "/billing/org/{orgId}/credits/auto-topup", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putBillingOrgByOrgIdFounderWall"] = OperationDescriptor(method: "PUT", path: "/billing/org/{orgId}/founder/wall", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putBillingOrgByOrgIdTaxInfo"] = OperationDescriptor(method: "PUT", path: "/billing/org/{orgId}/tax-info", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putBucketsByBucketId"] = OperationDescriptor(method: "PUT", path: "/buckets/{bucketId}", pathParameters: ["bucketId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putFlagsByKey"] = OperationDescriptor(method: "PUT", path: "/flags/{key}", pathParameters: ["key"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putFunctionsByFunctionIdSchedule"] = OperationDescriptor(method: "PUT", path: "/functions/{functionId}/schedule", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putFunctionsByFunctionIdSource"] = OperationDescriptor(method: "PUT", path: "/functions/{functionId}/source", pathParameters: ["functionId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putFunctionsSecretsBySecretId"] = OperationDescriptor(method: "PUT", path: "/functions/secrets/{secretId}", pathParameters: ["secretId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putMeConsoleLook"] = OperationDescriptor(method: "PUT", path: "/me/console-look", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putMeEarlyWall"] = OperationDescriptor(method: "PUT", path: "/me/early/wall", pathParameters: [], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putProjectsByProjectIdAuthOauthAppsByProvider"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/auth/oauth-apps/{provider}", pathParameters: ["projectId", "provider"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putProjectsByProjectIdEnvironmentsPromotionOrder"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/environments/promotion-order", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putProjectsByProjectIdFrontend"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/frontend", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putProjectsByProjectIdGettingStartedHidden"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/getting-started/hidden", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putProjectsByProjectIdMembers"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/members", pathParameters: ["projectId"], requiredQuery: [], bodyKind: "json", bodyRequired: true, transport: "json")
        ops["putProjectsByProjectIdMembersByUserId"] = OperationDescriptor(method: "PUT", path: "/projects/{projectId}/members/{userId}", pathParameters: ["projectId", "userId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/connections/{connectionId}/break-glass", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/connections/{connectionId}/group-mappings", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdConnectionsByConnectionIdRequire"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/connections/{connectionId}/require", pathParameters: ["orgId", "connectionId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdOutsideMembersAllow"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/outside-members/allow", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdOutsideMembersPolicy"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/outside-members/policy", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putSsoOrgByOrgIdSecurityContact"] = OperationDescriptor(method: "PUT", path: "/sso/org/{orgId}/security-contact", pathParameters: ["orgId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        ops["putStorageBucketsByBucketIdPoliciesByPolicyId"] = OperationDescriptor(method: "PUT", path: "/storage/buckets/{bucketId}/policies/{policyId}", pathParameters: ["bucketId", "policyId"], requiredQuery: [], bodyKind: "json", bodyRequired: false, transport: "json")
        return ops
    }()

    /// Operations with no generated method, and why.
    public static let ungenerated: [String: String] = [
        "GET /admin/admins": "platform staff only",
        "POST /admin/admins": "platform staff only",
        "DELETE /admin/admins/{id}": "platform staff only",
        "PUT /admin/admins/{id}": "platform staff only",
        "GET /admin/ai-workspace/overview": "platform staff only",
        "GET /admin/ai-workspace/sessions": "platform staff only",
        "DELETE /admin/ai-workspace/sessions/{sessionId}": "platform staff only",
        "GET /admin/ai-workspace/sessions/{sessionId}": "platform staff only",
        "GET /admin/ai/backends": "platform staff only",
        "DELETE /admin/ai/backends/{backendId}": "platform staff only",
        "GET /admin/ai/backends/{backendId}": "platform staff only",
        "GET /admin/ai/context-snapshots": "platform staff only",
        "DELETE /admin/ai/context-snapshots/{snapshotId}": "platform staff only",
        "POST /admin/ai/context-snapshots/{snapshotId}/invalidate": "platform staff only",
        "GET /admin/ai/models": "platform staff only",
        "POST /admin/ai/models": "platform staff only",
        "DELETE /admin/ai/models/{modelId}": "platform staff only",
        "GET /admin/ai/models/{modelId}": "platform staff only",
        "PATCH /admin/ai/models/{modelId}": "platform staff only",
        "POST /admin/ai/models/{modelId}/toggle": "platform staff only",
        "GET /admin/ai/prompt-templates": "platform staff only",
        "POST /admin/ai/prompt-templates": "platform staff only",
        "DELETE /admin/ai/prompt-templates/{templateId}": "platform staff only",
        "PATCH /admin/ai/prompt-templates/{templateId}": "platform staff only",
        "GET /admin/ai/workspace/sessions": "platform staff only",
        "DELETE /admin/ai/workspace/sessions/{sessionId}": "platform staff only",
        "GET /admin/ai/workspace/sessions/{sessionId}": "platform staff only",
        "GET /admin/copilot/classification-feedback": "platform staff only",
        "GET /admin/copilot/memories": "platform staff only",
        "DELETE /admin/copilot/memories/{memoryId}": "platform staff only",
        "GET /admin/copilot/memories/{memoryId}": "platform staff only",
        "PATCH /admin/copilot/memories/{memoryId}": "platform staff only",
        "POST /admin/copilot/memories/cleanup": "platform staff only",
        "GET /admin/copilot/memories/stats": "platform staff only",
        "GET /admin/copilot/overview": "platform staff only",
        "GET /admin/copilot/sessions": "platform staff only",
        "DELETE /admin/copilot/sessions/{sessionId}": "platform staff only",
        "GET /admin/copilot/sessions/{sessionId}": "platform staff only",
        "GET /admin/copilot/training-data/export": "platform staff only",
        "GET /admin/copilot/training-data/stats": "platform staff only",
        "GET /admin/dlq": "platform staff only",
        "DELETE /admin/dlq/{messageId}": "platform staff only",
        "POST /admin/dlq/{messageId}/retry": "platform staff only",
        "GET /admin/enterprise/contracts/{contractId}/billing-schedule": "platform staff only",
        "GET /admin/enterprise/contracts/{contractId}/invoices": "platform staff only",
        "GET /admin/enterprise/contracts/{contractId}/support-terms": "platform staff only",
        "PUT /admin/enterprise/contracts/{contractId}/support-terms": "platform staff only",
        "PATCH /admin/enterprise/contracts/{id}/commitment": "platform staff only",
        "PATCH /admin/enterprise/inquiries/{inquiryId}": "platform staff only",
        "POST /admin/enterprise/invoice-runs": "platform staff only",
        "GET /admin/enterprise/orgs/{orgId}/account": "platform staff only",
        "POST /admin/enterprise/orgs/{orgId}/tenant/welcome": "platform staff only",
        "DELETE /admin/errors": "platform staff only",
        "GET /admin/errors": "platform staff only",
        "DELETE /admin/errors/{errorId}": "platform staff only",
        "GET /admin/errors/{errorId}": "platform staff only",
        "PUT /admin/errors/{errorId}/resolve": "platform staff only",
        "GET /admin/errors/stats": "platform staff only",
        "GET /admin/health/components": "platform staff only",
        "PATCH /admin/health/components/{componentName}": "platform staff only",
        "GET /admin/hosting/services": "platform staff only",
        "DELETE /admin/hosting/services/{id}": "platform staff only",
        "GET /admin/hosting/services/{id}": "platform staff only",
        "POST /admin/hosting/services/{id}/deploy": "platform staff only",
        "GET /admin/hosting/services/{id}/logs": "platform staff only",
        "POST /admin/hosting/services/{id}/rollback": "platform staff only",
        "POST /admin/hosting/services/{id}/stop": "platform staff only",
        "POST /admin/hosting/services/{id}/suspend": "platform staff only",
        "POST /admin/hosting/services/{id}/unsuspend": "platform staff only",
        "GET /admin/incidents": "platform staff only",
        "POST /admin/incidents": "platform staff only",
        "DELETE /admin/incidents/{incidentId}": "platform staff only",
        "POST /admin/incidents/{incidentId}/ack": "platform staff only",
        "POST /admin/incidents/{incidentId}/resolve": "platform staff only",
        "POST /admin/incidents/bulk": "platform staff only",
        "GET /admin/organizations": "platform staff only",
        "GET /admin/organizations/{orgId}": "platform staff only",
        "PATCH /admin/organizations/{orgId}": "platform staff only",
        "DELETE /admin/organizations/{orgId}/members/{userId}": "platform staff only",
        "POST /admin/organizations/{orgId}/transfer": "platform staff only",
        "POST /admin/organizations/{orgId}/transfers/{id}/resend": "platform staff only",
        "GET /admin/overview": "platform staff only",
        "GET /admin/projects": "platform staff only",
        "GET /admin/projects/{projectId}": "platform staff only",
        "PATCH /admin/projects/{projectId}": "platform staff only",
        "GET /admin/queues": "platform staff only",
        "GET /admin/rbac/users": "platform staff only",
        "POST /admin/rbac/users": "platform staff only",
        "DELETE /admin/rbac/users/{userId}/roles/{roleId}": "platform staff only",
        "GET /admin/regions": "platform staff only",
        "PATCH /admin/regions/{regionKey}": "platform staff only",
        "GET /admin/resources/project/{projectId}": "platform staff only",
        "POST /admin/resources/project/{projectId}/db": "platform staff only",
        "GET /admin/roles": "platform staff only",
        "GET /admin/settings": "platform staff only",
        "PUT /admin/settings/{key}": "platform staff only",
        "GET /admin/support/orgs/{orgId}/tickets/{number}": "platform staff only",
        "PATCH /admin/support/orgs/{orgId}/tickets/{number}": "platform staff only",
        "POST /admin/support/orgs/{orgId}/tickets/{number}/messages": "platform staff only",
        "GET /admin/support/sla-report": "platform staff only",
        "GET /admin/support/tickets": "platform staff only",
        "GET /admin/system/info": "platform staff only",
        "GET /admin/users": "platform staff only",
        "GET /admin/users/{userId}": "platform staff only",
        "PATCH /admin/users/{userId}/admin": "platform staff only",
        "PATCH /admin/users/{userId}/status": "platform staff only",
        "POST /ai/copilot/deploy": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/deploy/{deployId}/rollback": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/editor/chat": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/export/docker": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/export/terraform/aws": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/export/terraform/gcp": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/export/zip": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/generation/resume": "no typed 2xx application/json response in the spec",
        "GET /ai/copilot/job/{jobId}/events": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/session/{sessionId}/workspace/approve-scripts": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/session/{sessionId}/workspace/preview/{target}/open": "no typed 2xx application/json response in the spec",
        "POST /ai/copilot/session/{sessionId}/workspace/preview/reset": "no typed 2xx application/json response in the spec",
        "POST /auth/impersonate/exchange": "platform staff only",
        "POST /auth/impersonate/token": "platform staff only",
        "GET /auth/oauth/{provider}": "no typed 2xx application/json response in the spec",
        "GET /auth/oauth/{provider}/callback": "no typed 2xx application/json response in the spec",
        "POST /auth/saml/acs/{id}": "no typed 2xx application/json response in the spec",
        "POST /auth/sso/callback": "no typed 2xx application/json response in the spec",
        "POST /auth/sso/start": "no typed 2xx application/json response in the spec",
        "GET /billing/org/{orgId}/invoices/{invoiceId}/pdf": "no typed 2xx application/json response in the spec",
        "POST /blueprint/frontend-beta": "no typed 2xx application/json response in the spec",
        "POST /docs/ai-answer": "no typed 2xx application/json response in the spec",
        "GET /enterprise/subdomain/{subdomain}": "no typed 2xx application/json response in the spec",
        "GET /github/oauth/callback": "no typed 2xx application/json response in the spec",
        "GET /logs/project/{projectId}/stream": "no typed 2xx application/json response in the spec",
        "GET /mcp/oauth/authorize": "no typed 2xx application/json response in the spec",
        "GET /openapi.json": "no typed 2xx application/json response in the spec",
        "GET /openapi/full": "no typed 2xx application/json response in the spec",
        "GET /projects/{projectId}/auth/magic/consume": "no typed 2xx application/json response in the spec",
        "GET /projects/{projectId}/auth/oauth/{provider}/callback": "no typed 2xx application/json response in the spec",
        "POST /projects/{projectId}/environments/{envId}/domains": "no typed 2xx application/json response in the spec",
        "POST /projects/{projectId}/infrastructure/restores": "no typed 2xx application/json response in the spec",
        "POST /projects/{projectId}/terminal/exec": "no typed 2xx application/json response in the spec",
        "GET /projects/{projectId}/terminal/sessions": "no typed 2xx application/json response in the spec",
        "GET /saml/{id}/metadata": "no typed 2xx application/json response in the spec",
        "POST /services/{serviceId}/start": "no typed 2xx application/json response in the spec",
    ]

    /// DELETE /ai/copilot/session/{sessionId}
    public func deleteAiCopilotSessionBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteAiCopilotSessionBySessionId"]!, path: path, headers: headers)
    }

    /// DELETE /alert-rules/{ruleId}
    public func deleteAlertRulesByRuleId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteAlertRulesByRuleId"]!, path: path, headers: headers)
    }

    /// DELETE /auth/me/linked-accounts/{provider}
    public func deleteAuthMeLinkedAccountsByProvider(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteAuthMeLinkedAccountsByProvider"]!, path: path, headers: headers)
    }

    /// DELETE /auth/sessions/{id}
    public func deleteAuthSessionsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteAuthSessionsById"]!, path: path, headers: headers)
    }

    /// DELETE /billing/org/{orgId}/addons/{addonId}
    public func deleteBillingOrgByOrgIdAddonsByAddonId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteBillingOrgByOrgIdAddonsByAddonId"]!, path: path, headers: headers)
    }

    /// DELETE /billing/org/{orgId}/contacts/{contactId}
    public func deleteBillingOrgByOrgIdContactsByContactId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteBillingOrgByOrgIdContactsByContactId"]!, path: path, headers: headers)
    }

    /// DELETE /billing/org/{orgId}/usage-alerts/{alertId}
    public func deleteBillingOrgByOrgIdUsageAlertsByAlertId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteBillingOrgByOrgIdUsageAlertsByAlertId"]!, path: path, headers: headers)
    }

    /// DELETE /buckets/{bucketId}
    public func deleteBucketsByBucketId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteBucketsByBucketId"]!, path: path, headers: headers)
    }

    /// DELETE /buckets/{bucketId}/files
    public func deleteBucketsByBucketIdFiles(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteBucketsByBucketIdFiles"]!, path: path, query: query, headers: headers)
    }

    /// DELETE /database/extensions/project/{projectId}/{extensionId}
    public func deleteDatabaseExtensionsProjectByProjectIdByExtensionId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDatabaseExtensionsProjectByProjectIdByExtensionId"]!, path: path, query: query, headers: headers)
    }

    /// DELETE /database/wrappers/project/{projectId}/{wrapperId}
    public func deleteDatabaseWrappersProjectByProjectIdByWrapperId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDatabaseWrappersProjectByProjectIdByWrapperId"]!, path: path, query: query, headers: headers)
    }

    /// DELETE /docs/api-endpoints/{id}
    public func deleteDocsApiEndpointsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsApiEndpointsById"]!, path: path, headers: headers)
    }

    /// DELETE /docs/changelog/{id}
    public func deleteDocsChangelogById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsChangelogById"]!, path: path, headers: headers)
    }

    /// DELETE /docs/examples/{id}
    public func deleteDocsExamplesById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsExamplesById"]!, path: path, headers: headers)
    }

    /// DELETE /docs/sdk-examples/{id}
    public func deleteDocsSdkExamplesById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsSdkExamplesById"]!, path: path, headers: headers)
    }

    /// DELETE /docs/sdks/{id}
    public func deleteDocsSdksById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsSdksById"]!, path: path, headers: headers)
    }

    /// DELETE /docs/v2/pages/{id}
    public func deleteDocsV2PagesById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteDocsV2PagesById"]!, path: path, headers: headers)
    }

    /// DELETE /flags/{key}
    public func deleteFlagsByKey(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteFlagsByKey"]!, path: path, headers: headers)
    }

    /// DELETE /functions/{functionId}
    public func deleteFunctionsByFunctionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteFunctionsByFunctionId"]!, path: path, headers: headers)
    }

    /// DELETE /functions/{functionId}/schedule
    public func deleteFunctionsByFunctionIdSchedule(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteFunctionsByFunctionIdSchedule"]!, path: path, headers: headers)
    }

    /// DELETE /functions/secrets/{secretId}
    public func deleteFunctionsSecretsBySecretId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteFunctionsSecretsBySecretId"]!, path: path, headers: headers)
    }

    /// DELETE /functions/triggers/{triggerId}
    public func deleteFunctionsTriggersByTriggerId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteFunctionsTriggersByTriggerId"]!, path: path, headers: headers)
    }

    /// DELETE /generated/{table}/bulk
    public func deleteGeneratedByTableBulk(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteGeneratedByTableBulk"]!, path: path, query: query, headers: headers)
    }

    /// DELETE /generated/{table}/{id}
    public func deleteGeneratedByTableById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteGeneratedByTableById"]!, path: path, headers: headers)
    }

    /// DELETE /integrations/subscriptions/{id}
    public func deleteIntegrationsSubscriptionsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteIntegrationsSubscriptionsById"]!, path: path, headers: headers)
    }

    /// DELETE /mcp/connections/{id}
    public func deleteMcpConnectionsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteMcpConnectionsById"]!, path: path, headers: headers)
    }

    /// DELETE /mongodb/{collection}/indexes/{indexName}
    public func deleteMongodbByCollectionIndexesByIndexName(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteMongodbByCollectionIndexesByIndexName"]!, path: path, headers: headers)
    }

    /// DELETE /mongodb/collections/{name}
    public func deleteMongodbCollectionsByName(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteMongodbCollectionsByName"]!, path: path, headers: headers)
    }

    /// DELETE /oauth/org/{orgId}/provider/{provider}
    public func deleteOauthOrgByOrgIdProviderByProvider(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteOauthOrgByOrgIdProviderByProvider"]!, path: path, headers: headers)
    }

    /// DELETE /orgs/{orgId}/invites/{inviteId}
    public func deleteOrgsByOrgIdInvitesByInviteId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteOrgsByOrgIdInvitesByInviteId"]!, path: path, headers: headers)
    }

    /// DELETE /orgs/{orgId}/leave-requests/mine
    public func deleteOrgsByOrgIdLeaveRequestsMine(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteOrgsByOrgIdLeaveRequestsMine"]!, path: path, headers: headers)
    }

    /// DELETE /orgs/{orgId}/members/{userId}
    public func deleteOrgsByOrgIdMembersByUserId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteOrgsByOrgIdMembersByUserId"]!, path: path, headers: headers)
    }

    /// DELETE /orgs/{orgId}/transfers/{id}
    public func deleteOrgsByOrgIdTransfersById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteOrgsByOrgIdTransfersById"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}
    public func deleteProjectsByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/auth/oauth-apps/{provider}
    public func deleteProjectsByProjectIdAuthOauthAppsByProvider(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdAuthOauthAppsByProvider"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/auth/sessions
    public func deleteProjectsByProjectIdAuthSessions(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdAuthSessions"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/auth/sessions/{id}
    public func deleteProjectsByProjectIdAuthSessionsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdAuthSessionsById"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/branches/{branchName}
    public func deleteProjectsByProjectIdBranchesByBranchName(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdBranchesByBranchName"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/database/dedicated
    public func deleteProjectsByProjectIdDatabaseDedicated(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdDatabaseDedicated"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/env-vars/{envVarId}
    public func deleteProjectsByProjectIdEnvVarsByEnvVarId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdEnvVarsByEnvVarId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/environments/{envId}
    public func deleteProjectsByProjectIdEnvironmentsByEnvId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdEnvironmentsByEnvId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/environments/{envId}/domains/{domainId}
    public func deleteProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/github/disconnect
    public func deleteProjectsByProjectIdGithubDisconnect(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdGithubDisconnect"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/infrastructure/{instanceId}
    public func deleteProjectsByProjectIdInfrastructureByInstanceId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdInfrastructureByInstanceId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// DELETE /projects/{projectId}/members/{userId}
    public func deleteProjectsByProjectIdMembersByUserId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdMembersByUserId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/users/{userId}
    public func deleteProjectsByProjectIdUsersByUserId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdUsersByUserId"]!, path: path, headers: headers)
    }

    /// DELETE /projects/{projectId}/users/{userId}/sessions/{sessionId}
    public func deleteProjectsByProjectIdUsersByUserIdSessionsBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteProjectsByProjectIdUsersByUserIdSessionsBySessionId"]!, path: path, headers: headers)
    }

    /// DELETE /rls/policies/{policyId}
    public func deleteRlsPoliciesByPolicyId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteRlsPoliciesByPolicyId"]!, path: path, headers: headers)
    }

    /// DELETE /schema-engine/snippets/{projectId}/{snippetId}
    public func deleteSchemaEngineSnippetsByProjectIdBySnippetId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSchemaEngineSnippetsByProjectIdBySnippetId"]!, path: path, headers: headers)
    }

    /// DELETE /services/{serviceId}
    public func deleteServicesByServiceId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteServicesByServiceId"]!, path: path, headers: headers)
    }

    /// DELETE /services/{serviceId}/domains/{domainId}
    public func deleteServicesByServiceIdDomainsByDomainId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteServicesByServiceIdDomainsByDomainId"]!, path: path, headers: headers)
    }

    /// DELETE /services/{serviceId}/git/connect
    public func deleteServicesByServiceIdGitConnect(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteServicesByServiceIdGitConnect"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/connections/{connectionId}
    public func deleteSsoOrgByOrgIdConnectionsByConnectionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdConnectionsByConnectionId"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/connections/{connectionId}/certificates/{certId}
    public func deleteSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertId"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/connections/{connectionId}/identities/{userId}
    public func deleteSsoOrgByOrgIdConnectionsByConnectionIdIdentitiesByUserId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdConnectionsByConnectionIdIdentitiesByUserId"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/connections/{connectionId}/scim/tokens/{tokenId}
    public func deleteSsoOrgByOrgIdConnectionsByConnectionIdScimTokensByTokenId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdConnectionsByConnectionIdScimTokensByTokenId"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/outside-members/allow/{allowId}
    public func deleteSsoOrgByOrgIdOutsideMembersAllowByAllowId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdOutsideMembersAllowByAllowId"]!, path: path, headers: headers)
    }

    /// DELETE /sso/org/{orgId}/security-contact
    public func deleteSsoOrgByOrgIdSecurityContact(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteSsoOrgByOrgIdSecurityContact"]!, path: path, headers: headers)
    }

    /// DELETE /storage/buckets/{bucketId}/policies/{policyId}
    public func deleteStorageBucketsByBucketIdPoliciesByPolicyId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteStorageBucketsByBucketIdPoliciesByPolicyId"]!, path: path, headers: headers)
    }

    /// DELETE /templates/{id}
    public func deleteTemplatesById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteTemplatesById"]!, path: path, headers: headers)
    }

    /// DELETE /v1/data/{projectId}/{table}/bulk
    public func deleteV1DataByProjectIdByTableBulk(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteV1DataByProjectIdByTableBulk"]!, path: path, query: query, headers: headers)
    }

    /// DELETE /v1/data/{projectId}/{table}/{id}
    public func deleteV1DataByProjectIdByTableById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["deleteV1DataByProjectIdByTableById"]!, path: path, headers: headers)
    }

    /// GET /
    public func get(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["get"]!, headers: headers)
    }

    /// GET /activation/org/{orgId}
    public func getActivationOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getActivationOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/autocomplete
    public func getAiCopilotAutocomplete(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotAutocomplete"]!, query: query, headers: headers)
    }

    /// GET /ai/copilot/context-summary/{projectId}
    public func getAiCopilotContextSummaryByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotContextSummaryByProjectId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/credit-status/{projectId}
    public func getAiCopilotCreditStatusByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotCreditStatusByProjectId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/deploy/{deployId}
    public func getAiCopilotDeployByDeployId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotDeployByDeployId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/deploy/history/{projectId}
    public func getAiCopilotDeployHistoryByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotDeployHistoryByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai/copilot/execution/{executionId}
    public func getAiCopilotExecutionByExecutionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotExecutionByExecutionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/executions/{sessionId}
    public func getAiCopilotExecutionsBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotExecutionsBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/git/branches/{sessionId}
    public func getAiCopilotGitBranchesBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotGitBranchesBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/git/files/{sessionId}
    public func getAiCopilotGitFilesBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotGitFilesBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/git/log/{sessionId}
    public func getAiCopilotGitLogBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotGitLogBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/git/status/{sessionId}
    public func getAiCopilotGitStatusBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotGitStatusBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/job/{jobId}
    public func getAiCopilotJobByJobId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotJobByJobId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/manifest/{manifestId}
    public func getAiCopilotManifestByManifestId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotManifestByManifestId"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai/copilot/metrics/{projectId}
    public func getAiCopilotMetricsByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotMetricsByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai/copilot/metrics/org/{orgId}
    public func getAiCopilotMetricsOrgByOrgId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotMetricsOrgByOrgId"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai/copilot/models/{projectId}
    public func getAiCopilotModelsByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotModelsByProjectId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/session/{sessionId}
    public func getAiCopilotSessionBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/session/{sessionId}/editor-files
    public func getAiCopilotSessionBySessionIdEditorFiles(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionBySessionIdEditorFiles"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/session/{sessionId}/workspace/export
    public func getAiCopilotSessionBySessionIdWorkspaceExport(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionBySessionIdWorkspaceExport"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/session/{sessionId}/workspace/status
    public func getAiCopilotSessionBySessionIdWorkspaceStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionBySessionIdWorkspaceStatus"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/session/{sessionId}/workspace/types
    public func getAiCopilotSessionBySessionIdWorkspaceTypes(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionBySessionIdWorkspaceTypes"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/sessions/{projectId}
    public func getAiCopilotSessionsByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotSessionsByProjectId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/stats
    public func getAiCopilotStats(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotStats"]!, headers: headers)
    }

    /// GET /ai/copilot/usage/{projectId}
    public func getAiCopilotUsageByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotUsageByProjectId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/usage-org/{orgId}
    public func getAiCopilotUsageOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotUsageOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/version/{versionId}
    public func getAiCopilotVersionByVersionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotVersionByVersionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/version/{versionId}/diff/{compareVersionId}
    public func getAiCopilotVersionByVersionIdDiffByCompareVersionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotVersionByVersionIdDiffByCompareVersionId"]!, path: path, headers: headers)
    }

    /// GET /ai/copilot/versions/{sessionId}
    public func getAiCopilotVersionsBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiCopilotVersionsBySessionId"]!, path: path, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/breakdown
    public func getAiUsageOrgByOrgIdBreakdown(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdBreakdown"]!, path: path, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/exhaustion-events
    public func getAiUsageOrgByOrgIdExhaustionEvents(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdExhaustionEvents"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/history
    public func getAiUsageOrgByOrgIdHistory(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdHistory"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/recent
    public func getAiUsageOrgByOrgIdRecent(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdRecent"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/rollups
    public func getAiUsageOrgByOrgIdRollups(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdRollups"]!, path: path, query: query, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/summary
    public func getAiUsageOrgByOrgIdSummary(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdSummary"]!, path: path, headers: headers)
    }

    /// GET /ai-usage/org/{orgId}/verament
    public func getAiUsageOrgByOrgIdVerament(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAiUsageOrgByOrgIdVerament"]!, path: path, query: query, headers: headers)
    }

    /// GET /alert-rules/project/{projectId}
    public func getAlertRulesProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAlertRulesProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /announcements
    public func getAnnouncements(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAnnouncements"]!, headers: headers)
    }

    /// GET /audit/org/{orgId}
    public func getAuditOrgByOrgId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuditOrgByOrgId"]!, path: path, query: query, headers: headers)
    }

    /// GET /audit/project/{projectId}
    public func getAuditProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuditProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /auth/me
    public func getAuthMe(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthMe"]!, headers: headers)
    }

    /// GET /auth/me/admin
    public func getAuthMeAdmin(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthMeAdmin"]!, headers: headers)
    }

    /// GET /auth/me/context
    public func getAuthMeContext(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthMeContext"]!, headers: headers)
    }

    /// GET /auth/me/linked-accounts
    public func getAuthMeLinkedAccounts(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthMeLinkedAccounts"]!, headers: headers)
    }

    /// GET /auth/mfa/status
    public func getAuthMfaStatus(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthMfaStatus"]!, headers: headers)
    }

    /// GET /auth/oauth/providers
    public func getAuthOauthProviders(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthOauthProviders"]!, headers: headers)
    }

    /// GET /auth/session
    public func getAuthSession(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthSession"]!, headers: headers)
    }

    /// GET /auth/sessions
    public func getAuthSessions(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthSessions"]!, headers: headers)
    }

    /// GET /auth/tenant/session
    public func getAuthTenantSession(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getAuthTenantSession"]!, headers: headers)
    }

    /// GET /billing/addons/catalog
    public func getBillingAddonsCatalog(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingAddonsCatalog"]!, query: query, headers: headers)
    }

    /// GET /billing/checkout/verify/{sessionId}
    public func getBillingCheckoutVerifyBySessionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingCheckoutVerifyBySessionId"]!, path: path, headers: headers)
    }

    /// GET /billing/credits/packages
    public func getBillingCreditsPackages(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingCreditsPackages"]!, headers: headers)
    }

    /// GET /billing/credits/rates
    public func getBillingCreditsRates(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingCreditsRates"]!, headers: headers)
    }

    /// GET /billing/founders/wall
    public func getBillingFoundersWall(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingFoundersWall"]!, headers: headers)
    }

    /// GET /billing/org/{orgId}/addons
    public func getBillingOrgByOrgIdAddons(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdAddons"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/card-check
    public func getBillingOrgByOrgIdCardCheck(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdCardCheck"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/contacts
    public func getBillingOrgByOrgIdContacts(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdContacts"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/cost-breakdown
    public func getBillingOrgByOrgIdCostBreakdown(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdCostBreakdown"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/credits/auto-topup
    public func getBillingOrgByOrgIdCreditsAutoTopup(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdCreditsAutoTopup"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/credits/transactions
    public func getBillingOrgByOrgIdCreditsTransactions(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdCreditsTransactions"]!, path: path, query: query, headers: headers)
    }

    /// GET /billing/org/{orgId}/founder
    public func getBillingOrgByOrgIdFounder(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdFounder"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/hosting
    public func getBillingOrgByOrgIdHosting(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdHosting"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/infrastructure
    public func getBillingOrgByOrgIdInfrastructure(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdInfrastructure"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/invoices
    public func getBillingOrgByOrgIdInvoices(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdInvoices"]!, path: path, query: query, headers: headers)
    }

    /// GET /billing/org/{orgId}/overages
    public func getBillingOrgByOrgIdOverages(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdOverages"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/overages/history
    public func getBillingOrgByOrgIdOveragesHistory(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdOveragesHistory"]!, path: path, query: query, headers: headers)
    }

    /// GET /billing/org/{orgId}/subscription
    public func getBillingOrgByOrgIdSubscription(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdSubscription"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/summary
    public func getBillingOrgByOrgIdSummary(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdSummary"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/tax-info
    public func getBillingOrgByOrgIdTaxInfo(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdTaxInfo"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage
    public func getBillingOrgByOrgIdUsage(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsage"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage-alerts
    public func getBillingOrgByOrgIdUsageAlerts(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsageAlerts"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage-alerts/configured
    public func getBillingOrgByOrgIdUsageAlertsConfigured(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsageAlertsConfigured"]!, path: path, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage-alerts/history
    public func getBillingOrgByOrgIdUsageAlertsHistory(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsageAlertsHistory"]!, path: path, query: query, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage/history
    public func getBillingOrgByOrgIdUsageHistory(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsageHistory"]!, path: path, query: query, headers: headers)
    }

    /// GET /billing/org/{orgId}/usage/realtime
    public func getBillingOrgByOrgIdUsageRealtime(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingOrgByOrgIdUsageRealtime"]!, path: path, headers: headers)
    }

    /// GET /billing/plans
    public func getBillingPlans(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBillingPlans"]!, headers: headers)
    }

    /// GET /bootstrap
    public func getBootstrap(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBootstrap"]!, headers: headers)
    }

    /// GET /buckets/{bucketId}
    public func getBucketsByBucketId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBucketsByBucketId"]!, path: path, headers: headers)
    }

    /// GET /buckets/{bucketId}/files
    public func getBucketsByBucketIdFiles(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBucketsByBucketIdFiles"]!, path: path, query: query, headers: headers)
    }

    /// GET /buckets/project/{projectId}
    public func getBucketsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getBucketsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /cms/careers
    public func getCmsCareers(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsCareers"]!, headers: headers)
    }

    /// GET /cms/faqs/{pageSlug}
    public func getCmsFaqsByPageSlug(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsFaqsByPageSlug"]!, path: path, headers: headers)
    }

    /// GET /cms/pages/{slug}
    public func getCmsPagesBySlug(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsPagesBySlug"]!, path: path, headers: headers)
    }

    /// GET /cms/partners
    public func getCmsPartners(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsPartners"]!, headers: headers)
    }

    /// GET /cms/team
    public func getCmsTeam(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsTeam"]!, headers: headers)
    }

    /// GET /cms/testimonials
    public func getCmsTestimonials(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCmsTestimonials"]!, headers: headers)
    }

    /// GET /credits/org/{orgId}
    public func getCreditsOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCreditsOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /credits/org/{orgId}/balance
    public func getCreditsOrgByOrgIdBalance(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getCreditsOrgByOrgIdBalance"]!, path: path, headers: headers)
    }

    /// GET /database/connector/{projectId}/tables
    public func getDatabaseConnectorByProjectIdTables(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseConnectorByProjectIdTables"]!, path: path, query: query, headers: headers)
    }

    /// GET /database/extensions/available
    public func getDatabaseExtensionsAvailable(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseExtensionsAvailable"]!, headers: headers)
    }

    /// GET /database/extensions/project/{projectId}
    public func getDatabaseExtensionsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseExtensionsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /database/tiers
    public func getDatabaseTiers(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseTiers"]!, query: query, headers: headers)
    }

    /// GET /database/wrappers/available
    public func getDatabaseWrappersAvailable(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseWrappersAvailable"]!, headers: headers)
    }

    /// GET /database/wrappers/project/{projectId}
    public func getDatabaseWrappersProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDatabaseWrappersProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /deployments/{deploymentId}
    public func getDeploymentsByDeploymentId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDeploymentsByDeploymentId"]!, path: path, headers: headers)
    }

    /// GET /deployments/{deploymentId}/steps
    public func getDeploymentsByDeploymentIdSteps(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDeploymentsByDeploymentIdSteps"]!, path: path, headers: headers)
    }

    /// GET /deployments/project/{projectId}
    public func getDeploymentsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDeploymentsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /deployments/project/{projectId}/stats
    public func getDeploymentsProjectByProjectIdStats(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDeploymentsProjectByProjectIdStats"]!, path: path, headers: headers)
    }

    /// GET /deployments/tokens/project/{projectId}
    public func getDeploymentsTokensProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDeploymentsTokensProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /docs/ai-search
    public func getDocsAiSearch(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsAiSearch"]!, query: query, headers: headers)
    }

    /// GET /docs/api-endpoints
    public func getDocsApiEndpoints(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsApiEndpoints"]!, query: query, headers: headers)
    }

    /// GET /docs/api-endpoints/{id}
    public func getDocsApiEndpointsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsApiEndpointsById"]!, path: path, headers: headers)
    }

    /// GET /docs/categories
    public func getDocsCategories(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsCategories"]!, headers: headers)
    }

    /// GET /docs/changelog
    public func getDocsChangelog(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsChangelog"]!, headers: headers)
    }

    /// GET /docs/changelog/{id}
    public func getDocsChangelogById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsChangelogById"]!, path: path, headers: headers)
    }

    /// GET /docs/examples
    public func getDocsExamples(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsExamples"]!, query: query, headers: headers)
    }

    /// GET /docs/examples/{slug}
    public func getDocsExamplesBySlug(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsExamplesBySlug"]!, path: path, headers: headers)
    }

    /// GET /docs/project/{projectId}/quickstart
    public func getDocsProjectByProjectIdQuickstart(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsProjectByProjectIdQuickstart"]!, path: path, headers: headers)
    }

    /// GET /docs/sdks
    public func getDocsSdks(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsSdks"]!, headers: headers)
    }

    /// GET /docs/sdks/{platform}
    public func getDocsSdksByPlatform(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsSdksByPlatform"]!, path: path, headers: headers)
    }

    /// GET /docs/sdks/{sdkId}/examples
    public func getDocsSdksBySdkIdExamples(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsSdksBySdkIdExamples"]!, path: path, query: query, headers: headers)
    }

    /// GET /docs/search
    public func getDocsSearch(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsSearch"]!, query: query, headers: headers)
    }

    /// GET /docs/v2/pages
    public func getDocsV2Pages(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsV2Pages"]!, query: query, headers: headers)
    }

    /// GET /docs/v2/pages/{slug}
    public func getDocsV2PagesBySlug(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getDocsV2PagesBySlug"]!, path: path, headers: headers)
    }

    /// GET /early/{number}
    public func getEarlyByNumber(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEarlyByNumber"]!, path: path, headers: headers)
    }

    /// GET /early/wall
    public func getEarlyWall(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEarlyWall"]!, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/contract
    public func getEnterpriseOrgByOrgIdContract(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdContract"]!, path: path, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/invoices
    public func getEnterpriseOrgByOrgIdInvoices(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdInvoices"]!, path: path, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/onboarding
    public func getEnterpriseOrgByOrgIdOnboarding(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdOnboarding"]!, path: path, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/spend
    public func getEnterpriseOrgByOrgIdSpend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdSpend"]!, path: path, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/usage
    public func getEnterpriseOrgByOrgIdUsage(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdUsage"]!, path: path, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/usage/history
    public func getEnterpriseOrgByOrgIdUsageHistory(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdUsageHistory"]!, path: path, query: query, headers: headers)
    }

    /// GET /enterprise/org/{orgId}/usage/projects
    public func getEnterpriseOrgByOrgIdUsageProjects(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseOrgByOrgIdUsageProjects"]!, path: path, headers: headers)
    }

    /// GET /enterprise/pricing
    public func getEnterprisePricing(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterprisePricing"]!, headers: headers)
    }

    /// GET /enterprise/quotes/{quoteId}
    public func getEnterpriseQuotesByQuoteId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEnterpriseQuotesByQuoteId"]!, path: path, headers: headers)
    }

    /// GET /entitlements/org/{orgId}
    public func getEntitlementsOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getEntitlementsOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /flags
    public func getFlags(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFlags"]!, headers: headers)
    }

    /// GET /functions/{functionId}
    public func getFunctionsByFunctionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionId"]!, path: path, headers: headers)
    }

    /// GET /functions/{functionId}/deploy-status
    public func getFunctionsByFunctionIdDeployStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdDeployStatus"]!, path: path, headers: headers)
    }

    /// GET /functions/{functionId}/invocations
    public func getFunctionsByFunctionIdInvocations(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdInvocations"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/{functionId}/logs
    public func getFunctionsByFunctionIdLogs(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdLogs"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/{functionId}/metrics
    public func getFunctionsByFunctionIdMetrics(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdMetrics"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/{functionId}/schedule
    public func getFunctionsByFunctionIdSchedule(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdSchedule"]!, path: path, headers: headers)
    }

    /// GET /functions/{functionId}/triggers
    public func getFunctionsByFunctionIdTriggers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsByFunctionIdTriggers"]!, path: path, headers: headers)
    }

    /// GET /functions/invocations
    public func getFunctionsInvocations(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsInvocations"]!, query: query, headers: headers)
    }

    /// GET /functions/invocations/function/{functionId}
    public func getFunctionsInvocationsFunctionByFunctionId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsInvocationsFunctionByFunctionId"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/project/{projectId}
    public func getFunctionsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/project/{projectId}/name/{functionName}
    public func getFunctionsProjectByProjectIdNameByFunctionName(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsProjectByProjectIdNameByFunctionName"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/project/{projectId}/summary
    public func getFunctionsProjectByProjectIdSummary(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsProjectByProjectIdSummary"]!, path: path, query: query, headers: headers)
    }

    /// GET /functions/schedule/preview
    public func getFunctionsSchedulePreview(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsSchedulePreview"]!, query: query, headers: headers)
    }

    /// GET /functions/secrets/project/{projectId}
    public func getFunctionsSecretsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getFunctionsSecretsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /generated/{table}
    public func getGeneratedByTable(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getGeneratedByTable"]!, path: path, query: query, headers: headers)
    }

    /// GET /generated/{table}/aggregate
    public func getGeneratedByTableAggregate(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getGeneratedByTableAggregate"]!, path: path, query: query, headers: headers)
    }

    /// GET /generated/{table}/{id}
    public func getGeneratedByTableById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getGeneratedByTableById"]!, path: path, headers: headers)
    }

    /// GET /generated/{table}/search
    public func getGeneratedByTableSearch(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getGeneratedByTableSearch"]!, path: path, query: query, headers: headers)
    }

    /// GET /github/oauth/authorize
    public func getGithubOauthAuthorize(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getGithubOauthAuthorize"]!, query: query, headers: headers)
    }

    /// GET /incidents/project/{projectId}
    public func getIncidentsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIncidentsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /infrastructure/sizes
    public func getInfrastructureSizes(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getInfrastructureSizes"]!, headers: headers)
    }

    /// GET /integrations/analytics/project/{projectId}/events
    public func getIntegrationsAnalyticsProjectByProjectIdEvents(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsAnalyticsProjectByProjectIdEvents"]!, path: path, headers: headers)
    }

    /// GET /integrations/analytics/project/{projectId}/stats
    public func getIntegrationsAnalyticsProjectByProjectIdStats(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsAnalyticsProjectByProjectIdStats"]!, path: path, headers: headers)
    }

    /// GET /integrations/deliveries/event/{eventId}
    public func getIntegrationsDeliveriesEventByEventId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsDeliveriesEventByEventId"]!, path: path, headers: headers)
    }

    /// GET /integrations/deliveries/project/{projectId}
    public func getIntegrationsDeliveriesProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsDeliveriesProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /integrations/deliveries/project/{projectId}/summary
    public func getIntegrationsDeliveriesProjectByProjectIdSummary(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsDeliveriesProjectByProjectIdSummary"]!, path: path, query: query, headers: headers)
    }

    /// GET /integrations/deliveries/subscription/{subscriptionId}
    public func getIntegrationsDeliveriesSubscriptionBySubscriptionId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsDeliveriesSubscriptionBySubscriptionId"]!, path: path, headers: headers)
    }

    /// GET /integrations/dlq/project/{projectId}
    public func getIntegrationsDlqProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsDlqProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /integrations/events
    public func getIntegrationsEvents(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsEvents"]!, headers: headers)
    }

    /// GET /integrations/subscriptions/project/{projectId}
    public func getIntegrationsSubscriptionsProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getIntegrationsSubscriptionsProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /jobs/dlq/project/{projectId}
    public func getJobsDlqProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getJobsDlqProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /jobs/webhooks/delivery/{deliveryId}
    public func getJobsWebhooksDeliveryByDeliveryId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getJobsWebhooksDeliveryByDeliveryId"]!, path: path, headers: headers)
    }

    /// GET /jobs/webhooks/project/{projectId}
    public func getJobsWebhooksProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getJobsWebhooksProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /logs/project/{projectId}
    public func getLogsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getLogsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /logs/project/{projectId}/feed
    public func getLogsProjectByProjectIdFeed(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getLogsProjectByProjectIdFeed"]!, path: path, query: query, headers: headers)
    }

    /// GET /maintenance
    public func getMaintenance(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMaintenance"]!, headers: headers)
    }

    /// GET /mcp/connections
    public func getMcpConnections(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMcpConnections"]!, query: query, headers: headers)
    }

    /// GET /mcp/oauth/requests/{requestId}
    public func getMcpOauthRequestsByRequestId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMcpOauthRequestsByRequestId"]!, path: path, headers: headers)
    }

    /// GET /mcp/session
    public func getMcpSession(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMcpSession"]!, headers: headers)
    }

    /// GET /me/badges
    public func getMeBadges(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMeBadges"]!, headers: headers)
    }

    /// GET /me/creator
    public func getMeCreator(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMeCreator"]!, headers: headers)
    }

    /// GET /metrics/org/{orgId}
    public func getMetricsOrgByOrgId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMetricsOrgByOrgId"]!, path: path, query: query, headers: headers)
    }

    /// GET /metrics/project/{projectId}
    public func getMetricsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMetricsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /metrics/project/{projectId}/overview
    public func getMetricsProjectByProjectIdOverview(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMetricsProjectByProjectIdOverview"]!, path: path, headers: headers)
    }

    /// GET /metrics/project/{projectId}/report
    public func getMetricsProjectByProjectIdReport(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMetricsProjectByProjectIdReport"]!, path: path, query: query, headers: headers)
    }

    /// GET /mongodb/{collection}/estimatedCount
    public func getMongodbByCollectionEstimatedCount(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMongodbByCollectionEstimatedCount"]!, path: path, headers: headers)
    }

    /// GET /mongodb/{collection}/findById/{id}
    public func getMongodbByCollectionFindByIdById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMongodbByCollectionFindByIdById"]!, path: path, headers: headers)
    }

    /// GET /mongodb/{collection}/indexes
    public func getMongodbByCollectionIndexes(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMongodbByCollectionIndexes"]!, path: path, headers: headers)
    }

    /// GET /mongodb/collections
    public func getMongodbCollections(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getMongodbCollections"]!, headers: headers)
    }

    /// GET /oauth/org/{orgId}
    public func getOauthOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOauthOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /oauth/org/{orgId}/provider/{provider}/authorize
    public func getOauthOrgByOrgIdProviderByProviderAuthorize(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOauthOrgByOrgIdProviderByProviderAuthorize"]!, path: path, query: query, headers: headers)
    }

    /// GET /onboarding/org/{orgId}
    public func getOnboardingOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOnboardingOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /openapi/project/{projectId}
    public func getOpenapiProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOpenapiProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /openapi.yaml
    public func getOpenapiYaml(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOpenapiYaml"]!, headers: headers)
    }

    /// GET /orgs
    public func getOrgs(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgs"]!, headers: headers)
    }

    /// GET /orgs/{orgId}/access-matrix
    public func getOrgsByOrgIdAccessMatrix(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdAccessMatrix"]!, path: path, query: query, headers: headers)
    }

    /// GET /orgs/{orgId}/blueprint-defaults
    public func getOrgsByOrgIdBlueprintDefaults(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdBlueprintDefaults"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/change-requests
    public func getOrgsByOrgIdChangeRequests(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdChangeRequests"]!, path: path, query: query, headers: headers)
    }

    /// GET /orgs/{orgId}/data-region
    public func getOrgsByOrgIdDataRegion(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdDataRegion"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/identity/summary
    public func getOrgsByOrgIdIdentitySummary(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdIdentitySummary"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/invites
    public func getOrgsByOrgIdInvites(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdInvites"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/leave-requests
    public func getOrgsByOrgIdLeaveRequests(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdLeaveRequests"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/leave-requests/mine
    public func getOrgsByOrgIdLeaveRequestsMine(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdLeaveRequestsMine"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/managed-domains
    public func getOrgsByOrgIdManagedDomains(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdManagedDomains"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/managed-summary
    public func getOrgsByOrgIdManagedSummary(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdManagedSummary"]!, path: path, query: query, headers: headers)
    }

    /// GET /orgs/{orgId}/members
    public func getOrgsByOrgIdMembers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdMembers"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/membership
    public func getOrgsByOrgIdMembership(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdMembership"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/profile
    public func getOrgsByOrgIdProfile(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdProfile"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/roles
    public func getOrgsByOrgIdRoles(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdRoles"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/security
    public func getOrgsByOrgIdSecurity(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSecurity"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/security/posture
    public func getOrgsByOrgIdSecurityPosture(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSecurityPosture"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/support/sla-report
    public func getOrgsByOrgIdSupportSlaReport(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSupportSlaReport"]!, path: path, query: query, headers: headers)
    }

    /// GET /orgs/{orgId}/support/summary
    public func getOrgsByOrgIdSupportSummary(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSupportSummary"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/support/terms
    public func getOrgsByOrgIdSupportTerms(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSupportTerms"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/support/tickets
    public func getOrgsByOrgIdSupportTickets(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSupportTickets"]!, path: path, query: query, headers: headers)
    }

    /// GET /orgs/{orgId}/support/tickets/{number}
    public func getOrgsByOrgIdSupportTicketsByNumber(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdSupportTicketsByNumber"]!, path: path, headers: headers)
    }

    /// GET /orgs/{orgId}/transfers
    public func getOrgsByOrgIdTransfers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsByOrgIdTransfers"]!, path: path, headers: headers)
    }

    /// GET /orgs/invites/lookup
    public func getOrgsInvitesLookup(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsInvitesLookup"]!, query: query, headers: headers)
    }

    /// GET /orgs/transfers/preview
    public func getOrgsTransfersPreview(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getOrgsTransfersPreview"]!, query: query, headers: headers)
    }

    /// GET /plans/{planId}
    public func getPlansByPlanId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPlansByPlanId"]!, path: path, headers: headers)
    }

    /// GET /plans/org/{orgId}
    public func getPlansOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPlansOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /pricing/ai-features
    public func getPricingAiFeatures(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPricingAiFeatures"]!, headers: headers)
    }

    /// GET /pricing/compare
    public func getPricingCompare(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPricingCompare"]!, headers: headers)
    }

    /// GET /pricing/enterprise
    public func getPricingEnterprise(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPricingEnterprise"]!, headers: headers)
    }

    /// GET /pricing/plans
    public func getPricingPlans(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPricingPlans"]!, headers: headers)
    }

    /// GET /pricing/plans/{plan}
    public func getPricingPlansByPlan(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getPricingPlansByPlan"]!, path: path, headers: headers)
    }

    /// GET /projects
    public func getProjects(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjects"]!, query: query, headers: headers)
    }

    /// GET /projects/{id}/insights
    public func getProjectsByIdInsights(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByIdInsights"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}
    public func getProjectsByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectId"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/api-keys
    public func getProjectsByProjectIdApiKeys(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdApiKeys"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/auth/activity
    public func getProjectsByProjectIdAuthActivity(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthActivity"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}/auth/me
    public func getProjectsByProjectIdAuthMe(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthMe"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/auth/oauth-apps
    public func getProjectsByProjectIdAuthOauthApps(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthOauthApps"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/auth/oauth/providers
    public func getProjectsByProjectIdAuthOauthProviders(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthOauthProviders"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/auth/sessions
    public func getProjectsByProjectIdAuthSessions(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthSessions"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/auth/settings
    public func getProjectsByProjectIdAuthSettings(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdAuthSettings"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/branches
    public func getProjectsByProjectIdBranches(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdBranches"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/branches/{branchName}/url
    public func getProjectsByProjectIdBranchesByBranchNameUrl(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdBranchesByBranchNameUrl"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/database/dedicated
    public func getProjectsByProjectIdDatabaseDedicated(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdDatabaseDedicated"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/database/dedicated/connection
    public func getProjectsByProjectIdDatabaseDedicatedConnection(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdDatabaseDedicatedConnection"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/database/dedicated/status
    public func getProjectsByProjectIdDatabaseDedicatedStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdDatabaseDedicatedStatus"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/deletion-preview
    public func getProjectsByProjectIdDeletionPreview(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdDeletionPreview"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/env-vars
    public func getProjectsByProjectIdEnvVars(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvVars"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}/environments
    public func getProjectsByProjectIdEnvironments(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvironments"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/environments/{envId}/domain-status
    public func getProjectsByProjectIdEnvironmentsByEnvIdDomainStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvironmentsByEnvIdDomainStatus"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/environments/{envId}/domain-verification
    public func getProjectsByProjectIdEnvironmentsByEnvIdDomainVerification(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvironmentsByEnvIdDomainVerification"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/environments/{envId}/domains
    public func getProjectsByProjectIdEnvironmentsByEnvIdDomains(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvironmentsByEnvIdDomains"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/environments/promotion-order
    public func getProjectsByProjectIdEnvironmentsPromotionOrder(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdEnvironmentsPromotionOrder"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/frontend
    public func getProjectsByProjectIdFrontend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdFrontend"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/getting-started
    public func getProjectsByProjectIdGettingStarted(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdGettingStarted"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/github/branches
    public func getProjectsByProjectIdGithubBranches(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdGithubBranches"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}/github/repos
    public func getProjectsByProjectIdGithubRepos(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdGithubRepos"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/github/status
    public func getProjectsByProjectIdGithubStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdGithubStatus"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/github/tracked-repos
    public func getProjectsByProjectIdGithubTrackedRepos(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdGithubTrackedRepos"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure
    public func getProjectsByProjectIdInfrastructure(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructure"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/{instanceId}/metrics
    public func getProjectsByProjectIdInfrastructureByInstanceIdMetrics(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureByInstanceIdMetrics"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/{instanceId}/replicas
    public func getProjectsByProjectIdInfrastructureByInstanceIdReplicas(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureByInstanceIdReplicas"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/{instanceId}/upgrade-options
    public func getProjectsByProjectIdInfrastructureByInstanceIdUpgradeOptions(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureByInstanceIdUpgradeOptions"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/migration/progress
    public func getProjectsByProjectIdInfrastructureMigrationProgress(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureMigrationProgress"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/migration-status
    public func getProjectsByProjectIdInfrastructureMigrationStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureMigrationStatus"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/infrastructure/restores
    public func getProjectsByProjectIdInfrastructureRestores(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdInfrastructureRestores"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/members
    public func getProjectsByProjectIdMembers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdMembers"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/promotions
    public func getProjectsByProjectIdPromotions(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdPromotions"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/promotions/diff
    public func getProjectsByProjectIdPromotionsDiff(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdPromotionsDiff"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}/region
    public func getProjectsByProjectIdRegion(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdRegion"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/security/advisor
    public func getProjectsByProjectIdSecurityAdvisor(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSecurityAdvisor"]!, path: path, query: query, headers: headers)
    }

    /// GET /projects/{projectId}/settings
    public func getProjectsByProjectIdSettings(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSettings"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/settings/addons
    public func getProjectsByProjectIdSettingsAddons(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSettingsAddons"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/settings/api
    public func getProjectsByProjectIdSettingsApi(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSettingsApi"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/settings/compute
    public func getProjectsByProjectIdSettingsCompute(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSettingsCompute"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/settings/jwt
    public func getProjectsByProjectIdSettingsJwt(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdSettingsJwt"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/storage/settings
    public func getProjectsByProjectIdStorageSettings(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdStorageSettings"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/users
    public func getProjectsByProjectIdUsers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdUsers"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/users/{userId}
    public func getProjectsByProjectIdUsersByUserId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdUsersByUserId"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/users/{userId}/sessions
    public func getProjectsByProjectIdUsersByUserIdSessions(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdUsersByUserIdSessions"]!, path: path, headers: headers)
    }

    /// GET /projects/{projectId}/users/stats
    public func getProjectsByProjectIdUsersStats(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsByProjectIdUsersStats"]!, path: path, headers: headers)
    }

    /// GET /projects/slug-available
    public func getProjectsSlugAvailable(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getProjectsSlugAvailable"]!, query: query, headers: headers)
    }

    /// GET /quickstart/project/{projectId}
    public func getQuickstartProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getQuickstartProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /quickstart/project/{projectId}/json
    public func getQuickstartProjectByProjectIdJson(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getQuickstartProjectByProjectIdJson"]!, path: path, query: query, headers: headers)
    }

    /// GET /realtime/connections/project/{projectId}
    public func getRealtimeConnectionsProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRealtimeConnectionsProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /realtime/events/project/{projectId}
    public func getRealtimeEventsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRealtimeEventsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /realtime/stats/project/{projectId}
    public func getRealtimeStatsProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRealtimeStatsProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /realtime/status/project/{projectId}
    public func getRealtimeStatusProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRealtimeStatusProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /realtime/subscriptions/project/{projectId}
    public func getRealtimeSubscriptionsProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRealtimeSubscriptionsProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /refunds/{id}
    public func getRefundsById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRefundsById"]!, path: path, headers: headers)
    }

    /// GET /refunds/org/{orgId}
    public func getRefundsOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRefundsOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /regions
    public func getRegions(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRegions"]!, headers: headers)
    }

    /// GET /regions/all
    public func getRegionsAll(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRegionsAll"]!, headers: headers)
    }

    /// GET /regions/{key}
    public func getRegionsByKey(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRegionsByKey"]!, path: path, headers: headers)
    }

    /// GET /regions/{key}/metrics
    public func getRegionsByKeyMetrics(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRegionsByKeyMetrics"]!, path: path, query: query, headers: headers)
    }

    /// GET /regions/health
    public func getRegionsHealth(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRegionsHealth"]!, headers: headers)
    }

    /// GET /rls/policies/{projectId}
    public func getRlsPoliciesByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getRlsPoliciesByProjectId"]!, path: path, headers: headers)
    }

    /// GET /schema-engine/{projectId}/changes
    public func getSchemaEngineByProjectIdChanges(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineByProjectIdChanges"]!, path: path, query: query, headers: headers)
    }

    /// GET /schema-engine/editor-sessions/{projectId}/capabilities
    public func getSchemaEngineEditorSessionsByProjectIdCapabilities(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineEditorSessionsByProjectIdCapabilities"]!, path: path, headers: headers)
    }

    /// GET /schema-engine/introspect/{projectId}
    public func getSchemaEngineIntrospectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineIntrospectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /schema-engine/migrations/{projectId}/{migrationId}/diff
    public func getSchemaEngineMigrationsByProjectIdByMigrationIdDiff(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineMigrationsByProjectIdByMigrationIdDiff"]!, path: path, query: query, headers: headers)
    }

    /// GET /schema-engine/migrations/project/{projectId}
    public func getSchemaEngineMigrationsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineMigrationsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /schema-engine/snapshots/project/{projectId}
    public func getSchemaEngineSnapshotsProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineSnapshotsProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /schema-engine/snippets/{projectId}
    public func getSchemaEngineSnippetsByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemaEngineSnippetsByProjectId"]!, path: path, headers: headers)
    }

    /// GET /schemas/project/{projectId}
    public func getSchemasProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSchemasProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /security/audit/{projectId}
    public func getSecurityAuditByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSecurityAuditByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /security/overview/{projectId}
    public func getSecurityOverviewByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSecurityOverviewByProjectId"]!, path: path, headers: headers)
    }

    /// GET /security/variables/project/{projectId}
    public func getSecurityVariablesProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSecurityVariablesProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /services/{serviceId}
    public func getServicesByServiceId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceId"]!, path: path, headers: headers)
    }

    /// GET /services/{serviceId}/deployments/{deploymentId}/build-logs
    public func getServicesByServiceIdDeploymentsByDeploymentIdBuildLogs(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdDeploymentsByDeploymentIdBuildLogs"]!, path: path, query: query, headers: headers)
    }

    /// GET /services/{serviceId}/deployments/{deploymentId}/status
    public func getServicesByServiceIdDeploymentsByDeploymentIdStatus(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdDeploymentsByDeploymentIdStatus"]!, path: path, query: query, headers: headers)
    }

    /// GET /services/{serviceId}/domains
    public func getServicesByServiceIdDomains(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdDomains"]!, path: path, headers: headers)
    }

    /// GET /services/{serviceId}/git/connect
    public func getServicesByServiceIdGitConnect(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdGitConnect"]!, path: path, headers: headers)
    }

    /// GET /services/{serviceId}/logs
    public func getServicesByServiceIdLogs(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdLogs"]!, path: path, query: query, headers: headers)
    }

    /// GET /services/{serviceId}/status
    public func getServicesByServiceIdStatus(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesByServiceIdStatus"]!, path: path, headers: headers)
    }

    /// GET /services/project/{projectId}
    public func getServicesProjectByProjectId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesProjectByProjectId"]!, path: path, headers: headers)
    }

    /// GET /services/project/{projectId}/summary
    public func getServicesProjectByProjectIdSummary(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getServicesProjectByProjectIdSummary"]!, path: path, query: query, headers: headers)
    }

    /// GET /sso/me/paused-access
    public func getSsoMePausedAccess(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoMePausedAccess"]!, headers: headers)
    }

    /// GET /sso/org/{orgId}
    public func getSsoOrgByOrgId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgId"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/break-glass
    public func getSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/certificates
    public func getSsoOrgByOrgIdConnectionsByConnectionIdCertificates(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdCertificates"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/group-mappings
    public func getSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/require
    public func getSsoOrgByOrgIdConnectionsByConnectionIdRequire(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdRequire"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/scim/reconciliation
    public func getSsoOrgByOrgIdConnectionsByConnectionIdScimReconciliation(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdScimReconciliation"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/connections/{connectionId}/scim/tokens
    public func getSsoOrgByOrgIdConnectionsByConnectionIdScimTokens(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdConnectionsByConnectionIdScimTokens"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/outside-members
    public func getSsoOrgByOrgIdOutsideMembers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdOutsideMembers"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/outside-members/blocked
    public func getSsoOrgByOrgIdOutsideMembersBlocked(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdOutsideMembersBlocked"]!, path: path, headers: headers)
    }

    /// GET /sso/org/{orgId}/security-contact
    public func getSsoOrgByOrgIdSecurityContact(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getSsoOrgByOrgIdSecurityContact"]!, path: path, headers: headers)
    }

    /// GET /status
    public func getStatus(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatus"]!, headers: headers)
    }

    /// GET /status/atom
    public func getStatusAtom(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusAtom"]!, headers: headers)
    }

    /// GET /status/incidents
    public func getStatusIncidents(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusIncidents"]!, headers: headers)
    }

    /// GET /status/rss
    public func getStatusRss(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusRss"]!, headers: headers)
    }

    /// GET /status/subscribers/count
    public func getStatusSubscribersCount(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusSubscribersCount"]!, headers: headers)
    }

    /// GET /status/unsubscribe/{token}
    public func getStatusUnsubscribeByToken(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusUnsubscribeByToken"]!, path: path, headers: headers)
    }

    /// GET /status/uptime/{componentId}
    public func getStatusUptimeByComponentId(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStatusUptimeByComponentId"]!, path: path, headers: headers)
    }

    /// GET /storage/buckets
    public func getStorageBuckets(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStorageBuckets"]!, query: query, headers: headers)
    }

    /// GET /storage/buckets/{bucketId}/policies
    public func getStorageBucketsByBucketIdPolicies(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStorageBucketsByBucketIdPolicies"]!, path: path, headers: headers)
    }

    /// GET /storage/download
    public func getStorageDownload(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> FunctionResponse {
        try await call(Self.all["getStorageDownload"]!, query: query, headers: headers)
    }

    /// GET /storage/files/{bucketId}/metadata
    public func getStorageFilesByBucketIdMetadata(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStorageFilesByBucketIdMetadata"]!, path: path, query: query, headers: headers)
    }

    /// GET /storage/multipart/list-pending
    public func getStorageMultipartListPending(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStorageMultipartListPending"]!, headers: headers)
    }

    /// GET /storage/usage/project/{projectId}
    public func getStorageUsageProjectByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getStorageUsageProjectByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// GET /templates
    public func getTemplates(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getTemplates"]!, query: query, headers: headers)
    }

    /// GET /templates/{slug}
    public func getTemplatesBySlug(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getTemplatesBySlug"]!, path: path, query: query, headers: headers)
    }

    /// GET /templates/installs
    public func getTemplatesInstalls(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getTemplatesInstalls"]!, query: query, headers: headers)
    }

    /// GET /tenant/branding
    public func getTenantBranding(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getTenantBranding"]!, headers: headers)
    }

    /// GET /users/me
    public func getUsersMe(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getUsersMe"]!, headers: headers)
    }

    /// GET /users/me/preferences
    public func getUsersMePreferences(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getUsersMePreferences"]!, headers: headers)
    }

    /// GET /v1/data/{projectId}/{table}
    public func getV1DataByProjectIdByTable(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1DataByProjectIdByTable"]!, path: path, query: query, headers: headers)
    }

    /// GET /v1/data/{projectId}/{table}/aggregate
    public func getV1DataByProjectIdByTableAggregate(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1DataByProjectIdByTableAggregate"]!, path: path, query: query, headers: headers)
    }

    /// GET /v1/data/{projectId}/{table}/{id}
    public func getV1DataByProjectIdByTableById(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1DataByProjectIdByTableById"]!, path: path, headers: headers)
    }

    /// GET /v1/data/{projectId}/{table}/search
    public func getV1DataByProjectIdByTableSearch(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1DataByProjectIdByTableSearch"]!, path: path, query: query, headers: headers)
    }

    /// GET /v1/health
    public func getV1Health(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1Health"]!, headers: headers)
    }

    /// GET /v1/project
    public func getV1Project(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getV1Project"]!, headers: headers)
    }

    /// GET /.well-known/oauth-authorization-server
    public func getWellKnownOauthAuthorizationServer(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["getWellKnownOauthAuthorizationServer"]!, headers: headers)
    }

    /// PATCH /ai/copilot/session/{sessionId}
    public func patchAiCopilotSessionBySessionId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchAiCopilotSessionBySessionId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /auth/me
    public func patchAuthMe(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchAuthMe"]!, body: .json(body), headers: headers)
    }

    /// PATCH /billing/org/{orgId}/addons/{addonId}
    public func patchBillingOrgByOrgIdAddonsByAddonId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchBillingOrgByOrgIdAddonsByAddonId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /billing/org/{orgId}/contacts/{contactId}
    public func patchBillingOrgByOrgIdContactsByContactId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchBillingOrgByOrgIdContactsByContactId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /billing/org/{orgId}/usage-alerts/{alertId}
    public func patchBillingOrgByOrgIdUsageAlertsByAlertId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchBillingOrgByOrgIdUsageAlertsByAlertId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /database/wrappers/project/{projectId}/{wrapperId}
    public func patchDatabaseWrappersProjectByProjectIdByWrapperId(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDatabaseWrappersProjectByProjectIdByWrapperId"]!, path: path, query: query, body: .json(body), headers: headers)
    }

    /// PATCH /docs/api-endpoints/{id}
    public func patchDocsApiEndpointsById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDocsApiEndpointsById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /docs/changelog/{id}
    public func patchDocsChangelogById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDocsChangelogById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /docs/examples/{id}
    public func patchDocsExamplesById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDocsExamplesById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /docs/sdks/{id}
    public func patchDocsSdksById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDocsSdksById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /docs/v2/pages/{id}
    public func patchDocsV2PagesById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchDocsV2PagesById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /enterprise/org/{orgId}/onboarding
    public func patchEnterpriseOrgByOrgIdOnboarding(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchEnterpriseOrgByOrgIdOnboarding"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /functions/{functionId}
    public func patchFunctionsByFunctionId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchFunctionsByFunctionId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /functions/triggers/{triggerId}
    public func patchFunctionsTriggersByTriggerId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchFunctionsTriggersByTriggerId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /generated/{table}/bulk
    public func patchGeneratedByTableBulk(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchGeneratedByTableBulk"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /generated/{table}/{id}
    public func patchGeneratedByTableById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchGeneratedByTableById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /integrations/subscriptions/{id}
    public func patchIntegrationsSubscriptionsById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchIntegrationsSubscriptionsById"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /oauth/org/{orgId}/provider/{provider}
    public func patchOauthOrgByOrgIdProviderByProvider(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOauthOrgByOrgIdProviderByProvider"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}
    public func patchOrgsByOrgId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}/blueprint-defaults
    public func patchOrgsByOrgIdBlueprintDefaults(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdBlueprintDefaults"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}/data-region
    public func patchOrgsByOrgIdDataRegion(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdDataRegion"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}/members/{userId}/role
    public func patchOrgsByOrgIdMembersByUserIdRole(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdMembersByUserIdRole"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}/members/roles
    public func patchOrgsByOrgIdMembersRoles(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdMembersRoles"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /orgs/{orgId}/profile
    public func patchOrgsByOrgIdProfile(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdProfile"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /orgs/{orgId}/security
    public func patchOrgsByOrgIdSecurity(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchOrgsByOrgIdSecurity"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /projects/{projectId}
    public func patchProjectsByProjectId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /projects/{projectId}/api-keys/{keyId}
    public func patchProjectsByProjectIdApiKeysByKeyId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdApiKeysByKeyId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /projects/{projectId}/auth/settings
    public func patchProjectsByProjectIdAuthSettings(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdAuthSettings"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /projects/{projectId}/env-vars/{envVarId}
    public func patchProjectsByProjectIdEnvVarsByEnvVarId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdEnvVarsByEnvVarId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/environments/{envId}
    public func patchProjectsByProjectIdEnvironmentsByEnvId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdEnvironmentsByEnvId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/settings/addons
    public func patchProjectsByProjectIdSettingsAddons(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdSettingsAddons"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/settings/api
    public func patchProjectsByProjectIdSettingsApi(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdSettingsApi"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/settings/compute
    public func patchProjectsByProjectIdSettingsCompute(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdSettingsCompute"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/settings/jwt
    public func patchProjectsByProjectIdSettingsJwt(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdSettingsJwt"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /projects/{projectId}/storage/settings
    public func patchProjectsByProjectIdStorageSettings(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdStorageSettings"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /projects/{projectId}/users/{userId}
    public func patchProjectsByProjectIdUsersByUserId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchProjectsByProjectIdUsersByUserId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /regions/{key}
    public func patchRegionsByKey(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchRegionsByKey"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /rls/policies/{policyId}
    public func patchRlsPoliciesByPolicyId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchRlsPoliciesByPolicyId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /schema-engine/snippets/{projectId}/{snippetId}
    public func patchSchemaEngineSnippetsByProjectIdBySnippetId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchSchemaEngineSnippetsByProjectIdBySnippetId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /services/{serviceId}/hostname
    public func patchServicesByServiceIdHostname(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchServicesByServiceIdHostname"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /services/{serviceId}/runtime-class
    public func patchServicesByServiceIdRuntimeClass(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchServicesByServiceIdRuntimeClass"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /sso/org/{orgId}/connections/{connectionId}
    public func patchSsoOrgByOrgIdConnectionsByConnectionId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchSsoOrgByOrgIdConnectionsByConnectionId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /storage/files/{bucketId}/metadata
    public func patchStorageFilesByBucketIdMetadata(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchStorageFilesByBucketIdMetadata"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /users/me
    public func patchUsersMe(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchUsersMe"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /users/me/preferences
    public func patchUsersMePreferences(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchUsersMePreferences"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// PATCH /v1/data/{projectId}/{table}/bulk
    public func patchV1DataByProjectIdByTableBulk(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchV1DataByProjectIdByTableBulk"]!, path: path, body: .json(body), headers: headers)
    }

    /// PATCH /v1/data/{projectId}/{table}/{id}
    public func patchV1DataByProjectIdByTableById(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["patchV1DataByProjectIdByTableById"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/alert-rule-suggestion
    public func postAiCopilotAlertRuleSuggestion(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotAlertRuleSuggestion"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/alert-rule-suggestion/estimate
    public func postAiCopilotAlertRuleSuggestionEstimate(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotAlertRuleSuggestionEstimate"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/chat
    public func postAiCopilotChat(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotChat"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/chat/stream
    public func postAiCopilotChatStream(headers: [String: String] = [:]) async throws -> FunctionResponse {
        try await call(Self.all["postAiCopilotChatStream"]!, headers: headers)
    }

    /// POST /ai/copilot/execute
    public func postAiCopilotExecute(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExecute"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/execution/{executionId}/pause
    public func postAiCopilotExecutionByExecutionIdPause(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExecutionByExecutionIdPause"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/execution/{executionId}/resume
    public func postAiCopilotExecutionByExecutionIdResume(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExecutionByExecutionIdResume"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/execution/{executionId}/rollback
    public func postAiCopilotExecutionByExecutionIdRollback(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExecutionByExecutionIdRollback"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/export/{versionId}
    public func postAiCopilotExportByVersionId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExportByVersionId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/export/github
    public func postAiCopilotExportGithub(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotExportGithub"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/feedback
    public func postAiCopilotFeedback(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotFeedback"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/generation/{manifestId}/cancel
    public func postAiCopilotGenerationByManifestIdCancel(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGenerationByManifestIdCancel"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/branch
    public func postAiCopilotGitBranch(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitBranch"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/clone
    public func postAiCopilotGitClone(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitClone"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/commit
    public func postAiCopilotGitCommit(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitCommit"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/init
    public func postAiCopilotGitInit(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitInit"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/pull
    public func postAiCopilotGitPull(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitPull"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/push
    public func postAiCopilotGitPush(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitPush"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/git/write
    public func postAiCopilotGitWrite(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotGitWrite"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/job
    public func postAiCopilotJob(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotJob"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/job/{jobId}/cancel
    public func postAiCopilotJobByJobIdCancel(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotJobByJobIdCancel"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/job/{jobId}/retry
    public func postAiCopilotJobByJobIdRetry(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotJobByJobIdRetry"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/manifest/{manifestId}/pause
    public func postAiCopilotManifestByManifestIdPause(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotManifestByManifestIdPause"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /ai/copilot/memories/{memoryId}/promote
    public func postAiCopilotMemoriesByMemoryIdPromote(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotMemoriesByMemoryIdPromote"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/rate/{messageId}
    public func postAiCopilotRateByMessageId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotRateByMessageId"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/artifact-body
    public func postAiCopilotSessionBySessionIdArtifactBody(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdArtifactBody"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/brainstorm/stop
    public func postAiCopilotSessionBySessionIdBrainstormStop(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdBrainstormStop"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/env
    public func postAiCopilotSessionBySessionIdWorkspaceEnv(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceEnv"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/fix
    public func postAiCopilotSessionBySessionIdWorkspaceFix(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceFix"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/heartbeat
    public func postAiCopilotSessionBySessionIdWorkspaceHeartbeat(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceHeartbeat"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/install
    public func postAiCopilotSessionBySessionIdWorkspaceInstall(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceInstall"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/prepare
    public func postAiCopilotSessionBySessionIdWorkspacePrepare(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspacePrepare"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/release
    public func postAiCopilotSessionBySessionIdWorkspaceRelease(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceRelease"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/repairs/apply
    public func postAiCopilotSessionBySessionIdWorkspaceRepairsApply(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceRepairsApply"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/restore
    public func postAiCopilotSessionBySessionIdWorkspaceRestore(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceRestore"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/run
    public func postAiCopilotSessionBySessionIdWorkspaceRun(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceRun"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/session/{sessionId}/workspace/stop
    public func postAiCopilotSessionBySessionIdWorkspaceStop(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessionBySessionIdWorkspaceStop"]!, path: path, headers: headers)
    }

    /// POST /ai/copilot/sessions
    public func postAiCopilotSessions(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotSessions"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/table-filters
    public func postAiCopilotTableFilters(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotTableFilters"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/table-filters/estimate
    public func postAiCopilotTableFiltersEstimate(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotTableFiltersEstimate"]!, body: .json(body), headers: headers)
    }

    /// POST /ai/copilot/training-consent/{sessionId}
    public func postAiCopilotTrainingConsentBySessionId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAiCopilotTrainingConsentBySessionId"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /alert-rules/project/{projectId}
    public func postAlertRulesProjectByProjectId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAlertRulesProjectByProjectId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/account-setup
    public func postAuthAccountSetup(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthAccountSetup"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/account-setup/check
    public func postAuthAccountSetupCheck(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthAccountSetupCheck"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/cli/authorize
    public func postAuthCliAuthorize(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliAuthorize"]!, headers: headers)
    }

    /// POST /auth/cli/callback
    public func postAuthCliCallback(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliCallback"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/cli/deny
    public func postAuthCliDeny(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliDeny"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/cli/login
    public func postAuthCliLogin(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliLogin"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/cli/requests/check
    public func postAuthCliRequestsCheck(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliRequestsCheck"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/cli/token
    public func postAuthCliToken(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthCliToken"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/forgot-password
    public func postAuthForgotPassword(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthForgotPassword"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/login
    public func postAuthLogin(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthLogin"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/logout
    public func postAuthLogout(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthLogout"]!, headers: headers)
    }

    /// POST /auth/logout-all
    public func postAuthLogoutAll(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthLogoutAll"]!, headers: headers)
    }

    /// POST /auth/me/linked-accounts/{provider}/start
    public func postAuthMeLinkedAccountsByProviderStart(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMeLinkedAccountsByProviderStart"]!, path: path, headers: headers)
    }

    /// POST /auth/mfa/disable
    public func postAuthMfaDisable(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMfaDisable"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/mfa/enroll-confirm
    public func postAuthMfaEnrollConfirm(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMfaEnrollConfirm"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/mfa/enroll-start
    public func postAuthMfaEnrollStart(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMfaEnrollStart"]!, headers: headers)
    }

    /// POST /auth/mfa/regenerate-codes
    public func postAuthMfaRegenerateCodes(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMfaRegenerateCodes"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/mfa/verify
    public func postAuthMfaVerify(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthMfaVerify"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /auth/reauthenticate
    public func postAuthReauthenticate(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthReauthenticate"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/refresh
    public func postAuthRefresh(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthRefresh"]!, headers: headers)
    }

    /// POST /auth/reset-password
    public func postAuthResetPassword(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthResetPassword"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/reset-password/check
    public func postAuthResetPasswordCheck(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthResetPasswordCheck"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/session/device
    public func postAuthSessionDevice(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthSessionDevice"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/session/token
    public func postAuthSessionToken(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthSessionToken"]!, headers: headers)
    }

    /// POST /auth/signup
    public func postAuthSignup(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthSignup"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/sso/restart
    public func postAuthSsoRestart(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthSsoRestart"]!, headers: headers)
    }

    /// POST /auth/tenant/handoff
    public func postAuthTenantHandoff(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantHandoff"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/tenant/login
    public func postAuthTenantLogin(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantLogin"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/tenant/logout
    public func postAuthTenantLogout(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantLogout"]!, headers: headers)
    }

    /// POST /auth/tenant/mfa/verify
    public func postAuthTenantMfaVerify(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantMfaVerify"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/tenant/refresh
    public func postAuthTenantRefresh(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantRefresh"]!, headers: headers)
    }

    /// POST /auth/tenant/sso/start
    public func postAuthTenantSsoStart(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthTenantSsoStart"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/verify-email/confirm
    public func postAuthVerifyEmailConfirm(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthVerifyEmailConfirm"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/verify-email/resend
    public func postAuthVerifyEmailResend(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthVerifyEmailResend"]!, body: .json(body), headers: headers)
    }

    /// POST /auth/verify-email/send
    public func postAuthVerifyEmailSend(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postAuthVerifyEmailSend"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /billing/checkout
    public func postBillingCheckout(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingCheckout"]!, body: .json(body), headers: headers)
    }

    /// POST /billing/enterprise/inquiry
    public func postBillingEnterpriseInquiry(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingEnterpriseInquiry"]!, body: .json(body), headers: headers)
    }

    /// POST /billing/hosting/checkout
    public func postBillingHostingCheckout(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingHostingCheckout"]!, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/addons
    public func postBillingOrgByOrgIdAddons(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdAddons"]!, path: path, headers: headers)
    }

    /// POST /billing/org/{orgId}/addons/{addonId}/preview
    public func postBillingOrgByOrgIdAddonsByAddonIdPreview(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdAddonsByAddonIdPreview"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /billing/org/{orgId}/addons/preview
    public func postBillingOrgByOrgIdAddonsPreview(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdAddonsPreview"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /billing/org/{orgId}/cancel
    public func postBillingOrgByOrgIdCancel(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdCancel"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/card-check/confirm
    public func postBillingOrgByOrgIdCardCheckConfirm(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdCardCheckConfirm"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/card-check/session
    public func postBillingOrgByOrgIdCardCheckSession(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdCardCheckSession"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/change-plan
    public func postBillingOrgByOrgIdChangePlan(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdChangePlan"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/change-plan/preview
    public func postBillingOrgByOrgIdChangePlanPreview(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdChangePlanPreview"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/contacts
    public func postBillingOrgByOrgIdContacts(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdContacts"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/credits/purchase
    public func postBillingOrgByOrgIdCreditsPurchase(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdCreditsPurchase"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/org/{orgId}/pause
    public func postBillingOrgByOrgIdPause(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdPause"]!, path: path, headers: headers)
    }

    /// POST /billing/org/{orgId}/portal
    public func postBillingOrgByOrgIdPortal(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdPortal"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /billing/org/{orgId}/reactivate
    public func postBillingOrgByOrgIdReactivate(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdReactivate"]!, path: path, headers: headers)
    }

    /// POST /billing/org/{orgId}/resume
    public func postBillingOrgByOrgIdResume(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdResume"]!, path: path, headers: headers)
    }

    /// POST /billing/org/{orgId}/usage-alerts
    public func postBillingOrgByOrgIdUsageAlerts(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingOrgByOrgIdUsageAlerts"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /billing/promo-codes/validate
    public func postBillingPromoCodesValidate(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingPromoCodesValidate"]!, body: .json(body), headers: headers)
    }

    /// POST /billing/redeem-promo
    public func postBillingRedeemPromo(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingRedeemPromo"]!, body: .json(body), headers: headers)
    }

    /// POST /billing/webhook
    public func postBillingWebhook(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBillingWebhook"]!, headers: headers)
    }

    /// POST /buckets/{bucketId}/signed-url
    public func postBucketsByBucketIdSignedUrl(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBucketsByBucketIdSignedUrl"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /buckets/{bucketId}/upload
    public func postBucketsByBucketIdUpload(path: [String: String], query: [String: JSONValue] = [:], body: Data, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBucketsByBucketIdUpload"]!, path: path, query: query, body: .binary(body), headers: headers)
    }

    /// POST /buckets/{bucketId}/upload-url
    public func postBucketsByBucketIdUploadUrl(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postBucketsByBucketIdUploadUrl"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /contact
    public func postContact(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postContact"]!, body: .json(body), headers: headers)
    }

    /// POST /database/connector/{projectId}/query
    public func postDatabaseConnectorByProjectIdQuery(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDatabaseConnectorByProjectIdQuery"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /database/connector/{projectId}/test
    public func postDatabaseConnectorByProjectIdTest(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDatabaseConnectorByProjectIdTest"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /database/extensions/project/{projectId}/install
    public func postDatabaseExtensionsProjectByProjectIdInstall(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDatabaseExtensionsProjectByProjectIdInstall"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /database/wrappers/project/{projectId}/install
    public func postDatabaseWrappersProjectByProjectIdInstall(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDatabaseWrappersProjectByProjectIdInstall"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /deployments/{deploymentId}/rollback
    public func postDeploymentsByDeploymentIdRollback(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDeploymentsByDeploymentIdRollback"]!, path: path, headers: headers)
    }

    /// POST /deployments/promote
    public func postDeploymentsPromote(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDeploymentsPromote"]!, body: .json(body), headers: headers)
    }

    /// POST /deployments/tokens
    public func postDeploymentsTokens(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDeploymentsTokens"]!, body: .json(body), headers: headers)
    }

    /// POST /deployments/tokens/{tokenId}/revoke
    public func postDeploymentsTokensByTokenIdRevoke(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDeploymentsTokensByTokenIdRevoke"]!, path: path, headers: headers)
    }

    /// POST /deployments/trigger
    public func postDeploymentsTrigger(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDeploymentsTrigger"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /docs/api-endpoints
    public func postDocsApiEndpoints(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsApiEndpoints"]!, body: .json(body), headers: headers)
    }

    /// POST /docs/changelog
    public func postDocsChangelog(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsChangelog"]!, body: .json(body), headers: headers)
    }

    /// POST /docs/examples
    public func postDocsExamples(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsExamples"]!, body: .json(body), headers: headers)
    }

    /// POST /docs/feedback
    public func postDocsFeedback(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsFeedback"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /docs/sdk-examples
    public func postDocsSdkExamples(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsSdkExamples"]!, body: .json(body), headers: headers)
    }

    /// POST /docs/sdks
    public func postDocsSdks(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsSdks"]!, body: .json(body), headers: headers)
    }

    /// POST /docs/search-click
    public func postDocsSearchClick(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsSearchClick"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /docs/v2/pages
    public func postDocsV2Pages(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postDocsV2Pages"]!, body: .json(body), headers: headers)
    }

    /// POST /enterprise/contracts
    public func postEnterpriseContracts(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseContracts"]!, body: .json(body), headers: headers)
    }

    /// POST /enterprise/contracts/{contractId}/invoice
    public func postEnterpriseContractsByContractIdInvoice(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseContractsByContractIdInvoice"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /enterprise/inquire
    public func postEnterpriseInquire(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseInquire"]!, body: .json(body), headers: headers)
    }

    /// POST /enterprise/invoices/{invoiceId}/paid
    public func postEnterpriseInvoicesByInvoiceIdPaid(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseInvoicesByInvoiceIdPaid"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /enterprise/invoices/{invoiceId}/send
    public func postEnterpriseInvoicesByInvoiceIdSend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseInvoicesByInvoiceIdSend"]!, path: path, headers: headers)
    }

    /// POST /enterprise/quotes/{quoteId}/accept
    public func postEnterpriseQuotesByQuoteIdAccept(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEnterpriseQuotesByQuoteIdAccept"]!, path: path, headers: headers)
    }

    /// POST /entitlements/org/{orgId}/check
    public func postEntitlementsOrgByOrgIdCheck(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postEntitlementsOrgByOrgIdCheck"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /flags
    public func postFlags(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postFlags"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /functions
    public func postFunctions(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postFunctions"]!, body: .json(body), headers: headers)
    }

    /// POST /functions/{functionIdOrName}/invoke
    public func postFunctionsByFunctionIdOrNameInvoke(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postFunctionsByFunctionIdOrNameInvoke"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /functions/{functionId}/triggers
    public func postFunctionsByFunctionIdTriggers(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postFunctionsByFunctionIdTriggers"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /functions/secrets
    public func postFunctionsSecrets(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postFunctionsSecrets"]!, body: .json(body), headers: headers)
    }

    /// POST /generated/{table}
    public func postGeneratedByTable(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postGeneratedByTable"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /generated/{table}/bulk
    public func postGeneratedByTableBulk(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postGeneratedByTableBulk"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /generated/{table}/query
    public func postGeneratedByTableQuery(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postGeneratedByTableQuery"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /incidents
    public func postIncidents(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIncidents"]!, body: .json(body), headers: headers)
    }

    /// POST /incidents/bulk
    public func postIncidentsBulk(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIncidentsBulk"]!, body: .json(body), headers: headers)
    }

    /// POST /incidents/{incidentId}/ack
    public func postIncidentsByIncidentIdAck(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIncidentsByIncidentIdAck"]!, path: path, headers: headers)
    }

    /// POST /incidents/{incidentId}/resolve
    public func postIncidentsByIncidentIdResolve(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIncidentsByIncidentIdResolve"]!, path: path, headers: headers)
    }

    /// POST /infrastructure/poll-status
    public func postInfrastructurePollStatus(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postInfrastructurePollStatus"]!, headers: headers)
    }

    /// POST /integrations/deliveries/{deliveryId}/retry
    public func postIntegrationsDeliveriesByDeliveryIdRetry(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIntegrationsDeliveriesByDeliveryIdRetry"]!, path: path, query: query, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /integrations/subscriptions
    public func postIntegrationsSubscriptions(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIntegrationsSubscriptions"]!, body: .json(body), headers: headers)
    }

    /// POST /integrations/subscriptions/{id}/test
    public func postIntegrationsSubscriptionsByIdTest(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postIntegrationsSubscriptionsByIdTest"]!, path: path, headers: headers)
    }

    /// POST /mcp/audit
    public func postMcpAudit(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpAudit"]!, body: .json(body), headers: headers)
    }

    /// POST /mcp/oauth/register
    public func postMcpOauthRegister(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpOauthRegister"]!, body: .json(body), headers: headers)
    }

    /// POST /mcp/oauth/requests/{requestId}/approve
    public func postMcpOauthRequestsByRequestIdApprove(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpOauthRequestsByRequestIdApprove"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /mcp/oauth/requests/{requestId}/deny
    public func postMcpOauthRequestsByRequestIdDeny(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpOauthRequestsByRequestIdDeny"]!, path: path, headers: headers)
    }

    /// POST /mcp/oauth/revoke
    public func postMcpOauthRevoke(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpOauthRevoke"]!, body: .json(body), headers: headers)
    }

    /// POST /mcp/oauth/token
    public func postMcpOauthToken(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMcpOauthToken"]!, body: .json(body), headers: headers)
    }

    /// POST /me/early/welcome-seen
    public func postMeEarlyWelcomeSeen(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMeEarlyWelcomeSeen"]!, headers: headers)
    }

    /// POST /mongodb/{collection}/aggregate
    public func postMongodbByCollectionAggregate(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionAggregate"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/aggregate/cursor
    public func postMongodbByCollectionAggregateCursor(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionAggregateCursor"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/bulkWrite
    public func postMongodbByCollectionBulkWrite(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionBulkWrite"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/count
    public func postMongodbByCollectionCount(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionCount"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/cursor/{cursorId}/close
    public func postMongodbByCollectionCursorByCursorIdClose(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionCursorByCursorIdClose"]!, path: path, headers: headers)
    }

    /// POST /mongodb/{collection}/cursor/{cursorId}/next
    public func postMongodbByCollectionCursorByCursorIdNext(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionCursorByCursorIdNext"]!, path: path, headers: headers)
    }

    /// POST /mongodb/{collection}/deleteMany
    public func postMongodbByCollectionDeleteMany(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionDeleteMany"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/deleteOne
    public func postMongodbByCollectionDeleteOne(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionDeleteOne"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/distinct
    public func postMongodbByCollectionDistinct(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionDistinct"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/find
    public func postMongodbByCollectionFind(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFind"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/find/cursor
    public func postMongodbByCollectionFindCursor(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFindCursor"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/findOne
    public func postMongodbByCollectionFindOne(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFindOne"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/findOneAndDelete
    public func postMongodbByCollectionFindOneAndDelete(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFindOneAndDelete"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/findOneAndReplace
    public func postMongodbByCollectionFindOneAndReplace(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFindOneAndReplace"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/findOneAndUpdate
    public func postMongodbByCollectionFindOneAndUpdate(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionFindOneAndUpdate"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/indexes
    public func postMongodbByCollectionIndexes(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionIndexes"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/insertMany
    public func postMongodbByCollectionInsertMany(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionInsertMany"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/insertOne
    public func postMongodbByCollectionInsertOne(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionInsertOne"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/replaceOne
    public func postMongodbByCollectionReplaceOne(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionReplaceOne"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/updateMany
    public func postMongodbByCollectionUpdateMany(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionUpdateMany"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/{collection}/updateOne
    public func postMongodbByCollectionUpdateOne(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbByCollectionUpdateOne"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/collections
    public func postMongodbCollections(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbCollections"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/collections/{name}/rename
    public func postMongodbCollectionsByNameRename(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbCollectionsByNameRename"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /mongodb/command
    public func postMongodbCommand(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postMongodbCommand"]!, headers: headers)
    }

    /// POST /oauth/callback
    public func postOauthCallback(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOauthCallback"]!, body: .json(body), headers: headers)
    }

    /// POST /oauth/org/{orgId}/configure
    public func postOauthOrgByOrgIdConfigure(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOauthOrgByOrgIdConfigure"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /oauth/org/{orgId}/provider/{provider}/refresh
    public func postOauthOrgByOrgIdProviderByProviderRefresh(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOauthOrgByOrgIdProviderByProviderRefresh"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /onboarding/org/{orgId}/auto-setup
    public func postOnboardingOrgByOrgIdAutoSetup(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOnboardingOrgByOrgIdAutoSetup"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /onboarding/org/{orgId}/complete-step
    public func postOnboardingOrgByOrgIdCompleteStep(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOnboardingOrgByOrgIdCompleteStep"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs
    public func postOrgs(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgs"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/{orgId}/change-requests
    public func postOrgsByOrgIdChangeRequests(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdChangeRequests"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/{orgId}/invites/{inviteId}/resend
    public func postOrgsByOrgIdInvitesByInviteIdResend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdInvitesByInviteIdResend"]!, path: path, headers: headers)
    }

    /// POST /orgs/{orgId}/leave-requests
    public func postOrgsByOrgIdLeaveRequests(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdLeaveRequests"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /orgs/{orgId}/leave-requests/{requestId}/approve
    public func postOrgsByOrgIdLeaveRequestsByRequestIdApprove(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdLeaveRequestsByRequestIdApprove"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /orgs/{orgId}/leave-requests/{requestId}/decline
    public func postOrgsByOrgIdLeaveRequestsByRequestIdDecline(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdLeaveRequestsByRequestIdDecline"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /orgs/{orgId}/members/invite
    public func postOrgsByOrgIdMembersInvite(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdMembersInvite"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/{orgId}/support/tickets
    public func postOrgsByOrgIdSupportTickets(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdSupportTickets"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /orgs/{orgId}/support/tickets/{number}/messages
    public func postOrgsByOrgIdSupportTicketsByNumberMessages(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdSupportTicketsByNumberMessages"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /orgs/{orgId}/support/tickets/{number}/reopen
    public func postOrgsByOrgIdSupportTicketsByNumberReopen(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdSupportTicketsByNumberReopen"]!, path: path, headers: headers)
    }

    /// POST /orgs/{orgId}/support/tickets/{number}/resolve
    public func postOrgsByOrgIdSupportTicketsByNumberResolve(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdSupportTicketsByNumberResolve"]!, path: path, headers: headers)
    }

    /// POST /orgs/{orgId}/transfer
    public func postOrgsByOrgIdTransfer(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdTransfer"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/{orgId}/transfers/{id}/resend
    public func postOrgsByOrgIdTransfersByIdResend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsByOrgIdTransfersByIdResend"]!, path: path, headers: headers)
    }

    /// POST /orgs/first
    public func postOrgsFirst(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsFirst"]!, headers: headers)
    }

    /// POST /orgs/invites/accept
    public func postOrgsInvitesAccept(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsInvitesAccept"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/invites/decline
    public func postOrgsInvitesDecline(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsInvitesDecline"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/transfers/accept
    public func postOrgsTransfersAccept(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsTransfersAccept"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /orgs/transfers/decline
    public func postOrgsTransfersDecline(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postOrgsTransfersDecline"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /plans/apply
    public func postPlansApply(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postPlansApply"]!, body: .json(body), headers: headers)
    }

    /// POST /plans/save
    public func postPlansSave(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postPlansSave"]!, body: .json(body), headers: headers)
    }

    /// POST /projects
    public func postProjects(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjects"]!, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/api-keys
    public func postProjectsByProjectIdApiKeys(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdApiKeys"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/api-keys/{keyId}/reveal
    public func postProjectsByProjectIdApiKeysByKeyIdReveal(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdApiKeysByKeyIdReveal"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/api-keys/{keyId}/revoke
    public func postProjectsByProjectIdApiKeysByKeyIdRevoke(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdApiKeysByKeyIdRevoke"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/api-keys/{keyId}/rotate
    public func postProjectsByProjectIdApiKeysByKeyIdRotate(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdApiKeysByKeyIdRotate"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/api-keys/split
    public func postProjectsByProjectIdApiKeysSplit(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdApiKeysSplit"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/auth/forgot-password
    public func postProjectsByProjectIdAuthForgotPassword(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthForgotPassword"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/login
    public func postProjectsByProjectIdAuthLogin(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthLogin"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/logout
    public func postProjectsByProjectIdAuthLogout(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthLogout"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/auth/magic/send
    public func postProjectsByProjectIdAuthMagicSend(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMagicSend"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/mfa/disable
    public func postProjectsByProjectIdAuthMfaDisable(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMfaDisable"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/mfa/enroll-confirm
    public func postProjectsByProjectIdAuthMfaEnrollConfirm(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMfaEnrollConfirm"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/mfa/enroll-start
    public func postProjectsByProjectIdAuthMfaEnrollStart(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMfaEnrollStart"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/auth/mfa/regenerate-codes
    public func postProjectsByProjectIdAuthMfaRegenerateCodes(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMfaRegenerateCodes"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/mfa/verify
    public func postProjectsByProjectIdAuthMfaVerify(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthMfaVerify"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/oauth/{provider}/start
    public func postProjectsByProjectIdAuthOauthByProviderStart(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthOauthByProviderStart"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/oauth/token
    public func postProjectsByProjectIdAuthOauthToken(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthOauthToken"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/refresh
    public func postProjectsByProjectIdAuthRefresh(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthRefresh"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/auth/reset-password
    public func postProjectsByProjectIdAuthResetPassword(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthResetPassword"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/signup
    public func postProjectsByProjectIdAuthSignup(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthSignup"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/sync-users
    public func postProjectsByProjectIdAuthSyncUsers(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthSyncUsers"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/auth/verify-email/confirm
    public func postProjectsByProjectIdAuthVerifyEmailConfirm(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthVerifyEmailConfirm"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/auth/verify-email/send
    public func postProjectsByProjectIdAuthVerifyEmailSend(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdAuthVerifyEmailSend"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/branches
    public func postProjectsByProjectIdBranches(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdBranches"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/database/dedicated
    public func postProjectsByProjectIdDatabaseDedicated(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdDatabaseDedicated"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/database/dedicated/restart
    public func postProjectsByProjectIdDatabaseDedicatedRestart(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdDatabaseDedicatedRestart"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/db/reset
    public func postProjectsByProjectIdDbReset(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdDbReset"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/env-vars
    public func postProjectsByProjectIdEnvVars(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvVars"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/environments
    public func postProjectsByProjectIdEnvironments(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironments"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/environments/backfill-urls
    public func postProjectsByProjectIdEnvironmentsBackfillUrls(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsBackfillUrls"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/environments/bootstrap
    public func postProjectsByProjectIdEnvironmentsBootstrap(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsBootstrap"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/environments/{envId}/domains/{domainId}/verify
    public func postProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainIdVerify(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsByEnvIdDomainsByDomainIdVerify"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/environments/{envId}/provision-ssl
    public func postProjectsByProjectIdEnvironmentsByEnvIdProvisionSsl(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsByEnvIdProvisionSsl"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/environments/{envId}/verify-cname
    public func postProjectsByProjectIdEnvironmentsByEnvIdVerifyCname(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsByEnvIdVerifyCname"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/environments/{envId}/verify-domain
    public func postProjectsByProjectIdEnvironmentsByEnvIdVerifyDomain(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdEnvironmentsByEnvIdVerifyDomain"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/github/branch
    public func postProjectsByProjectIdGithubBranch(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdGithubBranch"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/github/connect
    public func postProjectsByProjectIdGithubConnect(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdGithubConnect"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/github/pull
    public func postProjectsByProjectIdGithubPull(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdGithubPull"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/github/push
    public func postProjectsByProjectIdGithubPush(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdGithubPush"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/migrate-now
    public func postProjectsByProjectIdInfrastructureByInstanceIdMigrateNow(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdMigrateNow"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/replica
    public func postProjectsByProjectIdInfrastructureByInstanceIdReplica(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdReplica"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/replica-preview
    public func postProjectsByProjectIdInfrastructureByInstanceIdReplicaPreview(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdReplicaPreview"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/resize
    public func postProjectsByProjectIdInfrastructureByInstanceIdResize(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdResize"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/resize-custom
    public func postProjectsByProjectIdInfrastructureByInstanceIdResizeCustom(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdResizeCustom"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/start
    public func postProjectsByProjectIdInfrastructureByInstanceIdStart(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdStart"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/stop
    public func postProjectsByProjectIdInfrastructureByInstanceIdStop(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdStop"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/{instanceId}/switch
    public func postProjectsByProjectIdInfrastructureByInstanceIdSwitch(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureByInstanceIdSwitch"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/included/retry
    public func postProjectsByProjectIdInfrastructureIncludedRetry(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureIncludedRetry"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/migration/retry
    public func postProjectsByProjectIdInfrastructureMigrationRetry(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureMigrationRetry"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/migration/rollback
    public func postProjectsByProjectIdInfrastructureMigrationRollback(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureMigrationRollback"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/provision
    public func postProjectsByProjectIdInfrastructureProvision(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureProvision"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/provision-custom
    public func postProjectsByProjectIdInfrastructureProvisionCustom(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureProvisionCustom"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/provision-preview
    public func postProjectsByProjectIdInfrastructureProvisionPreview(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureProvisionPreview"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/infrastructure/restores/preview
    public func postProjectsByProjectIdInfrastructureRestoresPreview(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdInfrastructureRestoresPreview"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/members
    public func postProjectsByProjectIdMembers(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdMembers"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/promotions
    public func postProjectsByProjectIdPromotions(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdPromotions"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/region
    public func postProjectsByProjectIdRegion(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdRegion"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/settings/jwt/rotate
    public func postProjectsByProjectIdSettingsJwtRotate(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdSettingsJwtRotate"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/users
    public func postProjectsByProjectIdUsers(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdUsers"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/users/{userId}/ban
    public func postProjectsByProjectIdUsersByUserIdBan(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdUsersByUserIdBan"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /projects/{projectId}/users/{userId}/send-magic-link
    public func postProjectsByProjectIdUsersByUserIdSendMagicLink(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdUsersByUserIdSendMagicLink"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /projects/{projectId}/users/{userId}/sessions/revoke-all
    public func postProjectsByProjectIdUsersByUserIdSessionsRevokeAll(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdUsersByUserIdSessionsRevokeAll"]!, path: path, headers: headers)
    }

    /// POST /projects/{projectId}/users/{userId}/unban
    public func postProjectsByProjectIdUsersByUserIdUnban(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postProjectsByProjectIdUsersByUserIdUnban"]!, path: path, headers: headers)
    }

    /// POST /realtime/console-token
    public func postRealtimeConsoleToken(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRealtimeConsoleToken"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /realtime/enable-all
    public func postRealtimeEnableAll(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRealtimeEnableAll"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /realtime/install
    public func postRealtimeInstall(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRealtimeInstall"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /realtime/token
    public func postRealtimeToken(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRealtimeToken"]!, headers: headers)
    }

    /// POST /realtime/uninstall
    public func postRealtimeUninstall(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRealtimeUninstall"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /regions
    public func postRegions(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRegions"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /regions/health/check
    public func postRegionsHealthCheck(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRegionsHealthCheck"]!, headers: headers)
    }

    /// POST /rls/policies/{policyId}/toggle
    public func postRlsPoliciesByPolicyIdToggle(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRlsPoliciesByPolicyIdToggle"]!, path: path, headers: headers)
    }

    /// POST /rls/policies/{projectId}
    public func postRlsPoliciesByProjectId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postRlsPoliciesByProjectId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /schema-engine/analyze/{projectId}
    public func postSchemaEngineAnalyzeByProjectId(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineAnalyzeByProjectId"]!, path: path, query: query, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/apply
    public func postSchemaEngineApply(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineApply"]!, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/editor-sessions/{projectId}
    public func postSchemaEngineEditorSessionsByProjectId(path: [String: String], query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineEditorSessionsByProjectId"]!, path: path, query: query, headers: headers)
    }

    /// POST /schema-engine/editor-sessions/{projectId}/close
    public func postSchemaEngineEditorSessionsByProjectIdClose(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineEditorSessionsByProjectIdClose"]!, path: path, query: query, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/migrations/{projectId}/{migrationId}/rollback
    public func postSchemaEngineMigrationsByProjectIdByMigrationIdRollback(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineMigrationsByProjectIdByMigrationIdRollback"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /schema-engine/preview
    public func postSchemaEnginePreview(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEnginePreview"]!, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/push/{projectId}
    public func postSchemaEnginePushByProjectId(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEnginePushByProjectId"]!, path: path, query: query, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/query/{projectId}
    public func postSchemaEngineQueryByProjectId(path: [String: String], query: [String: JSONValue] = [:], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineQueryByProjectId"]!, path: path, query: query, body: .json(body), headers: headers)
    }

    /// POST /schema-engine/snippets/{projectId}
    public func postSchemaEngineSnippetsByProjectId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemaEngineSnippetsByProjectId"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /schemas
    public func postSchemas(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSchemas"]!, body: .json(body), headers: headers)
    }

    /// POST /services
    public func postServices(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServices"]!, body: .json(body), headers: headers)
    }

    /// POST /services/{serviceId}/deploy
    public func postServicesByServiceIdDeploy(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdDeploy"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /services/{serviceId}/domains
    public func postServicesByServiceIdDomains(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdDomains"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /services/{serviceId}/domains/{domainId}/verify
    public func postServicesByServiceIdDomainsByDomainIdVerify(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdDomainsByDomainIdVerify"]!, path: path, headers: headers)
    }

    /// POST /services/{serviceId}/git/connect
    public func postServicesByServiceIdGitConnect(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdGitConnect"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /services/{serviceId}/promote
    public func postServicesByServiceIdPromote(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdPromote"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /services/{serviceId}/rollback
    public func postServicesByServiceIdRollback(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdRollback"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /services/{serviceId}/stop
    public func postServicesByServiceIdStop(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postServicesByServiceIdStop"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/configure
    public func postSsoOrgByOrgIdConfigure(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConfigure"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/certificates
    public func postSsoOrgByOrgIdConnectionsByConnectionIdCertificates(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdCertificates"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/certificates/{certId}/promote
    public func postSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertIdPromote(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdCertificatesByCertIdPromote"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/disable
    public func postSsoOrgByOrgIdConnectionsByConnectionIdDisable(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdDisable"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/enable
    public func postSsoOrgByOrgIdConnectionsByConnectionIdEnable(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdEnable"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/metadata/import
    public func postSsoOrgByOrgIdConnectionsByConnectionIdMetadataImport(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdMetadataImport"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/release-account
    public func postSsoOrgByOrgIdConnectionsByConnectionIdReleaseAccount(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdReleaseAccount"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/scim/tokens
    public func postSsoOrgByOrgIdConnectionsByConnectionIdScimTokens(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdScimTokens"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/test
    public func postSsoOrgByOrgIdConnectionsByConnectionIdTest(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdTest"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/connections/{connectionId}/verify-domain
    public func postSsoOrgByOrgIdConnectionsByConnectionIdVerifyDomain(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdConnectionsByConnectionIdVerifyDomain"]!, path: path, headers: headers)
    }

    /// POST /sso/org/{orgId}/outside-members/blocked/{userId}/restore
    public func postSsoOrgByOrgIdOutsideMembersBlockedByUserIdRestore(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postSsoOrgByOrgIdOutsideMembersBlockedByUserIdRestore"]!, path: path, headers: headers)
    }

    /// POST /status/subscribe
    public func postStatusSubscribe(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStatusSubscribe"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/buckets
    public func postStorageBuckets(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageBuckets"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/buckets/{bucketId}/policies
    public func postStorageBucketsByBucketIdPolicies(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageBucketsByBucketIdPolicies"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/buckets/{bucketId}/policies/{policyId}/toggle
    public func postStorageBucketsByBucketIdPoliciesByPolicyIdToggle(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageBucketsByBucketIdPoliciesByPolicyIdToggle"]!, path: path, headers: headers)
    }

    /// POST /storage/buckets/{bucketId}/policies/simulate
    public func postStorageBucketsByBucketIdPoliciesSimulate(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageBucketsByBucketIdPoliciesSimulate"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/download-url
    public func postStorageDownloadUrl(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageDownloadUrl"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/files/copy
    public func postStorageFilesCopy(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageFilesCopy"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/files/delete-batch
    public func postStorageFilesDeleteBatch(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageFilesDeleteBatch"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/files/move
    public func postStorageFilesMove(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageFilesMove"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/multipart/{uploadId}/abort
    public func postStorageMultipartByUploadIdAbort(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageMultipartByUploadIdAbort"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /storage/multipart/{uploadId}/complete
    public func postStorageMultipartByUploadIdComplete(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageMultipartByUploadIdComplete"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /storage/multipart/{uploadId}/part-url
    public func postStorageMultipartByUploadIdPartUrl(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageMultipartByUploadIdPartUrl"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /storage/multipart/create
    public func postStorageMultipartCreate(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageMultipartCreate"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/multipart/resume
    public func postStorageMultipartResume(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageMultipartResume"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/upload
    public func postStorageUpload(query: [String: JSONValue] = [:], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageUpload"]!, query: query, headers: headers)
    }

    /// POST /storage/upload-base64
    public func postStorageUploadBase64(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageUploadBase64"]!, body: .json(body), headers: headers)
    }

    /// POST /storage/upload-from-url
    public func postStorageUploadFromUrl(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageUploadFromUrl"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /storage/upload-url
    public func postStorageUploadUrl(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postStorageUploadUrl"]!, body: .json(body), headers: headers)
    }

    /// POST /templates
    public func postTemplates(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplates"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /templates/create-project
    public func postTemplatesCreateProject(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesCreateProject"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /templates/from-project
    public func postTemplatesFromProject(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesFromProject"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /templates/from-project/preview
    public func postTemplatesFromProjectPreview(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesFromProjectPreview"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /templates/install/apply
    public func postTemplatesInstallApply(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesInstallApply"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /templates/install/{installId}/rollback
    public func postTemplatesInstallByInstallIdRollback(path: [String: String], headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesInstallByInstallIdRollback"]!, path: path, headers: headers)
    }

    /// POST /templates/install/preview
    public func postTemplatesInstallPreview(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postTemplatesInstallPreview"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /users/me/change-password
    public func postUsersMeChangePassword(body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postUsersMeChangePassword"]!, body: body.map(OperationBody.json), headers: headers)
    }

    /// POST /users/me/request-account-delete
    public func postUsersMeRequestAccountDelete(headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postUsersMeRequestAccountDelete"]!, headers: headers)
    }

    /// POST /v1/data/{projectId}/{table}
    public func postV1DataByProjectIdByTable(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postV1DataByProjectIdByTable"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /v1/data/{projectId}/{table}/bulk
    public func postV1DataByProjectIdByTableBulk(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postV1DataByProjectIdByTableBulk"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /v1/data/{projectId}/{table}/query
    public func postV1DataByProjectIdByTableQuery(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postV1DataByProjectIdByTableQuery"]!, path: path, body: .json(body), headers: headers)
    }

    /// POST /webhooks/github
    public func postWebhooksGithub(query: [String: JSONValue] = [:], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["postWebhooksGithub"]!, query: query, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /ai/copilot/session/{sessionId}/editor-files
    public func putAiCopilotSessionBySessionIdEditorFiles(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putAiCopilotSessionBySessionIdEditorFiles"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /alert-rules/{ruleId}
    public func putAlertRulesByRuleId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putAlertRulesByRuleId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /billing/org/{orgId}/credits/auto-topup
    public func putBillingOrgByOrgIdCreditsAutoTopup(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putBillingOrgByOrgIdCreditsAutoTopup"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /billing/org/{orgId}/founder/wall
    public func putBillingOrgByOrgIdFounderWall(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putBillingOrgByOrgIdFounderWall"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /billing/org/{orgId}/tax-info
    public func putBillingOrgByOrgIdTaxInfo(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putBillingOrgByOrgIdTaxInfo"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /buckets/{bucketId}
    public func putBucketsByBucketId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putBucketsByBucketId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /flags/{key}
    public func putFlagsByKey(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putFlagsByKey"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /functions/{functionId}/schedule
    public func putFunctionsByFunctionIdSchedule(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putFunctionsByFunctionIdSchedule"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /functions/{functionId}/source
    public func putFunctionsByFunctionIdSource(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putFunctionsByFunctionIdSource"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /functions/secrets/{secretId}
    public func putFunctionsSecretsBySecretId(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putFunctionsSecretsBySecretId"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /me/console-look
    public func putMeConsoleLook(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putMeConsoleLook"]!, body: .json(body), headers: headers)
    }

    /// PUT /me/early/wall
    public func putMeEarlyWall(body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putMeEarlyWall"]!, body: .json(body), headers: headers)
    }

    /// PUT /projects/{projectId}/auth/oauth-apps/{provider}
    public func putProjectsByProjectIdAuthOauthAppsByProvider(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdAuthOauthAppsByProvider"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /projects/{projectId}/environments/promotion-order
    public func putProjectsByProjectIdEnvironmentsPromotionOrder(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdEnvironmentsPromotionOrder"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /projects/{projectId}/frontend
    public func putProjectsByProjectIdFrontend(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdFrontend"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /projects/{projectId}/getting-started/hidden
    public func putProjectsByProjectIdGettingStartedHidden(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdGettingStartedHidden"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /projects/{projectId}/members
    public func putProjectsByProjectIdMembers(path: [String: String], body: JSONValue, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdMembers"]!, path: path, body: .json(body), headers: headers)
    }

    /// PUT /projects/{projectId}/members/{userId}
    public func putProjectsByProjectIdMembersByUserId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putProjectsByProjectIdMembersByUserId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/connections/{connectionId}/break-glass
    public func putSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdConnectionsByConnectionIdBreakGlass"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/connections/{connectionId}/group-mappings
    public func putSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdConnectionsByConnectionIdGroupMappings"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/connections/{connectionId}/require
    public func putSsoOrgByOrgIdConnectionsByConnectionIdRequire(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdConnectionsByConnectionIdRequire"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/outside-members/allow
    public func putSsoOrgByOrgIdOutsideMembersAllow(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdOutsideMembersAllow"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/outside-members/policy
    public func putSsoOrgByOrgIdOutsideMembersPolicy(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdOutsideMembersPolicy"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /sso/org/{orgId}/security-contact
    public func putSsoOrgByOrgIdSecurityContact(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putSsoOrgByOrgIdSecurityContact"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

    /// PUT /storage/buckets/{bucketId}/policies/{policyId}
    public func putStorageBucketsByBucketIdPoliciesByPolicyId(path: [String: String], body: JSONValue? = nil, headers: [String: String] = [:]) async throws -> JSONValue {
        try await callJSON(Self.all["putStorageBucketsByBucketIdPoliciesByPolicyId"]!, path: path, body: body.map(OperationBody.json), headers: headers)
    }

}
