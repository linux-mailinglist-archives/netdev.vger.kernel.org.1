Return-Path: <netdev+bounces-294733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mng0EDQcIGoVwAAAu9opvQ
	(envelope-from <netdev+bounces-294733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:21:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5F637705
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SxRq3soy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294733-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45597300B1B0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11933D6DD;
	Wed,  3 Jun 2026 12:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C05156F45
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:21:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489266; cv=pass; b=fDEsQxUA7eZRrNNGkcTOQDh6G13LV/Ks+1POoBQ+u2sKHQzCjlgtWUFtenqcGZwEP/KEnZw8M3sf6FlBMuBNEknq9DRgVvqFGUji3UKtB13nI2Bs3oEaRGoDU5Ezxw4c7U/AAL8YYjKrq9EketrX2DNsvHj23Rz81ZaoY+cxTfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489266; c=relaxed/simple;
	bh=qmRDZ7S8LjnhF1IpPciRHs+PG19HyFaf+2lFuloHJ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfLr9zggBWiOh0pKL4VYDmqBQfJL+8Y2jeeQ2lIHSV/q56yTB+WWmRuKk25m9LIq8lH3zPj8QfrMFcsSrXQCENAdNYRuh98xGbNnV6aO5yLcNq+42xohlR1qQuBnPx6BeTb+0F1aW626e3zQfICp28bZ9lWeeiX+U0TCXD50sXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxRq3soy; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd167797dso306860a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780489263; cv=none;
        d=google.com; s=arc-20240605;
        b=ZDSJBuoC5UDYsf+6aLq+75r5k1P8RKmdkhKlaHcgkYpW3SxVVvFflCEltehb2FLZtR
         B+KMJ0bbbAWUst3SOVO1Mzps7eegpdWt6dPnz1YTXzZEowJ61C7bmkZo83tuGPGN9R7k
         3b8aNyZZAMHa/2FegvvlHRxTBlqp4w66NCxmlcbKh365KYnenuuNIiXXnst3dsmtD6Ft
         t9jzeqp+GJWC+pOd5pbjMY3wanXs9i+BRUJdLTzWTZZwUE+H8Fo1I5E0UbsyGw3k2SZ+
         T7RytF0hhGzriQ9YVGYS86DeGhiyH3D1jQuTAOFlPogYFv+qApmy0AjXwuIHymc0iZmS
         Sp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmRDZ7S8LjnhF1IpPciRHs+PG19HyFaf+2lFuloHJ6I=;
        fh=HezJ+vxHrDCAsS8VIC8t+08QDqiUaCAsF2CW+aC74cA=;
        b=hb97czQp6jaasfp3WzAGCAySq9bp6hZlNFWaT3lqeTFKPP/gU8af9gtIWXftyomhDJ
         77NDIP4/EdmJagda2Ec5UvEdq3sHZImNZ689V9ITeOJs2nBhZ/GWnXeYFQ8qF89C5t8A
         3lKVFbiEcjKXa5l/Yg9W1CqQOmpgad+b+RCjDgHh7cj1+0rkN3OSwwGa1E9X6nEPwl1n
         OaJ7fMOdBDhbVdPn3yiTVy0xz0ktcYCnVh5QILXp6gtQ/484LStI1CDNVwkpPC1dit6q
         T2MUTliGhBT6zkmIQKNIxvQJRBn4er3IMhibeYXWkvuXb0zrXiwoCCxQjipvwzT4hou8
         LGUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489263; x=1781094063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmRDZ7S8LjnhF1IpPciRHs+PG19HyFaf+2lFuloHJ6I=;
        b=SxRq3soySbu6rsRPI563Vj/JdYMpzNzyLprQEkXC0uo0Y02qwEjbgIVHk98Dyt8mVX
         tw3MHM4F5n45yPumrHLq6ItLKG+2I+nc5Az1w2m64o1HWzZYZY9yu0RX7gbOc94IcmZh
         Gaa9IyMGvo3Mgofbl9EP5VBxNpx/T6OhN9F+JD+lql2WZzj+mSf7Lg37t86D03FBxkF8
         GQr0eTr8enfRLttAS2N2sk35nAiCtHaNMWrVThVIxzztwbvWdZvqjLswiWofRfk9cjrd
         mwMhffZtTmmE+FQdfnom8DofIZLU0V/W9DvgfchjSjIITNbQz15I19+SF8eCG2zvS7Fk
         77nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489263; x=1781094063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmRDZ7S8LjnhF1IpPciRHs+PG19HyFaf+2lFuloHJ6I=;
        b=pVuhZ8gAK6CF9gGXTZVD6xIn/zaMrF7baHTmwwQwfNhh2yoRP8jpN2yxg/8Kd5e+QJ
         D60XoYksD4rBvHh1SsYXFS3oGaS4Yr4gJZB59chvJMn1QL9yXyovB5aFhjqoI7xd6M2k
         pIo1CQGxIPXtwcvMkww9C4WZisgtVf+HMHNHeO+ywwoxSymNtHS+vsSBulXYs7v7t0rC
         0x3r3ruLkIroMat89G7s7tnf9Xk+2hLNFqIgGsHRNMxOR6Uao4qsYi/D22ZyWZwr2fxq
         By7xGf/k2ga/IbSclO30zleLyUOCIzilhtU9FwxdGKxNwbj2WbItWteFTHkSVM8DsRCS
         1yeg==
X-Forwarded-Encrypted: i=1; AFNElJ/iLkhFJhOpcS2r71yH870GbezZGBigDOryiQMMf6rd1gqE0+wdDfX/cseIUicL5z5MCv+C/7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzIBGAtRpwssdFLSpEBeKBiYcMG6nUJyPiRJZO2OhrWGd8dcw
	vDwdIhzEY6h0PWJ6UfBxTorLgn4woYqA3VuSb5+GRcAdnUe/Fw373w730DwmMFeUkdvLk4/x4x9
	NLuVqYVWzb18mm+vYhm1gXU75Ce9Iygk=
X-Gm-Gg: Acq92OHSA+47HdNHlKD9+AuBIC7WIfzK56ujRblRKKludWTowwlmgyEjU9DOKL7rf2Q
	2M2dRKAWE0Anqgt00a70Oph2WWiPiaUhmLqDeqPl38Ko7TucvwmpOIwacf1Tf7bwUHxn2VXz6xB
	IzA2BBru3KCDparuz05tTvmmSBmnRuuvGARKq8djVi3WygNWnD6JZw20Xx/mBA2cfaLkVUebqmk
	JS+u9/sj4sTcJpwa7tmpWK1zlhXDymShyCSxuR78/dWo6qAJnqbEyUI+7cY5urmpD4MCnk0JlyQ
	yGZbVmKsgvr+SEsrfnF9bYo6krKayfKVNsBBmopGwFA0B9jcAkFe
X-Received: by 2002:a17:906:6a16:b0:beb:c3a7:9cd with SMTP id
 a640c23a62f3a-bf0ac508c23mr167267366b.8.1780489263349; Wed, 03 Jun 2026
 05:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603065532.13260-1-akiyano@amazon.com>
In-Reply-To: <20260603065532.13260-1-akiyano@amazon.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Wed, 3 Jun 2026 15:20:52 +0300
X-Gm-Features: AVHnY4IcVD1mWUEnaiL9FQfPRjAmrfXQusROIVUElX4liuPik0zZirGpCDmxGmc
Message-ID: <CAHfVqdVpvEF6PXCqSu_Of6SkQY+Uv0b2C1K-0xrgV3Cyg-RcqA@mail.gmail.com>
Subject: Re: [PATCH net] net: ena: PHC: Add missing barriers
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>, 
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Arinzon, David" <darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, 
	"Tabachnik, Ofir" <ofirt@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:akiyano@amazon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294733-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[saeedbisharaos@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saeedbisharaos@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9E5F637705

On Wed, Jun 3, 2026 at 9:58=E2=80=AFAM Arthur Kiyanovski <akiyano@amazon.co=
m> wrote:
>
> Add dma_rmb() barriers after both req_id completion checks in
> ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> payload fields may be read before req_id is observed as updated.

sounds good, note ena_com_reg_bar_read32() missing such a barrier,
probably can be done as a separate patch.

saeed

