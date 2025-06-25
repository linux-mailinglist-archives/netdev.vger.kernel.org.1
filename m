Return-Path: <netdev+bounces-201263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A9AE8B06
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F631891755
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13D2DAFD7;
	Wed, 25 Jun 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="peh9g5ZG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25F2DAFC1;
	Wed, 25 Jun 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870113; cv=none; b=SnmY/fWnjLLo+wQCmj/kwC0W7QXTKqdKhAtKCvBbl2HOUdsQWCkXj/ByFIEJM9O+nmiSVNHiTBreR2E5pJclAGt0Uy6N30Uf4DikHdASsna+Xx5Q6J30UH54tE8Bi2WIsaZQ72GOIm1SlxjtHov3ni5yD1Luj1aBDeEqSVEx7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870113; c=relaxed/simple;
	bh=FMeTeIxkoCIe0b/zGg4ZKHQQsAok+GnOlbj4bqiJvJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfzAM/wJesfe4il2oSIctqQtZxRHy1E7eWSuGufFzGQLJsi5XKTOhTkdJ8t2+yYAjFdbIDZZ9grhhmkN2fJNnWQiVLqAUvMk2nnXefcn9+JCiQr7imUwKbNC0N1P+4pY/uHQ/gC/ZNvkO2MjwRll8wFAY+phwgAQnaQsicNJLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=peh9g5ZG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LeuVjAxzuvL1vAawfkyXmNc9BV3RB1RRKJR7uKR6uvg=; b=pe
	h9g5ZGIAHz4Z3/8hGJCjCcGSzryCoUVJsYfa4pB920xYr5WualwA8QhQdHFdIBXBxuv5OqhHlwgtC
	VHdGWENaFDTOC7h6PKccCZWfq4gLEWoGu8RiSv8c682Fli94OpQrwQQccJRs+zOXDTsj7Ep9jQT1X
	bHucMQ5frd278gY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUTIO-00GxBa-48; Wed, 25 Jun 2025 18:48:24 +0200
Date: Wed, 25 Jun 2025 18:48:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, robh@kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: MII-Lite PHY interface mode
Message-ID: <fab0b3e5-9860-43c2-8c02-70d855b598a1@lunn.ch>
References: <20250625163453.2567869-1-kamilh@axis.com>
 <20250625163453.2567869-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625163453.2567869-2-kamilh@axis.com>

On Wed, Jun 25, 2025 at 06:34:51PM +0200, Kamil Horák - 2N wrote:
> From: Kamil Horák (2N) <kamilh@axis.com>
> 
> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
> 
> Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
> Add MII-Lite activation for bcm5481x PHYs.

Please split this patch into two. Add PHY_INTERFACE_MODE_MIILITE to
the core first. Then add support for it to the broadcom PHY.

Splitting it allows you to make the commit message more detailed.

>  
> +	case PHY_INTERFACE_MODE_MIILITE:
> +		link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
> +		break;
> +

You could call this out in the commit message.

>   * Describes the interface between the MAC and PHY.
> @@ -150,6 +151,7 @@ typedef enum {
>  	PHY_INTERFACE_MODE_50GBASER,
>  	PHY_INTERFACE_MODE_LAUI,
>  	PHY_INTERFACE_MODE_100GBASEP,
> +	PHY_INTERFACE_MODE_MIILITE,
>  	PHY_INTERFACE_MODE_MAX,
>  } phy_interface_t;

This enum is not part of the ABI. So you can insert MIILITE directly
after MII.

	Andrew

