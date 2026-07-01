Return-Path: <netdev+bounces-303715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VZxcL9YsRWrq8AoAu9opvQ
	(envelope-from <netdev+bounces-303715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:05:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8D6EF19E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Bi4gjjXI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303715-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303715-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 860F2303E624
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79E3E0C53;
	Wed,  1 Jul 2026 15:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565D3FFAC1;
	Wed,  1 Jul 2026 15:05:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918350; cv=none; b=rlCu8ocf5cAXPpKx52hKtW6iPHui9uJZ773i2HAjRyVBhpV0I/3Hjs4DoVRgR+QRUdODkWmj4iyDiUwbTUgfA53jjmdjfjmUkZfIXdTgS91fWxEDpvpUzxSYuzVGcaebeaKYxKKDcJfnIQN5V9pTiT1UHv2jhSN8r7vrdHUWwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918350; c=relaxed/simple;
	bh=FtCtVsw7nkaJc4HIrFzeljJynV55gfdCbLtt2QOqaYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muSpvJXcXZ9N+7hEUrRlTkwY/AXpKG8drntekWtRIgKRKc0DcIS3vA/TwdsUlARV40FMr/nku6+2huVM2kC+Np+bScfcKsfzI+CbXMfhPuEWPQbRZgK3D3FEI6EknnG6O2qNj3eCCK00DgIw2grUDP8F7zWidAfQXC169mmwpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bi4gjjXI; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8JN5tErO00Oe7Z8q/eXWcaaoxIJRYRjAeSNF6rVFU6Y=; b=Bi4gjjXI0ATPgReq8DAd5dgJuU
	Zm4tcQ9FGK5eh44ASIkkHh4i8elrq9SYloiAHMJXIX+afiiGlW6jXFVj08zHIhmwP5ytmbAAzYfAM
	FnIgFKd2Xul6kekdncFEw+fopGzHqjfbYkRrmoUgW1gA2mK8Lq7rJZ71B6W5Qv/Gq7x4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewVP-00ABcG-Bp; Wed, 01 Jul 2026 17:05:39 +0200
Date: Wed, 1 Jul 2026 17:05:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
Message-ID: <6b368510-05d4-4d73-b588-8002d0d59915@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303715-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DA8D6EF19E

>  #include <linux/usb/usbnet.h>
>  #include <uapi/linux/mdio.h>
>  #include <linux/mdio.h>
> +#include <linux/if_vlan.h>

Does this patch require this header?

> @@ -414,7 +570,6 @@ static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
>  
>  	usbnet_suspend(intf, message);
>  
> -	/* Enable WoL */
>  	if (priv->wolopts) {

Please try to avoid changes like this.

>  	/* Force bulk-in zero length */
>  	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
> -			 2, 2, &tmp16);
> +			2, 2, &tmp16);
>  
>  	tmp16 |= AX_PHYPWR_RSTCTL_BZ | AX_PHYPWR_RSTCTL_IPRL;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
> -			  2, 2, &tmp16);
> +			2, 2, &tmp16);

Please put white space changes in another patch.

> +	/* Initialize MII structure */
> +	dev->mii.dev = dev->net;
> +	dev->mii.mdio_read = ax88179_mdio_read;
> +	dev->mii.mdio_write = ax88179_mdio_write;
> +	dev->mii.phy_id_mask = 0xff;
> +	dev->mii.reg_num_mask = 0xff;
> +	dev->mii.phy_id = 0x03;

If this device is going to have a long term future, it really should
move to phylink.

	Andrew

