Return-Path: <netdev+bounces-49910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF47F3CA7
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 05:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BB01C20E7A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF60BA25;
	Wed, 22 Nov 2023 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="StHdttqR"
X-Original-To: netdev@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D2193
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 20:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1700625781;
	bh=WyAShApkDdBPwl2YIcs5L7o6ggYYCKEIr+CohnIiE+0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=StHdttqReRqB113S/1/8A2J+KS6E9/syqzuCcV86z7aWExzC34utdq7S1ZpLsazsd
	 ToyQWRX7uQyZ/vrhH1rYwn3h3qZF576qoKbHN0hC243gPhcJ/g0ngOgl2T/L/fQfLX
	 4EZ8T+yMElNnSy/0SLytVzQYTzf9c+FsD9qGlsvE=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E820A66B39;
	Tue, 21 Nov 2023 23:02:58 -0500 (EST)
Message-ID: <cbf497a2aa3c1dcb83fde103b231c31b791ccb26.camel@xry111.site>
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
From: Xi Ruoyao <xry111@xry111.site>
To: Andrew Lunn <andrew@lunn.ch>, Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com,  joabreu@synopsys.com,
 fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,  chenhuacai@loongson.cn,
 linux@armlinux.org.uk, dongbiao@loongson.cn,  guyinggang@loongson.cn,
 netdev@vger.kernel.org, loongarch@lists.linux.dev, 
 chris.chenfeiyang@gmail.com
Date: Wed, 22 Nov 2023 12:02:57 +0800
In-Reply-To: <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
References: <cover.1699533745.git.siyanteng@loongson.cn>
	 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
	 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
	 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
	 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 04:39 +0100, Andrew Lunn wrote:
> On Tue, Nov 21, 2023 at 05:55:24PM +0800, Yanteng Si wrote:
> > Hi Andrew,
> >=20
> > =E5=9C=A8 2023/11/12 04:07, Andrew Lunn =E5=86=99=E9=81=93:
> > > > +#ifdef	CONFIG_DWMAC_LOONGSON
> > > > +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_EN=
A_AIE | \
> > > > +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
> > > > +#else
> > > > =C2=A0=C2=A0 #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR=
_ENA_FBE | \
> > > > =C2=A0=C2=A0=C2=A0				DMA_INTR_ENA_UNE)
> > > > +#endif
> > > The aim is to produce one kernel which runs on all possible
> > > variants. So we don't like to see this sort of #ifdef. Please try to
> > > remove them.
> >=20
> > We now run into a tricky problem: we only have a few register
> > definitions(DMA_XXX_LOONGSON)
> >=20
> > that are not the same as the dwmac1000 register definition.

You need to determine to use Loongson register or general dwmac1000
register definition at *runtime*, not *compile time*.

Or when people enable CONFIG_DWMAC_LOONGSON (for a release build of
kernel in a mainstream distro the maintainers often enable as many
drivers as possible) they'll suddenly find their dwmac1000's are broken
and we'll get many bug reports.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

