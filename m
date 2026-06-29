Return-Path: <netdev+bounces-302797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rzHLE46+QmrBAQoAu9opvQ
	(envelope-from <netdev+bounces-302797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21BA6DE242
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=HHikgqJb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302797-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302797-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677E3304CF75
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB4419311;
	Mon, 29 Jun 2026 18:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF71421F18
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759012; cv=none; b=ZXgAf/2x0DH0AvrM3miyvTUsacHnsgiGURixGpKCElGlqBeSmQcU5i00T9vnB+qBwTCQXCX2m92F23tIYfHXa4dNm4hiU/4DFbPKk2A0iIxUISsi3yCTG2txYM8YGtdpOhzW5kYFc6RoUUvGqW3BoIfiuGEpQ73qXslG9gziq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759012; c=relaxed/simple;
	bh=28WtIzdzVaYRsiNbLdnYJ1xAheR4ZdVVUI9pW2DMl20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2wybHAp+wwJinRTN9fKDJUtDvllHRtWSf4fvpZ9m03vFnI4xJsz99TOxQnaR35YqSKTrdtNEV7kDeECtMuTLoecM111GVN3kwVL5jjxMf77zS54v7PhwiSC2S3UaS+AM6obOpNqK3t/ykRRKOavQpjKbPZnuD5WBUqr9U3v1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HHikgqJb; arc=none smtp.client-ip=209.85.216.99
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so1584114a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759011; x=1783363811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgORjGgZWX2BQ9WeVKSnzW4blqmcmQT9/e6KN77haz0=;
        b=KPyBSnY1aeKJhVscOvCd/aR5C0oJwnmqQ7H8pCLk/MENZKTsuEUMwROj0A7wLovplC
         WfmvHQgknVAdY8zGCakSTJmTf/v8f2C/mWJPv63LmPvA23Sg4FB6Pmt1cn58sJFYVUO+
         OEW3AuOcx//5th7sZpSivXCNSa4QvLSz9f7tkw0nt3gYHHwH6HMzATxi6/eqqTME9hMc
         mSLhE6LVMwlHTPIAEGEpEDpuLZGSjSGH4U54DNz7qdwceK1yrI0W+WOwKrRG2HeRgDnB
         9ugPX4j8AtuVM5V++QoNhY3NViCj2wlIeZZuO0sitTw61u15Z8TxhzTrAlkBaJa5mto+
         sGmQ==
X-Gm-Message-State: AOJu0Yy5BcO372WAeRWHGVtTz6xgwHC9FQP86MFsdHre/483G6qBcqWX
	PVHdCYcsjdKKNWmdo+F2EYbfdBqsQgxwF4EHGX2DsKff8sSNTPjy6VSTgwHDKMJyJdlt0b652RA
	c5nBZck3SQUD/czdfh3WgNUP86BvtnfvT4Gxb/fsVo3T8m2VVXSMQ8YinaTFKNMJqTbFz5DTlBO
	aqaI6oJQkEe6G1bMIB/88QiR2gZgEL0VC6hUH/Uh2/lawdMAPUszBVaJKNiPFLF+48z1kjGp4Lp
	PdGmU44rPA=
X-Gm-Gg: AfdE7cnec/wOTye4qYehAyDu/x/2PEWYXLpfU/DNnLudtB5OPz7HRyb9kTmOyphC608
	/AxFx00/3EovFCDkjytsLKALEAHd5Mlcx5Oz4QlSt1WLtYC/lZ3USB3ktlFKqX9psk0Ku73Gmd3
	oxOzQgjKgHPNU3TyG/KYPzda9EkoTsKXLSLa/VSrSjfUsmcHNU7FnUwWt8i4yJKnS1jtev1bV+w
	NvwysHs5fnvwUQzoK6gIooSHW2W+RGKMfXD5a2+1jlZUFHNowDubQVxfEN9nN4tnszY3bAwsNjF
	VzvI8uF5xr97SGUfYFlYOi/8q9SVok7DJxMFuGPG2fEWprUAVzj3/TfBa5ji13gHyCDpWUqjJ5/
	+xGCuHuP2CKgNIDfmhFUOGzuJPUtCS1UOLu9zPdTnbSID2GOqxTy28dx8kGCxGPXd4+caTPtFAo
	CgUkI4Ly0COm8pn7qjjQ12KvaceFtyPcFF0jgOpxGf8Br6/A==
X-Received: by 2002:a17:90b:3b41:b0:37f:b80c:980d with SMTP id 98e67ed59e1d1-3805334a1cemr233656a91.4.1782759010600;
        Mon, 29 Jun 2026 11:50:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38052e29ce4sm30597a91.4.2026.06.29.11.50.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a87ef9713so47800901cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759009; x=1783363809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgORjGgZWX2BQ9WeVKSnzW4blqmcmQT9/e6KN77haz0=;
        b=HHikgqJbLaaRyy8QmPP6lguKnll/dX6mhLNtsE4WE1TxN1teJHkQMjSGMqwO/zI0lO
         WLlRUEj8MpRDrJzALpukcMLZzwDfJvUGYwiBfVGiPVQO1U207wmnvtS5QwKYxaZ1ocyj
         YoyAMTDxCgPjHcIs9fHT3zvgYr3TVOvzbt4Rk=
X-Received: by 2002:ac8:5dd0:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51c107d564dmr8291351cf.28.1782759008972;
        Mon, 29 Jun 2026 11:50:08 -0700 (PDT)
X-Received: by 2002:ac8:5dd0:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51c107d564dmr8290971cf.28.1782759008532;
        Mon, 29 Jun 2026 11:50:08 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Mon, 29 Jun 2026 11:49:10 -0700
Message-ID: <20260629184921.3496727-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-302797-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D21BA6DE242

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
index 02c234b18a06..6146d24a6397 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4154,7 +4154,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-		spin_lock_init(&txr->xdp_tx_lock);
+		spin_lock_init(&txr->tx_lock);
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ea32b8bd6600..f851ce0c4a18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1014,8 +1014,8 @@ struct bnxt_tx_ring_info {
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


