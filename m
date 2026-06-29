Return-Path: <netdev+bounces-302844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1iHGCpz5QmoELAoAu9opvQ
	(envelope-from <netdev+bounces-302844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5C6DF21B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Z3M1z6EA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302844-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A003019F28
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6B3ACF1F;
	Mon, 29 Jun 2026 23:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D12744F
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774157; cv=fail; b=cp0NiMr/nziMqk/fE6M+FjOi5K4U9eixA/dYtxZ5ojLj4qBqRsymrdonSHBvyYrUO/NcHdT001EI3AuhXMykQvjhsrIwXXDoVyMHMMCxWojpQDw3oIU6cyWGy7xAaP070IFW8t6aqADNGU/VG4Drtt3SwrNIhzQJdWVSiJxgSbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774157; c=relaxed/simple;
	bh=IpW58tjuS5VVZuyn/2Akg6AVMlDqt8L2Jkf2HvK7kYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkkpg+XZfGvd9M7L0h5k3yhLtpB37MiuV9ywred0t4v+fonc8fEZ4mf+iI41ZotirR8lzs3w225AvXhGqtJsqDy7RU4Xh6sqbdmFJzxr6UUqnVki9rFc9kmPOSWxPNPjDiPnrWd8mPxe0vMXHU6gSx6kk/Kpdm5XkM7Rglu9xfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z3M1z6EA; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvqNGMPffhTGtlazN6mFhrPhEzujVAeSb3PcGVd9NP9PLPjLtShXrgvl0+ndN5SgC20TttZsbt+tv+H77OqIPLZzr4FmqYHNLoepo9eHNN6TkPtD5QRMkSrr6aseQXwOWzrT/dqkYeH6G6n9U3LmJrJbaKTWgroUZChdnrMVWbERlIQpm1GF4C2ZQF9z7038yfJMHzN8ZkzRmFKHPDaYf+H1mhNE873K7SdZHcknDMTbC/BD0kDP4aWoXahxtePIaTTn9NaFB1iBBWOzDv0nabi7cssfyD+AULleiwzLIM8G9c6Tql8D+p/DSiXYJV7ER3eGQRyzFr8Dbtl0jbgU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=XiOH3zTiZq7fiobtl84VB4oU4P1su5kYe3awe8zEIuumtI43QZ37sjZL3zIhPGg68DNrtDLjVuFZ404+QvjW3LqyYM8Z9IGevNYRf8GTdP3cnoJFuT/mZ1/1oApm4ApEyFuAlyy3FhI+JFLkAuE2cvrknq05WZKwHotl5B7UPwpoAo6TTg5ZVtDz3fXZPeXvRew0i5o+ZpD60AtUavilXAkLZOFxBD7XwnBZmW7oCBKnh7BC4TVfgwnWssa50SVRkaMfqKUGGoRMR02Hdj8ifsVt37+ms/9QQSaIlcl9IZdq0x5jPamj1NODDDFJxTKlsR+FazU4x/J1NO4wBAuxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=Z3M1z6EAuLkOagoKuXN2ZumM85zmqn1ANZ9u8e+ID1SnVypw3k1UZUPio4QPpkMoioXX7UGphvSzNkkYZI+2yTbnNXlY+R13XCnIB5/C85RahoVpB+E55JhD0qFN7FEeW2owreWu2DF+uaSf+jSMnMsywoG08SVer4P364gF0a8=
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:02:28 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::43) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 23:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:28 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:27 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 1/6] pds_core: add support for quiet devcmd failures
Date: Mon, 29 Jun 2026 23:01:55 +0000
Message-ID: <20260629230200.82092-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629230200.82092-1-nikhil.rao@amd.com>
References: <20260629230200.82092-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f5a40f-ce23-45ef-db7f-08ded6327e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XNX+faC0pBgEZqAjhWVM+dkTQ+yPB+V7gjrgzXolqq8M2rZbqPqtqRmsjTPBRIUVfflftQLaAe/Smk4/g77s9VktXI7+MvXzcSkfScYiv3sIuOJPNA0x6Hq2w8WwJ62RKwd6dZ/VyL1A/2SDJrMufluCnUPx4xOtlmvjLOhJWU610DAShkV/7JvjaOdjJOXVPdrj6ot/pucwQLagXM3tROPdRsH/gdbK3KJjOKggpvB4HDM3ykfId/G6MkNMr+HI/gwt3DkT/ZFWoXiV/L8ZH/fa4lZqRs9MnyZVQv2qS5BLaKkz8hxxYMQCFk/+oT31zO56yTGqwWNZJ5XwXIJO7lKGtOa3RNGYioVRDpTJRelYTJrkeXDVwswszUGb2kvqRLPO48UKAaWPF/hYCwdqDfF9E4OPGS1mkUz9C251UMWiWSbLHVL+jhEfF9CM5BpPySSld35romCyMbgnUfgj0NazPiGElt9IiXZyH/S1PyWDpyt5cRFTyOW00ByGMc+wYxj6Q2HPScslLTGr/UzecSgUWEbFV8WyqGJE+uAd3UPnQ0naTRxcIC3yOLkJOYQtk5mBrs97vZi4uZ7lLaFW9c6vc5deFAVfNseXSmFpfXEDv9JvbH4Uon6/7ImZFMt51cXCDgjeZX0EBKUpCPyo02t0v1yuSHKoxVfaU8IC4VVjPH6UYD3hlzCF9Xadm9vsH0hQIoZwtYqgN/ngLhp5GQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JwUWNYJwdYLE/B6udF2NKkkdjRboOJHt2h1VZ1YhNk94l+2BIUlD6ZCpO7U7V3ya2E5mWXoM0T5+vtWRPXqBrY4XRJ5FVDvBKx8ohBASlBabqC3P4K3vK1ThsW5BVQG7lqJYXeSMNKCrtnf0UfaCRWWQknIxleJREN4nn7hR/gR1Bmai7svELL+Bqzd200lmJ3rwI1wijXDNMqLEDTR2uJqdYe5WgBEwDijz4B5Cay05eaOV839rbfALEWNvMGqhgztCJ4OPUWntZm5fBquucdP/rMhZD8CyXzr2vaZEXk9wHo4/UyPdvaoDmaRul89J4kOmZpENTPLUdVqwQ89n9gVY0i6ltYaEP7Zg1hl3UayYy2hgsqZgcOUljZYw5O9vHzj4q31Fg9UCTbsiPHuSMUJT+kGDga1cHYua0rqzd0sS/Abbv550SuZcPzD/HjhN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:28.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5a40f-ce23-45ef-db7f-08ded6327e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302844-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87C5C6DF21B

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


