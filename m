Return-Path: <netdev+bounces-160792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B204CA1B807
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB832188E58B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27CE13AD20;
	Fri, 24 Jan 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ncLwrlss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BC4EB48;
	Fri, 24 Jan 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729792; cv=none; b=JWjox/hxZWdT1lM+q7GKG9Nh/u3768Ow/wHYzRWvolY58xzCthwAFP5V1JMXkuFvTJv0XpsasmKhKfZdrH5lU9tOwDvzCK9PwTM+CDY1/IB6CMvqXSibX2xjqmFHCEAWlwlqK5iwU2TnK+VbOpSou1rhERSJVBIXWNky3GAYBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729792; c=relaxed/simple;
	bh=XWIansjWfB6/cN0pf+f69gYOD3xJGmRW2DqjLWAWN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMn+U9hMCnYtUUMNSlNSllQzbjST9rkZ3Nmu5WOLX6VUoLMmZ1TBDE2ZNyPSu5ju6XsOHLyN3KT+N2iSkyUv34gvTMh/I42swQe4t7m7K4c9E7WrZ7yC8MLeadh5UD+hYw/ViJJirB5JEAb0RGGi8sKUeGs2yH6/Hhgx+1AupPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ncLwrlss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=StI7FEme8i948SJseunjHBlFBz6s+jAl0egNazf6pAk=; b=ncLwrlssI7u2ik/5DiQxfsI0nA
	pzSzWRapnLX6PmJjDqvHetj9cbissTZCCBCTRtAmRGMURE9VokOAsZmc2Qe84KndFuX9TZXkOiDDV
	Fn43cRQVh1zu+nK0aOdnj7c/4AbtBcDpR2XT8x9TZ3sjQPF8AosCyufV4ZnrNVleL+CI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbKtX-007c9e-Tf; Fri, 24 Jan 2025 15:42:51 +0100
Date: Fri, 24 Jan 2025 15:42:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Milos Reljin <milos_reljin@outlook.com>
Cc: andrei.botila@oss.nxp.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com
Subject: Re: [PATCH net v3] net: phy: c45-tjaxx: add delay between MDIO write
 and read in soft_reset
Message-ID: <1ae9abac-8fde-4111-9dcb-ad06054db9b3@lunn.ch>
References: <AM8P250MB0124D258E5A71041AF2CC322E1E32@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8P250MB0124D258E5A71041AF2CC322E1E32@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>

On Fri, Jan 24, 2025 at 10:41:02AM +0000, Milos Reljin wrote:
> In application note (AN13663) for TJA1120, on page 30, there's a figure
> with average PHY startup timing values following software reset.
> The time it takes for SMI to become operational after software reset
> ranges roughly from 500 us to 1500 us.
> 
> This commit adds 2000 us delay after MDIO write which triggers software
> reset. Without this delay, soft_reset function returns an error and
> prevents successful PHY init.
> 
> Cc: stable@vger.kernel.org
> Fixes: b050f2f15e04 ("phy: nxp-c45: add driver for tja1103")
> Signed-off-by: Milos Reljin <milos_reljin@outlook.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

