Return-Path: <netdev+bounces-103322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0290797C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24B21C230B4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1D1494DF;
	Thu, 13 Jun 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B/oUlh3v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD24C6B;
	Thu, 13 Jun 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298832; cv=none; b=DNE1ih0iv0yarWzyFphV87LWPBFgRH2uZbEeoLmoXHIrADpjK9IBN9X+C2py/4qqCT6oEVT72KXtfogxAG1ZRXLJgNfD052S7mc2PvsvqPRoofTNxqtQlK3/PZLwaORjUPJphbjYifkF+Mq7ehlBR50X5Qf1K1b68JaGRI4VwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298832; c=relaxed/simple;
	bh=RurbkwLbpyNA8X3ETrlVRcztrM3lGDK5+fNbyV5IN/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZauhBFdG0nooCSEk0aGaC/71uouPne9ypBaJtsi8qiD8CHvAc+Q8YRddcI0UWWvAyMFT4xs6x3oxE6Ns5x/fwEwhF4gPOAGvhsMtNiD52RJt8rrWBPyY4lAvIRrQVsRa9sH9bK+OSkZzmVhQdcOhqJBoWXqy+87vlm5vCU8/HMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B/oUlh3v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=w6/11ltu780lh2jX4tChv2b8UmgJrvfcgICTSnxHFmk=; b=B/
	oUlh3vBZhTVNh+yyzfT7umg9yzAZ81yKD+68qgrLdv7qY81n8nM9kL5rUjbOKifZwMfuii0Ekn86q
	Wno3DRhw7uc+Dkrg4cK4iwSsyQcHOuA2wBSY1LqX4Lhz99JIxQGiQxUled69R5vbacNBeP+Y5i8He
	iWEAKv3kX9BQZUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHo0t-00HaWk-LO; Thu, 13 Jun 2024 19:13:27 +0200
Date: Thu, 13 Jun 2024 19:13:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: phy: dp83867: Add SQI support
Message-ID: <0f7cef0d-b5ef-4feb-981e-c587e08de0e9@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
 <20240613145153.2345826-2-jrodrigues@ubimet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613145153.2345826-2-jrodrigues@ubimet.com>

On Thu, Jun 13, 2024 at 04:51:51PM +0200, João Rodrigues wrote:
> Don't report SQI values for 10 ethernet, since the datasheet
> says MSE values are only valid for 100/1000 ethernet

The commit message could be better. Something like:

Don't report the SQI value when the link speed is 10Mbps, since the
datasheet says MSE values are only valid for 100/1000 links.

> +static int dp83867_get_sqi(struct phy_device *phydev)
> +{
> +	u16 mse_val;
> +	int sqi;
> +	int ret;
> +
> +	if (phydev->speed == SPEED_10)
> +		return -EOPNOTSUPP;

What does the datasheet say about MSE where there is no link at all?
Maybe you need to expand this test to include SPEED_UNKNOWN?

    Andrew

---
pw-bot: cr



