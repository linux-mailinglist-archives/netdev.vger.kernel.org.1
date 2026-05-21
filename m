Return-Path: <netdev+bounces-290423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPcnLX4OD2p7EgYAu9opvQ
	(envelope-from <netdev+bounces-290423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:54:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8915A66F4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54E56319AE1F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D304014B4;
	Thu, 21 May 2026 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiaHe+gJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFC3E1CFD
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368891; cv=pass; b=OBEpF4M8nWRECbGq6KrPbbXcNvLF7c+p5zSLJc4l3NGBrpEjpbYjxU/h5frqDJMnH5DrfyAOlEgG7LiJXqQ/VlzHu/qC2+MAfOJs3FY/OKnKrq9pWDUlEYphdWsN9TZotxk0YNtSWIyAsT9SCoe06eM3wQI+YeYUAHdbUXzoeaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368891; c=relaxed/simple;
	bh=g8N9Jxfh9vj5aW2BbWJ5uDPhpDGPw8QkpqCpsud9jsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxHnc1zmhRh/iUh7A0pPg1iuKpwwPPsQDWTIwAUwBQFSeHf2j+iDhvgGCaYfHNjD8G6aRHz9GXIceOrj6x30dbJMkvLUsz5v0LxT0gfxREuj2WpM9zovLirtC2OJzZJcus1R1LTZ1bQelxUsTbmxuaGoSZ7dt50KxWdxctHcRVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiaHe+gJ; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39556b00a85so50686731fa.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779368888; cv=none;
        d=google.com; s=arc-20240605;
        b=IAN3qlerpoZWtUVEpt5mmclezpr7ZTKp6flj7DbtMIkGMpaxqDmUbsTHBgUnJVx5vA
         Sud+8JYNb1ytvE/u7tPB5PMWy/jEWPPw84yV8K5Fqj7BoZtiorkoEm32TfeSC9y6CGqC
         3+ltaEL8hSLKCdq7t4H17cJyrjdv+IkAZQCeahn2s1dqF8Pws3rjQNWy6jfiFbHRtZTJ
         +cxLrLoIfX7p/INwdFaTdNqrk8qw1Wig6SDINmBI/ybK9YZ2CL0hNbQtEbLUlTpAeUTK
         1oKv0wwbtcw3osQtDQlEv7e/e8jh1pqJxOZA0E8uGL/4vTLZuRR5Z0DH1fx6gZopW2sN
         7/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        fh=hobeBBLoIjII5cgGtka22xOC2BBxOtGjVbApBbzfHAY=;
        b=XD7nrjJQEZ5MEBHZr2iEU4/SDCJaBPNTkb1EvOj7ZutScutC3MHY5evGEPifxEcLYF
         MdgNA5Siv3gb9iFYuGHEK/2M1uP0IJLTZ2yJrJWX7L5ikZekLglMS6sLvpv85VH+5ilY
         h1z+diqd8C+HDsCxIZF+7Uka5Rb/aIvNSfixno78mbQcT5mljMIJLyamEK+mMSa16hug
         ZSyNLDLgYPdWbcd5L8c7Aq4JyLHRSPiWOrdcftGMSpHl3h0RYANUPf5AcmK1TDEIALTN
         +8VtOURngF2bn622a+Co+PPvQN7/NUZeqeutQUKt+PvcFMUZtm+XYw8qpxXGb3+N7vsZ
         239Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368888; x=1779973688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        b=UiaHe+gJ6tu1ZsWczZOp855/kdK+HqXaPgr6gv30PGsaSd6mFF+3k+dUVEW8QmyxPz
         UQQjNtdaonsBtL1y8uv7MDsmuDCGtRZe5aCxRgcwdItVxArqAzfOT0htC7GsbVx2pcWY
         4s9tY3WeLpUMytWvIhfPmd61//S4xF+qw+nCIYCLFjm+mXZuQUB1uiFQxBHCKJ08bduE
         5lw6K6RB5cuDzsxMt/AceCR5kpJnHdc1niIEiyr3xwIfWm/RUtOIPhqX0yE6IfhofUea
         ZfulAOHzGGmAFrBzsVmHLAYLXmFejYaHNy2BAkOAcsLyGIPUr1lfVd8WbBS1IMLLIv0K
         6Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368888; x=1779973688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        b=fPpxF/pkpJvsPhDyOT9l1BDLG4BvT/gg4iETW5iUCQ1iZn8XcylIOFcW9YTrTQhV4x
         VTq9l6B5N6exIh+ynTFm2x976kg+xdAqiH+w2tXFFilX1YinwCvuWkHBK9EysQC8I0BJ
         ZRXfaFVSMxFNe9hgS2L4uG2lM1IEJlvEZCHcnyI+siWrpzFFMk05/o2sxVtmDOft6BZs
         Spige3hj0h/4vSbuXcniL2hUsH5946ag+mgYhNKqTU/QJ34WedpoxJPq3ZxhzLHbYFwm
         7pAYy54wEL+Nq6IRas7+h3fJ9zv74NzuWOlk28rRgnSxXUqkomYtV0P6ZhkODSCHElei
         eW3w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZoOi4rKrPIfJ44aRHVtGkL1opyBLd81GuSO64JK+VLVYax6ikvZO5hzvUNQ6MOOKJoo1bZ3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLawNnfc+EcK9wv9oHCTUa+d0vGVHX6wVqWgeuQF3tYFlXTYpn
	8xqGNWqtLgDCErYPv8xPDH0ZaR4nu1pimNnVcEGM6m4KO3mfRBdf6mM/viOJO2qC5FLqiEQXbBM
	mH3RVsdcGwTJ/+cb9FBf4aDsuZwf7toQ=
X-Gm-Gg: Acq92OGdy8MzQIAuI/wIcRBZK1JUzLzDhguz/tY49wudwF1zfU2et1pqIqQCvkIbY2p
	PphEhml9u1wXm1OM0LtE0b7DHiQ3tkmMtlEkWd/GPnC2D5VDhAz9bZqqukZchayYRfZe3Ij6fWI
	a5sKZPhNB80BoP9ylBP9Msp4Qru6hkuffUNdV+0QtnNNzPs0cBMwYYdKohE//640fHVqbJpsgxI
	KYZlt+y9NXEwWvqqx+vfHs1h8Z1ro+hluQ2GjGYcvQ/1W0+7k9ZPZfidSx/Dyb8RKbDQIOJj+AR
	+GJbKvmpliz2kQL+S1cTsRkz6VE9DZeXvGW7xCo=
X-Received: by 2002:a05:6512:3767:b0:5a8:750c:2f79 with SMTP id
 2adb3069b0e04-5aa2ba69be0mr766870e87.3.1779368888045; Thu, 21 May 2026
 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer>
In-Reply-To: <ag8ByhbrNNJaESYi@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 21:07:30 +0800
X-Gm-Features: AVHnY4L0irZOSzas-U-4vMjoJZWIjS-Nu31vumax-XgZcnfqGCmdnfBoPgQhD9U
Message-ID: <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290423-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 9B8915A66F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The series is the product of previous review from sashiko[1].
> > > >
> > > > 1) META
> > > > patch 1: address TOCTOU around metadata.
> > > >
> > > > 2) PUBLISH of CQ
> > > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > > >          overflow occurs.
> > > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > > >          publish its address when overflow occurs.
> > > > patch 4: like patch 3, but only handles the invalid descs cases.
> > > >
> > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljason=
xing@gmail.com/
> > > >
> > > > ---
> > > > V4
> > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljaso=
nxing@gmail.com/
> > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > >
> > > > V3
> > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljaso=
nxing@gmail.com/
> > > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > > overflow case (Stan, sashiko)
> > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > 3. adjust the selftest to make sure it passes in either virutal or
> > > > physical machines, which includes add usleep to support physical ma=
chine.
> > > >
> > > > V2
> > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljaso=
nxing@gmail.com/
> > > > 1. adjust selftests (Jakub)
> > > > 2. add READ_ONCE in patch 1 (Stan)
> > >
> > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> >
> > Thanks for the test. But I've tried with ixgbe driver...
> >
> > I noticed there are some flaky tests which have nothing to do with the
> > series. Can you confirm that it's not caused because of the series?
>
> That explains the different results as i am using i40e/ice which have
> multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> Broken tests are from mbuf cases.

That's weird. I never expected the failed tests to be about multi-buffer.

Are they the same as the output you attached last time? Or something
new? Could you please share it so that I can investigate the root
cause?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> >
> > >
> > > >
> > > >
> > > > Jason Xing (5):
> > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metada=
ta()
> > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > > >   xsk: drain continuation descs on invalid descriptor in
> > > >     __xsk_generic_xmit()
> > > >   selftests/xsk: drain CQ to wait for TX completion
> > > >
> > > >  include/net/xdp_sock.h                        |  1 +
> > > >  net/xdp/xsk.c                                 | 44 +++++++++++++--=
--
> > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++----=
----
> > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > >
> > > > --
> > > > 2.43.7
> > > >

