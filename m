Return-Path: <netdev+bounces-213330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E0B2497B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AF91BC3B06
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD51A5BA2;
	Wed, 13 Aug 2025 12:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03618A6B0
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087946; cv=none; b=romhERIwird/hYwr01YznAI/yw79GoG/nxDEuJzOJ5cJwopGcACCib+B6BRNVc7Afzj2ZOMEWnsPzQPywxZUGK3s99Lpe5w4OuEbeXsGqrStjiFCjDvNQEFnTTRbPWFp4OiqXETdAj8R07mwrS4fPySBdK+HpjuiZBXtaTekGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087946; c=relaxed/simple;
	bh=0HkpxNl44NrVp+5qb4BCrOTLkmwwz7dBkNDx3u1z8lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfTF2JuQN6N/LkMLMeUvbIs7KAXl4QZtX1r2yHvK5+aiHN0DWUxQp/D/WueichuMNQgDs0LongLDDdEKAk65mKQfeX5uVP09lIfBXLetaXFmRufplGcoWcx/GCRnQbd6UM94pxBf/HrHJ/CIeytF9PfgMD6UxEgDC+EAPYHwoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1umAXk-00048k-MG; Wed, 13 Aug 2025 14:25:24 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAXj-0005VI-08;
	Wed, 13 Aug 2025 14:25:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAXi-0094sZ-30;
	Wed, 13 Aug 2025 14:25:22 +0200
Date: Wed, 13 Aug 2025 14:25:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Dent Project <dentproject@linuxfoundation.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v2 2/3] ethtool: pse-pd: Add PSE priority support
Message-ID: <aJyEMob8kFAvD-HU@pengutronix.de>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
 <20250813-b4-feature_poe_pw_budget-v2-2-0bef6bfcc708@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813-b4-feature_poe_pw_budget-v2-2-0bef6bfcc708@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

Thank you for your work! Here are some review comments...

On Wed, Aug 13, 2025 at 10:57:51AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for PSE (Power Sourcing Equipment) priority management:
> - Add priority configuration parameter (prio) for port priority management
> - Display power domain index, maximum priority, and current priority
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  ethtool.8.in     | 13 +++++++++++++
>  ethtool.c        |  1 +
>  netlink/pse-pd.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/ethtool.8.in b/ethtool.8.in
> index 29b8a8c..163b2b0 100644
> --- a/ethtool.8.in
> +++ b/ethtool.8.in
> @@ -561,6 +561,7 @@ ethtool \- query or control network driver and hardware settings
>  .RB [ c33\-pse\-admin\-control
>  .BR enable | disable ]
>  .BN c33\-pse\-avail\-pw\-limit N
> +.BN prio N
>  .HP
>  .B ethtool \-\-flash\-module\-firmware
>  .I devname
> @@ -1911,6 +1912,15 @@ This attribute specifies the allowed power limit ranges in mW for
>  configuring the c33-pse-avail-pw-limit parameter. It defines the valid
>  power levels that can be assigned to the c33 PSE in compliance with the
>  c33 standard.
> +.TP
> +.B power-domain-index
> +This attribute defines the index of the PSE Power Domain.

May be:

Reports the index of the PSE power domain the port belongs to. Every
port belongs to exactly one power domain. Port priorities are defined
within that power domain.

Each power domain may have its own maximum budget (e.g., 100 W per
domain) in addition to a system-wide budget (e.g., 200 W overall).
Domain limits are enforced first: if a single domain reaches its budget,
only ports in that domain are affected. The system-wide budget is
enforced across all domains; only when it is exceeded do cross-domain
priorities apply.

> +.TP
> +.B priority-max
> +This attribute defines the maximum priority available for the PSE.

Reports the maximum configurable port priority value within the reported
power domain. The valid range for prio is 0 to priority-max (inclusive).

> +.TP
> +.B priority
> +This attribute defines the currently configured priority for the PSE.

Reports the currently configured port priority within the reported power
domain. Lower numeric values indicate higher priority: 0 is the highest
priority.

>  .RE
>  .TP
> @@ -1930,6 +1940,9 @@ This parameter manages c33 PSE Admin operations in accordance with the IEEE
>  This parameter manages c33 PSE Available Power Limit in mW, in accordance
>  with the IEEE 802.3-2022 33.2.4.4 Variables (pse_available_power)
>  specification.
> +.TP
> +.B prio \ N
> +This parameter manages port priority.

Set the port priority, scoped to the port's power domain
as reported by power-domain-index. Lower values indicate higher
priority; 0 is the highest. The valid range is 0 to the
priority-max reported by --show-pse.

When a single domain exceeds its budget, ports in that domain are
powered up/down by priority (highest first for power-up; lowest shed
first).  When the system-wide budget is exceeded, priority ordering is
applied across domains.

>  .RE
>  .TP
> diff --git a/ethtool.c b/ethtool.c
> index 215f566..948d551 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6339,6 +6339,7 @@ static const struct option args[] = {
>  		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
>  			  "		[ c33-pse-admin-control enable|disable ]\n"
>  			  "		[ c33-pse-avail-pw-limit N ]\n"
> +			  "		[ prio N ]\n"
>  	},
>  	{
>  		.opts	= "--flash-module-firmware",
> diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
> index fd1fc4d..5bde176 100644
> --- a/netlink/pse-pd.c
> +++ b/netlink/pse-pd.c
> @@ -420,6 +420,29 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
>  		}
>  	}
>  
> +	if (tb[ETHTOOL_A_PSE_PW_D_ID]) {
> +		u32 val;
> +
> +		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PW_D_ID]);
> +		print_uint(PRINT_ANY, "power-domain-index",
> +			   "Power domain index: %u\n", val);
> +	}
> +
> +	if (tb[ETHTOOL_A_PSE_PRIO_MAX]) {
> +		u32 val;
> +
> +		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO_MAX]);
> +		print_uint(PRINT_ANY, "priority-max",
> +			   "Max allowed priority: %u\n", val);
> +	}
> +
> +	if (tb[ETHTOOL_A_PSE_PRIO]) {
> +		u32 val;
> +
> +		val = mnl_attr_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
> +		print_uint(PRINT_ANY, "priority", "Priority %u\n", val);

missing colon
		print_uint(PRINT_ANY, "priority", "Priority: %u\n", val);
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

