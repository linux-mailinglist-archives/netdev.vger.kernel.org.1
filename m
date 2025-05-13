Return-Path: <netdev+bounces-190261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD6AB5E9E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91073189DA3E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A81F0E26;
	Tue, 13 May 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GwleEq6M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25ED33F7;
	Tue, 13 May 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173211; cv=none; b=EzMBEl0X1jDy9XT+7ZFGGjOfigka6HMLain0z+/oW1qb6Th3nXnDNMEiR4nCoVdb/NtqW+zkH7tkQD8/B9jKR2tEkvhOtUp2T+oZ8oU0F1+UqGlKDmoaRmN+9pVDUmUTa9qT00d63acAmuDtqCMbFIll77oSeP+Ti2p1NB4YVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173211; c=relaxed/simple;
	bh=gZD1X07ma/dG1ZFre1+w0/ui2O8NhnYzvubmwxqG1y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z729WgF3FkYttKAFTbN2QSsURZbzr2VKxSlNggf9Q3Rr308pmIakxKXQQe072vbYoqlIzjtKDhvvsxF0fYe6VGaQfHjD6Nc7M6PEYwRIx+uGUtBE1QHAITNdjJAjeys5vCef/uPS6eelx17FvNuYOv0xTpCCfXpv92x0/BmVar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GwleEq6M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=fbMajz8w3X/FLDkTx5Qc3ESHcp1c0CTxTYL/fxwaRn4=; b=Gw
	leEq6MF+u8X6Hy8d2Uzp48BSKqc2Bu4Ntfo3CNuoT3hYDHSE3h/PSY7dB//ZYaVtkgi8Z2D7ypidA
	4MISDxhk5X1e7b33HrhsN6uL3nyjEoWtrNTRY7qYi+MfARWlf2kvHgO3eTDkABnK3wUnP4uEkyL+c
	R0UfmvjMF7d7TQc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uExYs-00CV9F-U9; Tue, 13 May 2025 23:53:18 +0200
Date: Tue, 13 May 2025 23:53:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>

On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Riégel wrote:
> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
> > On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Riégel wrote:
> >> Hi,
> >>
> >>
> >> This patchset brings initial support for Silicon Labs CPC protocol,
> >> standing for Co-Processor Communication. This protocol is used by the
> >> EFR32 Series [1]. These devices offer a variety for radio protocols,
> >> such as Bluetooth, Z-Wave, Zigbee [2].
> >
> > Before we get too deep into the details of the patches, please could
> > you do a compare/contrast to Greybus.
> 
> Thank you for the prompt feedback on the RFC. We took a look at Greybus
> in the past and it didn't seem to fit our needs. One of the main use
> case that drove the development of CPC was to support WiFi (in
> coexistence with other radio stacks) over SDIO, and get the maximum
> throughput possible. We concluded that to achieve this we would need
> packet aggregation, as sending one frame at a time over SDIO is
> wasteful, and managing Radio Co-Processor available buffers, as sending
> frames that the RCP is not able to process would degrade performance.
> 
> Greybus don't seem to offer these capabilities. It seems to be more
> geared towards implementing RPC, where the host would send a command,
> and then wait for the device to execute it and to respond. For Greybus'
> protocols that implement some "streaming" features like audio or video
> capture, the data streams go to an I2S or CSI interface, but it doesn't
> seem to go through a CPort. So it seems to act as a backbone to connect
> CPorts together, but high-throughput transfers happen on other types of
> links. CPC is more about moving data over a physical link, guaranteeing
> ordered delivery and avoiding unnecessary transmissions if remote
> doesn't have the resources, it's much lower level than Greybus.

As is said, i don't know Greybus too well. I hope its Maintainers can
comment on this.

> > Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. But
> > the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
> > has support for these, although the code is current in staging. But
> > for staging code, it is actually pretty good.
> 
> I agree with you that the EFR32 is a general purpose SoC and exposing
> all available peripherals would be great, but most customers buy it as
> an RCP module with one or more radio stacks enabled, and that's the
> situation we're trying to address. Maybe I introduced a framework with
> custom bus, drivers and endpoints where it was unnecessary, the goal is
> not to be super generic but only to support coexistence of our radio
> stacks.

This leads to my next problem.

https://www.nordicsemi.com/-/media/Software-and-other-downloads/Product-Briefs/nRF5340-SoC-PB.pdf
Nordic Semiconductor has what appears to be a similar device.

https://www.microchip.com/en-us/products/wireless-connectivity/bluetooth-low-energy/microcontrollers
Microchip has a similar device as well.

https://www.ti.com/product/CC2674R10
TI has a similar device.

And maybe there are others?

Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a TI
CPC, and an ACME CPC?

How do we end up with one implementation?

Maybe Greybus does not currently support your streaming use case too
well, but it is at least vendor neutral. Can it be extended for
streaming?

And maybe a dumb question... How do transfers get out of order over
SPI and SDIO? If you look at the Open Alliance TC6 specification for
Ethernet over SPI, it does not have any issues with ordering.

	 Andrew


