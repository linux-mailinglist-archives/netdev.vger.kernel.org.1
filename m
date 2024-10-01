Return-Path: <netdev+bounces-131075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F54898C82C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FB8B234F4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3421CEACE;
	Tue,  1 Oct 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OeXHYPCm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FA1BFE0E;
	Tue,  1 Oct 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821376; cv=none; b=WPPmqj3RgQh1o/598U2MwjeDN9I7uNSWSoRMIngqj4DsjWotVRxw/8U7H3qDqLqWvS+2Niflyfps9vBacN+bvZCkogomhPSnRBrLRIa/AWkdDdcVJkcOIT6FVFlGJWxNSgsCPJYq4rnRqQTo53hlw1n4qXLX+Wczdi9ctMG0POw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821376; c=relaxed/simple;
	bh=ezm7sfmqUxhzACEH1qeh07gli3z5qJTH26Eib/lzF3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVhuk0a+8JOvTMlE4W6qyEJ+D3mrCGEP+/2/GfomP4T9nJvaBDaebUKdnJGde5ARxo0Prsq3OvFh80t/fULWX7T/7WDfDlzru07lP4VO7iVtdLP3dYfIydc+X5N4Bk9Ffhf9PZGc4+TtBmZwkBzQBPnoExtL5TN14uVeF98b/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OeXHYPCm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LTbiQxGhLhjJ2QuFi3zfij1gdteKVnqjtQY6SQNZPns=; b=OeXHYPCmRtWZvSv4Du95Ii74es
	5bwwJg7zf9nOJtCfvHy3aV0Ay31hKrOTVkO/IGpBJfhiKS1S6XZySFuJKx9MMDoUCg0WgAKSfQcvG
	8jq55uGRsODdInLOmEYtP6Zn7s0R+PM0P3BnD+p4aWy9wAuzTzNMCUkLb1+rPM6AxJFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlGY-008mUE-UM; Wed, 02 Oct 2024 00:22:46 +0200
Date: Wed, 2 Oct 2024 00:22:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: Re: [PATCHv2 net-next 1/9] net: smsc911x: use
 devm_platform_ioremap_resource
Message-ID: <40e8ad8e-cc37-45e7-a94c-094b1e0a3775@lunn.ch>
References: <20241001182916.122259-1-rosenp@gmail.com>
 <20241001182916.122259-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001182916.122259-2-rosenp@gmail.com>

> @@ -2414,21 +2404,9 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
>  	struct net_device *dev;
>  	struct smsc911x_data *pdata;
>  	struct smsc911x_platform_config *config = dev_get_platdata(&pdev->dev);
> -	struct resource *res;
> -	int res_size, irq;
> +	int irq;
>  	int retval;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "smsc911x-memory");


> +	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pdata->ioaddr)) {
> +		retval = PTR_ERR(pdata->ioaddr);

I would expect some sort of comment in the commit messages which
explains why resource "smsc911x-memory" is always resource 0.


    Andrew

---
pw-bot: cr

