Return-Path: <netdev+bounces-293118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J48LyeSGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29D602C61
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F052B316E533
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1E330305;
	Fri, 29 May 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLQqwW4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09632BF4B
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060533; cv=none; b=M8xmNRR7CVxRUnXBWSA6oqBG5j+QW5UZL2UDdcMPn2gDhftJb0/JO4mbdKYXjPOtTcAGQipQKsf1A1EaU9b1DrjKRXglCgW2qoDM9JSZoMV5psZ26Non/QpFgpcLgeVowokkG9KPINLZasP9hN7ucnYHSgloKG5hTLol6PeJM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060533; c=relaxed/simple;
	bh=Z3APHbh5TYfhP7kaL21679bcOl/k3zaRswL2vcWbRDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHtzT9huHTGB4lhNFyTW5CSIpR2q+oXa4TIobL/nT/+zcjTboTw3X7/Va1FSsD/BygD8MdbFlLLXCIfcysFUnDiCwt3Kc84LWPSKsGKenb9vDbiYz6aZo2zxattuzVfy4aTTtf12rH+wkcBclheDSuK30byLlMt+PDmfUYK2yzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLQqwW4L; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48544493bd1so4523837b6e.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780060530; x=1780665330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNh04EbzjB6tqvoBQD7muGaJ63hCK9iGM72wl1+O/+E=;
        b=nLQqwW4Lv+OONwe1k1riJjctK8mThN1aSE2C/bjNPJf7FRKUAUGdAbYFmvBMo6xGID
         QS0URDJ3691LcotIAy835D/3R2V71vHvX2vkes7artLkx6krol/KPX5iUyN7IGCpkMM2
         LJayu+EqFrQGYVYen3IeKhGBQZL70ug6Z3O2UNWEvGU3OanMcjEl6Cj3fVGok4J9W+Mx
         c0UxITDC3Ib+R9xia0FqslzHtUP5hiYBmzXHOyT4V8WpWRcO3Q6UD7grB9TZWM26T7r4
         JFFQ1mjCgOvj42FHRKweuVxIsi86Pn6wxyJRf4xJQRmr0yP4kG77Eo9r0FsDX+gMt/ZW
         3ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060530; x=1780665330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNh04EbzjB6tqvoBQD7muGaJ63hCK9iGM72wl1+O/+E=;
        b=R/npi/pPikW8v0hWNxs/FiR3BAbQwcgiKA06EggXG8EaKXXH+HV5wZ/2cBxqtV2Mux
         nsiT39Q7By//pWQWvIyAdj8uDhuDY43lf3y7HACe1SeoOvgB7nqs/jeHt04L6z+ApyfM
         HJqNUnJfHRlupo7qYMCiHZo+75Q+z3Sy1sKXb/mSCtBBESv3xYbx5qq8S7vTrg3mmm+I
         gHhocaU16l5/4ydcsE7Gpju77YXstH/hie2eHG5cdMIbpP0Vu87F/vkuMo8GSWchd2cR
         SkgnMG9H2BO61IN5yprfIfwDB0xv3kx04m8jxVATu970dMvrDAW71gcMtP3ZXdlIjQHz
         0fjg==
X-Gm-Message-State: AOJu0YwAbgBENSRo/7Ik/LQqyycv0s+5wCkv/w6m9Wkas7iqOUjVxPQS
	Y/C3sh/Rpr7kp4Z6+3xEQqMuWREgDoDrJG38Ve/t6BcgFKUzzctMUPdX
X-Gm-Gg: Acq92OEfLTjrKsbxQtxIQiCdZgDuelcMmapXPnjDMwWzGG0mnCYRRFOjyTJZXnD/1Uf
	xC3GFpOKEjkXnkWhQu/YKenKJ5SgUrPwXkdQfU/cHjbOU6Prle2I93j2I1B7Q8vyyitYoaeBY/f
	Cr90WE3sbQIVZ+TjsyKBSJMRjS5VntH4JHIzrWXvurOdNklP46ctwLriqmA4Zo5tHixSC/wSlRP
	2mhwjTWt6MviCFU0Xb1T8G/p/hyMhTqZQt+G2mdXohOyE/pLdST94C5fNmB5szkwy8yrgrsBb5q
	+YNUYroR2fCC4MfT0nlWgNmdfrvqJb008sGcSLOuRXvEV5GW4JSzo5Jfwig+wreDcQyz+i2PPsn
	5Hj+pP22T+Oz4T4CZMTbWceq3QhDZ6bLwNngUqfOAhmIwCbWAlJzcDhczoxvjx2oEocHDUoUkzY
	NzIDgeBwzZORbOM7LGDXtY9BOt8QbF3i0=
X-Received: by 2002:a05:6808:2516:b0:467:1da9:2b0f with SMTP id 5614622812f47-485e6c8bf9emr1661830b6e.34.1780060530347;
        Fri, 29 May 2026 06:15:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485ee206b05sm574932b6e.17.2026.05.29.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:15:29 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 29 May 2026 06:15:27 -0700
Subject: [PATCH net v2 1/2] netdevsim: psp: update rx stats on the peer
 netdevsim
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-fix-psp-stats-v2-1-3a194eacf18e@gmail.com>
References: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
In-Reply-To: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F29D602C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nsim_do_psp() handles both tx and rx psp processing in the sending
device's nsim_start_xmit() path. The existing code has a logical bug,
where we erroneously increment rx_bytes and rx_packets on the sending
devices stats, instead of the peer device.

Additionally, compute psp_len after psp_dev_encapsulate() and before
psp_dev_rcv(), which modifies the header region of the skb. The
existing calculation was actually correct, because psp_dev_rcv()
leaves skb_inner_transport_header pointing at the tcp header, but this
is fragile and confusing as there is no actual inner transport header
after psp_dev_rcv has removed udp encapsulation.

Fixes: 178f0763c5f3 ("netdevsim: implement psp device stats")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/psp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6936ecb8173e..afe58b21041a 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -22,6 +22,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	struct psp_dev *peer_psd;
 	struct psp_assoc *pas;
 	struct net *net;
+	int psp_len;
 	void **ptr;
 
 	rcu_read_lock();
@@ -48,6 +49,12 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		goto out_unlock;
 	}
 
+	psp_len = skb->len - skb_inner_transport_offset(skb);
+	u64_stats_update_begin(&ns->psp.syncp);
+	u64_stats_inc(&ns->psp.tx_packets);
+	u64_stats_add(&ns->psp.tx_bytes, psp_len);
+	u64_stats_update_end(&ns->psp.syncp);
+
 	/* Now pretend we just received this frame */
 	peer_psd = rcu_dereference(peer_ns->psp.dev);
 	if (peer_psd && peer_psd->config.versions & (1 << pas->version)) {
@@ -72,14 +79,10 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
 
-		u64_stats_update_begin(&ns->psp.syncp);
-		u64_stats_inc(&ns->psp.tx_packets);
-		u64_stats_inc(&ns->psp.rx_packets);
-		u64_stats_add(&ns->psp.tx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_add(&ns->psp.rx_bytes,
-			      skb->len - skb_inner_transport_offset(skb));
-		u64_stats_update_end(&ns->psp.syncp);
+		u64_stats_update_begin(&peer_ns->psp.syncp);
+		u64_stats_inc(&peer_ns->psp.rx_packets);
+		u64_stats_add(&peer_ns->psp.rx_bytes, psp_len);
+		u64_stats_update_end(&peer_ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;

-- 
2.52.0


