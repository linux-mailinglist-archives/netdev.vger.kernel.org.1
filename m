Return-Path: <netdev+bounces-290715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIRULzEMEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68F5B0450
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CC630AD9C9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5C37C903;
	Fri, 22 May 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsuiBQI4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CF72621
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436215; cv=pass; b=XOMAaWZUMpmZKR17Yag8N9XsIQ1477eSvR5RBR/DmHuQ1r+yqQDfgDMI7gc12yfNCFnxeHNuPVG5lYOBBi4egZXKf66WeD42gRVXaINFqIrpoREESJj+J1iiiaLF+wrZrGE45Se4noPYF84ceP5VjmLdqCpa34d6/SCs1Nx0Vr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436215; c=relaxed/simple;
	bh=sBKPbvVh8rZyxB1CUqLTVxA3LKQYZlHsH0ye97vd7Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLzCvbn3oYPV6IxMS9PC9csLYV010uED4kKwbCTb7BgfI3T/Z6WVnbT7oa/WB1wZSO/DaaXH+Edh3p8kX9VXK1jx8ocPYsN2C1LoB4oeGa/keTZYlENsCjoF506lbjjjr0Cm7ObAfA+765AyvTiAYB+0wsxDwKNvRxqlPS6WSpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsuiBQI4; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so3715537a12.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779436212; cv=none;
        d=google.com; s=arc-20240605;
        b=aVoYqTmEaDT0WTKxcUgxzUrfM2SYNUri/r2zyYgJCuvWfS4py/irgf46skLTtL/MEq
         MEPlQXoO5vK/4ld/uBOJ4RwStjSsfjo2jZPL2ZNUHJN4bK2aoF9R0X/lvUaG4CQwSjlN
         hloQmHPUoJaH0MVR4XHMFO5pE6YLW/ZOG2sUY//B+pzlRWTsnj0/oII+0iJqC0Oew3sC
         lqXjvVU755v6q/hRKuQWDeal9vfzf+iyUGxbWJ8bVpheUVgJTs5Zs4Ag/otFqkadYGbP
         vmdA6sVcYpS0puVltbdSxq7Zrer/8cpXL36mRoK19X28iNIOz35RO8UjEIKYZoQJond7
         Fbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgG1Vz5eRRJtL8VkMuX6m6NiZAhSKljIsOoLMSCZ26o=;
        fh=+mi+/wgop+WvyLxhkWlLCMdA4/w/PzZYmEJxaw7j/Ks=;
        b=B+UZRKDFaUxYozc+6Ws4Arc5vPzDLlybSagRtB1X50cxOT8ubWJlnO4FrI4EyASWSd
         mbDggQ6rJxkAeeCe2oGjq8NQVZaOGXp/wfa4aI6RvX3gi/CZ/c85Q/ZQxQ4F2DWG4qVG
         OBDgp7L16TndA5ljWjhOTOt73MEvQTxtUTmd/IhKSfvr/K6P88m4OBTSYZaO0WmLbfCw
         rrBF8e8CzSmwBW67aC9Ff2qvvda/ekrwT04IJQ/AMwJb3Sjkue5EGq19axnqkuQNeAoF
         P0z9/z4q9wekM1gDW8joBlaf57NOJMMtSBGdFROJcLYvSsdhlyYQet1a6IHcwX5T4Gdi
         yndw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779436212; x=1780041012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgG1Vz5eRRJtL8VkMuX6m6NiZAhSKljIsOoLMSCZ26o=;
        b=SsuiBQI4UIyRA2ydYLgvu5oBRPQVsUBh0Uzin2p9uKOwEOjoFQ/Oa4/CAPu87MxYLg
         cPXjTUEzhpXuyycd5VxPNGRUjDB9Ws4yZOKvKspPlzLhIgMS+rd6bz69dNZSa4kdM1ng
         BXE3tC2m4RV+NcY3IRFLyw+KBBI8QZt3BDnUpUdnEPfrpBhhpv7lslTiFJtR+KPxURl4
         Q++QeoPrGr9baoSLBp6cmKJlyZrWEw4ciVp9YjYyL8ufF6sDuAAzlQ1wnainWM84Rsb/
         S0rli8niM2xBbtdHAxy9pAUOezVVFoTsHxxDjBfJBImo5ZijanVIGbwyTRlzvWxKW7oU
         1lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779436212; x=1780041012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgG1Vz5eRRJtL8VkMuX6m6NiZAhSKljIsOoLMSCZ26o=;
        b=F3EfuU2ET+uSFT8XK6Y3nQ9WXXOWGOQY6p4V9i4i/bH73Qu7Uy1t9Txmy1ZVsf+LPr
         JUaIm8OL55CWHm2e9Z/QO51aYGMQxvtbT0aMqPAbbXgCJvnxmHF15bVQmuUTt0kEf3UO
         vtQVkiF6Ea++OPjEg90aIXRto6nhq0RAYenx7OhUfTUU+CnWRpneOq3qLnAIHTsGj2+3
         tx5VJ+mU3DlrEo5j80Hy7eT4it1a1NQgMqbghIkuJraADeXcdqMlD16iBH4Ihl0Sf9sJ
         afxvybG6sJYZLhQPuRqF6Z7/zkdblUs8kb1ln0KNj27t653yc6UR7qTrDi4381/J6idG
         QYaA==
