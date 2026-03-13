Return-Path: <netdev+bounces-267491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGRMLLIntGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58740285876
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250EC32E0C62
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928AC3AEF5C;
	Fri, 13 Mar 2026 14:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFA3ACA40
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413483; cv=none; b=J4GRKaz4AXS4ACosD5YVJkRT6Gp16XWxz3ebcTyNrBIRh+q4M8Y2rjv4dympkgT5lEX0k7LbHxUNKQUi7ouAeYol2UCjaxxZi1o9DilUBtsBYDGW+NdRrkdsIn6PnZnow0aK1ddBU/JKlJRJ+DrZTHKe9QMmucEpKbrFENSzUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413483; c=relaxed/simple;
	bh=6AsJbarJuKcJPcWPfgVpIH7BMjuy7BG3xDQpPK6V/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy0lNPKZj6KZIciiXHN+2hIzkTAfbEpUsSNX1Pf6sLPeWCX/VtIRred53/nglnYR+q6PDnsa6ZC3qWWYnxmrRw1FI3wCQHrFmtKQ1423dRPA3wo+olY8py/wOvGyIF6lX34udd72kdvpBexJ0sAabd3QrMq2QpQm9u+Mspu5L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be27fa54feso3086088eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413481; x=1774018281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DUMAwxZqTdLUEMLvVYJSQMyD/W2a6tfmiwVuhAHo8k=;
        b=QGLfPdD93T37tzSdgkmCXGq9ZmoppytJrt4za1gQtSDzaOMAXLRSBSCMwSedm1p08P
         fuf+J0K7lF9a+uwSWjbWphapkRLQb8gStUArAS+D2qDo0KTXrVR6rnVJAHP1pf7YuGRN
         u9MQVt9ccM8ed/NWaBf4+k5Bq8X/HWukilV1yXLWst4ofY63uAwjMIq3RsdBnCv2fTmO
         j008Y2ZF6PDSJikrUi1IgiMVoW6w6zo6yxkbr4DXIFzPuHk6joOSBovtJJ3hGOossUwk
         LFmsdfhLkv683wxa3bJR/JVOCxbyQp7OrWcVYT+OQH7s7/+Mb4bq0hOMDufDrF4AwM5e
         NFKg==
X-Gm-Message-State: AOJu0Ywj0qOmuoXBL/Os+04A2Nx2MqJUEBKFFVo+3R8htWPFgiiJdSo2
	YwnvzpUzinylp3rtCAMA4CuGYhH7ESIXoZCYXpwxTQR/iXhAjHVkUXpKPde3
X-Gm-Gg: ATEYQzxzYR/GTjr0AGyNQBmJw/YI8fEQoWIBIAs/YUuwYD+gq82Tyt8bPQAVCGyQzm3
	HgsN981+VlHbRXjr6I1RIxbRvtAroue+Y0ePX3T9FeYJH4V2cbQ7CdHn58av/nvWE8NLnn+Nc/7
	BYGtakcAdAKfAZhXBPBumYBOYYkoiOrowmxBuHsGloQCbHokZ30Re/6SlMv+gDgGche90U5LdDh
	aPbHVWlMghS8dd2AGDLNjNVXozAMN7PYSTXONO8CrlxkaVpIUNgXuRl4IRBnD4RUFO7IFr9MfIv
	+LjrI9Sg6KZZbqA/YcMhhwkmgEgbvX56vDicZb+muezzqJzB84Jm8wQ7vSpGJebkeB50E4mcIee
	/UZYUMNFm30EQnxUngZs0UrhJnU1qit0H1CaeODHEA97OPCeLYUjjBE2XgCJX933h/zRQdKErjo
	uPMjaozNX/snqQwajKseWvotTYiJhkz7IKYstFFTaEgezaTFMOn/4t7cNL/mxqDYLuU1rVicR8E
	zxl8DNsWrYH/s7sT86Ktm5Tr2f0
X-Received: by 2002:a05:7301:19a9:b0:2be:798f:23de with SMTP id 5a478bee46e88-2bea540d79fmr1517835eec.10.1773413481171;
        Fri, 13 Mar 2026 07:51:21 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0c34sm2772577eec.7.2026.03.13.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 06/11] bnxt: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:08 -0700
Message-ID: <20260313145113.1424442-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267491-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 58740285876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
now take explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

The bnxt_cfg_rx_mode internal caller passes the real lists under
netif_addr_lock_bh.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..225217b32e4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11040,7 +11040,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 }
 
 static int bnxt_cfg_rx_mode(struct bnxt *);
-static bool bnxt_mc_list_updated(struct bnxt *, u32 *);
+static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
+				 const struct netdev_hw_addr_list *);
 
 static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
@@ -11130,7 +11131,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	} else if (bp->dev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnxt_mc_list_updated(bp, &mask);
+		bnxt_mc_list_updated(bp, &mask, &bp->dev->mc);
 		vnic->rx_mask |= mask;
 	}
 
@@ -13519,17 +13520,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
 		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
 }
 
-static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
+static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask,
+				 const struct netdev_hw_addr_list *mc)
 {
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
-	struct net_device *dev = bp->dev;
 	struct netdev_hw_addr *ha;
 	u8 *haddr;
 	int mc_count = 0;
 	bool update = false;
 	int off = 0;
 
-	netdev_for_each_mc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, mc) {
 		if (mc_count >= BNXT_MAX_MC_ADDRS) {
 			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 			vnic->mc_list_count = 0;
@@ -13553,17 +13554,17 @@ static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
 	return update;
 }
 
-static bool bnxt_uc_list_updated(struct bnxt *bp)
+static bool bnxt_uc_list_updated(struct bnxt *bp,
+				 const struct netdev_hw_addr_list *uc)
 {
-	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
-	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
 		return true;
 
-	netdev_for_each_uc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, uc) {
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
 
@@ -13572,7 +13573,9 @@ static bool bnxt_uc_list_updated(struct bnxt *bp)
 	return false;
 }
 
-static void bnxt_set_rx_mode(struct net_device *dev)
+static void bnxt_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_vnic_info *vnic;
@@ -13593,7 +13596,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, uc);
 
 	if (dev->flags & IFF_BROADCAST)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
@@ -13601,7 +13604,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 		vnic->mc_list_count = 0;
 	} else if (dev->flags & IFF_MULTICAST) {
-		mc_update = bnxt_mc_list_updated(bp, &mask);
+		mc_update = bnxt_mc_list_updated(bp, &mask, mc);
 	}
 
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
@@ -13620,7 +13623,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -15871,7 +15874,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_start_xmit		= bnxt_start_xmit,
 	.ndo_stop		= bnxt_close,
 	.ndo_get_stats64	= bnxt_get_stats64,
-	.ndo_set_rx_mode	= bnxt_set_rx_mode,
+	.ndo_set_rx_mode_async	= bnxt_set_rx_mode,
 	.ndo_eth_ioctl		= bnxt_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= bnxt_change_mac_addr,
-- 
2.53.0


