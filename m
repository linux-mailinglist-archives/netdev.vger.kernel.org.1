Return-Path: <netdev+bounces-303991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jo3nE3MERmqrHwsAu9opvQ
	(envelope-from <netdev+bounces-303991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:25:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9226F3CAA
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:25:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TPGvykes;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303991-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303991-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3339302C3C0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BE438B127;
	Thu,  2 Jul 2026 06:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F138AC7C;
	Thu,  2 Jul 2026 06:24:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973482; cv=fail; b=ZkvdUd3MlbXxDi+P2L6SLHMmQgmuOdkp2UcuKyGa2+oeBi0kZy43/+ee2E2poHJEcxAa1fAOGKD3JFwXvHXzGh8Jp2QIIaeeLhva2ZtbHOPKAk2qRWINfFJmRUyO08BRb5TCFHHIPnBZuLZ/DAdGS6+S+Gy6yqDPBzLnur29ls8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973482; c=relaxed/simple;
	bh=NavQOWDGtSduDgCBykMN4fYbMGODT6VJwXyqLRj5WLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnHPBVD8SxPovMYPweRynSFXaknDsEIqD7uDPruEo6VjxyjjuI+loR6XmJ1v6gcw0c+oPHnruzScfnV6gRAQCcUWuj39/kYdPEawzCOnVYWgB50JVCLxLvCB/72plhb4rwkvT0AFufKmrD6uMGaqOzLQeSFAYHNUnr5KGY2gEL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPGvykes; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDGnhyEKfREeG5NJ9wZnxWglZ7fSpZjNc+oISpXFwLNmNCnRZHmNA9HfYA1UdG9PFhMX8sRaUVjVthJT2wLfmfy+fNwzLV3+M+VMR1sfylehizNkvT4cGC9SjuUaaVOSQoqcKkLcxNufUUqTyzInDey+zu/lQrtjgHXPr3XLoQYWdaqZk2e0uyIQzsYpFm32KPXiz1/mKNHpHTWUfK3RwTitOEtHXMgTNHYD7N/Fc0286VfVxXm+xWcNXhgNF4PxG+H3gQsO1hRS2+zqnh9EIDikhvRlmENjIFJ8fgcgxCw35EBIGj3sMIMiyRn6sJPpsS56nPxZnxgYe2+A3FPj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwpY1hL5/2oRrVH3xusOME+WKeAW1y7BAHEUKM13eFM=;
 b=C7o/nBT7TEnyuXIR54ey4Cal6Logzuqpbj9JJ1NI/YNCeR5VVRP2DGpNynMmNHi/IszDbJn4zp4HHU3mr5vDhME2sBO9LI8SDlfQyoCyACldZxNGSGpXw0UW0Z3TBD3RyQ4OntxLB32mzZIGklnp8YSXJ0mJf+9uSa7kF3076wbkqAmoLDfaJG3jglHnb7swYv7Nh07l40iT8oPyUWQnYREgzghFk6lZ2h2B7Y7MRh8Cez7m40TkwPgXoZ/S7bHic1Bz9hJCa3yHm6ZfjA5MeJgnSbSr70xSAJQ6fWjfePD1LfVyUCJpjYRX2mKmZBJQ7Js5Xa52RFRKXCGlQriPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwpY1hL5/2oRrVH3xusOME+WKeAW1y7BAHEUKM13eFM=;
 b=TPGvykesXVFxfUrx7CVmBb6lpEX1jg50HDRObqvWNYR9kLxASknBsQ+PpqgyvkrZjXVGY44J7TNDTLbLIWNh0Pm6OK0aPj59FvvP1wjQUQ9B9dhQq5o+K+WXRUTQ3f8CeMlJzlyTp6P/oBzuL7Kb2GLr/TQt6IXWLJy8jhQ785TaY3pUioICEQOlPj6G2qImGdWd/9VsoilrqrULTKFT0XqaHoXtURjBbRFo7FwbuNRwxquakNRWDUXPKbL5nHTW1GVdIQx989dMGTAsyyFNpQN2PKsrvYL7jE9/bCFxVtRp+uab3m4to/IGAuz8PtEp3W17TX7LmHzMnyGqoDkUlQ==
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 06:24:25 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::7d) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 06:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 06:24:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 23:24:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 23:24:10 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Jul 2026 23:24:05 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>, Willem de Bruijn
	<willemb@google.com>, Wei Wang <weibunny@fb.com>, David Wei <dw@davidwei.uk>,
	Cosmin Ratiu <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: drv-net: xdp: run with both IP versions
