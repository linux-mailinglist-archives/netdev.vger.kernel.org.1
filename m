Return-Path: <netdev+bounces-194802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF44ACCAD1
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ED917686A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394323D2A9;
	Tue,  3 Jun 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jQ3wAnMe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB823D28C;
	Tue,  3 Jun 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966246; cv=none; b=Rj1PEMvKUxVvQ6vZPrauTFBf47c9mia/KzxRat6JSO5+ENnwVfgTBr0wJZP+AuhZ2p9jzAFexnmztnDlwUk+Bd9zLCu3i7G6K2Uva1TpniD5cn5DqyM/bxswvgSjSJJkI0gR09To1x82EinCaAiv26Sz31zxOXHzGoj2uhegAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966246; c=relaxed/simple;
	bh=PpH+6e7ifnDCPX8rSR/T8BXwr0K8/Bj2KcSVGUYY5RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTQnSJvC4N92cdMn48Vn9ZmZ1qH9mgpWWHcYL3hrqRolwLFzu+nC9Bp3JP3UvS/bmfihk7JAN0+jubHgzTmBoOSz5awI2XeG+HnJaY9WhTs2FK0coeuUmxvuaM/oWoclwFarc56XEbUNnpA04vqvO+yTTk4GY9O9nWxQfbEG4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jQ3wAnMe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q/i6f3Ru7JAiYV6cS3SdbbZlqAdkedBY2Bh7anq1a4A=; b=jQ3wAnMeEjjsZLLl6MJa1sqpx2
	q/oS20pqZnF0LTXo7sJfDXy6AQzPbDqT1XPQx+Ou1CebU7g+2o9HLJ07Gd2gbJOqOjQSsvD3eiIZ2
	AwJ0PJey/keOcrEm8bRaSjlPeebg/k3RYGB9kYNcMnP4P8CXC5V+d1Sh4SyVtZ5cjk9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uMU0c-00Eawb-D6; Tue, 03 Jun 2025 17:57:02 +0200
Date: Tue, 3 Jun 2025 17:57:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abin Joseph <abin.joseph@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, git@amd.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: Add shutdown operation support
Message-ID: <3f3a9687-1dea-41fb-8567-1186d4fa2df2@lunn.ch>
References: <20250603152724.3004759-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603152724.3004759-1-abin.joseph@amd.com>

> +static void macb_shutdown(struct platform_device *pdev)
> +{
> +	struct net_device *netdev = dev_get_drvdata(&pdev->dev);
> +
> +	netif_device_detach(netdev);
> +	dev_close(netdev);
> +}

Have you tried this on a device which was admin down? It seems like
you get unbalanced open()/close() calls.

    Andrew

