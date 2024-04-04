Return-Path: <netdev+bounces-84873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99089881F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CB31F21347
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FA1EB56;
	Thu,  4 Apr 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fBJ+3ljK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180E374C2
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234572; cv=none; b=l/B9dNA02WfZ3fr2X+cAf0RpFR/TtN60a02u4r+kV3dNCB2a1zrAas8XRj0yVC3HXTRx8HkAitt05uJl7Y9gF3jh8dpQP9rEJ2gtxeGERqO3sYOomK537xuaNsYj2arrLIfcaSgnO5H+FyCWCbRcwN2PhcW8rv0b2zbMKpidIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234572; c=relaxed/simple;
	bh=VZECsXrmGrw2UjThvxaWvwLj0UWSSyCPr6glQNxfZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEY2rFyufWFMKjTe+928TGFuVR0OXUk6EPseY7MYB8A5Rt0/SWlxytSqcVDVTApHOu8qXCogZuC6bxri7NILBV0BaMAeq2oIvz05PcFMQgM95/usyIkGZFwcZRitr2yJxmCuul8tcRLf1A8/2OFggB2Ir94iSLYoFPkJu2mti54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fBJ+3ljK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yz2zoTd3B2SGb2OvGZT4Mv8Smk7eqCeRwTqYq1ii66k=; b=fBJ+3ljKDSXh2OH3wgGI4/xq6F
	BrWqpAST6/nPLFvHG2qCXfFZR5Elbt5YkPLv+m/ITK3Fjs7JyuksKctIA/cyOSgZS3h5stfqytteA
	8reNhqSjc8DgDKGAkcKCsDf4rXFTuCftrgcvP7P/2S89lk4alLRT00gt7MnV3qiVEGV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsMQZ-00CBQ6-Pt; Thu, 04 Apr 2024 14:42:47 +0200
Date: Thu, 4 Apr 2024 14:42:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 3/3] net: dsa: microchip: lan937x: disable VPHY output
Message-ID: <6577caf8-470e-495b-b4c9-99e7b8a73c54@lunn.ch>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
 <20240403180226.1641383-3-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403180226.1641383-3-l.stach@pengutronix.de>

On Wed, Apr 03, 2024 at 08:02:26PM +0200, Lucas Stach wrote:
> While the documented VPHY out-of-reset configuration should autonegotiate
> the maximum supported link speed on the CPU interface, that doesn't work
> on RGMII links, where the VPHY negotiates 100MBit speed. This causes the
> RGMII TX interface to run with a wrong clock rate.
> 
> Disable the VPHY output altogether, so it doesn't interfere with the
> CPU interface configuration set via fixed-link. The VPHY is a compatibility
> functionality to be able to attach network drivers without fixed-link
> support to the switch, which generally should not be needed with linux
> network drivers.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

