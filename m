Return-Path: <netdev+bounces-256263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5SJpfggWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:48:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01660D89B9
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97842301AF4C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D20311583;
	Tue,  3 Feb 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="CRbwtVGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C12D94AF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119317; cv=pass; b=XxnsnoSShOEcxDASvzLTZPYId8Vk89MjOqwHi9jPs8b38A1Zh1nOZuXk1tYIe+RottT5ECPlJkJROPQ4RTIqtgQeFIrv3c4NV1YtaI44Y4hb1+RfTnb6kV2q9eOTC1Dr2+4ynCqXZHUKY6PDDxauUAZdGcQCz9+JFL9DvjWCW04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119317; c=relaxed/simple;
	bh=dWopzSpImLPFAF1eY43y9tbT3DilTzbhZVu036Cp84U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4mXFfc/VXxvSloVxIIxIjMM5QUTOQghx6BMWx5k+9lvOXzCSgJ9mqU9Q93H0yS+NnUS58i4ROxL+3KBx4WG22iAb3mH8vgjamYdQc+MK4dcC1oSrU/mxyx9wg//mFu2Atu5o/y9j0HunU0Rot+1dL5oHA/bSKvbrMm9QlOJzQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=CRbwtVGO; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233c155a42so9053865c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 03:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770119314; cv=none;
        d=google.com; s=arc-20240605;
        b=FAF7bI8lvGNA3R81ahf3cNCC2EFBemqNeNo70Ixl6yUE8I9njEd4igxsLH2gbXR9MM
         OZREdc5VAcWwcCQRsVm6E3HGrPZ1JJ1fZ8VFEURztR/lGAU0BJvnpxAHi0o96GvkJeew
         lzjMnFjqLFwIDq95YYcw4LXr4R5A/ak1Nw3Tt178LswwsjedetkBn+Q/jq9by7+ENQy5
         SHQhUo06WbscEqPXKnMYrYRKSs4OubycxAL659zef+XwmeSSAi/eQIcG7Soyrozyt/zy
         nrpwsXpszrgJWvRRrK2VW0WKoUPbi7Py3Ds869EdiJf5lfMaLGJKJkI9xgvbTjXM8HyK
         XrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dWopzSpImLPFAF1eY43y9tbT3DilTzbhZVu036Cp84U=;
        fh=ikrDm68aMPKdXdc5evmjxGZ4OdzgGQ+ab9SePxTP25Y=;
        b=ATibbiZ/zc7WvzVCfGYbOtz4E73w670CUi8pHNKN4Xh55EZfc846btZQMWU7gyP9Mp
         ZvriIHjFr+uPU7ZJdG3nWP3gbIeX9ElsVt4tGAnGULfb5tH8Q1zbEXfpW3M73cqyQXDp
         EPT97psFEdB6arupRjltwRE3D64svnEoWSbwM4JH+C/xVGM4NfYmfwE5SYPXsuYaWAE8
         RtZQqIhJXxsr44JUaC7lohKEAuojSfRXeyFHF9q4jia0Yzr5OK8pF2YEI8S3DLX4KwOo
         xU5YcZPaOhT9v9b2ItsU6uoC4/B0QMQheZI4z8bcbP2Tn+n+GV1df/DTg2MOoW+bVcc1
         sfYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1770119314; x=1770724114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWopzSpImLPFAF1eY43y9tbT3DilTzbhZVu036Cp84U=;
        b=CRbwtVGOZcP/NyElMfmpOANSLvBJFIO01ULGVkrHK6D6bu2JJSxSIhS0jysqRoxPVK
         mPZcfUBiFe5+fhDwVXikv76+foyWWLfnYONYJBa82maTv7lxM48QMfOw5pcFQ5fXQuZh
         5H4kwTBR4xVkcXxgeB6avgpEpfJKY5qRsyjZW5URynMIpMZGNMCa91Bty2YMzdxJ+KJa
         r+zox41LbDNxtn2VW2/eWsaDF703es5UumU46QWCXW53ISAQE1I6xSc8Ww6Zkk7XhVqf
         T0IA1KeCfp+5aRc/oYqvnY8pHTUU31fh2lN6gEbhqSFt/OtReRDiCs5nvLD0SU2wzqfS
         EV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119314; x=1770724114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWopzSpImLPFAF1eY43y9tbT3DilTzbhZVu036Cp84U=;
        b=KCDW4cRbNZD4uJt5hLxwHl/UfIsHIdc2oERLjNp99bqf3w/Al9TvzIg4W/oza5d5kZ
         dcn2wq8J47cAzj8XHessCMhLRtxQIWmfaugtD6/3r+L6eTwCiZITNsDF5NduH7zpHOgM
         RqG7v1VN+4SZ/RYFK46feuF2q7qfSkZWc3O6in4zKl6l8/ex4i0FXi39iGOv+Xuhoj12
         yD6b8+TTadTr5uKP87FlrcpRPJztjZeajlCPkqs6vFSXiKHKTlN5yYOvpQ60ii5Yh416
         OAOLALUkZU0HbDeB9rrp5QM4CiVqVWNCbSYkXPp+UknHFLmIG90daSdlF4CMkQ3hDG/s
         f4PA==
X-Forwarded-Encrypted: i=1; AJvYcCXK8ke1o9oeoc50UnwVROWBjJi3YVmV/+KM4BlWmOSzSmUNuXIdNRL9hO7vu+/pefOIMQFomQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsuHYeucR+hiWaOd6ZxTvCSTM5Y3HzcKc5d6/A/o8DJc1W0W4
	DENlZDUn8ubB+zHTh2lsU3DZZOi6Ujt5scRfcTySo+QVvNuHIW6PokCGdhy1eDayRmJtmXRWyGl
	rXlo3Z2ikkZG4Fo8+S/h7uLfOHSt9WgzAP5+emJ7ZuQ==
