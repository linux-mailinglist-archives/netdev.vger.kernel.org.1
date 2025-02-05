Return-Path: <netdev+bounces-163165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CBA2976D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E451885C03
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB821FCCE5;
	Wed,  5 Feb 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d+unV8Q5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64F1FDA62;
	Wed,  5 Feb 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776754; cv=none; b=vDxf+YB/AMGtt/qOjIMRhV9psLQZB+QhzNVkoWxUR7i6AQ8TsVzn8fIt48iFfW5xySVD00G5yTaWCAkuT9EUX5Dq6TVkFqUZiW58KD8gxg0pQ17/b3zYKVndaJQSHlSOQICpElmpbfoOjCGJXb2b0lnoxzA63dVyFPXd+n2UAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776754; c=relaxed/simple;
	bh=SWhcYf8lgrOAo4XzFq2cTizxHoWC/z6TiQotRdwM504=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/gJfIlcin7OQ8V4m73c7ebT2FRntOkk7ia8TaSEwMjfpn/44K+9vZbTqNDKi/fAholw0cLlQ0iTDPR2oUFx827xbNjDJRL6WXHV0668MEVEag3Imll/VP/0ChDc9JRPqcYRPnAq1QuXQoroMBYnEqKXy+URqRXUbRLRetQTels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d+unV8Q5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/UZE8IKL84cYB96Jh6KUCBsqTE4d/7Tqqel9vwHv95I=; b=d+unV8Q5ei9GB4rlWkljBYOmaX
	6xLalGpEusIB0J3mnjT+xNdC2bGDHgUc+jB5w2hncI5i/yW3P9tlU9thaDepbzUb52SP4KQsYlxAL
	ormrHFZ4L2OJL2C0P+xY2VN7b8MBpP5C1gpKC41MnHzpHfc8gclGCTlHS9sUQRPLPfzs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfjG9-00BFm3-DR; Wed, 05 Feb 2025 18:32:21 +0100
Date: Wed, 5 Feb 2025 18:32:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: Add support for
 driver-specific next update time
Message-ID: <dd07079e-f719-4bcd-b8ad-571a4cbf2b8b@lunn.ch>
References: <20250205091151.2165678-1-o.rempel@pengutronix.de>
 <20250205091151.2165678-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205091151.2165678-2-o.rempel@pengutronix.de>

> +/**
> + * phy_get_next_update_time - Determine the next PHY update time
> + * @phydev: Pointer to the phy_device structure
> + *
> + * This function queries the PHY driver to get the time for the next polling
> + * event. If the driver does not implement the callback, a default value is used.
> + *
> + * Return: The time for the next polling event in milliseconds

Jiffies, not milliseconds.

    Andrew

---
pw-bot: cr

