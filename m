Return-Path: <netdev+bounces-256737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJIPFatng2kbmgMAu9opvQ
	(envelope-from <netdev+bounces-256737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:37:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4A2E8F8C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B80E30A91B5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DE425CEE;
	Wed,  4 Feb 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKF515F8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC396425CE5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218414; cv=none; b=XEpAKoGU82YPkzTdJNp3kOHp24xlL9wlpbTHS1PbGTbNgH8O5o8F9NvkGIzW8KaVGKD3Lxcg2qL9tC5/o10/GXd6ifPKhYLxm2d2k1iAjlSj5DZGcpAagSF7bdCkzedUrV5SvTMPWtFMecYUZL2aoaU0hMqtu3+e/4wG09e4SPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218414; c=relaxed/simple;
	bh=AbRr/30dy18DzHXHj6FkozJad0FQIPWhxZ2GqG3Z1M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2L8EIz1I6ByRI0PSosnkJvhA66kdxTlKpTU35+clJ+BxgIitMoukaRJgxMpkIA9H9zGsKuEsXN9KN6TAYmRCsl1rAItPfhJdhskQPdlDLN4Bcwj9A1OgErI0PZZDm45YA5nYnIkwS7r1oyHkCZiU9Zvx4Bq1ygGJRjy1Bo1rRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKF515F8; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649c070ef3bso3798915d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218413; x=1770823213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRqiqvUMMSZGLeeYDMB2av2ykrxfAYNo5nlbKFvA9yM=;
        b=cKF515F8Q/CCjYl4xQzW691ufkQetXcPnNErT+6dWJDiP8ooM0gnKjWfB1f6elzfO0
         U8LxLc5OnobAUQu8R+XKcphHOjBBgzFiDxoZR7aBXGTPP95EGVtatxgQCYyUS8rDqw2d
         x7EZRlkaWRsPNHYjsEinoc1/qu3N71dn0t/Y9rEylt654jcKrPP9T/6GWFTvDT6AVDb2
         giJc4tn/QdoJQr7X2Tlm0C5m3U19XBaDrk+EoS1JIiO8J25YoZSh+KjZuX0q6ssZ7QaH
         g2UFtjqCdOUQ0JQrzCw/NxARzEcjiTY9JFbEFCC+mo4PkbS79vXm73kbxJktC9ZUUeNL
         TTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218413; x=1770823213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRqiqvUMMSZGLeeYDMB2av2ykrxfAYNo5nlbKFvA9yM=;
        b=vQxidJINjmziumHeztzYMVKE8lxPJ+16QPr231WoHAQ/E093HVxMlLf9n8DoQTk/FI
         06uFKDOtw/xGwVSt/xM0JY/D24ibiHko0ZxMZLgWN6gfIRQ7nNbWETZ+pMKYWFkrJINU
         YBuIPQJrNPI87OhM+jryFA/D0XA1jCSwLgT0kUneesBPlwGQPxH5+XfOi5f0Gwd4oBH3
         lRhCh9eu9yn60PanJgWk72wcJ1jP7O9pmFhiqztmT4qhR5zGEwg/pLeYjSN5QC7auVKH
         fSgHMnZRX1onsEpEe3zAYLa8nhoWm2oCWGNxP3iV6+yZv4tGeGzP+fDVX/Kt/f7iM3An
         A56w==
X-Gm-Message-State: AOJu0Yy9c3bXy1Y7iU64BGjTRIqNEOv0qA8Ri5iFQYCnr29Eh+M024pf
	blh2+E0qKuXuJbXOjB7grO5stSPSwBrWRTHCI6ux1Y5H7JAURFtr/SSjVfcY4Q==
X-Gm-Gg: AZuq6aIQFjiHudjJ/YFXlCUtM7bOu9urIBde8DykKLRHCgVTWtRIepVvfAZGTJab/4Q
	CYLCl0fdgAu4pJUeav1ON2YrUnQC0anjDIkxyYCjvThXQc61eoph5Vh8A2TEc8MPteS7BrvWz9m
	HrRi//fGUeH3TGPiHte2f+GVLozZF6IfXzbKnGIfItm7IZEVdR+JrNyhAstuAlcBgqvp2LnxSvu
	KELvU0IXfBFkoN1UneqWfleNtPYdyc0zgHLvy0upJ+F3VIygUAVcI61KscMv+QB7HTnHgVeGpSQ
	x0zS5M7cd1ovDLW+Y+VoGEzB1eyKKrRRpa40xIttuYcieU8xcM0VtK++mH0URutkofuBJvnPv2Z
	kN1voOJiZjZlSTI99cZc9i94ngMV8NjCFzHbJ5o/E1Jyu+QjBEflQxYHqQifEhZeMTp2liLY1Fg
	B23qRr4U8u
X-Received: by 2002:a05:690e:2481:b0:649:d17e:9ac4 with SMTP id 956f58d0204a3-649db32d07dmr2575966d50.18.1770218412746;
        Wed, 04 Feb 2026 07:20:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5cd5c1sm2584218d50.18.2026.02.04.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:12 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:08 -0800
Subject: [PATCH net-next 4/9] psp: refactor psp_dev_tx_key_del()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-4-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256737-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED4A2E8F8C
X-Rspamd-Action: no action

This is a pure refactor. Lift the list deletion and key validation
code into callers. Subsequent patches will have different requirements
for what actions need to accompany psp dev key deletion.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_main.c |  7 +++++--
 net/psp/psp_sock.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f626..982c96f74ae3 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -132,8 +132,11 @@ void psp_dev_unregister(struct psp_dev *psd)
 
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
-	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
-		psp_dev_tx_key_del(psd, pas);
+	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list) {
+		list_del(&pas->assocs_list);
+		if (pas->tx.spi && !pas->tx_moved)
+			psp_dev_tx_key_del(psd, pas);
+	}
 
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index f429b8b2d8f2..1a97609564e7 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -85,9 +85,7 @@ static int psp_dev_tx_key_add(struct psp_dev *psd, struct psp_assoc *pas,
 
 void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
-	if (pas->tx.spi && !pas->tx_moved)
-		psd->ops->tx_key_del(psd, pas);
-	list_del(&pas->assocs_list);
+	psd->ops->tx_key_del(psd, pas);
 }
 
 static void psp_assoc_free(struct work_struct *work)
@@ -96,8 +94,11 @@ static void psp_assoc_free(struct work_struct *work)
 	struct psp_dev *psd = pas->psd;
 
 	mutex_lock(&psd->lock);
-	if (psd->ops)
-		psp_dev_tx_key_del(psd, pas);
+	if (psd->ops) {
+		list_del(&pas->assocs_list);
+		if (pas->tx.spi && !pas->tx_moved)
+			psp_dev_tx_key_del(psd, pas);
+	}
 	mutex_unlock(&psd->lock);
 	psp_assoc_put(pas->prev);
 	psp_dev_put(psd);

-- 
2.47.3


