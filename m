Return-Path: <netdev+bounces-272369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AVMJGcCxmnQFAUAu9opvQ
	(envelope-from <netdev+bounces-272369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:07:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F433F02B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A7D3015889
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC25372B59;
	Fri, 27 Mar 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyaBJP87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360D2FF170
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584333; cv=pass; b=XunPAz/RAdWHTlGBVAe1WxmLI/vaTC3Tp2OtsUq4VLIfw4N8pw5fP48lMy1S1o6YmkgB/li3koh8g9z++JvvTai3UU7CDdSUjN30IBR80eBKTCZsLum9UnLSqf0s/7GJ0QuL6fD1Qrh+Gy6+hmHEGagMmn32yvKr2Dyw//yCw+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584333; c=relaxed/simple;
	bh=kZahunIpVubmTUukRfxzwGTgTBAh3pGnOOcfvGiScZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu9JgTQFvYc9n6fv6o3rhFtJfkybE2RaUlJMr/S2EHXdijmlrMDHT7WvyjbYqTX131QEHMRUoytyqRZYg0K7zPTnhf50kZG5LjjAIV8x9/VDTUwftWhgl3eiV6iZd0OH+mYaLxk6lkky1Mfw9sbT5SbzD8uUXMHX75SF+yyB8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyaBJP87; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b392f1846so28191111cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774584330; cv=none;
        d=google.com; s=arc-20240605;
        b=BSr5BmgOwfUmzyxqVc/N+iz//Ar2YmCHUlD+9zXcgprzHBsFSsHyNS9VdQ3aZ8heIo
         u0v8XP2Qfz3dKKppBELrKq0+GaTeggDur4+ixF4wXj5asFsbQXBs+43w2waX5RAwOefH
         Q2ANObCTrPvsPyhRMiCEwA1VgBFm8FbPZNzCceaelxj1tku2DfEiaEu+ofDb2fh2Sqtb
         bJS4uun6NnY8SZRA0tbW7kIAaK19s4KutMj3/oeYcioX5ibBwydwRiET1MJ/QbuWEcm9
         XgXAC1thKIhnXMku8Ojmc1KyKZPErP3OzdWfwRKB0TWwtn4vCd8CFw35N08ERCIG0sM6
         Zxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XH4CFunHXiIzKPG1/u/7Sccn0ubveaWD/LLjVziqAyU=;
        fh=kZm881+3tqZ6QintKczLnzfF9cBEOfkrQ/4SwnQ2pSY=;
        b=Sbjk2eSKs59FKSS1mJ2GLQ3wh7j+W84pS3UFLX9n4PbG9UTdJ0B9MRSLH6B2TxdrFu
         se3Wv05yPoJ1BA031UPGhzkNHYysPzIgIGBIS5UFBXRdw5QxT1+8Z1gewehNySPXfxUC
         XK9aRZ2eMv8cIMl8sUzwN22Ut7OM1QeSyfmbhoyrjpPC5Q4hr2MXsc8SjhIIJ+RYb8cx
         phlQkgZYHYnsb+4Yv4F2tW27MWv/Aj/+uS2kOw9Kh7qVdtfItGxPZ28SlR97IYPCou5d
         6wfAQnS0xUyocb1BhgX7xjEJGPsoo7z9puSpIrygZsk3Z629suYPAfVsTNd35N9dvQk9
         0HwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774584330; x=1775189130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH4CFunHXiIzKPG1/u/7Sccn0ubveaWD/LLjVziqAyU=;
        b=DyaBJP873w++xMNGnwtp7NfWVRliUFcBvp2dxAguVOBCdMkIUgJ/1W++rBYpUtCMXm
         Nip6HcdKTq2DJUSiJmgb+4NDSV5e+xqxX0rA0/g9nagsgP8euQ8fERwIS2kLBgjo+QVi
         9uQxJ3+vF7k2ladTLTRiApFE9fBSo1q5M0LPuNfDyQWPYCdz/oFZVfJUB/Aj2qGMmQ52
         AcDZXzVe2qaQxrsHub2/Uzx+3XJdSYblYl0D9i7SR6pHh0P21uoZg1LmnG/rgOIrIwy1
         qEWcThnjCjCtfPdzjAG5vl3QbUj2Sd4iSPqbi+oyl6da5SPLS4NhcOdfrDYGjc/rxyEC
         X9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774584330; x=1775189130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XH4CFunHXiIzKPG1/u/7Sccn0ubveaWD/LLjVziqAyU=;
        b=S4/mtwytyoeMyZ4ZH/U0Lr1p3m8GqsPZvx1ucRUzy6Ru/bufv+fIrBlWPWH5jLH5Wv
         en7ix+Ugr13bB6VdbGMc95v9Cb655VXRWg0XbsSf2wlMeo5dS3IxruMrWoEooBxxoaow
         c6FfJmKFpgXQpzEPiKLr9jdGMldOfUeZFDT7aPeKzl1Izkn3jZJGnHOXobj6jrQuTD6Y
         oDzjyqjAz8OHu9NyJMqFGPBNwCu/Ld2yNIcIPMwKha47n6XJbEQgZWLUY1+UJabh6T9v
         kG5oDIkTY4dLb+gIJ7bJyKPWkL6M2tkGa9F+zOFrCpHNnaPUq4JJsfxSLyiz06VUtDvQ
         B1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcw3F4vzVfLUFbwLEmFmLdISc3iPPYukLnC4halGyRIEq8wHeiWAVohZPonktWVWzAwvDIO9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxi6omBtDD0uXSTogvK9ddQEjdSdxcv2CpNmZvK2Ws9Oq9dhEF
	jQhdzPF+iXSUp3jVDCVyIG2yCHC87VcWZ0hTxiuAWf+UYA2T5A28Si0oCX1ZEIB0XWqW3gm+BzK
	uBcTBhvjlGNWabvGQvi/Emt2XdA7ixRRd8qcp3NA2
X-Gm-Gg: ATEYQzwQWX08SKxzvMijvJz3sMyyQaH/uaqA8CgSDdR4fmYjm3RZ8TwzBV7cQSDhg72
	xjcqpFxuh6kjMRCPMptO3u9rV6rnPqjgdG35J2n9XcjmXMlgve/MP7t3m5uiQs8o12me8T/iftu
	J1ks6vBwa3CAWIGaDag6FIpHp+N4gv6lRHCFL3aLuQ5tooH8M9QQ4Trl0b1g/zeWmxEgif45hOq
	w2IaPm/z7h0LDk2/KQROvR2JjfURk6u1bNIudEnPoiauzIo/e/SU3Wr1OYaw542Fwxl4ntIZOwf
	XGNogQ==
X-Received: by 2002:a05:622a:8:b0:509:2f5f:a178 with SMTP id
 d75a77b69052e-50ba3836481mr14736391cf.21.1774584329967; Thu, 26 Mar 2026
 21:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323011816.3737155-1-edumazet@google.com> <20260324015011.858344-1-kuba@kernel.org>
In-Reply-To: <20260324015011.858344-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 21:05:18 -0700
X-Gm-Features: AQROBzDSzzNvvbFG9gpFoI6pJfgqBOhLwkYbl2VDEzYeAheSdYScitZWEkRwPPw
Message-ID: <CANn89iJiQStxF5f9Hp=N94hHOaNSg78F+iPzqzbSVnkRXvxLQw@mail.gmail.com>
Subject: Re: [net-next] tcp: use __jhash_final() in inet6_ehashfn()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, kuniyu@google.com, 
	horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272369-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DF8F433F02B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 6:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> tcp: use __jhash_final() in inet6_ehashfn()
>
> This commit fixes a bug in inet6_ehashfn() where the last round of
> jhash incorrectly used __jhash_mix() instead of __jhash_final(),
> which left entropy distributed incompletely and didn't provide proper
> avalanche properties.
>
> > diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> > index 109fbf620ad7..0a781cba4085 100644
> > --- a/net/ipv6/inet6_hashtables.c
> > +++ b/net/ipv6/inet6_hashtables.c
> > @@ -63,7 +63,7 @@ u32 inet6_ehashfn(const struct net *net,
> >       a +=3D (__force u32)faddr->s6_addr32[2];
> >       b +=3D (__force u32)faddr->s6_addr32[3];
> >       c +=3D (__force u32)fport;
> > -     __jhash_mix(a, b, c);
> > +     __jhash_final(a, b, c);
> >
> >       /* Note: We need to add @lport instead of fully hashing it.
> >        * See commits 9544d60a2605 ("inet: change lport contribution
>
> This isn't a bug, but the comment earlier in the function needs updating.
> The comment currently says:
>
>         /*
>          * Please look at jhash() implementation for reference.
>          * Hash laddr + faddr + lport/fport + net_hash_mix.
>          * Notes:
>          * We combine laddr[0] (high order 32 bits of local address)
>          * with net_hash_mix() to avoid using __jhash_final(a, b, c).
>          *
>
> The line "to avoid using __jhash_final(a, b, c)" is now misleading since
> the code was just changed to use __jhash_final() in the last round. Shoul=
d
> this comment be updated to explain that we combine laddr[0] with
> net_hash_mix() to avoid an extra __jhash_mix() round, and that the final
> round correctly uses __jhash_final() for proper avalanche properties?

Ah well, comments are stale after one week.

