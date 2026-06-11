Return-Path: <netdev+bounces-298047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rlXqBUKGKmrxrgMAu9opvQ
	(envelope-from <netdev+bounces-298047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E296709E4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:56:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=vLSR6WIm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298047-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298047-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BB933A4ABD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FC3C5544;
	Thu, 11 Jun 2026 09:50:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AD3C5542;
	Thu, 11 Jun 2026 09:50:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171448; cv=fail; b=aCAONgFbsPTAq2Rjv1ppDHE448aGa/tstdQW/YlTl1SO86CavfOkRtLU96O3wya1EYLiKqc9ltZTQXWPvk2J7vN6hYO4ZoiRyeh2E25aGISUN840i6DjZ9EQXVSxFYFJxXfhv7XRHNsPYAW0F0ZfgmUIB4sI/v0zdojsZBPN5n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171448; c=relaxed/simple;
	bh=ssNyOlBbwPxN68vpXg0rp/OvRDi4pcEABiUtAXbkm3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taJRvKIsmeGysr2ufndqad6+KSvBqLDKdQjQ9gODg5VneQUcVkbqXxD/cdGNU2kqEt9cnG0ofPCt6FsoZ91595EzNqPYz5rICGMvlpWTcUBNk5piczb0tY7CT6RXDSyNA47wSvmhM4uMYp7vxJDwk1Verj+sjmpVp91nVWvgAZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vLSR6WIm; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPI5Hwf2HE0UTwId+3JfC1kFGH2UhiFBq8I3aLSpdKfDH/Qz59SwXM9upuyPOSnjsV3dK3E0PnypwI2qMwhjPUMmKoo/+JluimLzGVa6YKs2NFkn/yT/67uMT4nCKk/brhemI0smqIS7hzjP0dYeJ2mRtvp32pJN/UYSphDg78UWayj5Q992SbhbM+/e+U6bj6J8X1rx+7/U94u/vGqkZowp+Yr2UNOIKFbDv4s0Dm+FMfS9/AH/rvTdFUmcxinLWo4tTYD2ZAmi0rAncMUUWk/Eg9KXTGDEyjOI9zJc6N5c6Bt1JzV5YoldG378Bu3ic2/6GRlHCSPzLwvBUL5v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmihmPp6m7u7jDCA0HTd26bawjOukfGnQoi2jFyhrhI=;
 b=C7GhWA1zz9LVkIXwIjC1eNfkxeSGbGxznkfPmb/1PM7i/3FMTeBlbh2wEfVmoQywUHUlvhTj2Qb5PNWlV1hFhtRrTQibJFc08Fn5/rBXwEUS74rruFalwhWaQ7a/N986pYvXZDuQcsv/hGwyBaS3Zs6TSiBhTeGHUz25WOKrNfuwResOIfGC83QftbD6sLMoXRR+HgNzlFmbpHxSB17jeUbTDSpdpeDP0yURXlVehALi3ciGloWKzzjSsO1ABVl2qPGlcPnGge+6l517aL6J7mNZU+U6sK+mwhyMQj4gAcpkHvZqo/CXS8y5QANCzma50nk/KUAIzTy5th7ne3U31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmihmPp6m7u7jDCA0HTd26bawjOukfGnQoi2jFyhrhI=;
 b=vLSR6WImbmGxNeeBsOcsTdq1PuTqRdi34re1rtViqIXjUOtuYWsOxlgcg7KBges9w55yjMRXPT6ueOhOtoYpwTtW9MxgG2CzAQYjnH/Iacd33mIjvI8F7jCOStebqGg4BaXmv3UHw0a18Er0bVSbM+yUVlp3ipBlkytcmal5m1M=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 09:50:43 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::84) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Thu,
 11 Jun 2026 09:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:50:42 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:42 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 04:50:41 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65B9ofZv1062397;
	Thu, 11 Jun 2026 04:50:41 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65B9oeYm014464;
	Thu, 11 Jun 2026 04:50:41 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	"Markus Elfring" <elfring@users.sourceforge.net>, Hangbin Liu
	<liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>, Jan
 Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v4 1/3] net: hsr: Add standard LRE stats via RTM_GETSTATS / IFLA_STATS_LINK_XSTATS
