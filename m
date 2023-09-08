Return-Path: <netdev+bounces-32599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C5798A22
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0491C20CE2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91304F515;
	Fri,  8 Sep 2023 15:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E535694
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31EC433C9;
	Fri,  8 Sep 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694187749;
	bh=GtViuvQNjO5QyEqMbHXIoI+ao0sM4hudHD4TCioXYDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S6HKSkVxEMXvAIoGpPPnYkmN6UhqxYt6LWw7o8KOq3fuZ8pteF+7X124oopEpqq0l
	 JfS2N3rOPa2/ld+k6qz4C/OHtfUFXYHOFuYWyyd7ROToOGOEz4OpeC+Dst/SndGjMK
	 RbchcMdk7T76emowY1XWKIR7H9MhtkODFkIT+sjp+c2/o+Wup2AMFXrMxCUc+XU7d4
	 K0Qq3Xsu9pLr6Y4KHWoyls2DoFOlplTgNvwgVsW4C5w04GuFjNg/+NxubJCyP5L3t5
	 XRfpQldS8uz9SU6WTjYjt2jNeEWC9Ay1XHcHfCytRSaMfkbK/FBDDbCJSrKO65iWSZ
	 r2cKM1oDyq+Kw==
Date: Fri, 8 Sep 2023 08:42:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230908084228.7887c1a9@kernel.org>
In-Reply-To: <20230907092407.647139-7-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Sep 2023 11:24:04 +0200 Maxime Chevallier wrote:
> +enum phy_upstream_type {
> +	PHY_UPSTREAM_MAC,
> +	PHY_UPSTREAM_SFP,
> +	PHY_UPSTREAM_PHY,
> +};

Would be good to define the enum in the YAML spec, too.
That way YNL users can auto-magically see strings for the values.

