Return-Path: <netdev+bounces-237406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A165C4ACF7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07E11887953
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7C2F5A10;
	Tue, 11 Nov 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YL1i4kv5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851926E706;
	Tue, 11 Nov 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824774; cv=none; b=G+5Pl7Zzo+i7gp/nmRMUKjGI0CdVCRQi5fZpaqyMj4vZAhlEGIrpnpOK8suVeHa5Wr3DfmM3At/CRar1gfs445MG01E0XN/3NdacJfZaiZvap1qE7+Mlj29cwCtlp7r33bZhPasUzHAj0QnzRCfkjDeWF7WT57+4zs9O0ALhUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824774; c=relaxed/simple;
	bh=lnl+d1Dqtavd1L9x3dXhCGUyr61mK2oo+pYCb6l+Vu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqeWspXRsF5N1XakU6kpkrLaQgfIbPSaojlC2waG5e0MMW8e+T/PMGAvPEX19qukKhrD+eRTryNMoR9fAwnJL1zuQ3mT2JXZG8w2kXCYEfV+fokZgXn3XgRRM23Wmo4d7syejtGvQGnz+Reb0zFMjKNt+ohttyBmFe+Wj/Syt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YL1i4kv5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fLBGhKqvRZ3T84/49heIB53vWanJflY7cu0EZCUAZCI=; b=YL1i4kv5mZe5yULLj3jU/Tbz2J
	onBNt4O8Sfw7HY34vE+XtmGLoVJ/r//fV/TiFUZPruAj6AHf4F+71fo9lcQ5SK2rYJDZo6YIbW3Lh
	qtmuhMIG4/WElboOjdhDIXYasYDOdjUSrFd12wzGGsiO2/IKj9AlabQFDagKu+P8mZ7g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIdFO-00DZme-Pf; Tue, 11 Nov 2025 02:32:38 +0100
Date: Tue, 11 Nov 2025 02:32:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-gpy: add MxL862xx support
Message-ID: <e064f831-1fe9-42d2-96fc-d901c5be66a4@lunn.ch>
References: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
 <5e61cac4897c8deec35a4032b5be8f85a5e45650.1762813829.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e61cac4897c8deec35a4032b5be8f85a5e45650.1762813829.git.daniel@makrotopia.org>

On Mon, Nov 10, 2025 at 10:35:00PM +0000, Daniel Golle wrote:
> Add PHY driver support for Maxlinear 86252 and 86282 switches.
> The PHYs built-into those switches are just like any other GPY 2.5G PHYs
> with the exception of the temperature sensor data being encoded in a
> different way.

Is there a temperature sensor per PHY, or just one for the whole
package?

Marvell did something similar for there SoHo switches. The temperature
sensor is mapped to each of internal PHYs register space, but in fact
there is a single sensor, not one per PHY.

> @@ -541,7 +581,7 @@ static int gpy_update_interface(struct phy_device *phydev)
>  	/* Interface mode is fixed for USXGMII and integrated PHY */
>  	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII ||
>  	    phydev->interface == PHY_INTERFACE_MODE_INTERNAL)
> -		return -EINVAL;
> +		return 0;

This change is not obvious. There is no mention of it in the commit
message. Why has something which was an error become not an error?

    Andrew

---
pw-bot: cr

