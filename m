Return-Path: <netdev+bounces-290322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MpsL4DZDmq9CgYAu9opvQ
	(envelope-from <netdev+bounces-290322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B03935A2F54
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA4903031C2C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE437F8C3;
	Thu, 21 May 2026 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="JAXyft9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C837EFE6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357229; cv=pass; b=Ohv4xnY1wxJJc+CVhwNy2eN9iApcGtnzSwvajIQKG1HCV2wJHYJa6fBS2naPfzAEnL0p7RoPEnXY/Q/cpEkB+Anb7Yoc8p98+qzzWBG3gdFoj8+izg43/4UVZFy023pyBuMADET1OC3SRBP1hD2TR4uIdmJjZxvMZsrgyd0d0HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357229; c=relaxed/simple;
	bh=ibSjtIiSjF4pi9+WHDCxKEiQXveQYf4gKeETFVZtlIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw76vSz1itd6LCIN7WT9k2q4jMS1oAmm4grmrYuD86DXLlNsOQ4JwRF2U7G07WG6ZX4fSqCnsW0G7/vmbs4y5SIEgIhYAgRMoC7ViKWpvvPQUsA4IIHVoWh2oh1jZv9SMM+ru4VC7VxlsMzTDWr+o0FqVZHlDFCqsm/JgFrYs5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=JAXyft9v; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-841513664bbso203617b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779357227; cv=none;
        d=google.com; s=arc-20240605;
        b=MLFXTKKPPeFhya2EU6MSUH/ZU9duJQARc+Pj6c4v/m1YRhUcyEcid2e5TBFO4O65PI
         wdgIEzT+okvY/rlNVcRNboj/4hfmeuAwM/kNu5S6JzB8PkNp3SKGTsrPabjGFToNbdcH
         0DjSoy8xwyyT5C5j4pkr5LyaAOkDF+p+TfOer/+HKsyKHYKmtdBiERnyasPk+DqSndfl
         15lLIoZnWTNXWUACAqkNLG7Y2ZFAI8s8namNc1WNJoVppB8Vz51iTS9RARs978Ot+MLC
         oHr9D7RqPs12Rq5q+juSyzlitWMm2tAr+QPrQ1LrAvjIbpwH+ojGaq/b0l+Co8GuLU5r
         4Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/NgD71Wvnu+OP5PxEvXZ2CGKc44UcNTOyVqJ9VO1+U=;
        fh=9OV2Fj+jq0UvwwDq3/PSsLPxDD9s9tw3U/HVq1Z658k=;
        b=C7W7OF7q+F9rsLHRl69Kpl7VPQDc+4s2FXpAN1VOJm2a6VsowoDgvtTrh4/ptZK8cg
         wZoYWrR3LSQGCXxH5ZzwxDZTtB5QJ+IW7+lEOc78ZrwBVs+RmXiTHMlCMV/hMppF71/z
         pBigtKib0YJn65mtyb93WE80AKMSoS+yZFqs56LO+7VlBhNPh1MY0pHwz+mcK2UB2CVv
         CQiGZ7Z0rlmf8UYwTQwEunz4/KvT7lRsVMJPzvSM25o4ai0AzVty35yrf+FEMvpHKJLp
         wrYZk2a8ZphUPbPTS/leyv+SCAOAqKOiAhZI9J1C1zyStEhXnBx0Kmir+y5E2SPN5YCl
         phng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779357227; x=1779962027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/NgD71Wvnu+OP5PxEvXZ2CGKc44UcNTOyVqJ9VO1+U=;
        b=JAXyft9vhskvWnlB1Y1xytzj+y9VwvvWYDq/pZVmLV7AqX/w9PbYgApjUJzJ8JxscB
         y0Ij+NdaAkNrtCn7pWalCfswatpbBdvXTCvGZv7MplryvKL+5v1O+O88gW28rP3Rm5tl
         KlUczJzXnAFHQMBUv99G8rJRAHUGM3ttQspODVtz3SCGaAoz/5XWLk51IXXaxNrlTNti
         +tHRGElgQHGoElDUP8nFPCNlHfAd+1vOUDRFyJD1hx3UPu4oYG6YsMTMAto/b1aJPUsU
         aJJf/tWjJ2vnDaorfmUjLTsnqtJ6FM9cr6D2ZUBIfufPyWsyMwOm0++36sVxzyF5WEfp
         7CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779357227; x=1779962027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/NgD71Wvnu+OP5PxEvXZ2CGKc44UcNTOyVqJ9VO1+U=;
        b=gaJAGpym5lqcZ9qnpciah0BZaJIGgmCL77HWOuO4VXpoh1ceL4IFy9g6Urr6AP7xm1
         GtfteXEeQx0Ct/702oA7Oe5wGnyjLpxQEsOuA0Sn136YdlI6RNc5zoZj+JPgVeyMR5KV
         Ir++4spy5QQE9KYv5kHPzQjpMxPNmpJrrIhSQ7lYM9uHMmngsUyVG6qowKSqf76m1+ZM
         9fvXMd2f4SX1Bwb/iI7LCjVSl7EZHOTdkXnyg2VUKffotB68A3H7GiWZsarEWDiXMxMq
         jzZ2L3HzWv/B67YO8HrJAkrBb0CIrv0uB+ZxVyXszj+RuUWEd1wmTjsuyDvEPeC2jhwO
         pZuQ==
X-Gm-Message-State: AOJu0Yy6nVs9HRX6lVYWs+knmgs9l4nDVYNa4+n1IVEfFJhQWIUGOjX0
	BMy/0D7elbPNVyZfNyVnqlWZsc0JkyS3nVtTRABf2AnlpySfmQMAWGOevlcRV0YzjEiFAeLt4U1
	4XgnpzxHk6rjoVx+G3rZpop/BTR5FXyKUDLfzHkTQ
X-Gm-Gg: Acq92OHgaKFZylov/Rt+KgYZXbhpkhC/y3J6rEuRwKc/v5OJfUgYLkb5wEMFPiYFPoK
	TJ9uBwNg0yk/uKmOTdKdbGuL/GlMApsQo7fMXcvfYSC9VJesuX+4IcnXGG8V+wyeXTSHtZgQEGH
	ISB0y2Z5y67hU05QkERFoAA8/hIfhE6Exaogn9MdYKD2b630dw3rKOFGBMURdwQmpGuWZqeqyHf
	PvL3pFRT5VAVQBvfq5yqGIUrVqbMdkRa4esVqK/vIUDSJtLKtZZD8NEZ518dS4K8i8wS/hp4DA1
	oN/jJWPlFQs2H9t1Qpk=
X-Received: by 2002:a05:6a21:3382:b0:3b2:b1e9:f1f2 with SMTP id
 adf61e73a8af0-3b308275d38mr2286818637.4.1779357226950; Thu, 21 May 2026
 02:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
In-Reply-To: <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 21 May 2026 05:53:34 -0400
X-Gm-Features: AVHnY4KUwVPEQjF1GizXLp4WVWBoiWHYn6PhaDahxztAl6JVbxenVtHA1P8MNz0
Message-ID: <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com
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
	TAGGED_FROM(0.00)[bounces-290322-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: B03935A2F54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

::

On Wed, May 20, 2026 at 4:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, May 20, 2026 at 5:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, May 18, 2026 at 11:42=E2=80=AFPM Rajat Gupta
> > <rajat.gupta@oss.qualcomm.com> wrote:
> > >
> > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > not account for the runtime header offset added by typed keys. This
> > > can leave part of the write region un-COW'd.
> > >
> > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > the actual write offset is known, and add overflow checking on the
> > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > offset_valid() against INT_MIN, where negation is undefined.
> > >
> > > Additionally, linearize skbs with shared frags upfront to prevent
> > > silent data corruption when pedit operates on zero-copy pages
> > > (e.g. from sendfile).
> > >
> >
> > Sashiko makes the claim that:
> > "
> > ....
> > .....
> > If the payload part extending past offset 0 resides in a shared
> > fragment for a cloned skb, wouldn't skb_store_bits() write the
> > positive offset  portion directly into the shared page, causing a data
> > corruption regression?
> > "
> >
> > It missed the earlier code (before the quoted code is hit) which is
> > very well documented!
> > /*
> >  * If the skb has shared frags the user is likely using zero-copy
> >  * (e.g. sendfile).  Those page frags may point to page-cache pages;
> >  * writing into them would silently corrupt the page cache.
> >  * Linearize so pedit operates on a private copy.
> >  * TL;DR: if you want zero-copy, don't use pedit.
> >  */
> >  if (skb_has_shared_frag(skb)) {
> >         if (__skb_linearize(skb))
> >              goto bad;
> >  }
> >
> > TLDR:
> > If the  skb  has shared frags, it is linearized upfront using
> > __skb_linearize() which means any risk of modifying a shared fragment
> > is non-existent.
>
> It seems there's a second sashiko ive been made aware of - these
> things are just multiplying ;->
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.2037-1=
-rajat.gupta%40oss.qualcomm.com
>
> Both points it makes are valid. Dont have time right now.
> And infact looking at the second point sashiko 2 made I realize I was
> only paying attention to externally shared fragments which the poc
> used.
> So probably the sashiko1 had a point as well. Anyways i dont have time
> - will respond by am tommorow.
>

Sashiko2, claim 1 (rephrased for brevity):
"With the pre-loop skb_ensure_writable() removed, tcfp_off_max_hint
and related use is no longer needed.

I was going to say "separate patch" but since the cause is this patch
that removed the use, at the expense of a much bigger patch we should
remove it (delete it from include/net/tc_act/tc_pedit.h::struct
tcf_pedit_parms and net/sched/act_pedit.c - as described in sashiko2
claim.

Sashiko2, claim 2 (summarized):
"..skb_store_bits() will memcpy() the tail bytes of that 4-byte write
onto frag pages that are still referenced by the original clone, so a
clone held by a tap, AF_PACKET listener, or mirroring path would see
the modified bytes on its shared pages."

This is the same claim as sashiko1 but sashiko2 gave a much more
convincing description ;->
skb_has_shared_frag() is only true if the frags are flagged as
SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
frags from eg a driver on ingress and that skb gets cloned with frags
we won't catch it.
One approach is to do an if (skb_has_any_shared_frags(skb)) and then
do a skb_linearize_cow() but that sounds like overkill.
Another which will make the patch even uglier (but less expensive) is
to add an extra check insde the patch's "if (write_offset < 0)"
to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_writable()}

cheers,
jamal

