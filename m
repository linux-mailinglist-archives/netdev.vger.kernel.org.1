Return-Path: <netdev+bounces-211050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A37B164E5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164F87A628B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA32DEA8A;
	Wed, 30 Jul 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qvhbE45E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564C1624E1
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893646; cv=none; b=WDvna/8yEX1XwoWjJUlsyFMIoGDZXdb09mQJON0XQ9CCVAhARMP1ztKuLFMiBfUR+VbGabb8yvu9BCBzvwIVcjKE++16dKm687Ze1RijJIW5iSzMICsHXLcFyuLvY6FivgRcjU18tHoyRm/R42LX81RWB7RXyvEx6T3XZdYJcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893646; c=relaxed/simple;
	bh=HJgQa2x3un2LXu2ghjwgsdDs0UVNd66ef/5hYsK3Zkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNBV6Hca/P3tOOpgAIWfSyciTj/h3S/XCUUb9YNuzYHBuF7IF8Ex+1a7XWmLs2No+tPFTleBkSGzDcCz6f1xVboJ+hyF05DK/WFWmhxndXYVr7wnmlovcJGWbC2pNH/IdJJiDof08f/C41dZzxGlKX3EKJ2mmRlxxL7e8f8/qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qvhbE45E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N8Kjs3bH8aFQj/NnCgzBcFc93BhH8wPAOXv+ad8CFoI=; b=qvhbE45ExIf57l8RR0rLPUgZzR
	r42XPwOowj4gQi+TrGpX0eAY6SZXVuNNQiFJAWY9cLR4S16XU+iTgACQL7y0fPPFGZdUS3tLi8bv3
	FicW37QwCgY69+YSB5mnbxKC5hiONxWpZzaVh98QHdxDZYUXWA3rv8zSKXUxqFzXDKx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh9r9-003IVR-0f; Wed, 30 Jul 2025 18:40:43 +0200
Date: Wed, 30 Jul 2025 18:40:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: _ <j9@nchip.com>
Cc: netdev@vger.kernel.org
Subject: Re: no printk output in dmesg
Message-ID: <6d5c7557-008b-49f5-bedc-912d5c198924@lunn.ch>
References: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439babd9-2f47-4881-a541-5cb63b94aa57@nchip.com>

On Tue, Jul 29, 2025 at 07:26:12PM -0400, _ wrote:
> Hi
> 
> In "stmmac_main.c", in function "stmmac_dvr_probe", after probing is done
> and "ret = register_netdev(ndev);" is successfully executed I try this
> 
> netdev_info(priv->dev, "%s:%d", __func__, __LINE__);
> netdev_alert(priv->dev, "%s:%d", __func__, __LINE__);
> printk(KERN_ALERT "%s : %d", __func__, __LINE__);

It would be normal to end the strings with "\n". The low level kernel
print function has some ability to glue together a line from multiple
parts. It could be without the \n the message is not getting flushed
out the console device, etc.

	Andrew

