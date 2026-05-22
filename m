Return-Path: <netdev+bounces-290796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DgFJKpEEGpqVgYAu9opvQ
	(envelope-from <netdev+bounces-290796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E715B359D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED14C300DE2F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE13CD8A4;
	Fri, 22 May 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="HkLjccJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23021346E7D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450612; cv=pass; b=r5ragjRzauvKquM9uL4g1TLXdNQJb10yAJEvLIXo00hpFF081YRC8Gs1i4R2LcBTub3cBKlgRtFA5i7vXbi3/+bIObEUOezTBoZlmOHMP2JopHzk4c+hg1AEA+Uhqy1H1keAbKodJJpc2f69aIY9pJTqaMG7B0g6t4rNNE74C0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450612; c=relaxed/simple;
	bh=R6xTu9ITn3BiEaEnWcaMUebDRNvzwlGb/ld2546sUSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF+6YuMg4ASPhs+SqFhdOJvj1DrkvLZcWYo1QzcncxNVvPIOHk2j6EIeSPZeLDr8As3e7brJzaxRdGooUYfrXZKeG6XuCZM8uJXZ8veceJ0H7tEzPiV5k57UnEZ0HBkr5qRSvLEnB8vs9lwNBI5+US9v5utjZI2VrXPT3V8tC3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=HkLjccJC; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so3375379b3a.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779450610; cv=none;
        d=google.com; s=arc-20240605;
        b=KCaLLrnR0S7X8XmoZoWqY/ixGhHTzMGX23BbCZP9xCihTKn3KxTDyp3BstdaIirTtg
         GOHGshN72ViuDdIaOy8xw7gutJdwp0RvHsi9iq4dEk6u5tCM7h7rQkSFBw0xhkiIzBbq
         d42tqRp+4IF12jyC41ih3aKQWakPplzSiKgRthxwoSdg4AUkbLigMx4n25D7SPwMrSc4
         cQ6z+XZHGaWor+zh73Oos/0JsfMT8VEa6nZUn130B8yUOsDzvcU+kdTf8gG41/qgOPS0
         FhveVNh6/yKAK0d6bQHEtGmJcvFY7gvp1hPBVaa5c2DioXO0HRGPcPVfRwtnfyvsOUv5
         47Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPnkZIW9sqaFI/evQzG9duCQF+9dbPV4XzLdJR5es9c=;
        fh=MIDAyHMXMpR2leVayTRHcdjLZpoR8TvD6MY4fctXEeA=;
        b=jsgYICZv7pwUfxguzAklw7NKHbZDA23h9OcJCtCfd94dq1HFKYlzyipTs48MzoALye
         B5A2IGIUssObO4r8Tg6p6FcVFQ8JU0DCQdfUu8dgVnnVwMTT8LaeutnyZnln51+J3sM6
         D+yvUcQz3vCqsFB1ij/1vnF+iC3JLNdMHmFOdB6wNxaWyURu7cox9HeTnLqPSVOdMzTQ
         dl/K8Mu570p618EFFUOJzg6MF5EQP1xJI2tv1qp67dSILDFog9zJRc2yHPb8+nXnlDhp
         mn4z0+uE67lMBlQjo0LaqAld9oGvzgnMf6JllYkpFFeA4nqJuiYRoXTaxeLUo8FPwf+R
         vuZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779450610; x=1780055410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPnkZIW9sqaFI/evQzG9duCQF+9dbPV4XzLdJR5es9c=;
        b=HkLjccJCvpgmg0xj5pvTf8ZvkH1gDOXIngTuMKd7YhsPU9xKzdudZLKOutZft92Ui0
         fGDUABCl5wpXmUugCQyghNI7TulXxz50dhxQHLuXlKKh7LgYTd/aI1703GBvRxvWw8Tu
         EwtA1th0nLX3XfjOEfnk2a7O2cwMDSbNCyMpN4Rp9pYP/zolTcl6a869N7RSJyXSLi+G
         ntaNxucmKXNcyYaKRxfluloaj2p59wDzYj0kTKeKuWbCZv4yJlU1SMg2F2nKUsCGRSqO
         N939VLuy9dLhUZ9X/5Eyl01zLBH9MWf/r+iUH8ZIj8UAYl+Q/GoZPN76Cak191JdunU2
         ElQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779450610; x=1780055410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPnkZIW9sqaFI/evQzG9duCQF+9dbPV4XzLdJR5es9c=;
        b=NgTjhoDyQE0jWZq0weSPDAfANnYNx5tn6Q7KNWJb00BfwxiMf3f464sIbFmlStPjlU
         Q9bt7pEckFzrDWilvn6LEBET5Ns4EpgiEaKkNQEg3tmGad+5OY5HnucxrJmqm4KNjzoC
         +7ibBGGRjXAE6uEv+/Su/GruuILHHRu6RAeEbUx99WIvHX5O8EtSJZ6ib9DXxFCodgW6
         maGDY+vH3ttg+drcDdl2bGYted3fEqgabff0Qq9hxFRq3TpkkKOLDEcjmsehE4/PdzPh
         Fz0ptOL5fsSvhXjjf6t7T/U3+oQlCY1cNjx6u3xtwGHIl5jjnUFRs/KSaPzMV2b7OZGn
         ntYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vwYcW0FKTe6vfcoRHUspnqL5ER10K/wgHgF2fKPrRb3mABbG3PiDUQjDJXSFbzyYLJ8+Pgv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlZJTKFr1I1UlNDJQWv/mCzAu84x4XqlXz390J9ToSOcyWnbA
	eDhBlq7p1mkXSk4tAwKCD06UrBliCxtf+dvLfi/fvPeSWsS0cpiZtgOfg5CFqUzY5uFYBUKekCB
	Jts91+xuhyjB1aqaFKP2aip4W/mNSzRBpF1R5oeoa
X-Gm-Gg: Acq92OFkTxXLkfTURLsoOAnbLMA7zli1aoW2WzH3FP8Vb9Ooz3IslRKxMau+5iGKhyZ
	1Jd473Jyp1dztiBjq1oJOmFxNGQ463jfI1fvbtdocXYLpyUC3sixCc5ykqSvgNO+y1h0c7Np1cC
	i/vrQAqdBdzjPEN1ZnvtWVVhM1gLeYe605VjypJtPBUxCcPgJA0BGenU/rLKgjdcHPBPCY7SxNy
	O1IS5qqP1zAkAi/9cIrkD9EnI7cY2rDvdiLOLqDMkgslj9+OpEKNaaSeXnvLGUhqwJ1ezEhtDlT
	EqcpZqXRxRNjRYCJFLE=
X-Received: by 2002:a05:6a21:7483:b0:3a2:d436:acb6 with SMTP id
 adf61e73a8af0-3b328f966f1mr3438659637.37.1779450610232; Fri, 22 May 2026
 04:50:10 -0700 (PDT)
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
 <20260521073526.793d30c3@kernel.org> <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
In-Reply-To: <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 22 May 2026 07:49:59 -0400
X-Gm-Features: AVHnY4KKjMaG7qwe7IkEx8pZnbov3bHtaqNJRboQBiScLGo86m-6YpVAstdDVqU
Message-ID: <CAM0EoMkANSFw7AxAX3opcnJhzd_qchosW8nFVfWV8wEkdL9R9Q@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Rajat Gupta <rajat.gupta@oss.qualcomm.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290796-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,toke.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8E715B359D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:51=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> On Thu, May 21, 2026 at 4:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 21 May 2026 06:15:17 -0400 Jamal Hadi Salim wrote:
> > > > This is the same claim as sashiko1 but sashiko2 gave a much more
> > > > convincing description ;->
> > > > skb_has_shared_frag() is only true if the frags are flagged as
> > > > SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
> > > > frags from eg a driver on ingress and that skb gets cloned with fra=
gs
> > > > we won't catch it.
> > > > One approach is to do an if (skb_has_any_shared_frags(skb)) and the=
n
> > > > do a skb_linearize_cow() but that sounds like overkill.
> > >
> > > Yeah, this would be overkill - imagine running tcpdump 100% will be c=
loned
> > >
> > > > Another which will make the patch even uglier (but less expensive) =
is
> > > > to add an extra check insde the patch's "if (write_offset < 0)"
> > > > to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_wri=
table()}
> > > >
> > >
> > > To be precise, something like attached (untested, uncompiled)
>
> hi Jamal,
>
> I tested Rajat's patch with your latest addition; it compiles and passes =
with the same subset of tests ran earlier by Toke.
> Agree some follow-ups can be done (e.g. removing the hint, and maybe anot=
her smaller thing not yet detected by Sashiko) but AFAICT you can add my Re=
viewed-by: when sending v2.
>

Thanks Davide. And a Tested-by as well? I guess the same goes for Toke.

Rajat, please send a v2 with all the feedback once we hear from Jakub
what he thinks of keeping the shared frags check.

cheers,
jamal



> >  Do you know of anyone modifying payloads with pedit?
>
> hi Jakub,
> yes: MPTCP kselftest does that on purpose, to mimic a middlebox and trigg=
er DSS checksum failures [1]
>
> [1]  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commi=
t/?id=3Db6e074e171bc5cc83eb91b03c2558c2d9fccf26e
>
> thanks!
> --
> davide
>
>
>
>
>
>

