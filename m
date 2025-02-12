Return-Path: <netdev+bounces-165342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA40A31B7F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ABF18860B9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CB1CA9C;
	Wed, 12 Feb 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J55hrgTK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EDA50
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324942; cv=none; b=JP20Jfl3HER9jsmj6U9FVj5Emxu68yNBnYqH4YjSZj98Scw3QDPKASLaQu6cDXJgrZpDZXxt2pUKMxGkzU8g5xZvye5y7KEXwX7Ngrqpl5s1WOiWtAaiyfWbLcTcXrlfoxUMpSrOAaunDX+dcv1d5BwhjpfZ6tba3cXpvMdAlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324942; c=relaxed/simple;
	bh=HC+70OmC/K9tDRFpVOB0d0icK0tVN2JIdDajikQjzrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu60S0U11SQD42P+nWUqrh3zjHw0L2OSYZGLV+FKEqOgCAC4l4U0FOZuEB0GBEaLfA1/icxTD2v2fLdW/+7HJ2OsbFr5yHEf7083/n9oZXZkIeHSrb0hJCSJWVqulOm3YfIWIgUlQ9/C/yXCcDB/hXi2t2O1TRVZeDat0Oc83CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J55hrgTK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vBjQKFm9bLB7d7bWC5R45kW4Z8b7qy0/auV0S7iVnU=; b=J55hrgTKGY29+Co5zQvZ2z1jHy
	Xvdrp0AvWvACrLTKTZIbyeD0mo3PJ3oqpENw/1oySYz433JBGXuT5IAKkLeSmSsX//ysHyeBxkpFa
	iV3fhqfcQrQA4mY1lCuhgQWw1zJkGs3hqxDawrbSvzhHAClzzzfCmpTZgQLNJUVf6Cx4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti1rm-00DF1x-Su; Wed, 12 Feb 2025 02:48:42 +0100
Date: Wed, 12 Feb 2025 02:48:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: phy: Support speed selection for
 PHY loopback
Message-ID: <57e02f9b-ff5e-44fa-b2fa-cbd7dd93408a@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-3-gerhard@engleder-embedded.com>

> +int phy_loopback(struct phy_device *phydev, bool enable, int speed)
> +{
> +	bool link_up = false;
> +	int ret = 0;
> +
> +	if (!phydev->drv)
> +		return -EIO;
> +
> +	mutex_lock(&phydev->lock);
> +
> +	if (enable && phydev->loopback_enabled) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!enable && !phydev->loopback_enabled) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (enable) {
> +		/*
> +		 * Link up is signaled with a defined speed. If speed changes,
> +		 * then first link down and after that link up needs to be
> +		 * signaled.
> +		 */
> +		if (phydev->link && phydev->state == PHY_RUNNING) {
> +			/* link is up and signaled */
> +			if (speed && phydev->speed != speed) {
> +				/* signal link down and up for new speed */
> +				phydev->link = false;
> +				phydev->state = PHY_NOLINK;
> +				phy_link_down(phydev);

If you set the link down here...

> +
> +				link_up = true;
> +			}
> +		} else {
> +			/* link is not signaled */
> +			if (speed) {
> +				/* signal link up for new speed */
> +				link_up = true;
> +			}
> +		}
> +	}
> +
> +	if (phydev->drv->set_loopback)
> +		ret = phydev->drv->set_loopback(phydev, enable, speed);
> +	else
> +		ret = genphy_loopback(phydev, enable, speed);
> +
> +	if (ret)
> +		goto out;

and this fails, you leave the link down. You should make an attempt to
restore the link to the old state before returning the error.

	Andrew

