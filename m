Return-Path: <netdev+bounces-291373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDoaOL93FGokNgcAu9opvQ
	(envelope-from <netdev+bounces-291373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:24:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1C5CCD41
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE5C3034640
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD03F5BF4;
	Mon, 25 May 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="uvSqmoQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622C3F5BD0
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726174; cv=pass; b=k2FWoRZkmOzSw/OGTtdevDdlsQrWrdWKX6NOehrV/nw6oDq1C1sKJ2pt2h4L+gI/LLqaKUydaqh3BWC3Vb4lNWG+AM+moW5QT5ltu8N0UmK1nw90jPSumQu4Vn0W4XbktjxWiYT5oMvvtDJuy6OAMnk5AI7IiLZ8Jj0piY4dO2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726174; c=relaxed/simple;
	bh=XwMolNIpVC/KsDcWBM1y2Ytjqf5vf6MeZhYqlok18Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cg+ZcdrdcBM0cqou09WV3Gw0RKsoJdZJZz6KdxWYp9FrQuoR5uOHnYhjT57VTK2U3QlNjR0OSft7o+TjWcT5XjgpF2UlRuT85jLzIJCqBaYvjQcUH3Xgs9DGRcX6mq0N4VlSbt8KBYwTph3Ehn0+CYUVwnQnaZ4L04DGQ6RpQh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=uvSqmoQx; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso3627379a12.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779726172; cv=none;
        d=google.com; s=arc-20240605;
        b=aNnhsujgP6Dke0d96BFkxccOkQ6g4X1Txd3OZpE+jS/j0w0t1zqVotcoxv0z1i+lt1
         kTXqZrjz9/Yo9+MK1r6ppQodU1zTvrKEnt88LN/x+rpyD/CO2fU9koKtpLdnjBz/ELWI
         uH2BV+bCjQ4eYwMFnBmuppz6akf2zduJxz0qcVai2+VrVceEnfwzAkGv97jN2olaqRpR
         z7zOQPDQ3BEgmsvdbUmqyNdHHBpUWaLFhucl4vFqU1sVY4VXjPQmvzOU9n+LCjLzKovE
         GIcBE4KH+nLFemEz5wSpWMAFPmnymr65a+TzvHM5lj88oeBdIvXJEQ5PcF9h61XXzQ7N
         dm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvpXGGWbwY60OwBtxDOf2B0WBSKcW0jPpy1/sHrxLrM=;
        fh=ZZM5AYCbfqHsFaGoNjVu+2UpEz1DtHGsShXTlDlq3Gw=;
        b=dAZpTmja4kuZHI3YwXf+H/f0HRUQ1pGVbYjqGtY0kqyqmw7riIGUB7/Ja0D9zOOdyu
         JRSdpH375Qluixs40eYEkH8s1a3hf0p6OHWem///WZvd6wNjcZYPyrPoJ0DGQ2mE7nF2
         eJ2WFQK+u6ydWgNkqPjGZAGc4MxF9GhXlKdCvINF0QfKRm+Er27ui6Blyn5aSr92GZ+9
         RNiIA2BpFaG+cc61idwh7ilkFpXAOVW9fF+l+vfdhkWyz4KKTifDhp0l0q/oloS8QHnI
         oyVbn2um/G6VUiAZaICPUwncKTDc9KcVB+I4QqRZJNQI/PJ9OHlLjMlyOO7SyqUNmqcZ
         Ne2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779726172; x=1780330972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvpXGGWbwY60OwBtxDOf2B0WBSKcW0jPpy1/sHrxLrM=;
        b=uvSqmoQxAmgBodjPFPoF0n3m/zk7fssTMCd3h4fhIYJ3+zNKVyTttKmNzc3hfHnRTs
         SpFaoH98eXFMp6O/OuT3yoAf4ilimMbYG08JSQr0JIWo2+Axm1aXaPuTyIn6yvpIfdK4
         myTj/SHKHImZ4UJuNbfI2tR/SK6tJAkjw06RW+BP6S+2LTXVJrakBmlI5DI1vefVHjnM
         AE4CzJ38FNRNJ7bOlg5r2C+EElIMWle5JaRSIpnz81xcyDkF78MPRgQ9H1W9Hs+F9xO5
         AImEyyUVMhFKqGt69XlBUn4IFHjo/wSTbnKzkmlsNHnXvP4/K+xl/lJYljNHniGwEbEx
         +w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726172; x=1780330972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvpXGGWbwY60OwBtxDOf2B0WBSKcW0jPpy1/sHrxLrM=;
        b=JakpqPiiZ981XPLOJgHGEMJEZigfkEn+jBNdGylGJJQcBdWhuf7DPE+SSM2oW89z52
         UTZ9BsQRn5O2BowL9QMeRzRereeoq2q7arlQWjhFGI6kaDu3D1VEhIMkJp8ZM+/BSZsN
         CswfEV6iGdff3n15sR4eWFcNKvgU1zgxDy6S1r3kSDIfZ2Nuto5VAOWDFdXHrSf75yqW
         2amep6SyVNuA+hK10/40+QqtGrjMPS17zeOMtlgZufWfrDKEcXK+csCxtj5VQI2uhQaK
         yg0gSKiG0/I5te5Bfll+Cl3+dLf0qzSrqZmAxRn2eR6PUKDYzLshuJygLTx0KoaFs041
         tNww==
X-Forwarded-Encrypted: i=1; AFNElJ9BMJ3IX7v96Qb/Uc9uBZerv5IVwGjmm7bEnMCGK1t78KwZCovt0WbeDmfRo6+vLu8nIhismWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiOdYvyW24wHPm+XFTHWpllxxxZMo7c6WqEHJlA5BcmAIG1M6
	lMlaKxaTih4SBNLdk+ELBEXBHXJHjqPt+RYIJ4timfq9hdPIeyqfjSqS0v7ynwwXO+k06qnlau1
	5JvNuiDGRwS6dxmkb6j2bZ2icaOPzpwPgbOawViJbsAXDEXJ2o9bYPajd
X-Gm-Gg: Acq92OF5SdTvsu5z56vBEtDQfV2Mf8b54MgNdmhsMfmiIxjoJp/DdzJUZoFczhX+TNm
	MUTdJ5M6zhsre8Oj488EI4dsbAtovyl8SAAtr+iVltsDJsjpbqJ+TFYhTBmumnW7IuNgi1WbUxu
	EZcrWVBgqKVhDEN+r3L10rOVrGJ0DFOBg5OXdhYvogbznqX9DWId68/6ptGvI+GGwfAXgW0BazL
	UCNx9uFRp78pdgeE6a9VzxeqBLJnWPfsywOR0wMuxpIURwixaZBfBvbKuuSAlHXBFUxxH4MYQqM
	ggJ1qq9mnv/VUtZVeW0=
X-Received: by 2002:a05:6a21:594:b0:3b3:1ee3:2796 with SMTP id
 adf61e73a8af0-3b328caba50mr14978881637.1.1779726171702; Mon, 25 May 2026
 09:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org> <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
 <20260523094641.2bef6580@kernel.org> <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
 <20260525083932.234f26df@kernel.org>
In-Reply-To: <20260525083932.234f26df@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 25 May 2026 12:22:40 -0400
X-Gm-Features: AVHnY4Jj9u4GV4d54QyPbONnULigOfs1P9DZn1Q6loLojyaaBCtfomP_kjR8OgM
Message-ID: <CAM0EoMmjg+qrc=E+1nSVcCUPFh9yUfw59ASLCOM4jcEvRtw4jg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291373-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 11E1C5CCD41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 23 May 2026 12:57:08 -0400 Jamal Hadi Salim wrote:
> > On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote:
> >  [...]
> >  [...]
> > > >
> > > > The other thing (i may be over thinking) with pskb_may_pull is: if =
the
> > > > data is already linear (in a clone), wouldn't we corrupt the shared
> > > > linear data of the clone?
> > >
> > > I said
> > >
> > >   for the portion of the problem that's "we are writing to frags"
> > >
> > > IOW not replacing the rest of the patch (assuming we care).
> >
> > So as an alternative to the piece i posted? i.e this:
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index 79921b8d89ba..8f0f84b50c85 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff=
 *skb,
> >                 if (write_offset < 0) {
> >                         if (skb_cow(skb, -write_offset))
> >                                 goto bad;
> > +                       if (write_offset + (int)sizeof(hdata) > 0) {
> > +                               if (skb_ensure_writable(skb,
> > +                                               min_t(int, skb->len,
> > +                                                     write_offset + (i=
nt)sizeof(hdata))))
> > +                                       goto bad;
> > +                       }
> >                 } else {
> >                         if (unlikely(check_add_overflow(write_offset,
> >                                                         (int)sizeof(hda=
ta),
>
> Yup! Even better.

Dude, it's hard to follow you sometimes ;-> It's hard to grok what you
mean the problem of "we are writing to frags".
Let me try to be verbose and you can narrow it down. There are _two_
codelets dealing with "frags" both of which can be written to.

1) The patch from Rajat deals with zero copy from app with shared
flags. That's whats being exploited in the wild.
There's a piece of code there that does this in Rajat's patch to handle it:

+       /*
+        * If the skb has shared frags the user is likely using zero-copy
+        * (e.g. sendfile).  Those page frags may point to page-cache pages=
;
+        * writing into them would silently corrupt the page cache.
+        * Linearize so pedit operates on a private copy.
+        * TL;DR: if you want zero-copy, don't use pedit.
+        */
+       if (skb_has_shared_frag(skb)) {
+               if (__skb_linearize(skb))
+                       goto bad;
+       }

After you posted, i thought this is the "we are writing to frags"
issue you were referring to.
I if-zeroed that code and indeed it does not seem that the exploit can
be executed even with that taken out.

2) There's the frags coming from the other (driver) direction in
particular when skbs get cloned. That is what sashiko2 (nipa variant)
pointed out. IOW, there's no active report for that specific one but
Han Guidong responded after i posted this:

--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *sk=
b,
                if (write_offset < 0) {
                        if (skb_cow(skb, -write_offset))
                                goto bad;
+                       if (write_offset + (int)sizeof(hdata) > 0) {
+                               if (skb_ensure_writable(skb,
+                                               min_t(int, skb->len,
+                                                     write_offset +
(int)sizeof(hdata))))
+                                       goto bad;
+                       }
                } else {
                        if (unlikely(check_add_overflow(write_offset,
                                                        (int)sizeof(hdata),

Saying he was able to recreate that scenario with a kernel module. And
that this patchlet fixed it.

Hope you are still following at this point ;->
So when you said we can use skb pulls - I thought you were referring
to removing the above patchlet and instead to use an skb pull approach
(for which you posted a sample patch). I mentioned the two issues:
1) It will likely break the negative offset that work with pedit
already (skb pull could conceivably be tricked to assume a large
positive number)
2) that skb clones could result in writting into the shared data
(which i said i may be overthinking).

So which one of the two are you referring to? Or maybe it is both.
Should we keep #1? or this the one that should be replaced?
Are you ok with patchlet for number #2? Or do you want that replaced?

Provide as much context as you can so we dont go back and forth ;->

cheers,
jamal

