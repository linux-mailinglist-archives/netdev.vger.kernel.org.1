Return-Path: <netdev+bounces-213449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC48B2500C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ABB6862D3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D642874ED;
	Wed, 13 Aug 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sLdiBpUQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE31228CBC;
	Wed, 13 Aug 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103170; cv=none; b=QkPQzd6WKC2rQQiUcbHxRg/JFXuenWJ4CxshCS5IChDp2WGNm0pNuyHPZg+L9YqXvvrt+20Uax/n1s+l9arLg2uY9W+MAwf0nEOERouY5b/APR4+SZdPagqB+snEK29aLExJgNV3gHu6acdkDeHf4aukTjbKwBfbs+uYSevBuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103170; c=relaxed/simple;
	bh=6jhThN3V5Sy9HAQLake0C0yKwgeTlss8RsoaPr0/fIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPVtvD/RC9vLYO9Y2qJnJBgkTDlZDP6uE2L+cM9y0otRTwueSwUdfbCIKYRr6+FWPZ02l3tNWfYQ9ugVqiuZSIVctluVOOA1IhoOQbitoAC3BCoERT6dkNS/ZSvgs6CFdf10rwbod3mbjQif5KcjBjDyvp4VzPaW5gLckbY2gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sLdiBpUQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0RmjA/0wiM4s7TkHx13AGbryUZlazMaMKFUlnrneZd8=; b=sLdiBpUQ6Yi+E7x3xU6hlF9M8i
	PnCofosIIGDvBfpg1eNpOM7+bfa0aFRmpvdr80QrtJ4ZAihQqJI/yt8SHMhnaL94kqYLIq/Vl7sZ0
	z3r12w8VXITbqpgNB981DFKF4qjjhw8HfynZBRCAj8z4okX0Ycn1Rz3UiGNTrvHkkME9mEPB7FNWZ
	BBgiPuymq90exhf6beW9yubxMbXDTN8qvjdqdrtcLR8kcITjAccHv0uuZQXY6Eitdn/sEdYKOe8Dn
	5ijge/Vtvg4pvrx9GIfPJI9NslD/y4GbqhV+tGVBGiBoVPEPbcCojGZJgv1lX+SULMrBi/WpbjN5e
	wE7F558w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34320)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umEVL-00073q-0M;
	Wed, 13 Aug 2025 17:39:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umEVF-0005uD-34;
	Wed, 13 Aug 2025 17:39:06 +0100
Date: Wed, 13 Aug 2025 17:39:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v2 06/10] arm64: dts: allwinner: a527:
 cubie-a5e: Add ethernet PHY reset setting
Message-ID: <aJy_qUbmqoOG-GBC@shell.armlinux.org.uk>
References: <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-7-wens@kernel.org>
 <aJyraGJ3JbvfGfEw@shell.armlinux.org.uk>
 <CAGb2v67cKrQygew2CVaq5GCGvzcpkSdU_12Gjq9KR7tFFBow0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67cKrQygew2CVaq5GCGvzcpkSdU_12Gjq9KR7tFFBow0Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 13, 2025 at 11:51:18PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 13, 2025 at 11:12 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Aug 13, 2025 at 10:55:36PM +0800, Chen-Yu Tsai wrote:
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > index 70d439bc845c..d4cee2222104 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > @@ -94,6 +94,9 @@ &mdio0 {
> > >       ext_rgmii_phy: ethernet-phy@1 {
> > >               compatible = "ethernet-phy-ieee802.3-c22";
> > >               reg = <1>;
> > > +             reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> > > +             reset-assert-us = <10000>;
> > > +             reset-deassert-us = <150000>;
> >
> > Please verify that kexec works with this, as if the calling kernel
> > places the PHY in reset and then kexec's, and the reset remains
> > asserted, the PHY will not be detected.
> 
> I found this to be a bit confusing to be honest.
> 
> If I put the reset description in the PHY (where I think it belongs),
> then it wouldn't work if the reset isn't by default deasserted (through
> some pull-up). This would be similar to the kexec scenario.

The reason for this is quite simple. While it's logical to put it in
there, the problem is that the PHY doesn't respond on the MDIO bus
while it's reset pin is asserted.

Consequently, when we probe the MDIO bus to detect PHYs and discover
the PHY IDs, we get no response, and thus we believe there isn't a
device at the address. That means we don't create a device, and thus
there's no mdio device for the address.

There is a work-around, which is to encode the PHY ID in the DT
compatible (check the ethernet-phy binding). However, note that we
will then not read the actual PHY ID (maybe we should?) which means
if the driver wants to know e.g. the revision, or during production
the PHY changes, it will require DT to change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

