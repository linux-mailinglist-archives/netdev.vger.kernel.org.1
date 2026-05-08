Return-Path: <netdev+bounces-285872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFW5EhP5/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:54:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EC4F8259
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62673301F3C2
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0B3F7897;
	Fri,  8 May 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoptMYnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37603F54AC
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252041; cv=none; b=gqXakeU4VLvzgqoVJao/b4E38BQMm+rm1Pt3GyCiZoZjrTKpB6KdXFw3p0Kg71r/PnOzv+Pudhza+CWb/c80GJrjHd93GzaHp1uocRPw+fTdpY0tsxjzsPChE7ikkCVdfSetY16ZWa+YQdhqUgxh1tJdzGNIABANXlbczAEpcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252041; c=relaxed/simple;
	bh=Imh165vQ/goc4NSzO7qYhOZsclYavVhpTt2KZ2NZzGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUqiMkBy3spjTU9gDgf6qIYCwgjt3aCKw05id/KsHyJ7PYQOTTxgotDYGw8SFJWPEwOh63HtE4MGSFnYSw2XPTd8mba4QUobEe2PX3UeZFRnscV/DrfqtWIXLM+99G76sGCQcdTX3nvCmovyVxQKS8+zv7Y5tPjtkYfASvqYaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoptMYnT; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-691de293326so1247014eaf.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252038; x=1778856838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3yf/0EioU1Vkg8reIOYdru1mIh+jCd1PePb15OVlfI=;
        b=BoptMYnT3XYVkaWsOQkveikubxxOkLGFxXnwb1hS8/9I65AJRK41p0CtgtKfNESV4p
         dVYSRpA9+D0VBkGMClqYAKOdTiDSzEyz46ELu0h6BfjhK+GCi5xo1RADXLuCPsOLT0nl
         WDKEPhGSNckA5+qNB4gPwr/CGgZ6b3HufZpLsrGDfjz0jU/xzHBZreaQGArqSACe88oM
         DewzTbDpnIxMYuh9TMwFRUxsxX7AxWyXAgcvRTCxA3SatEYoq6o1qj1eebWsSSliKgAH
         1ocsTbBi9Iff7ppNQEkuehCjM2XwOiapTpmb0a6HuqprytckWJDOCRZ7TLqjKPILzDFO
         42sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252038; x=1778856838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3yf/0EioU1Vkg8reIOYdru1mIh+jCd1PePb15OVlfI=;
        b=a5z/I4JaumvGoHNGHDpN0NiD8Feg9MHC8UeY83xRFLIa1IhIQiLoB79WO7bPNjqauX
         DTP+qUd6PMwv/kIzjmyPG66Fcm97A2ItYLU54Y7CVdVmDkpKP2t1a2CHCE8VuHklFUYH
         uKWUIzlRmQ4iBFvgJnlhsf22aQ/wx7aNI8rZgoy2aQz14stP2lBwSAGtFYYf/+1lilgQ
         Va2d/7VtDuCThnnQ8vqoer95O6MzxWtiqczPnOU77RW+i+W/IxNckWcRXbo7Xxj6PoCd
         pILyZMIQO/6YSvd+1Ekeh5VgcHOEq8w11e8VVOO1l7CrDJI123ZfInoAzw58ha0wVAMc
         qe3w==
X-Gm-Message-State: AOJu0Yy1TpbxWdSR6QMvFboR+FAmcbuAPP49QjeYex4z03N82AdiAxt0
	rHcT9Y9XIdJjWhUwbWdEP+rfgOHpREJePWwCWBSnrWn2/tNDcX7yTRt2mtPGTg==
X-Gm-Gg: AeBDievwGeKPt5NuYX2q5zseC1deBf58WCBxiq7GGuMim+RWFTTE9A5rvVH1D5YV37T
	63/UQpzF80DwyXWbk1TybMPM/yuWD3UiH/nfnDLU11lwG7wZb4rh+jjHZSD8V4H7y7NjiXxget4
	E37mM00x9ntqMUBIWKJMnUdXP16CQHb+o/wV75lLaCx/q/0qupVJNpTZD8XPJUdPRFS6WXNBqF0
	1BEwcEr5GewXEXiX6yfzm+HtYRcUreKhFeMrQJ0Gl9rYhsp1lavPOxJ92ie/hPspIgn2yyB+PCX
	k11Iy/0UD0Ng0Y8Fgh6u1r2g2VqSAds+mVut2c6mBZbBgAYrW305Z3f1gKwBTKhNwmN0qc9OqXq
	fWiKNew1Ia4M9sUmC65i61gkE6DpoUpZU31Y+v3piJH/1qlFSejWrrh62tyauqmv9rh87xkRBLZ
	zMk62VE8wti5HQVrK0Tr2xc3EqW6F215kAJrV9Du6hrQY2LxQp8Y1Z
X-Received: by 2002:a05:6820:3106:b0:696:924d:2fec with SMTP id 006d021491bc7-69998d5e1b6mr6025442eaf.56.1778252038577;
        Fri, 08 May 2026 07:53:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c76cc4sm1213298eaf.6.2026.05.08.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:53:58 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:44 -0700
Subject: [PATCH net-next 1/6] netdevsim: psp: reset spi on key rotation and
 check for exhaustion on alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-1-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: DE8EC4F8259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The PSP spec states that the lower 31b of the SPI need to be
non-zero. Though not in the spec, I think it is reasonable to reset
the lower 31b of the spi space after a key rotation, and to also
decline to generate session keys when the lower 31b saturate.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/psp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6936ecb8173e..5073bda60883 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -132,14 +132,14 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
 		  struct netlink_ext_ack *extack)
 {
 	struct netdevsim *ns = psd->drv_priv;
-	unsigned int new;
 	int i;
 
-	new = ++ns->psp.spi & PSP_SPI_KEY_ID;
-	if (psd->generation & 1)
-		new |= PSP_SPI_KEY_PHASE;
+	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
+		NL_SET_ERR_MSG(extack, "SPI space exhausted");
+		return -ENOSPC;
+	}
 
-	assoc->spi = cpu_to_be32(new);
+	assoc->spi = cpu_to_be32(++ns->psp.spi);
 	assoc->key[0] = psd->generation;
 	for (i = 1; i < PSP_MAX_KEY; i++)
 		assoc->key[i] = ns->psp.spi + i;
@@ -162,6 +162,10 @@ static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
 
 static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
 {
+	struct netdevsim *ns = psd->drv_priv;
+
+	ns->psp.spi = (ns->psp.spi & PSP_SPI_KEY_PHASE) ^ PSP_SPI_KEY_PHASE;
+
 	return 0;
 }
 

-- 
2.52.0


