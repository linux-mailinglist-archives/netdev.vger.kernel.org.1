Return-Path: <netdev+bounces-102318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477149025C6
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7094289F43
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86913D8A7;
	Mon, 10 Jun 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vUVsEEgA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9E13D8BF
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033884; cv=none; b=DjpQDAmEJG0beQSCk5ySNX9aO3ONQZvqRhNxZ7XB/ZIURERgLzd8L4MGC5veVOeWUMzK2Al9dX/g6lqPcHmyYilPwQwjp0Ml8dseBSl1nb4ZcgPzenhAVC8lnAdUsLKuS698daWa2qTZnM9PIldbt4AHGCU5mO+d32GT8cyGJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033884; c=relaxed/simple;
	bh=EVm7cwejf2DiVgiLBm20+0xPcdBYd1Sy4AFlRazG0D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7lVtMwm9LCinI+LpiK0MmzLLiLz8mwkYzePw7S0KgvGFKF2znVSa1RtPRpZuMYRkWkfPhPxqj31OuRl11wzoqYS57vAalYOgY5adOOj+A3bWkBUcl0UbxIJ67ZMIU78plVpzqi0PilwpJr20umPXBp9ezwwHNxdbodugNI+Yy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vUVsEEgA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=paGZ+mtcCSNo19XHaCCq2HUfc8ZotHNYtNCNtFKkJNo=; b=vU
	VsEEgAQTfqXMs/AclHQ85aHqkAmLoTwyIKTPe6RzPDhfWbMfXfGCbHQwMXQ9g+MPatlKweYZmYjQa
	+ACQKOLTn1Jikaphjsd8WJ1kRVV0rVNnTLlmJZQI85YQ2VR2xrTgp8aoh2G2VbxAl8JunsOF9PbxK
	0qgm0BtLamDjOSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGh5o-00HJTT-Go; Mon, 10 Jun 2024 17:37:56 +0200
Date: Mon, 10 Jun 2024 17:37:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <7a6d0a1f-8134-409f-a449-c68b305623d9@lunn.ch>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
 <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
 <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>

> then the AQR105 seems to need the MDIO bus set at 1MHz to allow for
> detection:
> 
> @@ -1681,6 +1681,8 @@ static int tn40_probe(struct pci_dev *pd
>          goto err_unset_drvdata;
>      }
> 
> +    tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
> +
>      ret = tn40_mdiobus_init(priv);
>      if (ret) {
>          dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
> 
> This is not needed for the x3310 and may be related to, that the AQR105
> is connected to phy address 1 on my card.

802.3 says the PHY should operate with a clock up to 2.5Mhz, and many
PHYs operate at faster speeds than 2.5Mhz. So this is likely a
symptom, not a cause. Is the PHY getting reset? Is it being given
enough time to get itself together after the reset? Maybe a delay
needs to be added.

	Andrew

