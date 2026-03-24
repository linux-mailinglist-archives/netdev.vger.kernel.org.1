Return-Path: <netdev+bounces-271279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LWzB5DvwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:09:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D931C25F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06D283046F5D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E5340A5A;
	Tue, 24 Mar 2026 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IYs1ln2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B5326927
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382935; cv=none; b=jF0KF005dm1FfNPQDvlrjAxJGCCzJZZ6Ln358SwP/MyCNC64/5DLuekw3ZDTvn6uFTBWKNRqXxa61fvfkg0rH4baArCjTaLwYA1GxS9V3ODY2CHPZX9ZXnc77Bg9HRGnseSuXQyAp6A6BuZSt9NJhLThkuqSnzeXZ8DcyFTdaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382935; c=relaxed/simple;
	bh=hgtx5DhPOKPCho9c0wl9Kivlyh35wDQGK0eH+R5yiZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbHhDgSDp56GKssB5zBmqj+kw6cHNT2/J1gnT9TmTmWl9Mh2XXk1ujtF0qL36DvUTyfFn6wG7dmFRelGlv0X4G+AY3pmxTfNFNeVAaV4deNAFSt0y2anxit2x6I3Dp6uSK53iRBDZiRiXbLZNnt+wRVCBnKIcS/xI0W547OKGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IYs1ln2m; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c7412b07f22so112144a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382928; x=1774987728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pxxzbypf53pxP6inFxYsPbLMyq3tzwpCDDjX0r9z0Q=;
        b=YaT9kL4aVT8B6ZKgPIYhWK3qEDSUtZ9KoWPTGXs7Ueykk1aarqTsTWSLRxqdooU4R0
         5F6bGx+qBCt/HdTr6gdAC4L70QIBNyH4LuPvXxBVQszNaWPxTdAplAf7Us2pUheRtAEq
         gAKYaqmfk8krkxdS+9t9h02H+jPLNvrvqIG6ICMCf4MRFaozWNZEy6HLQXnK5nn62ewK
         lAedcoHhmtoFwmPeZll55y9R870n+vaXLxFjzACV6dKT9DmaSKgl53PrBGONnlE8ozlu
         O9dYULf+ff0psg+PTysVM2NPzwqsHnV8EnwHACIhjr0CcKuEQnV8aOD1sal2AL/skQZk
         F3vw==
X-Gm-Message-State: AOJu0Ywr+VnfiV8Bl/El3XZj2xAAilCn6seLxL/UJIQlkhc+zqn1K2Pv
	dfv1jcwe7aV+m4OcjZd+Rzp0GuC48TksmfnnaU5uiGYia74S95O3eToBfkYisCm/ococMTA6EB8
	5c2h3j2AnlJRUeHYXn8LKbi0beb12ljSntyW+B56oN6J6TIHhWH+bhxTkGr7LNCHhUwGSPeVbbm
	k/ualFO5iDAfOqYBaPzDsfszZQW7LQtj5TZBuYsMif44MP7pNfWy3BQOGCBNsiTskNZWF6nZr4T
	heHdscQb9QJi2vXrw==
X-Gm-Gg: ATEYQzxd4bJMniBIGhBnRKoAZqK/czrHTqzjSPpXVVvL0UdYR3duLXccko7K/He6jc2
	Ch2ZrGlSBpNlOrlQzMu7FrbZ5cY2ov6XzxVCSxjvM0wylnh3rfnL9AXdhy2HQ4jqIDQP/63UfKM
	kXXuWSNwXASu98LlEid/JH9lTDHZvTGdeDfYw/BHtrn8tyIisDMgA0Pj7kWRMFqeK/egX4PeC7o
	vBIx1GYo+AvX8oucH8jh+3x8VcG+yxvZIWwYHqdGT1dPVRlXmEpU71MalRQOOIWyTkM0JAMq5j9
	sZ9AzGT/FaPVS3e4YasH76zu9fgTzeHtUoCYsz8i0MpVP+CfNYAH69e9ZF/dT0qMkOLvZapUi7u
	ZKiRTc0H8/xLhzHIqbDVaejpi8jAesRitOyBNk/XhlZgUoaraSdZXDv3wqCDBYWwMGf0LAavS/6
	wb6i9Li/p+scUzt9nqCkEUM+kiasjCJi/DDV9lCB93AmKdlWPWtEwVqnOCyEgXiGIwog==
X-Received: by 2002:a17:902:e847:b0:2b0:5306:5f20 with SMTP id d9443c01a7336-2b0a4e16ca1mr42138335ad.18.1774382927755;
        Tue, 24 Mar 2026 13:08:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0ae468a14sm1674855ad.45.2026.03.24.13.08.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so155606a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382926; x=1774987726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pxxzbypf53pxP6inFxYsPbLMyq3tzwpCDDjX0r9z0Q=;
        b=IYs1ln2mpRDXQqpagkLPUcMS3ZBJb2auA6OZesSGniCFhlJsWWzPY7nJAInbwz811A
         PI/kKeIijYYmBoKgGbOnIhGJY/kSuMqHvFjJfj7s++6t0p8/PwMIBZaJ+pHNJXpQ8WTF
         B4KZQ6JU3DBrw5AMZjsM8P1erezmWfmCI+a94=
X-Received: by 2002:a05:6a20:3d19:b0:39c:212c:9088 with SMTP id adf61e73a8af0-39c310290femr4590660637.20.1774382926050;
        Tue, 24 Mar 2026 13:08:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d19:b0:39c:212c:9088 with SMTP id adf61e73a8af0-39c310290femr4590635637.20.1774382925594;
        Tue, 24 Mar 2026 13:08:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:45 -0700 (PDT)
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
Subject: [PATCH net-next v9 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Wed, 25 Mar 2026 01:37:37 +0530
Message-ID: <20260324200740.346029-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271279-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B67D931C25F
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
index b03a9f186b97..8e59935c6826 100644
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


