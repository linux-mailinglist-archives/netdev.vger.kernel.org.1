Return-Path: <netdev+bounces-220117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43CB447F9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB811899237
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573D293C4E;
	Thu,  4 Sep 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SQn/Y1/S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73928D8CC;
	Thu,  4 Sep 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019742; cv=none; b=MAzH1AFooeAlPc3qAyQefqCZfTEePs5dpRW+cXg7DiC4GPWoEsuEV8arKRnNMI4d+thIbGukJFdu6uIg1Acl/VwIIOUA0yRvWdpFtqAXXZTHVtRdwYCvdgqCnANO2gonwP5DVZpb569ZjVhN9rnmHGhxA/st9fnr1WCKDVo2WGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019742; c=relaxed/simple;
	bh=tDUmtKiAmfLggFiIfyLwFQa8v67he3woUzBRC8/bkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYAwW6TS2+Th1SxoazxwYWDPqO14yf0ajACjD4DyySQnv47lhqxW5v1acebkr0B0zZamRtkkK1L44HYdrQQjIM0zXUaDZHC/y6CInx1n8v/YeS4gKIIboKmyhQ+ScoZO1VGjIutHdDxkeoBdAaWMTqWZSAzfOVDGqQVJuvXddLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SQn/Y1/S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dxzBPSAFsQckba1frp35n5o1ZHGDhJqh3J+KGp3RDhc=; b=SQn/Y1/SO+tyJtbMtXcc6PV5fP
	kY715f7wzZ5A769O7Bh8a6/+yXTWDcHSZBJ2e6VWE36x0PM8Q3Haii/o0T7c/8IM8ifQI5LWPizsy
	6+Kkt0PmRMaIWZgZbfIp0CaqdzZmomte2C2BDiKsIg5oAvvKLt5xVNTZD4aFMGwxtiPw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuH5w-007GxV-8t; Thu, 04 Sep 2025 23:02:12 +0200
Date: Thu, 4 Sep 2025 23:02:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
Message-ID: <29a8a01e-48be-4057-a382-e75e68f00cf0@lunn.ch>
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
> +			goto cleanup_ports;

I think a dev_err_probe() would be good here to give a clue why the
interfce failed to prove.


    Andrew

---
pw-bot: cr

