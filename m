Return-Path: <netdev+bounces-70162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0884DE42
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455A01C2278D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571E6D1D0;
	Thu,  8 Feb 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqpmk6wv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114B6BFAD
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388032; cv=none; b=DTe2pWynCqDV7wICouAv373v4v2dDdWJZCoxyDZ2hGkU9ZRE6/yMIKlWSFGNTj8iDbpV8OD2PasigWs1S0wPvNY8R5AJKMgzIYoecA5ydUETLxNpM9E66nYLqQG9dgukmrUwt0Iivcwf0g35xQYXDHCWTQebfgPO13ns/wBOooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388032; c=relaxed/simple;
	bh=GpCDK4oIPH72AhyPeeUmc/bT9ksVXizrIRL4kTnTS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEjm0n1tkR4jXZOvD0A386YJQJvgVmwnvgqxjUNzKVhkNlioE1zg4MOEfmypXe00vjMOaqC0/KDEk7impznk/TRDxEXKxeMs2ldTPcxrvqUUexG+KducLFYjYadFtOVI8N9He8vlp8alGQtTg1nIxLBGvC8npgtV+W4464OG8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqpmk6wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3238C433F1;
	Thu,  8 Feb 2024 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388031;
	bh=GpCDK4oIPH72AhyPeeUmc/bT9ksVXizrIRL4kTnTS0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bqpmk6wv/nJ0GG9KfUIMsJSfZs9bzoNoiNczqtZHCDeg6J/+wcfzSS00nTRjurKF/
	 yqrWf92wdTKt/8wgygHCYKMAze69i+5iOJ3ecPwLoL+uV+lQG9wBhz8ajYz6zyMGOr
	 +M5fNWZCyT2QWe3Vs22hAE2xGgGZQjRQVOfTWa/CLUXCz8EVhcQIerO1bFmRv0/iu3
	 fi+k8efYzsVP618H1FjGV+sfiKDMZUKIAj1CA5+jR04vMsm5LuHSmklDaKEavTp2XA
	 +ZaV0rHtH0d9HvSNGLtf7plSRvIxEpRplzod82jyCBCq2OchNc37fx7JlrliwVy6+L
	 7aD6SK57Wgvkw==
Date: Thu, 8 Feb 2024 10:27:07 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next] net: dsa: b53: unexport and move
 b53_eee_enable_set()
Message-ID: <20240208102707.GC1435458@kernel.org>
References: <20240206112527.4132299-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206112527.4132299-1-vladimir.oltean@nxp.com>

On Tue, Feb 06, 2024 at 01:25:27PM +0200, Vladimir Oltean wrote:
> After commit f86ad77faf24 ("net: dsa: bcm_sf2: Utilize b53_{enable,
> disable}_port"), bcm_sf2.c no longer calls b53_eee_enable_set(), and all
> its callers are in b53_common.c.
> 
> We also need to move it, because it is called within b53_common.c before
> its definition, and we want to avoid forward declarations.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


