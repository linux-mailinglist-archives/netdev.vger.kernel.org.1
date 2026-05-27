Return-Path: <netdev+bounces-292425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO1IKN83F2os9gcAu9opvQ
	(envelope-from <netdev+bounces-292425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:28:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F36395E9080
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC579302BA52
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEE3EFD13;
	Wed, 27 May 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="MeK1NKm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E43FD94C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906341; cv=pass; b=DEI9b30nIlNwfH8WkUjLvFx/Czuz19LMcysrk7q8frXed0WPI2ZRGkq0fNiell2BDme8HQcHDWBflW8o4zNDswdOKyl7LT/U2kczrkvkLFV4Zz5yc73uSl8+9eKieeF3n9OSh5lE9B6HMjypPVtjYobjKzwgbow41ozCbFn17j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906341; c=relaxed/simple;
	bh=fyvzl1r3YSuIM4P7Y/9my7fcSb2d/cJ65mLIkItASmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjP8wHIrpVNIQdhse03CezCx+dwDb50sTQ4CxyR5I2SgHIVJKbtacRKh3lgGTLC09ovVgYOWSh447CrG2tovrX2HMeKWdoriz4bSI2PXpXlTFSZOSbpQeQULLscmC1Zw9pdpSED4DrFOdSE3UMXfFh5pNGtHHtzH3jCj/GlkU4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=MeK1NKm9; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so8704894a12.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 11:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779906339; cv=none;
        d=google.com; s=arc-20240605;
        b=bLy5bFbw/vZvz4anhaGFJuPzdUqggCoJ4VpKcI58Q+jVs8zw3tM9+AhRTyqnqROQEu
         T920UH8ubCOUBPy0uo+0sQDZW04SDmboWudZokWgbGnnqjpK5m21032qIt+3BSx/a0pT
         KOEi0IqdXrAreZ13ot9ze7eIY31ruwqtta7n0uZuE+9BNmaCP/q0+erV+mtjlRoDt2n8
         e8SaSH6qcAg1H0Kg93uGGDB0tH5+7DfDDXla0itGI/jzblKC1h6EY0ZNM9QnjrG9EKN1
         pQ2pGrqg+5CDmIVfjVDhqtfFibgl4njyGZfuvgZVgYlg4S5Blkvdr7xl+ec74NxzNzuq
         s+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bYGQXzXXLkAHyIIE6GsTyR2TD2fkA+qDmv25gUpApHI=;
        fh=rfp4E3aVxlF6BnAAFae0KKakBzRhpfmAG25DFfdn7/o=;
        b=Z2/WU00mYeYHF2cIh2vrr1Zk8hodhT0pq4g22nrQbTm4VnuQwvUrrsCf89+UxbPlvd
         mQQPugmyNK8z5mDXpjYzKRVD5oclKA2CG4rS/00I3U4fWEFW91ltgoz2A0hit5Qz+1Ts
         uhQEIdxrVvtgSgTvOW5Jl3XWlKMAghv9gpQYeMjgU5ziiGIRr2KZ4MOVUag10nozgQKR
         57bCfBpRnSwLxWXXuzwJU/v3q9w7jrLN0DXT6dJ6GSDAe8E1EUG3i/MsypnPq4/vJjDq
         aY1YY4VtxFjB6NRfiYN3Jf+aNLEqRU9ROpojEVFp8ehIaQv1hB57Yd7R7QRnw0s3vUXY
         RnXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779906339; x=1780511139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYGQXzXXLkAHyIIE6GsTyR2TD2fkA+qDmv25gUpApHI=;
        b=MeK1NKm9wZCdP3ifU8TXxI57amow27qWLK5TiLpm0LFJrDXXVN48xXDbnTURSUoa1r
         ijsyDw9Q5INPrdJH0XDdv+305gDDyITPqMfTh9TAbU/RzrPfFpVvNjUmepUG2/rbG0Up
         RbLFvLPtt2bxkXeKKnyMA+QMo2A/EU808FlQPSLf+3XFU0Bt2keDmKlOfDokEbzIBgqX
         2q1fDH55NlhDsLw9P8Xe/Ynsrlx6HAuSuDI8oYt79qsGjHlbNVulrOpLxwjSS5l4tHvi
         5ygr/lP8cWoawcf73vWstE7rjRfYVJ8NU3BAU+6oq7z1CFT0R2UUxI13MQK8UNmLaiNX
         W3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779906339; x=1780511139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bYGQXzXXLkAHyIIE6GsTyR2TD2fkA+qDmv25gUpApHI=;
        b=W796NN1NpdPcaaCwQEpwVa9A5ZVVWSvK356FdDSdfdIccfCrWDY1tW6Rplk2CRK+NZ
         uWpOgoLLmzA/QbbuRVZXgiCvI7fWUCLkXcWaC5YAWv7SHOuZ5g/LzltXBODMYTz78I3S
         7psABvkILqPEi9gWJ/8yoBtjBKbcpZ7HfYcSK4grVjL1QO6xZVvJEYuxH2bmWsHptDXu
         wAnXUree4wqezQIMxSfNtXyQl5iTIscGzuPvqvGOy9U++LA14UWPqQZE2x/KhfGmS5lQ
         UrPPuIQqeQAcpvix/rFkpWGcle4reBHD1XCoFuTe3bOEWBl9k24Vw7fc1Gv4LA1lgwjz
         yZ3w==
X-Forwarded-Encrypted: i=1; AFNElJ9hiWObsfNd7CgvpsNFBMRn26QEKjBgZfHpqylko5Ni6g29q6QY6fZpf5zfmPqbkbt/dRGDKLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vjRADDw1fwuYSbUEl/2wyG32mqTx9RLgql8BU+X4FEsLei51
	6pfFIhXoP/tYaPYNxFPtx0kwDnVrj0pA8Ztw4fi/Gr1Y5UYVGQkb+1UG2C3fYIg3h+7rJ0okEty
	JohvFwe/ew7/ASf5nTzcln/LvTYRRa5eAhThFrsVe
X-Gm-Gg: Acq92OFkzXKJZ9VUdposzkJ3XwcBCbs6KL0D7cpe+Uer7IOLbxI9gqGE3+0O/4DGFh6
	O//+MXxntntallJrD12A3F9jJd4W3S0D3voJCyNZaX/owZ1D2bqLEfWPG6gb8yma1ux7+ERUlzR
	L/zLqc8pTKxBTDixFw6lU7g0jXfjXZMY3c1z5ovXDDdUgCmuAcX4xI6GuVV9rxH4iMqfLx0TfZu
	/u4BgestibVyZ7FwAGCBnoiHDdm+0Kl8xES6BLma67C5eqCswGo5Ae6PPh/CUKNmsFbbh2+d3ff
	ttGM7PtSnaVdI98zvaCnTBO0F9NSm1SmQOfUn/Vz
X-Received: by 2002:a05:6a00:39a6:b0:82c:e83d:a9b0 with SMTP id
 d2e1a72fcca58-8415f552ce6mr22950285b3a.21.1779906338849; Wed, 27 May 2026
 11:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526155913.1060694-1-jhs@mojatatu.com> <87wlwq2cxf.fsf@toke.dk>
 <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
 <20260527171310.0d5ed340@pumpkin> <CAM0EoMkwoiJ_LODqv_taoDTLvfrAYwPyRv2oGyP5P=q1b+1+OQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkwoiJ_LODqv_taoDTLvfrAYwPyRv2oGyP5P=q1b+1+OQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 14:25:27 -0400
X-Gm-Features: AVHnY4K-C7n8wn1-bp_373mGPM5SmDZXb9pg5bbXxZwK_fLr6KoIJxehPqN_-LQ
Message-ID: <CAM0EoMna=w7tkN2GqZXSf74VjNqQ3HWxrr7JxFm4RoL-Aib8Ww@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com, dcaratti@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292425-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,qualcomm.com:email,mojatatu.com:email]
X-Rspamd-Queue-Id: F36395E9080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:48=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, May 27, 2026 at 12:13=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 27 May 2026 10:56:57 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > >  &&
> > >
> > > On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> > > >
> > > > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > > >
> > > > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
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
> > > > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb=
 is writable")
> > > > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > >
> > > > Re-ran the tests, and everything looks good, so:
> > > >
> > > > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > >
> > > > Also looked at the code, and I have a few nits below, but I'm reall=
y
> > > > nitpicking here, so whether you end up fixing those or not:
> > > >
> > > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > >
> > > >
> > > > [...]
> > > >
> > > > > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb,=
 int offset)
> > > > >       if (offset > 0 && offset > skb->len)
> > > > >               return false;
> > > > >
> > > > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > > > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> > > > >               return false;
> > > >
> > > > This change makes it really obvious that this is really just:
> > > >
> > > >         if (offset < -(int)skb_headroom(skb))
> > > >                 return false;
> > > >
> > > > so, well, that would be clearer, IMO.
> > > >
> > > > But then I guess the same could be said of the positive case, so:
> > > >
> > > > static bool offset_valid(struct sk_buff *skb, int offset)
> > > > {
> > > >         if (offset > skb->len || offset < -(int)skb_headroom(skb))
> > > >                 return false;
> > > >
> > > >         return true;
> > > > }
> > > >
> > >
> > > Yes, that improves readability. If i understood the discussion betwee=
n
> > > you and David L. something like this one liner would be reasonable?
> > >
> > > if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))
> >
> > I doubt it will be measurable whatever you pick.
> >
> > Thinks, can 'we' get away with the much more readable:
> >         offset + (int)skb_headroom(skb) < 0
> > No need to worry about the '+' wrapping,
>
> By that you mean if offset was _very large_ then things will overflow
> and wrap around to a negative number?
>
> > the first test will fail.
> > Large -ve offset are going to stay negative.
> > So it does look all right.
> >
>
> To use Toke's code golfing analogy, maybe let's just stay with the
> last optimization I posted i.e " (offset > (int)skb->len || offset <
> -(int)skb_headroom(skb))"  ?
>

I sent v3. I added names for Tested-by/Reviewed-by but because i made
change, even though they are simple, please test if you can. I dont
expect anything to break and Victor reviewed and tested already.

Please no more changes. Hold your tongue if you see some missing comma
or period.

cheers,
jamal

