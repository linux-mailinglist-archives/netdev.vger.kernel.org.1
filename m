Return-Path: <netdev+bounces-197036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151EDAD7688
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C612818902AD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F029B797;
	Thu, 12 Jun 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TrfWvhOt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479229B8DB;
	Thu, 12 Jun 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742454; cv=none; b=rvjU22lgdLrNR4tUr05dbczV7afAfeYvpnuzz8tWiU7fkYvMmeNSCxx1adC4jiPdg7SwXJQobDszO7k1RpeGxm0fmzWLylFtMhsVZTQ1OgDDvCTh+kzIz3dmwowcwdHYnPA6l6U5HagtdjcF2ASI6poGrkAozENEXUDnpqxN/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742454; c=relaxed/simple;
	bh=iPNR50sPYUUCDCaNvj8MLZuK+84itUMQIshIg3L0XlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm59xztlbq2MJLOV59Ey/d7Oj2sptf8NrtbJB1jPuNfPhkU/qOorlzUICzOvd8g1fowi0EqDVBJrAWyBosYY2cdDI3S1pRbyAhGApVJzm8SPGDXJY4Yl3GPqfWRlu1LoEK/hY0DT+/i5ej8kt9Q1BitusnOD55BkxWEKgW2kf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TrfWvhOt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YaLaQm730cgBiLAxsEht8msCO4OYIEPeLEr72jBbh3M=; b=TrfWvhOtKPry1+2f6wadGbk0DI
	voP75vIqyke9FmjQCviZUUfiUkNff8NKvXTMZ6eDgJkUi5xKy8l3pwe0G95kIgqG0tZOy9ttPxTIM
	OJIK6wIFkFavDwMQyCmnRCDm3OsgaM0ncC8Omdiz+DckfxM7WfwmoVwKWFBygLLmpycM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPjwJ-00FYo9-JG; Thu, 12 Jun 2025 17:34:03 +0200
Date: Thu, 12 Jun 2025 17:34:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: dp83tg720: remove redundant
 600ms post-reset delay
Message-ID: <3f3cfa9b-07f3-450e-b1a8-984943edddef@lunn.ch>
References: <20250612104157.2262058-1-o.rempel@pengutronix.de>
 <20250612104157.2262058-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612104157.2262058-3-o.rempel@pengutronix.de>

On Thu, Jun 12, 2025 at 12:41:56PM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Now that dp83tg720_soft_reset() introduces role-specific delays to avoid
> reset synchronization deadlocks, the fixed 600ms post-reset delay in
> dp83tg720_read_status() is no longer needed.
> 
> The new logic provides both the required MDC timing and link stabilization,
> making the old empirical delay redundant and unnecessarily long.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

