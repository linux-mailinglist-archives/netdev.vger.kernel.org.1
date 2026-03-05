Return-Path: <netdev+bounces-264533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEb7HvHiqWl1HAEAu9opvQ
	(envelope-from <netdev+bounces-264533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CC217FE8
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4071304FA68
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0C41C0A2;
	Thu,  5 Mar 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h5tGnkK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7241B372
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740898; cv=none; b=pEektsm/3RGtGQ3trz+alDM2GKrpgrG2iU35BrxoONxD8FxC7UW0xqsE4bwC5H1uktNs2bTqYULQT/Ki79LLQDMMuZWktkNrmlbYALpKEvVizR7NQ+1vu2q8M75RPWELd9knX0xYB87gSFj5mTCb86PaPj/lB+IaTEp0rqoC1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740898; c=relaxed/simple;
	bh=qKDKHBItqjlnp8iifqqtVQdCi5Fm/RBPg5qa3TEt4zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb1QH7HESTf1toGGy6luJ+xtgfB28ysZ5pAIx4wWFYKqnGRMMU9FZa9eStuO1rAVFBEZ6dD1btReD0/oMGCq2V02yIiXVilIhT6eGHY5KcgovBIY1M7jc/sPCWkcSH/I2ryzRJKitEroAEh0wvz13dmUZ+Rt2GkODEqlUQ+GQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h5tGnkK0; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-45f015a3259so3424993b6e.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740896; x=1773345696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NQ9BrBInuBHEDXnVhh5tO7NgvGRCwjBMLMeJv/Jy6A=;
        b=qlyVejx9A+5HAfQJy9iXYuBri/WA6dHeSlr0h6QQFBnrEvr57GGBnn5yXVnTkIffSm
         Ps4I55as1EyjE0jVXysrGineoGjPr9jCX5NTrVm5b15mPlWyaB6UW6GmLAfONJmyl4li
         p0thIMCcgBwKoS8jlddIVBfBH5fTmn0hQqGVskBACqSfW/El9zBZlYufcBGP2KdigRAy
         tVxl8JSVralMg1LFUv4jBtQPBj3bEWfUcKqneS3/aeKjZeYdRhled7UBnVabbHDjTyZe
         uQ0gHXavCDOPW2jedbiKNHq9qd54Ds/fso7RxmMjLYqaz3CHM6X4DcmZOEkS11ARnNYL
         e9TQ==
X-Gm-Message-State: AOJu0YyAm291bTHlvKacmrpS3fNUTkqk10NMB7kCqCXZarpe9cc9YTRU
	wP/aQBcBAq/F/60ExgtMy5wpe56aR7P31U00naHos3FOYfP1e6+lkb8cYwQBwHCSsgzytNpMXB5
	TJBp9SYApO1z0sRmunYfgnv4iVM/5peRIHZ7h/DNV526zkFlmSE1vZVOEURJIxl/CvD4C657n/M
	Iv7h1Hka6N7tbsidSMiSFW9eXO723vr43nVj2W174ZBoU9Hizns9MQ71YkNpdKTq6qNAAxKfXXP
	0Q6lKbzsmYZAhLt4A==
X-Gm-Gg: ATEYQzxbzR756Dml87K9w6XsnMAdzKwqBPMsDIa72aHk886XUJuPzNShKGoDsD8EiCy
	DfpoxTUKUcYpGczL1xRfLTtxrSjMcLZeXildJUOxrjJHEK8wVDQyOAS8I//Xve06EdiWj96T0OP
	v13CcbG9pMKVFlf1qe7ztmdxPnBp8vyVqf+e+bK3O58oiun+AFVSg3EsoeeDityZO+MHMj27yTw
	Y4yVhM+O+zBhVJF2SescOT3Caew94rcKyg46FY0g/tpNsYyKEhLZZYf8j5twbfjsIrIB7ru6sit
	dypSQq07KJW3WyuvYM0apDPPCqcLb2+6R3Pt6FSviZlVqATacX8EIKO0hZoO8QQ7aoWz+Dk1TLb
	s3JgAE+qPI2JI0n3ofzKKS0o9J/sW/LCInNQ3l60uKyDO1u3QnFTNf/dEbdsGpVTPCl4PNsioyY
	ALfeVzv8KaOx9Xfxcq9Rw37Tv5ZdDsRYjGxe2owkTu5749XzkI3sgG8O0nQ7Hs+Uw=
X-Received: by 2002:a05:6808:1913:b0:463:8fba:5e00 with SMTP id 5614622812f47-4651ac77260mr3888878b6e.30.1772740895862;
        Thu, 05 Mar 2026 12:01:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899fb4d696dsm13540456d6.24.2026.03.05.12.01.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae6961bff0so109831065ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740894; x=1773345694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NQ9BrBInuBHEDXnVhh5tO7NgvGRCwjBMLMeJv/Jy6A=;
        b=h5tGnkK0vXmPi6QlVUvCoFlYUGLHs9rjbbpPoo6XSsdOJqVSxuZLKwgMyuhjEQiS6f
         tqkHeGlUSySmc89dqRs8Ie6P6vLcSCSnTsZ1FfgTWHwqqLkEEFJZV28k4O7FrNh8mzpV
         oyKQRwrfGWboVsVbJLM6uENmxXrGB9eAfOFTA=
X-Received: by 2002:a17:903:2b0b:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2ae6aae9955mr72397055ad.28.1772740894502;
        Thu, 05 Mar 2026 12:01:34 -0800 (PST)
X-Received: by 2002:a17:903:2b0b:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2ae6aae9955mr72396595ad.28.1772740893968;
        Thu, 05 Mar 2026 12:01:33 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:33 -0800 (PST)
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
Subject: [PATCH net-next v4 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Fri,  6 Mar 2026 01:30:14 +0530
Message-ID: <20260305200018.111728-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: F36CC217FE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264533-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
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


