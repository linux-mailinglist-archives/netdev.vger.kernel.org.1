Return-Path: <netdev+bounces-291425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DQoDimdFGqpOwcAu9opvQ
	(envelope-from <netdev+bounces-291425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:04:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A95CDE41
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 822343011785
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88E35E1DC;
	Mon, 25 May 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="h1qZM/4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E18462
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735845; cv=pass; b=qOTk5xGbqvkrD0w3xFawjeAj9fJOC2xaQsSIc+QtNGk5ezi6cvajMfUoEh4NL0LBQ9Tgl16LZho9x5a0CrYHWGZG25VaKXqQdv226iFR5kptAwfGaGtGSG2dihqvh/Eo5jQs5t6COrhLZnUWAPJw2MgeR5zVTQxpcrn+W69QPTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735845; c=relaxed/simple;
	bh=1f6voMSlJuA1nJAtm8EkBarJRUzGdfQF/GA9h8cQ2p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5T4nr4ltPh1Zg+704UwLxREdNAiIv85AomSRa7mUz8PSMtCVxJ52JpdzCdaJLqzgripeK2u5W9Q7svm1xJkI6MxNz4vQRy5KqVpP7WxjwiKTsWpSeUgWWbdnodEnjGxfO+fGBWP19sWjNn92AsmFY+i79jJ35qMX+QdX3BPiTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=h1qZM/4j; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-835386ff122so9921242b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779735843; cv=none;
        d=google.com; s=arc-20240605;
        b=fkMrHUQBGLjw69xlyPzziXFyt6MU25gx5f3/rfF55k+HDEYuPQdNF82kJ9a4TXPljv
         PX/QfC9CrurIE3YyUAfB5WAsgpjBd/A4Fy/D5f1i3/kyJcf2YwCrwoSmDXW4zvmCFZnu
         fmOTizKkibFoZxWTM8jBywHllRsZwHR1rNM6XpbGB+9CUzF4HyqnXKXdWHZUorxDXuZn
         V43oTm3mud70ZdVR6PHKZkibDk32rtFtLSr/3tEPoNt0tY+e3ZBiKi9aCnKopl15ZMgs
         ndQxIhtZIDk4gndqeitB0mwozTjXtieeV4Ku6qasWmAQnkuLlaXfyB4thlw0P1Z+BnH1
         0CcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dw7D2OIA0IItcv+WAWgo7LO+GScBXj05+Y4sBbbB/cU=;
        fh=JScdwvVabjzp+K9qUeOtE5Q400e2Y/tqe5qJc+Dur+Y=;
        b=hn9ZkCypELGZ9rKwe5N/kfR/awkUfAg/bvV58nqFqk4cQ4MY84XphwQfXEX+3fZbwR
         q/ZVDgANpVnm2S4oiXMqhTXvENog/AjAVJdbmqV0c0fjbDTqyT7nZYjf3ZGCUbGZ1PO4
         GaI7ylDDNSi1ekPd5YASsMfbJ1kaq6oAlLTgyxw4HUq6Es9wTXmShuF2R6M5+zLoLWNu
         awVOMQ+xmLnC6PiIcT7zz4KFRqx+RoKHOKAn/8tw9ACZwukFeEYHPrgzOtODJ0pb6RjQ
         +qnBtUQAFJxBjSrOSrUumQWqNODTA9Ckx5ydR776oTBpdVdoRTeE2S0+59jdR9NNlHVM
         UiMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779735843; x=1780340643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw7D2OIA0IItcv+WAWgo7LO+GScBXj05+Y4sBbbB/cU=;
        b=h1qZM/4jp/03NPQzTTzW8WMm7rYY3rtblqE8vXvGfm8Mdie1PjxyXvMz81K6+843mO
         JatojB27XQMm/NXY3ws27cw6uXqtB96QaPIeHqjg+cdux/zunCCVNa0TPhwYOTW79PPV
         2vQHeFmj3RwyM6lUk7+QDJZ6mvIL5PeXIsSY9mfstGnvMHyOsQNy+1P2xFhJs5BLkgId
         cYo/RzpHZ5enqtKOMa7LxsvN2lGUegnFSXmENiHiGc5iyakBIcjD/JsS4t39097o+U5d
         gYqn4UZ1CE5F4q3DsyHx0CYjJBA32/drHfpJ3zYGKAz9Rc4n9ThszLpk/H9qmZw7Rn5R
         u+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735843; x=1780340643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dw7D2OIA0IItcv+WAWgo7LO+GScBXj05+Y4sBbbB/cU=;
        b=meCNpYvfEo2hI9fLP/nouqWk1WJQcdujPGqGeaaWOEb0rTG2GH4VY5s/kIRfIpc/UH
         caK7x1XKSIkDyhn51/4DIEhyWQNpIK7SumYU2KTjrBAxPV0IqVU+N9vF4jbiZM5EYqji
         AGHcGT6QMR4B0XKYpebRxnHiSfc7Gt47VAyg6q0kn9edq5WKu1dPQttDeYU3LfHG+w0C
         nTKH6tXOZ5TLCnbwUsVJmrGGZ8iydxDG/IX4yPdbTFkIXE0GzF0g7RcVG40prFwv+Me3
         Tcvrgw1tOTxNSd6WBN9ruC9kYYYmc9CzJzQAO8yj/qBEqTgs9s1iddMi8oh2zM9mOaOo
         E8vg==
X-Forwarded-Encrypted: i=1; AFNElJ+MK5Wye9z9pXnGyqpuaR2Buzp0lTKVweJa4Ka8Xw1Vcx5u6MLet7zQdQND1kmQ+3rVWvfkwnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb0184mNM8zqRDq8aC/RaQtQu8njcGKURd1deZz4hzUlv9WsA
	XJpJBrEj2qR+LK/B9d3mGpyiAlQ9TSIdynL6/1HC+PlkhQvLucPltNF6SJTSz+O0AhXz7rodjTO
	mVd9hiGjrfGBiPCd5NgSivtkBAtXOjFKafJ/VeE7H
X-Gm-Gg: Acq92OGfhGMQWR593K1PYFYTjcEfCd0JmIptymzokGCAI13TB6zGUAlOaOiAqbSaoiQ
	h/IKPLFlcXoQV1Vpmj7lCfJmxdLJTrbsWLOUR5cD76wiRr36rlGeXSUP25+AXPttuQnjVpYCcne
	TewviFKnQjgIInNrzd1UmPm1O0Byp+CfSlM+sglR9JDeJnOK+r7y8tX569+Envd+rI5lzBiprEY
	U4gIZotp1LKJgVhQuYBLKOPvYs94hnt2biHG5Qv+J1w6tdyW9Jm//iz2VrnB/snC6zdmcE1Ptyd
	fCLrNDz23jWDRQsFDjw=
X-Received: by 2002:a05:6a00:140f:b0:82c:b808:4c59 with SMTP id
 d2e1a72fcca58-8415f687146mr14590429b3a.46.1779735843089; Mon, 25 May 2026
 12:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org> <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
 <20260523094641.2bef6580@kernel.org> <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
 <20260525083932.234f26df@kernel.org> <CAM0EoMmjg+qrc=E+1nSVcCUPFh9yUfw59ASLCOM4jcEvRtw4jg@mail.gmail.com>
 <20260525103443.1da3e406@kernel.org>
In-Reply-To: <20260525103443.1da3e406@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 25 May 2026 15:03:51 -0400
X-Gm-Features: AVHnY4ImkyIuWRwCNng_Bpl-KyKEnKsQHG3nGshwXKcXY1Yug9jufhlFejM6hp4
Message-ID: <CAM0EoM=YDZB6oNN4A1sXck3FS1TsH8D9haqSuooLG+AFuKvHfQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291425-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 859A95CDE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 1:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 May 2026 12:22:40 -0400 Jamal Hadi Salim wrote:
> > On Mon, May 25, 2026 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > > So as an alternative to the piece i posted? i.e this:
> > > >
> > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > index 79921b8d89ba..8f0f84b50c85 100644
> > > > --- a/net/sched/act_pedit.c
> > > > +++ b/net/sched/act_pedit.c
> > > > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_=
buff *skb,
> > > >                 if (write_offset < 0) {
> > > >                         if (skb_cow(skb, -write_offset))
> > > >                                 goto bad;
> > > > +                       if (write_offset + (int)sizeof(hdata) > 0) =
{
> > > > +                               if (skb_ensure_writable(skb,
> > > > +                                               min_t(int, skb->len=
,
> > > > +                                                     write_offset =
+ (int)sizeof(hdata))))
> > > > +                                       goto bad;
> > > > +                       }
> > > >                 } else {
> > > >                         if (unlikely(check_add_overflow(write_offse=
t,
> > > >                                                         (int)sizeof=
(hdata),
> > >
> > > Yup! Even better.
> >
> > Dude, it's hard to follow you sometimes ;-> It's hard to grok what you
> > mean the problem of "we are writing to frags".
>
> Long threads have the tendency of losing focus.
> Better to just repost the whole diff than tossing snippets at some point.=
. ;)
>
> > Let me try to be verbose and you can narrow it down. There are _two_
> > codelets dealing with "frags" both of which can be written to.
> >
> > 1) The patch from Rajat deals with zero copy from app with shared
> > flags. That's whats being exploited in the wild.
> > There's a piece of code there that does this in Rajat's patch to handle=
 it:
> >
> > +       /*
> > +        * If the skb has shared frags the user is likely using zero-co=
py
> > +        * (e.g. sendfile).  Those page frags may point to page-cache p=
ages;
> > +        * writing into them would silently corrupt the page cache.
> > +        * Linearize so pedit operates on a private copy.
> > +        * TL;DR: if you want zero-copy, don't use pedit.
> > +        */
> > +       if (skb_has_shared_frag(skb)) {
> > +               if (__skb_linearize(skb))
> > +                       goto bad;
> > +       }
> >
> > After you posted, i thought this is the "we are writing to frags"
> > issue you were referring to.
> > I if-zeroed that code and indeed it does not seem that the exploit can
> > be executed even with that taken out.
>
> I don't want the skb_has_shared_frag() being added, that's my ask.
> TBH I missed that skb_ensure_writable() when reading the patch.
>
> If we use skb_ensure_writable() before all the writes we can delete
> the skb_has_shared_frag() (as your test proves). This is the extent
> to which I care about the patch, anything else - no strong opinion :)
>

Ok, I will send the patch probably tommorow AM because Rajat may be
confused by now ;->

> > 2) There's the frags coming from the other (driver) direction in
> > particular when skbs get cloned. That is what sashiko2 (nipa variant)
> > pointed out. IOW, there's no active report for that specific one but
> > Han Guidong responded after i posted this:
> >
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
> >
> > Saying he was able to recreate that scenario with a kernel module. And
> > that this patchlet fixed it.
> >
> > Hope you are still following at this point ;->
> > So when you said we can use skb pulls - I thought you were referring
> > to removing the above patchlet and instead to use an skb pull approach
> > (for which you posted a sample patch).
>
> Yes, skb_ensure_writable() does a pull already. So the only problem
> with existing patch was that the negative offset branch was missing
> a skb_ensure_writable(). Your snippet added it, plugging that hole,
> so skb_has_shared_frag() can now be 100% safely removed. Hence my
> "LGTM".
>
> Please also remove the skb_store_bits(), and skb_header_pointer().
> Unless I'm missing something these are dead code.
>

That also seems sensible. But needs testing.

> > I mentioned the two issues:
> > 1) It will likely break the negative offset that work with pedit
> > already (skb pull could conceivably be tricked to assume a large
> > positive number)
>
> Your snippet looked fine tho unnecessarily complex in practice.
> (AI generated?). I'd go with skb_ensure_writable(sizeof(*ptr))
> as the worst case. Packets shorter than 4B are irrelevant in practice.
> But again, up to you.
>

Sashiko-nipa provided very good context and implicitly suggested a way
to solve it (and it doesnt seem to be a mechanical turk ;->).

We need a session at netdev conf to discuss all this tooling. Maybe
some of the security people can show up and share their secret trade -
it's overloading.

cheers,
jamal
> > 2) that skb clones could result in writting into the shared data
> > (which i said i may be overthinking).
> >
> > So which one of the two are you referring to? Or maybe it is both.
> > Should we keep #1? or this the one that should be replaced?
> > Are you ok with patchlet for number #2? Or do you want that replaced?
> >
> > Provide as much context as you can so we dont go back and forth ;->

