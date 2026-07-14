Return-Path: <netdev+bounces-307585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FjanDA2ZVmpT+wAAu9opvQ
	(envelope-from <netdev+bounces-307585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F8758ADD
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=iDYVIJAj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307585-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 867FA302263F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A5427FB1;
	Tue, 14 Jul 2026 20:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3D427F80
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:15:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060150; cv=fail; b=WJJXS68ro5GbOlwb6uuh68IfRy5ANCJ6gFyughraMiTKItxCxMI8biavyBb8e8yahPR++lUw1ukZ50sHLkfxjvDbjPD9jbFKNv7i1iLNBW5mghxw0BMRL6p6ymBN+aQH/ECjO82ZWkpRds0zFiFEc7xZmt7HgtN7vhSXeaTu0tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060150; c=relaxed/simple;
	bh=A8LOH/J7FGfLk4F3CBt6nmoekWM4hNT8hAJxveKr9rY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2JAuNzhhlCz6HkE+vBFPoL8k1xsrQCQaYBJN2SDgV2r/EmL1rPXqcxszneCUFzCrKXDaT8C1LCS6LeU1sKLv78CmlRhmLG2H68ZKDC7/fzJOp2NiB5boJ4c5zeV/lBR97WmTDSplEN5In/mLtszYF3xMqZRc/UAHpYQMs11UM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iDYVIJAj; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPvxRWrReuRs8GOfC7bR+UfGx4IKMJx3DvhUpBFn0BGj76//QnP+1uvnpRc9fwfhiWsj4kGGlK005nQr+WRGl0uYL6O00NB4BAjbBHfV4g4QKu/q7YYHkCxW175ihBPNm/hjn9ZHmZDfb7o8prs2kEDG2Jl9v54/lx4i7VHgwCZQEbRzvtsdiVnh0L6YUvuKe8Y/68ERo5KZCeYfiYVxm0lu+YTNkBLYJO6Z+dmxtr766ONlAu2LUCwBYwMMuqSmV+H1Kgg/cIIgGq7t3mCNXMjCZeGNwzGJWJSDhYiPIPB5HYhBTQUTTAhxWYPQM5Wlm0K8dZ3lclJuff6djw6KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jitiAKHjB4KTMMW+ZUEfEPCTOtbpGVXc3AcSTZppTBY=;
 b=mVp1GdX5eB3MjLiRh7o6B2T+FgM3fgdotDwnZy4o6nfIcCUVjc3ni+0ZQU9+hnCbjrfkmR3k9Gu6OZjQg8vHNYZ4gGllWYCoT73y7Bw6Zm45hEh1w7C1X90BDpZQAqerjfX4WT3AZeJ+HmeyiNsVnggRwKBqxjHhItZN6dOU/SeyyhyI3vHk+1/ro6mpRCelpyO63fSxUabS1l1xMr6wOXHzlyHrc2ZTNyR9kk/omgZOh300nSXb19lOn7Rei9p/cZFUsrTePOK+lqBUokxmJ6MAx6EA6oyNoawDD0n54p6P0Xw+u6WAic0XeZH9VxWpP/c1shqKZcLraRHQguBx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jitiAKHjB4KTMMW+ZUEfEPCTOtbpGVXc3AcSTZppTBY=;
 b=iDYVIJAjSie6f60lRadH7a6bBzu9buxrWTXaouzuQW2zbcuQmqhl+jdxOns5TUAmODd3mNsKQUQkQUlB4+vzTB839sHx5I/NH6hB5bGlghq7iPHPXWJxChUD63R9n+EEzvsKGTeU/UQ420QCnB8i/0t+5Z795xLtihx/YWV+Y2A=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 20:15:44 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::6) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 20:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:15:44 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 15:15:43 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: yield the CPU while waiting for the adminq to drain
