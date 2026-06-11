Return-Path: <netdev+bounces-298300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id akA3FUEFK2qQ1QMAu9opvQ
	(envelope-from <netdev+bounces-298300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:58:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB56749EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=ZQuUeJDv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298300-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B76230091FC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABE4A2E3A;
	Thu, 11 Jun 2026 18:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018949218D;
	Thu, 11 Jun 2026 18:58:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204282; cv=fail; b=uo76n5TChUSUCju66GDNbhwdVqztLIechPU1k2/KEqYhwEOjUvL8jc/Rs1Hsa7c81OoLDvAR5G3pNp3/PdqaKsiD7CXqVGjYj5AxLtK4KShJVIvkj4r2VmZbklymxRrIYPPQWdj2PAvKV6XQC1XExX8rVsCfZ/uqUfTjzDqyLcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204282; c=relaxed/simple;
	bh=60wdbOpZKBLOhnnh5T8keaKcZHTK1Vz//BFbRgFpHOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYGhgQyFc8X4xw4y9UGNlL15TOVl4HOPVxq98voCdAVnR/+Szb5HuiTiu/eZoJbA+g3GbDd5plFmKY1ezxsmPk6R/3onuvIux+D7tUnff7ovl75J8vEaEX1fyPeRhyth2/S8RHWaDonSl07VQcOF+XQFZldPe9dMdzEuIEzT8Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZQuUeJDv; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJxMFS8oS3UJsTBFuW9COTQBWSQD3HT51D+7FPxKIssyYpxNMsSxF2qtoD+zJoalsxqqgKg6QP48OiRd/6iXZ1c/XWYj6G+LFU1zzg4PRzuv1SOHniM1AYD1NSoGl+xYH48Ic0/kes83d7ERUBM14wL8OkV7jfvXrAvcwMqYJwt6nO2Y3FJz9qpVwkLK2vY6JFC4b8/5KeMycUv6U2g7Znxgf6M7/AULo+HwcUp7Mr0u07/Cqq0AhvVhNdJoRjFgRWN4LOJF4LYAw2GeUHPH1N7q+ijJ+qJORMxQ1ZBBvK5cy07tyMWVNimDNTBbSTCM2sKhAnwnLIIhTNqNKAuARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgzgpWZvPM8JO5LV7k6Z3usak6I9hERQPLxFSS5bNUg=;
 b=KmAZNGzRkZaAaDXCMy17QpE5nQY/ha2TTCwoHuUT22SkfQ/S/q4DaddjnOvGLFPn2ZhecLecXkR9BktWhjKkO27LPsIu6LrKv74k5hj/9/IL4j54Gitl0r2yTce5mwfYOiT4qr3HUilgEQdufcys5xQBFunD9dVixiHhb/I4ozaEFKFLifSFYy24L2KE1InFtry+YbshbN//5wOhJFI6zeEzcTJ83wA3zeGJpGf55ks/D2zbztJzOC+Rueo2OG1GMXXQxyxHZiYrncUwvhsnBiq7s9B5RaJiWPMV38V9RW+gra37DmVk6pGmVVlFljtE3S8NI05fJEdYTlvfWNmjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgzgpWZvPM8JO5LV7k6Z3usak6I9hERQPLxFSS5bNUg=;
 b=ZQuUeJDvVjKnWOU998PryKlshB77dr+lIeRsS+ofJ0QUA/JRkZDPQeQZQfjEeXutw25vFLfqhULO0cFG5JDiC5x8CGpeWXGkP2rzMZbpLDd68sxBntUbTFahbKzloNj+IlSIyryFxGELLLsflNwb1dCu8yZCwDZjihqdCtTp3kM=
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 18:57:57 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::61) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 18:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 18:57:56 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:52 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:52 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 13:57:52 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BIvqp4652983;
	Thu, 11 Jun 2026 13:57:52 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65BIvphQ013176;
	Thu, 11 Jun 2026 13:57:52 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <sdf@fomichev.me>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 1/4] net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