Date: Thu, 11 Jun 2026 15:20:33 +0530
Message-ID: <20260611095035.852370-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611095035.852370-1-danishanwar@ti.com>
References: <20260611095035.852370-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ0PR10MB4702:EE_
X-MS-Office365-Filtering-Correlation-Id: a0437ba7-d199-459d-f717-08dec79ee6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|7416014|18002099003|22082099003|3023799007|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	svZKG3naxrbs3tabD3olIHxrG90L8TgtwCZePZKWeyBDFMipiD94fLEG6oMYVnqcp1PSgp+hDYL6Fp3kcTQEUaJug3bzsj7OtHDwMRG2tW++UKghOFF27MCHYKR71qMsBjGjXIOdP4xxENw3UR+DMOXRGrM58bRegAiIMIbeyUHo8EcyVvWiX7hjPvXi7piswHG5UMroUdNOayBGaCve+gvT6VXAaHivi4WzRCoqYU8jJXYStZTxg5unnRjnHezbE/MZbDr2KsnbQk6+iQov7LM/d5Hf2bTbDRE//fbefwyseEtIT4+5vBdbfCtc1Sg/QEvqCojDROSTJ5DuuHGPon3kxoyhdsAw2seV03bYf0SpBnD+cY1fKa9b6sHT5Gnb/3Mf1ld7h1nliZDpjfApsX1oZaF++YhHNaHnSfncCyho9gAgaekMgrCoDbIufkZXQd0ENJaXFjEIUrHoUN7ite++9JtrzTCTxyG82rTE9XoeILSNKHY87JE5UizNwe62E/iVX+5PWiZc+b+eIDxtS4dBTQQkz0N+Azh2Lq5jI3EJa6mxzqTxda/o9Fk+mRWj/+dUXeJeus9DZmLYy3H6zVSjxz12iVDDawCygxaY06OIRjVaSrNzaRN049gpqamkHNQ1rUAJKHLsO2iEzwxc5/Qz5EIIBXZgkC3drcBCTAtJOReeEeSh+4Ilaxt57Zq/334/psS+hU0OWwn7qefDyH9ZWb4IXDkBKcW26C0IlELGH4mxXjOU1lqQPjtgZA9AuTFwhyAptkMngdhaZmUvbw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(7416014)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gEyDR6PCDpyE33X/sRftlC4DRPiv+B1vgcGSwN5OK9+p5HH631nd3XpzNFY+xFucARNByCRR69iXGRfLQ/ZLZpS9Kh0hE7fosve5q+8oYWl1jkGynF5vlqXrOqYq0B5inAPPzQ3Jei8OCf2QQnsOkpF4+kJ5ZSGf218/TvRz4Cee+q9iixgq8nZoNYQP/sBVl6aHgr2c/GwxlzvDokAHdMkLaPbByqqFnAjavK1c8F1r7biSlworEXvxOIIMGCfJY9iezQPzWF17YOiq+nsHfooWqopQxen8sEvY3e2DNRne1jK9prmH5T46ukqutUpwOfpzbpPmqN4imGZJcnSh1P01xXvshBcPfrQL9nEYac3Gl2zwC9IQNzzDLBTrhudHT7VTJlNDb1dwuaioXNc1QVJRbsXGQHSwHrM38Kg6XckCTVqSCMqNtJxoR7Q2XXqn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:50:42.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0437ba7-d199-459d-f717-08dec79ee6f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298047-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81E296709E4

Per the IEC-62439-3 specification the Link Redundancy Entity (LRE)
maintains a well-defined set of counters applicable to both software
and offloaded HSR/PRP implementations. Define these counters as
individual netlink attributes inside a LINK_XSTATS_TYPE_HSR nest,
following the approach used by bridge and bond with IFLA_STATS_LINK_XSTATS.

The full IEC-62439-3 MIB counter set is represented, with per-port (A,
B, C) granularity where applicable:

  lreCntTx{A,B,C}          - sent HSR/PRP tagged frames per port
  lreCntRx{A,B,C}          - received HSR/PRP tagged frames per port
  lreCntErrWrongLan{A,B,C} - received frames with wrong LAN ID (PRP)
  lreCntErrors{A,B,C}      - received frames with errors per port
  lreCntUnique{A,B,C}       - frames received without duplicate
  lreCntDuplicate{A,B,C}    - frames received with exactly one duplicate
  lreCntMulti{A,B,C}        - frames received with more than one duplicate
  lreCntOwnRx{A,B}          - own-address frames received (HSR only)

