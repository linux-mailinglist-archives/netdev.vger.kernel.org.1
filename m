Return-Path: <netdev+bounces-299142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PKCJa01LmoUqwQAu9opvQ
	(envelope-from <netdev+bounces-299142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF096805F2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=XqRMbYcY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299142-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9A0301FFA5
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2630BBB6;
	Sun, 14 Jun 2026 05:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261C30596F
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:01:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413283; cv=fail; b=S7778FnLpJZwtwvW3cBHLP3j5HYu9iILWqkJ6T1yPTx/6GRqs7H+MPDJ9/sM0esbwsNRmKG6W6qseP0tevSrkO7x+9vOSzRcpMFMoGhNquqs5urNxVt9i38ipvRIUx5gTYjmuhK1077vEXkEiRBM9xCCTl01V7Vlz1iqhzVkbFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413283; c=relaxed/simple;
	bh=IpW58tjuS5VVZuyn/2Akg6AVMlDqt8L2Jkf2HvK7kYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neStfqX/lMcHtkCMGiXrQrNsjN2kPAo0w2fa8k7J2vggYMwA68DWOsIZQuJYGSOeQad0vhT5BPLpEtKwyVQDQkINa17vinC/M/Zmx4RS+GUsQSpPp0prhway5+ObcE72WCJu1n1b2CP/c9ila/jrIv0fKrGT67W22bppMWbcq38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XqRMbYcY; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdvC32fwx/P2727dA7/TzbzAanLqLO+SI6YCH45K6DQtDNAMdUzLAbMmEvNnv9/rbedDpI2Jb2CTinpe3eDsq/C1zC1jQLAEqjk/ar4Ql4HpzuhBwp07REOzgwkczs1JCjDcBzsidSyzp8Q/skSX28+PhkmqKP6/B5j8Kg5qURXwM0bBdSQA36+BDWB2FDicjv2Ncz6Xnu4kKuDJ7gWZtk4P5dty4A9brloceGW4tILoYltdb50CFCyAasLFMIS26srbC+0AcpFHkGiSUfIlcFX/9z4J1VhbM/F3/tcto8WmzVy8evlNvNI6abs9rKnfytYz4K88HXWL7DWiunmUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=efXp9sACjay+PNoMrIirtwxWM9z+qgnrW7ghpCXtgK7BgnbuQscyujhYf8bR6q3ZeOYM51rHWDCpP2vO1cnTEuugkQ60gUwkTusEpynZUiQL0xyP6GfwYpIdeYRqtS184aRUY9Yx55KBej6xKhqWc0XZ8XqT1YU1mMgKL6e1PaOTUV7hY4qSiq35VAdqw1e9jwyY6CcesagJuC/6rfmtVp5vcvcN6bt4m94w0+RjZ585TpgrHXpbrIqYxKIjyBlvjLD+rlkJqa08HpO8fj00JBPLjN35eY1Me5A2Yk0oXlvRJ8ifaEu/cS/EGILujeTOQsJZJv2C/8FT5oqGs07eKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=XqRMbYcYqs8DepxCOTamg757GPota+TPOCaEnZerEAnMLtZKesFv6N4PnAsOC/8FhjdMyuvvHkGHfoyBPsSjrVy/5QS9uclXybA9FipdQr6eQ5ywNl6nHWVPcUJqdQKTsIuE7JmRPAxdGvYC4Y8Ost0NjSBZbu1rZhzhZPndquE=
Received: from CY5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:930:3::20)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Sun, 14 Jun
 2026 05:01:17 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::35) by CY5PR20CA0020.outlook.office365.com
 (2603:10b6:930:3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Sun,
 14 Jun 2026 05:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 05:01:16 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 00:01:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH v4 1/6] pds_core: add support for quiet devcmd failures
