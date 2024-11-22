Return-Path: <netdev+bounces-146810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69C9D5FAD
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CD9B240E2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD41DE3BF;
	Fri, 22 Nov 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZJIY4oyt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79151EB39;
	Fri, 22 Nov 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281818; cv=none; b=XM0aNKiZt/AowvJ7tYZFZVTNuwb1yoyseBzMVl/GVXbA59KxqRyZM1ZcRIzPbdD2jVJSrwvw7Sc6sBNu7SiOWwt1eShpcKUppB9RrqpfWvdee0dgaEzzWQd9xQrSOXW06EuHadPwjwUnfjdLCOSL7QeVJwK95eSCMX6NW3GvVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281818; c=relaxed/simple;
	bh=mZ21rdDJ3zAnuFWlyHb6NiiUnMUpMAbEM3+ycKs7pqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4UQV0sA02+ah7DH60i1/s7yRgi34Do5iqEcjBlEvyJgoqKDyQFBPEoMQ1w5CrGrXVl1EwLM11vCvU1uiFo0SV6xQ9AkF4HOv5hnMinFkrYoKD/4aequTTbhJ5hrhIgNgirSlqkkTM/jPaNfsTSH2EJdtgEvpX/+HU/p33DMaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZJIY4oyt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vaUybqTQpiem73Wv9ncKdezE+jM2aHBMFGGvXpQ/rDg=; b=ZJIY4oytWD7tCq2gw3kNRX3C0x
	yww5cYYEuoKNOzJGgus/vCZxuQNqur6si0hlRVua7ous07wpm/LibF1vJIbXD7uPwqdZAcqlxf/Ii
	q75y+buO1H+Ze+HRcnGw9enmlWxIyP8K1Z7I55O2wGU00oSCEZNinP78u0cB212AhCM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tETdA-00E8kl-BL; Fri, 22 Nov 2024 14:23:28 +0100
Date: Fri, 22 Nov 2024 14:23:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: mdio-ipq4019: add missing error check
Message-ID: <d92dc1d4-44c7-434c-ae8e-6620a7ce52cc@lunn.ch>
References: <20241121193152.8966-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121193152.8966-1-rosenp@gmail.com>

On Thu, Nov 21, 2024 at 11:31:52AM -0800, Rosen Penev wrote:
> If an optional resource is found but fails to remap, return on failure.
> Avoids any potential problems when using the iomapped resource as the
> assumption is that it's available.
> 
> Fixes: 23a890d493e3 ("net: mdio: Add the reset function for IPQ MDIO driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