Date: Thu, 2 Jul 2026 09:23:48 +0300
Message-ID: <20260702062348.2123960-3-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260702062348.2123960-1-noren@nvidia.com>
References: <20260702062348.2123960-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e42912-1420-4b1e-c27c-08ded8028fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WDslS0Ly1seWWI/CcL4ixxa2ajf3ecZ/E9/oY24PBl/3VllH91i3aCplI1useZuz6naeuxXp8TTydEinfQ1k7NLRa6jNQCZWflPtbxBGfOpBp0GIR4jBZ7MYR9s+WG3UNqzn/2ogVps9YWZIUJvEIL+V73NGYrkMTcIsGvNFti+L2uAnalw6WdrkP9oyG0BG/APhOsLpdri49gqKo/tQLKa6oWUnWEOZcf8oeBxjAH0+K1tPyseoBrmT/1VPhMyKtfUqkW4N+pFhlkdt4eg2qtZW+nWVdMyNooA7x6ptHZAHPAZ8b8DgRZP2DzsPLgf0mgobzS52ugW9YrklxBqpmXXKc6mTwENsTCvLNz90IbrAXvepqyJMzKj7fagUAtfsaXkBIYcqgczmEvBrwDhpLM3xglX//vfAM4hDXdEDobDAOt/sh4Uwi8Cf0cxqU+VsAAWQAy0Zic+/U8VBPnmCHyiIXH75OVl4J706W219rBlZ4jFGA6w/HoNEdGDiE2xKbHKQLseX766pUBoJCi7OjexSnH/qwswEBkw0jFFM17cW0/1HOiGGcrbjUatxJK4/J2F8TyeUiD8M57cwSTxR7Yr5R3hCws3zHoHhGqxYvBEXIKzDgZ8EtZd6vuMq9W+6GKx7qzCUhCZx9fJmAll1KrV99KwymrK1FBOTCDY76z8iowwicwo1Y8CMNtR2wt7+7vxXt8pOtmejtDNxUG6jZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xguh54AF0j/IO9Y184ewrgcW24c0+8HlWm3JWfLchk+A0EWwRmNWXubfigTVsW29CtxJpjdIni58PvQ7iYpwsY1T7hYSoAJLhGaZK+J+gtt6sAQKlx0cVnvH51EAsBxrG062vBp16EYOfvkspoD6UZCmgfs6DKUH+m+60ZkT3tKoriJneVGQDteSJiSqf38zyMZ0QwR6dtkh27HeXtGWwI0F6IHBcAqbvFAmk8uHq78+8nxk/cTiqxXrbUwBMpltCJabj6T6AzNhelprcyzf0mShbbiD7uR6T00zbn7nhpNJko/zPbGyPSR3lr38QcGlT83PRlQpI+w0P4HVGIqGMChTgTiATNgoAZpvbGBKOnYBIyL9LWC4arL4KwpSIMFLi83wiB0LqIV/MCVvR1ft7h/ZP1Hrh6BDHfWqsUS0Ll4f44zaVCZmgnp+Jm1iPvPS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:24:24.4594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e42912-1420-4b1e-c27c-08ded8028fbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,google.com,fb.com,davidwei.uk,nvidia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bobbyeshleman@meta.com,m:willemb@google.com,m:weibunny@fb.com,m:dw@davidwei.uk,m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:noren@nvidia.com,m:cjubran@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303991-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C9226F3CAA

Parameterize test cases by IP version using @ksft_variants. Set the
environment's IP version at the start of each case using a new local
helper, which also handles restoring the original value via defer().

The last case is left unparameterized because it does not send traffic
or exercise IP-version-specific code.

While here, fix an int vs str comparison bug `if cfg.addr_ipver == 4`.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 94 ++++++++++++++++++----
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 2ad5932299e8..0369929f3c51 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -172,25 +172,45 @@ def _test_pass(cfg, bpf_info, msg_sz):
     ksft_eq(stats[XDPStats.RX.value], stats[XDPStats.PASS.value], "RX and PASS stats mismatch")
 
 
-def test_xdp_native_pass_sb(cfg):
+_ipvers = [
+    KsftNamedVariant("ipv4", "4"),
+    KsftNamedVariant("ipv6", "6"),
+]
+
+
+def _set_ipver_defer_restore(cfg, ipver):
+    old_ipver = cfg.addr_ipver
+    cfg.set_ipver(ipver)
+    defer(cfg.set_ipver, old_ipver)
+
+
+@ksft_variants(_ipvers)
+def test_xdp_native_pass_sb(cfg, ipver):
     """
     Tests the XDP_PASS action for single buffer case.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
 
     _test_pass(cfg, bpf_info, 256)
 
 
-def test_xdp_native_pass_mb(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_pass_mb(cfg, ipver):
     """
     Tests the XDP_PASS action for a multi-buff size.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
 
     _test_pass(cfg, bpf_info, 8000)
@@ -219,25 +239,33 @@ def _test_drop(cfg, bpf_info, msg_sz):
     ksft_eq(stats[XDPStats.RX.value], stats[XDPStats.DROP.value], "RX and DROP stats mismatch")
 
 