X-Gm-Gg: AZuq6aJbBmszoVdJJlOAnjA1EAhM4edUXxlZfdpBm4hkWi500C6Jr9DEHXB6NON80xp
	y8i/wEjRxsIGVhmuD2DNBKxQcUe9e+PEjEj9a88r4sAroAD3/rS+dSy54GDCIixlLWDlPrQSw0m
	I36Sk3E03TGmKTpV+2SFqiUEwJaMr7XzO3ETbmPU92nerm3rNqWKJoTiqZ9h7ZGLNlnCS+ugrYW
	ihcXPTEyOa6DZuCy6GGuqqk/xoBYvN1i9jG8iuLuEegpIhrJngNgRbe3fPS8Au4YRfp5X5eh/XW
	kQ/b3oSq9jjNwOU/1VLO+DbMi6zLA63bWrIQfwkoe8M4HXvAHJww3FPMFd14nhOlDPspqHfra48
	8ZaJvrDpbK8xq
X-Received: by 2002:a05:7022:226:b0:11b:998d:bded with SMTP id
 a92af1059eb24-125c0feae0cmr4778177c88.28.1770119314480; Tue, 03 Feb 2026
 03:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203085942.2477583-1-alice.projects@fastmail.im> <4a029386-a03d-41d0-aaf6-0d5e7a6af389@redhat.com>
In-Reply-To: <4a029386-a03d-41d0-aaf6-0d5e7a6af389@redhat.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Tue, 3 Feb 2026 13:48:18 +0200
X-Gm-Features: AZwV_Qjr1HaUDBMWs2ww146oqr91_91kDbP1kAtqKkhKtlulGrikKo7j7bhwH28
Message-ID: <CAD0BsJUgkSnbEByqYQdskxp+6riBy4j2Nznr+J6LU4njNiAcbg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/12] BIG TCP without HBH in IPv6
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alice Mikityanska <alice.projects@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,isovalent.com:dkim]
X-Rspamd-Queue-Id: 01660D89B9
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 at 11:51, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 2/3/26 9:59 AM, Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > Resubmitting to add one more patch for bng_en. No other changes in code.
> >
> > This series is part 1 of "BIG TCP for UDP tunnels". Due to the number of
> > patches, I'm splitting it into two logical parts:
> >
> > * Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4.
> > * Fix up things that prevent BIG TCP from working with UDP tunnels.
> >
> > The current BIG TCP IPv6 code inserts a hop-by-hop extension header with
> > 32-bit length of the packet. When the packet is encapsulated, and either
> > the outer or the inner protocol is IPv6, or both are IPv6, there will be
> > 1 or 2 HBH headers that need to be dealt with. The issues that arise:
> >
> > 1. The drivers don't strip it, and they'd all need to know the structure
> > of each tunnel protocol in order to strip it correctly, also taking into
> > account all combinations of IPv4/IPv6 inner/outer protocols.
> >
> > 2. Even if (1) is implemented, it would be an additional performance
> > penalty per aggregated packet.
> >
> > 3. The skb_gso_validate_network_len check is skipped in
> > ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
> > would make sense to do the actual validation, just taking into account
> > the length of the HBH header. When the support for tunnels is added, it
> > becomes trickier, because there may be one or two HBH headers, depending
> > on whether it's IPv6 in IPv6 or not.
> >
> > At the same time, having an HBH header to store the 32-bit length is not
> > strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
> > just restores the length from skb->len. The same thing can be done for
> > BIG TCP IPv6. Removing HBH from BIG TCP would allow to simplify the
> > implementation significantly, and align it with BIG TCP IPv4, which has
> > been a long-standing goal.
> >
> > v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
> >
> > v2: https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/
> >
> > v2 changes:
> >
> > Split the series into two parts. Address the review comments in part 2
> > (details follow with part 2).
> >
> > v3: https://lore.kernel.org/netdev/20260202192338.2373930-1-alice.projects@fastmail.im/
> >
> > v3 changes:
> >
> > No code changes. Added Paolo's ACK. Tcpdump patches have been merged and
> > unblocked the series:
> >
> > https://github.com/the-tcpdump-group/tcpdump/pull/1329
> >
> > v4 changes:
> >
> > Added one more patch for bng_en, because it started using
> > ipv6_hopopt_jumbo_remove in the meanwhile. Added Eric's Reviewed-by.
>
> It's a pity you resubmitted before the 24h grace period

I'm so sorry for this! I was unaware about the grace period, unfortunately.

> without any request to do so.

I received a build error email from kernel test robot, and realized
that another usage of ipv6_hopopt_jumbo_remove was added between v2
and v3. Trust me, I had best intentions: I didn't want my series to
break bng_en in net-next, in case this new usage goes unnoticed before
the series is merged.

> That usually causes a request to wait for 1w before
> the next revision.
>
> Moreover the current one does not apply cleanly to net-next.

My fault! I tried to close the gap ASAP and didn't fetch the changes
that were merged this morning.

> Still I think it would be for the better to be able to include this
> series in the upcoming the merge window, and I guess I'm not alone with
> such hope.
>
> So please wait at least 48h (be accurate about the time) before the next
> revision.
>
> Thanks,
>
> Paolo
>
> p.s. this is my (very lenient) take, other maintainers could ask for a
> different/longer pause.

Thank you, and please forgive my unawareness.