Each counter is encoded as its own HSR_XSTATS_* u64 netlink attribute.
Unsupported counters are initialised to ~0ULL by the kernel and omitted
from the netlink reply; user-space must treat an absent attribute as
"not available".

The UAPI attribute enum (HSR_XSTATS_*) is added to hsr_netlink.h.
LINK_XSTATS_TYPE_HSR is added to the LINK_XSTATS_TYPE_* enum in both
include/uapi/linux/if_link.h and tools/include/uapi/linux/if_link.h.

A kernel-internal struct hsr_lre_stats (in linux/if_hsr.h) is provided
for offload drivers to fill via ndo_get_offload_stats. Unsupported
fields must be left at the ~0ULL value initialised by the HSR layer
before calling the NDO.

The HSR stack calls ndo_get_offload_stats on slave A to collect offload
counters.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 include/linux/if_hsr.h             |  48 +++++++++++
 include/uapi/linux/hsr_netlink.h   |  56 +++++++++++++
 include/uapi/linux/if_link.h       |   2 +
 net/hsr/hsr_netlink.c              | 130 +++++++++++++++++++++++++++--
 tools/include/uapi/linux/if_link.h |   2 +
 5 files changed, 230 insertions(+), 8 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..b8c20f0906194 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -38,6 +38,54 @@ struct hsr_tag {
 
 #define HSR_HLEN	6
 
+/**
+ * struct hsr_lre_stats - Kernel-internal IEC-62439-3 LRE counter set.
+ *
+ * This is the buffer type written by ndo_get_offload_stats() when called
+ * with attr_id == IFLA_STATS_LINK_XSTATS on an HSR slave device.  Each
+ * field maps to one HSR_XSTATS_* netlink attribute.  Fields that the
+ * offload driver does not support must be left at the initialised value of
+ * ~0ULL; the HSR layer will skip those when building the netlink reply.
+ *
+ * Per-port suffix: _a = port A (slave 1 / LAN-A),
+ *                  _b = port B (slave 2 / LAN-B),
+ *                  _c = interlink / application interface.
+ *
+ * @cnt_tx_a: lreCntTxA - sent HSR/PRP tagged frames on port A.
+ * @cnt_tx_b: lreCntTxB - sent HSR/PRP tagged frames on port B.
+ * @cnt_tx_c: lreCntTxC - sent HSR/PRP tagged frames on port C.
+ * @cnt_rx_a: lreCntRxA - received HSR/PRP tagged frames on port A.
+ * @cnt_rx_b: lreCntRxB - received HSR/PRP tagged frames on port B.
+ * @cnt_rx_c: lreCntRxC - received HSR/PRP tagged frames on port C.
+ * @cnt_err_wrong_lan_a: lreCntErrWrongLanA - wrong LAN ID frames on port A.
+ * @cnt_err_wrong_lan_b: lreCntErrWrongLanB - wrong LAN ID frames on port B.
+ * @cnt_err_wrong_lan_c: lreCntErrWrongLanC - wrong LAN ID frames on port C.
+ * @cnt_errors_a: lreCntErrorsA - received frames with errors on port A.
+ * @cnt_errors_b: lreCntErrorsB - received frames with errors on port B.
+ * @cnt_errors_c: lreCntErrorsC - received frames with errors on port C.
+ * @cnt_unique_a: lreCntUniqueA - frames received without duplicate on port A.
+ * @cnt_unique_b: lreCntUniqueB - frames received without duplicate on port B.
+ * @cnt_unique_c: lreCntUniqueC - frames received without duplicate on port C.
+ * @cnt_duplicate_a: lreCntDuplicateA - frames with one duplicate on port A.
+ * @cnt_duplicate_b: lreCntDuplicateB - frames with one duplicate on port B.
+ * @cnt_duplicate_c: lreCntDuplicateC - frames with one duplicate on port C.
+ * @cnt_multi_a: lreCntMultiA - frames with more than one duplicate on port A.
+ * @cnt_multi_b: lreCntMultiB - frames with more than one duplicate on port B.
+ * @cnt_multi_c: lreCntMultiC - frames with more than one duplicate on port C.
+ * @cnt_own_rx_a: lreCntOwnRxA - own-address frames received on port A.
+ * @cnt_own_rx_b: lreCntOwnRxB - own-address frames received on port B.
+ */
+struct hsr_lre_stats {
+	u64 cnt_tx_a, cnt_tx_b, cnt_tx_c;
+	u64 cnt_rx_a, cnt_rx_b, cnt_rx_c;
+	u64 cnt_err_wrong_lan_a, cnt_err_wrong_lan_b, cnt_err_wrong_lan_c;
+	u64 cnt_errors_a, cnt_errors_b, cnt_errors_c;
+	u64 cnt_unique_a, cnt_unique_b, cnt_unique_c;
+	u64 cnt_duplicate_a, cnt_duplicate_b, cnt_duplicate_c;
+	u64 cnt_multi_a, cnt_multi_b, cnt_multi_c;
+	u64 cnt_own_rx_a, cnt_own_rx_b;
+};
+
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
diff --git a/include/uapi/linux/hsr_netlink.h b/include/uapi/linux/hsr_netlink.h
index d540ea9bbef4b..c414a2bb93b79 100644
--- a/include/uapi/linux/hsr_netlink.h
+++ b/include/uapi/linux/hsr_netlink.h
@@ -48,4 +48,60 @@ enum {
 };
 #define HSR_C_MAX (__HSR_C_MAX - 1)
 
+/* HSR/PRP LRE extended statistics attributes.
+ * Reported inside LINK_XSTATS_TYPE_HSR (RTM_GETSTATS / ip stats show).
+ * Counter definitions follow IEC-62439-3 MIB naming.
+ *
+ * All counters are __u64.  Unsupported counters are omitted from the
+ * netlink reply; user-space must treat an absent attribute as "not available".
+ *
+ * Per-port suffix: _A = port A (slave 1), _B = port B (slave 2),
+ *                  _C = interlink / application interface.
+ */
+enum {
+	/* Sent HSR/PRP tagged frames per port */
+	HSR_XSTATS_CNT_TX_A = 1,
+	HSR_XSTATS_CNT_TX_B,
+	HSR_XSTATS_CNT_TX_C,
+
+	/* Received HSR/PRP tagged frames per port */
+	HSR_XSTATS_CNT_RX_A,
+	HSR_XSTATS_CNT_RX_B,
+	HSR_XSTATS_CNT_RX_C,
+
+	/* Received frames with wrong LAN ID (PRP only) per port */
+	HSR_XSTATS_CNT_ERR_WRONG_LAN_A,
+	HSR_XSTATS_CNT_ERR_WRONG_LAN_B,
+	HSR_XSTATS_CNT_ERR_WRONG_LAN_C,
+
+	/* Received frames with errors per port */
+	HSR_XSTATS_CNT_ERRORS_A,
+	HSR_XSTATS_CNT_ERRORS_B,
+	HSR_XSTATS_CNT_ERRORS_C,
+
+	/* Frames received with no duplicate per port */
+	HSR_XSTATS_CNT_UNIQUE_A,
+	HSR_XSTATS_CNT_UNIQUE_B,
+	HSR_XSTATS_CNT_UNIQUE_C,
+
+	/* Frames received with exactly one duplicate per port */
+	HSR_XSTATS_CNT_DUPLICATE_A,
+	HSR_XSTATS_CNT_DUPLICATE_B,
+	HSR_XSTATS_CNT_DUPLICATE_C,
+
+	/* Frames received with more than one duplicate per port */
+	HSR_XSTATS_CNT_MULTI_A,
+	HSR_XSTATS_CNT_MULTI_B,
+	HSR_XSTATS_CNT_MULTI_C,
+
+	/* Frames received matching this node's own address (HSR only) */
+	HSR_XSTATS_CNT_OWN_RX_A,
+	HSR_XSTATS_CNT_OWN_RX_B,
+
+	HSR_XSTATS_PAD,
+	__HSR_XSTATS_MAX,
+};
+
+#define HSR_XSTATS_MAX (__HSR_XSTATS_MAX - 1)
+
 #endif /* __UAPI_HSR_NETLINK_H */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 79ce4bc24cba6..11458f683624a 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1905,6 +1905,7 @@ enum {
 	LINK_XSTATS_TYPE_UNSPEC,
 	LINK_XSTATS_TYPE_BRIDGE,
 	LINK_XSTATS_TYPE_BOND,
+	LINK_XSTATS_TYPE_HSR,
 	__LINK_XSTATS_TYPE_MAX
 };
 #define LINK_XSTATS_TYPE_MAX (__LINK_XSTATS_TYPE_MAX - 1)
