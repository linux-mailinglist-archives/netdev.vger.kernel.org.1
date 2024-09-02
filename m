Return-Path: <netdev+bounces-124264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED69968BF5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96768B20F37
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DEB14BF86;
	Mon,  2 Sep 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pdkTPLTG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C313AA3E;
	Mon,  2 Sep 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294035; cv=none; b=p7G+10qlhya4CUIulnfjWX8U1XMO+iUD7bDYFz/0NjPSAgrbKwAQBODlCkSS4yisEUygY5HhkraOneOF8OegSgf1poGpBdIFaIefbQjX+dQ9kojGUghN0gaAEHNvQe+CPWiyvXrFUELmHyn0bx1k/OrO3nyqxcOkNrua1TQv08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294035; c=relaxed/simple;
	bh=CkJkF/373yx2wrwwgj2iFiYDhvrw4DB8j1vqmdmXuEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftGsjJ7rwr3tw887nYIjRZD3MOHrF9IOin+5IYCjYSJu9kIHzZgtvJRNoqtNOwhp7116PYcpLvaKwaX0oCPRosSoeuWbOE5nT4QlbGz0iCLSmDElX01Wawi2UiOnE/KvABg03HtZGNFAPTBaOkC2VMl9D/rCpIMspllzwt8Plo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pdkTPLTG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uomZ8Qg+6Fky99H3+8KCFFJi9wmMw34y2Q0dhOmFcJU=; b=pdkTPLTGBh9DAQnu6QZg8QARE0
	0IDtGF9wu7yvBQcvFsXrMowZYfKi4bWoOO4uVaMxKsBc2aavX+ImROTLq4AHSzvfvxbiP7a7tLYp8
	zb8F7umZRSvUK3630eoB4FMTefP5WkEMWjIL68dzbKlk/hqTomN/0cAhWHBGIDrNl13s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl9n1-006K7c-2d; Mon, 02 Sep 2024 18:20:27 +0200
Date: Mon, 2 Sep 2024 18:20:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Message-ID: <8bd356c9-1cf4-4e79-81ba-582c270982e8@lunn.ch>
References: <20240902063352.400251-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902063352.400251-1-wei.fang@nxp.com>

> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id0180.dc40
> +      - ethernet-phy-id0180.dd00
> +      - ethernet-phy-id0180.dc80
> +      - ethernet-phy-id001b.b010
> +      - ethernet-phy-id001b.b031

This shows the issues with using a compatible. The driver has:

#define PHY_ID_TJA_1120                 0x001BB031

                PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),

which means the lowest nibble is ignored. The driver will quite happy
also probe for hardware using 001b.b030, 001b.b032, 001b.b033,
... 001b.b03f

Given you are inside NXP, do any of these exist? Was 001b.b030 too
broken it never left the QA lab? Are there any hardware issues which
might result in a new silicon stepping?

Does ethernet-phy-id0180.dc41 exist? etc.

	Andrew

