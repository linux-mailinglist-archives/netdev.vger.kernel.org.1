Return-Path: <netdev+bounces-118861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04195350D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8F287717
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83F1A00CE;
	Thu, 15 Aug 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nz0XuEsX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01D14AD0A;
	Thu, 15 Aug 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732399; cv=none; b=IwnYq/L9G0MJOJGTzSCQIIxHgDaV/NCNrz7wjXF8LF7AXsq4J0SHHwfZrvjpVdH32bdtBXvxi5V8tzyXs5/uMwdVRATiX05jNbY/+rvEvb2qPIANv5hwV+K6xOILnyehn82eevl9bQB7Q1C6hZE275ENOvqm0xfG3c7551gDydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732399; c=relaxed/simple;
	bh=5zLlgiauFmtzDe0WGZrVO5jLD2j3yrPLGKIoogSK2Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogQn/fn2vJB6roo13u00wVIZvkm8fu+/qZ48eqzln0uljvWZcbdZvatfpSSVeY8ynQ8zbj4lI1DBMoUpT0m44cEw9YG3RTXuwh8OK6N1JHcjC28ztO4cgkLOwgRirqVYSTY8KREZEghkDP1YHp41HFy+D/oxNPYPpQdswaj6CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nz0XuEsX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M8aNZa8nyfe/bSa1TM/F99VXtKGXCBMqn9UQAaHvcN0=; b=nz0XuEsX1PBBgoXUQqeR2HGbFm
	OLQdQ4hC8kvHZ0tIad/Flwa+wLzOXEW4+8EFJSXOPpMstRwI8KuSt0U0TYktNgyeFAni0V4VvH8kK
	mFyFDiVHGNnbeNl/iNGftrtCGYfti4WDi+uEzZHab/VUC2V25GNiJ+GwmaWPx8n8N94Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sebXA-004qjE-V3; Thu, 15 Aug 2024 16:33:00 +0200
Date: Thu, 15 Aug 2024 16:33:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, andrei.botila@oss.nxp.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Message-ID: <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815055126.137437-2-wei.fang@nxp.com>

On Thu, Aug 15, 2024 at 01:51:24PM +0800, Wei Fang wrote:
> Per the MII and RMII specifications, for the standard RMII mode,
> the REF_CLK is sourced from MAC to PHY or from an external source.
> For the standard MII mode, the RX_CLK and TX_CLK are both sourced
> by the PHY. But for TJA11xx PHYs, they support reverse mode, that
> is, for revRMII mode, the REF_CLK is output, and for revMII mode,
> the TX_CLK and RX_CLK are inputs to the PHY.
> Previously the "nxp,rmii-refclk-in" was added to indicate that in
> RMII mode, if this property present, REF_CLK is input to the PHY,
> otherwise it is output. This seems inappropriate now. Firstly, for
> the standard RMII mode, REF_CLK is originally input, and there is
> no need to add the "nxp,rmii-refclk-in" property to indicate that
> REF_CLK is input. Secondly, this property is not generic for TJA
> PHYs, because it cannot cover the settings of TX_CLK and RX_CLK in
> MII mode. Therefore, add new property "nxp,reverse-mode" to instead
> of the "nxp,rmii-refclk-in" property.

Please could you add some justification why using
PHY_INTERFACE_MODE_REVRMII is not possible.

	Andrew

