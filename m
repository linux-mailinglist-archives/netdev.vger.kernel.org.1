Return-Path: <netdev+bounces-84621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786F8979CE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3874B226A0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF445953;
	Wed,  3 Apr 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vRoo6MNq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE183D962
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176422; cv=none; b=G3zXOtrjhnYCJfoCVIhnVeC/fV8hkYHn6RcD6F7ttg4MC3BQGu3ZR6AzZF8PjhLYVB3dSAe+Pys8aSt+9q94LRNQQPeIweZ1ISLU58z/7yr30pMfkQHYcOWKtVKsp+9p2taQtDezZPEMSNqH8Lp7+Nc2QZfUvenDupUKmmBbdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176422; c=relaxed/simple;
	bh=kV8yQKJMR9jgfC4VsLHdnSuZHZcDR6fGoCVZgRwm4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd96RgtxnOy8EvC06iFuzF9anFQWYoM5evGyu3ZbjaU6Q0GyFVUISLESvGB1rW+voyCpSZL4n1QNgE9NbJkm7jlKT0B38mfR5MmLXxwSXnT4+mCfmB79ohtDz6S4erYK8/MWuiTrTFs/4CYkz5HiYdCZcpXurCrvbrR39dTU9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vRoo6MNq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=svmXAR7X5aWdFJv6efM1jOZkodKsLr7G7IbwzDTyPno=; b=vRoo6MNqzwvgcS2dgXN2VgdoKm
	t16Bd8bWkTXCeTpqn8YGdYfyLFhSjmkwbiL6ne/dya0q60uV0fZBKTd1Rl5ResMXhcqG0DrK+xHun
	on5IUwNYvBoIfg2XMfXedkYlbvcDnqNQLoLsGp8zvpVR0rtd5mbu76ZbhGJXH3AthwRY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs7IW-00C74J-R3; Wed, 03 Apr 2024 22:33:28 +0200
Date: Wed, 3 Apr 2024 22:33:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's
 NIC driver
Message-ID: <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>

> + * fbnic_init_module - Driver Registration Routine
> + *
> + * The first routine called when the driver is loaded.  All it does is
> + * register with the PCI subsystem.
> + **/
> +static int __init fbnic_init_module(void)
> +{
> +	int err;
> +
> +	pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);

Please don't spam the kernel log like this. Drivers should only report
when something goes wrong.

     Andrew

