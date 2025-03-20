Return-Path: <netdev+bounces-176596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F1A6AFC2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF14886C14
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8F21CA07;
	Thu, 20 Mar 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aA516Z88"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AC1EA7DE;
	Thu, 20 Mar 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505654; cv=none; b=O7KnIzxZRtv0quyBwP/vydFkkabXmK1qJrXsQYE2LPtTYT2aRd5Bw5kgJOuctzF6ptE9x633Cg6mJ0G403whaA0aNX53wbs19kQCbwlAFjGNy7OTD9QDsCNbimh6LwYbmwZYuIJ/Vcap/YWFh8w1QSgv+009jr3lzYb8K9Ix3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505654; c=relaxed/simple;
	bh=+s7ZB5CBM9CcGb7PpCJcK4Lr37jqrpaUHbWPFDVwTgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf1Y1Qzl9iu4tnZE5/j5kVp6inuv1GvHFPrMei2k04Dma3p5u6BMkNpzi9JtxH6nh7N6lEHIr2AIl09NCDra7PPoSyrwK5A0AvqItbt6JCY8s6Q3bYf8bUyu6U0aksA4hH1z4Q8KcRiL1mzA5vIVBxwpkoeAI5XAKTJylHf3pTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aA516Z88; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+UI5/kSNnDWvxYjcQDDBW5iFQFnCG/NBqKa7zfzLaO8=; b=aA516Z88ocJ1ZbpR5Vx88VqxFq
	xq+NNe2hLJZz8N1TJ7TN86HC+bA32PanbhdX0HOqUYLPcmFuMQJMiY2QCJV6ymLJvSajp5aW3LJoC
	EdX/5TvdyKyLJLVMFUxZuyw3whhMoamPljYS62YTDS3JLejwZKmpWQqUFzawHMw1MI5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvNJe-006W48-U2; Thu, 20 Mar 2025 22:20:38 +0100
Date: Thu, 20 Mar 2025 22:20:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Message-ID: <075283ba-ced1-4aa8-b9ec-7bb456d1d82a@lunn.ch>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
 <20250318-tn9510-v3a-v6-4-808a9089d24b@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-tn9510-v3a-v6-4-808a9089d24b@gmx.net>

> +static int aqr105_config_speed(struct phy_device *phydev)
> +{

This is used when autoneg is disabled. Generally the name would be
_setup_forced, e.g. genphy_setup_forced(). Sticking to that naming
convention makes is simpler to understand if you know other PHY
drivers.

Once you have changed this, you can add my Reviewed-by:

    Andrew

---
pw-bot: cr