X-Forwarded-Encrypted: i=1; AFNElJ/UQagIm6DmRIZU3ppZv4qzVNpPBE+thyTC4PR5AATSVO76unITS9ZNkUNdNr4oVi+DAL36nL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuGHx8PvR3x0HAQK1xf53TKaMuQQzd5uP71jQAX2t0zWXK1vB
	MWYS2eQWRoZGJDSFz5irZLFDwQn/ZrW5WrKsX84h9jaOlpJWTBM5Wy6uTACvw8Vvm5GQn5t5cvQ
	PDlW/IaTeE59UILirnNenzJu1LrVi3KM=
X-Gm-Gg: Acq92OEPL5cnRKAeR38Z3tnSVoF1535U9k8mdTSR7NRFy2fGPvvWbsB45WaaOz3kZ96
	3zZp2ZKb5fCLtqEnoLS8pK8JzxCDQPI5vzdHxi/4a+C/f7ZoKq7AvmYcZE5AzSQfFoKJADJMzLR
	gD26/Aqcbu0p6JBXNnOMPW9hc950XWpnST6GEIR+fp/aMOuXkuhefI/1rXafUGqCKrDwoehePHz
	UVLbAp+LnHvxFbqdI++EAgGSFI6SO9nvgwqQm+i22WcmLO1NsOPyrS6yWcS32lNmexkwPT4X53b
	DvS5kE0=
X-Received: by 2002:a05:6402:d08:b0:678:a507:e837 with SMTP id
 4fb4d7f45d1cf-6889c4080a8mr1138238a12.1.1779436210240; Fri, 22 May 2026
 00:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com> <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
