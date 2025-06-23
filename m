Return-Path: <netdev+bounces-200440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC52AE5835
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0A1BC6BE6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C1722D785;
	Mon, 23 Jun 2025 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iATEysp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CC1AD3FA;
	Mon, 23 Jun 2025 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722940; cv=none; b=NWHC9pcAl3gl6INA5a87exTQjOVti80XdrDD4maj/oO3AkwBEaTiXFuvB9WNm3VCLr0a7hqV9DpOaYgv816U0xHgCz9cTxrDBsxG6iJ/WUarTZKBqgzTv7rcBbekLgb8un5at0U98ouYyCZr2ZoyDlIKYpgRMxt0D0HVkTK3F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722940; c=relaxed/simple;
	bh=38KvN3nUvZKHe+4UDt03W6VYHPRfCYDRs2Zg5OMyECA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYeHFdpnyiEMmZfOWAzOdawJbKua/jzKqSyz1smzv2aCDWpqNBAB1S7jj6UU2DD2uyIDOTdqHL6jPxsl6VdIqHZuVRDsLpPxhEuzMPN0MoAjtv5fpdJC1LmzBYGNdX1h3/qS19D+hjR+13KncDoU988j4B+vblD+Oos9shVW8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iATEysp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425EDC4CEEA;
	Mon, 23 Jun 2025 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750722938;
	bh=38KvN3nUvZKHe+4UDt03W6VYHPRfCYDRs2Zg5OMyECA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iATEysp9fHni7LFRaxaw8qypvTiRqFG1jr86EgTnW0gf/o39V13W6iiNduEM/j5WN
	 QvTLaaKaYZ3gQOQd0bq+KeWX4UK2Ig1C4pkXQnpsufoY+O9tRQAh4dR6wEq5cOkwwf
	 5nTQvlRyFb6AtobqLk5YtbA4Oi0N7meJpjX7L4zmP7odCe8dJxVkyTzHTMsqQdMM78
	 qwVvddtPKqeax5TyD46FBH4n8q3hAU2ESJsUApCpSgFJ48uXZ/UfgcNSaWg9frdbWs
	 TAvtg4hy4i3rdfuGbKzrZv0CiKgCNva7NhbdELIjlQv8RcXa+7+gSKU6C/c+58P5QO
	 2/ZethTnz7ZvA==
Date: Mon, 23 Jun 2025 16:55:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Russell
 King <rmk+kernel@armlinux.org.uk>, Thangaraj Samynathan
 <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: fix WARN in
 __netif_napi_del_locked on disconnect
Message-ID: <20250623165537.53558fdb@kernel.org>
In-Reply-To: <20250620085144.1858723-1-o.rempel@pengutronix.de>
References: <20250620085144.1858723-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:51:44 +0200 Oleksij Rempel wrote:
> A WARN may be triggered in __netif_napi_del_locked() during USB device
> disconnect:
> 
>   WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350
> 
> This occurs because NAPI remains enabled when the device is unplugged and
> teardown begins. While `napi_disable()` was previously called in the
> `lan78xx_stop()` path, that function is not invoked on disconnect. Instead,
> when using PHYLINK, the `mac_link_down()` callback is guaranteed to run
> during disconnect, making it the correct place to disable NAPI.
> 
> Similarly, move `napi_enable()` to `mac_link_up()` to pair the lifecycle
> with actual MAC state.

Stopping and starting NAPI on link events is pretty unusual.
The problem is the disconnect handling, unregistering netdev
removes the NAPIs automatically, I think all you need is to
remove the explicit netif_napi_del() in lan78xx_disconnect().
Core will call _stop (which disables the NAPI), and then
it will del the NAPI.

> This patch is intended for `net-next` since the issue existed before the
> PHYLINK migration, but is more naturally and cleanly addressed now that
> PHYLINK manages link state transitions.

And repost that for net, please.. :)
-- 
pw-bot: cr

