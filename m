Return-Path: <netdev+bounces-262098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH+0LkCaomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:33:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252AC1C10D6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28836319D56E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEE36CDF5;
	Sat, 28 Feb 2026 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BgEP7TZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A336CDE4
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263709; cv=none; b=eImGAn9jiLF7Om4L54cdZZhhhFGbMNv4JVNAW9YysAKyjClvrztIYcbyKI2croLQr5ErpM/UUFhfjYc6PyTC3K/PUmnn5pq8nQklKaufSQPrNV9ujKCUea18wkMOM4IqvHdxNX9eJlYKqdmbAB15d0oiHHMmKLrBmav1B3y9KhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263709; c=relaxed/simple;
	bh=qKDKHBItqjlnp8iifqqtVQdCi5Fm/RBPg5qa3TEt4zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwrkfHl11WkWOcTJA/md7piwtzqE3aZzTR/epIcUqsXlfH5hKfoS1ZewZZQo9YZ00YDKdqpHDIMAulRATPjVlcqCdtX21gTiwqeQBco8fgwxCfv4FlXOFON56JpMPvAFFjpULELnmtFKespKhHNyxRBb+JsATpbKa13T8STvHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BgEP7TZq; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-506a297c14bso26200801cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263707; x=1772868507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NQ9BrBInuBHEDXnVhh5tO7NgvGRCwjBMLMeJv/Jy6A=;
        b=Hrat/47g/ETsXOZl1p9u8sfUCvVXDT0ggJ8Cf/1OJ/eDOzMRDeq3WuwN9dbC9OlJF/
         N7Nj+Os4zHRKfXeAL73GCotJ/ce1CNP2+EnZCCRUOeucSyb/UHL4BM9L9MvDT9h8yr0f
         da+H7Lq+8Ml5umMmaJXmA4fTnsoNbPG+nDgW90SFRQFutUWD5QLr3/ITBdN/Czl4PJdU
         QUrPbKyPH+Nr3pvHemqftDm05cm+WgfhqSpBnme2g/vOXVpuuc+GVVc/c/MmGapYl011
         Ip1BR1qNCJwLR3chyjHNq2XP6mvEeLlZ/xgDEqvdxM0UE+PBiAo0KbbUNfHos7gsjUIA
         vjFw==
X-Gm-Message-State: AOJu0YyaYBlpFaPVkq/kYtvcrSUqtHnaeUZhJwCLa1MQaTEyK2Y9IIxF
	himqmH9HSLaRTWtjFPFxkBObX3+yADG83c8XDVnBGhJQVHLdwI79EfJ+5yUT1lThciLtYF7aDrE
	0Qars59OefLXB/yZhtSlY/tdT7VJ8acov/RjrWcR/EUt1w+AGMzHb29h/N8NdBkaDO9XiFffUjE
	SjcSTyEj3TOztyl4ydoaU6mXB3QOs2tnwaqJyuccF0R3PBeQuc9AeH84uFRGw7/H1fDmA9+HYzf
	yXMMsDqseFlZDItQw==
X-Gm-Gg: ATEYQzwiGJDc7MX5XuH7EFqsJ9496G3wcvNE9MoyXJlps07KYHcWfAs9XAHUk1Rjz33
	fD8+m5KIR1AuNZkoGEwd2KOY21UDkZm+vahvyY+6AHubd9pFzgNXH6mTADcHc8bfEIWqAag/gzy
	gagsT0sLWWKDY2fpFBjI7wky9i7pt1h4waoltEIIFmzp/2uOlV+UJU2NFr9dNRUl7eO0TQ96PqH
	ojHAF7ORMKPx7OVTRbT5bwVJkW+I/5uFF0E6emt6YuLWml2TD7Mz4xFBiOK3yErpinuyKRpmQHJ
	7i/N5wBmvUVxDLD0kvsMB3Ks5NQOMwrK6EB0MPHO7aYglClZy/jXvQIHoaOOUhwpO10wC5vLDoJ
	NyK05WJ22C252psU8ImarlyPAbookazpRBcv9uJPjGqUHtskW1QLmRl/RT7H0WokVNkSmb6ui2R
	orio3sbFlQBt08NQhreiGjTl9QC74mS5r1hnHy3eD7CBlHzmymoqa81oCMzVt9Mv6kyw==
X-Received: by 2002:a05:622a:164f:b0:4ff:a46b:3af3 with SMTP id d75a77b69052e-507528a7dc6mr65482641cf.16.1772263707346;
        Fri, 27 Feb 2026 23:28:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744957ecbsm9304921cf.1.2026.02.27.23.28.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:28:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-824b3532298so1122816b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263706; x=1772868506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NQ9BrBInuBHEDXnVhh5tO7NgvGRCwjBMLMeJv/Jy6A=;
        b=BgEP7TZqqLSvaroqMRuVGKhi3aHUIupcldVKZYOEGNGmzHSQhcGKNhoc4Tm0tl5GBV
         cJZxS6ALu8fg+qlHuOoSckOfzjyBnRlSNZdW0ONh1gA5cDfvL/TAGHy54VtgSyA1g0Ew
         6YkjKt6Swu/0ExrtjORzVsJ8XJqFrhv++mOUY=
X-Received: by 2002:a05:6a00:6f22:b0:828:d9a1:c5f9 with SMTP id d2e1a72fcca58-828d9a1cb54mr1417672b3a.33.1772263705716;
        Fri, 27 Feb 2026 23:28:25 -0800 (PST)
X-Received: by 2002:a05:6a00:6f22:b0:828:d9a1:c5f9 with SMTP id d2e1a72fcca58-828d9a1cb54mr1417649b3a.33.1772263705273;
        Fri, 27 Feb 2026 23:28:25 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:28:24 -0800 (PST)
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
Subject: [PATCH net-next v3 7/8] bng_en: periodically fetch and accumulate hardware statistics
Date: Sat, 28 Feb 2026 12:57:14 +0530
Message-ID: <20260228072715.1632280-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 252AC1C10D6
X-Rspamd-Action: no action

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
index fff31f85e17..29c072e38a7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -322,9 +322,93 @@ static void bnge_timer(struct timer_list *t)
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
@@ -338,6 +422,12 @@ static void bnge_sp_task(struct work_struct *work)
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
index 324db55fc7d..f160ba9b69c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -305,6 +305,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.3


