Return-Path: <netdev+bounces-297422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id afLKLiXbKGqmKwMAu9opvQ
	(envelope-from <netdev+bounces-297422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16267665A18
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:33:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dmJnXbDs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297422-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1AE6304F2F0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7F280A20;
	Wed, 10 Jun 2026 03:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDF1C8604
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:33:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781062434; cv=pass; b=U1CxDcdfRDBStEZrBhVDXG4yxKQ7nXqD8ibIq4ZkJrCuyNeSfG2SDOkn/6flOFGk0dwBSH1UEf84qL5KqrGiiV1JVE8hc0zVfbLtBQO9PNcrEpNqAlQBVfH2usHkMCeGEx9L2PPsH1FxLdB6p/gxBub7pom8NTgA+KR97LLUals=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781062434; c=relaxed/simple;
	bh=dAViIC5cmpdHo3iS2vFu00yi7m7M7pxNxF3iPrG4Vn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZZL/qlGURYCWjLGCrMrDhI6fvOzi/PsvDi1EWiOF/vQTrAbu/hBxf/VgLX1XDQRbfqaIBXUUhIn9jJtbZosDAsPVDzt3zCHg8m0u4u9OIFBxh+gW79DoiHf1EisAAHu80KIumIqOFx8hHE3LRP5G4AdRPcuPhZqoiAJOOHeuZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmJnXbDs; arc=pass smtp.client-ip=209.85.161.68
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-69e59978deeso2493953eaf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 20:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781062432; cv=none;
        d=google.com; s=arc-20240605;
        b=Lro2qQXUUcudNpjGs1dJ3FO9qI/+Nonzy552UinkGPxLVCa1pXe88EbCngI2EW9e+E
         ZVl1SVpsFyPiRjqgpu2YaTUjNhkK0cc4LjAsJ4HLLndEDAV/0slD1KUmv7U6tCwNmynL
         F7JuaPpBsSHq2yR86aOGvCECEKv/Lvdgq1aPtV36/Byd/1/QGnRhQq1G8vp/p5E96GrP
         Dv5eLPYQW51N9rT6RSK2shI5BdhyyRMjbsNm3AEbo1lJfAKmIvQ64SdwPEV3U6SL66pX
         MjzrH6nSVDfWCvL1JrBQwngkvrTdtSz6Ux3qCh2rX6pqtWb+c5KCCBKdKjkUsfwVerMd
         /MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mrk8D6nLCOAlGLENVGlllT957t5rxx3NQBZGq5cO8ko=;
        fh=7ABf0X+M2UYJKgZqXd37qwLPq2ZrR5BsN3AcEL0bWjw=;
        b=ZJ0ozhrn71EGA6Tp55b1211vxQWmxWjWJHYb1v8lVcwGH78tijys4SkG8DejyIll0b
         advi2y9ANpY6hbj9v6HRJn8e6DA60z5looeND8N91aZ4iOGRAEi3JWKsTmJf0JeHOh7V
         hD3K/4kKwKSoUpGyWb4b7oxvPAx4qHe6WS3L782E3jfTRC+/FcjW0Dk0PPtNJipjAH5r
         VfMMNwXPEQtGWqJyHxASHBXlt402OloQKoufzWo6i5Y7Chz08vnUEDj25H2VqD9g9j5J
         WXF0auKO0ZAKv/u8/A3V3uB6sJKGYz2I2X1IlZhWESY+WDLLTMaUw/XwRWF6aE0cecW2
         92EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781062432; x=1781667232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mrk8D6nLCOAlGLENVGlllT957t5rxx3NQBZGq5cO8ko=;
        b=dmJnXbDsV2/bBffrff5g4hzxpXm5tiw2sc87PUbPEVfabmC7CI13elI59wivM1PT8d
         ejXIdvRDUmva3Dr8oMkx9pJQiSi8dWzhfyBDUjAr4rXoqzHom0TfnUb+TjcaFJD+PrPK
         M67jMZBpJ0ciNsubh6LtPAdjoIs07vjbFQrs72NwGm3s7z3KgHljNzEyH0BnqqaYSJrB
         Opu654CEfSUlZz8Bc8v6sHya/cBXE02hJ2L5FIoPvahRytZxVU45rQ21lbOLsEaG4Gzt
         J//U4lpHg5KgQhF6d1TEOjebRObeJQ6dHpgn7gyuGgCudqezR6FUAmKf3kJ5rcSPvStZ
         dX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781062432; x=1781667232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mrk8D6nLCOAlGLENVGlllT957t5rxx3NQBZGq5cO8ko=;
        b=OM4B9WDsf0kJyeGuBLulBPs+e/H8lSRDyQGhiqNIXy1yQisovCbebw4HCgYtDK35xl
         OrQEWCiP3PpsNtNijMIlTs2MBhpq7BNatir9Nn78WuCguJC1twhTX9JGpW0IlQGYVoQP
         cBPuoq5ePrAT443VJlrJOKoh2U+iIfuBFyRRB7asxPbfayVHG3NlGpD7VwFO+xCB5/8X
         ZYjSllmFQ/3gLLVnM3YSxi+PvdC6pFCmz7ZV/IOCZB3qRoXh0n04+HUZJfafLgF61OuA
         IczPZDJXM85P0S4/TpzCVJhp/ES4IQVuCXci4C0FeRITSQq0udVoiIDBJK6JGgQtGAhZ
         8nDA==
X-Forwarded-Encrypted: i=1; AFNElJ+pu/DTZivlV74XiKZlW63jrG+1mUq1X5RMEZjhlYwlLylDt/yzh3lSA08K+oAofauzeihSpnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftxE3BMzrCmZqftlYPZR9wP30Hhg4QDKgJw52A7pqdoYhPjso
	C238Y8lQrBzqXbW+bIc67cM/cF0YFV8EX9GHccvK9iFiybxn121e/f5hW+xMexGiGEiwUEldzgN
	KZ5LaUpIk7w8yPSa0Nclkqe5iFx5tjMQu/xS3VCk=
X-Gm-Gg: Acq92OG5g7NdaKi3+tKtEsYT6kZjAegU6tjBY4aC4GA0/KfLdaQmIfriyRnRjBzMfMo
	4IaAgJt2xyBQGI3Q8CT0SCxALp/ZnixVbMNT1md0QFG9WCbP5fZeDOnFPU52ynDTCJR0/IjQTln
	pIWgpdVpEoAL3BOF4A2yqXvLA3Qw1PsUBXdo9j9IYe/RKovI713syDMak5tI6jeqwvbIOBh539M
	Rvh6UMlocaqPwcK5JZCIwLfYQ99uGeo8IYeDRYNNcIvBBRH/mSI1maONH6Z0w7+K/LZOvaaedVY
	5maB4yHUI0uXon6m8HSAx5BoVhjlMW30W8MF1e2pC9wgNUyS5qS6Hl901tDZ/lA=
X-Received: by 2002:a05:6820:1a0b:b0:69e:8698:3cb9 with SMTP id
 006d021491bc7-69e8698672bmr8328074eaf.6.1781062432209; Tue, 09 Jun 2026
 20:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607154423.67146-1-dennylin0707@gmail.com> <20260609183909.2fa53143@kernel.org>
In-Reply-To: <20260609183909.2fa53143@kernel.org>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 9 Jun 2026 20:33:41 -0700
X-Gm-Features: AVVi8CeIpEjKgnILCdFvp7khfam0HSgD5dbpnRpVXW-yVZ5NMKy7yYlh2zq_9AE
Message-ID: <CAGEkeHees96S+8gFL6gC1fMMWSuzBkapechXmeh5Bnh5y7kuRw@mail.gmail.com>
Subject: Re: [PATCH] net: qualcomm: emac: replace strcpy() with strscpy()
To: Jakub Kicinski <kuba@kernel.org>
Cc: timur@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297422-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:timur@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[dennylin0707@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennylin0707@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16267665A18

>   Netdev discourages patches which perform simple clean-ups, which are not in
>   the context of other work. For example:
>
>   * Addressing ``checkpatch.pl``, and other trivial coding style warnings
>   * Addressing :ref:`Local variable ordering<rcs>` issues
>   * Conversions to device-managed APIs (``devm_`` helpers)
>
>   This is because it is felt that the churn that such changes produce comes
>   at a greater cost than the value of such clean-ups.
>
>   Conversely, spelling and grammar fixes are not discouraged.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

Thanks for the review.

Understood, I'll keep the netdev cleanup policy in
mind for future submissions.

Thanks,
Hungyu

