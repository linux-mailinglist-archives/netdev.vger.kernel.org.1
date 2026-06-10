Return-Path: <netdev+bounces-297443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jmf8N331KGrbOAMAu9opvQ
	(envelope-from <netdev+bounces-297443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D02665EFA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=OjuJCZFW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E6530FF5A8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D22370D6E;
	Wed, 10 Jun 2026 05:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EB36C9CA;
	Wed, 10 Jun 2026 05:25:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069125; cv=fail; b=FVa5QW46eimcL1GcV+VEhOGSDEFr0D+vhQWJpDmdjdj0FRKmu8DbnUdO0Ht9M6E1o21iRs+wvgRx8Dk5J0M44Ucr0xwXtSdYfGLG9pV61v7+xecfEdvAasqIY0pS8eMnya1qb5sns3wUc1/ZsGtJGQ7JHiJ6N8isip4jIfoYUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069125; c=relaxed/simple;
	bh=4aNU5vH+57p1UtdMVvAw1lTy6iRDkM6VPr6vcrDaKgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ2JSGdz9fHVWBoaGPOjZ9R9Whc+Gwy5egJ6huQzrm4S9Iw2PjvVLmVJz9dC/I5jzqOR7Xy30NGBPrlCu7xKa4upkD6vK6p70FQfRps/vKXVJPfCUhG6nyNqJhtDNLA/9C/L9vioRDluJXy7xFIjQxc2wyUQSC9lSLpDvORsrM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OjuJCZFW; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THJlZ2tdX8DtmUovajVBLl8J3SLJcZpPrP7kvw616DrkI48aGUFRxRuKehACA998N6ZoLzrCpCBTjsMHIoN8PDoY7gAgKLnDAfEfYp6NFmvc2CHsUn1TE18Mdlt77tukrFa4DdKiXZm55dXw7t0FRzb+1wpxjbSM6LPReLp6Py8IIgr8e7vzUoM5VHc7Je31WuNuRnCEW2btNy7uvy3IkxQhUFxFS7WfBJXI2HgMub3a5iRFFDaWL4Q75qaSzVFhyDA9z/1D6KV6jjfaJZIkhQPBKn9aTaeh7epgNyvlKxxBJjeozOjtklM4WiJQpKLxT7/ahfPqVpJO8y1j+XQ0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/movj6kffQeNXqxfWeWk1f3jnGlBtYb1SdfdYS51ow=;
 b=sm5fkPnF/LQmwgpX3lodgeZ86kgV0AE6cntzFIvNHMKENh2NhbbgxKs29I7/SrBy5yUTcN8ZyB9+XsCncdq8pXYxg9nuYFep02nR6QjQWPJnmEbVHosEHveZIy11TO1fLmnbgYyKU6RkxIuR/aRXOnoUQpw/gHft9GgTU8d7b50Hn0Fn0nXut0YbERDhg5eD+Wgl3HHl8osf+/DAkCovdB3AxhF5qMkcUEi6KRAy0kVS5Zlq/oE0aJ70fi3P6/rDk0E9FcSADVsgJwpySBqQTenWev84jLq1VZpt6MXn5Ec8kzV9k5OT/f5J63+JFPOupIJJ8uWGl1puSYRmxwNVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/movj6kffQeNXqxfWeWk1f3jnGlBtYb1SdfdYS51ow=;
 b=OjuJCZFWs27iH29PGwlc3QA5Up20cwUh5RUPMGhEPX5QhspmNJCo5AB2yv4LUiloyIVMeIpaKeT7Pj6f/GjSYQp4P8V3mMcFoX7RhEjl8zUzwO1s9504wUxnYJoSRFghle/aRHiOgJrou/9q+FB4tT0ijt/idx2/bSodEk11AXU=
Received: from MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 05:25:21 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::51) by MN2PR11CA0007.outlook.office365.com
 (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 05:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 05:25:20 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:20 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 00:25:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 00:25:19 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65A5PJZ63165462;
	Wed, 10 Jun 2026 00:25:19 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65A5PJqr004450;
	Wed, 10 Jun 2026 00:25:19 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <arnd@arndb.de>,
	<basharath@couthit.com>, <afd@ti.com>, <parvathi@couthit.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v7 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Wed, 10 Jun 2026 10:55:10 +0530
Message-ID: <20260610052511.781752-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610052511.781752-1-m-malladi@ti.com>
References: <20260610052511.781752-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: b7699c66-2379-4fc8-b5a8-08dec6b0aa69
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|13003099007|6133799003|18002099003|22082099003|921020|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	NBkFJLzFSjx0+O4mkPT5DZhtHQijPpLghr55siEeqR73YSbd27qd6Zq1aUJj1xpRxcgg4oLjJVgzbPzl6babLYsnMQUwu6AtOMr6gHNlHCRzNCwonJ73gpKMT6NscZ8clUGb3/Ri7SYTZj7AcF+NWGRXpX4t4qyDglXUPq7eD1EBi1Xbwmq0HsDWlWgXnzFHm7I1cK7vcL+P7qShGLaCq9Xp8QuuebXLPSCnz33C6NJCl6V+Jnf+9qD/TIHcKnlOtppw5ZlS4w5QriZlwSDBnxTn42jLsQ1V1hGiOzeoz8DFZCtDUPXlXVYDl7pRUGgv+on6OPBxhkX7hdPBx/9s04iFGQFcxwdBQJPyltM8eh0gj+hKuJdyAADh1TQJoN0grf72/fYBz6nXer1c1oC9dsJfDyNLJH1bqog9A7tqbLb3W5vKP5HsJCUfcUGD22j0FKMeJxHr9CaSw4ExPy6jLY68bYv9+0rEEYJvSjQ5CcRzlcX5aD3kyCt4/bqFTjky9DzbU/2Vq5PgfVzn3w6CNbmXNcyWzURW3BVOFg6eLisJoDcUtI/EAJSkw9AaQDJpxpAisllmXenP6FUJH+zUOmRqI+UMCltDEMOAkLSRm57NLZh/LiCj6n69uIXyau+be070ME7Sr+GF4EJLyzCxL1odSxOle2X30L3i3j21I5wJE3LHU1r/9SGlPrXWlpfYpetFyZnSnHKximbYQrr4y00UeYxbbgGAlkES3mmo87A=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(13003099007)(6133799003)(18002099003)(22082099003)(921020)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sq5YDQDvZSPzFK9T2OKHJ08vGnxZEMCpFmkOGbIqOr46eUX8I5lllt1b5PIfJG64raHy9Af3eGJe5SVaYQxL9lL54HLWafuv4ScbyB0q2w4O2Jpao1Rp+FgoZX42ZG4P0A6+RqBClhInUUZQU070xf3pqvbIH6nLEVANbGW2BE9h8JPEyxSDG/wT5U1LWfQ4PepClti7GTnaZc7IleX3ZtKCeZlww1bylI2VkpGFkEiefYSmk6PLx3cdJrVB76sy0/jVL6RH/AGyC9NlPxBiBewvEaFMj2Z82MXuJT+stVTCcwMrE0JpGpSS4xpMmvRIaDvpuTfsc6Hq8Ks99HPyApkYxK+YRuo6sgR3ULa+79tYjfGZ49K0oBWjVS9KsWkRjrv/0DKwl1vfk5aOFVDU8LDMbEo2oY+KSL+6AXLDhHGfbdhahJKnZNGNAocERBVg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:25:20.7544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7699c66-2379-4fc8-b5a8-08dec6b0aa69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,ti.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:url,ti.com:from_mime,ti.com:dkim,ti.com:email,ti.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297443-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32D02665EFA

From: MD Danish Anwar <danishanwar@ti.com>

Introduce QoS infrastructure for Frame Preemption (FPE) support in
the ICSSG Ethernet driver.

prueth_qos_iet tracks FPE enable/active state and verify state
machine status via firmware-reported enum icssg_ietfpe_verify_states.
icssg_config_ietfpe() configures IET FPE in firmware, triggers
verify state machine based on ethtool MAC Merge parameters.
Polls firmware verify status up to 3 times with verify_time_ms
intervals and driver handles timeout by logging error and returning.
In case of any failure during configuration for enable/disable,
IET FPE falls back to disabled state.

For MQPRIO qdisc support all queues are express by default later
gets override by user-provided preemptible_tcs bitmask via tc
qdisc mask. Preempt mask configuration: Maps traffic classes to
queue express/preemptible state and applied only when FPE is
active (Tx enabled).

Verify state machine re-triggers on link up/down events based on
fpe_enabled and fpe_active flags, and for memory protection,
fpe_lock serializes all FPE state mutations, preventing races
between ethtool config, qdisc setup, and link events

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v7-v6:
- Replace netif_running() check with emac->link inside
  icssg_config_ietfpe for link down conditions
- Move netdev_set_tc_queue() to emac_tc_setup_mqprio()
  and fix its handling
- Update prueth_qos_mqprio struct to fix the dangling pointer
  issue 
  All the above changes addresses the comments provided by
  sashiko
- Used readb_poll_timeout() for icssg_iet_verify_wait instead
  of open coding it as suggested
- Fixed plausible checkpatch errors 
  All the above changes addresses the comments provided by
  Maxime Chevallier <maxime.chevallier@bootlin.com>

 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 282 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  68 +++++
 7 files changed, 364 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index f4276c9a77620..d19bcd25c9d07 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -46,6 +46,7 @@ icssg-y := icssg/icssg_common.o \
 	   icssg/icssg_config.o \
 	   icssg/icssg_mii_cfg.o \
 	   icssg/icssg_stats.o \
-	   icssg/icssg_ethtool.o
+	   icssg/icssg_ethtool.o \
+	   icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4b..c3ee97e96cd50 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1724,6 +1724,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 
 	netif_napi_del(&emac->napi_rx);
 
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae2..1ac202f855ed4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..39f379df923bf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		icssg_qos_link_state_update(ndev);
 	}
 
 	if (emac->link) {
@@ -1652,6 +1654,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
+	icssg_qos_init(ndev);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
@@ -1793,6 +1798,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 free_ndev:
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..f73b8f5fca956 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,10 +44,11 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
-#define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
-#define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
-#define PRUETH_MAX_PKT_SIZE     (PRUETH_MAX_MTU + ETH_HLEN + ETH_FCS_LEN)
+#define PRUETH_MAX_MTU		(2000 - ETH_HLEN - ETH_FCS_LEN)
+#define PRUETH_MIN_PKT_SIZE	(VLAN_ETH_ZLEN)
+#define PRUETH_MAX_PKT_SIZE	(PRUETH_MAX_MTU + ETH_HLEN + ETH_FCS_LEN)
 
 #define ICSS_SLICE0	0
 #define ICSS_SLICE1	1
@@ -254,6 +255,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 0000000000000..8b601d6f3d718
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->qopt;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int prempt_mask = 0, i;
+	u8 tc, num_tc;
+
+	if (!iet->preemptible_tcs)
+		goto reset_hw;
+
+	if (iet->fpe_active) {
+		/* Configure queues for user requested preemptible tc map */
+		num_tc = p_mqprio->qopt.num_tc;
+		for (tc = 0; tc < num_tc; tc++) {
+			/* check if the tc is preemptive or not */
+			if (iet->preemptible_tcs & BIT(tc)) {
+				/* Set the queues as preemptive queues */
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+					writeb(BIT(4),
+					       config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				}
+			} else {
+				/* Set the queues as express queues */
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+					writeb(0,
+					       config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+					prempt_mask |= BIT(i);
+				}
+			}
+		}
+		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+		return;
+	}
+
+reset_hw:
+	/* Reset to default: all queues as express */
+	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
+		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+}
+
+static int icssg_iet_verify_wait(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	unsigned long delay_us, timeout_us;
+	u32 status;
+	int ret;
+
+	delay_us = iet->verify_time_ms * 1000;
+	timeout_us = delay_us * ICSSG_IET_VERIFY_ATTEMPTS;
+
+	ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS,
+				 status,
+				 status == ICSSG_IETFPE_STATE_SUCCEEDED,
+				 delay_us,
+				 timeout_us);
+
+	iet->verify_status = status;
+	return ret;
+}
+
+/* Direct synchronous configuration of IET FPE.
+ * Caller must hold iet->fpe_lock.
+ */
+int icssg_config_ietfpe(struct net_device *ndev, bool enable)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+	u8 val;
+
+	lockdep_assert_held(&iet->fpe_lock);
+
+	if (!emac->link) {
+		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
+		return 0;
+	}
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+	writew(iet->tx_min_frag_size + ETH_FCS_LEN,
+	       config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	} else {
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		goto fallback;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = icssg_iet_verify_wait(emac);
+		if (ret) {
+			netdev_err(ndev, "MAC Verification failed with timeout\n");
+			goto disable_tx;
+		}
+	} else if (enable) {
+		/* Give firmware some time to update
+		 * PRE_EMPTION_ACTIVE_TX state
+		 */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(ndev,
+				   "Firmware fails to activate IET/FPE\n");
+			ret = -EIO;
+			goto disable_tx;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	icssg_iet_set_preempt_mask(emac);
+	netdev_dbg(ndev, "IET FPE %s successfully\n",
+		   str_enable_disable(enable));
+	return 0;
+
+disable_tx:
+	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+fallback:
+	writeb(0, config + PRE_EMPTION_ENABLE_TX);
+	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	iet->fpe_active =  false;
+	return ret;
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	mutex_init(&iet->fpe_lock);
+	/* Set default values to prevent garbage values during .get_mm() */
+	mutex_lock(&iet->fpe_lock);
+	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
+	iet->tx_min_frag_size = ETH_ZLEN;
+	mutex_unlock(&iet->fpe_lock);
+}
+EXPORT_SYMBOL_GPL(icssg_qos_init);
+
+static int icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
+{
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	mutex_lock(&iet->fpe_lock);
+	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
+	mutex_unlock(&iet->fpe_lock);
+
+	return ret;
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int tc, offset, count;
+
+	/* Validate parameters */
+	if (qopt->num_tc > ICSSG_MAX_TC_QUEUES) {
+		netdev_err(ndev, "Number of traffic classes (%u) exceeds hardware limit\n",
+			   qopt->num_tc);
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->flags & TC_MQPRIO_F_SHAPER) {
+		netdev_err(ndev, "traffic shaping is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->flags & (TC_MQPRIO_F_MIN_RATE | TC_MQPRIO_F_MAX_RATE)) {
+		netdev_err(ndev, "per-queue rate limiting is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!qopt->num_tc) {
+		netdev_reset_tc(ndev);
+	} else {
+		netdev_set_num_tc(ndev, qopt->num_tc);
+
+		for (tc = 0; tc < qopt->num_tc; tc++) {
+			count = qopt->count[tc];
+			offset = qopt->offset[tc];
+			netdev_set_tc_queue(ndev, tc, count, offset);
+		}
+	}
+
+	mutex_lock(&iet->fpe_lock);
+	if (!qopt->num_tc) {
+		iet->preemptible_tcs = 0;
+	} else {
+		memcpy(&p_mqprio->qopt, qopt, sizeof(*qopt));
+		iet->preemptible_tcs = mqprio->preemptible_tcs;
+	}
+	mutex_unlock(&iet->fpe_lock);
+
+	netdev_dbg(ndev, "dev->num_tc %u dev->real_num_tx_queues %u\n",
+		   ndev->num_tc, ndev->real_num_tx_queues);
+
+	return icssg_iet_change_preemptible_tcs(emac);
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_state_update(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	ret = icssg_iet_change_preemptible_tcs(emac);
+	if (ret)
+		netdev_dbg(ndev, "IET FPE %s failed\n",
+			   str_enable_disable(iet->fpe_enabled));
+}
+EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 0000000000000..e826ce4bcfd96
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+#define ICSSG_MAX_TC_QUEUES			8
+#define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
+#define ICSSG_IET_MAX_VERIFY_TIME		128
+#define ICSSG_IET_MIN_VERIFY_TIME		1
+#define ICSSG_IET_VERIFY_ATTEMPTS		3
+
+/**
+ * enum icssg_ietfpe_verify_states - status of MM Verify returned by firmware
+ * @ICSSG_IETFPE_STATE_UNKNOWN:
+ *	verification status is unknown
+ * @ICSSG_IETFPE_STATE_INITIAL:
+ *	Firmware returns this if verify state diagram is idle
+ * @ICSSG_IETFPE_STATE_VERIFYING:
+ *	Firmware returns this if verification is ongoing
+ * @ICSSG_IETFPE_STATE_SUCCEEDED:
+ *	Firmware returns this if verify state diagram completes verification
+ * @ICSSG_IETFPE_STATE_FAILED:
+ *	Firmware returns this if verify state diagram fails during verification
+ * @ICSSG_IETFPE_STATE_DISABLED:
+ *	verification is disabled by the driver
+ */
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt qopt;
+};
+
+struct prueth_qos_iet {
+	bool fpe_enabled;
+	bool mac_verify_configure;
+	u32 tx_min_frag_size;
+	u32 verify_time_ms;
+	bool fpe_active;
+	enum icssg_ietfpe_verify_states verify_status;
+	/* fpe mutex protects all FPE operations for synchronization */
+	struct mutex fpe_lock;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_state_update(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+int icssg_config_ietfpe(struct net_device *ndev, bool enable);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


