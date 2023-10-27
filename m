Return-Path: <netdev+bounces-44759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7727D9844
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F91C2108D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2631EB48;
	Fri, 27 Oct 2023 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PviAyZWx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D2D03F;
	Fri, 27 Oct 2023 12:32:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADEC0;
	Fri, 27 Oct 2023 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bs28ALhgw+SsGrD8IZNzd1kcl11K+aTCog1cdlerQt0=; b=PviAyZWxwetshaA7PLZ/MU5rdM
	kz5PV/y28YoGancChzHxeYO9WAbGodXtMiiuYbxFfCxo5RAPEyEQvGWvz+D58QCLDErfvstdKyQ4r
	CysbFn+2Xl3eVN2POpTPdvDrzwCw94b8PL6JhNrANQYKN6E+uQr/EOxhOhjS6INROB8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwM0O-000L1r-Km; Fri, 27 Oct 2023 14:32:00 +0200
Date: Fri, 27 Oct 2023 14:32:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Message-ID: <d6377de8-603f-4ac1-a691-b79c46a5057b@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
 <fd7f7d62-7921-4aac-9359-ff09449fd20c@lunn.ch>
 <acfb97fa-54f8-4381-bb82-db8f85fa86db@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acfb97fa-54f8-4381-bb82-db8f85fa86db@microchip.com>

> > Device tree described hardware. Its not supposed to be used to
> > describe configuration. So it is not clear to me if any of these are
> > valid in DT.
> > 
> > It seems to me, the amount of control transfers should be very small
> > compared to data transfers. So why not just set protection enable to
> > be true?
> Yes having protection enabled for control transfer doesn't hurt 
> anything. The only intention for keeping this as configurable is, it is 
> defined in the OPEN Alliance specification to enable/disable.

Standards often have options which nobody ever use, or are only useful
in particular niches. Its often best to keep it simple, get the basic
feature working, and then add these optional features if anybody
actually needs them.

> > What is the effect of chunk payload size ? Is there a reason to use a
> > lower value than the default 64? I assume smaller sizes make data
> > transfer more expensive, since you need more DMA setup and completion
> > handing etc.
> Again the intention for keeping this as configurable is, it is defined 
> in the OPEN Alliance specification as user configurable. They can be 8, 
> 16, 32 and 64. And the default is 64. Also Microchip's LAN8650 supports 
> for 32 and 64.

Do you have any idea why the standard has different sizes? Why would
you want to use 32? If you can answer this, it helps decide how
important it is to support multiple sizes, or just hard code it to 64.

There are plenty of old research on Ethernet frame sizes, but they are
for LAN/Internet usage. You typically see two peeks, one around 64-80
bytes, and other around the full frame size. The small packets are TCP
ACKS, and the rest is TCP data. However, this is a T1S device for
automotive. I personally have no idea if the same traffic distribution
is seen in that application?

Are there protocols running which use a lot of frames smaller than 64
bytes? If so, 64 byte chunk size i assume could be wasteful, if there
are lots of 32 byte frames.

The other potential issue is latency and the way the SPI bus
works. Its a synchronised bi-directional bus. You can receive and
transmit at the same time, but you have to setup the transfer to do
that. If you are busy doing a receive only, and there is a new packet
to send, you have to wait for the chunk transfer to complete before
you can start a bi-directional chunk transfer. So a 32 byte chunk
might make your link more efficient if you have heavy but bursty
traffic. However, you have to consider the overheads of setting up the
transfer and running the completion handler afterwards. This can be
costly.

Do you have real use cases for using different chunks sizes? If not, i
probably would just hard code it to 64, until somebody comes along
needing something else.

> > An Ethernet driver is allowed to have driver specific private
> > flags. See ethtool(1) --show-priv-flags and --set-priv-flags You could
> > maybe use these to configure cut through?
> So you mean, we have to implement the support in the ethtool interface 
> to enable/disable tx/rx cut through feature, isn't it?
> 
> If you feel like the above configurations are not needed, so by keeping 
> protection true always, chunk payload size (cps) 64 always and moving 
> tx/rx cut through to ethtool, we can get rid of this DT bindings?

Again, do you have a real use case for cut through? Or maybe flip it
around, Why would you not use cut through?

	Andrew

