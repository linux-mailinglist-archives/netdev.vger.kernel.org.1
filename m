Return-Path: <netdev+bounces-273815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA9jLsFyzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 636123736E2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C055F303A803
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D82868AB;
	Wed,  1 Apr 2026 01:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4329D267
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006366; cv=none; b=uUuw66He6q1OLafy5Zd6b6nb0irIuCJXxmBx1F4KrZITGsSywwYzi0oVrLjw0mkbVvj7rOdHGebsMUxmopgLyb6CAkj34dgjG47oPUswvPUwWA2kUWjsmO+XutI4YINiRV1joJD3huj3IICJD3B8zrizn02gqvHy1uPgNGZay6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006366; c=relaxed/simple;
	bh=t1exql4/Ix3BsrdYRR+luYRI0WA+2T+nHyND5a1pukU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px5H+BRrbu74Abo/7N75GNVmSVkuMdMp8+uYegXCYu58Cr+VKRWKJfiiTLJTs5tt7Vsui2P3zwOKPbHxlnV9fMxCTsRpatHkS2SXIUwaFZeAgdgYS9UbtBqrWEbTStd7CpOys5AMCnqSoBd1S6dgoHb2v5DNwTcAxKs6Ni05jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128e4d0cc48so7598002c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006364; x=1775611164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3ijjUZw4OlL6/tdhFX0BO0poRtsutbJEx/GXaQEh5M=;
        b=WsUaGcluFiGaKKBnyyZVOpKGUIxaCIfBwK5Svz8tr199CPRDhWfBIffjzVa6xezVaG
         XSrT75tUDopCCcQRV70JMlUj4ISAHt5myIK5RQnIig9/H17Ex8J7Jo8ra5RQBdUCUbwX
         mZZoPOuOaPjfxM44OnFkGUkHwLCp2+CH0PJl62Q2yRdWfS6HmJB/81Vyz+zHqEpRsXL8
         rxFYPynhpAuo/95nraxrICNAeoUIrCNKR1cFeNRmFuC4Co9mUByB5/kvzD+3HFY+cM7x
         acy+mxEV0trigWrXorUR4OCtUQkfJEd26XpRbBM5DipTFVHZX7mU/KSWjo8pVsJUeiDR
         hLNA==
X-Gm-Message-State: AOJu0YwBgwVBwAanOKt+9mnGHrxN+fdc+Ihlw0ktqsKolqsk1VdtiiTL
	ZtFyv4sqdjo513JBvIRLpeC0Bnheix7Tomzsd/aiqoDPoGakXw7JBeYpNONk
X-Gm-Gg: ATEYQzzXcioEMOM8sH9bHdl1Z2U3u1aJShv443tAtIYejek2LNAtpcQ3UJNF0UU71Z5
	hczNoo2S3t2wZJJD++sozO/G4JL3bF/lu5WdhGkqP2dEDs621ohHaGMEWBWOuEjH/ZVUhUyP8z4
	MEgV9fUaw8JLpeOjSrnS1ltHOA66cDUp3Hj3WLMYk1CILN/jc+qwGkhP2Xr9pKy+y/Wyn4DQvxw
	UPNET6tKZZp/leO0i9lIE2/WKXpDzohIihVGB8gCol1soJs6sxbHg2tyYVUobB5imjF8CcoRJpp
	FGxhwQJdKST6lEmGucCwLd1qWa2ml5wuXeezK6CFeo8W9PFKbwFm/hn6PEFOOKGMluCERZW/LKE
	p8jos/tRs50nQe+VhGGQ0D3QcR6B88Yo4FPAI8T+MIEgcB0dFaN1B5nBGToS949fMRKoX+hVMAX
	XLZV6aphEbPrdwcLc2lhWbo37R8HKV+K5C953X0nCi5G+I7p6vvuxlmjsKgDvGyQiRbWk37M8As
	iY2N24hveXrIqsxt6f12cUOFq82
X-Received: by 2002:a05:7022:f68d:b0:128:d5f1:d595 with SMTP id a92af1059eb24-12be63fb902mr1026379c88.10.1775006364026;
        Tue, 31 Mar 2026 18:19:24 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab9864810sm12455829c88.12.2026.03.31.18.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:23 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Tue, 31 Mar 2026 18:19:08 -0700
Message-ID: <20260401011914.1716692-9-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273815-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.444];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 636123736E2
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


