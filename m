Return-Path: <netdev+bounces-189627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEEAB2D80
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC663AFCEE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629F253351;
	Mon, 12 May 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXnI3bv7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE945195;
	Mon, 12 May 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016939; cv=none; b=Yq75X22dk0a69YJT9ywAh3mvuaMUJ06aMJqrciS/vtuMLZH+pNsbL+G6zGkuRQLVnlzelgN9E9jHunPHGseMFlWPppbsuYBoHHzEwymynQ+duDI3ilRsdT/Snnd7SJdPX23tFOlTkiJAjlyvTyPZg48a5RCV24dqPOr001MAbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016939; c=relaxed/simple;
	bh=d+LeGSOURHxaZ+9jdSebxv4Bdxq4KInyp2lUp/6P4X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkclnjQy9i39eFyY4aXmXD3p1uVp3emnkHi6d5150YvNdJWrp99AimYHcmpW7IrERUWhm4dbwYdbj61MdhfZZyYR22Mgx7ISz+bBQp8FOtaQW+bxBYdpoxShgfLET4/EkbwDsjKJtO7kgCt6Eqgv/c8rXr8OiyFeDElsYS1ABdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eXnI3bv7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QrztMGFBQB8/q3cnhtp1cbW+ELoTxxoxt6567ZIMK0A=; b=eXnI3bv7yrjSk65tlVvDazkvsm
	I/q4WiT4NRZfRIcPQf3MmEuXoidy+p6ZgI+LFMx4lZhVqMZU2/y94l/fqmnB6d5N1KNJro/3JSAMW
	JEULZ/1MV+rspq5aTNB6710zjXgFJwng/GW6SwRW+alzeqzLaNdxNcK91X/m5hBL1wTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEIuO-00CIG5-15; Mon, 12 May 2025 04:28:48 +0200
Date: Mon, 12 May 2025 04:28:48 +0200
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
Subject: Re: [RFC net-next 02/15] net: cpc: add endpoint infrastructure
Message-ID: <e038e209-dc4a-4dc4-9356-cd3a54535856@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <20250512012748.79749-3-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512012748.79749-3-damien.riegel@silabs.com>

> +/**
> + * cpc_endpoint_register() - Register an endpoint.
> + * @ep: Endpoint to register.
> + *
> + * Companion function of cpc_endpoint_alloc(). This function adds the endpoint, making it usable by
> + * CPC drivers. As this ensures that endpoint ID is unique within a CPC interface and then adds the
> + * endpoint, the lock interface is held to prevent concurrent additions.
> + *
> + * Context: Lock "add_lock" of endpoint's interface.
> + *
> + * Return: 0 on success, negative errno otherwise.
> + */
> +int cpc_endpoint_register(struct cpc_endpoint *ep)
> +{
> +	int err;
> +
> +	if (!ep || !ep->intf)
> +		return -EINVAL;
> +
> +	mutex_lock(&ep->intf->add_lock);
> +	err = __cpc_endpoint_register(ep);
> +	mutex_unlock(&ep->intf->add_lock);

What exactly is add_lock protecting?

> +void cpc_endpoint_unregister(struct cpc_endpoint *ep)
> +{
> +	device_del(&ep->dev);
> +	put_device(&ep->dev);
> +}

Register needs a lock, but unregister does not?

> +/**
> + * cpc_interface_get_endpoint() - get endpoint registered in CPC device with this id
> + * @intf: CPC device to probe
> + * @ep_id: endpoint ID that's being looked for
> + *
> + * Context: This function locks device's endpoint list.
> + *
> + * Return: a struct cpc_endpoint pointer or NULL if not found.
> + */
> +struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id)
> +{
> +	struct cpc_endpoint *ep;
> +
> +	mutex_lock(&intf->lock);
> +	ep = __cpc_interface_get_endpoint(intf, ep_id);
> +	mutex_unlock(&intf->lock);
> +
> +	return ep;
> +}

cpc_interface_get_endpoint() but no cpc_interface_put_endpoint() ? Is
this not taking a reference on the end point? Maybe this should not be
called _get_.

	Andrew

