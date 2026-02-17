Return-Path: <netdev+bounces-259109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKYCD5SilGloGAIAu9opvQ
	(envelope-from <netdev+bounces-259109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:17:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6282214E8E9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9E683004D30
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7232BF26;
	Tue, 17 Feb 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXalppK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39179330329
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348609; cv=none; b=JIOCl0wDuGYWiWO4GP7D/fB3oN+GRWgPI9orj7hi9rVbZAdYMKC39OyMZPiZxxLTQ0uioKAa9T3eHPHVf7kY9aA8uh8Ho7t9Ezk3FACr1V2P8Ay1PxOiUJiqL33TBZsLFjj40+Ys5RleI7TXE5UGioUJg1yV2yNQYHhWiw8SBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348609; c=relaxed/simple;
	bh=Ujh1eB5WerqFei5SAzPMrUf8WGtz59N6p4B+XjqW9TI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gkRXdJhKc9Qcy4hx7TQDi2GEPpQ2/vbAMLyKG6l7KsUnYvclbElkxSxw1P1Poko2h8twgUEtS4V+iNlq9uKz5IP55jzU5u4o1zXWRHCvk4PDZSFBHq09hN1sSEKPLBgktAe5ewNCxcUcvRA3t94t9R/VcK/B8N9tVzrNrKUqbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXalppK+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7bced39cfso46075115ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771348607; x=1771953407; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/I3hMNeh4eo4FoEiIy82yE2fPyi/MuBpxcAosPDaWE=;
        b=VXalppK+g9SPqvnp24KA5+3q8rrQ7I3oaZDuyvr0TeOHvXOgxdiK8Sw9J4RvGMTmFo
         FRhZs5QFiZcIzunFZnSojhkbtlympVbGw/MTJhFTuRYTuroGYBkDFp2c3OuW68TEKc0j
         zvFcEr23NMZIPs+5KG09qmvuvDFogriDpF30EezRenGiQ8NnFGPlHL+Jnys1KA3mB4r+
         w2iatPIMhtEib9FxQFT80mp+28m5Or/hAu9eP2jSoNxM0oRDa5PEVXoiPEjIzi51w0Ca
         OGCZS6aZeacyk8NYrF+KXdP+g2LvmxQ8V0MCiuHp43UBrqjAtC8W925izhd3NNdVQ+Pd
         +qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771348607; x=1771953407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/I3hMNeh4eo4FoEiIy82yE2fPyi/MuBpxcAosPDaWE=;
        b=BJpEE9iDcs9lfY0Od20BApaZDhrrWvB5iaKaNpPZjjHMrk714K4XTqtTNBUdyogroP
         FeumJ/uHo74m3h2OXuOJKGh6b4VpdloAxKa4Adpa41ehQF18fVU7HWGjxVk6Da2EiBa3
         P/OPjJT2n8L+bsFSqLbfigdk9ze49uIWKdk4l+2JxYc9otJiSE74TOv6njh335HYDOd9
         fOrGcQBT/r4r/sp6OmfpIYx4oz5hPZ0Y0XeePABagGuIMn5oQY1FJZXqvepFa7wTnL8t
         O9v+nGkhXYF14nYtHpGKCsVSSSahYNZOXIeyzXY0DhXzVuJPLqWQGo51bkQljpzFUGOU
         KVIQ==
X-Gm-Message-State: AOJu0Yzt4BvJ3UgYs3KqCTm5tf2nauxkdoUYcobliSrrPF+7UqzPes+w
	8C8E/k65gmy8yGFiEWqMegdoVVDJyiC7cw1JiLTndZFdknFy3qOd6O+t
X-Gm-Gg: AZuq6aKrBjY464OcL5e0XIZVtaMTPRtsHkGK25WP/sizUiE4e1E0GvTr8Mp2svAqaGw
	Zwhu8RxODFPTPKos85tQaMEqLRyeF9URr3JoNkBBjrJR3qxuYfjRsFl/kVNluhk5jFXNmdTgY9o
	fYlTC6FUP3Hik9449DoYB2hBnrrNfolUyoy7IUr/I2J9Fdp/eN79N4bJ/sg9++BytL4InzO/GRx
	eBhfiCDGERTwhImtS6/SILjjpLs2Ckrm4tsVPnuSDFt4b+b65bgWZ3R2w0waCvc99TrFhfrwWWW
	mP0RkNQznD2l4yUtWHeMkrH7Qkt6Wnklr76zJ/+81yNqiSLEB1usVkZ/uhIdUWssl+axMBkmvk1
	YZJ8UtRHEH2r8W4dLGLD3jSEZbZ12LQBdceeS9Blt7ye00ebINSZYP2UjuriC3sM28ptt3ZsJmU
	ZSzMLF4cWKOcMk8J2N2vcwBRtCiFs0dJ1c2m79ZtyEew==
X-Received: by 2002:a17:903:1ce:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2ab505c976amr154231685ad.46.1771348607375;
        Tue, 17 Feb 2026 09:16:47 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa34bsm99947655ad.19.2026.02.17.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:16:46 -0800 (PST)
Date: Wed, 18 Feb 2026 02:16:43 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] espintcp: Fix race condition in espintcp_close()
Message-ID: <aZSie7rEdh9Nu0eM@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6282214E8E9
X-Rspamd-Action: no action

This issue was discovered during a code audit.

After cancel_work_sync() is called from espintcp_close(), 
espintcp_tx_work() can still be scheduled from paths such as 
the Delayed ACK handler or ksoftirqd.
As a result, the espintcp_tx_work() worker may dereference a 
freed espintcp ctx or sk.

The following is a simple race scenario:

           cpu0                             cpu1

  espintcp_close()
    cancel_work_sync(&ctx->work);
                                     espintcp_write_space()
                                       schedule_work(&ctx->work);

To prevent this race condition, cancel_work_sync() is 
replaced with disable_work_sync().

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Shorten the patch subject
- Target the net tree
- Add the bug discovery background and the race scenario to the commit message
- v1: https://lore.kernel.org/all/aZLmvv51f5Iu9G7b@v4bel/
---
 net/xfrm/espintcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index bf744ac9d5a7..8709df716e98 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -536,7 +536,7 @@ static void espintcp_close(struct sock *sk, long timeout)
 	sk->sk_prot = &tcp_prot;
 	barrier();
 
-	cancel_work_sync(&ctx->work);
+	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
 
 	skb_queue_purge(&ctx->out_queue);
-- 
2.43.0