From: Han Guidong <2045gemini@gmail.com>
Date: Fri, 22 May 2026 15:49:36 +0800
X-Gm-Features: AVHnY4L1T7nyhwpCILNAhG4jRMfZlxsYUZ5nOkdJVts-lY9fkvq5TVfZla7rcwE
Message-ID: <CAOPYjvaiZ73U-zpUv_A-Kco-BgA58k4ntxeGobXQfFBdiSqjvA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290715-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: 2A68F5B0450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 6:15=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, May 21, 2026 at 5:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > ::
> >
> > On Wed, May 20, 2026 at 4:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Wed, May 20, 2026 at 5:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 11:42=E2=80=AFPM Rajat Gupta
> > > > <rajat.gupta@oss.qualcomm.com> wrote:
> > > > >
> > > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > > once before the key loop using tcfp_off_max_hint, but the hint do=
es
> > > > > not account for the runtime header offset added by typed keys. Th=
is
> > > > > can leave part of the write region un-COW'd.
> > > > >
> > > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > > the actual write offset is known, and add overflow checking on th=
e
> > > > > offset arithmetic. For negative offsets (e.g. Ethernet header edi=
ts
> > > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > > offset_valid() against INT_MIN, where negation is undefined.
> > > > >
> > > > > Additionally, linearize skbs with shared frags upfront to prevent
> > > > > silent data corruption when pedit operates on zero-copy pages
> > > > > (e.g. from sendfile).
> > > > >
> > > >
> > > > Sashiko makes the claim that:
> > > > "
> > > > ....
> > > > .....
> > > > If the payload part extending past offset 0 resides in a shared
> > > > fragment for a cloned skb, wouldn't skb_store_bits() write the
> > > > positive offset  portion directly into the shared page, causing a d=
ata
> > > > corruption regression?
> > > > "
> > > >
> > > > It missed the earlier code (before the quoted code is hit) which is
> > > > very well documented!
> > > > /*
> > > >  * If the skb has shared frags the user is likely using zero-copy
> > > >  * (e.g. sendfile).  Those page frags may point to page-cache pages=
;
> > > >  * writing into them would silently corrupt the page cache.
> > > >  * Linearize so pedit operates on a private copy.
> > > >  * TL;DR: if you want zero-copy, don't use pedit.
> > > >  */
> > > >  if (skb_has_shared_frag(skb)) {
> > > >         if (__skb_linearize(skb))
> > > >              goto bad;
> > > >  }
> > > >
> > > > TLDR:
> > > > If the  skb  has shared frags, it is linearized upfront using
> > > > __skb_linearize() which means any risk of modifying a shared fragme=
nt
> > > > is non-existent.
> > >
> > > It seems there's a second sashiko ive been made aware of - these
> > > things are just multiplying ;->
> > > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.20=
37-1-rajat.gupta%40oss.qualcomm.com
> > >
> > > Both points it makes are valid. Dont have time right now.
> > > And infact looking at the second point sashiko 2 made I realize I was
> > > only paying attention to externally shared fragments which the poc
> > > used.
> > > So probably the sashiko1 had a point as well. Anyways i dont have tim=
e
> > > - will respond by am tommorow.
> > >
> >
> > Sashiko2, claim 1 (rephrased for brevity):
> > "With the pre-loop skb_ensure_writable() removed, tcfp_off_max_hint
> > and related use is no longer needed.
> >
> > I was going to say "separate patch" but since the cause is this patch
> > that removed the use, at the expense of a much bigger patch we should
> > remove it (delete it from include/net/tc_act/tc_pedit.h::struct
> > tcf_pedit_parms and net/sched/act_pedit.c - as described in sashiko2
> > claim.
> >
> > Sashiko2, claim 2 (summarized):
> > "..skb_store_bits() will memcpy() the tail bytes of that 4-byte write
> > onto frag pages that are still referenced by the original clone, so a
> > clone held by a tap, AF_PACKET listener, or mirroring path would see
> > the modified bytes on its shared pages."
> >
> > This is the same claim as sashiko1 but sashiko2 gave a much more
> > convincing description ;->
> > skb_has_shared_frag() is only true if the frags are flagged as
> > SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
> > frags from eg a driver on ingress and that skb gets cloned with frags
> > we won't catch it.
> > One approach is to do an if (skb_has_any_shared_frags(skb)) and then
> > do a skb_linearize_cow() but that sounds like overkill.
>
> Yeah, this would be overkill - imagine running tcpdump 100% will be clone=
d
>
> > Another which will make the patch even uglier (but less expensive) is
> > to add an extra check insde the patch's "if (write_offset < 0)"
> > to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_writabl=
e()}
> >
>
> To be precise, something like attached (untested, uncompiled)

Tested this and it looks correct.

I used a small kernel module to inject a cloned skb through the real
tc ingress path with a crafted layout: crafted skb_mac_offset(),
tiny/no linear head after skb->data, and the rest in a clone-shared
frag tail. With Rajat's patch alone, the peer clone could still be
changed. With this added hunk, the peer clone stayed unchanged.

Thanks.

