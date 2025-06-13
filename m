Return-Path: <netdev+bounces-197498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBCAD8D1A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28251897E35
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849115530C;
	Fri, 13 Jun 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tgdjHMFj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462B149C51;
	Fri, 13 Jun 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821360; cv=none; b=ngu316nguDEdUC+ccC8khBmZG2hLhyrp8mMqkWk0+lF2rcX4ggqvC/mt/ozlnnRam0FQFcIIiHLimzaegCp/gavMqRLhmFof7H4Exumw0uN4Btgt41Jnmk9P1Wc4pXI+C6Mb6ZClaLu0uKvnSl49h2wB1mYlzWv9cJo+gZYO4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821360; c=relaxed/simple;
	bh=O/NebmeZGGg2IhdH1S9R3TNHKkIt5wu+2/SmcUFoMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK2xdvuQTIJ4yeS08ljhOKPLt5F2mWqtMc0oHOs718Qcmb1QOxCMmM/m1hWP8+wTOD+xw5bXM9pTegM3Ws9bZUv+AiBozz7Rdx3P6/q7lJvNO7pxvT1D+koXI1+XurMWkm3xbkMhp31jd1YkFel7X70QmFKa46+z7UsGogWTmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tgdjHMFj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tl4tRNDuCjGmIDAuKrhHz1taKxx3ofiUm1DQcYgp0LQ=; b=tgdjHMFjEALwjHYPllcXe90dMY
	/dHuNSnOfY8S9RiTQDzLX4q08nphOh0RRzPAfK7+2gWG4jBWiqr1gygjlsE5FIE8GvIiZAMLNlFdq
	9q6LqliG8J4AxwAUWnSfyi/yzsApx0OXoKJ92sUvR0g8HZ10+pahbAfgGExPMrsgNbxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ4Sv-00FiWb-Do; Fri, 13 Jun 2025 15:29:05 +0200
Date: Fri, 13 Jun 2025 15:29:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: Add c45_phy_ids sysfs directory
 entry
Message-ID: <e2c55a28-a247-4184-8708-1e325d4e9706@lunn.ch>
References: <20250613131903.2961-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613131903.2961-1-yajun.deng@linux.dev>

On Fri, Jun 13, 2025 at 09:19:03PM +0800, Yajun Deng wrote:
> The phy_id field only shows the PHY ID of the C22 device, and the C45
> device did not store its PHY ID in this field.
> 
> Add a new phy_mmd_group, and export the mmd<n>_device_id for the C45
> device. These files are invisible to the C22 device.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew



