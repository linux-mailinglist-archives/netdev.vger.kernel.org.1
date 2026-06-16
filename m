Return-Path: <netdev+bounces-299717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5aEJay2MGodWgUAu9opvQ
	(envelope-from <netdev+bounces-299717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF568B811
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Y6neItu6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299717-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2D013020878
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBA38837A;
	Tue, 16 Jun 2026 02:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A722D7A1
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577383; cv=fail; b=DgWYH/j4cbiBbdNhj87djjqoxVf5Ay7ZhpdvSM+ppUcXkP7SztZtUwDATITUcW63fHKPIOfo/jGRjuWT+YQD8I7XulHqLSFjKPz4ewXpxxWEc+p3NIqHjSa47Nw2XtOjcCuZchdgItaJwdOqjr7LtyB7d6u9ZzcGElqVmi7skGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577383; c=relaxed/simple;
	bh=IpW58tjuS5VVZuyn/2Akg6AVMlDqt8L2Jkf2HvK7kYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCpAz5BPTyvNBjfpGcefjWa8+UuK8ZNYSFd1Qr8tcmHpafCzPfNo9/pKKc84RZwMEEVxfVQja8PCEoPAg5lgDmI8BU8r9ZZSuf74QtRoZP/ZGEcw8Snx1/h8Rz0Dz61L7CSZPS6PkKtrk+fbR4NfcsnHH+vQTPZ5wIgoX9lxtdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6neItu6; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmhNWpn6zPLM73hUbZSugFI7oke8xAxpLhctbxLChFS7uNm3wgm2mse0j15LvuZ9pS5cPC+FQMbQbf8lj+vK1lsgbVyLo5oyq/NlmC3RyhhtEfxV5eRRboLqd+8eZk0O7qPIJqu+07dpbjqsdr3PCP0l0AYmq6QShSHqTPb8SWSCPrLD7eUFvGRDYhQn2vNTMvifWODa7+jkKSnmYEjEqLF4kgYQjySvq65Hv/usaUXtC7lx8AxbviajFhE4IB6dRIdvQysJh6vAuJUaLPh54PcZ5GsNySNfhdCx1+lFcUViMo9yjjxd8K7cgpia+bukBlpwHrYSf6h2fPx5wNbNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=mmZhztfXzoNdd4+xIZNGSScOsRAPwOrX8heZARAqN7wAEGlw8DnN1rbFCUA3GicznxIf1JrKeGR9QDx5be1WdbCpsnSK70jfDJV86iffqMil6qRwwcXkmP+VJKWRZ4KSZ6OzKb/cOxTlftt50D/sVL+h4tb2i41hYl/lI5HB2ajYKTeu9Mr/dtOck/zzsdcolK014gdyxM3r68TI3FGhRc0Edzp9nqO2FYshB891ZS+1pc/XXyy5Tg7NmnupaGOugiMpc730XQduzu6TlSIW/ySbD3GXk72etwqaIlN0dRYpl4GQtBOdGW3/QID3QxU01c0TEuBCIaoiDQypw2JN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=Y6neItu6K26+cz+GinYn3H45FOTPgsXg5RyNx5b1Rbpr9Gm2K3Qwdi1QR9hPdRHKRKGCotqWXImyWAeGdVHFnesifl+QpEuU6WFuU2DuFYCQL1eXDviZjHO0CTGaPWI6KDzWfSWdwGwjB2Q6rlXFRd1E+sPjsaFQIYWTO8crl/Y=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:17 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Tue,
 16 Jun 2026 02:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:16 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v5 1/6] pds_core: add support for quiet devcmd failures
Date: Tue, 16 Jun 2026 02:35:49 +0000
Message-ID: <20260616023554.258764-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616023554.258764-1-nikhil.rao@amd.com>
References: <20260616023554.258764-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c6dee8-1472-4fc2-45e0-08decb500ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AKbmB/Y57OkSKBrm37EeH0xsWNKbbZkm0gfpcDXpdMqbgQV2/0T+ADVDBsacVxIm8H6cpcYtpXMLc/68cxmGlYUwesJgb/3zrTTxRQybO15ERYwFIiXr1jCoJkzfngADFdJQPKcfjihIwls9/6auIwpoEviNzer9PZxrwHeuCWDmiGFJrgIVItWlnCrSheBtkOh1E4JP3nzauJSU6HoWEZM1oLxqxjrm+tQvkA7TCeHSSetBRVarwkWRiywEbqbDG7acuOsZaOqfecpvXHF/hojQAnC2KX1D7jkjsKBhraFsEGvjgO8i2vH41R4n8H7kaUDRcNjf8L+f5jRcu6cVOufQuFBkidKJrgpJVxTB41vQ+uym4RjNabBKoMDlX0Q90v9N3w1ZYZZuGKyx5gXu7vZdkJKNQO7smX961GCdCdAe5GOyxMFu9SamaUea/PvnV6WuVPX3/hIKaujyisKrK/G17jQWAhUl1+Y2hR5qYh+ElTLdQ8fuG/aXMPDFnPOWz9rKDDPFdOKXrkjocEuPEijuZ099EqRHs6NrVze42qRtjmGUHpIb5OUE3L/sYVLS7DBS4Ir1oMSwGbnUXpCS/9MKINCCuKvuhAZqu1JeA/5HAgMr4kuuDP0M1/5WZGvVetfuke1wl5U9LTp5efl7eBJ7YIJleVnPVLeW1Y1iypqM0cWHvD8x0yFH4OkbcBkqhcyKr47hvWU9dTi8as8TeC08DIKx881eHANvMRLpZ2I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ik568svBJ4iEozal0J7lU3vgJUjVRqLKx2Rh38Fcw5YaltzjjwLyLmNDJ4gsPMP0MmChTDnTsHmANl5j9YSWYOZex/2matwB2C7YNKf+qMp23F2ZYhry5++CJ1OGTA4ArU7FQ1kil0nRvGyF5mr0iV4j6rdXTsY4u5m+co0yT3IKjigWFxjkwU/mexwEtv0M+zXasMMvkqnmMwtVc3magqS8pyKynf3p6aKNW8FTHMTwhSpQMpabOU0TW07TCEwT5k+adHlMhmKHYkByscNCF+WNZ1NWq6diazeDFCqa2IPGcRnUq0o/1tQLK1NcbB6YYhpdc/+2DngRsH7nUzI1Anbx7qMyJwwGRDaxQ06motPxJ4iAHbrcFSRjA+SjxrST3G2W9dAVAUNqc0P1CvK9OE93EA/+DBM77PvjWAU6r2oOmy2aHmkfz6TE3KeUs62g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:16.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c6dee8-1472-4fc2-45e0-08decb500ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299717-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECFF568B811

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


