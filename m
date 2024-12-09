Return-Path: <netdev+bounces-150204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF29E9762
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AA1645E9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0E3596F;
	Mon,  9 Dec 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LFEdpqk3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C008233152
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751712; cv=none; b=UolhzswavlRF1rcx04OleEwxQKDurnJ1+qdvE892UXEjE7vBbPvPTehjQhaothllAyMUES1LpI+aklF4YpYOo5cLylApMVW1DuNz0pPmgU6c2T3RsLtz4zC1tuYcf/XzJsD49EaJRhHC9MEPvF2kdjrDxm2vSwPY1WUqx4NcxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751712; c=relaxed/simple;
	bh=bBELRjwXXxVkjJi1rupauKN5d2vHQSBmcRxpcEsfoPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8JhhSMCbu/gOAvsPjikdY/Lu7YoiITQ5p/x90zXa6obIc+Ge+CGsRRvzP54sr9dqSLEDQ46j2+/O4pZ5kJfTVZqPoK/Ao60t1hbc7QITLp7/AHM68BeTFm6oniQXccNFXkm2/iRXzR4k0v84pLKJRw0gm4MkjTmVM9u0u73XlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LFEdpqk3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MbRdvqh7mjeyDSPaKW0vbfhpGu4GFVcDzjz5R7/zWFc=; b=LFEdpqk3MCE/DexBBTARceR1vb
	1DmSjgIKzRhUOUTAJJRUYX9CBs7znZiGpbAnZfIFLXh8QAATFTf+8/irzlHAqOetE+sc5mcwP3uHq
	U+XyfE35sG2YcHuw0oR/KdN84yD7yz7OPJgKCtoNurluMSz8N6tFfwwMaki4nuakua2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKe1E-00Ffon-PT; Mon, 09 Dec 2024 14:41:48 +0100
Date: Mon, 9 Dec 2024 14:41:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
Message-ID: <3b9ec0a5-35b3-4c23-bbf2-c9e509a54da2@lunn.ch>
References: <20241209071101.3392590-9-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-9-tianx@yunsilicon.com>

> +static void xsc_remove_eth_driver(void)
> +{
> +	pr_info("remove ethernet driver\n");
> +	xsc_unregister_interface(&xsc_interface);
> +}
> +
> +static int xsc_net_reboot_event_handler(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	pr_info("xsc net driver recv %lu event\n", action);
> +	xsc_remove_eth_driver();
> +
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block xsc_net_nb = {
> +	.notifier_call = xsc_net_reboot_event_handler,
> +	.next = NULL,
> +	.priority = 1,
> +};
> +
> +static __init int xsc_net_driver_init(void)
> +{
> +	int ret;
> +
> +	pr_info("add ethernet driver\n");

Please don't spam the kernel log with all the pr_info() calls.

	Andrew

