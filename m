Return-Path: <netdev+bounces-101217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A58FDC6E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3A0B22C62
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44A17580;
	Thu,  6 Jun 2024 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ye8sFZ7n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446319D8A4;
	Thu,  6 Jun 2024 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639221; cv=none; b=DYkYH2FdZL4hbUMuD2wspTknqwq5TvHOLbcxJ66hnPfCYSbFzsmWp16Ljf1NHqRPNBkfdctlBGvJsDyYSff33hmiYo7xCLzAfcVbCOh1nv0ten/XUxt+eV5y4fsoJr5smI1f7kgPJrdmRKukBggPDBQXf3htloZZhm8mmn2lqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639221; c=relaxed/simple;
	bh=6+/R8Ql6dduByazHOFhqp4goj94V/FvcNQwRF8JK4dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1CUbWd0ynFfqymTbaRTXrTy0dNPcf/vGvEAqZwrlwo8wFYpIbQHxtJUkunIRDPoTHKfKT+eSaRyI7uZvtowpn5CA0T7L+xErkCk83c0H63j6u8d+3wybQlP6kR6uBpUPvRsAU5KsYsDE3vGxpCPI2PRCoocZCLZe99uI5n8gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ye8sFZ7n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o1tJShiCjUKTGOnGPoj6gaAEwK5rlY/9SPGoFARED5E=; b=ye8sFZ7n3Ow41VafXGesFb942C
	T3PxLmIglTtRjrHqD3zBOpa7EX2GBUoglJdq1o483eKtnjo1jdIRQTHL8eqyQG/DrE8dbsfcreA+V
	0u7248U3gd0alQbwNttvhDBdHNJOKS549yX5hc7M9uZbqUuQQxeg4JFoY+tNs4WWw7Do=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2QD-00GxxY-UK; Thu, 06 Jun 2024 04:00:09 +0200
Date: Thu, 6 Jun 2024 04:00:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
Message-ID: <ce853496-5556-48eb-9953-d34d6c1cb514@lunn.ch>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102457.4050539-5-vineeth.karumanchi@amd.com>

On Wed, Jun 05, 2024 at 03:54:57PM +0530, Vineeth Karumanchi wrote:
> WOL modes such as magic-packet should be an OS policy.
> By default, advertise supported modes and use ethtool to activate
> the required mode.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

