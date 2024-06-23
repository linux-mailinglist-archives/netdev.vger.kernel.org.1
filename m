Return-Path: <netdev+bounces-105918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4259138FF
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CC5282BC4
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F253EA69;
	Sun, 23 Jun 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NdiA2RVv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9515E83;
	Sun, 23 Jun 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131004; cv=none; b=MqHLrOpOaweDA3YWzEtScH44X1tiBWjMbqXcCiuPFYYXBGwZbD0oWorofbY84TQpyf1a0so9uo19SqxzEnzmORNuuWlyNSKDfHEyy1IYk1vX+HxKpCv2rix2SSyBUj2grtWUJdPQTWiZYVaMabrOdEJujkQsOAh1BbyvHt1FDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131004; c=relaxed/simple;
	bh=x4e8XcpJNZymn97A0V+osWFBR8uTIfDjYcM2vgAnIeo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ACucUB34BifkxlCoBo2rTbQp1Z+73LUhFXXNt2jcQyf13AHiwPSyf2xl2pilwBH9YUh3RYoInvdFT7Hn71NujcZ87fv0B1IgsKLku49dbeOzcyIudbvtpuuu0cBrZhVqvi837uhPfAR8eNUH0eM1BoME4enfckqBLEzHGxNBmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NdiA2RVv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719130963; x=1719735763; i=markus.elfring@web.de;
	bh=3B2iF2h3ohW2JdPS8V2ghJL3k8HTmL/3Td3HOCrMzss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NdiA2RVvQGEA4DentX5eZomaqbxNfyu3SCPJV+JnEt6X0V5NNBN1Qk5EXVYhyDVs
	 aiy26951PT2/GNhiFyC58q1L+eBcwrrMGi9cl3op1vwtmaptaGTuMpe4ZvqaYn4qd
	 V7yQIt24ascbaOV45UfvLLlwm0tNLm72tKDjp8/iknnFw7GRgPikB4p/BjwnxovjR
	 N66JjVFSPVXLBKq5lmoPSGNdnTQjH6h2nKZhZF2Ja1UbR8j03noyBKrkugrKM3Msx
	 Egrec6ZdS1N/Cdn0dVR1rDmNvc0M6TXeBr0nFvTn8AaV9Gjo/g1XFmZm9mKp2kbMF
	 oyU4Kvq0RdLj6bOe5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1su59G2BYf-00otqA; Sun, 23
 Jun 2024 10:22:43 +0200
Message-ID: <b0f546d2-bb6a-4761-bbc0-69d785df5eef@web.de>
Date: Sun, 23 Jun 2024 10:22:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, imx@lists.linux.dev,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <julia.lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Waiman Long <longman@redhat.com>
References: <AM0PR0402MB38910DB23A6DABF1C074EF1D88E52@AM0PR0402MB3891.eurprd04.prod.outlook.com>
Subject: RE: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AM0PR0402MB38910DB23A6DABF1C074EF1D88E52@AM0PR0402MB3891.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RhNAOB7zwVYK3MyZH/sACZ3FmkNf75gEXEW2BT7QSpSBf0753Rp
 qxqGiNuMFwtHShwF3HQF6FJuw2OOXNo9PcDQlx6D5bwxSaGScX8q/YohwGjYOVmXT3CT+Nk
 zudjRI8k1dTix64dpcyf4lml8eExuE1yKO2PvxawoYK4gp2JFwTT1r5AASxFBetnZoCi9P0
 aw2MkJbScBbF0GoCgHtsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jhXu7Ls7F4g=;6Ol0DqOJu0Cat9xBMdFBH/JNn7F
 7uNpSp0hXWxU7rgj96/rMmcOM3lDx/DzvfFL0KOQHK2qnAmaPvIt2bzYcdYJDl64v58GZSRWz
 eBdf3AfspiAzL147WIde3OHc0IvRnPaNYPTAE1Tqe0pdChr0HeYEMUg7CUVxyoSFB2ZjUIHmu
 kyffBJ+YVO0rX/F8q02746kUyyrquueB+X+sDnNIT4sRm9efYOKNTQKhGak7IdUVBdaQ9l52F
 SH9qa1kQGiazmMamsGjVlD9yF9m6qzDerHJ9oB3C9a6ebzTkcCffquqeXVshRrt92iEZZjnFp
 TY1jdiwZ6/z87RrIeks5DHOM//G0d6WeEvmhmj2U1/H9ZxF2yVajcGLKod5mBCDWl4ijNFUqd
 M6PXREASPi1XnsjK7HQD+/edWkqNs07P+ncMAOirxzX7DFuOL3yzKb2DH6sjp1+23yFg687WF
 D/MpvIVjgOAUeUhnT40b7W0si00/8t2cIsRSJUZszbb4NUaElNsViGjFk+WSO9VR8uj0XbWQ0
 O83XbGlBgpv1qn2mJYjV5YmHSaPa/22c4WJISlpa69POdUZaRcCSxelkzo2Nmc+mMtFUp0rb3
 kmz3pnPgHM+HbDfdtXsdRsfzRDntin7jbh9zWo5Kr46+TuJpyCr3Bh4yRGI4bCfKGAFLP2JPc
 FG/uzSq0WYdNe0YJ8mrTXjQGC5PaPpbgQVDMfmwaJBZ4yQQJjeJDE1yQ19+pn7K3kOwS8V7l+
 6j1n++fGvKdt2dFOYMZSX6z7T4mJrCEtZzmniQjtljsLRC3PhWD9JWppDh3bw7Z7f9eUE9Cl9
 QBZ94z4RHzqhenRQz+bpF79hPbK06jWI115QI9rozXjLU=

=E2=80=A6
> > > +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> > > @@ -99,18 +99,17 @@
> > >   */
> > >  static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint en=
able)
> > >  {
> > > -	unsigned long flags;
> > >  	u32 val, tempval;
> > >  	struct timespec64 ts;
> > >  	u64 ns;
> > >
> > > -	if (fep->pps_enable =3D=3D enable)
> > > -		return 0;
> > > -
> > >  	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> > >  	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
> > >
> > > -	spin_lock_irqsave(&fep->tmreg_lock, flags);
> > > +	guard(spinlock_irqsave)(&fep->tmreg_lock);
> > > +
> > > +	if (fep->pps_enable =3D=3D enable)
> > > +		return 0;
> >
> > This is not obviously correct. Why has this condition moved?
> >
> As you see, the assignment of ' pps_enable ' is protected by the 'tmreg_=
lock',
> But the read operation of 'pps_enable' was not protected by the lock, so=
 the
> Coverity tool will complain a LOCK EVASION warning which may cause data
> race to occur when running in a multithreaded environment.

Should such information trigger the addition of any corresponding tags
(like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D)?


>                                                            Of course, th=
is
> data race issue is almost impossible, so I modified it by the way. Becau=
se I don't
> really want to fix it through another patch, unless you insist on doing =
so.

Would you like to take the known advice =E2=80=9CSolve only one problem pe=
r patch=E2=80=9D
better into account?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n81

Please take another look at further approaches for the presentation of
similar =E2=80=9Cchange combinations=E2=80=9D.

Regards,
Markus

