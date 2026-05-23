Return-Path: <netdev+bounces-291129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HDBKHrcEWq+rQYAu9opvQ
	(envelope-from <netdev+bounces-291129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08A5BFECD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 168643004621
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70541218EBA;
	Sat, 23 May 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="NMg84wSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0F1F5825
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555443; cv=pass; b=ovYgl3mgVNAN+XrOAwKji5/lEH8DfFJxTEA7AC9DXcS0dMhBBDcVzoQKXJMfNhormcB4XvPK6gPi0j7mHuHNF3aIYybSyla4qjic/nld23oAXa0hVwEk6RBw68JyNhSuBivnwq1y+9amcd8oHvz37Bg2AtR7Ciw6pxfxnSGpTtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555443; c=relaxed/simple;
	bh=5VMOLKG8SGxdN9mbigVeUd3OyYFBWqrBlZq3AyxQKcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otxh3RUnGcMgcmBtPXykEMmNIDRGb5jFb85AIDWTjZTU5WDsfvsYTyzhbLPqY4yL2FfgH7/xoOddZtARWHvVYlXIRbJ4+hUdpknvrvU1Bfx7S0YgqJeqU0sfXmVm3VBiNnpp66WujAIvYDGde4+oSc+6h7mRkqx0rID7nQu9A6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=NMg84wSp; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36936dcf19dso4064818a91.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 09:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779555441; cv=none;
        d=google.com; s=arc-20240605;
        b=cf5fUlNDt44/skPyNzYbTd48lvQ6nez9fRrJORtEqI/ni1Bs8Z+3TqPAooTCboCy31
         PYovfrsVfju0Z3rKlIO955q0Cmw//Bp6SArMeJbwOGoXsc60EfcII3eWOpbZAQP/ukGh
         2thy6gOFDp8pksIiMM9/6NoQH3JRgYiA3vA8qv+kv7DOnwKPETa8qCrB3LloVWryXtqI
         CFqZS1GmicKIUk/0zHhmaSnCKMcQO+WODx5dTWTT9csSTgfA4+JKZPVHmOAi4VGym+ZV
         e7+u0XDrWfDYui83xbDoPDLaAHYHHxs6e2WdI2xFwHmKBSKv+BTvGM7oND/JcZO5c/Sy
         1Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMgKndvDcQ2cFvH3GrLKJUGqdEv3CtYgRiXoeJBUaDE=;
        fh=YzU9fUVWGYKJiYptN5C0lEu3uloaHTUDloGoEKxqppE=;
        b=gqfThKuuCOHkQOUdXfpsZiHkRp8MO7PBCqJLrKQwnrRfIHRxkZ0tf4LM0zgTAuFgEw
         L/VVw1DlfJNV0z+3gwfGazUxsUpjSDWl3rE2OwanAgGCJK5Keq4IPpyBTTvC5WHIqMFx
         fufwoUEcPUdn7JHG3pn+qe7sq1sSIAvIf4hfAN1zuzLjpO4SKxWnchiSAUJB6lrAIIqW
         9PWftHOsTtu92cMs4PqEslpwP25+ad2B/mVFKeW7poUQ17J5nfhMa0cXqW/OQ3zN1QzB
         QpP/SXlM+Or2l4X+xizQ9JHUWPJaMno95F5NwtcIKOKIUcquJo2IUgO9tG+Rqs6rq1jb
         PLaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779555441; x=1780160241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMgKndvDcQ2cFvH3GrLKJUGqdEv3CtYgRiXoeJBUaDE=;
        b=NMg84wSpvkaR3rU8OjKHb+JJE8EQsWQSt2vCPFQknynAFRXyNWV81nDL+buevFX1Kq
         IU31cTAkDBEiF/G6mDE+T8Y+b3MdiM4MDQ9dYsL3EgDudilpw+F/4GcrcPCBdjyH4Dwg
         WFgS7xwbNXDfXlLYXgCKFNa09vs0R/6RcGjGNIxNhuiVqgOumTRZvydxVROVyfEjlxuB
         wOXukDgR/Ed/cdEGL0peL4X3E1CC2MGBHJ5cqVOxfysoPHKTsWakbGG+l7qMtbdpdJQe
         UwTN+GUTfRCETC22FPW+w2feq+dlTQmUbqalsiUV/71Bg0kk6hSt4Ju+VcvxAjNoRUNX
         7LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555441; x=1780160241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMgKndvDcQ2cFvH3GrLKJUGqdEv3CtYgRiXoeJBUaDE=;
        b=facCTwlRCHpy2cRB2CbgyLsK9yrjGz/H9G7rcxSka/7Jx6W6T3w6ZGvjJnhyph2Tsh
         SFRDOEnMPPjZFX+tEKeC6IFigXbbSe0gGSLcNRdJf/wEWjyX/jnlJrkX8L+gYKaWLaJ4
         DN2fyAQHqD5EIkcfnipTG+2rCLzHdOAUQSUf/MHfeFrSd2oi4Ilt5aGSO0y2k86foqNe
         cLojfy3urzR2Ems6RmWJBgLdOmui1OOSqJNog22MpyYTEkk4Bf3AUJUmw4tTFYcVKYmE
         ocba1nj8rLk9TbuQhCAusLoPYOO+xZewJaoDwt0fAZLZCyDwbi85CM/CHcFCEOS1bH3X
         eQFw==
X-Forwarded-Encrypted: i=1; AFNElJ+5BKa1xhIu9ImkbiLoEv6UhKi/UfADjwVPNR/Berz2jTZ/Obakw/70smzfXs3BHNMXw4KR5o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpFEV7xWf8/mFS0TD+RkmoJ6BoZxaIMbCPNOlCPhsKepYxH5d
	ziEAyqQLstLmwhrCDAFUzmLgT3cnSJSW8VRbuP2uJ+wUm8KlObJYZkDzs87TFTKGju4U3RusOsK
	BDqw9mEU3QGWa2afrxshbcSN5Gp+2ftPrehlAvQ2A
X-Gm-Gg: Acq92OFoDJ1Fm0zRAyU+IrFAlppEdGNR7Ygdvkwld/9YBfJahBa2o+AGtu6xY31NrFX
	27rnPz7mHKlMQKcaTCOxwJJPNLvy6u0bkA0ce9brea5dU+fSLLmCDGZNoFeOfEXR3vpsKlz3bpM
	J5i+fMCxv0tYohRUW/gsEMFcX47Mu8RpzJCW28h6zX5Z/rcmVL4KvXy1YJ5ERZ1w3FIrsYfFZOL
	ZwIogoY6PIs1zZ+8y2UWyK3x8hgAo6qPY4P70ZJ03I+5BwoVkhcrEx3QEaDvYZgk/ZhKcNSenhs
	VAlIaWRUYvwCp5ygAmSKwPOnEJfvng==
X-Received: by 2002:a05:6a21:4a8c:b0:3b3:2703:110 with SMTP id
 adf61e73a8af0-3b328c39338mr8514388637.4.1779555440712; Sat, 23 May 2026
 09:57:20 -0700 (PDT)
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
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com> <20260523094641.2bef6580@kernel.org>
In-Reply-To: <20260523094641.2bef6580@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 May 2026 12:57:08 -0400
X-Gm-Features: AVHnY4JNz4EeVdyrO9SQWz0lWcQgzu3b3hwiW4CyUyA9W7M5ZGU_Ed2flIdZTa4
Message-ID: <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291129-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB08A5BFECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote:
> > > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > > >                 }
> > > >
> > > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > > -               if (ptr =3D=3D &hdata)
> > > > -                       skb_store_bits(skb, hoffset + offset, ptr, =
4);
> > > >         }
> > > >
> > > >         goto done;
> > >
> > > I see you are trying to get rid of the skb_header_pointer() /
> > > skb_store_bits() piece. Sure looks cleaner if we must linearize.
> >
> > The other thing (i may be over thinking) with pskb_may_pull is: if the
> > data is already linear (in a clone), wouldn't we corrupt the shared
> > linear data of the clone?
>
> I said
>
>   for the portion of the problem that's "we are writing to frags"
>
> IOW not replacing the rest of the patch (assuming we care).

So as an alternative to the piece i posted? i.e this:

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 79921b8d89ba..8f0f84b50c85 100644
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

cheers,
jamal

