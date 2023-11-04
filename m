Return-Path: <netdev+bounces-46039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D57E0FF1
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B25B210B6
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0A11702;
	Sat,  4 Nov 2023 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f3w2pTZf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF8C13C
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:38:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B93A2;
	Sat,  4 Nov 2023 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lzWyV33e3c8/bJdweyH0zX+fxwaKoGIC7RM6cxCiZJA=; b=f3w2pTZfXLtb5Ppg7zlbs16J68
	uVzxzGlWcB8YF2GQ78Z9xRfKKkiAYWANRjF1Cflf1iVQfcKBaPLbY39Uvh/fM+7v3nl28Hy3bzBJQ
	srHLrDPPTtjHWE3HrnoEnGX/En3Ira1pjtdb9nxPoANtxYtqPzkPHqDxBNr2ApfbWFmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzHmr-000sLr-5i; Sat, 04 Nov 2023 15:38:09 +0100
Date: Sat, 4 Nov 2023 15:38:09 +0100
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
Subject: Re: [PATCH net 2/4] net: ethernet: cortina: Fix max RX frame define
Message-ID: <562fcea9-9378-4b81-ab92-9681f0c487cc@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-2-9c5513f22f33@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-2-9c5513f22f33@linaro.org>

On Sat, Nov 04, 2023 at 01:43:49PM +0100, Linus Walleij wrote:
> Enumerator 3 is 1548 bytes according to the datasheet.
> Not 1542.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