Date: Tue, 14 Jul 2026 20:14:56 +0000
Message-ID: <20260714201456.1776153-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 5123be54-2f63-4011-4dd4-08dee1e4af47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	TmiNIwvPvF2f72NG/hDOsZAwpDnV4AK55uIBH/MqG0yVOTS1Br4rknmyD5tbTMaTGvc2T3mIbCKqb4dzYAlNFf+rQp6xQHUnKmaQ5DE3d1oHCrEj3SP8e7+Qgj/6HjSLkBBlW4vZrTok7gl91R9ZSFIZhLvHmyupX10flD2C4U+Ta8EOrlq7jAsVNcu37KNRI+fnRHAU8QlWq15OiabCEKf8zbxrlxKSnaUXXZDJoMwl6JKDs2UkS7uIdK2Mq9nAu/miLHoK8Fo/lOtga0vdRa/0T6cXW7/9WrsYe9D8SSIYBrlczItymKNGk27WElrrUP95dFk6K+AjX06XVzigOdLo91A8MyvsemiTRTsDj0jupMdCddqJ2sLSWdzf3ViPKfxKh1OAMoKc9RvcsKfMAUVTXsKizczbT2yh18FtISclUIyVvJSrYQi8MPRKwTgnntCULEAYXbGcKsyce+9HEjpln2aKWEZesosddEjZwTLbYsK5zjnLAa64CpYRnT5LKjAl2PeIgrfzyI272r5BOH73C+icOfG29JTBFZDfF3vl/WszhWPfwloc6Uqk4RCDdiWVET1G04L2ktL31Ucr5WSWvWkKAPWcpX1Wrsgfw8hVuPMqry3TODtSsntRtrmjX2uqUMOKNIOy6pfM4b8RbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fXVCZ2sybM6ifcI91rnaITdDdR2mUOdwDv50XRVSoUIrZfLmNGspKNILQDhIKGOd0iJXISefBw26BMAwxeT40ioYkbbaHuH7ojKmZG7PcfxTUpIuiF89jrUkCgrbsBrYz/fenZEuixEA/ZtTaoxqPtLsAJn/+g2p/dbSe/7yIlfpi23rJhnGhC2ntbrj0tHSxKiOAAZZfYwodvtSNhDIMV2ORCnNCax7Y8RpsZAI/XMj/A20aPu+papwm6KS2nNMAJITJ+QZPizFD54ZGaMt/k3nICLn3punLwXoEAr/QaNJZe6jbVsexf0H4zs/AWg+R0tNaDnhK4jKsS5o0Tz0mrSy0J0S0tAV6sgsVmQuyEgS+1oNTcdUaKzmAZ6MkPOgbKlYNwN3ndm0r9FXbhBtmuWzSZJzQdLqAO7qYR4Wvq1YTpsGn7M6EkrRy1Mu6D0K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:15:44.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5123be54-2f63-4011-4dd4-08dee1e4af47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307585-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:mid,amd.com:email,amd.com:dkim,vger.kernel.org:from_smtp,sashiko.dev:url];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0F8758ADD

pdsc_adminq_wait_and_dec_once_unused() busy-waits for adminq_refcnt to
drop to one:

	while (!refcount_dec_if_one(&pdsc->adminq_refcnt))
		cpu_relax();

The refcount is held by pdsc_adminq_post() for the duration of an
in-flight command, which can wait up to devcmd_timeout seconds
(PDS_CORE_DEVCMD_TIMEOUT is 5) for the hardware to complete. cpu_relax()
is not a reschedule point, so on a non-preemptible kernel this loop can
spin on the CPU for several seconds, starving other tasks on that core.

Add cond_resched() to the loop so the waiter yields to other runnable
tasks while it polls, keeping cpu_relax() as the busy-wait hint between
checks.

Fixes: 7e82a8745b95 ("pds_core: Prevent race issues involving the adminq")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 38a2446571af..19eeb5b06f4d 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -533,6 +533,7 @@ static void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
 		dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
 				    __func__);
 		cpu_relax();
+		cond_resched();
 	}
 }
 
-- 
2.43.0


