Return-Path: <netdev+bounces-248726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6ED0DA9D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 061E43013EF7
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524412652B0;
	Sat, 10 Jan 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/x+6jyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E942050
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768071462; cv=none; b=SiHs3i8aS+ukAdYkKp3/psMalBYsTPVDwcR2kgGoOZpUmtWjj+Y488Z/hi07Am+Cp6y4g0RvSfi5xUVDFqC+dRBrH1vMjVf1/qnKvHFTYGoYtZPx28wGCPJnHRPX1yeiWQ2Gp9YJiQ+jqhlUzgz7oeBCpvB8XGHiIaK406RoSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768071462; c=relaxed/simple;
	bh=WZjLJEsQWa+iONBelhDn2rwy2lZQ4tYSIINigAcVMy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOa0rJArQuuVyE4snCGUirLHk5m0kP3KZtp5JfpCvsdZ26MlrKsD1sd7C6FnfJDixT1/do9iKv5Mo3rqNYGNBp4RE2Vrev6KTiPiSPCyl9gG9eZ5x7LuXqUCLaAmhOOPhu9c6rMMYnU5GNPyJXTsEqx6OIoFYD0XIw3t7FJFSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/x+6jyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200DAC4CEF1;
	Sat, 10 Jan 2026 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768071461;
	bh=WZjLJEsQWa+iONBelhDn2rwy2lZQ4tYSIINigAcVMy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/x+6jyY3Bh2uieZ9yxMhMfe6oKSPMRsFD/Z35J8AyhgYj3LlLcem6MHBDGJ4T2tp
	 wR+nf6KMmo7pMwL5GHAS+hNy69w0RCvuMYBhqGIKMGlBKkLYDTNPDbM/eDmus1axmI
	 v/QbY5RQKW2kgy4+H0wlgd9Hmk99pOY0VnYJ2OhslagED3tvdecbYCFKI3685sOiUT
	 0IpBQCBE6mqaS6TsUuEfCZvrAIZSrmiTWN9Boz0OOXE6GVHahRLStWqzhpSrauqL27
	 bTf3Oq3MxPShuipnctoY7phZQZgDriAXsL0Z/5hlDOk2599mE17OzTpm75lhaBFoEJ
	 6a4rn3HTqQgLg==
Date: Sat, 10 Jan 2026 10:57:40 -0800
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
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <20260110105740.53bca2cb@kernel.org>
In-Reply-To: <6b1377b6-9664-4ba7-8297-6c0d4ce3d521@gmail.com>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
	<492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
	<20260108172814.5d98954f@kernel.org>
	<6b1377b6-9664-4ba7-8297-6c0d4ce3d521@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 18:23:06 +0100 Heiner Kallweit wrote:
> On 1/9/2026 2:28 AM, Jakub Kicinski wrote:
> > On Thu, 8 Jan 2026 21:27:06 +0100 Heiner Kallweit wrote:  
> >> --- /dev/null
> >> +++ b/include/linux/realtek_phy.h  
> > 
> > How would you feel about putting this in include/net ?
> > Easy to miss things in linux/, harder to grep, not to
> > mention that some of our automation (patchwork etc) has
> > its own delegation rules, not using MAINTAINERS.  
> 
> Just sent a v2 with the new header moved to new include/net/phy/.
> patchwork is showing a warning rgd a missing new MAINTAINERS entry.
> However this new entry is added with the patch:
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
>  F:	include/linux/phylib_stubs.h
>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>  F:	include/linux/platform_data/mdio-gpio.h
> +F:	include/net/phy/
>  F:	include/trace/events/mdio.h
>  F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
> 
> Bug in the check?

My reading of it was basically that it's upset that realtek PHYs don't
have a dedicated maintainer. The check considers the PHY subsystem as
too large for the same people to cover core and all the drivers.
If that's the case then the check is working as expected.
It's just flagging the sub-optimal situation to the maintainers.

I wasn't sure if you'd be willing to create a dedicated MAINTAINERS
entry for Realtek PHYs. The check itself is safe to ignore in this case.