Date: Fri, 12 Jun 2026 00:27:41 +0530
Message-ID: <20260611185744.2498070-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611185744.2498070-1-m-malladi@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 000cda0f-bc9e-41e4-a5f7-08dec7eb594e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|22082099003|18002099003|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/dln+8waK1sCO3POc6ec/393OCeT9UcAF/58zcbWKfq2h3bOt7s4tygwTWA5lzQbar0E2wMYUrb92kxf6NPtbxeO8dOHr9Bo1CpziAXIIZ55SDQXf/tkV4TTRsfL8CFW9W7cLkDoRZa/cwl2O8yWjbOxYQN6ztMuTtHNnMfneKZc/AU1BHIzkn2iOdFQhS0vNSCt1oDWcFrVP2HWG/1lS9rOqiKYj7lgexYGhh7FvpZEbnaX+y2aNMZ7SxtbWx8Zkrub87Y6eHs6zb+ltHWA0Tcbg59wUR20mPhI3M+rXJItQWxc79dw2XM1PPdJSHd6GfufHa2LiUocJkrB7LrGDB0CqMVq4UXpvIg0KNmyrGBK1I7k2oGKHyJrsir/feSDJ2WQLqS4tfrsjL/pkbxZ0ewJ0HoE92ZPCygLlGJtVVC1uI6rbGpzV3yoX5IrrkPTi6oxpmnqInZJGuR9s0dAWhAD2REQgtxIMtAq15IuQeRTGO/8wl1xbD/dc1u2XM06/1Welsvp6C3iTCOzlRnqNb8m1XPZe4RxP6yu/Cl2Z5HRwEux/Lw7BzhDtJzrKpAWpZzY29UR0k+CAxPZ+DPj/y0PdANon6f4vS55BrJ4I6eO26oLdp8+7IpF/Ey+lcDYisAJ4fhQG3vYjyiCDJ56bpxo7TQpWbcMx0KXFJvuPzt/mAOKJXPqjEPg3Rny5jkk2Y/M3viQHfXqlawIRaDQxYwGaFgY6FmK+wXAl6wm8WMHSir9ifKKhWNyaOLZFHSuYFhpxOexAVEi8+mkE9lHQA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(921020)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XoEYXEhD7wuj2yCxRsD2N6/Xqjz0hKaKKeblaIqVG00c8ZF75bEXetNIu3kxkGiYjiHB9hTKDv8uo4ZCle+GBumCPjkUy0tfPUshZL0Vx5yNbWHNG1wZ1Lc4KsoMeILHiJy98YTgooQWT2Fhwx7IX1q91PytBuyd4Zp7nnudnP/U9EyNeMu5tPDeFkdL5MiHtyKYNn8TDJxvus5dJtcZGjpnR3+UU1JnEXVsom7Hfq5ABW6dwKl9NiUcVXUDy3Y13ST7WjHlFCkZE9HtoX28XyhLlc2hvp6UWFRwZdEmdUexP5R3OAM6Am8Ru5DeNhF640g69ZSodn3P2y8yomzUO59aw7cs67MDNcIjXc+0C9MhMx95AkTxgp+nrYsX8b4ogGGf7cVJOhCgTAKEd/IlUqlk9WaHrFV2pYsNTCc8+LX8J/UgBv/EwZscPSnNWotY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:57:56.1456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000cda0f-bc9e-41e4-a5f7-08dec7eb594e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,ti.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298300-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BEB56749EA

emac_rx_packet_zc() calls prueth_rx_alloc_zc() with count (frames
received in the current NAPI poll) as the allocation budget.  Two
problems arise from this:

1. When the CPPI5 descriptor pool is exhausted (avail_desc == 0,
   FDQ already holds the maximum number of descriptors), count > 0
   still triggers allocation attempts that all fail, spamming the
   kernel log with "rx push: failed to allocate descriptor" at
   high packet rates.

2. The XSK wakeup condition "ret < count" is wrong when avail_desc
   is zero: ret == 0 and count can be up to 64, so the condition is
   always true.  This causes ~200 spurious ndo_xsk_wakeup() calls
   per second even when the FDQ is already full, wasting CPU cycles
   in repeated NAPI invocations that process zero frames.

Fix both by introducing alloc_budget = min(budget, avail_desc):
- When avail_desc == 0 no allocation is attempted, avoiding pool
  exhaustion errors.  The wakeup condition "ret < alloc_budget"
  evaluates to 0 < 0 == false, correctly clearing the wakeup flag
  so the hardware IRQ re-arms NAPI without spurious kicks.
- In steady state avail_desc == count <= budget, so alloc_budget
  == count and behaviour is unchanged.
- After a dry-ring stall (count == 0, avail_desc > 0), alloc_budget
  > 0 causes new descriptors to be posted to the FDQ so the hardware
  can resume receiving immediately.

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..55a696912811 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -927,6 +927,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 	struct cppi5_host_desc_t *desc_rx;
 	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma, buf_dma;
+	int avail_desc, alloc_budget;
 	struct xdp_buff *xdp;
 	int xdp_status = 0;
 	int count = 0;
@@ -993,16 +994,13 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 	if (xdp_status & ICSSG_XDP_REDIR)
 		xdp_do_flush();
 
-	/* Allocate xsk buffers from the pool for the "count" number of
-	 * packets processed in order to be able to receive more packets.
-	 */
-	ret = prueth_rx_alloc_zc(emac, count);
+	avail_desc = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
+	alloc_budget = min_t(int, budget, avail_desc);
+
+	ret = prueth_rx_alloc_zc(emac, alloc_budget);
 
 	if (xsk_uses_need_wakeup(rx_chn->xsk_pool)) {
-		/* If the user space doesn't provide enough buffers then it must
-		 * explicitly wake up the kernel when new buffers are available
-		 */
-		if (ret < count)
+		if (ret < alloc_budget)
 			xsk_set_rx_need_wakeup(rx_chn->xsk_pool);
 		else
 			xsk_clear_rx_need_wakeup(rx_chn->xsk_pool);
-- 
2.43.0


