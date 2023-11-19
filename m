Return-Path: <netdev+bounces-48977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04137F040A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F5280E8A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 02:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD47110B;
	Sun, 19 Nov 2023 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxH5lUG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF81ED1;
	Sun, 19 Nov 2023 02:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD81CC433C8;
	Sun, 19 Nov 2023 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700360816;
	bh=VoHoOfSpNaP9qVLMEtcQXPYQyIswkE0mHkAveNm44rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxH5lUG3ZKnoTO3Bu6m7TnuVK1fkIPSp+yMLAWtjYf7QgrT9h+xXFetL/xsev9O+R
	 vzjjCyLFmZluckTgeZDmJkpHglkVRznuw14VLPeae0Rh/rh+35lwGGetX/hzGgQDLw
	 odUA935ulOMsiIgLUnuM8IGQ1E+dQZ5Tob10ujEvbmBrfIXYLMRftThz0Amka/idNh
	 pG1R+pZL/8D877iWFsX4gpguLOYcHglA6RLgzGvNqJoE1nyNp3xZpvhiZHOPkbBiat
	 UyBetbn7Fjbd1peWu8cCTwlw4jJi7kxbMtj5aNoY0YWk9uTWaxKCVXsaiQaPQIt6va
	 hNeP4FuFGXWvA==
Date: Sat, 18 Nov 2023 18:26:53 -0800
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
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 10/16] net: ethtool: Add a command to list
 available time stamping layers
Message-ID: <20231118182653.4b706d99@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-10-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-10-472e77951e40@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 12:28:38 +0100 Kory Maincent wrote:
> +	ETHTOOL_A_TS_LIST_LAYER,		/* array, u32 */

multi-attr u32, please

