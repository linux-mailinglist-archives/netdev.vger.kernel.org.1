Return-Path: <netdev+bounces-47837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721747EB8ED
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43841C20954
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89B33071;
	Tue, 14 Nov 2023 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2prKTzrk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB62AEFD;
	Tue, 14 Nov 2023 21:48:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E3D5;
	Tue, 14 Nov 2023 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J34jQR/yh5cGe31WfVIp+XCRxJDahHI7Z4a9PZud/Qk=; b=2prKTzrkXpWNGiNvrJ6gfNzSX+
	rmXyLuh227SiKVpC7EIYmPCIexq9aZTXsfTus2SJYzETncnRvwinzHif7cKwAGCfApLkYIjQqG+J6
	yez38boPgDWeyEwfQF+P16qxQ0+cuGwx2zhVdlqwDqkQZfpucNMk9mIwVBaWwABsur7w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r31G5-000CAk-VH; Tue, 14 Nov 2023 22:47:45 +0100
Date: Tue, 14 Nov 2023 22:47:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 6/9] dt-bindings: net: ethernet-switch:
 Accept special variants
Message-ID: <9d8e821a-4a5a-4392-abe3-b583a30a6c8b@lunn.ch>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>

On Tue, Nov 14, 2023 at 12:36:01AM +0100, Linus Walleij wrote:
> Accept special node naming variants for Marvell switches with
> special node names as ABI.
> 
> This is maybe not the prettiest but it avoids special-casing
> the Marvell MV88E6xxx bindings by copying a lot of generic
> binding code down into that one binding just to special-case
> these unfixable nodes.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

As you say, not pretty. But it does the job.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

