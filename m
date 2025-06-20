Return-Path: <netdev+bounces-199918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328FAE2319
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE597ADC84
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EA22C355;
	Fri, 20 Jun 2025 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxQhk8JN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80A221FBF;
	Fri, 20 Jun 2025 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449300; cv=none; b=hZX08cmz7Y7h5LQIogNJ7SOc45P/D7NnsOsoTSbLW3REyRtSZZYbgb/pyAl0y/jAlWbRnnBsbqWBfr74h2qwnZi1DDOUdUoqLrCor3q7eukxOboRzeSsDijs8BXTTlGoda2S2Dep1NY81Jc75A+wUc0cGRFoDD52+MG0zJqtq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449300; c=relaxed/simple;
	bh=pySmXwSoyXawUE5lOnRaqr9m9TZBHviSkIg2SRRuX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDExrsImS6uZ2JZ22gGxI7BrcO2YvCgw8Xk8Ry4UyWlxjJ+Y8MWdBs/qOqJ1Q6TCki0g/dvmfhFcazry9JPvWgQU9bE6aBWzwHhZVXTETeP0GLLzY8o+v/kwfAdy9U8c0gFFKWylsj6eIiqy1KOBlUx3ZgVR+QLNhCqf4neBekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxQhk8JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8326C4CEE3;
	Fri, 20 Jun 2025 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750449299;
	bh=pySmXwSoyXawUE5lOnRaqr9m9TZBHviSkIg2SRRuX38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxQhk8JNCzaL8/q8x4EhcJeBc60BO9OOzIA5hIMUvJ+pycDoC7fhFn/alRkio7MYS
	 BnnlC+ivohmNlOgJUH9jUDGBnQEGl2gw+GaLKe20HW6Lh2bVnvDWaChOUHBn5dWBpN
	 e2+MflIzwkCeGkO6mfVuJ25SEjx0UWOLYz41i8olocWpHmcz15Jv+xVVNeSeap05Az
	 s4dYRxreq2shNI0VdzCnKdxq8rCcDAybviJeF/JY2nEaWGDvwrmzzPtpD+C60qU/nf
	 nsSHnRPKJ4Hq7FT4ZJikXwoj9QXGWWxT99tMHhn95t7VG4a1aHxwMdyNUMOOAxBdbn
	 J2SprTsJuhDAg==
Date: Fri, 20 Jun 2025 20:54:55 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel test robot <lkp@intel.com>, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: pse-pd: Fix ethnl_pse_send_ntf() stub
 parameter type
Message-ID: <20250620195455.GA9190@horms.kernel.org>
References: <20250620091641.2098028-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620091641.2098028-1-kory.maincent@bootlin.com>

On Fri, Jun 20, 2025 at 11:16:41AM +0200, Kory Maincent wrote:
> The ethnl_pse_send_ntf() stub function has incorrect parameter type when
> CONFIG_ETHTOOL_NETLINK is disabled. The function should take a net_device
> pointer instead of phy_device pointer to match the actual implementation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506200355.TqFiYUbN-lkp@intel.com/
> Fixes: fc0e6db30941 ("net: pse-pd: Add support for reporting events")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I note that this is a fix for a patch present in net-next but not net,
so the Fixes tag + target of net-next combination looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

