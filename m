Return-Path: <netdev+bounces-185706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E69A9B7E7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD214C3E48
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190221FF35;
	Thu, 24 Apr 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2RCrh/zN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0C1E231E;
	Thu, 24 Apr 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521394; cv=none; b=jgvy6whBGZGXuDnmWdiXfGXK8LrOO+TFXb1v26WRY8d+j6iw+oX68aPFaoWpzysBE/Ws4ziisCah9mRA4fLyIbAT45VgcK1coZOu997h5VvPEnzgCbwnZo127jrBcJ2QA1xndwQZ9HojfObUYg7+G4/oihKFaWijrw0SNsLfYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521394; c=relaxed/simple;
	bh=HKz2v/Dk24xsj/fbF/BXdQp5dBDuDBSlFnA/gFKOpRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTKonnuQEeNPwuJUAa8m4s0vvoAlj8eiii6plAS40H1lAnCtrjXHyOP4wxuuC0Ek5JZ2RrT+Idb2PxInKxrDVcvxdEgzbRbkj8yyoXp8tP67JP/upjObP4FPcZtRXtaf8IEnI/6eZc0A3by5wUxbunI4/VkWJiYFy/GTMG8TjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2RCrh/zN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bgHAVRSAtGS2mucHqdulufmpGRpZTS9/L7tc07qePPc=; b=2RCrh/zN/3ZFHAA0cZnrwsSn/r
	7jiQ2NoKx+p2nXFoiPH81MDw/eOCr9IxIj/VbzE6U//36F+XhAZo2M3AA3n8txwu2IjAKfNnFXAo5
	XFmmzS08oyl2Uq7rB9EUQ807RpD/QVRoh5HoTIqNZQfycVkGUke3QQAhjqS/vWYgHA0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u81qF-00AVAd-F9; Thu, 24 Apr 2025 21:02:35 +0200
Date: Thu, 24 Apr 2025 21:02:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, clabbe.montjoie@gmail.com
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <7fcedce7-5cfe-48a4-9769-e6e7e82dc786@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
 <20250424150037.0f09a867@donnerap.manchester.arm.com>
 <4643958.LvFx2qVVIh@jernej-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4643958.LvFx2qVVIh@jernej-laptop>

> In my experience, vendor DT has proper delays specified, just 7 instead of
> 700, for example. What they get wrong, or better said, don't care, is phy
> mode. It's always set to rgmii because phy driver most of the time ignores
> this value and phy IC just uses mode set using resistors. Proper way here
> would be to check schematic and set phy mode according to that. This method
> always works, except for one board, which had resistors set wrong and
> phy mode configured over phy driver was actually fix for it.

What PHY driver is this? If it is ignoring the mode, it is broken.

We have had problems in the past in this respect. A PHY driver which
ignored the RGMII modes, and strapping was used. That 'worked' until
somebody built a board with broken strapping and added code to respect
the RGMII mode, overriding the strapping. It made that board work, but
broke lots of others which had the wrong RGMII mode....

If we have this again, i would like to know so we can try to get in
front of the problem, before we have lots of broken boards...

	Andrew

