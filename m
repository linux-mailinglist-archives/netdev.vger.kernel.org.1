Return-Path: <netdev+bounces-153087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316B9F6C1E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A302A166D65
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C5198E63;
	Wed, 18 Dec 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a3iCu5vv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6594A1D;
	Wed, 18 Dec 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542191; cv=none; b=ed1qPKfFdYYWJ2Ulxfwt4opAs2n8unSI0P3roeQMAFO/Xkxrf27ps2nqj3M2dwqgEnvYa3pUx5OjeFDe1n7qSjOeKFCkNLrvPMkoxAPRKQsIyx7vmkDF4af6+1iQmzRBM6LsuIC49Sjw6HapzX9ypQcpoJENvJGdC4brLGwgbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542191; c=relaxed/simple;
	bh=s8lk+/oLUdRbIaHKP4ZllaA3rqkUAOWUi7drDNlhs7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvaGaCM1GLaLR+KavPQFpTH4go5rSXTqy6hIeekYEgQd9T0XyCS4Er1su2CGSyenBOSZAySpsIhvaplQgDoRmmabATcoTi3+MuhQXZHAihFu9Jaxx1gYChY5uQkPfvDg1JsQH2/8MiN1qWd6N7yQKUY9xrcnrMvry/8RiHJ/nKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a3iCu5vv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LUbmOvAQbbk+rjWr6Xku6oeLX+F+YOEx0ESn29I/zSM=; b=a3iCu5vvjKEwMqdPSytPlzwI86
	Q1EjeuAURoo/ZK/EWH2gPf89IfehgV0NmxKdqgijZkLwTT/dl9F+fhnLUOlt5DHY+pxJOpTniH/oO
	38rLwxuXcceU9pMVEsXuo8ASuYDFCexMLNyrlutMk737aK3z13/aPjIQX0clhUZNGnQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNxem-001LPR-23; Wed, 18 Dec 2024 18:16:20 +0100
Date: Wed, 18 Dec 2024 18:16:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <c63316ac-696d-4ca9-8169-109ed1739f2a@lunn.ch>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
 <20241218085400.GA779107@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218085400.GA779107@debian>

> By the way. Wouldn't it be helpful adding a u32 max_leds to
> struct phy_driver ? Every driver supporting PHY LEDs validates index at the
> moment. With max_leds it should be easy to check it in of_phy_leds and
> return with an error if index is not valid.

I have been considering it. However, so far developers have been good
at adding the checks, because the first driver had the checks, cargo
cult at its best.

If we are going to add it, we should do it early, before there are too
many PHY drivers which need updating.

	Andrew

