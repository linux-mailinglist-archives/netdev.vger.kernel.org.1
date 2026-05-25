Return-Path: <netdev+bounces-291247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAYtFLD5E2oHIQcAu9opvQ
	(envelope-from <netdev+bounces-291247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:26:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2225C71C8
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482A3304BE63
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46D3D1CA4;
	Mon, 25 May 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtyZj2c+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2A3D1AAC
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693839; cv=pass; b=c/4hsv59EZnB7eloyJDtt2hz0NlKTQj8oBI6V3YN/a1SuSEiBQ5f+vUQPfifllBHsM+uUeGM488m3un+qRIg4jlJatTN0XHnh5ekNP8gJLKF6258rsHyKpazFpkx9YiHW4j606wIXTBGtXiwDi+slVj2DbmFd1XXbnr5w/x0L3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693839; c=relaxed/simple;
	bh=Mew+uPT2pPeuSrUeWNOImf5WoHivcPQQHv2E7O0Fi3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3FfZETNq63qMbgNbGPIGBB0m4pXoFRJD3NEuDzzMLs87AZARBNEAztCTPVUTO5mco4bNtZJnFQLAr/w3aT/ZdGXXiaLzdEGq402a3+h+eiTuOSOFHAVqzgmBaYPWWbjjdY67dMlGWNf8WF5clUQJM/kqbyIZA+etBRGQTe+CWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtyZj2c+; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51306c9f2e1so110413531cf.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779693836; cv=none;
        d=google.com; s=arc-20240605;
        b=YnDyQTVavzUnzmtPmfC+xed3y+Be1EN5wyGvHesf5K+bYEwJDyyC3iZEpD47ArBLTn
         2pZ0aovzi03ah9Zui2AiVWt6IXgoe+huZGb9dsdGoBo8cJmhEU2rGjwz8dPNf2xgJUmG
         nZ0uk4yaTx1q9rMbY+OhoJje3eDUSP7vjDvHDbTa2Jdlx0kpmv92+ImVv/7ENbxwVAzB
         3r1iaqrGJPcS8+MSZqDqGKi0UbpOR2CMje5fPA1oOzpD8M1bXLDqL8wh1IB/DGcHeBxT
         vFY+8TlxBynCRaKCtvtgQGbzQ7gFkpGaRHibQAh8dugQp2bhx80hUlJHsR+vvslywsyX
         6t4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mew+uPT2pPeuSrUeWNOImf5WoHivcPQQHv2E7O0Fi3w=;
        fh=xuvO0u3l3iKJIqW0+U8wPiI80RW9lu7gOQMa5Ra2tBg=;
        b=FvsuRnArsc1w1lnpY2VVMrX/VaUup8hC9gSw1t97vyLOCVCGBfKqnJGuOp5OY9+8Nm
         r5bf1i1a5ee7rlkEgIci3B1owk2DdX8dtEaumSej1/prnTeioYs3N8TPR6ta8Hf8rK7B
         Lht7E6SJ49ZCyEqqpE00nAWXp3ynnFPw6oBhwQmBmVac7FPhm8qDY5hAEj62NOH9NUc7
         4VWKbeG6G5f6BFor0fKziXI1leqXqdYvrkm5z3aJD5hgTFHmPPZjxgyqgTa8NZ53+YPx
         iDFL2zPITpMSeXksSP9QqFGnbyaHGTfp+uTw6nVarfy4ODJUlLJ/7/yHOlZ4878xT18r
         Q1Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779693836; x=1780298636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mew+uPT2pPeuSrUeWNOImf5WoHivcPQQHv2E7O0Fi3w=;
        b=HtyZj2c+gLgOJ4Vn7KjTR89AvOfA/CjUj80Ss+l3BrsOs7Fk54M9iSZb6AL4E6Be56
         2cedJ1pdDJMF8hvC/IISdBffvxtLuDi0iGam2ytMeUQ6srjFdLYQvJK69l5r2mfLGwF1
         ghfujXbENfca1FFMoKI8m5yTEodLIqbyucTHf32cNP7lsI8ggz8bUJIT/8/88tt37Vbt
         hG8DM7L+kCGBIHjlmCRHfOCQbGef0C5XveOKRDMmUmHmMJhI7cwevkKDOd5EodbAluoW
         13xDCtPBwFJxQZwx5svkpBXkT3LWcafmIFiJhUAgjvCadkf1rI2mOpPvMnk+CeNKQhVs
         kSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693836; x=1780298636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mew+uPT2pPeuSrUeWNOImf5WoHivcPQQHv2E7O0Fi3w=;
        b=PAZ4yj4WuhKk3R7tS9j6cZG8oJieQczvOjtq91ME7ZA6Mge6XMLTqKyEpF0HFNPd4y
         pUB4WDwoQvp+nfCteiHvOQUtAxtzKqeNvGZcQoH1n2Z1tAlOV78ZjatAsWJj+nt+X5mg
         /3wvwAp89+GqDxBLCirndy4WLUU1II62nPVJsHurHqkq73xpTYbEOzBkp6Xe5yNlj5KV
         pxsNFkF6yO4GyJEFY7H22r6N2iL2W7xnONE8EbOWvsNQoovJEmo3gHKEs9v8QzP49wEw
         m0M24DUP+fLe3KHVOS/J53Z5w3PCOdi1Zp3vWR72qFWOJoQGPl4U4b9ouSXm/tqrgEDR
         7TVw==
X-Forwarded-Encrypted: i=1; AFNElJ9uj4o4b6G9OsKRJQAYPfay4XEDHo9O3IG5nLwMINc3pzxxZrXvZmzr8tFncTIov0IzyPDfm7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88Wy8aqn9RrXNyfC7uHY5yC9h13YI7qKUPPp8spny791r5+4U
	Z8VHKRMQfksl8d85yOHSo+9EhhxnkXDklAxW+SXA4Atm9FTW069J4vlXdB5P2mcuNDWRyG1hT1F
	HHrr1qRRfJkFri6Vkv9sVwYoayOIlOZjP4J1vzqsq
X-Gm-Gg: Acq92OFVZUPW3vQqsa2uW+bLjyPPNgV4vTus+VRj+brcNo2bMRT+MWAgRecYb25R+wQ
	zunpn5HrdovR/A1g/nzi/TK4Ki61zbicQOXQkRvWaOZkCOSQ9vc8eEvOSUbDbCQOvHXnVb1eZWA
	tLW36uiR+fAU/DjVu8J7bYnDDkJOYblVCf94OQAXxvt6mI4qUwWVLWNRcjRbsWS7mJEJh3uqpqF
	yizqHavfNSoF4xQPmyTVJvwapOPVyK8FPdnAZR6My8664dEyIKlVa5UE+eMkrm5yHIvbWYpfgpo
	wNYW18DoaeEnN5zsMfYy9xCp/piCTrtfKK/jrpiXao59z/6XwuzO0wbSaTdZLOcShdCRHpvfLBb
	qutV+S6H9myAqhVAJg6bL4m4HooKTnoSF5y402FV08pGJQlQUfUZ10Oimx+TGg6oWcxn8UfLsoG
	U=
X-Received: by 2002:a05:622a:260f:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-516d42ee019mr192767451cf.7.1779693836199; Mon, 25 May 2026
 00:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com> <20260525001745.1251640-2-kuniyu@google.com>
In-Reply-To: <20260525001745.1251640-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 May 2026 00:23:45 -0700
X-Gm-Features: AVHnY4IdcNgQyUx4vtaYMm9fa_La_SLq9ArkcGaqiuvPLzT1vEocPKpck6_wr1k
Message-ID: <CANn89iKK5=-4GNuVvrzSvC9Hjrf-jvMu4G_0VORkUHcSNxaEjA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/5] geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291247-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA2225C71C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> geneve_nl2info() calls ipv6_addr_type() to check if the remote
> IPv6 address is link-local.
>
> Then, it also calls ipv6_addr_is_multicast() for the same address.
>
> Let's not call ipv6_addr_is_multicast() and reuse ipv6_addr_type().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

