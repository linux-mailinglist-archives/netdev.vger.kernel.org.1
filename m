Return-Path: <netdev+bounces-260120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHLpEj2FnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:50:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B236817A24E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF1383148DE1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E69328608;
	Mon, 23 Feb 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aCGcL5YH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFD327C0F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864677; cv=none; b=UNV8ltYBmVqIIsEIioey+LWYakLEVCMSen6x9egib87qI9mrnhw5gQO0svxEJh7Jjfgc5SsEVX+arCPYoFXj0mtoWOaSaFcmINZgtL7X8Xo0zn6GjC9CvWlYQFu4SZRHkZY4oPLMXCjLzWnTitwbf4TBy0UaT7F998ZzWB+pHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864677; c=relaxed/simple;
	bh=AdKt8wrJmv4nluSRJ1kG2mGHhXNw88ryp6gQeexchcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKIXVlplY7WJyzs27+xZBMEIuuz+WTSPuNpuPL+w4gDqCA4mkPAdgLJ6gZ9qiBl22GUJGYkN4rrNi8I0KuqeZ36h0ky78nE/VD87NQZw1LQJlKmnFCxhC1Hz3/E9lgO1UyysWQBIfLbHZ3c0qDS8/praaNpStpZAzrm+wHin1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aCGcL5YH; arc=none smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-45effa36240so2848090b6e.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864675; x=1772469475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi7jWd0C81kE5nB7PeuEALk1pyyWsZNcqCAZ39HdnzE=;
        b=P8gTEH7vo6bOgPC4qCtE9jb25tREpGx9OaWTOPMu6TWZnhv7AjjJKxoFeVubcVXuaR
         KQ1d+uK99Fp1uwpi8RwimYD2INrxv8a3gvPIJIEUZQL3Kbng3A2JmIttdM+0QZgbWY3c
         erRbq/YUO+LX3oFOykE8rqKuMUKiCDvCXfF85r4SKuM35eCmxJ+J3JP9lcE6RVfh3s0k
         XuwEYije2vSaqz5MiU3TMVZu9QvRI2x1sMl+flWgq8MLmwQnXM+8u/6rxUCNXTc9fiV2
         drDRdkJbmEh05ov7ZOUyugLLFTO24u+xYuWDu3Frb8TnTGGfINO1e9LoqnUf4WjUC9iF
         5AgQ==
X-Gm-Message-State: AOJu0YwxFpRKYjR63GNCy3KX8B4RnswsAFec7hiuhJK1hZN3TVA+zf03
	+8S0mtmFO346hZcsjlSyMijQUYcicztmMZb6HbsbqjR/EySDSU99+rNe84613hb32/etllu7BS6
	TfCvtuDL7ymwOjoBxzIXNUGswCWqtTX558DRVd2g3R4q5Sb5m84Yx6PxewbRqV8jIflfvUeujBr
	AxUruuYAExgTaHmilaQFhx/iKada+Cy9D/79A4DMsqZ8H7t3RfxldJtz/ebaFcKae5AnLbNLtne
	h06isw3qFAF7Whisg==
X-Gm-Gg: AZuq6aKtZ+rj4PUdfNbFnquqlwZCt9DaZhFvcWbnhNCsllVyriot3eAU73FzqaOfAnA
	9o/JuPFSVndR+wAAHy3GQWVGYhEJadQs3bcJ9e4Va+y6NF6A6T/ExLzQRZeNmPNh49k9BN1V0ZG
	YwAdYUxSKnSUrkO6IIdKspyCjkG5hTrRmP/7fAuPUTpLGqMRExBje8AhAJZvErLXLv9tSYAg7oa
	8kpblQjvP809H0EsQhw/upAddiEhPe1RMwmWTKrtcpXzlvo0UQLLs4qrgAxBaaO5jWq2qU3lJlk
	G6EN0ByXm6gyyne0NbzNp8zc0gefX/cWMkIe3DyIUEXzV93QAieRVVzPX0k+dYGc/zJ4Nkl+g2e
	QZxLtVBA+32zoo+AVIPI3WPh6m/l+vCFHhS8qjfZpCbBfqQfTYYo4UntRbikVZ14/WpqdIlcq9n
	gKf/5bLg6QZMcuidEHiwA9A+Ujmbx38GEcsjKQWh0QbikqGHjnDQf7KlOLAWBmePDCjw==
X-Received: by 2002:a05:6808:170c:b0:463:f9ad:a4cf with SMTP id 5614622812f47-46446226ac4mr5325003b6e.23.1771864674877;
        Mon, 23 Feb 2026 08:37:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4157cd428c9sm1135273fac.2.2026.02.23.08.37.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:37:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad5fec175so206686835ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771864673; x=1772469473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi7jWd0C81kE5nB7PeuEALk1pyyWsZNcqCAZ39HdnzE=;
        b=aCGcL5YHUPBxa4M3U4+iDHT1t1DcLe3M6J7lN8zZ4Ll906NLg/fyWKwieqlI8Pxdgy
         2dynVHEsGRXYe5K3qM9jyFbRWbbhr5AdlF2LshgC3H0y1ctULuIlLZoueAyJURrTew/L
         9J4khxRkDSPydWk0vJ0sDDG6XayrTgNsXZERs=
X-Received: by 2002:a17:903:f87:b0:2a0:8be7:e3d7 with SMTP id d9443c01a7336-2ad7456f999mr66521035ad.57.1771864673473;
        Mon, 23 Feb 2026 08:37:53 -0800 (PST)
X-Received: by 2002:a17:903:f87:b0:2a0:8be7:e3d7 with SMTP id d9443c01a7336-2ad7456f999mr66520845ad.57.1771864673038;
        Mon, 23 Feb 2026 08:37:53 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3445fsm96763825ad.13.2026.02.23.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:37:52 -0800 (PST)
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
Subject: [PATCH net-next 6/7] bng_en: periodically fetch and accumulate hardware statistics
Date: Mon, 23 Feb 2026 22:06:40 +0530
Message-ID: <20260223163641.755200-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260120-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B236817A24E
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
index 6589fbdb47f..e2715419b6f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -325,10 +325,94 @@ static void bnge_timer(struct timer_list *t)
 		}
 	}
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
+
 bnge_restart_timer:
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
+		int cnt;
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
@@ -342,6 +426,12 @@ static void bnge_sp_task(struct work_struct *work)
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
index 65cbdcc9d30..107c8a69c93 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -299,6 +299,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.3


