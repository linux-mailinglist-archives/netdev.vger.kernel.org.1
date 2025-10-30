Return-Path: <netdev+bounces-234401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D8C20228
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB0560770
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737C2EBDF4;
	Thu, 30 Oct 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jI+I0PRo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3134D923
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829112; cv=none; b=psBYXx4kS6qwzmCAGrYhIEJX8U5q1RAHySAP0a4+bNelzvhEWVN+PEH50CGazaR5v2WIHVQSKxfM5h/9JtamOFr2RJdL+9jRZOd6aOOYiYuCr9MT8TMy7CUDv5EEGk3Eu2BcwAczPnXAyOK0wznM/wtHxE/gjRVen+HNrtPYc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829112; c=relaxed/simple;
	bh=D1G//7urAWctOdMahOdS2bovWwv03yftrhst2ezVZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWqe3sYGek5Mxp5JNeSFaHMhe99joJyKcUnTrVLFdn5CDrjgWG7TAp1TNOZHj1EAQ3sm3ZiNyGS1ftpcCpZT02c39LnsInfhNeqBrq9T/PTcXx81o85xvNwzvmRCc0ljsmkXJYS44CNSPE2fZMBxrOoDVFzz1hl69KUv62R1XQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jI+I0PRo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=t0K5kbUb8pcLn5pf6DWa47/zoLMaWlXUqTZ3dnwtw/Q=; b=jI
	+I0PRodIlliLDtjTMPhAODaiABTtxwzFyekm40Cffvgw4wa8iwU21Yq0Ga2mXK2oIv7oennGr/1tT
	468w/45pU4/I0SKr448rBCBXR0BfZa2PtVC9/wjC+9Mh4oPtuHEvG8mKP22wQzFsv6gVfR667MkEG
	ETVweXf4EJOnaoI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vESE2-00CVWS-MV; Thu, 30 Oct 2025 13:57:58 +0100
Date: Thu, 30 Oct 2025 13:57:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yi Cong <cong.yi@linux.dev>
Cc: Frank.Sae@motor-comm.com, davem@davemloft.net, hkallweit1@gmail.com,
	kuba@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx
 delay config for the rgmii
Message-ID: <5b97f70c-45c3-41c2-ba7b-d383864f0003@lunn.ch>
References: <94ef8610-dc90-4d4a-a607-17ed2ced06c6@lunn.ch>
 <20251030022509.267938-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030022509.267938-1-cong.yi@linux.dev>

On Thu, Oct 30, 2025 at 10:25:09AM +0800, Yi Cong wrote:
> On Wed, 29 Oct 2025 13:07:35 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Oct 29, 2025 at 11:00:42AM +0800, Yi Cong wrote:
> > > From: Yi Cong <yicong@kylinos.cn>
> > >
> > > According to the dataSheet, rx delay default value is set to 0.
> >
> > You need to be careful here, or you will break working boards. Please
> > add to the commit message why this is safe.
> >
> > Also, motorcomm,yt8xxx.yaml says:
> >
> >   rx-internal-delay-ps:
> >     description: |
> >       RGMII RX Clock Delay used only when PHY operates in RGMII mode with
> >       internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
> >     enum: [ 0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500, 1650,
> >             1800, 1900, 1950, 2050, 2100, 2200, 2250, 2350, 2500, 2650, 2800,
> >             2950, 3100, 3250, 3400, 3550, 3700, 3850, 4000, 4150 ]
> >     default: 1950
> 
> Hi, Andrew, thanks for your reply!
> 
> Let me add the following information:
> 
> The chip documentation I have for the YT8521 and YT8531S:
> "YT8521SH/YT8521SC Application Note, Version v1.7, Release Date: January 3, 2024"
> "YT8531SH/YT8531SC Application Note, Version v1.2, Release Date: November 21, 2023"
> 
> Both documents specify the RGMII delay configuration as follows:
> The RX delay value can be set via Ext Reg 0xA003[13:10], where each
> increment of 1 adds 150ps. After power-on, the default value of
> bits [13:10] is 0.
> The TX delay value can be set via Ext Reg 0xA003[3:0], with the
> default value of bits [3:0] being 1 after power-on.
> 
> I reviewed the commit history of this driver code. When YT8521 support
> was initially added, the code configuration matched the chip manual:
> 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
> 
> However, later when DTS support was added:
> a6e68f0f8769 ("net: phy: Add dts support for Motorcomm yt8521 gigabit ethernet phy")
> the default values were changed to 1.950ns.

Read carefully...

> >       RGMII RX Clock Delay used only when PHY operates in RGMII mode with
> >       internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.

What do rgmii-id and rgmii-rxid mean?

> Indeed, the RGMII standard specifies that the clock signal should be
> delayed by 1-2ns relative to the data signals to ensure proper setup/hold
> timing, which is likely the origin of the 1.950ns value in the YAML and
> current code.

https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L264

> More importantly, the current Motorcomm driver's delay configuration logic
> is incomplete. In the projects I've worked on, some configurations are
> obtained from DTS, some from ACPI, but many manufacturers prefer to directly
> set the delay values in BIOS based on their hardware design.

Which is somewhat fine. If you want to the driver to not touch the PHY
configuration you use PHY_INTERFACE_MODE_NA

https://elixir.bootlin.com/linux/v6.16.5/source/include/linux/phy.h#L72

However, in general, Linux should not rely on the BIOS, Linux should
correctly configure the hardware, and in this case, it is trivial to
do, since it is already all implemented.

> In fact, Motorcomm's Linux 5.4 driver versions guided PC motherboard
> manufacturers to configure the delay values through BIOS, and the driver
> code did not touch the delay registers (Ext Reg 0xA003). This means that
> upgrading to a newer kernel version, where the driver writes 1.950ns
> by default, could cause communication failures.

Only if the MAC driver requests the PHY to adds delays.

> To summarize, the current issues with the Motorcomm driver are:
> 1. It only supports configuration via DTS, not via ACPI
>     —— I may implement this myself or coordinate with Motorcomm
>        in the future.

FYI:

https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/firmware-guide/acpi/dsd/phy.rst

You need to work within this framework.

    Andrew

