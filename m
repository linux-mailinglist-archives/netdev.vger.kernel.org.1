Return-Path: <netdev+bounces-287338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJOhFzKuA2rT8wEAu9opvQ
	(envelope-from <netdev+bounces-287338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69052B17A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD5F30FC784
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC823A3E6F;
	Tue, 12 May 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u/r5u1Zg"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE6396D1A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625883; cv=fail; b=Dk0aQ5MLUyj9o/bKEMQc694JKh+snKFGnyeVoDF8B6LKy94DqkbWXYAc9PD9+X4vCX6lknvOfgiYBbfmQBvpPpobJv7rDs4vcSABK1YqxQyVrTvNHgEm1yi3KkdgJ0wF+htXE+dtq11n9WGMj61o4h0eL+mwLLEap4rO0gtFUcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625883; c=relaxed/simple;
	bh=pGMGVZYluUeUVzNNk5SnfLEPS/mnHOcdUxiwEfO7YeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iC3Hf9u51e5NGGxpY+K8QEwm4jwh7srcH+I4A2JoPCBXu0vtGmESAi6DnP6f5yHzV16sHDWObZPgFz3DftmGMLtQQ1c9j6sbFGr2nDsGfiC97gvCwKVhJL4ol7z+Bj5bBsWqL5XM0Sg+ZsrJQSfsQ13fU4WfrTy78RJDnyQ4R+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u/r5u1Zg; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG3wbs88DriX2xiY5n3amu+aFTiWG+gQU15Cwqt7BBXLP3w4olTfwp9ISXPEy0b4pPW+ewO0iSL2K4xNRfIEAuWWnVcfEA6wi5zkmPzrIGjxF4GXcoJ30zqOXJbLLE4Y9Cqh57QCmAygp6U9ooiilCYZeIlOJ+h+07pRzx+ccOkHzRTtMUXH6/qYfHuVxrc92PSyQuuTN255k3EdIxT1UygNr8v/2VRR9XC6Ne5StMQbok9hJP3TfVZEwdMY6tNajoOTEjy904guVGeWg/QYzjJ57Dk4bLhwjRJUCgDJHkcKORL3VKrPYdyTw4R0mBS7c2Bb5paV08A1wfPLsN6lCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIAoB75n1ZqVToHi9aLCNEZzZjXZPMorQMB1P9Wfku4=;
 b=JNBEmxOz8Tu/+bSfwryQAh7x5j/FvYIRfUVA2YEZXPPJxkljbohPwYoiYpzY6xqT1OeJYmrurKWI2ABjQgQlfkQH0NHZlGuyAvTj28bpzi8BvXaqq4tKplygQIAi3gRNIMlhXq+p7fwFWfD4QCl9vEj5Nre+udoZpIE/iCWmRcE8caq61FsEr5h7G9y2DKzlVmzYFtc8JZYWUcbwORrd7TNmqksyBUFPVBkjroOwFFWyij33Z8zsffi39nyyrzHL9cscA9Z6CYaTZ9aZeQiC2O+GOKxP5UmR6ulvyHlqsxZMxuaFkHp7uj95JJRmCgTU4cYVA3av8W3rR365vTiiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIAoB75n1ZqVToHi9aLCNEZzZjXZPMorQMB1P9Wfku4=;
 b=u/r5u1ZgBotGH9pWJaLXHM2JbdfsXLzzwozqVjYUYW/zRrPHlKB3d1HyZ/LmiBqCF2EvNkhH6M5dqNGG9TMYAgP90fnpZIupBx6Hgz+uM2TXqZ70L3tqgG7M2SkoMp/vjmeO6XYpQK65IufQ8YPl5oq+NigmeHimcognH5S7024=
Received: from CH2PR17CA0007.namprd17.prod.outlook.com (2603:10b6:610:53::17)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:44:38 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::bc) by CH2PR17CA0007.outlook.office365.com
 (2603:10b6:610:53::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 22:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:36 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 1/5] ionic: Small improvements in devcmd retry logic
