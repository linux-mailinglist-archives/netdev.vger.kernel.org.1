Return-Path: <netdev+bounces-102796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DD904C4E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00AF1F23576
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996C16B755;
	Wed, 12 Jun 2024 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azc8cCkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41516B74F;
	Wed, 12 Jun 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176033; cv=none; b=jUDnnrkSq8XmazmPQea5+ZHdpPy0dMmXhAZwjN3xDjCMFRgE5c3Umpd73C/+er+slRMcPxIIjMQ626IYRebkkQ7F8MnUmT/szw0i1s7SxlHzBNBf169zO9kaAiM3fAU0KIzDfnYPlqTLw37kB2qu7mDjiePlVF89Fd6GUtmW7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176033; c=relaxed/simple;
	bh=+Rww3ToDP1rCgowHETjslBhmPr1ZzWm2jyXRlow5EHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpILa3R62sTa0o+qhqU7oBSjyf4UGvb0NILt9FUp96ZEje5Q/de/VsD7eu8PFgjBdx9pfFXwIkyQasUjPPDWczvYY3JEu2YG/Um6E9RmvhFRjKTaK5C8Jq7q+kS79duTFwgX4m7iPOVgBNDS+TPYFkZBf1FObUeWJ64/QN6F9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azc8cCkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9AAC3277B;
	Wed, 12 Jun 2024 07:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718176033;
	bh=+Rww3ToDP1rCgowHETjslBhmPr1ZzWm2jyXRlow5EHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Azc8cCkxptCRPh+Mq4/EDEGWMgWm8rOQV+Jm7egOz378QpwlmMceaiMKzHrqS2f4d
	 h7sGIvTbPi3BMn7b1mnggZVYWrdTEaOD2xCHUfZl6dIGBPG2VTAEQoSQQ9/be+FOXc
	 fY+VaHM9yMYY2LxfNEBDYj8jNmZyUmvnfTcFFTK2IN1tSAibzYmlhat/2hjEu7/GCr
	 WHHIiypD4q2KC0jtZfpj8qZ44DST7oEXStA7yVfkARuWyV4G21Iyk7M0FMyw81xcn5
	 IB6L6Pr79kfZWr+/1rnR3AlVHKjlRVe8cooX7lj3Zoxfv2pK9DxOPk8UEW6Pv7E+7z
	 aiEkdqWMaKL2Q==
Date: Wed, 12 Jun 2024 09:07:07 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Message-ID: <20240612090707.7da3fc01@dellmb>
In-Reply-To: <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
	<c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 20:42:43 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> +cc Eric W and Marek.
> 
> On 11/06/24 17:34, Chris Packham wrote:
> > The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> > clause 45 MDIO interface and can leverage the support that has already
> > been added for the other 822x PHYs.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >
> > Notes:
> >      I'm currently testing this on an older kernel because the board I'm
> >      using has a SOC/DSA switch that has a driver in openwrt for Linux 5.15.
> >      I have tried to selectively back port the bits I need from the other
> >      rtl822x work so this should be all that is required for the rtl8224.
> >      
> >      There's quite a lot that would need forward porting get a working system
> >      against a current kernel so hopefully this is small enough that it can
> >      land while I'm trying to figure out how to untangle all the other bits.
> >      
> >      One thing that may appear lacking is the lack of rate_matching support.
> >      According to the documentation I have know the interface used on the
> >      RTL8224 is (q)uxsgmii so no rate matching is required. As I'm still
> >      trying to get things completely working that may change if I get new
> >      information.
> >
> >   drivers/net/phy/realtek.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index 7ab41f95dae5..2174893c974f 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -1317,6 +1317,14 @@ static struct phy_driver realtek_drvs[] = {
> >   		.resume         = rtlgen_resume,
> >   		.read_page      = rtl821x_read_page,
> >   		.write_page     = rtl821x_write_page,
> > +	}, {
> > +		PHY_ID_MATCH_EXACT(0x001ccad0),
> > +		.name		= "RTL8224 2.5Gbps PHY",
> > +		.get_features   = rtl822x_c45_get_features,
> > +		.config_aneg    = rtl822x_c45_config_aneg,
> > +		.read_status    = rtl822x_c45_read_status,
> > +		.suspend        = genphy_c45_pma_suspend,
> > +		.resume         = rtlgen_c45_resume,
> >   	}, {
> >   		PHY_ID_MATCH_EXACT(0x001cc961),
> >   		.name		= "RTL8366RB Gigabit Ethernet"  

Don't you need rtl822xb_config_init for serdes configuration?

Marek

