Return-Path: <netdev+bounces-220084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA6B44624
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0EC1CC1DD3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74E25A2A5;
	Thu,  4 Sep 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iao1eaBP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5B2417D4
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012821; cv=none; b=UUVSvsIdUQy+E/IiPshvRNVAsx3fagalw/ujFl/mlRXDwWgOLYXU8h0nxNfyDd9j7+wxjmN7PsXE5GAIKJO9wd7scEJOaAHVMtMnqfjGIFh2Hjsm4hZnbcyEaiIo6ai1pzoAgbltuX56HArv9AxQ42ZYmY+jrBd8Tz+PTctSHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012821; c=relaxed/simple;
	bh=MtfZa1k7punazYHLZHjV6BdtuJwbPDuoroVR20HUX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ1Idu3nLoWOqE400mw1o8oZVs+8boqD5Kpf6x4jjilfBPZV+3wJLmpWHafWzgh9lCBleTvWN0W5p2LMChuBOurlxkevINa4Xmj+hbOuNwsJNRc3364n4GSw058M0Bl75BppwqO6ZvdqxeiYLTlFg23loqbsETSyz9kfxGgtEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iao1eaBP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZNStzmu/S7k70SieMDJinKLC9M3S5bgWLe20xLF8iK0=; b=Iao1eaBPpwmvC26vIrLRsjIMwp
	GocEdjrd+xTFgvDV3sp7nvS30n7Rl0j9cU0UTXQvLssnXw9murb3hM3AKQHQkCnBJjrFT4o7blW89
	AYGstPfv2I2+uzZlaLQIiohAnKcC4yCPlWTqcnjUB2c10vdtCU0z0wdyDZQR5Q8erXaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFIJ-007GCU-LE; Thu, 04 Sep 2025 21:06:51 +0200
Date: Thu, 4 Sep 2025 21:06:51 +0200
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
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 11/11] net: stmmac: use STMMAC_CSR_xxx
 definitions in platform glue
Message-ID: <495816bd-221c-40c8-992d-a2b7e2b213d6@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oh-00000001vpT-0vk2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oh-00000001vpT-0vk2@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:51PM +0100, Russell King (Oracle) wrote:
> Use the STMMAC_CSR_xxx definitions to initialise plat->clk_csr in the
> platform glue drivers to make the integer values meaningful.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

