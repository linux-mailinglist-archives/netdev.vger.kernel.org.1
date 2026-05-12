Return-Path: <netdev+bounces-287312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIgWIkGaA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9C52A3AB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAFD30A9E5D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916037A4B8;
	Tue, 12 May 2026 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AxS6FX19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8637F726
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620906; cv=none; b=DAaMeMNSvEX66zrLA6vr41RwUDiVh5AuKRStNIhuR+Xp7pkUlE69khvtiqcx5A59zaWctyII7Cr8jwKFJK2kS8incCmXmG1HPUn4FAl0PuRjIkB0FkkS5ek+YGubSTtPSU5RMCpestJrdNt3bXpbk8LWqhQXr9ijQaORr9o6sXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620906; c=relaxed/simple;
	bh=5NE7NYOrDTjMH1DyP1ytab4WN9wuztCQQbxT1lM1yHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMdOOmHg5tzFihoAhynZjfOs8tqykS8lvMbX1/vTP4Nxl3DnWExuXL737L6A72BgudAlI66ZNVTjnonmgTS8ddKvSUmzIY5WjI72P7V3Njb8UIPU6XYKWQIvWON1ra6OMN9uSJtvA25RWwpPzN1ZoJy7crkPbkgLJmeM1KUwZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AxS6FX19; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50e97863425so59526721cf.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620904; x=1779225704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3cksWFFa2kzbbtiOmVQNxWlrUyE4+eOxq8fX0ecKms=;
        b=qYok+6IKY8Xpfr8u3R9Qjtmo6Ll+AF06JmlyZFx9Y7u0vAePJKXnZZGaCJ4M/m/+9X
         m37oyaywP6YpKXJLu1VDpfSeMbVDbm+2d2nk/J1dt6F6CrKGjB4bWK/FriiZufEe4GHr
         hf99BJEM9DHvq06OXDoeAH+MeUqWy0TLIzA35fHrG2+n9+GERVL5zbvLoQJFPem4+AcR
         hsK55SqwSx3FAlvX41dRnpA1tBX3/dyiR+TOtIVKGuLAkC9UApoctQ3jvQEJu5os79VF
         e0zwUMfMANLHC2quVjVo3qH/nztU407iLfSZ3vB4jYvZRp46XJvu+ZgL03rFk5K8G5KX
         ECZA==
X-Gm-Message-State: AOJu0YzZo9ysIY7LpZb7zZMSt7Tn5AKjKMAfe+nV+idLAlLgCSBLUOfb
	/jTiHpUgpH+cUhu6Xp7rgfoJmSPczJGsKKb55keJTcVN5fWC2OPMiivU5GndQZemJj2+RRtv8L4
	+wwZHKAofdq2t1iAEYhD2QHBxAYIrb7DxnigvSotii/+mLyEycyUPYb63fpGzAvbDhNtmfzagfo
	lLjHx8oC3mCG2YPqsWIcQY2VDaHBjKGrrV9PYiZgMl2qZO+wsmdxtB08TD1EPl0jsGB8UzG5drJ
	kZnoaar+Tk=
X-Gm-Gg: Acq92OGNxGUoFvj3uRFwWnT1jL1zCVQw8ctw+LqGaWJF7GQMdakYEfPkuQIyF8JAp4K
	0TLeBmlZHw3rNebkX+rNwhUix7uONfDZy6x1fPl2jCDejNdRaVryfcXuWKr7qYDd1edYTXZQPAs
	QtNuSfcsfSIme84QdzOk20PcShRC2PXlpgvXN/KUp7rPWB1jHlTtCTmuarjWnUlcG7aiSVRtmro
	FdJIgteQULc6W26gTnHXN34GPkxDlC+Pf8e57eQNOc7xya0avUsbLKG02T0AYIevpctqb6M0JU8
	R0KeRfaUNhFLxtfr3+r5C38H/AgQFMTB32OXrOrRrrlfX1FP3hYdsMez0RobEnH7lMbT7kBmeK6
	oFvNXKKKEpC4flXhb4wZsk2T41tryOLQJt6ATuY8p+g75Ntyz2Z7AQ8Yb9hGfLHrgMygNewDBWu
	gybxkpQXZOX7yexJyMOx9FFTpJB1TQtffZS5fs1KsQSQcPz9aeSiV6Ba0j
X-Received: by 2002:a05:622a:a0b:b0:50d:597e:4b50 with SMTP id d75a77b69052e-5162fe263f3mr2623741cf.13.1778620904065;
        Tue, 12 May 2026 14:21:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5148e818759sm9113661cf.24.2026.05.12.14.21.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270dcd11c1so12048652c88.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620901; x=1779225701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3cksWFFa2kzbbtiOmVQNxWlrUyE4+eOxq8fX0ecKms=;
        b=AxS6FX19xwYZgIcezfqqJx7oCVZRh2HXHJjXpluOQaGXT36zIFk1i2E2nwLQSAdLif
         4SvRQhpqG7cjSVVOpwVusgnOW79gn9BwbZstxfj313/pTBeiRIoXVB0BBts0JCb25nVZ
         ZLH4sESeEXwyHUwU7LlxWNWGk29MW4dih9mvk=
X-Received: by 2002:a05:7022:670e:b0:130:c9cc:3384 with SMTP id a92af1059eb24-1349ac64a08mr79020c88.30.1778620901423;
        Tue, 12 May 2026 14:21:41 -0700 (PDT)
X-Received: by 2002:a05:7022:670e:b0:130:c9cc:3384 with SMTP id a92af1059eb24-1349ac64a08mr78993c88.30.1778620900599;
        Tue, 12 May 2026 14:21:40 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Tue, 12 May 2026 14:20:54 -0700
Message-ID: <20260512212105.3488258-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260512212105.3488258-1-michael.chan@broadcom.com>
References: <20260512212105.3488258-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E4A9C52A3AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287312-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 8d5206c1ba8f..b545907294af 100644
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


