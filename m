Return-Path: <netdev+bounces-105956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F5F913DD7
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250051C212A4
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095918412E;
	Sun, 23 Jun 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V/CfHjz/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14314144D27;
	Sun, 23 Jun 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172831; cv=none; b=ci8KDFxvJx1Ea5glsy4p5k9yFXLSPrvNiW3Ikda8lOdgouvl/UvkgahUyxYgYjRLBdOYVPuL6GbYQ2KjuCIbfMBT0Wx3vMvEaVnMesGUyMqMtR/Ge/1nolCfpmokmmibwYBka0cfGLdzhCXPKy9RqViu8m3vh3mtwQfQrVtl6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172831; c=relaxed/simple;
	bh=tdEngc11sD2vPlLzre5yWLpZAhAAfCXQ59fzkTEFaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaAcGVkmRMG4XHdoQ+E13Qf216Llsu36K55XhtoHh2Ezced+FtfwjWX5dDyV4MZTEqABX+8VlByFtiztcFaHx8Vo3g1Ys5n4K3VCB4XocntVGutO1wHlEQpEmmQKP15kW5KRM5xmtqsjTCYSJsUR2z1HtAMhbS2N8PAvXeRKKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V/CfHjz/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DJ2B6QWuaoTdFrjJuq0ql4wztJP+AWuUKJujEGMnyPM=; b=V/CfHjz/D3X8W+dd377+H49JBo
	nlub23k5sgAUZyRyq8jDXjzfhYfLwtqgpLOUM/+ZJISczwc9lczG/6qpi9ebD27JvwaTUcwtIRIpR
	Tfxv3f4JOq3Q/5BF/ZWTPAfiH6uICO/3LMoDcQowr8YiCmg/z0dn2RVLhARQNn/r6+5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLTNp-000nbM-TE; Sun, 23 Jun 2024 22:00:17 +0200
Date: Sun, 23 Jun 2024 22:00:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
Message-ID: <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
References: <20240623194225.76667-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623194225.76667-1-marex@denx.de>

>    - $ref: ethernet-phy.yaml#
>  
>  properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id0000.8201

I'm not sure that one should be listed. It is not an official ID,
since it does not have an OUI. In fact, this is one of the rare cases
where actually listing a compatible in DT makes sense, because you can
override the broken hardware and give a correct ID in realtek address
space.

	Andrew

