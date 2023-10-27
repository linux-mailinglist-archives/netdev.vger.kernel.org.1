Return-Path: <netdev+bounces-44725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF77D970E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6710D1C20F7F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E118C20;
	Fri, 27 Oct 2023 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TX9atbL1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC54BA50
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 11:55:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D5186;
	Fri, 27 Oct 2023 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xKkgQbSQCEpZQloC8PIwFH82W161i281OBtZkhnuCC8=; b=TX9atbL1jQWE81Enyh8HJrA9xI
	K2Ysh8YrtMMYUX6cwdcHb7MJCV9OL9/8XNYhnrwF8fYHCNdvtYXmA98KPpbjRKU5XLWdrZkBdlVj2
	c6FwQpC2+rAx0UevgxpPwl/3TFYpt9Dmeo/U+IipSCOW+tHtpINI325wE7zCHnjBmbhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwLQq-000Ko8-Nf; Fri, 27 Oct 2023 13:55:16 +0200
Date: Fri, 27 Oct 2023 13:55:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Jerry Ray <jerry.ray@microchip.com>, Mans Rullgard <mans@mansr.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lan9303: consequently nested-lock physical MDIO
Message-ID: <f0e67b6e-e226-46fc-9e7c-60da35938d3f@lunn.ch>
References: <20231027065741.534971-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027065741.534971-1-alexander.sverdlin@siemens.com>

On Fri, Oct 27, 2023 at 08:57:38AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When LAN9303 is MDIO-connected two callchains exist into
> mdio->bus->write():
> 
> 1. switch ports 1&2 ("physical" PHYs):
> 
> virtual (switch-internal) MDIO bus (lan9303_switch_ops->phy_{read|write})->
>   lan9303_mdio_phy_{read|write} -> mdiobus_{read|write}_nested
> 
> 2. LAN9303 virtual PHY:
> 
> virtual MDIO bus (lan9303_phy_{read|write}) ->
>   lan9303_virt_phy_reg_{read|write} -> regmap -> lan9303_mdio_{read|write}


> Cc: stable@vger.kernel.org
> Fixes: dc7005831523 ("net: dsa: LAN9303: add MDIO managed mode support")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

