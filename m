Return-Path: <netdev+bounces-33259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55079D382
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4B281BF7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4356018C28;
	Tue, 12 Sep 2023 14:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CA18C05
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925C118
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewOqTjKl0Cv+jvbq4w6UY4m+GNEFA1ltdqZuNAkieBJZMmuow2R9DlJpDMOrbr6eYC1gvyq9pYF5M04R2za4GYWMPPZKkBOvejwmQG/MJzHUDXucoRmOfFY4OSe+nR5wDXHjUMEzc3UgAJGIRIB9P1LgfGaVssaYUBENBCvoccnIY23Mi6OaeB16GtrDPKsLMnomjLsoZV/QOFRI523spFxslg7x0IX8/Z3L4qkcgoYb06jxIkIzBntndT01FcKTklMJZH0E9bXDncA2RsppVK4RYefrnS3HRMhTlv1K2wJoR+Wq1hWGWCuOgF4s9BYLBDb1hz59L284hGpUMErKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSyVKPtcvQCog7oYOnrncxzQ89nafW1rmDsCQfCgs+g=;
 b=m6sWDZGhyd5DClLi7py0Aa3YXP1smLeaphCLyx3N4KZNDrMjwcuwuOY5WDcwMjvDUZB4BiSzPk92hESOck7b5svhZvwHURZurgrYp+HufVQlXwVBSt3PkDELjH4MZM1SwObaxDqQKKWXMFloP79HPTrEXY//6YRTP0O/4cmIBbxkhSWNavSI8wFxzOdL30MSQgpAs4ctJaHfCuPJ5JmqKRzMtUMMv8GKDxKh6vMeXejnLg1nSz4tfQU/SIwQ2pjIHoX7cLKrae6PsNVzZgjBz4TJXZuAIw1ZWF/ij9Og8dgxyBB9v9GGA5DxgjNLlIe2zkPuDJ8ym7SjEBmDglf6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSyVKPtcvQCog7oYOnrncxzQ89nafW1rmDsCQfCgs+g=;
 b=oW8Zdh7SnxxOCFtC4lkK3zQRVXnhwxCwWCNzIA1sP4PQ65P+tCOh88UgPofmRACov6v89i31yFR8HxaeaSztnqw+bpf0mEz0rZ8+sk6Rv7KrZisa4OXd1bbKt/8M68wz50J9rzEwjIEL4X+NX04BhGWg28vtivnBMBzdsFgCvj0=
Received: from CY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:930:10::17)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 14:22:36 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::bc) by CY5PR16CA0025.outlook.office365.com
 (2603:10b6:930:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 14:22:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:32 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:30 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 5/7] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Tue, 12 Sep 2023 15:21:40 +0100
Message-ID: <741a59efee97edc978f0f65d1d1f48edbdc38e2d.1694443665.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1694443665.git.ecree.xilinx@gmail.com>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aad1343-fa41-457f-7548-08dbb39bb62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EpzxLKqXF/OKTbCNnQsVB0CHMjZA4CmXsX71LLGLL+htObI7ZPRC5u+hpiPXRRWWPI5NnIOGxMr9+Fb0OrH406LPLi+vVDky9IPid6lR+z1XC+g+tVGd7ilBTwjTVk1szWCeXxIosUbZ18s96l9RDTyMKnm9NtvoCn34nDsizwTqcFL3wNCJK7jE4037/dXqCHnJY9wnYpGw+AJnI3D81FmA0z44FrXZILCzqnrzUZrMYw+Tk/223PSD+O2gEDDFthjTV+HatLBzYLua598s/OdS+3QXRYIueg94Oxrz2Oxzv6c6zU/HSzUnrCHhn48c5JHKJBU/6jkZt5JADlpK/aV7yPXArqH4vwUflwT7Pdbm7ZSTSh/JMTIcZox4FUlHgiJRo10fgIP2vK4hqxw+7S4M3DM/qfjlG2Uaq3sMA+tTGLzFrRN2YP4I6ST+UNKO5i2bj+VSm3UAyXjagYjZ+Nd946mMvm/u+wn3ZRjAuJreKnaDFAm1GxgtMGox9nKQdZb1JusF2HWzBRrYGsGikyk4moHm0gyneQq5SKkQ6m5xNP6jQWmdTEjOzbUr1KbwZAcG8vm76c1SL6RsQMxjM1aRkvc/bH9irmlh4YvSKfXIE63Jc3INJTr+RHjxdo48YZ6Fdjn8jKBuPa/JmMi6rffD01gjofBaLBFJlLicDGbN6F8cMHjSoTyg6luIEp6tpxBG2AfSVPMdYldDFm/9RprrPxlagUcaLrwh55XeBNop5FDtEKFzIzRg0l7g/7qL6S3p/ZUx7LUCkPW3PJAKfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(9686003)(478600001)(8676002)(336012)(2876002)(40460700003)(55446002)(7416002)(36756003)(86362001)(82740400003)(356005)(81166007)(5660300002)(40480700001)(316002)(36860700001)(47076005)(83380400001)(4326008)(8936002)(2906002)(110136005)(426003)(41300700001)(26005)(54906003)(6666004)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:35.9229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad1343-fa41-457f-7548-08dbb39bb62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341

From: Edward Cree <ecree.xilinx@gmail.com>

Currently passed as NULL, but will allow drivers to report back errors
 when ethnl support for these ops is added.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 9 ++++++---
 net/core/dev.c          | 3 ++-
 net/ethtool/ioctl.c     | 9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4fa2a7f6ed4c..8977aa8523e3 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -927,14 +927,17 @@ struct ethtool_ops {
 	int	(*create_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
 				       const u32 *indir, const u8 *key,
-				       const u8 hfunc, u32 rss_context);
+				       const u8 hfunc, u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*modify_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
 				       const u32 *indir, const u8 *key,
-				       const u8 hfunc, u32 rss_context);
+				       const u8 hfunc, u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*remove_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       u32 rss_context);
+				       u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
 				    const u8 *key, const u8 hfunc,
 				    u32 *rss_context, bool delete);
diff --git a/net/core/dev.c b/net/core/dev.c
index 6b8e5fd8691b..f12767466427 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10869,7 +10869,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 
 		idr_remove(&dev->ethtool->rss_ctx, context);
 		if (dev->ethtool_ops->create_rxfh_context)
-			dev->ethtool_ops->remove_rxfh_context(dev, ctx, context);
+			dev->ethtool_ops->remove_rxfh_context(dev, ctx, context,
+							      NULL);
 		else
 			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
 							   ctx->hfunc,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4ce960a5ad4c..5b943db75974 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1385,14 +1385,17 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			if (create)
 				ret = ops->create_rxfh_context(dev, ctx, indir,
 							       hkey, rxfh.hfunc,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 			else if (delete)
 				ret = ops->remove_rxfh_context(dev, ctx,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 			else
 				ret = ops->modify_rxfh_context(dev, ctx, indir,
 							       hkey, rxfh.hfunc,
-							       rxfh.rss_context);
+							       rxfh.rss_context,
+							       NULL);
 		} else {
 			ret = ops->set_rxfh_context(dev, indir, hkey,
 						    rxfh.hfunc,

