Return-Path: <netdev+bounces-105881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C19135A4
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81136283622
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF04376E4;
	Sat, 22 Jun 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zPnQPM9m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575019470;
	Sat, 22 Jun 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081467; cv=none; b=cO4sNuFVvBzAwZuiqTyOjmRwBvonQZV6zpLhZtt2Rwxf/pX7D00qT1V4ZBDjpizRSw7EuxWbScZDWpl3fqENRO0UB1jouyupxaIVA4D7z9BSfxBn2xufswLUWjWnQ0DcNgK5pw1Zx1MX3y/iBc1xgUzHCQsSu9rRbsuhKM0Xb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081467; c=relaxed/simple;
	bh=DSpro2WAU+N2QuvZEKVtGV7pPqRIhvL7TWkdGSBbE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2oeeuYAUHFB2AxjJ7wzrbNVAsLWgReu4eMYSM3eQDAypi5BjzW5tQpYeFtu7Sfmp4vTUHeBJ/comOO6oDOmELoWw2cPN2mEKbDhDInWuTUxB8c7hZx30dws4gwYfzPxstjVWG51jLeaPq3rIkocjYhEv6c1qV7qwVZM64VTJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zPnQPM9m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=OG0d15cSbY7QTT3DIOE0qGKIHXBPgmGWjTLaWpcBSpo=; b=zP
	nQPM9mZ5JF3TMpxfVz7pb0wWmTpNxJaQtXb/9Bjmm9xQXaxdw8EapOvARQUqrV4oypl5ZZURS3kLm
	ccd1e3VheAo+gMCxhlSgIxnmyZ3dhdIxyr7NA5egPZJe7kTDJDANyQqlnEpijphg5hK8WV/R02ep8
	DuOh0khdDtfc+KU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5cH-000kI3-Vx; Sat, 22 Jun 2024 20:37:37 +0200
Date: Sat, 22 Jun 2024 20:37:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] net: phy: bcm54811: Add LRE registers definitions
Message-ID: <f07cb96e-9a0a-4a29-91e8-6975e1a2df00@lunn.ch>
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-3-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621112633.2802655-3-kamilh@axis.com>

On Fri, Jun 21, 2024 at 01:26:31PM +0200, Kamil Horák (2N) wrote:
> Add the definitions of LRE registers for Broadcom BCM5481x PHY
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  include/linux/brcmphy.h | 89 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 1394ba302367..ae39c33e4086 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -270,6 +270,86 @@
>  #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
>  #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
>  #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> +#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */

That looks odd. Is there something subtle i'm not seeing here?

	Andrew

