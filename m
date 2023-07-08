Return-Path: <netdev+bounces-16224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC774BEB9
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 20:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C9928126E
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2588BF1;
	Sat,  8 Jul 2023 18:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E08498
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 18:28:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82243D2;
	Sat,  8 Jul 2023 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hMCzX6G+RqwJ+hPZQhd7V/qy5pJoruPr1loVfQz//CE=; b=kpwlnEqbJpSBtjbe5w3qyllTnU
	ZjBcJpkem7IP5esUXHCks6TmjU8YYsRdz0YCMifm+RHNIPL9Aka8UV3Q/MJDYFFs+wPCrpKLaP8a2
	xumKSLYxeUQpUDII/DBvZ5ySnSBnIp3hS/bFALaoxL0uSULHXWiHw7ozy+t+Gt73Wlvs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qICft-000pLJ-8U; Sat, 08 Jul 2023 20:28:53 +0200
Date: Sat, 8 Jul 2023 20:28:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH 1/2] net: phy: mscc: add support for CLKOUT ctrl reg for
 VSC8531 and similar
Message-ID: <8c188fbd-eaa4-4063-9153-d7b8c2772f8b@lunn.ch>
References: <20230706081554.1616839-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706081554.1616839-1-alex@shruggie.ro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 11:15:53AM +0300, Alexandru Ardelean wrote:
> The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
> have a CLKOUT pin on the chip that can be controlled by register (13G in
> the General Purpose Registers page) that can be configured to output a
> frequency of 25, 50 or 125 Mhz.
> 
> This is useful when wanting to provide a clock source for the MAC in some
> board designs.
> 
> Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>

Please take a look at
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The patch subject should indicate which tree this is for,
net-next. 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

