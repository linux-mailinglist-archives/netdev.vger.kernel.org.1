Return-Path: <netdev+bounces-300113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3+KBZBzMmqy0AUAu9opvQ
	(envelope-from <netdev+bounces-300113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:14:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7C698588
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:14:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L1a8Soi5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300113-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7DDB30315FB
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175C3A5E7E;
	Wed, 17 Jun 2026 10:03:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29153D1AB5
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:03:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690636; cv=pass; b=MkFZFkwLI3cq9SNnlSCIX9KBD9Nf6Mr5P13OqgOKeHdDqLJzSnibLMwDSWiMyg0juNuJcfD4auEprwjpW2yVsX+PLeKvdhNVte8Dw/mbSmi5p3dDn+A0yVOM0xKliu3HxO0N+BaWGqQ7bMMePZa4MYozEspImsk+iRJDeVKIwiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690636; c=relaxed/simple;
	bh=uNWxnj3qi2+ykxztSlNloYhZMOqtxnahieXViRSeMXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxImqkyxmgt5WMvQQRYi4xgDMMXc/9NNnOgv46TlnsJwut9Tsn+V9Q/Hmz6C64qNAtKyGKRSGc1hX2cRK34vanTe8sZhWY1t8egt2PbjCk3YMwycxCY06+2lzv3mAcZ+nKMujVoaXJ1W0TuEjHtF7sGawZA9idryZGpvkWHT6gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1a8Soi5; arc=pass smtp.client-ip=209.85.208.175
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-396779b9a7fso49031931fa.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690630; cv=none;
        d=google.com; s=arc-20240605;
        b=giCZDgGlYi2G1ljiNg06QWvoi0Dft5x440OmlPqmQPtNIt832okgkyj16OCdF9aMP5
         goy8jtS3BE2JKftWnDzQ8iYhquwgaDN4gq3O3zVEQot+IEYugnsEsWWIYxMm05UFFEgh
         WESL1+RbG31v3Gl/zc2E7rkRxTvZvuF+PNHSOxMkztb9tGYcC//JEGS2eZx9p89EA2ON
         fJ7PcLvEowASg0GWr0zZYLWuAwIwswsgdC6ffO0t1hJLcr7RjF6qa7iE0E3PqzmEfjik
         raQ6a89EYNSEZaNuyzK43QPv+48WNf7DX/d7E5TEWPtTjjJgrs4HiUTwsROInURaSO+0
         t/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        fh=3kzS/4SB19xlBTYh1pplyjjqtV6L/f7C+a6pGOCVbDk=;
        b=IdV9lrwmGyFJBloCEgFmKJA15w2rTxoABG4v4plVwBHkiSDvnc3O28YohOuv1cL2j2
         5BoJKRAeXsxMauyI9ziqA+4HrHvdRkehMQEldXnVotvRWV+yLPpNBGYedtPXoxC5ECUm
         dFuou6B2w39mI22ZdxsCdoWyfQViKWf49wtJGd6AHhH5lPb8sOLb+F88xCuDJ7Y7d5rV
         H1C8dPUj0KAFZatxOdlihSG4Vu8oh7beKWGL/oblDob9T2+MnHbna+jFeWx99kVxRK/Q
         yl0vFSLqTJtVcuHzAQ70ygtUcALus6oolYhMA4kfpJYG8wRZImst0bHV9z9mWSM+/PeV
         +1iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781690630; x=1782295430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        b=L1a8Soi57fiumVgzxWUfcNfs3kwh96pLANkcqdK4skZehwSXPZpYsr44CzVspx2Fb4
         TUePM0UzzUk/1h/w9Agj3oBlsfGbE8D3fxdo0sin4/tBSiLTOoLoiv8JS3Rbyz1Z2HbG
         xPVLM54kZpbZ87LtexU9rk/s11TE6oGo+DoZX04tOgaUJ7Sb6IFUw+ipviO71CTT+2Kg
         rX+RJvQcVGt+bD7an+Ez7OEsx7/oC4mdRutKk133MlIu4qVnXZFNOhPLYhxtQTfN4Md+
         YAUVEiqTG+xLPse0n+Un7K3WUNx6M3F3w+Hjmd1XlkbhhYHMdLQPJaixjaHM0agZFmnT
         vRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690630; x=1782295430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        b=NBumP7ZQWPJL3O3BmUstVUS7Qdp/N12IZAFApE7JHA5s8Q+JZNDL/GrWSH36y3/DB4
         r93YmunMieKoUNGixh4Kje/HuWmwzpJiYfLDXeuk1QDcGioRiDVYWplGHQR6e0zDRwz6
         X6etuwzccO+fB/WU6L9hITG8XcCX4SU1XEybiXdaFgAwaj/E8eUqPpUhGrjLGJxFKVMk
         ar1hRWzum/EbwTJu6vO9XcbUwa60dAiSYXd4q0uM4nv3nQR9l2baY4adYZZ/i9+hlmrI
         u1eeLKAGqioBhqAFNlImyEJKJKWA4G/WWfQCVizOMDyvVvUWB9cy/L3/P+18kr2ExrhS
         ARmg==
X-Forwarded-Encrypted: i=1; AFNElJ8kTah9uP1rlOlvTm5+J+XSLzUUCuwo88slKxLX4yOnbU5fht947qUHCwzL/tt5BP7sfC1uejw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoXXy+4ArNj1tSRrkyLlFYkrSF7ZddnupX/j5/kV2kMNCCWa+
	0+IBTMj6lzoGou7mx42Jg44GVUUYbpKd4czvb5SijWFkZvdowr8quY4nimlcA0twGmfBOe6OcJG
	IrGm27sWBIawX7EoCY0qHtQ08Trwkuv0=
X-Gm-Gg: AfdE7clNbv4m9wl0szYUMSpTXfgZyalaJggAlDWpv1zzgG9bMP5JwHj2gMqHRHVrpdE
	dTsEFaG9QX6aXaqFBsxhZkya7Sti7TerqOSIj2D/ciryz5aW/BtidlnwtMNSoeTJ5Vr1xSIPXdV
	h4WYpz1tdBVSgPCLRIwEduVytxZUCR/XDya3JGsApER+vUiztTzi26O2Z/nxKrjwT0YqaPFyE1q
	j28RnJAs864WVSCNKb+wMNOJ06MuPKNpE0Mj+B5zLeV3xLJMtHMhDE7tSMINf/2TF99c16EWPS7
	VH1gGoBoQA8z/t+IObLgAg0vtohGNH8hVLvtcYZFx4LBePhDk41gsQ0bjhk0T30oiJHaWymblIz
	ljQT+26ko0WY=
X-Received: by 2002:a05:6512:3c9b:b0:5aa:6dff:cf1f with SMTP id
 2adb3069b0e04-5ad46ffd388mr940205e87.45.1781690629647; Wed, 17 Jun 2026
 03:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com> <ajJsMj0QMOF5I8qq@boxer>
In-Reply-To: <ajJsMj0QMOF5I8qq@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 18:03:10 +0800
X-Gm-Features: AVVi8Cdp26ThLaA66Ypf5qUBe6fIsAARte4Jy6SOTxHSkFiChwA96WKCdQw9Ckk
Message-ID: <CAL+tcoD9yf9kTTK335RjTiFL5FrigXgNs650O2Lnu8_LxXRhwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300113-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67C7C698588

On Wed, Jun 17, 2026 at 5:43=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 17, 2026 at 07:39:06AM +0800, Jason Xing wrote:
> > Hi Tushar,
> >
> > On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
> > <tushar.vyavahare@intel.com> wrote:
> > >
> > > This series improves AF_XDP selftests by making timeout handling
> > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > >
> > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > dependence on RX UMEM setup state for timeout behavior.
> > >
> > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > before worker startup, removing signal-based termination, and using
> > > barrier synchronization only for dual-thread runs.
> > >
> > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > configuration does not leak into subsequent cases on shared-netdev
> > > runs.
> > >
> > > Together these changes make timeout handling easier to follow and
> > > improve selftest stability, especially on real NIC runs.
> >
> > net-next is closed, but in the meantime I'll review the series ASAP.
> >
> > BTW, another thing about selftests I had in my mind is that are you
> > planning to work on this [1]?
>
> This one is on me. I took your changes Jason and aligned ZC batching side
> to this behavior, followed by xskxceiver adjustment. I am planning to sen=
d
> this today EOD, however let's see how badly internal Sashiko will kick my
> ass.

Thanks. We'll see :)

Thanks,
Jason

>
> >
> > [1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing=
@gmail.com/
> >
> > Thanks,
> > Jason
> >
> > >
> > > Tushar Vyavahare (3):
> > >   selftests/xsk: make poll timeout mode explicit
> > >   selftests/xsk: fix timeout thread harness sequencing
> > >   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
> > >
> > >  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++------=
--
> > >  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
> > >  2 files changed, 56 insertions(+), 42 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >

