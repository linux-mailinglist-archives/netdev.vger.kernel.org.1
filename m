Return-Path: <netdev+bounces-289884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKR/MqiPDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2558BE39
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C78BC3077610
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D63D890B;
	Wed, 20 May 2026 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aliN50wN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4F3D1CD1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273457; cv=pass; b=uoLVrnmkf9dmT41cEuIj98cxW/r2cdRiHD4RaHoReR/sSZfwrFJKavdzA5swoClrDK8jlJmiSZwp+a8Auo84gthopRlnpxd94L875I2BXGIKJZ7g0c0WajVUx4WMZrGhJQvl2R86UgoYYm1CclESDeRQ+K4lMGKQmKyOQBlOpmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273457; c=relaxed/simple;
	bh=VlViicmk+1v30D9aNrApLr9YZ1aJ9aCUqM4mwd/sKqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Isr4gbpYYGcwEs8Rt2uHRE3Ej0NIe1pH/PzTdWX66AqIAeaWVzvz3/RYnLURXERd+IwJXR8zWikMjHqyw9ss11WOv9gM4WDgmnPWCQ/jfRupeF3uJ5QCNSBu+SELHKIH6QbeBLpSF+1A8dEDp1767HXwhpEQr7W/LRlkIOWDk7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aliN50wN; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so8148487a12.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779273454; cv=none;
        d=google.com; s=arc-20240605;
        b=DttikiLIy7B3g/wBZYyncH2A/JwT5oZFwfECw08gac+V4CWRve+M4XhbMTNdADN05U
         cO6HYRjytL2Lh2MEAtypqELGJuvHv9DISDSj5Dlav5eM5+hIzb1zO3h0K/5BD+NPr0jr
         C/k/tmUCGFYXpNHB7pdSzhZqCDGXFYGILFpmXPxsLsGPH6p4QoaoVRvG2TuK9gldAA0E
         VkCH29l4kxKeVunSDOxDdBi2uZSiQnHoy/RLSNVM00olcG0JB0a+H4omHgsw8pZRzk4a
         o/C4HP+iKTGX0RMgQL195FhACl8PbrNfngmk9Zi1rZQpNT19qIG5RRLf3I9yBbTvYRZK
         F6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VlViicmk+1v30D9aNrApLr9YZ1aJ9aCUqM4mwd/sKqs=;
        fh=KyyqsPcfitIqHZkip3yoANomIOu7xBdsaDvxQc4AJCQ=;
        b=VIX/I3AKXmed0UByxnXChSSFg/N45APAq0cdgUkei6drw6kQMUXtiRg35CTGniZ5RX
         rY4FcOA6bBS2gtS1sv1NsMZCqPnec+3KdJjHHJTp2X2uWF2IouM8yHDdBgJmygfW9hPG
         aN2ST6X2ENhT27626id5c0s/io1mlJMFxymhOCJGMKmVf+/deuQ/MOSjXCab1qbhyKpl
         6icCPO7nuhss4My5pbjHu6++rlvuzDWMtalIwbK8zsdifbH5GpiceId9CqGU+AeFF5I1
         jRQ4G9LBsizd5P7rVIUxODcc4g+G40dcklEwATO/4QnR7D9b2ZiisaTHvYIxO23aLcwQ
         VfVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779273454; x=1779878254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlViicmk+1v30D9aNrApLr9YZ1aJ9aCUqM4mwd/sKqs=;
        b=aliN50wNOnpkP2GHlmnPPC07klXsA3jsg0hhWC02uFVB9JK0T1JaNt1fkJdQcS0zCx
         U4HMxcgB/63MycAscwgPjBONIOpD4o0EuUWGtSpOwtlfWwKxv/9xmOaXl6S07ge6D+oL
         wpvKfo0b5R+xijzvGRBb1IrfGrz7XvJDOU4LKp1fzCtGxn8ciKXf5oYoSaULivYnC1sN
         jx5/zlRBWB9AUz5IJ6GSsdnhhNUG1VN9SX+gi/F7tpUzzH0xTufye9OI14exCFjqPgVD
         JirjYJ7p8IuTKBFj07Tj0Snj6GB5aFFLA7wQFrPkoyi30H9DxHmenDgcp92rH58z146R
         y2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273454; x=1779878254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VlViicmk+1v30D9aNrApLr9YZ1aJ9aCUqM4mwd/sKqs=;
        b=eq+Iu4MGEdiyc6FfEomjkH2b/w/t9RnZST131nZ08FwZjo64f35029LDLuduQWANA+
         /HpvH1S1LDXoPQkL+M5k85cE8K2sl3Y3+q8HkfE6TnrabY6lV5HOVuUF2fuQeGJDZHpm
         1VPcZuHIdBkRFhNb32YSbbT2qM25SP7nvudndhIjzCZH+3aLgv5tUcNHaC4pomna0e7g
         eHmNKYDn98I2+KurA7XEz8zalNI9L7CozXR9eGfn5eqohSooBQ41+16GCMRVhAyJRRUH
         Tiv8eEq2PAyz6kMalYD09xRKQsPEIxZuARq/pUCgAQJ6s+EtAaf7/EWT3SjiYcJSZlqr
         6pEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VfUX3tYPB532cuqv4i4oZ0P9Bdpjz4UpmuqwOVf+HTx10JRWyPAXwo9MwQv0V/BUEmHc6xtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLqVRqRb9IZGtNDKrENvyjHb2D3Uog9Y4yUEtY1KesYywkZkE
	4ULSkLKQrddwWXQfcr5ZpylzxmgCt8V0sfnsKdW3RUqWQek142cPgsZFn2oq9B42cE/uxkIieJH
	gDBBfSOdDlxBDHQ1K9OYDBVL02zX7ZII=
