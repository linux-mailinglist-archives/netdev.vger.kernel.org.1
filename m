Return-Path: <netdev+bounces-272550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBobEfh7xmnwKgUAu9opvQ
	(envelope-from <netdev+bounces-272550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:45:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A8344824
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640683026C29
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2C229B18;
	Fri, 27 Mar 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZfPPg9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333C221DB6
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615165; cv=pass; b=oprMC3t1/qZ8CMC/2ZNwviHbOg85oVb7PTzv+iVN2sK7Ef5O20MrFF2vf5WT4ZnCvWNH7FeCWnTRUVoR2RHRV4kwN4eFgmKYkicQn0HE36vtR/F8j89io1YA+jy33scRX3A3nKWfJHoFB4BR8X07iImYzykGevrtoJ15K2S0pKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615165; c=relaxed/simple;
	bh=9yUDwreZVAO3aCgvkkcmjPsNpZ0NGYYbXQDmMvro/NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cjl8L4YgrOKwmv0o1AU5c1cuHgBPu9QmQ+MAla62cm00SutJX63mtCohLnOKro+wWH0jaWN/KQylrFf+9e1WFNITqc0YCJfjCAq6Cptzj4YvF1qyz72gI6ZepYNFzb2N1DOcnnbflkfel3MA2z1VYrYFx7DEKkVCqwP8LG+M2D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZfPPg9c; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6500040f128so275542d50.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 05:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774615163; cv=none;
        d=google.com; s=arc-20240605;
        b=QsBsIub+q3JNhv3M2VhIBRb198yfSeoZ7A4kXJfCrodlCHwu/MGgX1Z3wQQ2QUuO+g
         y4jd1zK2lyKagaPW8S2NMVVp3aKHZcAsLavZpFeFxZWRu1tPmnkZSSl1Mul8XezKe68I
         4Bl0UQeBFZwjo3ujoksAJg+QOHl4vXrCRVCSxQcthhhMXeVyuNyNJyLJl2NS1S9akd5z
         NduoZdGwDIv5s73yFlwGOjK3CAJdqoZZ5sDdBCtY8e+nOtEW3ETEmHJuHb9J+AlCA0jc
         sJhdVVsrkQ6N2UWAz5zwhE4sZa7iOG2BT5pJzIQ1QqPPLYEKodgM8LdH2eNEVkRO0RFS
         R5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9yUDwreZVAO3aCgvkkcmjPsNpZ0NGYYbXQDmMvro/NE=;
        fh=dixpFNCZVxfxzOHxM5gyKeUQD2jNN8HaksYrghNk+nQ=;
        b=V1zE47bSu5xH1z3H2mHmWDyX6QiJjtbGc5x3g2KcqwgZcrYQqvE2aU01kBoBw3ncwP
         9Ts596aN3nHhM8hyNh6YFBB55UQH7ohWe7hcfLiDz6NZ9KR/60CrsLmrXc7KXww2X+SZ
         RChSOe3feLPyGkF5i/fQ5o/nD8+rHVmKJMhvPUI6qtZt+gePNFDOIIwPPTSCb+5S2HtM
         WynsiUV25yz6IE+09cxFfyMZLiilTAHPomc/6cFB2BjdpThOPkjtn593KKqCwuwn32WU
         gqFnIL1BOfpq8H/238006WsTlk5Z37DAGYWcg48udLms/s+L+t+FuB9hEeLERtQS5HNd
         IBfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774615163; x=1775219963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUDwreZVAO3aCgvkkcmjPsNpZ0NGYYbXQDmMvro/NE=;
        b=nZfPPg9cyym33ia3X5tDthwBqAVI1CRF+E/nPYenZQABTctGnlIDiSg7i1bzKgTOBF
         axmJNU3QlhD7/IfQ7beAiGjRCIv4p0KLt6Y6egYVRBZvTCN59pLxsUckc/5iavN7WXnO
         +1l+DoESaOYXaVtSQnF37S2iTFnnVbet23NW1EG282H5sVakuxtQ89aIL4O+96qZNyEz
         0IBYSbaXUR4IfkCaUu2D/845hwXrDaeRuaXHsnfrk86TSL65hNQEeZF/TAGm0xgUjhGX
         g6Lc4Tpnfl65om1rQIQlTqaUizpEQl3JsIp3n5kqKguSn35BSmP9H7vxPxM7ZHdNI0Zi
         Ke8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774615163; x=1775219963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yUDwreZVAO3aCgvkkcmjPsNpZ0NGYYbXQDmMvro/NE=;
        b=d9H+yUwNm21GjmThnWs23a1J0rA78ZeIN/PJLEj1QDBoDEHs5yVgixQhSfXcSxRUdM
         3DdKg27id9v8IQjoTwTawrZvzBgemMqF2TH8PBhUNm7L/2vBMhpm9TxAU4+RUl5xYfZj
         6nsY3qFTBCEzehTdk8tCGRJY3+x2GVGGKQi6/P3ggbIR1hTXWOPFi3vHAxAurfsK2BYh
         q6y8QIagi7f3IDFStVG2C+xB73p9pYuguPSvinIPTya3gG/ydrAUeW7JzQmJ4pSqypAg
         F/bRLNxAhX1p57MSf5ioo3vGRvttpzogV5JWdNUDv4eH/g4WXG5mVTRjpxHPTi0F/e/0
         2qCA==
X-Forwarded-Encrypted: i=1; AJvYcCWECUp7t4wggtSnzHk3lcF8NsxyMAmgnmU3sngbMHAlpev3bR2ZYQzBnut75eUgKmYzSnjox3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOOFsnFZ0wRoRkw3/lFfRQALBGTL22So66/t7bPzAR+WtQkOz
	dHBPQOz2SrUylUkSnlkMF4siMxrm0B+ibhWSaGYiTWBDbTEk87Wqb00y8orVtw6Px3g1uFfPW4T
	Uy2x6hMyqXoOfbSAWh2LT7WVveoBmtVo=
X-Gm-Gg: ATEYQzzscclfmDRdKkI6hWKgb4wG/P8UghQ3igSqks204NoB3GFU9w+YEz89LudYAtA
	ZPORP8JqfKGmk1GhPoE3c/QxCjDlx7N7X2/a69oqbDOenoECLf6kYnYhEv6wbe197qLM0278uBN
	ze/Z82YoXnPKXGkO57iDNLj/4ltKk6O1YDgbBSHjEvXngLyXTI91wFHLr9aUrImyifmS3sZoRBb
	jvLzdZoiX1eUpVp2XjfIZbMDYOInrlDmtosGQHWzyejNrfQd+O7C+VSmnAe1hHaniTIeuJHC4eT
	JAHO4u7B+4hxhEh3z6xYSM0cEHoHVmKrI1v9
X-Received: by 2002:a05:690c:89:b0:79a:62a2:b3a6 with SMTP id
 00721157ae682-79bde0b0487mr20276607b3.29.1774615163125; Fri, 27 Mar 2026
 05:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326021642.29170-1-dqfext@gmail.com> <20260326081304.xKa7-s_1@linutronix.de>
 <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com> <acZp3gRUqVIbw9yb@debian>
In-Reply-To: <acZp3gRUqVIbw9yb@debian>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 27 Mar 2026 20:39:11 +0800
X-Gm-Features: AQROBzDc-YGc2NLhX5E2vD7ZT3JvJ1z5OznSsvZlnQxdHln3jtYE9PJclSiuybM
Message-ID: <CALW65jZNi3oA7V7at_Jr5Vr4AdL03JYdA9WeK5G7cNr-XS2Bvg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] selftests: net: add tests for PPP
To: Guillaume Nault <gnault@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Felix Maurer <fmaurer@redhat.com>, Antonio Quartulli <antonio@openvpn.net>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272550-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 874A8344824
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 7:28=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> On Thu, Mar 26, 2026 at 04:26:23PM +0800, Qingfang Deng wrote:
> > Hi Sebastian,
> >
> > On Thu, Mar 26, 2026 at 4:13=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2026-03-26 10:16:24 [+0800], Qingfang Deng wrote:
> > > > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
> > >
> > > Oh thank you for doing this.
> > > I haven't look in detail but this cover the "invalid loop" cases that
> > > ppp tries to catch?
> >
> > By "invalid loop", do you mean transmit recursion?
> > https://lore.kernel.org/all/20250715150806.700536-2-bigeasy@linutronix.=
de/
> >
> > AFAIK, this can only happen with PPTP or L2TP, which were not included
> > in this patch.
>
> The problem was originally reproduced using L2TP, indeed. But I guess
> that it could also be reproduced with PPPoE by using a UDP tunnel
> device like VXLAN (like sending a packet through a PPP interface,
> handled by PPPoE, running on top of a VXLAN device, that routes the UDP
> encapsulated packet back to the original PPP interface).

Yeah I've thought of that also. It can technically happen, though
there's no practical use. For self tests purpose, I may just add the
recursion test into PPTP or L2TP tests.

Regards,
Qingfang

