Return-Path: <netdev+bounces-42251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454157CDDDF
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F7EB20F61
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814136AE8;
	Wed, 18 Oct 2023 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYGuBX65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA5335C2
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C148C433C8;
	Wed, 18 Oct 2023 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697637152;
	bh=K1Dhr3hZfDVKtLxR/ZTMbEg+7QkrSlzrgGTTVTTgxu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYGuBX65JLvJBpr6PoUDf/vrBelz9XtdvhtAQuC9ozyy4EobVjTTGfLCyklF7g6/r
	 Pm9jNWxk2xpe6nQy6K9sh4fUiqVrf8x03esnGFS6i5bBKYJ/NKQQp0a6fxrW9YLngR
	 2bLCiHk7zCl3NuWfBEyXCNGp2cIWJYl8f3Umti3RVzfk1EDih8PiEfpUWFJ4jyDIDM
	 aniznZKREE9mQqpXk4Kv2rDXyzmspKhcmLM6oOiMT0CEw4fgHwBtokHsx4YMeZAdDh
	 riB7FfryMlC/QSBJV639ZkFJMNGN74o4ebqWGDQMwxbE6Wmqba0+jXM823rGfYPnun
	 Whc+m+nZlxYLw==
Date: Wed, 18 Oct 2023 15:52:28 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: phy: bcm7xxx: Add missing 16nm EPHY
 statistics
Message-ID: <20231018135228.GP1940501@kernel.org>
References: <20231017205119.416392-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017205119.416392-1-florian.fainelli@broadcom.com>

On Tue, Oct 17, 2023 at 01:51:19PM -0700, Florian Fainelli wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



