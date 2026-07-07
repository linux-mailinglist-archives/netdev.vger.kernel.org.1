Return-Path: <netdev+bounces-305562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUgNL9xBTWqfxQEAu9opvQ
	(envelope-from <netdev+bounces-305562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833F71E84C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:13:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=daNzldlp;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305562-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305562-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE9C3021E4A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1053E556D;
	Tue,  7 Jul 2026 18:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180E38A701
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:13:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448004; cv=pass; b=GPh2MoEDMeZJRPGBaHWjWTRvbWH+3xhfCmx0qDXtyDE6zLD0wsj751yEUZFXvmKJHa/alsycHt5ptzHcgAiZ4dNUDrY3WPmXrbVMA/4MZ02ZCRqf9rWhgIEc2wTj1SYJkwriasE3BmviLbNQjv+6NxPQ3947LMzOgmuyb0Gz7TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448004; c=relaxed/simple;
	bh=xcHE9ULfGkwEKaMeTRmIaBfzY7ZG+zHhinnTfulb5Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/aV8Ysip77MA5KBGGJ4pKypQhsjoTBLEIiRp6RwlVJRhSHsZNcRwP4Un9Qw3PI648TSxcfdAXU9uDUab3FKYZq/qYu9TFs+eNNqGcOBnkKzTy2RyvlkvcPFmigRAePAWhQo4JKC3LrWWtJzwNxNdruejBv3a5pAMWW1vBd2HlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=daNzldlp; arc=pass smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381891a9525so4302380a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783448002; cv=none;
        d=google.com; s=arc-20260327;
        b=VLDG274Yuoy7X9gaySinJR0ftIjJpHKyUMTToZHSIAEpHfGMAXYq8LbtGS61Wg3JdR
         oggdmYbgR1FNRX110ujn6R1OGTxd45Fht4PXATIv7dm1WLc3HsvRMBsUhBBXkhezOf8X
         tjP79jFg82tB8ZQD9iLp91rZ7/R7veyA0TTcH0JyFOQSnOW/DBoLQCNdE7mXYwUH+kLi
         mhwstoNru2i1SoxZM6FuQgvcpBNmg7nUaXIo9jMZH9tlX366qbE/7OfNrbZVO5ChHacc
         GH3ttwC+B1xyw086A7UDeTxVcP9noW4hhpNxU79kHOOGnozk9xm1BXY/XuUg3Z9uB6RH
         cfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01TtGbBmyKmgPgNfEk81YY//dKq3+3v2yu4BgmeRT5o=;
        fh=LEomUYjF3ZSeI6bIEsXfLR/fLhzkcERXHJrx7JiXcuU=;
        b=cl/SslO3SAYCF98vYqqyTcvnBUa/PQB/QuCYUEwmSZz8n6kQVR1FYOG9f/86PwyBn4
         B4IWsVeooWaMWa1eW54FIko1vIJ34sKiXnW0mT8HCtCIiCCtunqoqxxWNAhB65A5ASiU
         gotn2c3x7V4YaL02NakSsExS+iha1u2QnspozK10yjo6I+yQX1cxdR9q86vgtv0Qdd0R
         2GuYZwJH1+rIa+g8IRAp5/lhMKdZ05J/azXdhMOPopujBzhKdI1ZaJgOeWtm32/N0Fcs
         /zpkMQDolo2WJXZwqMu+/szqPytv5STdt0okzfg/Wtwuy3KVLEASls8ujk7dGxD/9hf8
         RMNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783448002; x=1784052802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01TtGbBmyKmgPgNfEk81YY//dKq3+3v2yu4BgmeRT5o=;
        b=daNzldlp3gcwHtO+USomqrFeONXKnRu8HwrtpnEDT/UnbHWAJOlRf26AFY5XN2TG/A
         GbftDP+8KupIU5yOXHpbtcpWPBdic4QsqVnWSF0upu32HS1vsbkGUC+KdQGTQMkYfDVe
         Uhsj6iQZakWcbysGTqUhb1qO+PFcM/idBgxRpArqeVqjXpWSUlbCDn84jfeIny6MZadh
         fVJgZet29AcHLKTUdRqHz5Kwg5bI2HEMJ2fDDZgPTdCeu8DnEiBXaU7pMfWyqtIfTfsw
         kSylp29NhWkz1aEEfvaARDF0RzZFuHXz8uvIsh/FkYV+c0OpDu9/MyHQMR2Cw2PNTzcT
         FJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448002; x=1784052802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01TtGbBmyKmgPgNfEk81YY//dKq3+3v2yu4BgmeRT5o=;
        b=PTJM5knFvS2lGI1TnFTrmwntUfBxwRU/6PNawajId46POD1o2qlAveilzYi+E2xGXE
         R5gHRNXxGrNfhvSvxz96tc+t1Qj9TSoPwPlQdjruwWosPgqHxXW6goupwb97vfruJ5wT
         Z0szcdIHhejNlEIyShsl/nkarwHla2uDR9WqhDRQYCyc7UIlITq8cR91x08kdaFLuSpv
         le8HKU2jhAvUnONiXso7E/3BsAkyJX79wCy0mZN2okqpJ7ZtfNffmy4t5slN0ttOiiEy
         0iRSOXdTW1oGeRH2dPjUwT/APwrwIsusaty2pd3BQRDtu95pgbQSWlcrr25aO/Z3dhJo
         ijfw==
X-Forwarded-Encrypted: i=1; AHgh+RrUNwpC+vSP3doAriPFsb2tUf9JgorhECgVJFtDS8YP8Cx+WoH0pEaSuD2mUOtaO4QLlltHYjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4ycLFdEYvmu64mzTHQNNFHViLXsZWM1BmLdZ4SCCZAARsAx0
	DjXCkonuEV/CjbImaAIxZbQFR3HZ6KFFQtHxtYiapLGsnAkmFmsEnhRc9VXVObtT0X5FcMu+FDH
	89ZZujDzQUkDnDU5rjqudTvzC3Bs3VNVUQz50LzQ4
X-Gm-Gg: AfdE7claU+BMCL2qv6ZTtm5pn2sXAEE+jCIUq4sX0wClP2xXD9Ei/68zXu+BxtkcAiU
	d2uYyjtJWACvhrZoBJX8+5hmB9iS4fn8mdtTk3mcbIM+4YmyIYAA2jZs09IuUMy2c/DyJwffBmP
	6csMdkp5LTJqh3cfwd1NYZt2Bmkbeg89xOR1rGaBoN92kWOTdQk1KAajtImO1NpUz8G8NmBy63u
	QEdpz0OCkJWq2t+G4QVT0m6RHTD5ccSh/S90iPVUDSpZ3Op4C/iXCa3Xqw3lOJSPacJfmis6bhq
	b1gg/qwNDK1R2UvLgtj+JWxkdZ4g
X-Received: by 2002:a17:90b:2dc4:b0:387:872:7b87 with SMTP id
 98e67ed59e1d1-38755b4c8c7mr7216137a91.13.1783448002582; Tue, 07 Jul 2026
 11:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703051932.966884-1-xmei5@asu.edu> <d6cfd7bd90001af215ba456ab81404a60fbea1c4.camel@mailbox.org>
In-Reply-To: <d6cfd7bd90001af215ba456ab81404a60fbea1c4.camel@mailbox.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 11:13:11 -0700
X-Gm-Features: AVVi8CfBcY8HJYSoddoYXCtS6N0qJAzRWQlZncCamSTa9xGHepdNu99C5mKUv2Y
Message-ID: <CAPpSM+QVL1bR-=m4xf8AvDQbJCbDx_x3YoB+r6hmBjyDyOBPBQ@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before
 xfrm_hash_rebuild reinsert
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: fw@strlen.de, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:fw@strlen.de,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305562-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0833F71E84C

On Thu, Jul 2, 2026 at 11:19=E2=80=AFPM Manuel Ebner <manuelebner@mailbox.o=
rg> wrote:
>
> Hi Xiang Mei
>
> On Fri, 2026-07-03 at 05:19 +0000, Xiang Mei (Microsoft) wrote:
> > xfrm_hash_rebuild()'s first loop preallocates the bins/chains the reins=
ert
> > loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate or
> > fail.
>
> This sentence is difficult to understand for me. Can it be simplified or =
changed?
> This would help a little:
>
> xfrm_hash_rebuild()'s first loop preallocates the bins/chains which the r=
einsert
> loop needs. In this case the reinsert ...
>
Sorry for the delayed reply; I was on some task in the last few days.
Also, thanks for your review; your rewording is clearer.
>
> > But its guard is inverted: it skips policies with prefixlen <
> > threshold and preallocates for the rest.
> >
> > prefixlen < threshold is exactly when policy_hash_bysel() returns NULL =
and
> > the reinsert takes the allocating xfrm_policy_inexact_insert() path. So=
 the
> > loop preallocates for the exact policies (which never allocate) and ski=
ps
> > the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
> > reinsert. On failure the error path only WARN_ONCE()s and continues,
> > leaving a poisoned bydst node;
>
> what's 'bydst'?
>

It's a variable/field name: policy->bydst, the hlist node linking each
policy into the destination-indexed policy hash.

> > the next rebuild's hlist_del_rcu()
> > dereferences LIST_POISON2 and takes a GPF.
>
> /GPF/GFP/
>
GPF here is general protection fault (the oops), not GFP_.* (the
allocation flag).

Since a maintainer has already applied it and these are wording issues, I
lean toward leaving it as-is unless you feel strongly.

Thanks,
Xiang
> Thanks
>  Manuel
>
> > Reachable under memory pressure,
> > deterministic via failslab.
> >
> > Invert the guard so preallocation covers exactly the reinserted policie=
s;
> > the reinsert then allocates nothing and cannot fail.
> >
> > Crash:
> >   Oops: general protection fault, probably for non-canonical address
> >   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead...]
> >   ...
> >   Workqueue: events xfrm_hash_rebuild
> >   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
> >   RAX: dead000000000122   (LIST_POISON2 + offset)
> >   ...
> >   Call Trace:
> >    hlist_del_rcu (include/linux/rculist.h:599)
> >    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
> >    process_one_work (kernel/workqueue.c:3322)
> >    worker_thread (kernel/workqueue.c:3486)
> >    kthread (kernel/kthread.c:436)
> >    ret_from_fork (arch/x86/kernel/process.c:158)
> >    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >    ...
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhasht=
able")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> > v2: fix the inverted preallocation guard (root cause)
> >     instead of avoiding crash
> >
> >  net/xfrm/xfrm_policy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 7ef861a0e823..932a313b9460 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -1329,8 +1329,8 @@ static void xfrm_hash_rebuild(struct work_struct =
*work)
> >                       }
> >               }
> >
> > -             if (policy->selector.prefixlen_d < dbits ||
> > -                 policy->selector.prefixlen_s < sbits)
> > +             if (policy->selector.prefixlen_d >=3D dbits &&
> > +                 policy->selector.prefixlen_s >=3D sbits)
> >                       continue;
> >
> >               bin =3D xfrm_policy_inexact_alloc_bin(policy, dir);

