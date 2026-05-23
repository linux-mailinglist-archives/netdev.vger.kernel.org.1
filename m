Return-Path: <netdev+bounces-291094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xv67Dp2YEWo/oAYAu9opvQ
	(envelope-from <netdev+bounces-291094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D75BECE4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B043013899
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14103914F0;
	Sat, 23 May 2026 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="FKN4E7q6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DE19E839
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538072; cv=pass; b=Tpzz79KXWtBMTZ81XXs9Ggjn6SPxS8Ce34j0sZxshhkwLnx92rt1jkAAH9M914+ZpUE70Cao0+t7UXjeFtykFLdG8Jwp1OSuNGpk0YLPDsdGMMxRjjuN9q49saW8bbODC9zVx/yOJk4fcLkUtjUJJmPMwnxzfqgtYbgNy1W49v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538072; c=relaxed/simple;
	bh=4mqIIBnJbcVU7++q3/ORQLhGeCZBsGFmGrNV550AZRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxLLxcYGwKhNNx/2ffLA4mCusyOpY9lv43p3SUrTnbMQe3RxnWoOjvBpMOERz5S11f5rHohXEb+0DpDQ6n5xFTdEd27htvY/NugSivDOxtLEkhin7iJEciB6+5KYZOv7U067qQ2Uj64HBDD4nJ2NNY6od9/z6CSAGg8VearAz4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=FKN4E7q6; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c828daf83e2so3772817a12.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779538070; cv=none;
        d=google.com; s=arc-20240605;
        b=OtYlqKemZuvPmHdz43mHez71TopOWRACul34lF7SVk0msBB3CvW5RVASlAdfBivils
         8zx3huNHCAhfC7Pb++Vecp7eiGiKkVqqKc0CKP5ypCyhUihSkLuMA8U8IErR88FIT714
         Bh0dV+aLfuiWA5cruiara0pPAAcOQH/PICzZDDUuSCpqslhhrGzQVO2LEzcic8Jnem7w
         PoIhJT8M1mprSvobl/mdrImCjW1abwXRtHt31Zecnhje9v0L1/Mti0y4TFywDuf/B6eb
         /plhUgeL52zB42+b90w1wtRYgd4/AzLyRXz8qSjINC7/B7beVirguuDsrHMEp9/0ogsU
         A1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QGvZv5bNUvabJn3+DfvncI7Rw/cw1O0WkQMNuwB7ug=;
        fh=wfLjxHMJx8XD6c93WZcwbgdWhrkI8rnx5x9nYctk+EA=;
        b=IUmYEg7+HPwMOuAkBa0/YGyemCQQko9t/qM5vUcbFfE77go+b47QI5c6n5iLm50nAJ
         9xXAfpe9WPDygTnz22yygMn5jHHa4jiyrZ/LN566rdSDiE6YQ+mq0DWSf4+fm0/l4ZFF
         2NC9GKXstQBv9yEN32Hu6rxTqN6CWyhyuI3hQDgZoEimGg4NZYEy73vMissCp4yzMIuG
         HeXfLOT7KJ16KngDKIpBofqPhyyCiZR7x/V65pzas0Aiv4K2XeqkJIxLEE63LX3i6xK/
         eHPv9TNq9NkxZkZAqRmzdJ7gNP7gJtp3onSU5hmcTI7cBpqj53Vr7+WueTftHWkGroD2
         MyRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779538070; x=1780142870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QGvZv5bNUvabJn3+DfvncI7Rw/cw1O0WkQMNuwB7ug=;
        b=FKN4E7q6/7CiW3KpSxvjWDUtWs6uFQ1axpSIJ5+0UTP9Eo168IMECWbDhjBRRvDF0w
         wye1Z//1s6lo+KI+/5gJ5lDgYVSfFoEpe5hZQ/NM0IbYU+xlUZaepbC+V/7RW7kWZ7j7
         5NrBYK2rYkD4k3pGDP2mCdx/1wvsgbbIqgp9V8ZHCF+mV4KhL2HJccPeI5oGjP/6hvjk
         W44FjL2zXtfBO2Yy+lgunZ/YLv89FLOcJ44aQWjzL+uXemK7mTDBiKoAqdh1UxkckBKI
         9vTQowZs73H85JYVH4o/Becs46N5/4BoMIi9S8SqsovV9l7RKNyWJChecfmgMSqQtsil
         O2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538070; x=1780142870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QGvZv5bNUvabJn3+DfvncI7Rw/cw1O0WkQMNuwB7ug=;
        b=WwP9XJFmy1vD5nBg27D3RQZCdG57KC75Rc+W5iIfSE6GRUR/yK/GcqXbPWLmG+6jEE
         fMzoEwXSuQiaCiwOZC/6aKQXFdd4QFk10tQJAN6Vzu4rzOHKkmrlzGHV6lO9b9QRXhDW
         yaHyamhzxRyl+r50GZ9XNBNEbRtdN5ATb0hzSf1a7sO1ARJy0AMV41+5hH7Sfl5s8L62
         6CS6DQTDdq7iqji32moU4IqsFunEFK33ydDCzvN4bEII0xUneU2uWbn7zsLsFlYSL+Zs
         Wuo0B3axn7h/nBw/dQXjKDICX8dXJXXE2VrOVsJAiVmLiIEvif3MR/BQzGq+yEfFvr6M
         xv1w==
X-Forwarded-Encrypted: i=1; AFNElJ/bQ/nOlF0PBh8xy+SCKImaeuUa65ygz+SCn5dptFqgQrrAIu1auygtrpWv7/OP+33TDgXo4jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZJfTUpPfp+z72nX6vsdAwdfj1JPbI4cflrb9DRknTjPTZs9E
	kG8FBKF55YuiAWPMaI+c6XKA/8DcXYRgUp/vmTwmBj/NVE4qbTcTFFBw3LKTkIOVCGbw1SSoX0j
	iNeKCAtgrZQ4E2GlpCBAtH2H+qIyOzEOu0VHvyfEy
X-Gm-Gg: Acq92OEAAL8zrtvAj92ZSCZCDVHyfGiHQC+vLGyGXTEK5Z3GTz3Nd6bZd4T1hfl5GkQ
	6Fzg3z1oy37rjynsiL9EKp2EzAAz1yjzSaPTo6V+7JQW8afsar3htp41hWPPYYu0dgqOYX1zhV6
	mZyJZOSVIuGzno1w1LqWok4oyTmjPTiaeuq6K6OhhPu1qSPy9QB3E8kZAw4a90qTkKgZBxRctsE
	AsL9zgQ9sQg4OybyzDMcJJ7/cVV2gnFKvyjPdVRDkil5FdyGATwC29XErkQkOoVp25kAf13lAB/
	hgJzIjp5n6GoiOq9oxY=
X-Received: by 2002:a05:6a21:68e:b0:3a2:e0e4:f072 with SMTP id
 adf61e73a8af0-3b328f07390mr7552449637.48.1779538070116; Sat, 23 May 2026
 05:07:50 -0700 (PDT)
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
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com> <20260522175507.02b4fe83@kernel.org>
In-Reply-To: <20260522175507.02b4fe83@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 May 2026 08:07:38 -0400
X-Gm-Features: AVHnY4Jaiac_k3K0jdJIuRSSWWNeeVQl4vLSC7pa6fiLkdFtY2mW-qIkhw7U9m0
Message-ID: <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291094-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D9D75BECE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 8:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 22 May 2026 13:01:49 -0400 Jamal Hadi Salim wrote:
> > > > I must be missing something. What's the problem with changing the p=
atch
> > > > to pull headers instead? I mean - if we agree that this is where we=
'll
> > > > end up - we should just do it now. It's the long standing kernel po=
licy
> > > > to "fix things right" instead of creating temporary fixes which the=
n
> > > > have to be reworked in -next
> > >
> > > I may be the one missing things. You main concern is with this:
> > > +       /*
> > > +        * If the skb has shared frags the user is likely using zero-=
copy
> > > +        * (e.g. sendfile).  Those page frags may point to page-cache=
 pages;
> > > +        * writing into them would silently corrupt the page cache.
> > > +        * Linearize so pedit operates on a private copy.
> > > +        * TL;DR: if you want zero-copy, don't use pedit.
> > > +        */
> > > +       if (skb_has_shared_frag(skb)) {
> > > +               if (__skb_linearize(skb))
> > > +                       goto bad;
> > > +       }
> > > +
> > >
> > > i.e you want that gone, correct?
> > > And my concern was whether removing this still exposes things to
> > > exploit even if temporarily.
> > > Likely it wont. I have time, let me test the exploit with that code
> > > ifdef'ed out.
> >
> > Ok, it fixes the issue even i ifdef that out.
> > We still need the little patchlet i sent ...
>
> More and more I feel like I'm completely missing the plot but
> for the portion of the problem that's "we are writing to frags"
> the fix I was trying to describe is:
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2789..3a74cef58e17 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -414,7 +414,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
> -               u32 *ptr, hdata;
> +               u32 *ptr;
>                 u32 val;
>                 int rc;
>
> @@ -456,10 +456,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>                         goto bad;
>                 }
>
> -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> -                                        sizeof(hdata), &hdata);
> -               if (!ptr)
> +               if (!pskb_may_pull(skb, hoffset + offset + sizeof(*ptr)))
>                         goto bad;
> +               ptr =3D (u32 *)(skb->data + hoffset + offset);
>                 /* just do it, baby */
>                 switch (cmd) {
>                 case TCA_PEDIT_KEY_EX_CMD_SET:
> @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>                 }
>
>                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> -               if (ptr =3D=3D &hdata)
> -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
>         }
>
>         goto done;

I see you are trying to get rid of the skb_header_pointer() /
skb_store_bits() piece. Sure looks cleaner if we must linearize.
My primary concern would be it would break negative offsets - which
that patchlet and much of the dance in the Rajat patch accounts for.
ex: pskb_may_pull len being an unsigned int implies hoffset + offset +
sizeof(*ptr) will be intepreted as a very large positive number

I dont have time to test but something like:
# Change Destination MAC to 00:11:22:33:44:55
# Offset -14 is the start of the Ethernet header (relative to IP header)
   tc filter add dev eth0 ingress protocol ip flower \
        action pedit munge offset -14 u32 set 0x00112233

cheers,
jamal

