Return-Path: <netdev+bounces-36834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B87B1F49
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AED60281C19
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DC38BB7;
	Thu, 28 Sep 2023 14:15:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE310EB
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:15:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D891A2;
	Thu, 28 Sep 2023 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4lXjOnHxB9GLvJaR5Fv2Rluj6iGN8aIBrvlbtWJ+c7Y=; b=Vs+d2nBqAow7wdJmsNe/CO9t4R
	zxAYiw0gQU9Yv6337xt4dlPOMeaUgpnBeP02x/1SIfp7GNNjPr6cr7xYVoeVqVfsjIRjmC5Dt8KK0
	+cm3K60f3R8GCEzQjnsLIA1CHefuqIJc7Ezxv7JQ51ZDntp5uucrz/JQ/Oq1aqu3hrtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qlrnv-007kYz-Jc; Thu, 28 Sep 2023 16:15:47 +0200
Date: Thu, 28 Sep 2023 16:15:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Tam Nguyen <tam.nguyen.xa@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH net v3] rswitch: Fix PHY station management clock setting
Message-ID: <42789e22-d429-473c-89b1-dd65eecba863@lunn.ch>
References: <20230926123054.3976752-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926123054.3976752-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 09:30:54PM +0900, Yoshihiro Shimoda wrote:
> Fix the MPIC.PSMCS value following the programming example in the
> section 6.4.2 Management Data Clock (MDC) Setting, Ethernet MAC IP,
> S4 Hardware User Manual Rev.1.00.
> 
> The value is calculated by
>     MPIC.PSMCS = clk[MHz] / (MDC frequency[MHz] * 2) - 1
> with the input clock frequency from clk_get_rate() and MDC frequency
> of 2.5MHz. Otherwise, this driver cannot communicate PHYs on the R-Car
> S4 Starter Kit board.
> 
> Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
> Reported-by: Tam Nguyen <tam.nguyen.xa@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

