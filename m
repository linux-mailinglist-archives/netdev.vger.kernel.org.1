Return-Path: <netdev+bounces-272676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DIGFmjoxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:28:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1934AF37
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 515D93164A2E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D93C2790;
	Fri, 27 Mar 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S11KKDD3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F83C0630
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642520; cv=none; b=WljEdOAU4hx5bFeeO6lW7z+cQBOFBGcZDbWzL9wuQmPUpz972xYtzL02x/oVG398gPiQFFqxNRlpiFczrZ1Ifh+8/Fx/evuxqvRECFGwPjAccV7viucQ2Id0mxIoWS8bRhOg2a4sS7pEUK4tVq5ys5vGKn9wRgDrKZeV8tCNxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642520; c=relaxed/simple;
	bh=TIpcFuh7n2ngbWAaEFXISNUyNN8Exrie9238dF/EPiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIYUjaFT19C+72zoZZcoGswUpEYIJJygiOY4fZCr/adAIvsFAbkkQp8Q/gp2RHblCtt/xE7E1bRcS/wnHbYFgQUneiI0k9x6OIxM5L1FVe1lwqPrVMS9qEPPqFBJWpSYOdae9T2GjC7Vf0pkNFT2A3rJnTp5xMo0X4NaPok8+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S11KKDD3; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c742b9b7727so844806a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642519; x=1775247319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPl7EmvJaJYETRrR8LpDympp691TF5ooz/XTqqQRZvk=;
        b=AqjlMGfoS/kOHzHBaiRm5DniroU+4sZ7hiSbd8aHh+TbtSnVBupNrMTKUNmhkfqo1Z
         YHJBNg4FPsOVzBIMFsLMW/dEUJacWn/MV0+0lsxqlrqXu4ExTs6K00lQYkdNVdD5nPys
         CCJ8IA4HJR5s06QHDXVKV6tzDFNFeyjb32Hp/ZZPatduF0DJA+ly3dlhuu6FaVhdPApy
         xxDj2gPhIBZqCLNNW+fRiehfU3GsnWApWS4NJpimOgJq0Rzi/7nciIACklXXwCgDF8+q
         eWnc320tFq39RteO9i2TbqXR+osNr4L6zJNNJvmKgTY6ajUwxDv9V3COLb6Hfe66x9MF
         94mQ==
X-Gm-Message-State: AOJu0Yx2GC85ZwaJ1e9ZLg7ljrXZ8Csrc9vl1DybBdB5xRCG5QMWi59j
	rtrnH9MDobLk1OMsrjYHChojeYfsbJo2jixVq5ge+37dCOh4jQt67GOv8jyaedClu/eEFNZQLZP
	WQ4uOjeS5eYG56IUaFp6PGjZTh98xVNyMxlE5JOnnbqEXa1NQqzDdWFRlUah3YFRSps28z9seF6
	LdWOE6rGUyvmdh06GpoWblEPSBUTDWRy0r7RY7BtSykpfRbYCY9PKfJVKBcnU7UXE25vAFDIQmr
	DtJe2kjVIuTBKAREYWh
X-Gm-Gg: ATEYQzwTtnl4MWSWPrTufx8YCoUeZ3eleVZHzKr+fUuJJSieWjAajYFYKQMjFbC7YJ8
	ui0vrbOdy+nwP0/3evFsy3YQsDoLnKvYUDQ9PUxudUjAK9zk5kDm3ChnodA2yUWVLcy7skv7CKN
	QXlOR51+6jgnnf7gBTLsNsDdJ1OvRUtKQ2f6bt0Sf7MWP9p143Lu4tut49enZq5QnoE9gL2A0hu
	qWYfXJCMTgoxMFfQJW0GBBkV6U9JaRCZfiUZaOc/YzXd8ag18AM+sx5/JcjSsKqGKRjq9m8npZi
	VBMKWNZuYpmpEN+lIOh+sIU7PM11e2iNBYG+Rlo99IW0aP5g+uTvGg/TU8hYSrTq32UGuxrIfQm
	LLuxmbmoA/ugdwGtpCg4Ld9Tp3cmVxzs8wVx4kJPbZW8nAyrkOtCKhR9pZwVpGb91R/BcY11n0u
	EE9pxDiWocLATKPe+hQ39jWHv7APLiieqzcyfnjIEUR25ONVI76xVe+Ic/mDVX7yI=
X-Received: by 2002:a05:6a20:5483:b0:39b:92ea:d182 with SMTP id adf61e73a8af0-39c73557810mr6597875637.10.1774642518747;
        Fri, 27 Mar 2026 13:15:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c76916e0329sm12672a12.4.2026.03.27.13.15.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:15:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794b240c0d3so71628317b3.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642517; x=1775247317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPl7EmvJaJYETRrR8LpDympp691TF5ooz/XTqqQRZvk=;
        b=S11KKDD3bg/88sPM12zZbpwDXUzw9maHThDtsBrlhSbtr7/UmLlKDCVT1nF+zFzxDW
         y7vDBasP4efCuAjWcdggQxAc+CtbVozoOWkI55Aw0juhOvqkGjF/yfxbXuoXzZ9h21jd
         7hgbngDnedVkOUZ9sj53WjrSrrUkG7i45zQx8=
X-Received: by 2002:a05:690c:6602:b0:799:1a4d:82c0 with SMTP id 00721157ae682-79bde26a772mr33848167b3.12.1774642517319;
        Fri, 27 Mar 2026 13:15:17 -0700 (PDT)
X-Received: by 2002:a05:690c:6602:b0:799:1a4d:82c0 with SMTP id 00721157ae682-79bde26a772mr33847797b3.12.1774642516732;
        Fri, 27 Mar 2026 13:15:16 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:15:15 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v10 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Sat, 28 Mar 2026 01:43:40 +0530
Message-ID: <20260327201343.16146-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272676-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0F1934AF37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the timer to schedule periodic stats collection via
the workqueue when the link is up. Fetch fresh counters from
hardware via DMA and accumulate them into 64-bit software
shadows, handling wrap-around for counters narrower than
64 bits.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 90 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 23a07f640847..3b9bcfbe6fdc 100644
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
+			WRITE_ONCE(sw_stats[i], hw);
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
@@ -328,6 +412,12 @@ static void bnge_sp_task(struct work_struct *work)
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
2.47.3


