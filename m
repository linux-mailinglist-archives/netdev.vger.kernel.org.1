Return-Path: <netdev+bounces-270699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEPqMJqVwWkTUAQAu9opvQ
	(envelope-from <netdev+bounces-270699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246B2FC56D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 838AF301F6BC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071C3DA7D9;
	Mon, 23 Mar 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="J0tBP9BN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE293DA5B0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294422; cv=pass; b=n1B0FEGl3BXs+tmjPvXiVzxK6KTDtjXsgYHbRizYnO0gBj6MjZv84YVjzzj07vpoeCmXTMB4+vURCYep6SGxISGmvbD+e95+8cYD4iRZ0Kkj8k4ykf8AKxmEJo8TlUUBXjoLRoq08DwIqvd1bvYd5w7AuUCOqxiLCrFd4XDu2zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294422; c=relaxed/simple;
	bh=SBDn3cMfN89fQCvVMptCFDYgoBA4Q8cc3p9B/aVozMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A105E2aquBFSzES5OOLWdkDxugT3jJjPzH1ADdyXGyAIE0j2s0zGaoueWy903/oAWztJ7U00zD65zLQ0yfbyxy7HXcn6lz2So/i99dN/lPeu2x+MsshY5qPDleydqDKghxsdKXZeNcbeigoWKMypjGGAAGnyUdqKYdde9MvsHvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=J0tBP9BN; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8296dabef74so3847302b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294416; cv=none;
        d=google.com; s=arc-20240605;
        b=AnEyzpCUYidBtk3na/c4M43yC11ippNHEx0M/IEQegEV8663ZHL+ksnaKAyyFKKXUR
         HQAWURn0JfOq9AI1Qc2eqIsV7PpqJiUz5Z7hg+gWAwApH2cARi2xc92hzGcwcxGCK0KS
         imEYLXFOVB20x5Z2WkajIBExWXbgiKm+9jKGhINaxM5HWKLzrR3obzh8X/BS4jqUioFt
         kscklUe/mWY11HRkcHTvzQ02XxdkIIfjBTmSUpbtzwesU/Zz247gKoPoa1i/cmaunVYd
         vi/dN3pRKRswgszm3ENtMP2b3A4UHXeJ8WMhJ5Eo8MibfiJ3SyY3QLpG0a2YG7m4P0+t
         GtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jsZ0Ne9YohMirxnBGUDAnMm9ZjETUNRVwpxbQAd0PjI=;
        fh=4hPQTJ6zwbT5WvXzPx7ld1OsCByUjuabpDnIsXMyt4s=;
        b=eNGhvYRPe5h/YiVU85Ln3mnTq977rO/3skneABVKZGjlySPNgqzvWUMFWdWQ6QxTvd
         ycLsIB4D7r64Ru0UOrFi/4GnMjcsb1dS4TMfJ9LuJs0sfMWz9ImQNSkFu2ES4+7FF4HH
         qbDLzJPw5jcEs7mVO0bZ98GnkyrvLNEyltQgRtrvHyPGz1PVgwaQwIZ4nISINOHf1rvc
         qrPArM60TimGgXMSIctp8KNXOEnBkHO77dPeQvX3QWytC/NvhVRdOh6ZT2nIBpaZtI/z
         ZrT9Jvb5HmfbUt5JWdYhAGWE4ksrK2Tnsc+mouv/XUegTA5ZIvIMQxfgvaeEY4CRvEdP
         LLNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774294416; x=1774899216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsZ0Ne9YohMirxnBGUDAnMm9ZjETUNRVwpxbQAd0PjI=;
        b=J0tBP9BNx/MYi4wLJdScevAHNH3Y8kMKPgHO9Kog26TWPtA1aATUZCfd226yjlRHhB
         8G4dLcQCu7HX0bMfIxsmpETgVTVUlbydw7IcLc7tQzYHehyHbZArAIEBYvz35CbkNfUN
         quap1y9MT+21FwoC7VhEz/y0l9m+7c6BUp8oI0A6XFqlL5tveHnq1JMz41rsZhbVKsh+
         VcQfzfmMsck50v9JM8VYEaGEENl4aIpJSOehOGkYMppptf70SXGQg1cbRm1vyhCHooTG
         IhFWAJ7kR+etnzyua3NuGISaf88tbK8/XLt0Ri0jOTbOZFvf6i+ZU1BSvV9Hxmgzy5ZE
         CCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294416; x=1774899216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsZ0Ne9YohMirxnBGUDAnMm9ZjETUNRVwpxbQAd0PjI=;
        b=TF6C2u3zym5R4K5c/PCwRqUZy8ZOq1DNK6tFYkR6Q2gN2rYlKl6A+EiNcwxIXwc6o6
         rj9Im4O/gNSx6oPT9wLWOiW2/pWun12G4RIgurFu/5lNUT9o4WbWFoGAVTo94hSg3AJL
         lP0iKPkCKHe6gx62Vt7ZVg6nHedblbxILBnhCPgjr2nCGok4vkAWZ9QJ87gs0neobQc5
         1lNrIHcnu3y/BEt/c12jNbBp8N/ih6sqerInw5RTxAEyiEvg9NCsGML2IiPTd3DJ8ny9
         nAxVWPk/NxeKRiVZ84OL2FyFu4hSTbIobI+lSv7dSj/bnDla84/W1HLknS7+Ax6Y3ren
         27Lw==
X-Gm-Message-State: AOJu0YwOimITu0uCO1VHf/wB8MhAl4Z8P9m+VrK5rxuuhVgKOHqnzM7T
	7NGJEqjmCwzsE7TRGLGIqGMKandhVLsDwTdPWlyNi9scCawbjyzNot9kOGT0ZkSTBHa3ROouksQ
	oWEIZloBKfV2JD6OaNupzUSLtfQYXa5m9u9hBQUzR
X-Gm-Gg: ATEYQzx+tSm8JtNzB+UGo6VfWoZt5QKtLKi30ut5oqmVLUA8suqYrKC0xCXmN/APgIK
	yCrdFOkMjBUGQDsO93xWibx5TYRQy7SW/S8XiJrbgQPc6KbPSmXt7h5LJqI+ObXCI+dZtH7fAli
	1ie51kQZ7JDaw1rCmO/R3n5/Dw8C7BfMjBnndbi5TRRHRiiLEwwx+Lj2FKJpZmLYtiw6vqPpi9U
	9zgYuSaCYrp8jBYl6wephFgUntmS5oFwmnShFaTiwxsmnm8SLOkRDnC/rv+HbNhdRdaGOhKjEgY
	Fy8+PfCm5IFEdN23+JZ8uJekwg==
X-Received: by 2002:a05:6a00:1399:b0:823:1c3e:95cf with SMTP id
 d2e1a72fcca58-82a8c234f4emr11028712b3a.18.1774294416213; Mon, 23 Mar 2026
 12:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260316211052.332383-6-jhs@mojatatu.com>
 <20260316175705.2ef5004e@stephen-xps.local> <CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
In-Reply-To: <CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 23 Mar 2026 15:33:25 -0400
X-Gm-Features: AQROBzCy7gIuziKEmN4mC7CRB22ThDdH9s1im7kEWjHnmgQOUyFS7QdEbw1gIuU
Message-ID: <CAM0EoM=o23jUcFjaHABodMZd7aimEpFeWuuNFvzFL8bh=mV6Eg@mail.gmail.com>
Subject: Re: [PATCH net v2 5/6] net/sched: fix packet loop on netem when
 duplicate is on
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, 
	savy@syst3mfailure.io, kuniyu@google.com, toke@toke.dk, 
	willemdebruijnkernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270699-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4246B2FC56D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 3:34=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Mar 16, 2026 at 8:57=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Mon, 16 Mar 2026 17:10:51 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > > --- a/net/sched/sch_netem.c
> > > +++ b/net/sched/sch_netem.c
> > > @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> > >       skb->prev =3D NULL;
> > >
> > >       /* Random duplication */
> > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, =
&q->prng))
> > > +     if (q->duplicate && !skb->ttl &&
> > > +         q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
> > >               ++count;
> > >
> >
> > Would prefer that if ttl is exhausted packet was dropped.
> > Rather than silently not duplicating.
>
> so return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>
> Note, this is a change of behavior, no?
> Actually - when i was looking the first time the bug got reported in
> my view the bigger issue is when
> skb_clone() fails (which happens nastily when you have that repro from
> William). Unfortunately, the surgery was too big so i gave up.
>

Stephen, can we leave this part for updates later? i.e lets resolve
this and improve after....

cheers,
jamal

> cheers,
> jamal

