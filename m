Return-Path: <netdev+bounces-162807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EDA27FF3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815BB166490
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03817E;
	Wed,  5 Feb 2025 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LRIFxGFF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76C173;
	Wed,  5 Feb 2025 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713952; cv=none; b=l0KtU4PtmlvCeexRbED7p/gytGAsCez7BAl4d0KJ6dqwE4eY87C0wi7/CsCf0+FEJAjLIFIaFz6iCdw5L68XNvWoNCuvHeh0E4NkrYoeRauhXFno51RYUCR3sG7nmLMhmdFKKaV+odJoXXZN/zq1mrC1kGUb424iwqSKLZhnDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713952; c=relaxed/simple;
	bh=aMffe2cuyieFMT/ZvHdJ4Q+mva2yTWC26VFHFOFlKeI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZF5SQkxafObSkaYRkbDUIoKzBRMA+d8NBAPj7VTPt0Om+jN0/Fw2IcdnP/vTmpys2qqSU/7ulHyks6yn85gS4wGZYI6unrw02YM4mED5Dvc0g+tFD7axALM4MZovtqkc5fUriDwM5z4aD9EOn86ef0xLK0xp9GrfpZJjZnZmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LRIFxGFF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738713948;
	bh=aMffe2cuyieFMT/ZvHdJ4Q+mva2yTWC26VFHFOFlKeI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LRIFxGFFHQUulv7+gJaJmDaWZ/PPEQJVmMZGlxQsy7SG15tOvvOCxT6hHwupywBAO
	 bFTs9JIdo0/N5USrIdXdMxDqzfYs4LDT+w+9d2V2E6DVvPhUXbKta2mrcRSWADjZjJ
	 IFHRP+OSir09zKCOJGmq5BNwhrDamJW5HcnePqwfJgdo1JUjcRR3AruwfHcdOG7cnG
	 qKxX8ddUePxs12+jcVYZTdNBiXM3WMdrbFtjW2Xca+mLz/lRWd4bOXsBk568jKtjeo
	 SrzUlAatdu22ie+tuIF/MRU3W8Vf34yIuNph5y4IBwrSBZ+EBo8i/jo1WRRyHZfnjV
	 O7vCiBEdMjeRA==
Received: from [192.168.68.112] (ppp118-210-185-209.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 941067104E;
	Wed,  5 Feb 2025 08:05:46 +0800 (AWST)
Message-ID: <acf79ff017d7648d4d502b7031b88c4853bf724c.camel@codeconstruct.com.au>
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
Date: Wed, 05 Feb 2025 10:35:46 +1030
In-Reply-To: <66e2e5e4-5ce5-442c-ba0f-d12cbe79e868@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
	 <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
	 <66e2e5e4-5ce5-442c-ba0f-d12cbe79e868@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 13:40 -0600, Ninad Palsule wrote:
> > This one needs an ack from Linus W or Bartosz if I'm to take it.
> > However, it's also causing some grief from Rob's bot:
> >=20
> > https://lore.kernel.org/all/173859694889.2601726.10618336219726193824.r=
obh@kernel.org/
> >=20
> > As the reported nodes should all be hogs the name shouldn't matter
> > anywhere else (as far as I'm aware). It would be nice if all the
> > warnings were cleaned up before we merged the binding update. That way
> > we don't cause everyone else looking at the CHECK_DTBS=3Dy output more
> > grief than they already get for the Aspeed devicetrees.
> >=20
> > In order to not get bogged down it might be worth splitting out both
> > the IPMB- and GPIO- related patches like you did the FTGMAC100 patch,
> > and then I can merge what remains (from a quick look they seem
> > relatively uncontroversial).
> >=20
>=20
> The warnings are fixed by different patch by Krzysztof. As there are no=
=20
> more changes then I will wait for other responses. If I don't get those=
=20
> response in couple of days then I will split it.
> https://lore.kernel.org/linux-kernel/20250116085947.87241-1-krzysztof.koz=
lowski@linaro.org/

That patch fixes a couple of Marvell systems. I think you might have
meant this:

https://lore.kernel.org/all/20250116090009.87338-1-krzysztof.kozlowski@lina=
ro.org/

In which case, I've applied it.

Thanks,

Andrew

