Return-Path: <netdev+bounces-33725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081F79F98A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 06:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94822817B2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 04:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359915BD;
	Thu, 14 Sep 2023 04:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058A7F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 04:20:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FAE59
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 21:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViNQJQzyWnC3t9KT/GGZ7HGlphy3eMfxcAY6pkAisF2l3cpIS/5baDG/ScQcxTLGcsLoOmAgfc43BWbO/Mf8+4uxHxUNMvnLRPP9C9PwUplfTlW543AbySlPHpM/t09rWXL4lhqn4wNQzIf5PWbtKap7+t6sW4NnE3VkAiF0SVt2MKf6Ja/Ao2J7mGIlLjt6Ksd9Lo2Qg6m6YXlbyd/ko4zZk3S9+Y/7+1hD7p2w6fDGNHs1PswnQ4N447Q6lBV3a/1moEjiio1JZVui7T7iWYkiXDvE5MGMrHhArXYLSkZWG/bpVZvWtmZlIgRRjaekWtaQKphw1NdhIL6sdBTFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOL0kl9COOpkVr9Fa4Cc0Z4vazYatJV+4I/o/Z33yAg=;
 b=UfDvsWcnvwDumo0W76gx1OEHchwaL1SOK70+7CodsuSzdOW+UL9ulaUSko0TvUe6IbDIBHDq2xqmfy/Hs2ac56q46ttJz67XSQogdc9n6c7Zu7W4FNbyBWhM739IPZ9ic+8/UfNDgbKH1+ccMiTET5nqyDQBJXa0Wy5fQQET5VUcslFcWmwGlauZU58uLMDhPEzSb7nbz4dZDCy2p+w5yapXn/lHjLnRbuhhmBniLy6tYVz2yYVk/tJhLLF+2qCNVcXodGDmto7QH1TIOG6oe9Q6x4vCoFFRdO9pC+hxsOX7VUiyU80e+nXRrssDbreKtQf4LmxiMTeNhDosk0bZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOL0kl9COOpkVr9Fa4Cc0Z4vazYatJV+4I/o/Z33yAg=;
 b=iPTOFHizx9AwYJY4oVQ5i6UYHZcKs2QUYABm1xflnSR4VRDzyEmh6Hv6ZNOupgEs3m61wY9NKF8Zv0pZ60T3a3iuK+Wy7vrKBse/dWW+YabXdbFmtiLUI/0CaJfW5v2R3vtimZ3bwuVhMlaIjvcDDfDQ1duNB6LoJdLFGCOOtZE=
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 04:20:27 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::77) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16 via Frontend
 Transport; Thu, 14 Sep 2023 04:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 04:20:26 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 23:20:24 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: read STAT1 register twice to get correct value
Date: Thu, 14 Sep 2023 09:49:44 +0530
Message-ID: <20230914041944.450751-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 24df359a-37f4-40ba-1415-08dbb4d9ec55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mD9QgqiPC9vkszOhR0fyxpKJBN6CcCFy5XRxANFpSS9q9hMeKja6dvTRWchCizsjGgT2dYuYTJUoycYtj708TPgU02ADcJ13jLA8ZJP6iVrU8m1l20NMDtKirqWQzU86V/MaO3bs3/2wxRkEZV5+bZRxaQg7yptiFpE0ZLIDpNM1Doys1Yucql4FnDr4tDd4r5qPIN+giPDSQaydxCVTPorBnvSfPsN73VDGacwpX9q5paEus8H07U1gO+pJ3gwxca0w9ZYd4XOdAUVMOnUxXMRSjrMaMeUkN2NLQw6/7d57KQuBms5didXw+CHBocmMQhm4SPEGoi/8B4IocIFgvxaaklRFqMzRVeozo35Iz9SyOTHmR2gQ4BAuMq7lpaUt5NH+goGJcPAOdh8sDTTbeQVXJcwRpiUWq2G9sXv16gwjjFoBFZCBo+ZfZ5rcfy5GTVC+xE4JfFt2svLAAKul/u6Z26dfKjCRYoCF7/3WpeygmsS7Y/HD6TtBh93Is38c4eR/MS6iFNYve8yAMDrKOdbbRJqrgkWO266gz2i6rH95jMCq8QbYcCstLlAOpZOPM060Y+39qnH+xtx8glA7XNMsP5wLxrRj4rnxBd594flLInF01C1jxNEqy/3oPc0e6AU713mQs2oaDdUOWyLGK3gmpl296iCusHthTdwBJCTve4mCUxJ4tfth4yWVaD6NzG/1CSoZW1MX4fPI7tJX65dru4fMEAa730Pq3VAGZ+bnxmniw4f40rrXNd+JsPONaRXGTTZDR4FrPE6lYevjDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(6666004)(70206006)(54906003)(70586007)(6916009)(40480700001)(7696005)(41300700001)(316002)(478600001)(8936002)(26005)(16526019)(40460700003)(82740400003)(8676002)(1076003)(2616005)(4326008)(81166007)(356005)(5660300002)(86362001)(36756003)(2906002)(47076005)(36860700001)(426003)(336012)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 04:20:26.8489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24df359a-37f4-40ba-1415-08dbb4d9ec55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954

Link status is latched low, so read once to clear
and then read again to get current state.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 6a716337f48b..c83085285e8c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2930,6 +2930,7 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 
 		/* check again for the link and adaptation status */
 		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
 			return 1;
 	} else if (reg & MDIO_STAT1_LSTATUS)
-- 
2.25.1


