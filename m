Return-Path: <netdev+bounces-111256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F694930700
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DFE28256B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137A13DBB1;
	Sat, 13 Jul 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kjHDSx8D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408C38DD9;
	Sat, 13 Jul 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720895412; cv=none; b=sAzJNxrkHvRbQk7OghsI6n3KR8nU6Muh+r7kmfl6Ble5ykjP+LUuLYJ0F3aAwdvHxU5o6rf0dbRezPRvxDHUfT5u/kmKlu2kyNWxLS0QstKQvxnxDHfh8VRmKPgCxPsESbVZA9t4LZ2FesKQQgb56yXYhmZNmArxz9l5AgPEYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720895412; c=relaxed/simple;
	bh=WnXvrqoAwgMIgbvzVtu6MOVaCO13ZZpQdLRKOpclQhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4C72+vb/cWytz/9FYEFi8F3msdPoTdCcCwWDNJLXGKQrNsoZqLr692ZrAnMYScWqr6wdaENhi25Azy75Hqzj2atMzJJotjof07jSO219D7Es/m3HuDyt9092wJusUIxSDZWwPjHU/4JfYeokym78z83h/z/o70wcpFujGSai98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kjHDSx8D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1D7MnIKiFIEdTxNS652oY3qJc5VfEfaHPgzIXOoGoXE=; b=kj
	HDSx8DtvyGHgRTFNbxuHUm8BcGcfDecFXMGe6d0K1XFFNvI1iQBdTYhxxQzPMmpHXdAM0GGb67KFa
	wHhDO0fEJHEBqdTNBR8HAJpbdyog9gQ/OyRX+eG1SSdVZRxE2Sjog1MaGyVKX1YDLa0OcJsp8bgWv
	PSZU6TVWWR1qDFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sShVR-002TDG-6O; Sat, 13 Jul 2024 20:30:01 +0200
Date: Sat, 13 Jul 2024 20:30:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	f.fainelli@gmail.com, kory.maincent@bootlin.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <40ffc36c-0fc7-4195-ae3d-52750aa54eac@lunn.ch>
References: <20240712150709.3134474-1-kamilh@axis.com>
 <20240712150709.3134474-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712150709.3134474-5-kamilh@axis.com>

On Fri, Jul 12, 2024 at 05:07:09PM +0200, Kamil Horák (2N) wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle
> configuration of these modes on compatible Broadcom PHYs.
> There is only subset of capabilities supported because of limited
> collection of hardware available for the development.
> For BroadR-Reach capable PHYs, the LRE (Long Reach Ethernet)
> alternative register set is handled. Only bcm54811 PHY is verified,
> for bcm54810, there is some support possible but untested. There
> is no auto-negotiation of the link parameters (called LDS in the
> Broadcom terminology, Long-Distance Signaling) for bcm54811.
> It should be possible to enable LDS for bcm54810.
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

