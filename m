Return-Path: <netdev+bounces-261537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8En6KliSoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:35:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08D1ADBD5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCB4E30904BE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CE42847C;
	Thu, 26 Feb 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FcipaMKd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC13A4F34
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130173; cv=none; b=PxHyeKYMxcwYSlexzW5a4MTQPAq6f1XNzdhHu9NXaQ+G0HhrmA91pqOC+eSDehYqw7FTUlhl63Pu3NMbK8IlQd3lh2R1tEcFcN9BkTKbBoydauDMk1Ekx0qgyxf/xTVvQ1gMkipk8ktKCD2n2NamaS6dagr2kcK4C5hxjBfrjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130173; c=relaxed/simple;
	bh=j9pXrqilMEivb3kenCdVrVeZoo3VQ0pz99CklD/zhPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu6S//SO8W6nM7/ue7Jt+Uw+XaBCt1DisWGg9beW0VkPPf3uyJ/bH87jPu3viXB/oFXh7KJndnErznCWYdsux8O2xTvwVgAW4lMZT0EnpBmQ18wO86Zh4miktgiU4tbsh7m8mlEGAD3c89U2XX/TrT8UITMLQG++XPbXIgvzo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FcipaMKd; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-662f2fa7e67so507414eaf.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130171; x=1772734971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlTV+qVzUdFJA5OXCVkJ9bsWka+6SR1Yh0G21rFd6Gw=;
        b=xCKWGqxuikNF1LSWLJAq0MtbIlfqFOGdt4IAjbQtn2AOKmdt4Uz7BCQ5HZOQ30G/+j
         9mjNBpCLX+45osUuR96YEoNhim77cCbLOnkoKl1TD7VmS3NF63tH2sL8vt8UW+KoGauA
         MPqs1bUHEesfu+ggiDW6CP93CPQFA1cZnfGmxQT4SQP1W+w0pU1jIIXGXbHBSqABOahn
         mqMmvUNHj5I7afZBnyo8wuC39A/RfIZzQraMY3mS6bvnHAMHLhhkej4w1quhg2Vo3JRo
         B5p4m0yDX/L0GxMER4jaiX3bdLN4LHB2XhEL7gxx7Bcp2C9F1wZc6DHihRXDTwueG8vc
         Cd3w==
X-Gm-Message-State: AOJu0YzLnSnxGOrdKp/7yWGVG2fOk2jZFvC/Ui7vKsVRc8FdjGpcmrf6
	M716i7PpOwE1mwpmUV2waPLWyv3D8G0HKBHmpzhtWHTfY3Tpzqw2HHPzEaZeCO2oRKgRIiLRahi
	xfiFqokHJxqvAme6Yo5tqRM/tr01+aFm42rMUvxz2yHkcKi8mhpXCIs1mgqmq512GHEb/oAsyce
	PxFRlUKWiiYeJ3KqPJQODRlcbwB032rLoa/g/mapnUmdonx6LwwXqGfTRhvwZpPNyBCkQr/pJ3Z
	YLutXEjBxgHxBUNtg==
X-Gm-Gg: ATEYQzyQe149gboXehP0IFUGr4atAIjritlSg+ZP/3QFZtz/QRnZ03eXCRhakHZtgR8
	dywkvtKA1m6Eh1IDkpncsV0Z5xrlrvTCVej7gUBgcxUtzeYn/o9ErkPFlv5w7tQZzoUIizITmwe
	fkhzg1uPCGfRZgP+mO7O/nzpjjzOSUQBoelUZ0OsAKdsGLQHfQWl/7pcwcnAtPpGEn23dU2VtOW
	rJd1OgKGXyLcr+wwQhGXz1XTO85FQmGutpi2eMS8zteuo6Zh+OZKEQzXpCIDLE96HQXvVJLmGOZ
	t6R+U2XODYujmp8+pIKf9JQskFWq4Gyn/ugJ2Jk8JtNY5HOqfppViMr+jIPMbJDZPPjxaxoV3n/
	VdsnD6l17FyDehwYBnoPruyoC66fatiejtYS1tF7ZW75d6WbUmSQUxobxr/ZXfmxr8LDlOfHU/2
	WGEXUq+hY5EUJQpy9HsMA8vG18nxJEKc2is9W9ps0eRogtcfcUIGFlTxFsdbTV5EQ=
X-Received: by 2002:a05:6820:4de9:b0:673:e6c4:749f with SMTP id 006d021491bc7-679fafc06cemr99646eaf.76.1772130170597;
        Thu, 26 Feb 2026 10:22:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160d2d4c0bsm370734fac.17.2026.02.26.10.22.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aae146bab0so16611025ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130169; x=1772734969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlTV+qVzUdFJA5OXCVkJ9bsWka+6SR1Yh0G21rFd6Gw=;
        b=FcipaMKdXmXoI07tLLmXVzHHAzO8RDxA179sSwTpzyALprBB1g1LHIhDqMBjUqpVjq
         95l4+mvHFG+pjFystmp7MXpRkNjUtPJWlzL9kV/nSXzTs1EF2UyAK1zkPWyKSYBUvT3A
         /bkBoOGVQWoCnnC8aemTrP/Mae9Q+Mo+qy8xM=
X-Received: by 2002:a17:903:2445:b0:2aa:dad4:d34f with SMTP id d9443c01a7336-2ad74515d10mr186150205ad.27.1772130169081;
        Thu, 26 Feb 2026 10:22:49 -0800 (PST)
X-Received: by 2002:a17:903:2445:b0:2aa:dad4:d34f with SMTP id d9443c01a7336-2ad74515d10mr186150105ad.27.1772130168646;
        Thu, 26 Feb 2026 10:22:48 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:48 -0800 (PST)
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
Subject: [PATCH net-next v2 7/8] bng_en: periodically fetch and accumulate hardware statistics
Date: Thu, 26 Feb 2026 23:51:32 +0530
Message-ID: <20260226182133.1566714-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261537-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B08D1ADBD5
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
index c7b5de5a9c2..2b772956df8 100644
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
index 823060737da..f28edf94257 100644
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