-def test_xdp_native_drop_sb(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_drop_sb(cfg, ipver):
     """
     Tests the XDP_DROP action for a signle-buff case.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
 
     _test_drop(cfg, bpf_info, 256)
 
 
-def test_xdp_native_drop_mb(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_drop_mb(cfg, ipver):
     """
     Tests the XDP_DROP action for a multi-buff case.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
 
     _test_drop(cfg, bpf_info, 8000)
@@ -287,13 +315,17 @@ def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
         ksft_eq(stats[XDPStats.TX.value], expected_pkts, "TX stats mismatch")
 
 
-def test_xdp_native_tx_sb(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_tx_sb(cfg, ipver):
     """
     Tests the XDP_TX action for a single-buff case.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
 
     # Ensure there's enough room for an ETH / IP / UDP header
@@ -302,13 +334,17 @@ def test_xdp_native_tx_sb(cfg):
     _test_xdp_native_tx(cfg, bpf_info, [0, 1500 // 2, 1500 - pkt_hdr_len])
 
 
-def test_xdp_native_tx_mb(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_tx_mb(cfg, ipver):
     """
     Tests the XDP_TX action for a multi-buff case.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o",
                            "xdp.frags", 9000)
     # The first packet ensures we exercise the fragmented code path.
@@ -447,13 +483,17 @@ def _test_xdp_native_tail_adjst(cfg, pkt_sz_lst, offset_lst):
     return {"status": "pass"}
 
 
-def test_xdp_native_adjst_tail_grow_data(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_adjst_tail_grow_data(cfg, ipver):
     """
     Tests the XDP tail adjustment by growing packet data.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     pkt_sz_lst = [512, 1024, 2048]
     offset_lst = [1, 16, 32, 64, 128, 256]
     res = _test_xdp_native_tail_adjst(
@@ -465,13 +505,17 @@ def test_xdp_native_adjst_tail_grow_data(cfg):
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
-def test_xdp_native_adjst_tail_shrnk_data(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_adjst_tail_shrnk_data(cfg, ipver):
     """
     Tests the XDP tail adjustment by shrinking packet data.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     pkt_sz_lst = [512, 1024, 2048]
     offset_lst = [-16, -32, -64, -128, -256]
     res = _test_xdp_native_tail_adjst(
@@ -535,7 +579,7 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
             # after we eat into it. We send large-enough packets, but if HDS
             # is enabled head will only contain headers. Don't try to eat
             # more than 28 bytes (UDPv4 + eth hdr left: (14 + 20 + 8) - 14)
-            l2_cut_off = 28 if cfg.addr_ipver == 4 else 48
+            l2_cut_off = 28 if cfg.addr_ipver == "4" else 48
             if pkt_sz > hds_thresh and offset > l2_cut_off:
                 ksft_pr(
                 f"Failed run: pkt_sz ({pkt_sz}) > HDS threshold ({hds_thresh}) and "
@@ -579,18 +623,22 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
     return {"status": "pass"}
 
 
-def test_xdp_native_adjst_head_grow_data(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_adjst_head_grow_data(cfg, ipver):
     """
     Tests the XDP headroom growth support.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
 
     This function sets up the packet size and offset lists, then calls the
     _test_xdp_native_head_adjst_mb function to perform the actual test. The
     test is passed if the headroom is successfully extended for given packet
     sizes and offsets.
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     pkt_sz_lst = [512, 1024, 2048]
 
     # Negative values result in headroom shrinking, resulting in growing of payload
@@ -600,18 +648,22 @@ def test_xdp_native_adjst_head_grow_data(cfg):
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
-def test_xdp_native_adjst_head_shrnk_data(cfg):
+@ksft_variants(_ipvers)
+def test_xdp_native_adjst_head_shrnk_data(cfg, ipver):
     """
     Tests the XDP headroom shrinking support.
 
     Args:
         cfg: Configuration object containing network settings.
+        ipver: IP version to use ("4" or "6").
 
     This function sets up the packet size and offset lists, then calls the
     _test_xdp_native_head_adjst_mb function to perform the actual test. The
     test is passed if the headroom is successfully shrunk for given packet
     sizes and offsets.
     """
+    _set_ipver_defer_restore(cfg, ipver)
+
     pkt_sz_lst = [512, 1024, 2048]
 
     # Positive values result in headroom growing, resulting in shrinking of payload
@@ -621,12 +673,19 @@ def test_xdp_native_adjst_head_shrnk_data(cfg):
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
-@ksft_variants([
-    KsftNamedVariant("pass", XDPAction.PASS),
-    KsftNamedVariant("drop", XDPAction.DROP),
-    KsftNamedVariant("tx", XDPAction.TX),
-])
-def test_xdp_native_qstats(cfg, act):
+def _qstats_variants():
+    actions = [
+        ("pass", XDPAction.PASS),
+        ("drop", XDPAction.DROP),
+        ("tx", XDPAction.TX),
+    ]
+    for ipver in ["4", "6"]:
+        for name, act in actions:
+            yield KsftNamedVariant(f"{name}_ipv{ipver}", act, ipver)
+
+
+@ksft_variants(_qstats_variants())
+def test_xdp_native_qstats(cfg, act, ipver):
     """
     Send 1000 messages. Expect XDP action specified in @act.
     Make sure the packets were counted to interface level qstats
@@ -634,6 +693,7 @@ def test_xdp_native_qstats(cfg, act):
     """
 
     cfg.require_cmd("socat")
+    _set_ipver_defer_restore(cfg, ipver)
 
     bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
     prog_info = _load_xdp_prog(cfg, bpf_info)
-- 
2.45.0


