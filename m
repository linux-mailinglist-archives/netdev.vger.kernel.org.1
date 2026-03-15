Return-Path: <netdev+bounces-267915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHq8DdfAtmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:23:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC607291003
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EC5730514AF
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE48365A0B;
	Sun, 15 Mar 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P0Pb/6eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8309367F2B
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584314; cv=none; b=QcFY+5CuGmZ+RsE7QcQWZdD3bh4C7k7YShmJezUpzh6926MctViYoX6q3FyTD/6VYU5RddJFtGrbbILb817uqDGY3MDUVbd2G52jZletTvBYNhFbp3KWzebsYZRq9qz42OTDyNh44NWbwYW5RSSS96g3xKo9yNv9mERmDsotmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584314; c=relaxed/simple;
	bh=uNBl9Psxva5SJPexCKlx/63Rr8yoHyHROPl3twU89Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTh0p/LRj/z+oFSy0Ppn7REXKRbvRutV0vKRM6dwOZPjO6fxxQa6PcXkRp8SKhMGMzS1EG0xuhnnhnjC+fCyqAIRt54rlS4MF6t3J/Ztp7niGJsJnPiT3kVJKfOQKrnjhtPVHhrMl8s9IB77pFf0SAVeP3N951nzu3nF3pOKCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P0Pb/6eQ; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c739d32b72cso2534238a12.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584312; x=1774189112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kebxp6wh4nYYGznvwFFSyNwKbOSUnFEmSaJutA9Bji8=;
        b=pQ9WABeLBfC4Y6hj+NEq5qIE09NhheAevZeP3z0vXfqcXpCbLq/HIfIba9alGS4EOc
         1RRpSeisQ68Aua0pQD2Ae2mtJ/xGSkTJxECp12+z2ZwZf8qDqQGgiL7fmASM/E71+i3l
         FaeXsbd6hlZkQIz1cwdro+VEWs4tve8tWDQB0sqVRypjTo/beLytfYaDnZ9PYUix8WMj
         QYmpoOIJE4bYaszJEure4L6clctwmiqQWk6JOUPxRJ8Se+yttoWBXXUEi5GIj2hZM6LA
         wYXuyDx2g/pHOsb4Mj6Xp7SI30sP6iremtTsvDi3gfsKK0E2hRbutypMWx5UNxhba3nZ
         60uA==
X-Gm-Message-State: AOJu0Yz34iaqpwsOhXMl2cc5B/yj1MCLboDzSdLXGpT1Mr9HuYGdAcLH
	BlrZ14clY6OgrYzmC8QpnpJJE3v1Ho311zzOIJlAyEoviK1/LJ82NOVY3QhljQN+aBfpfUG7bhV
	39XQAPHmbttxjjjeAuhUFa0cVwZcN8Gau4UV/CHsW652bPK/VnkEkl5eT4e2b9GrykCpehTqGNl
	o+6Lpn1gcvyZj5aERhEkbTrupYNybYhJr/GF86ryrLGOlD8ro913rxKjUSG2CHH1b+4RvPMEOTv
	pjdbXS0Jg==
X-Gm-Gg: ATEYQzzT0kDmFKT5nDGMSGjX494+svdLc4U7TS96r8qsLe2U09Apb47wXrrJOJswG+2
	tgmWOCDdguhtoJlVGlhVfx3Mb41OtSRXO19YfQ1g5aWaLJfF6++k7F+Qggg3ZnxG5TuSuexS6VO
	w7YObYN60RA7fNPNeX59NcCGCtmgBkVxh1dbEM8i5VOCQ2vD+uOxhJb/IYuA6POajSUkQMMRPQG
	+npP/lWlw0y6vJOB1jp/xrw4TuGAjF1SE1uAmip01RqtC36QbpQo05ZNpPneRF/fb4iva0wgdUy
	55QAE7633SJUOFZbS8R/iI+50sJiTzL6cDCFFX3zZqe8W+Cfjx2mGhka2k0uRqoD+6fFR5uDdo+
	Prp+H6FgJK2ElR4czlBpGMLAggMLg4+lKWqfh2sP6FkUAxXXbcsw7qOG0oM2LBMEidiY/akuEkP
	awZzf2SXduCViqzhZ+pvfS0h0Bl03GVBN1AOrFg1aK5CLHTW0rFxN7Ssw=
