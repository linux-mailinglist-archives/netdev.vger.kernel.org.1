Return-Path: <netdev+bounces-189624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF666AB2D5B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2919B17181F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803CE248F61;
	Mon, 12 May 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j4Qfafm6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AA8633F;
	Mon, 12 May 2025 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016014; cv=none; b=f7NJ+BLpIwa/HoWVCM3OZ83Ba1KHr2TqIKgLs8y/UPWV3p5WlBkt0LpsX6ERGBal1cu0Z2A5SzSaQVouqHONr+9VQwzGRbrFUL6JA94Vn16HTLuxAhBwhhk5Ugn2L7PVLnGLqAoS5ko5a1mWkQOrw8s1lwLXdVv87n8KxH0xbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016014; c=relaxed/simple;
	bh=YLbZ2s6S+rAbmcXQn4qdpuboeCF33EFnDBfPvEgmIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjV+SvLFf4jZeQVp6q3dS6l4MfeqFNlC62LH6aSbH+0v7clK0QQr+ZzeEHwyduOqPX/yYizG+6FvrJrInSG8OL279eHozCywS0cT83WWk1GNus9CzkRXAWmXw4tjC9RFOCo/nGtAtmrab6UBJxVShc2UYBdcWc8qbClv9mnoBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j4Qfafm6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=81yI6L03drqcIE6/1CnP/3327RzWZVHHsPq4wWx9unc=; b=j4Qfafm66E2usJnBpD4aPhQcZ5
	+bwf11m0RDtGRKSvyp2Fddw3fiLq4xMhqHW4Z1PcX88ZkhUzLUGLSZJ0+tL/A7OEwMPgt9glqviYi
	g9do3+eFqQ0y8xaIWI2Ml1t0lWW3DDyuNYgsjbtpMgY6LiDw+KOagIMt2w6l9RHBAdbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEIfP-00CIBk-Ta; Mon, 12 May 2025 04:13:19 +0200
Date: Mon, 12 May 2025 04:13:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 01/15] net: cpc: add base skeleton driver
Message-ID: <17a103da-b01a-44cc-b1e4-5a4f606ed4a8@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <20250512012748.79749-2-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512012748.79749-2-damien.riegel@silabs.com>

> +/**
> + * cpc_interface_register() - Register CPC interface.
> + * @intf: CPC device to register.
> + *
> + * Context: Process context.
> + *
> + * Return: 0 if successful, otherwise a negative error code.
> + */
> +int cpc_interface_register(struct cpc_interface *intf)
> +{
> +	int err;
> +
> +	err = device_add(&intf->dev);
> +	if (err)
> +		return err;
> +
> +	return 0;

I guess this will change in a later patch, but maybe not. This should
just be

	return device_add(&intf->dev);

> +}
> +
> +/**
> + * cpc_interface_unregister() - Unregister a CPC interface.
> + * @intf: CPC device to unregister.
> + *
> + * Context: Process context.
> + */
> +void cpc_interface_unregister(struct cpc_interface *intf)
> +{
> +	device_del(&intf->dev);
> +	cpc_interface_put(intf);
> +}

It seems odd that unregister is not a mirror of register?

> +/**
> + * cpc_interface_get() - Get a reference to interface and return its pointer.
> + * @intf: Interface to get.
> + *
> + * Return: Interface pointer with its reference counter incremented, or %NULL.
> + */
> +static inline struct cpc_interface *cpc_interface_get(struct cpc_interface *intf)
> +{
> +	if (!intf || !get_device(&intf->dev))
> +		return NULL;
> +	return intf;
> +}

What is the use case for passing in NULL?

> +
> +/**
> + * cpc_interface_put() - Release reference to an interface.
> + * @intf: CPC interface
> + *
> + * Context: Process context.
> + */
> +static inline void cpc_interface_put(struct cpc_interface *intf)
> +{
> +	if (intf)
> +		put_device(&intf->dev);
> +}
> +
> +/**
> + * cpc_interface_get_priv() - Get driver data associated with this interface.
> + * @intf: Interface pointer.
> + *
> + * Return: Driver data, set at allocation via cpc_interface_alloc().
> + */
> +static inline void *cpc_interface_get_priv(struct cpc_interface *intf)
> +{
> +	if (!intf)
> +		return NULL;
> +	return dev_get_drvdata(&intf->dev);
> +}

What is the use case for passing in NULL?

To me, this is hiding bugs. It seems better to let the kernel opp so
you find out where you lost your intf.

	Andrew

