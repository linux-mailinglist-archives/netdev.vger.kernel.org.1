Return-Path: <netdev+bounces-48974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E556F7F0400
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668DE280E88
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD45ED3;
	Sun, 19 Nov 2023 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0F38iTg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB06EA0;
	Sun, 19 Nov 2023 02:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4D0C433C7;
	Sun, 19 Nov 2023 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700360569;
	bh=3ujfvY9seVdJuDzQfyqXCsj10Q9I2smZrJ5VqFMnpqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V0F38iTgPV1XvA+iHVjg3yvBfJs4uSPRMPJ0kXB7b60CxrdOgIZJksLqU1U+gro4z
	 GJVFVtXjNGuequkWlDJiBHDbm1+Y5kGGxD2SxjGcpOjreuGyX4CcDdUpSHb3OKIWBC
	 SQ54zCM8fE5fwlxZW0qNzAw433vrceTPeP4jyU0uWJcVfVfihfRw0j3xjleXdhNxMj
	 c7tbHLfDqo57OsdgMg4pZiahrUB7/RCVdoB1mpR5E0tgX7N3jXuzk+7QVOhiSoPprb
	 fZdx+JiWLBjAW7IUbmy3MkEnmxlJT0xqRMobfSGJUorn+rxNLmNK1+ZIfhcv+jdkJB
	 c16dMuCrcDQbQ==
Date: Sat, 18 Nov 2023 18:22:47 -0800
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
Subject: Re: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Message-ID: <20231118182247.638c0feb@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 12:28:35 +0100 Kory Maincent wrote:
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will easier future use.
> 
> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not use at all.

Does this really need to be in uAPI?

