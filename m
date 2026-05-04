Return-Path: <netdev+bounces-284102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMJFJpcz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063144C512E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCDF30488E1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3543FFAAE;
	Mon,  4 May 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KbvtOaXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364403FFAA2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939163; cv=none; b=JK6Eds53qiBayePOTkIP6u2iNeccNBJ/zAOfyQkJ6E9ybWuwCHHXbEgyR6LsIz+V6e067k++KUf0zVnLjjSIJeV42WFxKB7dKrhYrovTZ9lM84Fk2FjRLPjhP4IByRJaY8L+oOOvMzSSo2LqbO8LUk/uHtKWsQ76SmbzEw32iLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939163; c=relaxed/simple;
	bh=hGnxwM6jvpHu5Hdqbwwxgqt0jhdOZn7gw38WbwGQgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaxmCMtnv4DghjblmXbFLcL4eQtTy7NvRezTAJr70Wojc3JNJiuBjepLjUFLCKSi6Tm5lpPcW0jDakx2b2ZBBfawb5Fxt7xh+sTVTJ3IevOxDpPWGJTZ0QwlxFwxwKHiJMOLuMielRd853Wd6T3SaDEYjS/huCMI4BI4k2L/XkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KbvtOaXS; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2addb31945aso26067315ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939161; x=1778543961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9X5z7jX6rwwMQrX/NPILGs9pamuturrzjo9zQ2VG5c=;
        b=iSmWyZWE4NCy/trGVm4GGKFlchstuxPOpLsyNfCM9qISMOx0QKj28te2o7UTqfMM1u
         z2wJSwOI8pVu1tLxHqCmqzLsdG8oZvWBQttNSPr1WtqrgBAjpyrIK0xWTYLyGnJ9JHTH
         KEq5qyh3m7vo2G5lHR7JyZgnnb/dmh1zrLJ4Tup7UTj3/5acziminjIG1EzteEySnDHj
         nmKHo4tXZavyUIQGQicU5gTn/ID+L+Q7GLGzWkN/KQ4fnEx8/j5VKsF38vNlDRcvZojO
         HaiiAtPu3Or7MHL/mGvy9LRNlPTVFkb9o0p2BiPH1F/bWD49NT/3a60uR1DwH9+qPqAy
         hbYw==
X-Gm-Message-State: AOJu0YwRhramenqKenfd1m7uTFVg7ibqcEHw92/RljROdE6VNjPeXHKR
	Imk1RJN/+iyqVIW0B/Qya2i5PT/m31NrxhURaOMQi4pqY2lEkrbhlnTxjwM6NwxW4zkPczVtRc4
	XFW2SFE4sZSiym/d/yMuGo/omi6bqMkplcfZEhdk7s0LlK0g4qkMxqWUV7FY/6lDByYgwtZgRg4
	VBjqyQt6xfh6AJQg3us2zzTH/CjtC1jec05pwji0s3OCu0PZL4dnc6OysSx5rDNOxjbYzBZUyEA
	BeCugPajEo=
X-Gm-Gg: AeBDietub6iqdcUwegqJruFz+WpiiNejioOokSzlQcWQD8K4bR0GuKf3/VuQu3r5MuP
	CRoLJR+mX33QIxVIzXvVKNA6exXX2UpiZsCb+4mJ9tchZ5fwMhijgGsSo1TtYOwR3y+IkcwFJg1
	HoKyMVlfHlDll674WKVw4HXa0xRKFMtjY2f0g4ZqlIKr/5FA7YpQ0qjNg9qnj3AwO2ncPiqjEHD
	FKWmyUSHvBSg1/tSqRLxdJOyaftvbVYE/cO+RsBwlOhSNHfKlJetDzNWVMkF7M7z9NclINWiawY
	6IPC8BUkI5K/SxcXirXSjJykmAVLTjykDGK83Ny8iHtcF027cCx6T/N5ozuHtH8VCTW+8lQoKjn
	M6pkJPbTrM/71z9hRn4DREOy2koi6VrWVlbx8kWxRRPNE1iO5nOCvs4lDq72FEuRXvFsSmhx7g4
	Db7w3Y2KbswKhDF6Rz+w9ovO8/zz7CsdFqMWYgIqJ2M6fhW2W/Bj4TvTITYe2o2qlHJjk=
X-Received: by 2002:a17:902:ce11:b0:2ba:1202:4fc8 with SMTP id d9443c01a7336-2ba1202525fmr86221965ad.17.1777939161416;
        Mon, 04 May 2026 16:59:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9cab81a33sm7533315ad.36.2026.05.04.16.59.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca29dcd69so130168816d6.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939160; x=1778543960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9X5z7jX6rwwMQrX/NPILGs9pamuturrzjo9zQ2VG5c=;
        b=KbvtOaXSJcb9cgiWygXOib31NE0Ml85iVtbHlgHMZyUiFD+RLMWUxoi73QHEMRPplg
         R4FPmrMxQrC4HeCilwVNjzu/yycBvnEHNuNPG8U8l8zB6iQZhKq2hss1WY9MWZlkBlIt
         WqLEqxo8g2ietBoDI9mfPVUTZYY/zZ5V44Z4o=
X-Received: by 2002:a05:6214:4c48:b0:8ac:b4d5:50db with SMTP id 6a1803df08f44-8b66825795fmr171474166d6.28.1777939159770;
        Mon, 04 May 2026 16:59:19 -0700 (PDT)
X-Received: by 2002:a05:6214:4c48:b0:8ac:b4d5:50db with SMTP id 6a1803df08f44-8b66825795fmr171473966d6.28.1777939159300;
        Mon, 04 May 2026 16:59:19 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:18 -0700 (PDT)
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
Subject: [PATCH net-next 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Mon,  4 May 2026 16:58:25 -0700
Message-ID: <20260504235836.3019499-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 063144C512E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284102-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

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
index a2457ffc54e7..bcc0c94c8e48 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4145,7 +4145,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-		spin_lock_init(&txr->xdp_tx_lock);
+		spin_lock_init(&txr->tx_lock);
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index beea928d8c49..6c8ed3cb7dfd 100644
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


