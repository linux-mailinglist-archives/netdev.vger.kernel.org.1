Return-Path: <netdev+bounces-207749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B5B086BB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB0C170373
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9425E44B;
	Thu, 17 Jul 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="G1B9l6E0"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1025BEE5;
	Thu, 17 Jul 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737467; cv=none; b=VdO6psYG5/Rt9aujQqOCQ5ywX+o/OUij0yujgyUoHkeAv5B9/y5BHT6fDdicbXRbZw6l9KSzbTb+Bps0oNBt7vBsaXHFtGd8CNN52BSCvozw1PXrhTJ0vVc4sB6LSuhJs3Smnhm9mnSZUmARpBYmtcMBPclz0Ar5YKo9ttegRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737467; c=relaxed/simple;
	bh=TMp26SXyORzd+n/zV0+SamSsljiSBhP4fSKZp0oH2GU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFHarwjBtNTr4Cej8FO7ZLokHlbaHwsCtcBKWPTXRAk28mf4fgzLT80o1BfFHfCW4bxpcGlkgV43xVjTrSuxAikYFNMUdA8dTB0HUetc4ShWHLtcFt49MtkyU8fwe3Xq1KXrBeNTTbYN/rVnGdiswsrTSHEO4kRH7cnJGZOzZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=G1B9l6E0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752737462;
	bh=TMp26SXyORzd+n/zV0+SamSsljiSBhP4fSKZp0oH2GU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G1B9l6E0K4QzPszx5EqFcLqac7SwGkUewuoUYM7o0g8/Cq/guuhTVla9eSF6qmcEg
	 xxCI8QjK/ncbR3H9s28wwgLawwu816IK/fzRlZdmzheE6/9NTG5vfLgdQfM991znFy
	 U+ALQGnOg4IkH9BnqHmd2cyQIOwl0yvfNHH3rAukI6kxFINsKU1lKDEENhha/2iwys
	 tif8ZpmvwQmngBwAnrcErjv/E4tI3JyihuTPH3nu+G8nM6rST3CpNwzN2UHa7IUSif
	 Ao54FDjFSHt2z2YKKVpefkDplaDYu/EuvndeJhS+NT5yx4AP3LHolsBwIv2CnE6Jpj
	 iCHMxBoORSmQQ==
Received: from [192.168.72.164] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 53AAE69703;
	Thu, 17 Jul 2025 15:31:02 +0800 (AWST)
Message-ID: <2fbeb73a21dc9d9f7cffdb956c712ad28ecf1a7f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: YH Chung <yh_chung@aspeedtech.com>, "matt@codeconstruct.com.au"
 <matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 15:31:02 +0800
In-Reply-To: <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
	 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi YH,

> From my perspective, the other MCTP transport drivers do make use of
> abstraction layers that already exist in the kernel tree. For example,
> mctp-i3c uses i3c_device_do_priv_xfers(), which ultimately invokes
> operations registered by the underlying I3C driver. This is
> effectively an abstraction layer handling the hardware-specific
> details of TX packet transmission.
>=20
> In our case, there is no standard interface=E2=80=94like those for
> I2C/I3C=E2=80=94that serves PCIe VDM.

But that's not what you're proposing here - your abstraction layer
serves one type of PCIe VDM messaging (MCTP), for only one PCIe VDM MCTP
driver.

If you were proposing adding a *generic* PCIe VDM interface, that is
suitable for all messaging types (not just MCTP), and all PCIe VDM
hardware (not just ASPEED's) that would make more sense. But I think
that would be a much larger task than what you're intending here.

Start small. If we have other use-cases for an abstraction layer, we can
introduce it at that point - where we have real-world design inputs for
it.

Regardless, we have worked out that there is nothing to actually abstract
*anyway*.

> > The direct approach would definitely be preferable, if possible.
> >=20
> Got it. Then we'll remove the kernel thread and do TX directly.

Super!

> > Excellent question! I suspect we would want a four-byte representation,
> > being:
> >=20
> > [0]: routing type (bits 0:2, others reserved)
> > [1]: segment (or 0 for non-flit mode)
> > [2]: bus
> > [3]: device / function
> >=20
> > which assumes there is some value in combining formats between flit- an=
d
> > non-flit modes. I am happy to adjust if there are better ideas.
> >=20
> This looks good to me=E2=80=94thanks for sharing!

No problem! We'll still want a bit of wider consensus on this, because
we cannot change it once upstreamed.

Cheers,


Jeremy

