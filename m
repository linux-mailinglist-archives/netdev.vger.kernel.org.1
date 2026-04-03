Return-Path: <netdev+bounces-274926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M1iFsZuz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E853C391C9B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9EBE3057C19
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426A37F011;
	Fri,  3 Apr 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bMhKxiKY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F1379986
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201926; cv=none; b=JNB5NUrhFfSPoesxOP8i7sTiaoX/7Nn7lACCHrNNiPXMony7nUrea2DpUvsTGoDy842CzZAEd6D566sOc/tMJc6bizvReKIcPPHIk7QodRJJ3muw0ZCRjObhIUoEmTRaUV3UPmnLSmr6999cGBgUbiVt+VLdWZ0vKp9gQ4ybpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201926; c=relaxed/simple;
	bh=xN6tiyKspxsgVMlC8vJzNsPDISw/N/AbJdMOGbgS6f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0x6Qcpi2plOdj79hKkblPwmQ/ZWJnQnUAHy/feV7Z1t149BJMSA7Vj+/XMtojvMMVDRPypdnArbcMofkM6T/ssDzhmL4x2iyV7wzZQKCQ5BgEPTom7cCzmcKzK+F49qONatfeeUe1kYdilJGWkXTKv/eaCaNaNbqo+MgBjh5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bMhKxiKY; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso932790241.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201923; x=1775806723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HFToVJAFcLFa0HENZoEwa3N44/rquYMYOZOURTmueM=;
        b=j7qGw/NeZ6b8KB/ydkbsPZfYy/jzD6I8sVgJSC+XrxYB8UQ8dxJrhSUYittcEbHqS+
         xhcML/7CUsHv3fWEoYBchOTfPsem9YBWcUXKnijS6K8G1SbnPlsjKrmLa3ygWdSn3zJN
         khBXD5XGrMdwQ50wwbZO07EbUhYpj2P6I8HiYPRHqzmFuccTi2nJwO0xD+7w54oo2kiu
         CaivkpF8QbJiitfsux22mVdouAdDG8qPurCF6WEM5vwd1c012eux+NaL8KI8LF0TskSu
         1YlBU2txhJifnvxNXUXr7ttZXwGatxk79el8op2Xl0LyrmiSwwJNR/ePBFaD7ft3VvUG
         f/eg==
X-Gm-Message-State: AOJu0Yw2SkADOei76EOntVbvvb+m2xa2Z5lnJ+kcldpKFQC1oBhdHasO
	vvu/zBzDm1GWcGQS/ZZLw1GKngRDnYAxv7JCzsvjKnvtiwaqLrh9NaESxWI9HFn6wH31NxBV9Km
	6dWMoy4gQNo5m4X8HovVFQuIx6k/BspOAKe7SEzHmwG6WrrFgXRGMQsc8YpOAtWvG3JSUDJRUMz
	WgVOwz7csPSvu4Qp4/DK0olI+jFWE4LOrgREf8y+AtAKzXYpiDLA5cB56unnEy7wUWUr+g7k0Tt
	3WYTGnbcJfYvX7Szw==
X-Gm-Gg: AeBDievRZiBUKBIs5hrhV/gRH2rkGGEVdsC+SGN3eyG/5Ar8tMSIYoFZQa1LXH4MNhi
	ZUqrjNUqT17SDnQ6t5GfoCQMUtcrEUe7q3KaJeWLudZN09aNFRvYH/H0P5aOGgCZtbOjwhXfW7B
	rTdQFdEthbNUL/CLW5+2OU84VUEd67f2/C1BfZehbQ5O8PqcMlUq8OvEXGiDfZ8gngY0tVhG7gf
	zrP+iPrIQSSVFL47GFk2FuQt8LPjF68ImtAaHZbTmP9sX5jsmmRhuAK40YIpzw5C4/Tuytrg3Y7
	ZjZ6dUG4Q/maBwcoRs/BBTDEtIYzXjlNtY8vwikvZR9QrISJJk5aCtT89y/6Eh142QCQHfveA3+
	0hUCggJCcUJ7QB32NYaQ1jM6S15WAsCq4JF7h0wwrnUbuBX6rSeswVqTyRlcVcyscg8ys5fOovo
	hlZLA/NC02hPab96wb7ExYvmYB5R21uXiu5jmLNkJwQg+OTJSLcwwxYMGl1AYl2X8=
X-Received: by 2002:a05:6102:5093:b0:602:6c8b:4b8 with SMTP id ada2fe7eead31-605a4d5ba34mr815723137.5.1775201923438;
        Fri, 03 Apr 2026 00:38:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6058302b798sm414683137.23.2026.04.03.00.38.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso1870350a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201922; x=1775806722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HFToVJAFcLFa0HENZoEwa3N44/rquYMYOZOURTmueM=;
        b=bMhKxiKYFMZCFi6py+WtSpyXiDJkA+1ioBJk6np4v53nSpHjeB/SH2ebHblzzvX2wq
         sNMd8fBIRSkpar3ukEPe7fYeXA4kmj3urSL3upCsJzXt96Qd1aFmFNrguobCGuGDlMYA
         76JyRocuMKtplGxwSiCgfyaCgoKUl8h1RSIhI=
X-Received: by 2002:a17:90b:3c4a:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35de69774ccmr1985053a91.30.1775201921860;
        Fri, 03 Apr 2026 00:38:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4a:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35de69774ccmr1985033a91.30.1775201921410;
        Fri, 03 Apr 2026 00:38:41 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:40 -0700 (PDT)
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
Subject: [PATCH net-next v11 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Fri,  3 Apr 2026 13:07:21 +0530
Message-ID: <20260403073724.194360-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-274926-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E853C391C9B
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 97 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 290bf1cd96c9..61bac71c7f74 100644
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
@@ -294,9 +297,97 @@ static void bnge_timer(struct timer_list *t)
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
+	int i;
+
+	u64_stats_update_begin(syncp);
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			WRITE_ONCE(sw_stats[i], hw);
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+	u64_stats_update_end(syncp);
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
@@ -309,6 +400,12 @@ static void bnge_sp_task(struct work_struct *work)
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


