Return-Path: <netdev+bounces-304996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46RMFLyXS2qrWAEAu9opvQ
	(envelope-from <netdev+bounces-304996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:55:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A80710238
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GCAHVPGC;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304996-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304996-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18982301EB6D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCB4229CE;
	Mon,  6 Jul 2026 11:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80E42254A
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:55:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338915; cv=pass; b=Cm9/vrbtyS5hanE8rp5eixDFpbd28fBb8amXQO5gRD9R7kkUVBbCtbZVzEbxQoSgRT6dXmGZCbS0QedBRxLcfZwXia0k/haC5EaGnt+X6Lm+6LoK6JeMRFFnCSwGYWZ50k6DTYeB9tmh8/DmFCPHW6as1I1hqykF6BY8plFUlHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338915; c=relaxed/simple;
	bh=oELiRmArb5ClQEoFheQBb03GBeALw9I3nDP+vOH+JTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np5Ir3o0aLXErttp94WkSi5PYClFGmypImj60ONXU3owAjWoLJX3wQ0s8vsHar2NoS4Kuq+LoOKfZHiKkXuU4ncO3BbJjU2ba13ha7eqbssH9asUzhbXP085CBSEr5z4an1AtV/TvFq/2Xlq2r/1lsP+yW9Wa57uHLRXozKbd68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCAHVPGC; arc=pass smtp.client-ip=209.85.160.46
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cf70de986so938124fac.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783338911; cv=none;
        d=google.com; s=arc-20260327;
        b=KNDkufPWJe8MnVwHyG2dUct73S4RD0F8veTvFr2TY3pFewuOm2/S9ykjKUj2fvbo+g
         nx1D4Re6B80LlgIEbrtNDQFwXy5XkSTEfgJVMLRQzh/yyoujQAVP9mqz4m1t424vjtYA
         RmVLlpHHFi/Fa796Tf8UrUobi0bXkKVWCrOhX8W0trxIfQcrkKcrjO5h4iUEaJRIKuw9
         um/bhbcUW4rR1Yr5KGhoNfKHO2wzH+7gklV4Dte1dqcWQnNx3jjotk0T8usmsK/96mdQ
         5dDnSFETsDnu8lR9vYxOwhUXq0WszLijP47clL5f/VNHSfcppgJkj8mbIqlOo8HA9WAS
         IQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        fh=9WTvPJl6UjoSPGMCrdn6j/wgYvHsQL+Jz0f5NbtWhps=;
        b=rpGF4WlcVroK1UyQVYZaEIhUbb3ugq3m90sY32UhCMheIFgkPJ+8pioF+M8GKGjTXc
         ThacvHf+1Y/dbu9L7+aprq7XZSuhvoTwpBA02enSxbwLejUsIErSQ7et6VAA6Jon9TwS
         VeAmFVzb7RiZotW1XIgrqwbJX8H9JV63H+ipUSnVYFf2+SZm5DYMlssTNJOsoQCadwA0
         cz28XO4vo1r2ELRst1keQ1WN1CnG3G+6ln6KWX8Yv55oZCX0P4DYGwtmCT8lcrl868sK
         2YBW58/P+mtf+8fuT9xCi51NkXHoNmXaljGJZ+5zqLba7vT7n1arwmc49UPECWm0JqP+
         oZLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783338911; x=1783943711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=GCAHVPGC/J2QBLFvoEQQ8w2XGA9ryMaslj9JRMTQQPgzqmLZjKwDv3uRJobdvnjtEo
         kdFCXznyOSb7t5nyRDIq0DIam5BdSZFMph3lThae30hNMJ0tSziYZ/jZD+cDkkpXa+iG
         9inbYf+XGttiH2YlgQBqLC/mtv2cA69MNtm6G8uHR1mZbB2MSxy4fzgneiJrYZK1Xop5
         fhEe39p3iwZshntVcn2WUW619NXpXr8QuaGnPZ2hrd5fVJskaKf5CK1OQ+RuemJMI498
         Zpd5tu4WnwbHgcHpVYmDbVccjBnXMMco8NstB+WFWz40xzqKdFEbQ/zJqelEQEnXUeiC
         5y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338911; x=1783943711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=edJ8Umm1VyFbzxlEVpCB7qCyY6w0ftByOhunI5K/J/Bk2PdXgIyj9L+em8jNEW7/82
         DmxEy2OI618oNYJ2qmF8kdSpsUz8KmcNDOf2U7peD6PzRaH5MTp2OF6mV8Ja+qLFwArv
         CGo1MXMriRrBdqRSgfxTaVIlmT+VBD4LwMcBSTsnfjwyAfOPmbBeYJs6gdZ4vCTDkHAU
         yKXLKOQ42/tGEAsGs+4aZKNCJf2nKyOdHrzSjpZiUFRv/o04GFYV/+UTIEH0PbuADFs+
         6CF1Z4t313MuNlGyA59uLvV2yp4Pv/m5Okl3rOLBUj6R53F3R+yu7ctMln3zgkDPuFtG
         mRfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpy1e57grd5QyylWXbpnAJ/Ke/SJZcHMzc6Gf2FljEZY6ggKG3JYJHhyss8Nrq4LBOHsiHM2g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOk4HVVm3PQ6aHO9YzUZbS/Eu8LK700gRimRXTKvjGc/pE9gQe
	4D+pM3A9xGzzJCQMAaUev+G7D/bfn8guZ/WXbUxZ6Iy1JAsaormkeGc5VihWq6B4SbZW8BUEteq
	1f0Gw9CM6khA0LHzJsRbRcdQQvwZJA+CeYNPzxuSh
X-Gm-Gg: AfdE7clLQaYALkONM4dEaXKhe4tDN6yIXJiCq53tOnW+acSdjNJXOPlirAH906BSa6j
	yGWRHiI5+J6vuZn4g4dJYLn4cC5pRxSYVBTe8oCxlLL78/v1CzMw+yOx2uKbjfoxu2lZYUXNl0V
	lgyD3UiXVzl247pMFRokCGqX+CXAwYvR4sRGoDU66v+fDEzUwXnjWyMSAG0tdsueVelGhR+zTK9
	n9nwdKpm1V/eDFqY6MmZP1jvRr9nR5VDxYZWFBgDHrjqp1RPxbK4AD/CSoIiyK3RInj1Smn9rNk
	LobS7CEUfRP407yJ6hSSjFnVtVuvJEQTud+rWY8bEfMa7ajaWDne3ufj78+Ni6f9V4PGhojOkoL
	6w4j4Ez8Fe5M87pfoSbepHc68QAk5W2aXc04hifq/IgOpkGbZFg==
X-Received: by 2002:a05:6871:2016:b0:448:84c0:fcf5 with SMTP id
 586e51a60fabf-45106080959mr17902fac.20.1783338911104; Mon, 06 Jul 2026
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
 <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com> <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
In-Reply-To: <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 6 Jul 2026 13:54:59 +0200
X-Gm-Features: AVVi8CeBOFPrQ1zTHfcvlgKLuME2AIe_WExrBUVuPzho7a99Z1Y55-T5aiUpW6s
Message-ID: <CANp29Y6QgCh5wc=O_B-qj-t=7f-r5XYWMnbmBNY2E7mSLTn62w@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: sgarzare@redhat.com, 
	syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mawupeng1@huawei.com,m:sgarzare@redhat.com,m:syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:virtualization@lists.linux.dev,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nogikh@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,listbf7b8eeeb8dda31d6de1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlegroups.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A80710238

On Mon, Jul 6, 2026 at 1:32=E2=80=AFPM 'mawupeng' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> On =E5=91=A8=E4=B8=80 2026-7-6 17:24, Stefano Garzarella wrote:
> > On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> >> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> >>> Hello virt maintainers/developers,
> >>>
> >>> This is a 31-day syzbot report for the virt subsystem.
> >>> All related reports/information can be found at:
> >>> https://syzkaller.appspot.com/upstream/s/virt
> >>>
> >>> During the period, 0 new issues were detected and 0 were fixed.
> >>> In total, 5 issues are still open and 61 have already been fixed.
> >>> There are also 2 low-priority issues.
> >>>
> >>> Some of the still happening issues:
> >>>
> >>> Ref Crashes Repro Title
> >>> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f=
4c013e25dc5
> >>> <2> 3       Yes   memory leak in __vsock_create (2)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0=
f8708082678
> >>
> >> Hi,
> >>
> >> This is regarding the still-open "memory leak in __vsock_create (2)"
> >> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
> >>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >>
> >> I spent some time analyzing the root cause and the previous fix
> >> attempt; below is a summary and a direction that tested out.
> >
> > [...]
> >
> >>
> >> I'm not subscribed to follow the list at full volume; happy to send a
> >> formal patch (with the af_vsock.h / pending_work changes folded in)
> >> if the direction looks right to the maintainers.
> >
> > Yes, please, a formal patch with a great commit message is much better
> > than a long text to read IMO.
>
> Thanks for replying.
>
> As we conducted more thorough testing and further analysis of our own fix=
,
> we found that it is not as comprehensive as the existing AI-generated fix
> provided[1].
>
> Could you please let us know if there are any issues with this AI-generat=
ed fix?
>
> [1]: https://syzkaller.appspot.com/ai_job?id=3Dcd978d21-2110-4f57-9525-d7=
d91c4a7e02

I'll chime in from the syzbot side.
If anything is missing, please let us know :)

Otherwise, please note that the bot can incorporate code review notes
and, once the patch is ready, submit it to the LKML:
https://github.com/google/syzkaller/blob/master/docs/syzbot_ai_patches.md

Best Regards,
Aleksandr

>
> >
> > Thanks,
> > Stefano
> >
> >
>

