Return-Path: <netdev+bounces-273814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLPILt1yzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0303736F0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5394F3017316
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620EF2853F2;
	Wed,  1 Apr 2026 01:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0B1D8E01
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006365; cv=none; b=d7cAz5z+K5P7jCP6rMIjJvGx6syEgCARvNX/FX371+7eZRWW/EUy1mKpJ2BAn5NZdjiwlQ/81Ysr5lEBJa6fgLmrsBzE4wDFsvRUM/K4zLy8NzT2YU4dPMq6CLKJ5uWLpWWwuUtE7LwXYxCAn4bCIGNr/x471K7BOcoefWSFbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006365; c=relaxed/simple;
	bh=zJbC+A4/QcCaZAvJAW447Q2AMW5b/YkYtsY9TGpfZ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0WSATfoGqY27OtEV4id/OryAE6YXzZw4k4gdUeCoxqtTrtAeAuh8Xv+fD+dfuBuQxDiJfqniaq59v4xUYHQ2sIEOK8I/wK7TkHsmb3FE7Z/N9U4xfSqsOKyiDbwc2UjkkZVUIp52AOYOiyEqa1defYf0NPUWfGbq1ZbvmaixvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so1042843c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006363; x=1775611163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gV1gd8eqR5trFawrue+Fwjx0Nv4SVD+as/Eza1/G79Q=;
        b=GSuNSE7S42BGxYyOPAlNJFCsK7ekSwbYUGom+xBG7Nqn0W6YJi2tzI9Kj9ijcvuE1Q
         BWMazqxPQz7VWC+m4vP5hLRwATLjYFla2qi6fBeF+mFnRq/3OZBU1kMa0BXlfhEvw/ZV
         GMYYBeSAvaSwBVDAiRRJKUrusDk02f0LcUbZAcUaxuiQBAJfE8iekMVW6NNDsOge8l+b
         Ymohu40tL/cySkTA6xo11bm1IpRQwwh/Pj+foZXAowsue21Fdm78xFG/yK58ByZo38i5
         2mUdGQGaqVfeHwprz89FamuWz1S7JK+IOsXNaEfV4x7Rnn0toPVGpSlnGXlWRWG5Gi+5
         rT7w==
X-Gm-Message-State: AOJu0YwGBHatJ4i0OFsQmdO6FhJvNVVscCGfieF0xx3t+86Pvcutxq+u
	Rh2PxWNyH34EUGuKgKhYV0MCEMOIDrzWx9qfiR/4LWXqVzaBiOav0oMyo5dU
X-Gm-Gg: ATEYQzybOsAoh+j3owi3tKhSpv7IR0vN9BZGDTP+mBdqJUcLFz77vFDeW1Y9qdN5xMv
	eyd30ncD6rLkmdys1ZnOjj2CU40to//rK0gInJxFCXpo0qvZetGiIRW7ANrzz/lGcX/fj/CAPEI
	lWxUMtQsj1ckZGQ4gs+H8kXQ5CjtvdcyaRGmzhaw7J07UI/22UMtqPQymGZOW1fpWpKSljr7qTY
	vrjloMWAyh9Z0dtQRXTWlsbVNSGqKYXh7JcTsxNtBLu4okC+j5QZxFfHhryQpZeh1YA02z9DWiB
	cEMBPhw5b5s0rmCxZbQx2GgIAtyO0blq1vvviwh0E8P2WUvFjRUizGa+TpAtKyg+7evw3+3sesJ
	uTow12Lg5zJM1Ihi1vjtGf0//GN/m/XJbAUEjapWeowloq5KxTItNTD5WdOuT9cLj6uux7XaHkE
	jrTYnK9heSvsyuXEp+HedSlDLJ2WBpEhCMdPV4soTy0ho9oc+8Jj4PPbhakLIla6TqG2FAdwHF0
	/ONAkU/zXtCLjhVUdcI39TeavM0
X-Received: by 2002:a05:701a:c94f:b0:128:d2a5:709c with SMTP id a92af1059eb24-12be65531bemr1092520c88.33.1775006362909;
        Tue, 31 Mar 2026 18:19:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm12615341c88.0.2026.03.31.18.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:22 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 07/14] bnxt: convert to ndo_set_rx_mode_async
Date: Tue, 31 Mar 2026 18:19:07 -0700
Message-ID: <20260401011914.1716692-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401011914.1716692-1-sdf@fomichev.me>
References: <20260401011914.1716692-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273814-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid,broadcom.com:email]
X-Rspamd-Queue-Id: BD0303736F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
now take explicit uc/mc list parameters and iterate with
netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.

The bnxt_cfg_rx_mode internal caller passes the real lists under
netif_addr_lock_bh.

BNXT_RX_MASK_SP_EVENT is still used here, next patch converts to
the direct call.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ec611bc01ee..11956c7dde23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11033,7 +11033,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 }
 
 static int bnxt_cfg_rx_mode(struct bnxt *);
-static bool bnxt_mc_list_updated(struct bnxt *, u32 *);
+static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
+				 const struct netdev_hw_addr_list *);
 
 static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
@@ -11123,7 +11124,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	} else if (bp->dev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnxt_mc_list_updated(bp, &mask);
+		bnxt_mc_list_updated(bp, &mask, &bp->dev->mc);
 		vnic->rx_mask |= mask;
 	}
 
@@ -13512,17 +13513,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
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
@@ -13546,17 +13547,17 @@ static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
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
 
@@ -13565,7 +13566,9 @@ static bool bnxt_uc_list_updated(struct bnxt *bp)
 	return false;
 }
 
-static void bnxt_set_rx_mode(struct net_device *dev)
+static void bnxt_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_vnic_info *vnic;
@@ -13586,7 +13589,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, uc);
 
 	if (dev->flags & IFF_BROADCAST)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
@@ -13594,7 +13597,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 		vnic->mc_list_count = 0;
 	} else if (dev->flags & IFF_MULTICAST) {
-		mc_update = bnxt_mc_list_updated(bp, &mask);
+		mc_update = bnxt_mc_list_updated(bp, &mask, mc);
 	}
 
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
@@ -13613,7 +13616,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp);
+	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -15864,7 +15867,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
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