Date: Sun, 14 Jun 2026 05:00:47 +0000
Message-ID: <20260614050052.1048328-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614050052.1048328-1-nikhil.rao@amd.com>
References: <20260614050052.1048328-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: df469cc1-12b0-43fc-4d3f-08dec9d1f77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ycRHq3Yo3XeeUVcHJGuaD47eyb38naA/B/5Yv69+rpivFBa7gszvyRyrACJ0K4GNijdMWCqwqcw9BhXE4n/TiIxkhkIprfcFaCeWq5Oq0+HtEWBd9uXzTq8RGhgzFKzN/Yuc9EFd9ZVDS77r7q+nLxNVM0373Ye2XeAiOOpBXlJy/u8zsDe5BPil1r3Qzodmo+50tK5xETCNxreSLIHj5rwGMJJ4YkxLu5YGHLo389/5Q4gqCnFL07Zj51MqXu9wcQnB+fWeVOVwo2Ly1jjlWd/ga8e7jPtxhHBSR9Ib0E5hrLc+qOZQzV8LQRgY81BeU3AEjXVcyF0aWjhn23IX0W7dAtzbRaX6PcWgXeG3sgskYuHpwUeg2QNY12SuOhdS93qOb5gRaa/hEyT7cpEaWemQcKIcd+L5WcESYMPo7qprxAZ6VTjyw8jBn+/vhDq5EE7HHW16dzzeFAE2pbVUEgROrcEz7VPpClBHe/yi8QlbrZzUzust0Ww+tyooyYc110Moo4cYVCi7CqjWcsc6v9M/s/kAhz5JkMNoLd+fksDdQ8Vaz3NIMin0ZQi2ylGaG1Ex3M9+5BVeBJ38SiXSDycviy8h6t+kOoSpLTIghWs8ag1c3QSjpdoocKFkfCfUoUk6/mOIsZstPOEILHRYWzVsAr63ozqrIVrju4CFEqgZptx/4unQNSifMPqUmozIgCrMgbWX9MHIosaNAF7ZnWjnPhNjyk1aDFvHp5N19UI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9WDQ5DTqr9SfnmiQZ8G4iTVUK+9wFA/erLJ6dQNM/ShGmAveRVrO+UQV7xDRgm7aBQa+AiViMYjExLUE1gFKz1Awje8IuhWGb4VSJ2ZDwlz4P0mfzoYwkuZSTkhhNv3eyDwAMpFr3wIrsH2kijkJEuiiko7VZD5CvNGATuziAkT6uIitcXRrPGvHPsc4MrqNNP3LYtOK+IhNBRHY13V1DW0/QDcaAiLrYU3j79o9Fry4LvcSJ915B2zryyRZUkhDstExVPY37FSSuauxitOjFwslWNqY15aOGqm9uj674oTw31MQJbvO1EezmxuKWoqlwoLjj5jhVc16v+Zh2MXy6rfzdwMrWJog/X/+XFTJ/AbfFePa0CyDPH4fNHu1yH6uEQn658Eyd6cRcbEjQ3pKLpuoUbJCpTCV0Lng0om4RCG7ARYavu3YUUdqnptOIe/2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 05:01:16.9712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df469cc1-12b0-43fc-4d3f-08dec9d1f77b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299142-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FF096805F2

From: Brett Creeley <brett.creeley@amd.com>

Currently there aren't any use-cases that require special handling
on whether or not to print devcmd failures. Specifically
non-generic failures, i.e. not supported failures. Add support to
allow these messages to be suppressed. This will be used when
adding support to negotiate PDS_CORE_IDENTITY_VERSION_2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index bded6b33289c..dd9989cfe6b3 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -126,7 +126,8 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
+static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
+			      const bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -179,7 +180,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 
 	status = pdsc_devcmd_status(pdsc);
 	err = pdsc_err_to_errno(status);
-	if (err && err != -EAGAIN)
+	if (do_msg && err && err != -EAGAIN)
 		dev_err(dev, "DEVCMD %d %s failed, status=%d err %d %pe\n",
 			opcode, pdsc_devcmd_str(opcode), status, err,
 			ERR_PTR(err));
@@ -187,8 +188,9 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	return err;
 }
 
-int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
-		       union pds_core_dev_comp *comp, int max_seconds)
+static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				union pds_core_dev_comp *comp, int max_seconds,
+				const bool do_msg)
 {
 	int err;
 
@@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
+	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
@@ -207,6 +209,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+		       union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {
-- 
2.43.0


