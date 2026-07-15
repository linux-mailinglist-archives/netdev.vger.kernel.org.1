Return-Path: <netdev+bounces-307713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9558MLZNV2q6IwEAu9opvQ
	(envelope-from <netdev+bounces-307713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837075C3B5
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:07:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e67TCDDc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D416230E2A66
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B73DA5A6;
	Wed, 15 Jul 2026 08:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88310335066
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:59:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105949; cv=pass; b=B0cG9F9QsSaOnmEwxP8ISByuUwxsEmgXS11Cto7PjpgsUzCdNrYwUFo3bamqOvMXJy5oga7qdMxKi9Mj2rFkbb9ReKOEboAy2sb8NOsnBcM7+4SWupoOnSVcVqTUAxCnmPldlkWl3jDNFmz8qpglfck+ogtVSPQzyN3fHgcnJvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105949; c=relaxed/simple;
	bh=Dre0rhAOMbA2vc6z96CSk0Yv6aG6tGAoHo0wVAUQlvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMNSZx8LT55JIBq5OPxhyXFzAOx5QCJLKNc6h0CoCdu/wbzXPORCZe+gSMNg1L5eiRJvLQXQlQt0JcGYS4dAqGaJ3L81x5OIVM8T4Xn7PhdpMW+JBtpHFQaIePjINd4NscFhNlcaxyOHhkAQl18d3GnkQTvU0vhKPqe7Y7aQOQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e67TCDDc; arc=pass smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso745970a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784105946; cv=none;
        d=google.com; s=arc-20260327;
        b=BCAtGDYQAMcg30HrLVoAqREI/fee02LRiwIBAknWRJhdHOsNf9RqYcP4gAeCRw7eWN
         FTNdUmF2zlZh+njZXN03C/rkturXqOa/j9AMx0ht4qNuHtFFfXC5JdNMoiBIodHcbtVs
         B18ESdKeDEXBWqbSDqynEG3scUMgGcNHEwZaYF20qObwGwtRkyqRQcdnSJVySjCtcDyL
         KzW0XoI85MBap2lVVJx+6uuDHb/2fRDFAgGMeXSaHnbWbtX+nnpL0N0lBZmKIAMDW2XL
         ReI2A75A/uVRY7YU7AoysxeiNGkLDKsuL8wVm3rWnB4haAwDC3x9UdRUXWoFLJVNjfQs
         FVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dre0rhAOMbA2vc6z96CSk0Yv6aG6tGAoHo0wVAUQlvI=;
        fh=9VLwWZlCDX/VQME/6kRqGFDUQx6QFxkwimjJLsyiFjk=;
        b=NFG3uqFRbcepA6WcPlskOE+DfS7xaoIiHqBdjKN94+L9aLIQr4vnzZGumRxaOo40ET
         32LJ/ilOzHkEV94JPE52jfIcs1l/YZOFVV1iysxpKJ+KMNqxprrolUjVDLx2BpsXIADh
         yiCBaE6l7UHV0L/koaNQXQikdY3viZEG7MU6XzGAC/pgYyzeEVnAnEJ7n6JeoiCKgeZa
         ooG9Z4phZoLYwXnv4elJeFaA40gh5oBZ16DZglmVmnzVZZcRH8JeJGh7SlSaI0Fa8mux
         fyX7OOz9r20JmjYzbX0lJFcH9KdfdVU/5gezFvsSm/uzUdxYe4ZTGN2Sh2hwTOf5LATg
         ErTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105946; x=1784710746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dre0rhAOMbA2vc6z96CSk0Yv6aG6tGAoHo0wVAUQlvI=;
        b=e67TCDDccA9L7FuOu57iyIsXtR2nSVBTFjv19s3OCw7pWt0ld/RGFiFwgRFhmpWHny
         uGGCnNnTUVo+6z/Z+i677cMDnWNb+iAB0xZMhJqk7vegolSWIBdxV6CNJcsRvovxjOOv
         V9/TKnE8BNkFZrYnizGSuJDqsXJYKR/1zFGoHmy+hkh4OfrFqBdp2j07EMVXhsmbaScp
         eUs5InN0suxRZBpxm37M6E+vuU3DU/1yvmU7siCzWGAUo1prFZnC6M26BvzFiaGPeRCu
         evehc++O9PeBasauBNDSWog16q0r++L6sawu9Ef/CZfEuDdoGrVA/OUz7EBDAXh2QzFK
         vnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105946; x=1784710746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dre0rhAOMbA2vc6z96CSk0Yv6aG6tGAoHo0wVAUQlvI=;
        b=NbPsQFzpdBl6j9PsIWfQqTwGQoLA1vDl4qo+GFwd0+sb5+LHZSqIyOQ3w8BrEvbeei
         HHd3fxQgmCXpb7vCNAWsjs2VgyfLao/oi0jLjoOcGCVkqkIq7LcaxfSf7/WxZT9i1tRm
         ky70FcfxdCCdZ1C+WBLeFnk1H3LT8QDhNoshf1p9Ht5wb7mGlMHJUJEnl0REl1C+0QX2
         QvpGcAPIdnEu8ZXw7xqRJwASXn7mxHg96mGKzyG+Hu6C667Vhlefch7ztlFIBmaav/kx
         YjFiR34hAbt6gHeUyVBHXtMbEIenZU01yU4omdPv3Ahqp7nsir3hciMHTOiwGzK9hUhB
         b3mw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Yl72iXRnu0uAMEIFyyTCasi0kfSfE8puDbhi1cCnloQokIaDa/QOrPr0zVYsH/O2MFxwDy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zUs0vdeH2rIWpRS2e39V61S7Zph7J2qWK2FaP8Lt1zBmb3xB
	6LJLnCm9HlEFkhZhWFV6dMOmBRlKwdnyLMobIVSFlGdoWzqDOH4CBMfYWWlBIZt4k+reVaYm6Or
	uUwvt6aYbot92liSDszK3fbYLqSAWwLRyZpo1oHAWTchN
X-Gm-Gg: AfdE7cmaoyQXQqmGy1DyfSdDehENSelXZu0gpgNIbENs0zGKJuF+kmzfR3pi7V3+umr
	Vn7rvpbiTgpryLFHN6eQvJLeUcUjnwHSQoHUyFlyUxqn4+Zf7/a2FEbTZjI4sVQjpOkC7R0UPSb
	gL+CBwLYI5696gwHYifSzV63cu8dPeqkZuUelif+ixKo9DMJ5JzMlqpzsesqjZzyBYg8Qtg5eGE
	heg9srj4/t7MZpK7LDo/i32XVrqqFSczbSwSBc/eUPucALDdPxdrsieu+70YKmqwpnE/2A=
X-Received: by 2002:a17:906:2443:b0:c12:707a:8372 with SMTP id
 a640c23a62f3a-c161e992d2cmr680722966b.21.1784105945500; Wed, 15 Jul 2026
 01:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714091941.33783-1-running910@gmail.com> <e07c280b-d3a8-442d-bf19-f00d544ab26c@linux.dev>
In-Reply-To: <e07c280b-d3a8-442d-bf19-f00d544ab26c@linux.dev>
From: Zhixing Chen <running910@gmail.com>
Date: Wed, 15 Jul 2026 16:58:53 +0800
X-Gm-Features: AUfX_myTUoJp1A8VmbhBzNhWx8N3kj5HpN3fRLOHmuaZlWQoHn4_65qgWOT00kM
Message-ID: <CAMyuFdXdYWyHwYRBQb66GWycWZ=ZYXaca664Cq_TCNuhuKk0ew@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: reuse ppp_get_stats64() for ioctl stats
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307713-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qingfang.deng@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-ppp@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5837075C3B5

Hi Qingfang,

Thanks a lot for pointing this out.

> On a 32-bit architecture, this will introduce unnecessary seqlock
> overhead to get the upper 32-bit of a counter, which would then be
> immediately discarded.

That makes sense. I missed that reusing ppp_get_stats64() would add
unnecessary 64-bit stats read overhead on 32-bit architectures, while the
ioctl path only returns 32-bit counters. I agree this is not a good
trade-off for a cleanup.

Please ignore this patch.

Thanks again,
Zhixing

