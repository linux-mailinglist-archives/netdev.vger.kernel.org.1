Return-Path: <netdev+bounces-245215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC287CC901F
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31B3304E569
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFB348445;
	Wed, 17 Dec 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KEMDSHKt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5933EB01;
	Wed, 17 Dec 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991112; cv=none; b=T/uCbCCWVD66SB7z5jXaUubV+ZYzz/K8xUNcG7oxonSG117KTsv3p+q5pnPeU/OqF+D13G/ebIR6vdZyTPI6qSuwx82h5p6yfTsmRXTWnd0HeKuJLddrlYxXREpFiYKcTr2wE5itSsrtQKxYd+6InuuolOm3LXvbJMMbm8+i8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991112; c=relaxed/simple;
	bh=hQUiowIqnPYoumnsju6v2Rby74tKXjQbS/1VFaVx75A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKE9ynqDxlM6c92yGObXx7n3jOvh1gMdT+X50QiWy12/smFR+ktC/Cwysw6Rmmi8DvVez2619xGHqRlD5VUoDM2wfRGLfC9CuY4Xm1k4VHeTYoxzh8F8Hs9XaP6MJQHkWyAvYfUQaPXwUKv9gCUmMVd2LrzOBSCxltbQRhNiAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KEMDSHKt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JC/OAnrwflrdD+697YshlNQb8A1fVQJOhNEeBZnuY4o=; b=KEMDSHKtY0k0H+lZ6204QXDLnP
	IYEaaMGQRmp17Vfxs3oERU9L65fhet7KbBQv7w/QQr2RfEnW6xjnQD7HJmAkkiUx4ffBxrV0xZ31X
	gklJ2KmN8k/og0ipZ0Qbj3IuJ6MPuQEM6PrmEsODbiTRODjllsiDmLhsLxlyQq8Uu0k4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVuxM-00HEmV-Az; Wed, 17 Dec 2025 18:04:56 +0100
Date: Wed, 17 Dec 2025 18:04:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Rob Herring <robh@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <49385cb4-6ce9-4120-9dd6-c08d763f0564@lunn.ch>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
 <aUJ-3v-OO0YYbEtu@eichest-laptop>
 <aUKgP4Hi-8tP9eaK@eichest-laptop>
 <20251217135519.GA767145-robh@kernel.org>
 <aUK-h6jDsng0Awjm@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUK-h6jDsng0Awjm@eichest-laptop>

> > I think the ideal implementation would be the MAC driver calling some 
> > phy API to apply the quirk, and then that gets passed on to the phy 
> > driver. Surely this isn't the first case of a MAC-PHY combination 
> > needing to go fiddle with some special setting.
> 
> I was also hoping to find something like that, but I couldn't really
> find it. However, I will try looking in that direction. At least we can
> identify the broken MAC via the compatible string of the MAC driver, as
> they use two different compatibles: 'fsl,imx8mp-fec' (fine) and
> 'nxp,imx8mp-dwmac-eqos' (affected by the errata).

Maybe see if you can use phy_register_fixup_for_id().

	Andrew

