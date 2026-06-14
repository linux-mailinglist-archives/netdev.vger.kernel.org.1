Return-Path: <netdev+bounces-299162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0gBG25XLmrItgQAu9opvQ
	(envelope-from <netdev+bounces-299162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69886808CE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=axAZrKKc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299162-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68E5B3012CF5
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC553921E0;
	Sun, 14 Jun 2026 07:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC03939A3
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421925; cv=none; b=A2KRMIuWxLsM7w1tkDR+UyCypl4q+btECdOMKI+cwBoM6JA74BtKUf8gZ6hhCbNlL3TObbnRyR+Jv7cS0AfqIthcx7MgZc3zlJvrswE7DaaSJzDwmjRGWJIW/2QLkVNyBwSxXumjq4kcVGYNAsvZdPFSQuDB2zUotOdHN6EZJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421925; c=relaxed/simple;
	bh=NWuKJ1mMr9eyxF6TZExlSKSUCse0OIzAmSn+bsa+HE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkvXn+FaiYv6mqy0QgaD+XFL769Z/WU2Rtezrw0ORoppsrRdDGsxzEIUmjzpNl1Y3KQ9K6/7/Af5iGZXNzv20gPWMgb/M/V75X8CLmYwTV1eGrDcuXzXmJ/W72VYC/ZkvGaHU+hme+mUiQVFUNlwicTsZNZHl2+jyQleQmOw9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=axAZrKKc; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2bf18c30bb2so17659795ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421923; x=1782026723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK5XD/58ZRVH5Yf4AxD7K+kTRyqyXrb/QOAr3GZmqgg=;
        b=BqGvd/LNu8b0XnfcX5GQKv7LHdVLmKsFMLTKj73QVp7cRemk9sUd3Jhe8aYaO7Zzs7
         xIATFDkQhISELXLWlrbvmKEfu8vYVQovW57VMCp7kmr0abVqoQqYjg9Uo/J2f8Bly5MN
         W24GJ7X+sjUXuMzwe8X0k5KUFz8gaf/ct40TGFxc9qJCfpl3ZQyMO/YDnufo7YO60nc0
         Bvdewi3VYvnPn6ZLuXV+fD/isAUmqblCFF0C1tHWGidEe8XhZWzheZqgR5bYVlN3K5o1
         zqZWjLm1t0wUi+L+aeuMBoSSCPOzPWzEq6d9A9J57KOk8Qt8l2CxCm3BNVyFrnY20HRu
         noJA==
X-Gm-Message-State: AOJu0YxYYjWl2IlDOdvi0Kxe2AxEFMpnF38TMmVWCdmVNmQ5f8RcFrOu
	je9GLuwBSLu7i0uDwBV2AhwsqvFV/5dFunWzSZXFYvy/0t9xLNRccXK3FaJGC2vMzP0frAyvnP7
	SU8OZF6kOspzPLzCW3g8zmpT4XrQ9tSHwTO/lLdfZtez5ixTWGDB7bTvnpUgVXxL0Z+JZ37EvBS
	y2CxIZGe8BmYhrYQjrs6AEC93cZ9M5sKWJOH6m+xD53ojHRD4I+hE0EcdaaWvA9ZB1KoAhB0cdM
	aSeVLMPUCI=
X-Gm-Gg: Acq92OFySouj/kYUiYobsl6W6rMSDUhFgMiBWTEhRvEkbMEsgtVQvg/eEkseALA2TyW
	W2QW+PcNze7D9qO26eaUSyvCCJvBULNwirxSuIQBPfAN7roxFAOROkN9IFH7/nhoVa4AmYYl9Ur
	7ElDggWOL2O5qGuxjP14hiBjEbsVafxNc5hDk0cTPe4wSbCgeiYj0zS836wgmlfyIIumaWvIu7r
	elSz4bPRqL4QEiVfYbvF4FSm0HOw4PrVIp2jhqrbEaYwb2n235G+PFqQju2ICVo03nZ6VbQJCX6
	/XcYL8t/4/JDZ5kQ0fWrRXryeAo/diSLOY2yev86bqRlQlOKeaFnRmp9ut8vr7CbK3QVyvFBV05
	fwshJjehL1yze1oXLDkuna8iUUm3yqrlImECeRPRpgBcMX2JfEZIXL+ym1G5JC5H/v7F969QgvY
	1HWYMjGFgPLz3JtEHGUz6wjxq8fAduBaolGylbxTvtBf8beldp8y46nva12y0=
X-Received: by 2002:a17:903:3550:b0:2c2:bd05:dacc with SMTP id d9443c01a7336-2c664205199mr68376705ad.16.1781421922835;
        Sun, 14 Jun 2026 00:25:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c42fea329csm5870145ad.7.2026.06.14.00.25.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3080bb0267dso5317125eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421921; x=1782026721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK5XD/58ZRVH5Yf4AxD7K+kTRyqyXrb/QOAr3GZmqgg=;
        b=axAZrKKcy/avxy77Dp8wMcmnSzK8q/yOlbV0smiGwo4I7FnARbcsFGZgxt5HYRijk1
         9kn8JyNX9YDP+sNvCn0uQ18ermK5YhgK+DAqPxLswk0oWWljACGtYqNSuwb8wjkKkw8x
         WcaU+QOfGmfVaHBDuGmiQWaQ36Nn9lVDFVzWg=
X-Received: by 2002:a05:7300:6da4:b0:304:ed85:5f43 with SMTP id 5a478bee46e88-3093d15d8bfmr2943372eec.24.1781421920875;
        Sun, 14 Jun 2026 00:25:20 -0700 (PDT)
X-Received: by 2002:a05:7300:6da4:b0:304:ed85:5f43 with SMTP id 5a478bee46e88-3093d15d8bfmr2943358eec.24.1781421920278;
        Sun, 14 Jun 2026 00:25:20 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v3 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Sun, 14 Jun 2026 00:23:56 -0700
Message-ID: <20260614072407.2761092-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D69886808CE

xdp_tx_lock in struct bnxt_tx_ring_info is used to serialize
XDP_REDIRECT on the same TX ring.  MPCs will also need this lock
for a similar purpose to serialize sending multiple messages on
the same MPC, so rename it to tx_lock.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3e84a92d963d..5252ca1760ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4148,7 +4148,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-		spin_lock_init(&txr->xdp_tx_lock);
+		spin_lock_init(&txr->tx_lock);
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b1ef88f015d5..ce86012a9ba7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1013,8 +1013,8 @@ struct bnxt_tx_ring_info {
 	u32			dev_state;
 
 	struct bnxt_ring_struct	tx_ring_struct;
-	/* Synchronize simultaneous xdp_xmit on same ring */
-	spinlock_t		xdp_tx_lock;
+	/* Synchronize simultaneous xdp_xmit on same ring or for MPC ring */
+	spinlock_t		tx_lock;
 };
 
 #define BNXT_LEGACY_COAL_CMPL_PARAMS					\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..2a94a77847fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -351,7 +351,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 		return -EINVAL;
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_lock(&txr->xdp_tx_lock);
+		spin_lock(&txr->tx_lock);
 
 	for (i = 0; i < num_frames; i++) {
 		struct xdp_frame *xdp = frames[i];
@@ -376,7 +376,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	}
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_unlock(&txr->xdp_tx_lock);
+		spin_unlock(&txr->tx_lock);
 
 	return nxmit;
 }
-- 
2.51.0


