Return-Path: <netdev+bounces-46117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF57E1808
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3402AB20D2A
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DDC19BD1;
	Sun,  5 Nov 2023 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WhuJnfm1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D96AD6
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 23:39:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56FC0;
	Sun,  5 Nov 2023 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0fvE5a+3pi+CSkmWJTHCT4WObDGOY2LdpWjcXYqvuZs=; b=WhuJnfm1nBEbXlUeko6J144+xV
	ljsfuhUuRZg8+5WAMQMX8TGO1q7R9+xexn1V420YZCWhcpEMQSgQCU1aCa18KymjCM1y0kqo0CRyt
	uTuTA4NLAGziyR8VU7b2UwNUIEhPBziBTqbchTsIJQiSbRdXtMuBAlePGsXFCCqvQxMY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzmhv-000x69-EE; Mon, 06 Nov 2023 00:39:07 +0100
Date: Mon, 6 Nov 2023 00:39:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] net: ethernet: cortina: Fix MTU max setting
Message-ID: <f75f000e-455a-4922-a931-9cd6e211ad7f@lunn.ch>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-1-cd3a5aa6c496@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105-gemini-largeframe-fix-v2-1-cd3a5aa6c496@linaro.org>

On Sun, Nov 05, 2023 at 09:57:23PM +0100, Linus Walleij wrote:
> The RX max frame size is over 10000 for the Gemini ethernet,
> but the TX max frame size is actually just 2047 (0x7ff after
> checking the datasheet). Reflect this in what we offer to Linux,
> cap the MTU at the TX max frame minus ethernet headers.
> 
> Use the BIT() macro for related bit flags so these TX settings
> are consistent.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

