Return-Path: <netdev+bounces-198342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA2ADBDBF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A180E3B3413
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833522D9E6;
	Mon, 16 Jun 2025 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="shsnZ0gb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5A235072
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116905; cv=none; b=P5xVicSxjiM02KC0yby5NIfCEkVe0FJOa1hYZ11LsJ+OtKfrCqnHlW9KFQRAJzNin1rdvlJC+7GsuKpbwUMB0Zmu9nHgcdJuLMOAq7Pm8r4GJzCK0JIe50sqEOEjitJujlnyiaP6RjhWWW1uDZYSnrK4nh0xxTc6wgwdGysjAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116905; c=relaxed/simple;
	bh=bhL4UjVmtGafZ9Dm+OdiOdn+SBY8CAK3m7UYM0xNzIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqXNR9D2CuWnc+KLuGj16xto1JGb7AyDsDiwokskpHZN7wVhM056Ju3PvuU/IYsle30/b9HJIwScjgWSj7F7xl6hmFtedBU76JHG5fn+a2+mAqNo9IIwvjZH0VKjWI4IkzzPi2d8/kedHNx66gemZZj7OjUWTfsCD7OTl4JndeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=shsnZ0gb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Un0+1ftM5WRDevFf0RglkkUzK/GEGJ7mZMlQpvr5d4=; b=shsnZ0gblK/6NNim4BRE3Qat8l
	S+foVhF9x2p5hrnudDOu3/47ZX/MyR8FIwM6uUA+Pp6IMvxWcBrDRHH3u0FpBAms1i7z/6hqv/PuZ
	DP/cFv2nC13B3z4ZyexETRX8zFLwZDmdeQ0Qnt6C0g09DHZrdYGxqPldFkXtNE0+425I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJLq-00G6Ta-7Y; Tue, 17 Jun 2025 01:34:54 +0200
Date: Tue, 17 Jun 2025 01:34:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/4] net: stmmac: visconti: clean up code
 formatting
Message-ID: <eb9cf1c9-e03e-4fe0-886f-08fcb349b003@lunn.ch>
References: <aFCHJWXSLbUoogi6@shell.armlinux.org.uk>
 <E1uRH2B-004UyS-Ch@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uRH2B-004UyS-Ch@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 10:06:27PM +0100, Russell King (Oracle) wrote:
> Ensure that code is wrapped prior to column 80, and shorten the
> needlessly long "clk_sel_val" to just "clk_sel".
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

