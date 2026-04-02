Return-Path: <netdev+bounces-274731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AXRHnz0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EB38EECF
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4CA3028031
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6C3D5674;
	Thu,  2 Apr 2026 22:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804A3D567D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170547; cv=none; b=QqeJykLjoLX1NWzLZdts9OFbIC6PaKhd2l8dQEPep2MxHYpSsBmkRE0rnJ/w2Nufzeik+UOoyWSDW/oUVuNMOfufYFpgdqwEwlwMKKYKyCEVjU0QArZinyjnH8JQINMnnaaGZO6+q6wiiD3D9Nd40JO7d8UYaf+6ezpE1ikPHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170547; c=relaxed/simple;
	bh=iiSIzUBrs56QjIqhttn2EO5XzFfZ/VuXZ0WpLCk8nqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2vgssdYzu/zYDniumdDo5dPoZ74hsENYip3g14aCXtsovDHH0VjYOu6BO8KAJaXdxImRQB4Pxa8+KQfj/jxIyCqKbmuRIL40OHABi35jpEiPqAr2Pf2S+M6rDeWZDuFDYdFpGFcfDVrXDtCRqnSDmyDgj1oYdevbAjsGo1WMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2153722eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170545; x=1775775345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LR6nleHgd7kuRhOML6TjIwEgeuF0IL0PUeDGrY74Rc8=;
        b=NkAei6jGw7UBu8rs/DvcHTx/RFwSrnOIwdLxTJKvOp6eHYpaG/QogYeSmT7MjV9rHT
         BqsgYpak6gAiz82QwtCPigJfNwf/OtWizA3/EU1hObA46aLb+Yvna6el/G0vppWgVtbI
         uDgUFleIMDDiESoSnzJaS9ZKJCgrVsyXaprslW+l7q67IDv2ZI48V5BR2BASCZVPssW0
         rSd5R4tgBMKNW+vLykczoxfqSuJwRNElnFokN0X3g4kQPpsvu/bNIkvl6i0qTMlGwTgc
         I91Wg7JgEsI7apBKeRfPXx2lTs/jAkunSPOkt7LIl8Emx8YT13/FnD58jNX7X3LpGb+z
         QI6A==
X-Gm-Message-State: AOJu0Yw8QK+iOzkThCGVYnsQ6OVwHnQGmZrvlRFTluB8M1Nl6EulroHD
	DIIRjteoykU/zBgc90d/pP+KHtS8Nud/f01Gzf9w7xzJGZznATtiuYJuhMt/
X-Gm-Gg: AeBDiesNZaIPFYUmjAIQhDNGf2rhQUhEe+jJPZnl7ljX8bn90FyyydiRX4BeMiRqOqK
	7R1BoWHn+g4rSzkHCF+tox5GVb2GpMtRkHMk3LdVBu2//IBW5ZJGO0YtkjPHotpekss15MZLQUT
	g2bBHqcM4Hawow1LDIrWQINJjEnGxfTp7AUxr885EfvvcITPftzYHS6m40J8WCQgHobVACadBUW
	I1p80QbAPUqGBy8D2fEjdLBPkIuUhcUByMfB5SJwooQrjmHjoW2iKoEwRkk2Td/oWh8bNeMHS/e
	j4AOBRu5rhBgkMqOm6ADTsq6H0D6MovQnXXEiFoy4YHUBXsovl2ZHP6/TekFJzeVC5g6WdlkNyB
	ALsHiywWTbW+8HkrXNrL8wlnMBMt5Cvs4FSNwK7IZvpRaMLJ2ew8HExl63a+N8FFQgb3rOP63GD
	7rl64Jxh+ayp5Y/grUGPBycso0CMcKuIEh4UUJGNehKvf++2rwPdFfH/WxBTjXE9KQSqAvAXGaG
	gqh9U2X/lnhZDzYdQ==
X-Received: by 2002:a05:7301:4090:b0:2c4:dd55:ffc1 with SMTP id 5a478bee46e88-2cbf9af8898mr509933eec.2.1775170544975;
        Thu, 02 Apr 2026 15:55:44 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm5945808c88.0.2026.04.02.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:44 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Thu,  2 Apr 2026 15:55:29 -0700
Message-ID: <20260402225535.4124525-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274731-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,broadcom.com:email,intel.com:email]
X-Rspamd-Queue-Id: E90EB38EECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the introduction of ndo_set_rx_mode_async (as discussed in [1])
we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
use uc/mc snapshots and move its call in bnxt_sp_task to the
section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
bnxt_set_rx_mode.

Link: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/ [1]

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 33 +++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 11956c7dde23..48aa9fc53229 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11032,7 +11032,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *);
+static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
+			    struct netdev_hw_addr_list *);
 static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
 				 const struct netdev_hw_addr_list *);
 
@@ -11128,7 +11129,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnxt_cfg_rx_mode(bp);
+	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
 	if (rc)
 		goto err_out;
 
@@ -13603,24 +13604,17 @@ static void bnxt_set_rx_mode(struct net_device *dev,
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
+		bnxt_cfg_rx_mode(bp, uc, mc);
 	}
 }
 
-static int bnxt_cfg_rx_mode(struct bnxt *bp)
+static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
 {
 	struct net_device *dev = bp->dev;
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	struct netdev_hw_addr *ha;
 	int i, off = 0, rc;
-	bool uc_update;
-
-	netif_addr_lock_bh(dev);
-	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
-	netif_addr_unlock_bh(dev);
-
-	if (!uc_update)
-		goto skip_uc;
 
 	for (i = 1; i < vnic->uc_filter_count; i++) {
 		struct bnxt_l2_filter *fltr = vnic->l2_filters[i];
@@ -13632,10 +13626,10 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	vnic->uc_filter_count = 1;
 
 	netif_addr_lock_bh(dev);
-	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
+	if (netdev_hw_addr_list_count(uc) > (BNXT_MAX_UC_ADDRS - 1)) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
-		netdev_for_each_uc_addr(ha, dev) {
+		netdev_hw_addr_list_for_each(ha, uc) {
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
@@ -13662,7 +13656,6 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
 	if (test_and_clear_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
 		netdev_notice(bp->dev, "Retry of L2 filter configuration successful.\n");
 
-skip_uc:
 	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
 	    !bnxt_promisc_ok(bp))
 		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
@@ -14593,6 +14586,7 @@ static void bnxt_ulp_restart(struct bnxt *bp)
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
+	struct net_device *dev = bp->dev;
 
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	smp_mb__after_atomic();
@@ -14606,9 +14600,6 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_reenable_sriov(bp);
 	}
 
-	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
-		bnxt_cfg_rx_mode(bp);
-
 	if (test_and_clear_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_ntp_filters(bp);
 	if (test_and_clear_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event))
@@ -14673,6 +14664,12 @@ static void bnxt_sp_task(struct work_struct *work)
 	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
 	 * must be the last functions to be called before exiting.
 	 */
+	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
+		bnxt_lock_sp(bp);
+		bnxt_cfg_rx_mode(bp, &dev->uc, &dev->mc);
+		bnxt_unlock_sp(bp);
+	}
+
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event))
 		bnxt_reset(bp, false);
 
-- 
2.53.0