@@ -1915,6 +1916,7 @@ enum {
 	IFLA_OFFLOAD_XSTATS_CPU_HIT, /* struct rtnl_link_stats64 */
 	IFLA_OFFLOAD_XSTATS_HW_S_INFO,	/* HW stats info. A nest */
 	IFLA_OFFLOAD_XSTATS_L3_STATS,	/* struct rtnl_hw_stats64 */
+	IFLA_OFFLOAD_XSTATS_LRE_STATS,	/* struct hsr_lre_stats */
 	__IFLA_OFFLOAD_XSTATS_MAX
 };
 #define IFLA_OFFLOAD_XSTATS_MAX (__IFLA_OFFLOAD_XSTATS_MAX - 1)
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a6920..31aedf7460a47 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <net/rtnetlink.h>
 #include <net/genetlink.h>
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/hsr_netlink.h>
 #include "hsr_main.h"
 #include "hsr_device.h"
 #include "hsr_framereg.h"
@@ -189,15 +191,127 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
+/*
+ * Number of real HSR_XSTATS_* u64 counter attributes.
+ * Real counters run from HSR_XSTATS_CNT_TX_A(1) through
+ * HSR_XSTATS_CNT_OWN_RX_B(25); HSR_XSTATS_PAD is not a counter.
+ */
+#define HSR_XSTATS_CNT_ATTRS (HSR_XSTATS_PAD - 1)
+
+static size_t hsr_get_linkxstats_size(const struct net_device *dev, int attr)
+{
+	if (attr != IFLA_STATS_LINK_XSTATS)
+		return 0;
+
+	/* Nest header (LINK_XSTATS_TYPE_HSR) + one u64 nla per counter */
+	return nla_total_size(0) +
+	       HSR_XSTATS_CNT_ATTRS * nla_total_size_64bit(sizeof(u64));
+}
+
+/* Put a u64 counter attribute; skip if value is ~0ULL (unsupported). */
+static int hsr_put_stat(struct sk_buff *skb, int attr_id, u64 val)
+{
+	if (val == ~0ULL)
+		return 0;
+	return nla_put_u64_64bit(skb, attr_id, val, HSR_XSTATS_PAD);
+}
+
+static int hsr_fill_linkxstats(struct sk_buff *skb,
+			       const struct net_device *dev,
+			       int *prividx, int attr)
+{
+	struct hsr_priv *hsr = netdev_priv(dev);
+	struct hsr_lre_stats stats;
+	int s_prividx = *prividx;
+	struct hsr_port *port;
+	struct nlattr *nest;
+	int err;
+
+	if (attr != IFLA_STATS_LINK_XSTATS)
+		return 0;
+
+	*prividx = 0;
+
+	nest = nla_nest_start_noflag(skb, LINK_XSTATS_TYPE_HSR);
+	if (!nest)
+		return -EMSGSIZE;
+
+	/* Initialise all counters to ~0ULL ("unsupported") */
+	memset(&stats, 0xff, sizeof(stats));
+
+	/* Ask the offload driver (if any) via ndo_get_offload_stats on slave A.
+	 * Use IFLA_OFFLOAD_XSTATS_LRE_STATS, which is the correct identifier
+	 * from enum ifla_offload_xstats that these NDOs expect.
+	 */
+	port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_A);
+	if (port) {
+		const struct net_device_ops *ops = port->dev->netdev_ops;
+
+		if (ops->ndo_has_offload_stats &&
+		    ops->ndo_has_offload_stats(port->dev,
+					       IFLA_OFFLOAD_XSTATS_LRE_STATS) &&
+		    ops->ndo_get_offload_stats) {
+			err = ops->ndo_get_offload_stats(IFLA_OFFLOAD_XSTATS_LRE_STATS,
+							 port->dev, &stats);
+			if (err && err != -EOPNOTSUPP) {
+				nla_nest_cancel(skb, nest);
+				return err;
+			}
+		}
+	}
+
+#define PUT_STAT(attr, field) \
+	do { \
+		if (HSR_XSTATS_##attr < s_prividx) \
+			break; \
+		if (hsr_put_stat(skb, HSR_XSTATS_##attr, stats.field)) { \
+			*prividx = HSR_XSTATS_##attr; \
+			nla_nest_end(skb, nest); \
+			return -EMSGSIZE; \
+		} \
+	} while (0)
+
+	PUT_STAT(CNT_TX_A,		cnt_tx_a);
+	PUT_STAT(CNT_TX_B,		cnt_tx_b);
+	PUT_STAT(CNT_TX_C,		cnt_tx_c);
+	PUT_STAT(CNT_RX_A,		cnt_rx_a);
+	PUT_STAT(CNT_RX_B,		cnt_rx_b);
+	PUT_STAT(CNT_RX_C,		cnt_rx_c);
+	PUT_STAT(CNT_ERR_WRONG_LAN_A,	cnt_err_wrong_lan_a);
+	PUT_STAT(CNT_ERR_WRONG_LAN_B,	cnt_err_wrong_lan_b);
+	PUT_STAT(CNT_ERR_WRONG_LAN_C,	cnt_err_wrong_lan_c);
+	PUT_STAT(CNT_ERRORS_A,		cnt_errors_a);
+	PUT_STAT(CNT_ERRORS_B,		cnt_errors_b);
+	PUT_STAT(CNT_ERRORS_C,		cnt_errors_c);
+	PUT_STAT(CNT_UNIQUE_A,		cnt_unique_a);
+	PUT_STAT(CNT_UNIQUE_B,		cnt_unique_b);
+	PUT_STAT(CNT_UNIQUE_C,		cnt_unique_c);
+	PUT_STAT(CNT_DUPLICATE_A,	cnt_duplicate_a);
+	PUT_STAT(CNT_DUPLICATE_B,	cnt_duplicate_b);
+	PUT_STAT(CNT_DUPLICATE_C,	cnt_duplicate_c);
+	PUT_STAT(CNT_MULTI_A,		cnt_multi_a);
+	PUT_STAT(CNT_MULTI_B,		cnt_multi_b);
+	PUT_STAT(CNT_MULTI_C,		cnt_multi_c);
+	PUT_STAT(CNT_OWN_RX_A,		cnt_own_rx_a);
+	PUT_STAT(CNT_OWN_RX_B,		cnt_own_rx_b);
+
+#undef PUT_STAT
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
 static struct rtnl_link_ops hsr_link_ops __read_mostly = {
-	.kind		= "hsr",
-	.maxtype	= IFLA_HSR_MAX,
-	.policy		= hsr_policy,
-	.priv_size	= sizeof(struct hsr_priv),
-	.setup		= hsr_dev_setup,
-	.newlink	= hsr_newlink,
-	.dellink	= hsr_dellink,
-	.fill_info	= hsr_fill_info,
+	.kind			= "hsr",
+	.maxtype		= IFLA_HSR_MAX,
+	.policy			= hsr_policy,
+	.priv_size		= sizeof(struct hsr_priv),
+	.setup			= hsr_dev_setup,
+	.newlink		= hsr_newlink,
+	.dellink		= hsr_dellink,
+	.fill_info		= hsr_fill_info,
+	.get_linkxstats_size	= hsr_get_linkxstats_size,
+	.fill_linkxstats	= hsr_fill_linkxstats,
 };
 
 /* attribute policy */
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7e46ca4cd31bb..ed4e6d53ccbab 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1844,6 +1844,7 @@ enum {
 	LINK_XSTATS_TYPE_UNSPEC,
 	LINK_XSTATS_TYPE_BRIDGE,
 	LINK_XSTATS_TYPE_BOND,
+	LINK_XSTATS_TYPE_HSR,
 	__LINK_XSTATS_TYPE_MAX
 };
 #define LINK_XSTATS_TYPE_MAX (__LINK_XSTATS_TYPE_MAX - 1)
@@ -1854,6 +1855,7 @@ enum {
 	IFLA_OFFLOAD_XSTATS_CPU_HIT, /* struct rtnl_link_stats64 */
 	IFLA_OFFLOAD_XSTATS_HW_S_INFO,	/* HW stats info. A nest */
 	IFLA_OFFLOAD_XSTATS_L3_STATS,	/* struct rtnl_hw_stats64 */
+	IFLA_OFFLOAD_XSTATS_LRE_STATS,	/* struct hsr_lre_stats */
 	__IFLA_OFFLOAD_XSTATS_MAX
 };
 #define IFLA_OFFLOAD_XSTATS_MAX (__IFLA_OFFLOAD_XSTATS_MAX - 1)
-- 
2.34.1


