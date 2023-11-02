Return-Path: <netdev+bounces-45718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB77DF2A4
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09441C20EBA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213492FB6;
	Thu,  2 Nov 2023 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wLOyVWzd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907863AD;
	Thu,  2 Nov 2023 12:39:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D918A;
	Thu,  2 Nov 2023 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TIQojWmE9MxmAPu4pmyVMZLAi3i+e6rSjQXCU7X4YpY=; b=wLOyVWzdffZ8kcZX/6Ys3nEbse
	myM3WjCJSuj+r5vPeouDkpm2JbV6fEKka8u7SxZhQ6P2wrdhh3luyxWDwjBApw2IGeXfP3MJUZn+i
	PmNaGyoYQQ7MjLJSSb66v2oUTnAKON8bv3cCDXlcRDTqoELixgcF70JeADqxhB0ozSf4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyWyS-000kd6-Az; Thu, 02 Nov 2023 13:39:00 +0100
Date: Thu, 2 Nov 2023 13:39:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <f95b42ef-b7e0-44dc-b7c8-9353e9edc2df@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <ZUOUGf-PMGo8z1s-@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUOUGf-PMGo8z1s-@debian>

> 	spe1: ethernet@1{
> 		compatible = "microchip,lan865x";
> 		reg = <1>;
> 		interrupt-parent = <&gpio5>;
> 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> 		spi-max-frequency = <50000000>;

That is a pretty high frequency. It is actually running at that speed?

Have you tried lower speed?

> 		oa-tc6{
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			oa-cps = <32>;
> 			oa-prote;
> 			oa-dprac;
> 		};
> 	};
> };
> 
> With this setup I'm getting a maximum throughput of about 90kB/s.
> If I increase the chunk size / oa-cps to 64 I get a might higher
> throughput ~900kB/s, but after 0-2s I get dump below (or similar).

Is this tcp traffic? Lost packets will have a big impact. You might
want to look at the link peer with tcpdump and look for retries. Also,
look if there are frames with bad checksums.

     Andrew


