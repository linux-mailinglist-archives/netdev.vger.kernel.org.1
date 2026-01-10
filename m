Return-Path: <netdev+bounces-248724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11411D0DA91
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90063010A9D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E614126C17;
	Sat, 10 Jan 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKRIG0vC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58E25771
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768070941; cv=none; b=O6z8Wq7loK5r9spFJeaNsBX5tZnfXQFo2ztNsrJsOS/Ag/62LuJoRqnWYAzIIBe6qMeBAPF+YItT2b4slhNnR3ByPvNfzNyDUXRWJwnL+8OgAgEBHbL2kLh1zVhGBccbmo3LIt+4QAfE2E695en8mb4nzWZWcoSRBDD9thvC7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768070941; c=relaxed/simple;
	bh=0dAWoUzTvHaiJce07sZHIzrrwXoEXwl02qU1vns7cfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6LjaxV/WFrN3gAEVJh5ee4tuxV3uEO5/vyNtfUXr+WaWZjU9XazrcDPu2oc1BfVaSomlEJfre9kWBjVTn3zh0KbQ7ntRqmJ0f9KBuphP1IQ178oza4er1WV43vEIS9F2zmgK2zdC1cu7y0g3GdSRbGEkbsH7KDumGIARMl0kIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKRIG0vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2257C4CEF1;
	Sat, 10 Jan 2026 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768070940;
	bh=0dAWoUzTvHaiJce07sZHIzrrwXoEXwl02qU1vns7cfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKRIG0vCIzkXCUt0epxddZ+JeOM+oBsWcE5E+kjFeGe1v5/MPPfTippWcfL+lh/3Q
	 jvPsTENESqQ0yo9xL2puZLbbwVIwMArrYU6vYa3WMjRI9aoZx8UfSImPEkJKhRLggm
	 9tFTpDDmOMrpqkNQHIZiwGnJ2C8sUEF4OHwDQMOiis/aU1IXAnhzCJ4gSD+47gpH7/
	 crxq/BN+1WX3hfFA36MepQW6V/1q7SvQRTsQqpJVt1wmndmqXDD1ixtfqqfM1sQNgG
	 CAKXDBbM/cfP+tZG0GSUriN8C6cTSgA5OZwYy/Upei7UckGRFQIkKC+8BmSlldT58c
	 z5ObKcaqPs79w==
Date: Sat, 10 Jan 2026 10:48:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, Vladimir Oltean <vladimir.oltean@nxp.com>, Michael
 Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G
 Fiber SFP)
Message-ID: <20260110104859.1264adf3@kernel.org>
In-Reply-To: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 16:12:30 +0100 Heiner Kallweit wrote:
> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> DAC). The list of supported modes was provided by Realtek. According to the
> r8127 vendor driver also 1G modules are supported, but this needs some more
> complexity in the driver, and only 10G mode has been tested so far.
> Therefore mainline support will be limited to 10G for now.
> The SFP port signals are hidden in the chip IP and driven by firmware.
> Therefore mainline SFP support can't be used here.
> The PHY driver is used by the RTL8127ATF support in r8169.
> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
> PHY ID.

Hi Heiner!

This series silently conflicts with Daniel's changes. I wasn't clear
whether the conclusion here:
https://lore.kernel.org/all/1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com/
is that we shouldn't remove the define or Daniel's changes are good 
to go in.. Could y'all spell out for me what you expect?

