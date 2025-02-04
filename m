Return-Path: <netdev+bounces-162379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C520A26B1D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D281882DEC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559B17BEBF;
	Tue,  4 Feb 2025 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AZ5+ijlK"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1425A635;
	Tue,  4 Feb 2025 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643601; cv=none; b=m096MCp8qOUc6wOEfX61Wc4mNqBaKp+Z2h4ZEXfZyZn2j2jOA2tdndRKNwA1b1IB43B0UNYYmQOTVBKcEwx+s93EQuALDd+dJGmP/J36oLWx9xJ7zHVn4o8WWSg1Le+FnwgWTKkCvDSAbqAhqg33lBfxL1/SEiWtzND8XLTvHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643601; c=relaxed/simple;
	bh=OVO7pPvS9it63pRV7s9Xy2kC4yPGFJZs59pPpi//UPs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjpvnbTXGYbSC/x0KYmDlASGlVBKK+3C0Zg1S4EAujYi0+DchGvjDKGX7+gTmT6gNKdvJmbK0x7eruXEWNxBRZ8Rw5q86kEdiRLKMP7jxBOxKun0O3EvyGQFjct5nlwYigTds9DLvNxLpcZmkAYbApnBprmauNXRMIoAhsMmlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AZ5+ijlK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738643597;
	bh=OVO7pPvS9it63pRV7s9Xy2kC4yPGFJZs59pPpi//UPs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=AZ5+ijlKDQgxKTEifzz0lMAm8+CID+Vq9cW8amOSUOU2Lnrbgnn+RCsZMj1J/bF9P
	 IXpGFNm7WoQQrR5ryZs0gtv7IJQ3SiM/fDn72Ih4I/3VGF2Bp/MKobboggFt1+xwPE
	 20bsV5MIrHoCNcVNagNJVt72f4eopKbWzvG+eqWWe7fsd1hDwWs7vJFg5vOctzsb2t
	 gUfSqg0iYSd5RlppAuDM2qcmEB8YxwbJspydO//mUNV6Xhu+4fceeckJJy3Mn7gSUv
	 EtsHS5/nOLzIYgNbpyy78UmaGA5ttbtGugGQBuhz2hKfevC4/FMBLMO1bOPGqqbJV2
	 T3oJaaY0oFD8A==
Received: from [192.168.68.112] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D96DD734A6;
	Tue,  4 Feb 2025 12:33:13 +0800 (AWST)
Message-ID: <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 0/9] DTS updates for system1 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, brgl@bgdev.pl, 
 linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  openipmi-developer@lists.sourceforge.net,
 netdev@vger.kernel.org, joel@jms.id.au,  devicetree@vger.kernel.org,
 eajames@linux.ibm.com,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 15:03:13 +1030
In-Reply-To: <20250203144422.269948-1-ninad@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ninad,

On Mon, 2025-02-03 at 08:44 -0600, Ninad Palsule wrote:
> Hello,
>=20
> Please review the patch set version 7.
>=20
> V7:
> ---
> =C2=A0 - Updated pattern in the ast2400-gpio.yaml
> =C2=A0 - Dropped "dt-bindings: net: faraday,ftgmac100" patch sending it
> =C2=A0=C2=A0=C2=A0 separately.
>=20
> V6:
> ---
> =C2=A0 - Fixed dt_binding_check errors for ipmb-dev.yaml
> =C2=A0 - Changed the hog parsing pattern in ast2400-gpio
>=20
> V5:
> ---
> =C2=A0 - Improved IPBM device documentation.
> =C2=A0 - Added the hog parsing in ast2400-gpio
>=20
> V4:
> ---
> =C2=A0 - Removed "Add RGMII support" patch as it needs some work from the
> =C2=A0=C2=A0=C2=A0 driver side.
> =C2=A0 - Improved IPBM device documentation.
> =C2=A0 - There is a new warning in CHECK_DTBS which are false positive so
> =C2=A0=C2=A0=C2=A0 ignored them.
> =C2=A0=C2=A0=C2=A0 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb:
> gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of
> the regexes: 'pinctrl-[0-9]+'
>=20
> V3:
> ---
> =C2=A0 - Fixed dt_binding_check warnings in ipmb-dev.yaml
> =C2=A0 - Updated title and description in ipmb-dev.yaml file.
> =C2=A0 - Updated i2c-protocol description in ipmb-dev.yaml file.
>=20
> V2:
> ---
> =C2=A0 Fixed CHECK_DTBS errors by
> =C2=A0=C2=A0=C2=A0 - Using generic node names
> =C2=A0=C2=A0=C2=A0 - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
> =C2=A0=C2=A0=C2=A0 - Adding binding documentation for IPMB device interfa=
ce
>=20
> NINAD PALSULE (6):

Why is your name all in caps here but not for the binding patches
below? Can you fix that up?

> =C2=A0 ARM: dts: aspeed: system1: Add IPMB device
> =C2=A0 ARM: dts: aspeed: system1: Add GPIO line name
> =C2=A0 ARM: dts: aspeed: system1: Reduce sgpio speed
> =C2=A0 ARM: dts: aspeed: system1: Update LED gpio name
> =C2=A0 ARM: dts: aspeed: system1: Remove VRs max8952
> =C2=A0 ARM: dts: aspeed: system1: Mark GPIO line high/low
>=20
> Ninad Palsule (3):
> =C2=A0 bindings: ipmi: Add binding for IPMB device intf

This one needs an ack from Corey if I'm to take it.

> =C2=A0 dt-bindings: gpio: ast2400-gpio: Add hogs parsing

This one needs an ack from Linus W or Bartosz if I'm to take it.
However, it's also causing some grief from Rob's bot:

https://lore.kernel.org/all/173859694889.2601726.10618336219726193824.robh@=
kernel.org/

As the reported nodes should all be hogs the name shouldn't matter
anywhere else (as far as I'm aware). It would be nice if all the
warnings were cleaned up before we merged the binding update. That way
we don't cause everyone else looking at the CHECK_DTBS=3Dy output more
grief than they already get for the Aspeed devicetrees.

In order to not get bogged down it might be worth splitting out both
the IPMB- and GPIO- related patches like you did the FTGMAC100 patch,
and then I can merge what remains (from a quick look they seem
relatively uncontroversial).

Andrew

> =C2=A0 ARM: dts: aspeed: system1: Disable gpio pull down
>=20
> =C2=A0.../bindings/gpio/aspeed,ast2400-gpio.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +
> =C2=A0.../devicetree/bindings/ipmi/ipmb-dev.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0 56 +++++++
> =C2=A0.../dts/aspeed/aspeed-bmc-ibm-system1.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 139 +++++++++++-----
> --
> =C2=A03 files changed, 147 insertions(+), 54 deletions(-)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-
> dev.yaml
>=20


