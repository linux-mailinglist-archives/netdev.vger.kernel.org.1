Return-Path: <netdev+bounces-64052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF59830E50
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AB81F24D3A
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6825543;
	Wed, 17 Jan 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m1FmWC0R"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4925542
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524986; cv=none; b=MC0jOjWbgz/y90YE2xbxDIOUoLbI7fsaPClvLtgzWrIHoYIRm8cc5mi8TJKO/EOvg78b/pI2qyRrkvCxl/kBhvD9M/5ONJ10kSRTrzBIkZ3iYjaSJsYNc8upaOrKy5R9uDuUkv7vrrIv9OkczWdGmLESU1Ro10qroaD8WTefLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524986; c=relaxed/simple;
	bh=2dumyDA1FgWHbJManW0mL31qwTTVVgyBdJzEUpUCcZo=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=MLQGtlxy/J03Dim8Q7T2dQLY7IuM1anOhI/S+aLaEo8G2rn6R1d6z/pVqyF6IgsZSFNhWC1LlJwNHk60+J79VUiuNaA8qQgVay7r3NO0BnkYIb4+HFAT6WXGufmjvQnHKlJ6K/wTg54PWrtCKQnCGlTy4GHyyOK8hp2fED08OpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m1FmWC0R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kljASES85imkonGCuUt5AUkZQUvLRDRGuvg5xnwWMXM=; b=m1FmWC0Rfq/C3pygBVCJxrbc3u
	dL3q6MxJhKRyPaAbvbdy8kuC+EzpCAlscE+MZ6wLFHmGEPKixi5Y2YVj58IwNK/d2o368h00upp8S
	slrCKkF+My9PqoqdOBx3MvjeOmAZ4RSKfr3d7rJgWGagy3pF8n4DU0rCVDzenubIM78w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQCxK-005Qtc-3i; Wed, 17 Jan 2024 21:56:14 +0100
Date: Wed, 17 Jan 2024 21:56:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dan.carpenter@linaro.org, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 7/8] net: ti: iccsg-prueth: Add necessary functions
 for SR1.0 support
Message-ID: <3dd35d97-0c06-4154-b01b-92d452e51d53@lunn.ch>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
 <20240117161602.153233-8-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117161602.153233-8-diogo.ivo@siemens.com>

> +static void emac_change_port_speed_duplex_sr1(struct prueth_emac *emac)
> +{
> +	u32 cmd = ICSSG_PSTATE_SPEED_DUPLEX_CMD, val;
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +
> +	/* only full duplex supported for now */
> +	if (emac->duplex != DUPLEX_FULL)
> +		return;

You should tell phylib this, after connecting to the PHY. If you look
around you will find code like:

engleder/tsnep_main.c:	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
engleder/tsnep_main.c:	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
engleder/tsnep_main.c:	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);

The PHY will then not advertise the half duplex modes, and probably
ethtool will be disallowed to force a half duplex mode.

	Andrwe

