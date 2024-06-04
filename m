Return-Path: <netdev+bounces-100545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418F8FB120
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D6228325B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575E145339;
	Tue,  4 Jun 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWcMlLRC"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD31442E3
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500591; cv=none; b=gJQz53cR6angnqOfDcGcasW06CHbzhfDNkRT75+pfeGHtlIjiLaeyCiFoIrD0q1RD5ZYFGToXPp9ImxzXSHnCuIAQYU2pg1fv32vhUtn0RLLpDfkFQLObglgRvvWmolf3F02+dLMPbs2Vp0NV3oAxX+fY+9eumolXAeUd5GiChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500591; c=relaxed/simple;
	bh=dWWSNUqYDN5ry/z+GcmaaaXs7Riv5UKJE0DQmHdqdws=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=P6AJfNym7HKbA3OlTg0EelruBCgzoiKbdIn6PEPCp5tKaN5TzutrlCzIzSaJcUL2xqOlPaVCGKlOBpzgY9pSHMY553KApFWPp5MdLHm7k6evojzsCtk6D+chIWjGjW5pV0WIbElqwNk2GLy+NtcC5ROYNiBEYIEzEUFUDgJsPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWcMlLRC; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717500586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAxVotTNa0Ga3e/m4xN4nXb1+mWjuU+gf6eQphyby0I=;
	b=PWcMlLRCBWwEtb1zFIyOreTVGGZx/8yGqFqegFHe3jnkpGSbM4OcpEFp9L7PWL1oDzSlXq
	E1D/Hp7UEG0ZmQ78SG5+ViySuTfw5KUflDkGiAU1XmFlAGVuQ/Reh66hVBt7WMVItYllus
	cL2iLNzMKmQlVGW8F56LneAabK4nke8=
X-Envelope-To: chenhuacai@kernel.org
X-Envelope-To: fancer.lancer@gmail.com
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: andrew@lunn.ch
X-Envelope-To: hkallweit1@gmail.com
X-Envelope-To: peppe.cavallaro@st.com
X-Envelope-To: alexandre.torgue@foss.st.com
X-Envelope-To: joabreu@synopsys.com
X-Envelope-To: jose.abreu@synopsys.com
X-Envelope-To: guyinggang@loongson.cn
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: chris.chenfeiyang@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Jun 2024 11:29:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Huacai Chen"
 <chenhuacai@kernel.org>, fancer.lancer@gmail.com
Cc: "Yanteng Si" <siyanteng@loongson.cn>, andrew@lunn.ch,
 hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
In-Reply-To: <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B45=E6=9C=8830=E6=97=A5 15:22, "Russell King (Oracle)" <linux@=
armlinux.org.uk> =E5=86=99=E5=88=B0:

Hi, Russell, Serge,

>=20
>=20On Thu, May 30, 2024 at 10:25:01AM +0800, Huacai Chen wrote:
>=20
>=20>=20
>=20> Hi, Yanteng,
> >=20
>=20>=20=20
>=20>=20
>=20>  The title should be "Fix ....." rather than "Fixed .....", and it =
is
> >=20
>=20
> I would avoid the ambiguous "Fix" which for stable folk imply that this
>=20
>=20is a bug fix - but it isn't. It's adding support for requiring 1G
>=20
>=20speeds to always be negotiated.
Oh, I get it now. Thanks!

>=20
>=20I would like this patch to be held off until more thought can be put
>=20
>=20into how to handle this without having a hack in the driver (stmmac
>=20
>=20has too many hacks and we're going to have to start saying no to
>=20
>=20these.)
Yeah, you have a point there, but I would also like to hear Serge's opini=
on.



Thanks,
Yanteng

