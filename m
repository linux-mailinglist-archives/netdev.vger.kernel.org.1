Return-Path: <netdev+bounces-50643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8A7F66BF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86629281673
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5D35EFD;
	Thu, 23 Nov 2023 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="okzPD7pF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7651B3;
	Thu, 23 Nov 2023 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5vDWv3+Vdh2C5jUQTfnkwEb2P2xKkS0YYp9hl8KNogA=; b=okzPD7pF3pX0HtAh0a91/IV1ch
	J+YSpnJliSZC9AcfeEH3PVD+WQaFZOx9wcgMx0TuAavOW8b3OtZFg2PfnOyKnP2A+/elri5Scewdk
	h1UYqKEyG1o95yovTg5hLwHHsQlvR6KCVl4wvqvDFnPS0YgCisOZZJg/c4zcH82apVkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6Et5-0011Wu-6z; Thu, 23 Nov 2023 19:57:19 +0100
Date: Thu, 23 Nov 2023 19:57:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net v1] net: stmmac: xgmac: Disable FPE MMC interrupts
Message-ID: <338001dd-f4d2-46d8-b247-fca1684a0f3e@lunn.ch>
References: <20231123093538.2216633-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123093538.2216633-1-0x1207@gmail.com>

On Thu, Nov 23, 2023 at 05:35:38PM +0800, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") leaves the FPE(Frame Preemption) MMC interrupts enabled.
> Now we disable FPE TX and RX interrupts too.

Just adding to Wojciech reply. We should be able to see 'What' a patch
does by reading the actual change. What is not always obvious is
'Why?' The commit message should be about the 'Why?", and less about
the 'What'.

    Andrew