Date: Tue, 12 May 2026 15:44:17 -0700
Message-ID: <20260512224421.25236-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512224421.25236-1-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 724d80de-3a14-42d9-2cd7-08deb0780c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Pj1u/LVovbKz+tcfj13ODRMumFPQYijaT/6jg5o6TqaDHblDYvkJ5vM4cbVZKlbaCHBvr5FuPfiFYsvtVOHMfMxmkRyf8ErNgH/uIafG+cEd1uE0j/MSNwdY1VAwQV+1XvugncVRONFtUKUQ1trAqUF2SpcyiMGwwtLdPTPgT18af96jBqTfPVWycHUxaP9hRR9yEx/TMzHqIFRG+oEDak7KO0mZbw8YpXJncc0S3SSUTrXdHlgHr+oluHNG0dcGkOIzUWCtfUN3ofzWatAL1Serf80WY6u+a2yPUjQHcNgBAHN3ufg8LpN581SIv2X2ntelt5IUepOV05y01HoIQsPDR+IeWKy+cmPuD+K/KWil8gcFmHZ0TEEkhyJ/rjI1BF5/RAgnEC3FJjxJanweGH3q/drkHMnVE8UfJm5DW2drzQv+lOxD8HUX4/EZhhEX3u0nxcn6jUdBhe4tNeMgYy97adXXIi67kTweQXvU1eUnbrs1LQ6m2IOwH2QLLeEJX/2yKoyCYnWisiMdIaG7Q6pJixErUaQ/G2tWqBOWByZMULwwt+YtEQSyVeu0V/146yVMN+xpM4R/2cS4tYZtdLUsKGEQb+nD/0dm9gNn2sGc9hrjwm+wtE7vM6w2CE3ajRlTc6CQKWX8VCax0ImBzdJxlug7tPZnZPsPEn+9j0/UUNHLF30GVIIb1DxY+XwE0gzWJkohVZJ+yuwFVA8/StjNMUy0Hy7zBFG8G7pX9CA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BXgTompNyfIw1fm2bmX3OYy6h8HkqH54EgcD6P2sDkWwN4JayRdd+81QHTB81ZQnlK/NkJOCAodVWuVYYUIcTsn+JD11PNYkvnEnkUOa3OW7+xaPL2QJAn+ILfA0I+9j4se0Er2e2UjHWWG4rfb48S3tnxsE5nVrzkfeGxLqCCSOoqlxH4MAOn8c+hdfyWhTSG159WITLhvljiSnKsERZy/UVFAjdkEnW5QLkJ8qlFXemj8i71T53/TjMw0tvaZ+lRdnUO3KiDwqSxz72o0rStgfrMMX+/HhFH8jJTRZ7uGU1dgHftxyGNeb1lQjYuI5Q7GiKy+9MTgTPgTw9FfnJBjxSYfCy4111aFieLCGXBk9sxXcGYNADCHtfWUNy5n83ChUhZSXDvbajxtVc1bmccLwimOix+RVlHlDlW85zcehrZ5qajKp5+5u7AS7FD8f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:38.0339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d80de-3a14-42d9-2cd7-08deb0780c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
X-Rspamd-Queue-Id: CB69052B17A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287338-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Brett Creeley <brett.creeley@amd.com>

If the timeout time is hit when the last attempt returned EAGAIN, the
driver returns -ETIMEDOUT. This causes the -EAGAIN result to be lost.
Fix this by returning -EAGAIN if the timeout time is hit and the
previous result matches. Another commit uses this return value to help
signal that a deferred probe should be performed due to the firmware not
being ready, which is why it would return EAGAIN.

Also, reduce the sleep between the write to done and doorbell registers.
The msleep(1000) was initially added in an arbitrary manner. However,
this long of a sleep is problematic because it reduces the number of
retries when -EAGAIN is returned, which may result in the devmcd giving
up early due to the timeout. Fix this by reducing the sleep to
msleep(50).

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..a81b14e6a591 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -518,10 +518,10 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	unsigned long start_time;
 	unsigned long max_wait;
 	unsigned long duration;
+	int err = 0;
 	bool fw_up;
 	int opcode;
 	bool done;
-	int err;
 
 	/* Wait for dev cmd to complete, retrying if we get EAGAIN,
 	 * but don't wait any longer than max_seconds.
@@ -554,6 +554,11 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 
 	if (!done && !time_before(jiffies, max_wait)) {
 		ionic_dev_cmd_clean(ionic);
+
+		/* allow caller to manage EAGAIN from previous attempt */
+		if (err == IONIC_RC_EAGAIN)
+			return -EAGAIN;
+
 		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
 			 ionic_opcode_to_str(opcode), opcode, max_seconds);
 		return -ETIMEDOUT;
@@ -562,13 +567,13 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	err = ionic_dev_cmd_status(&ionic->idev);
 	if (err) {
 		if (err == IONIC_RC_EAGAIN &&
-		    time_before(jiffies, (max_wait - HZ))) {
+		    time_before(jiffies, max_wait - msecs_to_jiffies(50))) {
 			dev_dbg(ionic->dev, "DEV_CMD %s (%d), %s (%d) retrying...\n",
 				ionic_opcode_to_str(opcode), opcode,
 				ionic_error_to_str(err), err);
 
 			iowrite32(0, &idev->dev_cmd_regs->done);
-			msleep(1000);
+			msleep(50);
 			iowrite32(1, &idev->dev_cmd_regs->doorbell);
 			goto try_again;
 		}
-- 
2.17.1


