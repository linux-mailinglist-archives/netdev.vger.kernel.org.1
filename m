Return-Path: <netdev+bounces-163171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E308A297E6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A9D3A5574
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354001FCFF1;
	Wed,  5 Feb 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lmg6D3HU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5E1FC7F9;
	Wed,  5 Feb 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777361; cv=none; b=Y5mXtidN+k8LgHx9Dd85irtwKS7kbSbGvXUTwYDE8SPZ5uTBDd8GyqG+uujQBDXwxzjZ2LiLidmvhE5FMZwvdgK1krnRMBXQPlTeiGZpCWdT3mdMDsZ246IRblQM7OhpccgLn1vF3FxmVWAKOT7AsaIUxTSPZ6PxplnpfyT+gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777361; c=relaxed/simple;
	bh=FM4bTy2fIxKJY4YL884gR/k8wuHai1SuESQfqjTjdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxJ6GE6D7/D/XTKReMvurYcJIW8ayH/1qhaXUewzdQgDCFTb3vBopFcC8oFIYOuI7poz/rQAEvZW8W1Ux+OnwZxo4Pl96v/gGc5aTfZaiZVjqM+AL/WHk3918+zZVrY/NMDjmtPPAkW+boH+ZfqWB3VcBwBZbzxfLUUSZr47PwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lmg6D3HU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rdd/MEW/P3uHV2EnNuTrQYWSfyS/TwvFxMMuVJeRWHQ=; b=Lmg6D3HUaIPokEWuZLhONeCeGg
	qgd2hOYcbWwXf9MO9KbU8Dt++GyE5KOIVLQDJ9b/91+wMCHc7XMBCNBjyGvDWPjUazUezJo+NEsbi
	o/Vyhw+n93/UhfX/SlolsJxrAf6flZmptpVUNuLXpYpYzUWTJs3DHjtpLUkqQdRX+VBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfjPz-00BFwU-7g; Wed, 05 Feb 2025 18:42:31 +0100
Date: Wed, 5 Feb 2025 18:42:31 +0100
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
Message-ID: <2e316ec4-8f5b-4dbd-96d2-aabc29bfae17@lunn.ch>
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

> +	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
> +		unsigned int next_update_time =
> +			phy_get_next_update_time(phydev);
> +
> +		phy_queue_state_machine(phydev,
> +					msecs_to_jiffies(next_update_time));

Ah, i missed the msecs_to_jiffies() call. But the driver change now
looks wrong. I think to keep things simple, the API should use
jiffies, since that is what phy_queue_state_machine() and
mod_delayed_work() expect.

Did you test with Timer frequency = 100, that should make errors more
obvious.

	Andrew

