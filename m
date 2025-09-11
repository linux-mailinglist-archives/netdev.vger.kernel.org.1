Return-Path: <netdev+bounces-221912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F6B52543
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFDA483192
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7780224D6;
	Thu, 11 Sep 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXcR1CZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B24A04;
	Thu, 11 Sep 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552453; cv=none; b=klJMGhder0QgRW7XXBc6j8kGABdZs3RG/0rT0io9M4Jpak7mQ20B03vnwgN3XeIdIbFyfr0LPL/kNMJgoRexA/xLnXJX4q6tJBsRdiiYdToV2h41RcpbYCgkWzT/G+FBbuJpGaJr9GSnmWfyu7UggaXTZ7JbF+UCkJCPI/Bn6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552453; c=relaxed/simple;
	bh=o5ShqtGU1RVVEbNUwpMOJvTt/t8AGxhMK01uwqZ6cWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFq4klKT4q5p+YPTo5/Zk5HwuI/9nti2VOlVB6KF8GhJnGhyBdlRzQsnvhwOOo2Bz2W404Q3/YNMy7KRdNp6AjxgvDhzTQCLtYmKN/VGS1Xo1mLtm6Y55jL8LRJOkA4CgLhrARxwO/P/SwJSXadVArn4FThnK2af02nyGglWIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXcR1CZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C9CC4CEEB;
	Thu, 11 Sep 2025 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757552453;
	bh=o5ShqtGU1RVVEbNUwpMOJvTt/t8AGxhMK01uwqZ6cWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NXcR1CZKx1RuwDfaLrlExU/QGUSj4Aoi0TlE/TN5AiwlOVuP88R/pWIPbzddeIREm
	 mhXFM5L1kTM0Y129oq3KN7i2+kzKJgQxb80K+5Mo/OH/zAbJit4Joh2Lj5rQccODrR
	 QTXmz2UHWD8oB/F0DgcJzZhblVrLAzMS5ARwUIC/Zxjb4RijsaDH+pCsRQQbAppR4Z
	 DxSbKEqSJulBMXKzgLFfHO74/tSIRPLHHdRBazWy9+ZumsGys+25v47oEpMx+y6/4p
	 EtipphuUm0PBt+hMjpHzHKyi3Tdt0JPDHGNUS+upYwXITP8d5Tv+aKWBvfaWnseHcS
	 +mgBtQgCihd7g==
Date: Wed, 10 Sep 2025 18:00:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: MICREL: Update Kconfig help text
Message-ID: <20250910180052.31c05929@kernel.org>
In-Reply-To: <20250909-micrel-kconfig-v1-1-22d04bb90052@pengutronix.de>
References: <20250909-micrel-kconfig-v1-1-22d04bb90052@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 10:43:38 +0200 Jonas Rebmann wrote:
> Subject: [PATCH] net: phy: MICREL: Update Kconfig help text

no need to capitalize MICREL

>  	help
> -	  Supports the KSZ9021, VSC8201, KS8001 PHYs.
> +	  Supports the KSZ and LAN88 families of Micrel/Microchip PHYs.

Would it be more typical to add something after the family name?
KSZx and LAN88x ?
-- 
pw-bot: cr

