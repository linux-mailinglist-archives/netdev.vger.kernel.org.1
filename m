Return-Path: <netdev+bounces-220083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18407B4461E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99851BC6F17
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C024E016;
	Thu,  4 Sep 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gziWJT8I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123A1E51E0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012780; cv=none; b=Q8ZFpYxNggQzszf6hBNYEo7Rn8XGdekfkq5VrQ5F+KEhEhI9RolG4PHxO5U3GkyP5b/fumAaXJdsWtGT+wbxmBGMvShjdVuTSW8MIJHaN/zMFgGkykZnD5V7KBiQVLLi4dMOjC99azCkE+dmry2cdmVgYzYl1vXWa2soEFYib3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012780; c=relaxed/simple;
	bh=0Zioo0UlJ4f3EaPk0r7BzGg4rzzO/BN7G1O1yctbJ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYfBkfN7tXJCG6Qple+R6Jt81LgbRCeCDMu+wQ3w9cAJjEfaBHCk1JaSFjcNB9dKCluH9W/1/QdMHCUdYSZt2OQulSpnauBLw6W5Wc9tdCQU0uB9M2uujlK+nd+gJ2iTzN/G+POmwiJAMx3l+Y4mtSCB0bitbK+2UIIfR3pbXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gziWJT8I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OGqMfvzN+RX7Fb2jN99pOzet46JCEP6Ns/m1waPPGeY=; b=gziWJT8IaDrMtYth2Bj5gtAKKo
	i/ZuviPGV1xM7m4gD1C89+tn3QfECIZaugNDpekVxiEnc1rPZIs+/CEaTG9G0SwytKMwNLbyrRd75
	ziDoGkUjoM9/UP0qwlHnmlJQcVAuoUJ9WE2Euy6jnFagtdrJD5K943adUgPQjrkHxR94=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFHf-007GBa-4S; Thu, 04 Sep 2025 21:06:11 +0200
Date: Thu, 4 Sep 2025 21:06:11 +0200
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
Subject: Re: [PATCH net-next v2 10/11] net: stmmac: mdio: remove redundant
 clock rate tests
Message-ID: <cf78e814-a058-419e-ae7e-f84da4c47a8d@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oc-00000001vpN-0S1A@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oc-00000001vpN-0S1A@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:46PM +0100, Russell King (Oracle) wrote:
> The pattern:
> 
> 	... if (v < A)
> 		...
> 	else if (v >= A && v < B)
> 		...
> 
> can be simplified to:
> 
> 	... if (v < A)
> 		...
> 	else if (v < B)
> 		...
> 
> which makes the string of ifelse more readable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