X-Received: by 2002:a17:902:e88f:b0:2b0:571f:6f07 with SMTP id d9443c01a7336-2b0571f7b2fmr5774875ad.39.1773584312281;
        Sun, 15 Mar 2026 07:18:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece60cd8dsm9439005ad.21.2026.03.15.07.18.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:18:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae53ec06b0so273392585ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584310; x=1774189110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kebxp6wh4nYYGznvwFFSyNwKbOSUnFEmSaJutA9Bji8=;
        b=P0Pb/6eQLoedK1EYR2rwEKk1gA4vmNlc/9rOM1H8VkVTNisSuYzjaf4eOkJeAnd8rC
         YtgbPj0abm0xdcVU2WVXrRGJ3zeXRDfhExffmjKt3ZCUcp+yMk/7h1pGxoq2xhke9sHR
         B1yJmWOLSonzR3Q3LIx459C9FOV/1wGMdjLQk=
X-Received: by 2002:a17:902:d504:b0:2ae:bcf8:c338 with SMTP id d9443c01a7336-2aeca9db5dbmr99253595ad.21.1773584310576;
        Sun, 15 Mar 2026 07:18:30 -0700 (PDT)
X-Received: by 2002:a17:902:d504:b0:2ae:bcf8:c338 with SMTP id d9443c01a7336-2aeca9db5dbmr99253445ad.21.1773584310210;
        Sun, 15 Mar 2026 07:18:30 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:29 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v7 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Sun, 15 Mar 2026 19:46:02 +0530
Message-ID: <20260315141605.410878-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315141605.410878-1-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267915-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC607291003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Use the timer to schedule periodic stats collection via
the workqueue when the link is up. Fetch fresh counters from
hardware via DMA and accumulate them into 64-bit software
shadows, handling wrap-around for counters narrower than
64 bits.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 90 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9f62b5f19a2e..93f0149bd775 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -313,9 +313,93 @@ static void bnge_timer(struct timer_list *t)
 		}
 	}
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
+
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
 
+static void bnge_add_one_ctr(u64 hw, u64 *sw, u64 mask)
+{
+	u64 sw_tmp, sw_val;
+
+	hw &= mask;
+	sw_val = READ_ONCE(*sw);
+	sw_tmp = (sw_val & ~mask) | hw;
+	if (hw < (sw_val & mask))
+		sw_tmp += mask + 1;
+	WRITE_ONCE(*sw, sw_tmp);
+}
+
+static void __bnge_accumulate_stats(__le64 *hw_stats, u64 *sw_stats, u64 *masks,
+				    int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			sw_stats[i] = hw;
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+}
+
+static void bnge_accumulate_stats(struct bnge_stats_mem *stats)
+{
+	if (!stats->hw_stats)
+		return;
+
+	__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+				stats->hw_masks, stats->len / 8);
+}
+
+static void bnge_accumulate_all_stats(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct bnge_stats_mem *ring0_stats = NULL;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_stats_mem *stats;
+
+		nqr = &bnapi->nq_ring;
+		stats = &nqr->stats;
+
+		if (!ring0_stats)
+			ring0_stats = &bn->bnapi[0]->nq_ring.stats;
+
+		__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+					ring0_stats->hw_masks,
+					ring0_stats->len / 8);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		struct bnge_stats_mem *stats = &bn->port_stats;
+		__le64 *hw_stats = stats->hw_stats;
+		u64 *sw_stats = stats->sw_stats;
+		u64 *masks = stats->hw_masks;
+		u16 cnt;
+
+		cnt = sizeof(struct rx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+
+		hw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		sw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		masks += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		cnt = sizeof(struct tx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		bnge_accumulate_stats(&bn->rx_port_stats_ext);
+		bnge_accumulate_stats(&bn->tx_port_stats_ext);
+	}
+}
+
 static void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
@@ -327,6 +411,12 @@ static void bnge_sp_task(struct work_struct *work)
 		return;
 	}
 
+	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bn->sp_event)) {
+		bnge_hwrm_port_qstats(bd, 0);
+		bnge_hwrm_port_qstats_ext(bd, 0);
+		bnge_accumulate_all_stats(bd);
+	}
+
 	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
 		int rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 74b08d492c53..548c5a77e76a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -276,6 +276,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.1


