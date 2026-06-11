Return-Path: <netdev+bounces-298302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LEGxHX4FK2qv1QMAu9opvQ
	(envelope-from <netdev+bounces-298302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:59:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E7674A19
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:59:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b="C/k3T9Dr";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298302-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298302-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B530313476E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616048AE33;
	Thu, 11 Jun 2026 18:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60964921B1;
	Thu, 11 Jun 2026 18:58:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204290; cv=fail; b=me0uZtDsygXvftCIFGcUyxVS3VODPCAeOcfVL2IfLmMKBE66mdMTuqdvEJMgb/cA4jFmcm+yibagmyJC5RU13IThoKAHpdyblxgmnH85MubirTgwHzy3ILrecY/gnhfJdpdS1m6QI193MDa4tgkbXGe+1FQN0MAaOzoWzO/kQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204290; c=relaxed/simple;
	bh=8QsacmG/MLzGsf/iPGDCizrNTPk0G3FUvr+i6lqGQIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOoAK+3beT7b/hLGLlvqjHegaHaBRW2WjkTLxhzTwXE1fFFVZssZ9R0FGFhRZ8YEK59fN1SAxOyNo63rDSuXWaifyQ4ZFxkJ2qTKFqNvicBhp9uhpNMpbGuJN32XNtlU6Ykvn83TBuo2zvTw2WyJtBKsGkj1J92qllN2GVIW8i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C/k3T9Dr; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6K4MQwc4AfrHbaSyn1Kqp73rSEKjMjYxaU6z2IOW0EjpNcwqkYQCEnQxEZZeW3KZB47vGu5z4lhLTqMHUY0tiJSHMj8BQnsN97fvhbFDTYNN3QqfYVoyYJ8puRJaaDbsE41YkUAnIMMyDQTDrV9hJmsUDpzhxBrqLXYQI7DCP5+zG5PR00rlna/KSXszNSKc+P9JP6aAm3VL+3yGyqLAqe3ZScZu0BePhqqWqm0SYkkL2bDKCXYjM+kPuGb5v+MgWXeQuQVjlvW5zp/Lh+Th3ujwwkVelh0CBQy6hL+NeSSvmmoZKg9uMbuim1J9U/dKQ7hhDRnWUetJFjYSeFC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhzZZTC/Azdw0LeayNLKOL1YNGF32TNCMMwSuy0ukUw=;
 b=wnPZCT/GbD+oE2vDdiL+Izxgh33y4KcZYdUNFwRidapqaAgEttc0muSiIrRb4bx53ZL6p71igN6ofgdMopRLhl5vaX+2p8BP6aR6CNJ4e5vQqylQYdDTB7bAqgY2VJ8yszmppUU/0S5i8h1aOPMtK9mgREEXjevpGn8lND/jU1m6zizJmqgx+zgfIPtqRExHbLBPuyi4/FZc8va1Cbxw2RxEZvJnsBz1VknFuKNIS2Za2BwnLBejMXipbutk3+W5OkWnYOYsPEPSwKTrwID8AQbm0nG5kZ6xhLdaso+e6pMr7EYlv90/tZWwUc/DUYkhHM8RJyDNCMDf7aTuNw9FJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhzZZTC/Azdw0LeayNLKOL1YNGF32TNCMMwSuy0ukUw=;
 b=C/k3T9DrzUPBKDS6+JZOndvead0en+wmGoqccmz4EMSvZ9hd8NHzfvEK8U8EDBqR7AxxeZHHFC9I3NaD0CXSmArXlz1ZTUstW3cXfo2oBkdMaDJ/j62nYxJIxwIMl4Ou2DxbmJQu6f2LZl1b3w05iy1WuCRl91/Ii3RI/Z8IDfs=
Received: from PH8PR21CA0016.namprd21.prod.outlook.com (2603:10b6:510:2ce::24)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 18:58:04 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5f) by PH8PR21CA0016.outlook.office365.com
 (2603:10b6:510:2ce::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.5 via Frontend Transport; Thu, 11
 Jun 2026 18:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 18:58:00 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:58 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:58 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 13:57:58 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BIvvoA3923985;
	Thu, 11 Jun 2026 13:57:57 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65BIvvMn013190;
	Thu, 11 Jun 2026 13:57:57 -0500
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
Subject: [PATCH net 3/4] net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode
Date: Fri, 12 Jun 2026 00:27:43 +0530
Message-ID: <20260611185744.2498070-4-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: b96d5fc9-add7-4c29-9112-08dec7eb5c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|23010399003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	VWP1FdGHd6iRWpvs8emAdmaeAd6mjKIByfxb2FfJoNzxafHWaQFJbYIkddeqgdsTy+S8p8hojtvKT7WNs1luO6m5TIhEvIaH9i3s6d9SZ320o5aa0vcjirIFT07aUx6jtuy9tO0oSBMjotDrP+Zw6qWkeZ0kO+WhtTOpzhpbkLjZedCtOIsafcDuhmTJY4uJ9ldBMu0K8EICCj6B3K/NRJkNNKePXX9uPvWwHg8sBHCGOJuestTZGLvSaLMzLbTim3Ci1uUlC3+ZFtRtp6VpvOONiFfUquWHtMl5qRVFOF2SpvETnYH8bUBFdwPesLrDy2xVfSBLXWG0GPbFAasvdlWsedfhmN1GfMFs57Bigm9mZhVbaaRNfwl4DsudZuSJWpd6j2xzwY7jqTY9ZuleEIPzpNpSYLnisluqYh7K28jjvPvCH5LkNP7LzuO8aZ9dGnReDKHUNv6iVM00TN4hagDYhvjoGlOqXJkheaoU+S5dhV0fB56LoblXuN0r42TWXJPamhqFYuxkPfbcyIDS4Oq+qr0mxTmAgvfXffD+4qOe3VssXxiOS5iZPxKOTXjyS0Q+XjalKQWDLZAocFGOGovK+S1O2r/AxRNK8LRc86VXSj21zxxejWlNjgQ1NQbYPvpWIDbkcdW25OnPuz2xl6sHuB2JYBUkn1c3xzh8ETL3184PM4bkxnnyn45axUfQPJoKqkdb5VdivVlvM+xc1mIKZ5thz/Ct0PiHvRuKNC8jcNilnkzhnLbYrdXw3A18SPq7mIWW02t+YtOIYX2XZQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2ZMkYmlb0SyWW2k4Nn3dSquX/sMPckwQ9yYvHJWEgHU+bHyKD0yozyRcjBc8xMnsz09GPLv7Et/hVtv7An8CtXsFlFwLXGoWLe/a229fMmzwvYi248O4+GoxAEatwWaIPec9+3R37xm14Gwin0hD6gqGNkU4FO7NXWeCvKl/tJj5dp4S4LidxXWPZ35gkhNhVWSxFGECicxlgENGT6DVv2fBqg7aw/dBnLRWCV12UI0yq0HeCyNSS1bj6yo4wMNV0K4t+rD94HTHtIRJ9DVJQ2DwzDU+JHtdeHDW4jsgQJw3ihGmYp69/NzSoU2zdAjIhMRtDd8IYupV2EM/quUmwaUvGYfQMiDJgZZnUCZUyYlF+/dbwnVjD3FDwJGncWTsjASF2zMcS703geX3JLPZjylX9VyQjoD884k68ZXbPdU3SW6BI8eWw3rfooiecq++
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:58:00.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d5fc9-add7-4c29-9112-08dec7eb5c2a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,ti.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298302-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD5E7674A19

emac_xsk_xmit_zc() has the same issue as the fixed emac_xmit_xdp_frame():
it always sets the CPPI5 descriptor destination tag to emac->port_id,
which directs the PRU firmware to transmit on only one slave port in HSR
mode, breaking redundancy.

Apply the same fix: in HSR offload mode when NETIF_F_HW_HSR_DUP is set,
use PRUETH_UNDIRECTED_PKT_DST_TAG (port 0) so the PRU duplicates frames
to both ports. Also set PRUETH_UNDIRECTED_PKT_TAG_INS when
NETIF_F_HW_HSR_TAG_INS is set so the PRU re-inserts the HSR sequence tag
that was stripped by the PRU on RX before the XDP program saw the frame.

This ensures XSK XDP_TX frames in HSR mode are treated identically to
skb TX via hsr0.

Fixes: 8756ef2eb078 ("net: ti: icssg-prueth: Add AF_XDP zero copy for TX")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index ede32f266729..82ddef9c17d5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -105,6 +105,7 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 	struct xdp_desc xdp_desc;
 	int num_tx = 0, pkt_len;
 	int descs_avail, ret;
+	u32 dst_tag_id;
 	u32 *epib;
 	int i;
 
@@ -137,9 +138,17 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 		epib[0] = 0;
 		epib[1] = 0;
 		cppi5_hdesc_set_pktlen(host_desc, pkt_len);
-		cppi5_desc_set_tags_ids(&host_desc->hdr, 0,
-					(emac->port_id | (q_idx << 8)));
+		dst_tag_id = emac->port_id | (q_idx << 8);
+
+		if (emac->prueth->is_hsr_offload_mode &&
+		    (ndev->features & NETIF_F_HW_HSR_DUP))
+			dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
+
+		if (emac->prueth->is_hsr_offload_mode &&
+		    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
+			epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
 
+		cppi5_desc_set_tags_ids(&host_desc->hdr, 0, dst_tag_id);
 		k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &dma_buf);
 		cppi5_hdesc_attach_buf(host_desc, dma_buf, pkt_len, dma_buf,
 				       pkt_len);
-- 
2.43.0


