Return-Path: <netdev+bounces-259749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I+9N52pmGmvKgMAu9opvQ
	(envelope-from <netdev+bounces-259749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:36:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F116A1CA
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6499F3018BF3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8F366803;
	Fri, 20 Feb 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YqpoFQJN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED1366545
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612518; cv=pass; b=CqV7R4E3haZ4iCsqPS9qg1nk4HYfp1BdzNDuwzTub3J7YDJVhymZKTmGh6aPyPkCV5tkBlB+cHsHkwz6r7vsbxSafBBgQvj+15g2TCYn9U3DyCiO8mKR9RaPj3QaYNdhVZIqXH/3dyKAcBmTC2CCRaL3XuY190C5VWGpqG5AiOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612518; c=relaxed/simple;
	bh=MxQa3nrfu1YS+AokB96QoOSx1G+mkz1ci5wmgAEFyag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJ3gEoLDiII3KSbrhxcB8tZsqEy9Sp5VYYpX4xchUJg59qdbFcwSuoYNHBlxUwwWAe5H6FGG9m34YD/TvlOrRnk0UWqg0oaxR54zXg4xGwREeTBBS7XFmbvIYjyTpMIphtrGqMfjotlKbyXGUi3sVY2aE3YCb5VJJZmbVANxH6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YqpoFQJN; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso5506201a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 10:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771612515; cv=none;
        d=google.com; s=arc-20240605;
        b=cidIR6feSkBFhnGRJe0N9MICQebOtNksd3txr5J7K0J3jZKCg3VkMwb48qWW6kDTAq
         b5D2Hs4feS/lQYkIcDAtBgImAZlA/mM66a/NBNL6X0ktjb1KhUDC4TA/1YTwAptx+qWT
         PhfoQpCnvdLS5gNCaR9onKyUA6X/+FUeBcgrs+gzQL2vzRr9P3P9O6LNt8Pj2Ice4gHN
         gV7AluEGAj+YtEzYRdpEM59pUBy0laPOU++kj/j8fBeUlQHIEH5Cypu2lbDnKRLQ8xc7
         /gr72Slz/cDLnm07UKFVuyXy+ILZaY0EmTZy0O6k9cn86yoHCG9Twt3ApEWVyDMNWDNV
         6qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Xu9HuQBL5cHkzfmroWqrxWWuNKUX0XVOJbElhWvSbc=;
        fh=4wsaFr7yCnCGJv4OdjcIdNEcBDsPPpfcfa+Q4BcAGTI=;
        b=QodAv4dYlmRfsZC4tKIv3mN/FdTCFyzXFoiZXZo2tVACn1rm3I0DBD30M1k9dF0SQ3
         mHAMVWHk4QWwS3FcaxEjnErsbw1Tq9cbJS4EWLMriBo3wIdCijWMVyLlVFM3oxVUBtHB
         +of3hro7rPMtfOx/UIPp2asofBPHHhKYRjvEtU9WmG5CXRDfkoVOsM0/mc+KuUJF6peQ
         qtpYgL7eLO+NO0Y3OMpucuBV5CwbL6er5YuWgwtv2c6rRJQy/4Z6lgx9VGxF8j+GKqh5
         SqO4lkK4Pns4EGstiIvdHdLZUBtN/+u6kxDISbmI59j1CxmgEiHBXHdf1tM4lvW6OA6X
         249Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771612515; x=1772217315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xu9HuQBL5cHkzfmroWqrxWWuNKUX0XVOJbElhWvSbc=;
        b=YqpoFQJNZ7VmDgwYZImK521CGV7x2h+X3liTv6D6Q6BoDi6sRtJUi8pdKoHvtAPYis
         SXCmLw5YWWZOayoTatRpLHJBpt4vOWQ27fHjpXpPcWekHiBfRaRV/9PFlugAQgAsV3EX
         iDzo9YiVCCC3koGRvgSb0YSaEN4FUWFFjYcsBeQBEGMSCCiT/unt+3Sr+Gju42BtGeEz
         rpW//XkxJseLJIiOhL7DJ/vrj7sXrG7W1sjEeYa7+G6JssrxMH+45wDUewTPNLEoNgtE
         8enzrbaZ3Z7wS6OURaL3vupbVgxJLejr5gX9wSHult60ZvbpN7PqtNweroIVOwIdAJ+t
         +IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771612515; x=1772217315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Xu9HuQBL5cHkzfmroWqrxWWuNKUX0XVOJbElhWvSbc=;
        b=hYmXoXrgEeqZ3AJHUPnIORSEhlpoFe8FR50bsFVdkPcPgnWA9eAyeGZFg3zqoxxZ2h
         e6CIuBisUAmsiZPA5iflREMp4Iib8iFkHUucBDM6MLHhDPxoGktX7kf/m0/pXA+eChH6
         qxQ1U1KNSVD38WfKmm9XxvhdqcAIWjxyCgKuxDVIBY79v+6fJZ2PxfJUwZVo0AN5fLbg
         XFa7GzWn45aOiJOpLN6GF4vtBU4kBC2M5O8gdR05LsM/nrBOt1afsKT1EVf9BzVksC7z
         V2l08b6hQeLcBr91eFR7kIDwpozwSfgPo2G6ioGA2Ox83hKQzH4O8IGHqNgG+ZNjNjrk
         BlKA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIJYJR/gI8OqjsQ8dR8Hh4X+ehk4fZpC/vOkUbb8tfKaSgLr1Uw4HJSMAq7jNZZQPwJk7A/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6afmwDTDFHdUItaCw1qa/1kkd7caprf8acWjZ02viJPQddFYT
	4esRcyPGfxQlXSP1rwlf3buHlr5wOJLheYgzPDFZpE11SjYgPAtKzEK8tQ9sVl/Vuzou+S2vfRN
	QfjgtGe9tTlt9Lwsswg8gD0fH+Qb/z6RLJDvYkVDCug==
X-Gm-Gg: AZuq6aIsOm22nQHYfltOCzxnU/BUtA7ypuyaIr2VqSpoZFTDSnLl4rNYzjXnWPwkoPE
	UZatvvUUaUkoBXsn9Mc7W42/HeOP80a1GKz99ow18LHTYCYfVZmGyzqBnp/12kgzaCWumw3zWNq
	ZmyWJES2VBSnA2GBxE+QXDsav3x/haA3L56fl3wv7juoq5CXTB2mylBEHrmz0qmVjIVrHNs7DRW
	GsLXkCOZ+fRI3dBI8xZzWnwRsUXWiK8WR5Kt6weUQJd7YuBuWq8BS9u378lyemBzV7F44A7wY6Q
	LpItqrHB4g==
X-Received: by 2002:a17:907:3ea7:b0:b90:77bb:5aa3 with SMTP id
 a640c23a62f3a-b90810895b3mr33703266b.16.1771612515417; Fri, 20 Feb 2026
 10:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com> <20260220-fu740-v1-3-c8af54130c58@sifive.com>
 <45821cd4-214c-43c0-ab2d-bbf34d9ec911@lunn.ch>
In-Reply-To: <45821cd4-214c-43c0-ab2d-bbf34d9ec911@lunn.ch>
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 02:35:03 +0800
X-Gm-Features: AaiRm52zdgGy_ZwaGZNcNjw3wNbwheS9Jou-9dGIz_POzEmmVoyRUwnv2BD7-yg
Message-ID: <CAHibDyzQAWgGP9sktLtnpND-Qr6FRrTA=HEiweyDD6rWm=8=5g@mail.gmail.com>
Subject: Re: [PATCH 3/5] net: macb: Add support for SiFive FU740-C000
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259749-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sifive.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sifive.com:dkim,lunn.ch:email,infradead.org:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 765F116A1CA
X-Rspamd-Action: no action

Thanks for the review, Andrew!

Based on Conor's feedback on patch 1, I'll be dropping this patch entirely
in v2. Instead, I'll use a fallback compatible string pattern
("sifive,fu740-c000-gem", "sifive,fu540-c000-gem") in the device tree,
which makes this driver change redundant.

Since there will be no net subsystem changes in v2, the series will go
through the devicetree and RISC-V trees instead.

Thanks,
Max


On Fri, Feb 20, 2026 at 9:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Feb 20, 2026 at 04:27:07PM +0800, Max Hsu wrote:
> > Add a distinct configuration for the SiFive FU740-C000 ethernet
> > controller to comply with the SiFive IP versioning guidelines.
>
> We are in the merge window at the moment, so net-next is closed.
>
> As requested, please reword the commit messages to replace the SiFive
> guidelines with the generic DT guidelines. And repost when net-next
> reopens.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> The Subject line also needs to indicate which tree this is for.
>
>     Andrew
>
> ---
> pw-bot: cr
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

