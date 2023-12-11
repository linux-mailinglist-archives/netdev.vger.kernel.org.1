Return-Path: <netdev+bounces-55952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED180CF3B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88DA1C20C0C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154E4AF81;
	Mon, 11 Dec 2023 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IlmwAPyL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071DBE9;
	Mon, 11 Dec 2023 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JauBR/LEbHCc2vv8KSJsV1oxQwfG5ifcWzxVqBIww94=; b=IlmwAPyL2w+N8oz9Vmlqb/9KEs
	WZsIRZwCWYozgqSIHxkPUjfG6zTpZLjQJjPWclLgcV35wXbJzvy+kDIcXCebxoLSf+En77GKwvQtd
	UyiuNn/x/XbRETkeoutNzf7b+1ABtJrabw3pw+JBBYgfz7XppsYfy0NajxKzW4Q+bQgc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rChxe-002dGd-PN; Mon, 11 Dec 2023 16:12:46 +0100
Date: Mon, 11 Dec 2023 16:12:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: phy: c45: add
 genphy_c45_pma_read_ext_abilities() function
Message-ID: <e6d03b2a-a590-4a32-bb81-d9b356ddb5b8@lunn.ch>
References: <20231208151159.2791794-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208151159.2791794-1-o.rempel@pengutronix.de>

On Fri, Dec 08, 2023 at 04:11:58PM +0100, Oleksij Rempel wrote:
> Move part of the genphy_c45_pma_read_abilities() code to a separate
> function.
> 
> Some PHYs do not implement PMA/PMD status 2 register (Register 1.8) but
> do implement PMA/PMD extended ability register (Register 1.11). To make
> use of it, we need to be able to access this part of code separately.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

