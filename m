Return-Path: <netdev+bounces-305176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DuNMHaL9S2rveAEAu9opvQ
	(envelope-from <netdev+bounces-305176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB4714D39
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=My4tYYoU;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305176-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305176-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BEEF303817F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336838F249;
	Mon,  6 Jul 2026 17:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073202F7ACE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:33:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359187; cv=pass; b=qCXUJg/rKWXm6puRoU7/9Wxr1g6kBhRHJ20lxMZIhxpqWts+KnCtEL4Ko8R3aTW/zh119YnzkAF+iwFBl9zt2EvxJFCqcdwZqHHKISkoi0bW87O4YLB/t8Tvckb8g19ejkoQllW51m7zokJMhDJaJ+MeTourobjunrQitiKkD0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359187; c=relaxed/simple;
	bh=Gszr93hydq2zURZ8hxvOjO4dpL4R2clkfiRdevZOzMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArSKJBFYfvphUtbDBr0LTXR+34ecrCUmFr3GMYXRFQmPpLr1C7ETaV+kkXVPTWCSZXk+BfXsgGYYMsCv6kKWRI7V2vx7kPw4R/Wv2xbczFD/+qlVqZL9PGmxYtM61iXrEPoEeabQxyPRf5RrCiN5HFRJjgqCjKcz51LU5+yjDHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=My4tYYoU; arc=pass smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so30507505ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783359185; cv=none;
        d=google.com; s=arc-20260327;
        b=acUt51SRQZA/pCUow6mPqj/FMuYSLU9gPfqG4Cy3T7aombEGMqJt43X0vd2vN+fOxr
         72e+NeHXzYojx3TlnTb0/+d0kM2RTE9c7WfD6Cw8L1zCBYseUAdZBLDkvfLoQcFW1XCY
         rQItKpLWqU9dx47jS0f93wlMUfF5U67CavI6lftqYtoM7HNFC0mwhKnOkAp2x5E4buWA
         Hv2o8vlhdKskzFQpcBJw9WLPFcmkyh6SkEUE/MdMmkQeiv87PKFHqNSz2+/+3HyR9lk/
         IwOVy4nFOBZfl560dX9Oup2slma6rOJ06AYquM7vWEXArFbwM2izUs26yDiZRMY42I93
         RRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AIaTCMwhaTmMiCFgck+oUystkHONXu5O575YjPFEpPo=;
        fh=UXXlvJ5ns//BMDUiBmwlnJHo70rCwIZs3pUpmj4JNM4=;
        b=APZo469kp0vOiFjfifm9xhNIVyxOWPsFiygtHc8OXf7I3nCm28LWy7zzd3IijKfLmH
         hVSfaPeGBmfSiK6sikt/i6SN4cQYUFNIH9UnoZEGElftDMCDZggsKarLhAWCh/teqnFX
         +L5/+l1tsmuvgHd7oeolcF5RIf+s5dINop0bwYjRMu6sG6cmHAWdfnTc2tU3Oz/GpVwI
         l54WQVeLbJ36YD0Xxaah52hpJfZYOupoPZLEP8cD6SVaSIFBhBQh2yDMuHa+5ri4RJQP
         os9eviQzrYfhdfLDmFw0+C7e/SuJ3YjtcUHruUlVrxaz7ZoDkVQwxwuBQ2GHAy22jMKG
         Ic5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783359185; x=1783963985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AIaTCMwhaTmMiCFgck+oUystkHONXu5O575YjPFEpPo=;
        b=My4tYYoUySs2fAeSzsNPwPRyfmPxWw7s2uOsX+8bIdwZfVpKwBqKc9h7p2YYrIjXpY
         fy3oD8xeu6PUVWW8RKtM7A60cSvYPtOeYL2LEA1/g8iQzt0tcfym7p29ChqPyAMzEiG6
         z3H8eJL8qz5dV00bKAh3Dn11lUAeq2FQiVyE7f35dDUzRDY/okbyyn/lHUyNfv3zQm3D
         R1v2AUocoWAaM/jDyIRPEA+NfBUxTOx1EofAzlKZaU8a+er7YkorAa2DeCb8zQH+Rfmu
         OdV1M184StHc5fgc7/996l1yQWP4tV2cGol0OMTDzFPqc38SYlbcu8Fjon9VboxBb+V4
         +i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359185; x=1783963985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIaTCMwhaTmMiCFgck+oUystkHONXu5O575YjPFEpPo=;
        b=SxMTLjtB+6TpGuu0dh3hXNBGV7YnsP0kUvvKp/F/ZPpueesTokQ433UmfGjNrT6xEh
         Om5vW/gIujLyfpsK9A1ao47YJF6Csjw7f8kcxF8XT7xxb925fP7/d9+DG/iqUjVAc5Pi
         ylIQsPOekYk3fpkyMh4PI39AeYY/P0LOIKUpan/kNFDidkyJNpdACjlypSEiSjGqAb/j
         LuKN00eBQfngLIanoZq65KvJjTW450g1hA9Mk3zHxo9Pi3CgFIclA8t71bOspZBpF+S+
         Ml3boV1NYMtdnH+CqWYFDYm6QVjmjEWQ9Ai4qasqObYyMa9yJwaen2z1MgTiy++wHcv8
         /Ifg==
X-Forwarded-Encrypted: i=1; AHgh+RoC9AbWfHUSjti0r9Ijdn96XTdJmtvMFQa6MZwlIQmcIZdHiRp01rRPHu8L5kaNq+GbzXrbcgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHByDXiOm2tfd5098nOYOFsKbxJMJgb5iQO6bd6MzJBbqWKulZ
	A53Bu9ehK+TNs98Oc1q+DnWxDpU8TpkcDIv1FFNXeHnOGisn7CvWrMC5R4WogWPgEJONR3OGOOi
	8ScPTMdgVL1Btbw7Eub7/sdClgzLDQMBlqiQqStrV
X-Gm-Gg: AfdE7cmDAlP5cUPF3y6oSf5pPnFs1NSOiwJzdqGUdxJZ1CaGvTLJf/8Gw25o6pAW55H
	oF4AxDIspGGGvOeWWhAe1kF5ETYj5SWyxr0cX9KIVRffCvYw234pRqEJxFpkBwv6qn1XfMFu/eD
	BKie/qLtpQflw1EIwuwSTXr2kLX/0oKhXM2wEzWBcEgS6DPyun6OYflUJxs4jz46sY5GuZymwCo
	qA4WAaWeUUZkDa3EsKStE2lefmm2OilT/Z76wY/1rJpx4jEtexWSMLcj0+MVugpzk4U4OjU/gX0
	L4gpAa/gcMXoy8QRtgmZqispD+8r
X-Received: by 2002:a17:902:ecd0:b0:2c9:c517:d078 with SMTP id
 d9443c01a7336-2ccbf04a1cdmr15876265ad.36.1783359185403; Mon, 06 Jul 2026
 10:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627024023.2201160-1-xmei5@asu.edi> <aktHvEy7JC-eGClA@secunet.com>
In-Reply-To: <aktHvEy7JC-eGClA@secunet.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 6 Jul 2026 10:32:54 -0700
X-Gm-Features: AVVi8CcFt-NKVDNuTspmjXJLOce2jxmyZbjcNqucMFdCorfxeTNxbOmra_f3IzY
Message-ID: <CAPpSM+QELmdaYADrxfuvAf8qSfDS5qrYFvLq5jM+P5NJ5Por7g@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305176-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDAB4714D39

Thanks for your review!

On Sun, Jul 5, 2026 at 11:14=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Sat, Jun 27, 2026 at 02:40:23AM +0000, Xiang Mei (Microsoft) wrote:
> > From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
> >
> > xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
> > i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
> > rcu_dereference_protected(), stores NULL and dst_release()s the old dst=
.
> > That is only safe if no other thread modifies sk_dst_cache concurrently=
.
> >
> > For a connected UDP socket that does not hold: the transmit fast path
> > (udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache lockless=
ly
> > with an atomic xchg(). A per-socket policy change racing a send can mak=
e
> > both sides observe the same old dst and each dst_release() it, dropping
> > the socket's single reference twice and freeing the xfrm_dst bundle whi=
le
> > it is still referenced:
> >
> >   BUG: KASAN: slab-use-after-free in dst_release
> >   Write of size 4 at addr ffff88801897b6c0 by task exploit/155
> >   Call Trace:
> >    ...
> >    dst_release (... ./include/linux/rcuref.h:109)
> >    xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:225=
6 net/xfrm/xfrm_state.c:3053)
> >    do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
> >    ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
> >    do_sock_setsockopt (net/socket.c:2368)
> >    __sys_setsockopt (net/socket.c:2393)
> >    __x64_sys_setsockopt (net/socket.c:2396)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > Reachable by an unprivileged user via a user+network namespace.
> >
> > Use the atomic sk_dst_reset() so the cache is cleared and released with=
 a
> > single xchg(): whichever side wins releases the dst once, the other see=
s
> > NULL and does nothing. Behaviour is otherwise unchanged.
> >
> > Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket=
 policy.")
> > Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
> Applied, thanks a lot!

