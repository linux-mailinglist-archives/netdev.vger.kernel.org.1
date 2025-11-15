Return-Path: <netdev+bounces-238876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA6C60AF6
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7557E351B99
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8A20C023;
	Sat, 15 Nov 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IZ0Hl6JD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F571DB54C;
	Sat, 15 Nov 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240014; cv=none; b=gTQfm4IIxL/lxeyI0PMc8EssSQZuHeXN1DqijhqFjbfbck6i/cjOE//j+6z4d+/MB+kV8rGAJVSPVgV1m3jaIaSxrEKWjaC0diUfm3UmEZjr2ge5Wysd2+sk0nTg3SgyQy8sDm262OLwiqMha0h/wnTZ6+tP360oLdi0k/EIku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240014; c=relaxed/simple;
	bh=8qg9vRX23GKfaBl+pqJuXJZtVzvZZZB+Foh7CA9ChWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmAXm6HNbDNUDp5oKnfR/nYu/FWtW2V66Ak0BwelefZjGcN8EdHlNMmJA6xdpugL/D9jpz+0roTT0ni8aozzvbjjaFPnIewGwCh+4Gi3N0icSbV+cSq4iJolFMiTfjaBEhjgzjHnpXrLDpjKCEHMQE2tU3It+lFsYxX58X7FFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IZ0Hl6JD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=If5xnTv8Dob243+I+tQxsKHMpUgcW+22OdMYXZGVLc8=; b=IZ0Hl6JD8px6djAK4EJY2/dnlD
	ZRjhX+qSWnZRItww5RN22cUkLIZiEWTnFAszdyTfellEmLJ2NngIqKYJ+wDg3umBzQCnrCsBIzyQs
	ua9FxvJ6Cg7roTZuN8ZaOz1DJsgmOmiCalhHXK8pJUz5wVAfI5s/FcUt8Ba/fn43F02Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKNGi-00E6wY-65; Sat, 15 Nov 2025 21:53:12 +0100
Date: Sat, 15 Nov 2025 21:53:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: xilinx: ll_temac: handle
 of_address_to_resource() failure in MDIO setup
Message-ID: <de7369f7-0526-46f5-b6c3-a98c683c7aa8@lunn.ch>
References: <20251114155519.3524628-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114155519.3524628-1-Pavel.Zhigulin@kaspersky.com>

On Fri, Nov 14, 2025 at 06:55:18PM +0300, Pavel Zhigulin wrote:
> temac_mdio_setup() ignores potential errors from
> of_address_to_resource() call and continues with
> an uninitialized resource.
> 
> Add return value check for of_address_to_resource()
> call in temac_mdio_setup().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/net/ethernet/xilinx/ll_temac_mdio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_mdio.c b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
> index 07a9fb49eda1..ab23dc233768 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_mdio.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
> @@ -98,7 +98,9 @@ int temac_mdio_setup(struct temac_local *lp, struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	if (np) {
> -		of_address_to_resource(np, 0, &res);
> +		rc = of_address_to_resource(np, 0, &res);
> +		if (rc)
> +			return rc;
>  		snprintf(bus->id, MII_BUS_ID_SIZE, "%.8llx",
>  			 (unsigned long long)res.start);

I'm not sure this is correct. But it is an odd case. Apart from
setting the name here, res is not used. Imaging a DT blob which does
not have the resource. You get a random name, but the MDIO bus works.
With your change, the probe fails. That is probably a regression.

Are there any .dts files in mainline which do not have the resource?
Then we have a clear regression, and this is then wrong.

	Andrew

