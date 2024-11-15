Return-Path: <netdev+bounces-145117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD39CD518
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3B8281010
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3567DA9E;
	Fri, 15 Nov 2024 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I862EZ8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B1F16B;
	Fri, 15 Nov 2024 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634749; cv=none; b=sTgnu3a8REwpbbxy15orLNErpJdrP+RKuot1MvLQYtCHi7A4qe4Mqo3i/0jFmte9vfytmX/9yGqw9XCiDRQAjVVrLaBbswABrQJXo2ARtRUhU+49O97mZBCk7DMOFuGvN3emdngZWHfszUcPppHHcDzx6k19y46bXEXa3gFDVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634749; c=relaxed/simple;
	bh=P0J40b7glC7/Mp8K4L3ngJXbPo5jPgKO1ADYUFBreaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cesyVWIqiZg9fARL0CQtYQvbAAH0xxS5ve2lTwf4B6FB14DyZopw067p3sHDuRwcQUHGznhma/QZgPFvlDdWwxUv1hjSQ5aiiF1luN6bA1y8hoS7LzWvxU7N44UEBfC7ELfcbnN+ONInnc9Zu/sK/45rxrswyPD3aVe9uYxHRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I862EZ8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F256C4CECD;
	Fri, 15 Nov 2024 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731634749;
	bh=P0J40b7glC7/Mp8K4L3ngJXbPo5jPgKO1ADYUFBreaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I862EZ8MHJsGm98dQkMHrQTqO1OCOTzGm+CXlfIZsD0/eA52QBvHLPfKsTG/zn66K
	 rF41xnP6L3XPBTbhx5/EaKRt6MNKvIdk5z0LgHen1UhiQoPi6snmAAsyuVVhlqioEk
	 bwAqh6oZZrBGg07JU5YMrhVyv8rEHl2Acb41MXTD7NUIxHBdpRxb3vA5WhhgNL+TQg
	 o9aD0Xnw7N5FPXCDRZF7HvrY/esqf8zVllCPTELummijB1fOyaBbLMn5WZmKTLT5sG
	 JCnHLpjE+XthjsNtZHdhIak6f6004y/lFtQ1AmGe+CAuGZ4sHLZvmrSWoPxWxGPZv2
	 KuIpfbpesCVOA==
Date: Thu, 14 Nov 2024 17:39:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241114173906.71e9e6fb@kernel.org>
In-Reply-To: <20241114114610.1eb4a5da@kmaincent-XPS-13-7390>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
	<20241112111232.1637f814@kmaincent-XPS-13-7390>
	<20241112182226.2a6c8bab@kernel.org>
	<20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
	<20241113163925.7b3bd3d9@kernel.org>
	<20241114114610.1eb4a5da@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 11:46:10 +0100 Kory Maincent wrote:
> > > I see what you mean! It is not something easy to think of as I don't really
> > > know how it would be implemented.
> > > Do you think adding simply the PHC source and the phydev pointer or index
> > > would fit?     
> > 
> > In net_device? Yes, I think so.  
>  
> Also as the "user" is not described in the ptp_clock structure the only way to
> find it is to roll through all the PTP of the concerned net device topology.
> This find ptp loop will not be in the hotpath but only when getting the tsinfo
> of a PHC or changing the current PHC. Is it ok for you?

I think so :) We need to be able to figure out if it's the MAC PHC
quickly, because MAC timestamping can be high rate. But IIUC PHY
timestamping will usually involve async work and slow buses, so
walking all PHYs of a netdev should be fine. Especially that 99%
of the time there will only be one. Hope I understood the question..

> I am at v20 so I ask for confirmation before changing the full patch series! ;)

