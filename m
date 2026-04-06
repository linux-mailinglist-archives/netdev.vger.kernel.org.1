Return-Path: <netdev+bounces-275690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FubGZ7202k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:08:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78D3A602A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468083056154
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA173947B3;
	Mon,  6 Apr 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="am9jveDI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4138C400
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498737; cv=none; b=jNRgr3MyIN1ZnZTGgwPJ9WVxWzGhiWcCwgpBECjrZb25OxRq7l2hb752F3/smIDINKcShxLBi4V5k56xbDrRFd0v3cBOgxWXWxIRxe6LqrbqQZC9WYbRz5YOiA01OokU/75ehzqDTPJokeXJHhch0O3buH+VzM1ZoApd56iPzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498737; c=relaxed/simple;
	bh=i9Dlhy6KmGeyPCFecRkazd93QFltkDDdeAA6Ep5s4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms97TbuOVPh0LyK0lAbKl9Fs30NrWYvlcFq7+RjvMD5p2soOvmh2D1jB/nE+82Iq4ld3WyIEBplc5LeRQhl+h/7+mt4xc710YrI4+piN5DovAd+O0Gflg8dEZFnb/6UwQWiE+MjgTBdfNtDv5r2Z/Rq/xEIhW68Ow0DrqTT71DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=am9jveDI; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7dbcd92eda5so1565625a34.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498734; x=1776103534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5LdGYUb6kFydxANMiMpTYECSq+5KGtGmECDY4Es5lg=;
        b=EZaQLp5rGCs/lq6MqAv4vGIz9OU1Xs3ys664Qo+AfHsxNkRtoSI/NODemXPHOsYvjV
         TxcfTxu2cMNhhIFLo4RywlLTVDuk/jLnZwl6UYb/Q5PisNGDDA5Ko3B1quzPo0bB6/7j
         nYPgM+hvVSQx24aVLd3rLLkuGx9LcTmV9hcMRHl2sqvCrG7MgkjvjQWWulFNP8f5bCoc
         IQSKQ2I1GhahqDJiMBRw67GOO+O59UzaauY/DotM0AHszkvWy+/YeHsfhAQnlhdqo9bd
         /H/juEf2A+KSiDD9Lq+svWtVFtXU3KIJtXSw5vVieUdihrbH/nCTpzbhTIFos7wk+XBy
         QO5g==
X-Gm-Message-State: AOJu0YxS60zaLxICsKK0hkGoDMOYQ6ZVy02JAWYvzjO+3MQHKSS9YU/d
	c98tr5MM8qy2JSE0X/bUZ7q8gIxUMhh8Mks6cGhTXXHIQL0aaebErMqjwfc+l+M2+8FbM5Hy938
	WTGZedeYMTdneWbSiX14txCX6UPgAdL7OdPuuqeLM8xQCoZEUGnBlVB11Qt+fEVFEQSENKGL/s6
	xBzkHAT5rmU2/ZhzvTlXiXLI2P81lu9oyEo1yZjCiwi3ReUpcxBS//HOKf4LXLeOM7jwh+gzN8G
	vBzb7xL1PIlV21ONw==
X-Gm-Gg: AeBDiesH8wbuiBOOrxdktmhanvLLogpZuKFp+ukuldf3LEkQB6+raQTDKVbPMmwCY8N
	xeT00OUfLxrBlFr5efK01qi6Mjo8azZOIIWD5gYnpvxDBSKMfv+HlpcKmzM1Ku/DxblarNEWF9I
	4ka3cTKDRhc9Mri45YIu8OCr/7kms899O4L3lxvXP6hrke6Co8LUGe0OzgChF3/U75sUQXxzkB8
	XC2oG4tPtsEGKF7V1UlOKJbpxGjphdv89oot4wPiq4Qsl6vynLEdCpScQcZDln95vFvEjWd4s1u
	du4UjKF42PDPk193suMQ+WaI8ANEDJQWkgVOOi3o2d7EKsPPBf0I7ZqYBh2/FeQvmaF/nRhyqvm
	HgPCjgCSW7RfYlAw0QBMbWmkgEtphmm8KesA3TcQ6OipgQqbkHoEAcITRJGC0giOHdnOrTZgb2B
	XtyoahgiGMHb0iITJddLAQ1tzKzKa3BkvySpcxp6gx9ciATZyGwtjEpmVSS+7jNeo=
X-Received: by 2002:a05:6820:2d08:b0:67d:e0fe:8434 with SMTP id 006d021491bc7-6821e8625c6mr7479353eaf.27.1775498734425;
        Mon, 06 Apr 2026 11:05:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6839836e2a3sm381453eaf.25.2026.04.06.11.05.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24305cb3cso51845975ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498732; x=1776103532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5LdGYUb6kFydxANMiMpTYECSq+5KGtGmECDY4Es5lg=;
        b=am9jveDIq+mjwm6maITA2Xt7Opn7UDz/FT9brKhASAn8hSgsveLcZxqVuUDfCSC48S
         AiONUYPKQ8OyKS7CGI4plM5OhC5f60AwAmXWxd2x1+r1crvBj0hePZVHRchmvmGYpKRv
         x5qOaDWacbfZr/g1wPvIjMMHgUfD7NeCR1oqA=
X-Received: by 2002:a17:902:ccc9:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2b2816cfd51mr132266845ad.16.1775498732138;
        Mon, 06 Apr 2026 11:05:32 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2b2816cfd51mr132266375ad.16.1775498731622;
        Mon, 06 Apr 2026 11:05:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:30 -0700 (PDT)
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
Subject: [PATCH net-next v12 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Mon,  6 Apr 2026 23:34:17 +0530
Message-ID: <20260406180420.279470-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275690-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B78D3A602A
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 98 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 290bf1cd96c9..6f41dff3fbcb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -69,6 +69,9 @@ static int bnge_alloc_stats_mem(struct bnge_net *bn,
 		if (!stats->hw_masks)
 			goto stats_mem_err;
 	}
+
+	u64_stats_init(&stats->syncp);
+
 	return 0;
 
 stats_mem_err:
@@ -294,9 +297,98 @@ static void bnge_timer(struct timer_list *t)
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
+				    int count, struct u64_stats_sync *syncp)
+{
+	unsigned long flags;
+	int i;
+
+	flags = u64_stats_update_begin_irqsave(syncp);
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			WRITE_ONCE(sw_stats[i], hw);
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+	u64_stats_update_end_irqrestore(syncp, flags);
+}
+
+static void bnge_accumulate_stats(struct bnge_stats_mem *stats)
+{
+	if (!stats->hw_stats)
+		return;
+
+	__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+				stats->hw_masks, stats->len / 8, &stats->syncp);
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
+					ring0_stats->len / 8, &stats->syncp);
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
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt,
+					&stats->syncp);
+
+		hw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		sw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		masks += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		cnt = sizeof(struct tx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt,
+					&stats->syncp);
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
@@ -309,6 +401,12 @@ static void bnge_sp_task(struct work_struct *work)
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
index 15ededb801f6..a73f51b01bc2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -278,6 +278,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.3


