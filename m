Return-Path: <netdev+bounces-33423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44579DE3A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 04:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B1F1C20D40
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB7396;
	Wed, 13 Sep 2023 02:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC4384
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:19:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD601717;
	Tue, 12 Sep 2023 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ns6UnpiLdI2yDe5ElqFkyvCqmhJVj9T5E+dHT+rOskI=; b=KNpZUYN9eD1KrH4e5o1C5msqt2
	PKooCLoCoZRoBl8sbPDc7M0HGWjwDPyva6Gs/YBiw4id7IoRee7mmss6sFYKIIGZSBVGKsxe8K0EV
	GfD8TXWVKgu46iV+PthhYogYeOwZFi4ejdcJwComkGBs93V7kJ04dggruu6sRP0i6H1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgFT5-006Gzf-7w; Wed, 13 Sep 2023 04:19:03 +0200
Date: Wed, 13 Sep 2023 04:19:03 +0200
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
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <489f7f63-a542-45cf-80ec-f8d3cb7aa686@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <28dce908-3a87-48c8-b181-d859697c0152@lunn.ch>
 <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>

> Ok. If I understand correctly, I have to use devm_request_threaded_irq() 
> instead of devm_request_irq() and let the thread handler registered with 
> the devm_request_threaded_irq() function to perform interrupt activity 
> directly?

Yes. I've not looked at all the patches yet, but if the work queue is
not used for anything else, you should be able to remove it, and let
the IRQ core handle all the threading for you.

    Andrew

