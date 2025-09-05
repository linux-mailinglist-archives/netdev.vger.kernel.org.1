Return-Path: <netdev+bounces-220330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9EB45714
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CF524E52E2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BFF34F485;
	Fri,  5 Sep 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTJPCMEF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60B34AB15;
	Fri,  5 Sep 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073571; cv=none; b=cEkg32Oop6SLzF9h2NCvmfs6VUbdulCjDpmUxmZMw7YWOMXNz/GBtNn6EII9wYPdkQSHn6G8P9LXGzuAFQAbCpn9nZGIO4JIp4IVZjEVRkgjtzfRU2uwHUuMsIpeh/w8WjcB6cH7FmygbJY0xw+8IWeDpvW6r/mSKaTtRq9lico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073571; c=relaxed/simple;
	bh=FX1kSL/2Pwbo32oNmhExqjE9grmWE3cwBwKT+DcKSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy4KwgwKIZMuZIt2CDEmHPo26FE4IpqD6NesXMDUF62nZ3Ov7R2ifM7sd5zA2tXkE8xXTbvlyLMV7ldy3Kbo646Z/o9pzaBIrbYw3aXaPXdy9p68vXtuZ7w/Mw2z01qN7pN+zv39Jue6m5E+jj8gqjbUzovw1Xg5yDetYWQHrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTJPCMEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B69C4CEF9;
	Fri,  5 Sep 2025 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757073569;
	bh=FX1kSL/2Pwbo32oNmhExqjE9grmWE3cwBwKT+DcKSuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTJPCMEFZgVg12SCpBXKQg0kb+njfHH3lUn8QXbEXmS85RQp/pbtBIg1gKXI26uVY
	 Na6bFfxEQf0HpZOtrW0qSVy/Cxula/Kxo/+emsnlPQheXbkEute1gbhDs4nbrHKvwC
	 HHQhDtNTaBEXTntuXSLknyRqGQZH1rRw1C42VHGaRze5WjXG3a6p3kDimJAVzUGELL
	 fAUoTcej/DW30hFc2BlmF5mvtQyUQyptQ+lqxna52h/JDQnnvzniKx+PewMgIT5xFj
	 afpNo6SIFwAoyEZMKdCCLHtnqo282tl461e0Kv8/LUnP1qzV3E0WqV+/pjBQi4QnmO
	 eneBLykNN2n0A==
Date: Fri, 5 Sep 2025 12:59:25 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
Message-ID: <20250905115925.GN372207@horms.kernel.org>
References: <20250904203834.3660-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203834.3660-1-rosenp@gmail.com>

On Thu, Sep 04, 2025 at 01:38:34PM -0700, Rosen Penev wrote:
> The documentation for lan966x states that phy-mode is a required
> property but the code does not enforce this. Add an error check.
> 
> Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 7001584f1b7a..5d28710f4fd2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *pdev)
>  			continue;
>  
>  		phy_mode = fwnode_get_phy_mode(portnp);
> +		if (phy_mode)

Hi,

I think that err needs to be set here,
as it will be the return value of the function.

Flagged by Smatch.

> +			goto cleanup_ports;
> +
>  		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
>  		if (err)
>  			goto cleanup_ports;
> -- 
> 2.51.0
> 
> 

