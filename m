Return-Path: <netdev+bounces-184963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F2A97D14
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5FB1896117
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DF264A65;
	Wed, 23 Apr 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvw8iyjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A05264628;
	Wed, 23 Apr 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377017; cv=none; b=UQzcgLxm1Epppx/rxVDH8ii3+/IKrxuQOnp/KzSg46YpGpcHPBrwFn+NZh4TUHL2YcAHfX86c+QyfKzRwDqUFC9IL5sQi1EPsmiKuHxJCoFD4WPgoX0p15qtu2iDPTKU98VoOFOupYNVvESFIMM1UhBQ4fTMhxz0C3xOlluzQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377017; c=relaxed/simple;
	bh=dMAaCxtirToeS5W1D5JJ8wI17rIyBHUwXNSJ/MOGGqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGHIJaTXG/r33SWM7+8jBRkAxzLKVZppxQbhzXUxHiLeQO5t4eFXgAPRUun/vFwP2gHxFvOTBCUGnJ+8tFISxIejdcWA+xl9QNZ4ygNcdGEOzCnAN965Cm8ZeIArFALD8If4+LciBDXyXuHSaTx3pG0PgAcQ60r6HpCkVQN4b1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvw8iyjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36276C4CEE9;
	Wed, 23 Apr 2025 02:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745377016;
	bh=dMAaCxtirToeS5W1D5JJ8wI17rIyBHUwXNSJ/MOGGqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pvw8iyjT+Jx3JLT99jXyiXUUr/Sx1LlZPWfApmuERdqxBPZ6s755tjiS80CGPal3G
	 QAfhq8lgVnwiL3N218yPJHnZUkQKL1e2+VQ+sZm/8G1K6svkoY7RB2zwEpWsgDmcdu
	 LQoc9mLEu0/2U0ypDIfSoAfz6qyn+ibZCcObVBrbiXGf1gotnVg1a+k5exYb+IKpgB
	 rmuDvCcIM/vcdHtxf+YhUar4mFZlblRkL5jsfQQndyLGpB9ZxAG3gGzydvr8LOus0B
	 QgljS5pihclbDv0WDbI+kC7OgKx70f8Rzc7xpl1Vfb9QmMAiYzNrXLVG54ioaV0x3A
	 GBWiPlALEJnuQ==
Date: Tue, 22 Apr 2025 19:56:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: dmurphy@ti.com, andrew@lunn.ch, davem@davemloft.net,
 f.fainelli@gmail.com, hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net v2] net: dp83822: Fix OF_MDIO config check
Message-ID: <20250422195655.78124fab@kernel.org>
In-Reply-To: <20250422090634.4145880-1-johannes.schneider@leica-geosystems.com>
References: <20250422090634.4145880-1-johannes.schneider@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 11:06:34 +0200 Johannes Schneider wrote:
> When CONFIG_OF_MDIO is set to be a module the code block is not
> compiled. Use the IS_ENABLED macro that checks for both built in as
> well as module.
> 
> Fixes: 5dc39fd ("net: phy: DP83822: Add ability to advertise Fiber connection")
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Fixes tag needs some work:

  SHA1 should be at least 12 digits long
  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
  or later) just making sure it is not set (or set to "auto").
-- 
pw-bot: cr