X-Gm-Gg: Acq92OHOHIUV9RQGvWuFGK1tPD69Pz63DMWTKv1S2Fd8d4Tr7BACIBX+SnI3wnnc1ic
	7On6sfNL6IFjTZmlaUnsoPbjhbtjyeNmfgaDiCA9X/pxEwYGd+qRZFDL5nbFgQPt+4CI2WGvSoY
	Ia9u3bo+hln0qAYCtNDMrUEdWjaRjCTBmvzlUOjsGDoaIu8ztE47XPPWoqSuEHkiPnTXxuOi7mE
	yQVQmwmiLWaog/uN1npQNFiEjyce456Sre5cf/Qq+UcmS7NqCIaxtZCxhU/0u/ANwJxMjR9Hcdk
	6RDGMTZmAtwa5SP5kg==
X-Received: by 2002:aa7:c14a:0:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-683bd68303bmr9037447a12.19.1779273453744; Wed, 20 May 2026
 03:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
 <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com>
In-Reply-To: <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Wed, 20 May 2026 18:36:57 +0800
X-Gm-Features: AVHnY4KsXJAUg5CqT8fPRaCwKDHcoYkcWtt-5YwQCs2cgknN7rH4MQOcCeNIZqE
Message-ID: <CAOPYjvai8o1ak_iCUPUbwi339TXgL6rdTq8L-mcAn=ZGQeYQGQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 48A2558BE39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:12=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, May 19, 2026 at 11:11=E2=80=AFAM Han Guidong <2045gemini@gmail.co=
m> wrote:
> >
> > On Tue, May 19, 2026 at 11:42=E2=80=AFAM Rajat Gupta
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
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> >
> > Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offs=
et")
> > Cc: stable@vger.kernel.org
> >
> > I took a closer look at the code, and this patch is really addressing
> > two issues.
> >
> > The negative-offset write into shared head/headroom appears to be from
> > 8b796475fd78, while the shared-frag write, and thus possible
> > page-cache corruption, appears to be the later regression from
> > 6c02568fd1ae. So it may be worth adding an additional Fixes tag for
> > 6c02568fd1ae,
>
> Pushing it a little - but sure we should also point to that commit.
>
> > and I think an explicit Cc: stable@vger.kernel.org would also make sens=
e here.
>
> Please study the rules.

Hi Jamal,

Apologies, I'm still a newbie learning the process. I checked the docs
and saw commit dbbe7c962c3a ("docs: networking: drop special stable
handling"), but I'm still a bit confused.

Did the rule change to allow explicit "Cc: stable@vger.kernel.org"
tags for netdev?

If I completely missed the correct documentation, I would be very
grateful if you could point me to it.

Thanks for your patience!

