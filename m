Return-Path: <netdev+bounces-291095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIVwMkWaEWpSoAYAu9opvQ
	(envelope-from <netdev+bounces-291095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF25D5BED6E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0631130142B1
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED93939A6;
	Sat, 23 May 2026 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="pV91tkVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F22D1F44
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538414; cv=pass; b=lSnb6l/We1QEmUAgRcgT4AmX/TdFTSaeII0RSgzb9kc1JuEh6w0QLaMfwrc4RR1AIuqd6H5YVLFopKfjdMvxTB6orkBzga5tYMB4KO2ph+Q3RctR7Cn8BgA+nXs8rAqyfy9oE/VkVI8/fsJ5j4LnrE7iyJGfcZlfx35wJCEJHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538414; c=relaxed/simple;
	bh=g787+IrTsL04agteFy1OqIDr1dENcmPXSqA1tlUW5w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB9Zmvj1LQ876ZYb9mZiTpH/1NiMHjhWtoxB3RqxiMXtJ2fks7QWawt0bVn8X3ZOMMxIXMgrojN5ZMRpjhbHIj2HgG+z62c4ubRqodaFyfzynCfzKUBpc9xx2XVr/CSExK1zNx7aly6NmWHAcGf0LBxLEwKZPulrDMMNUReeYqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=pV91tkVT; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc85eda6b6so41426755ad.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779538412; cv=none;
        d=google.com; s=arc-20240605;
        b=On1jH5ywh3+TfrUC8yzDy1BiYPdgxVnqNP5pZFyBfjGoM5VORCI1+KAJu1NyQo+5Nn
         35PG8IfgZTh+am6M1YV2aAb+fKsxCziNtWj5ZKvdErMi6xVyy09/cx6E8dNbY0YfUxp7
         0mkXzEiWW/8AZ1fVmLIqFPukNgVONwruoJkN13kcM0b75hqVW7p3PlrQeU0Ux5S3kUH/
         xd9p0v2eVqsNvEeompoSlD8nr6CDSl2hlIPF4qRccQ1EI6ksj9nY0tyAcfvZMXcrscCU
         z7FNKg5Lr5qMXcyPYOCNTkZ0WLfX/WMuZHYULWsBRJa6hLes+HlQxe277RzKcmaXb0at
         KaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkf+ZHIOQ5Na0Efl5ED3kTp/oHnZd4lHm/JOB1K5HIM=;
        fh=fVa9chMR1ImVsChOSmhEOkAgywSqHq7+zwzGiYV3tDw=;
        b=Fx0jgR9ei3xDPFV6ckVrU91gtyfb93V7faicmL0AOCKNF96ZAy6EN6DgcGtM3z6Hh5
         AfrE9FsP4mZl3kBe+2VRORKnPcXTd5kB6185ZTLZm4uHLONDrw1lTy0VlrFz84Yn8JRH
         Jn2WfOw1tNSRA7bwLHz2Ieb1Zh1OIiGdsQskFgbNf+QzK0f0j+pdnfe4Xn4r/GZvvzar
         JOkfXf4vqErtGKx9PcphzlyYYdeYSps/mfJj2aLegKUUOG8eJHJpxOral+1KwuMbePQw
         CxNselGSfTXpGDREG85WmcerPb2L/r+b9oxHJEOc0fmmXBOJKmDBNQorLlz9sIvhyGgo
         pWHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779538412; x=1780143212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkf+ZHIOQ5Na0Efl5ED3kTp/oHnZd4lHm/JOB1K5HIM=;
        b=pV91tkVTbTw5hxmWWxrPrxrIn3uOOQZaZkq6a8u1dlXhgs1SBKcBymeQVcSFf3OSS1
         C1fX37Foxr7NQYVPdTNJe1WjA+DbEJ+azuLNo/iJSgwwgiEzcPJdT2D8V6SHRnk5KQgO
         mOoxeQXQPiBghhgluNr1eAB+AWsVSeFfpupqVIdPqcIjZX+fvMiCKqizva9So5FG+ho1
         t7h3TsTz8ab3Ng2nrzREuZ/VwKAi0NM20h1qa1wfEneRMTYha9cGDmSe3DP3xPs5dLX6
         lxj4j9LNWzNIPM27aR5uNegRPXkwBrT+athNTmg/rMs6OXujmaaz6Xw+CvzVkZU3z5Qo
         Nhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538412; x=1780143212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkf+ZHIOQ5Na0Efl5ED3kTp/oHnZd4lHm/JOB1K5HIM=;
        b=PKKjDcFnhFXyBl+lGPzdkVaXyUaxZVCKEVIZugtrf+YTTO6A0UB7eTA/AIBugewBKH
         8etzNxy+YjkWrGITfvUUxTjCpIjHFH45gDiwYKjCMLMg2QZJYtW/a/xu6JzwnUGRSRYg
         33D0mJQzm0ON8CeoUgOoko0Hls+0vP5/0hk6echdBKUH9VReRdv0Fw0eU+hlXev1GXes
         LaiVKvbJDQZJaCx6m7nvITIkSEGm5boG7//+x3P0BySWqERo5HBz3qlNl/X35rz2vsbj
         9yI5SKg0ZStSY3DCp5nYMKh3zY8q453Psf6vJ7GpjsG5J2YncGBLvJugfItHLP8HVkYv
         cCWA==
X-Forwarded-Encrypted: i=1; AFNElJ8hGb51sff3lgAASSxAuhl/WymslyK2joEXyl2ZZgQWTJotgZdPRla5sl8INwkh1nR5gd/wdP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVmNn3/89GhSzOco75b8COJCgn9AhwFhGgH+p7g426w6qkXbV
	ZAUHDHJgcayBRVq2M52tdAAb6SwisUrP4RHwsZml4ecEDjohXCmJlQ1cW5IWFcbuXGiWSpSURJS
	FPdAZnZUYiNKOThrQXyCjkPx7tmWr+vt6Gr9/h8EE
X-Gm-Gg: Acq92OG8Eju1FRgJeamv+W3jDYhHigK00WxMI//c3bqB5JXKMW0hPDkSENqdmnZbNUs
	SfZOGJaDXuDVJjpmXj4c9CABTcFfU4sPv6GX6mfe9smfI4q+W+Oje4Z/8YqdnfI42x5Oi80FCih
	JBrrUkh+I8tmOBbZUhnVYSmX2LWAq2PCJxbjYkWRntJjx8AHrOmd0+SRdG3G+Vl02BzigU2N3ti
	Mlfr4xD4tqBmToiLuTGzSubpHQkxfSrd+cIRCk5KCDQdvwxljM95b1niQsF86snMrtWTw3WR120
	YBkEEpkFPcxSp3PZLhf+qeWAqfXbBw==
X-Received: by 2002:a17:903:2ece:b0:2bd:93b0:2c1c with SMTP id
 d9443c01a7336-2beb0347067mr91017265ad.3.1779538412146; Sat, 23 May 2026
 05:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org> <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 May 2026 08:13:21 -0400
X-Gm-Features: AVHnY4JeubZZ-RwtQKbN9_GDgW3J9bc1ph2HrQSZTkonFPcuMua0zhnCq-ACeTs
Message-ID: <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291095-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: AF25D5BED6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

()

On Sat, May 23, 2026 at 8:07=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, May 22, 2026 at 8:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 22 May 2026 13:01:49 -0400 Jamal Hadi Salim wrote:
> > > > > I must be missing something. What's the problem with changing the=
 patch
> > > > > to pull headers instead? I mean - if we agree that this is where =
we'll
> > > > > end up - we should just do it now. It's the long standing kernel =
policy
> > > > > to "fix things right" instead of creating temporary fixes which t=
hen
> > > > > have to be reworked in -next
> > > >
> > > > I may be the one missing things. You main concern is with this:
> > > > +       /*
> > > > +        * If the skb has shared frags the user is likely using zer=
o-copy
> > > > +        * (e.g. sendfile).  Those page frags may point to page-cac=
he pages;
> > > > +        * writing into them would silently corrupt the page cache.
> > > > +        * Linearize so pedit operates on a private copy.
> > > > +        * TL;DR: if you want zero-copy, don't use pedit.
> > > > +        */
> > > > +       if (skb_has_shared_frag(skb)) {
> > > > +               if (__skb_linearize(skb))
> > > > +                       goto bad;
> > > > +       }
> > > > +
> > > >
> > > > i.e you want that gone, correct?
> > > > And my concern was whether removing this still exposes things to
> > > > exploit even if temporarily.
> > > > Likely it wont. I have time, let me test the exploit with that code
> > > > ifdef'ed out.
> > >
> > > Ok, it fixes the issue even i ifdef that out.
> > > We still need the little patchlet i sent ...
> >
> > More and more I feel like I'm completely missing the plot but
> > for the portion of the problem that's "we are writing to frags"
> > the fix I was trying to describe is:
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a2789..3a74cef58e17 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -414,7 +414,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> >                 int offset =3D tkey->off;
> >                 int hoffset =3D 0;
> > -               u32 *ptr, hdata;
> > +               u32 *ptr;
> >                 u32 val;
> >                 int rc;
> >
> > @@ -456,10 +456,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff=
 *skb,
> >                         goto bad;
> >                 }
> >
> > -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> > -                                        sizeof(hdata), &hdata);
> > -               if (!ptr)
> > +               if (!pskb_may_pull(skb, hoffset + offset + sizeof(*ptr)=
))
> >                         goto bad;
> > +               ptr =3D (u32 *)(skb->data + hoffset + offset);
> >                 /* just do it, baby */
> >                 switch (cmd) {
> >                 case TCA_PEDIT_KEY_EX_CMD_SET:
> > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >                 }
> >
> >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > -               if (ptr =3D=3D &hdata)
> > -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> >         }
> >
> >         goto done;
>
> I see you are trying to get rid of the skb_header_pointer() /
> skb_store_bits() piece. Sure looks cleaner if we must linearize.

The other thing (i may be over thinking) with pskb_may_pull is: if the
data is already linear (in a clone), wouldn't we corrupt the shared
linear data of the clone?

cheers,
jamal

> My primary concern would be it would break negative offsets - which
> that patchlet and much of the dance in the Rajat patch accounts for.
> ex: pskb_may_pull len being an unsigned int implies hoffset + offset +
> sizeof(*ptr) will be intepreted as a very large positive number
>
> I dont have time to test but something like:
> # Change Destination MAC to 00:11:22:33:44:55
> # Offset -14 is the start of the Ethernet header (relative to IP header)
>    tc filter add dev eth0 ingress protocol ip flower \
>         action pedit munge offset -14 u32 set 0x00112233
>
> cheers,
> jamal

