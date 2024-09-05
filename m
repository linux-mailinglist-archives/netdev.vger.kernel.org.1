Return-Path: <netdev+bounces-125531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398F96D8CB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A161F28093
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A819995A;
	Thu,  5 Sep 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1a+VgIF1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FB19B3E4;
	Thu,  5 Sep 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539945; cv=none; b=QiEw6LgLZEINYgv8pgBfxH6DlkMI5jsAKUzuWuAEMAtC2jk1cY3m1QBH6x/itEJFNkpMFfCl876AOD1krv4m6uCiwrFS9334u1GKY8/SrOk5yIaJNsvmy7EeF3mFAlhdh47PyEKFujP6B6wHJ1jYpc68g9GNHTcXCDNR0xstGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539945; c=relaxed/simple;
	bh=HIGsIXeugJQTCWAVm8XzbJYQEWiE/wuX3YHavCWJfXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5EnaDoTgzVUWnDqsC8ktXwSnSC0+JOSxqfDwZbu0Ri52W1mYwn0dYITC050BAjKybJeEdhtJjvKYlpk6YBLxuKrwuUC7Mj/wrJBVnembncjc49KNdPFmzNR3bl3aZBxU2k0xJWaGUOLYmBtmKaFD/jWbrrAPLdUQTIvvVPVnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1a+VgIF1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nbszc8u1ehabZGC5jnFsbhiRNH6rI1/BMSG1Fv5VDc8=; b=1a+VgIF1rva6uLAA0BUgoKxB1V
	8usNVlYzuZ1eTqiFuG6aMnQx62LA0WjIZv8sSOSV2XtFC6ub3bPPlyC4J54+o2PcTPEp/G3Q0T0Uz
	5OGj2GGz23FSJoHe1D4ZuKM/PvLvaK6rCH8f36eU8YUmzTp/0aIqsuSBVdmjV+kmJD1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smBlE-006fzA-UR; Thu, 05 Sep 2024 14:38:52 +0200
Date: Thu, 5 Sep 2024 14:38:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Message-ID: <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
References: <20240904102606.136874-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102606.136874-1-tarun.alle@microchip.com>

> +	/* Get 200 SQI raw readings */
> +	for (int i = 0; i < 200; i++) {

Please replace all the hard coded 200 with ARRAY_SIZE(rawtable). That
makes it easier to tune the size of the table without causing buffer
overrun bugs.

> +		rc = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +				   LAN887X_POKE_PEEK_100,
> +				   LAN887X_POKE_PEEK_100_EN);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +				  LAN887X_SQI_MSE_100);
> +		if (rc < 0)
> +			return rc;
> +
> +		rawtable[i] = rc;
> +		rc = genphy_c45_read_link(phydev);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (!phydev->link)
> +			return -ENETDOWN;
> +	}

How long does this take?

genphy_c45_read_link() takes a few MDIO transaction, plus the two you
see here. So maybe 1000 MDIO bus transactions? Which could be
3000-4000 if it needs to use C45 over C22.

Do you have any data on the accuracy, with say 10, 20, 40, 80, 160
samples?

Can the genphy_c45_read_link() be moved out of the loop? If the link
is lost, is the sample totally random, or does it have a well defined
value? Looking at the link status every iteration, rather than before
and after collecting the samples, you are trying to protect against
the link going down and back up again. If it is taking a couple of
seconds to collect all the samples, i suppose that is possible, but if
its 50ms, do you really have to worry?

> +static int lan887x_get_sqi(struct phy_device *phydev)
> +{
> +	int rc, val;
> +
> +	if (phydev->speed != SPEED_1000 &&
> +	    phydev->speed != SPEED_100) {
> +		return -EINVAL;
> +	}

Can that happen? Does the PHY support SPEED_10? Or are you trying to
protect against SPEED_UNKOWN because the link is down? ENETDOWN might
be more appropriate that EINVAL.

	Andrew

