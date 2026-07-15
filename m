Return-Path: <netdev+bounces-307676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iI5lCj81V2qNHQEAu9opvQ
	(envelope-from <netdev+bounces-307676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:22:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697BE75B655
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=hjikmKGu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307676-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307676-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457EC3029E76
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9503C2788;
	Wed, 15 Jul 2026 07:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A63C10AD;
	Wed, 15 Jul 2026 07:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100081; cv=none; b=JpOxQmSw4D5HENIR1Tkvf2caC9csIS68MazOntbN+mbz6orUxR3I8zgoxMVrNerk3ATUcgRaF9ABZlGOccC6bKLI8Q7e/hUir9zllhbPxx8o4euy8rgD11JYo5+qeAJ9FoyT/2Lb1uRDZikvkfeP1WT5kNWqqDsQDfMWA3Fjh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100081; c=relaxed/simple;
	bh=jTGdG+EAJACxYYJsgC3JAQaXCtp3vUY2N6D6hZSnDyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZqL4RYppDJchzKlUud7yXaDy1Zj72Dpd14GvcsEwB7cUvkBGDc0jEsFSF/aRsRCJTGrjez7vrb8rOuPZjgqbitubZE/0GcZJJcfmdKIP1QmoBuC91zSLlyVhss/IwCK3eDPs6L6TyZPJT/5K0jpogW96CgnyxAFUw7Jx126UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hjikmKGu; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3mCq31918373;
	Wed, 15 Jul 2026 00:20:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=20982SUSx9yGDSIR6xkSnuV
	1AXcg0T/sUg7crxYKTl4=; b=hjikmKGu3ZaCmACr9+9UMQCNhoQ5r69FFac76o+
	Pw7udUlhATdrd/UpCbcQo1pJtaPr2IUO1Qr7eIlcrL6hIMKSxZeNUKg7bl1o5Ftz
	E6H6gUsC/VM3hcT3KzF3RVpx+ZWgHfkTqQKK4PnOrbsL6IE/f17/pRhbCQm1eDLw
	ukfULljVkdKesMIEVuDzLXccmJLaorJX/18TW2vYvWhxCKZtPQDIOLGrYXBAxtN/
	NKiLVal1Pm/xcC+wMACUYkYdoOiu1xcKS8q9zcp0elhy+vZmxflCtiV7p2VoEtTG
	vYJB7whsoClgE40cDQzWoDTWdeBerAqJ04swWZdfBC0KRnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fdpw4awes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 00:20:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Jul 2026 00:20:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Jul 2026 00:20:50 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id DABBF3F7044;
	Wed, 15 Jul 2026 00:20:45 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Satheesh Paul A <psatheesh@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] octeontx2-af: add support for custom L2 header
Date: Wed, 15 Jul 2026 12:50:34 +0530
Message-ID: <20260715072035.617544-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoGgLvO0 c=1 sm=1 tr=0 ts=6a5734d3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=SVl1XXPbahHPMHDWaqIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PnNuiDvPzZ7FHGX2s9cUxCvGfqG5k_AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2OSBTYWx0ZWRfX568bvNhV67hX
 uuhTbior7yKRlxEQCa9ydoad7N2bHcmdstvrvSdCRDtBU34TadHA9iu0MqVMvTv1/elw2Og/4N9
 UKgVTXcxDie/Kou7jWehEpTiGHstn63c/oLE46eLi+INL719mv6Ey2WM8VGExzKKD8vHjxm79ih
 E8U+cKz6uYcqBhsHzr2nu92QKFI0tPUKm6QX9dRUd2CmNRyY4EtxQut6IfzebhtLD0s5I7m/T0g
 EwOYtCLUDb9ArPs9aURuxdshznZ9Dv09AubbYxMV4B7WoeKbFSAGz3Uzfhaau/8MKbY9ty6qagp
 ITGmujHidvXnspxcuQJlNBa0Y7O76Ye8GxHwHWkhCPIjLoGSAhPOenUFwmUB+0U5pvz8FM83P8s
 R5EWg3OBRgOHOHlN3d5SsUodH3i5QAU91YKsGXoFKH5VanU8e8Q6EUaWWXS8vpb0cJgDamvDB7A
 z3URJshJHxDsJY824aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2OSBTYWx0ZWRfX967JN51O9f+G
 mkQp3a3IJhcstTBcDTsbZVqsEBHp051odu7XNfMtvmcqhYPk9MKARugDT+HfxRLGQVHy83ekpXj
 PdfgPcREsgT029TJzaKV5hUF650Z1n4=
X-Proofpoint-ORIG-GUID: PqBvhfpfduX7U1sAfKu3G5GjmJ_xEEtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307676-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:psatheesh@marvell.com,m:nshettyj@marvell.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 697BE75B655

From: Satheesh Paul A <psatheesh@marvell.com>

Add packet parsing support for custom L2 headers. Also add support
to include a field from the custom header for flow tag generation.

Introduce a new flow key type NIX_FLOW_KEY_TYPE_CH_LEN_90B which
maps to the NPC_LT_LA_CUSTOM_L2_90B_ETHER layer type. This extracts
a 2-byte field at a 24-byte offset in layer A to be used in flow
tag generation.

Signed-off-by: Satheesh Paul A <psatheesh@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 253dfee9646e..10552e9cf519 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1263,6 +1263,7 @@ struct nix_rss_flowkey_cfg {
 #define NIX_FLOW_KEY_TYPE_INNR_UDP      BIT(15)
 #define NIX_FLOW_KEY_TYPE_INNR_SCTP     BIT(16)
 #define NIX_FLOW_KEY_TYPE_INNR_ETH_DMAC BIT(17)
+#define NIX_FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define NIX_FLOW_KEY_TYPE_CUSTOM0	BIT(19)
 #define NIX_FLOW_KEY_TYPE_VLAN		BIT(20)
 #define NIX_FLOW_KEY_TYPE_IPV4_PROTO	BIT(21)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index c5bddd2ad920..dade7bb6deb7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4288,6 +4288,13 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 			field->ltype_match = NPC_LT_LC_CUSTOM0;
 			field->ltype_mask = 0xF;
 			break;
+		case NIX_FLOW_KEY_TYPE_CH_LEN_90B:
+			field->lid = NPC_LID_LA;
+			field->hdr_offset = 24;
+			field->bytesm1 = 1; /* 2 Bytes*/
+			field->ltype_match = NPC_LT_LA_CUSTOM_L2_90B_ETHER;
+			field->ltype_mask = 0xF;
+			break;
 		case NIX_FLOW_KEY_TYPE_VLAN:
 			field->lid = NPC_LID_LB;
 			field->hdr_offset = 2; /* Skip TPID (2-bytes) */
-- 
2.48.1


