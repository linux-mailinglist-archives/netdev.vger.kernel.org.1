Return-Path: <netdev+bounces-168578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28933A3F655
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34612188E309
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20862080C0;
	Fri, 21 Feb 2025 13:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3066088F
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145808; cv=none; b=VtCJIDJOH6525K0L366EEYYAjWD8e2DLsSlN1For0o6fg81mj4bpj0VwtZXOZDlYV5PgcAGANJUZSRLnbUm8hv7MPtf1+fab9yyWVVd4KEG8khe2H1pUo3g85O376lvvgQI0lDqqGDj36Ck+kfE06A3E3ckgfJZ1fnioGFLPM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145808; c=relaxed/simple;
	bh=+OGK6S7sr/csBxUsXpd2Oq8bTN43O0NJ2ft0Ngbg0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4vIN2D6/XrBswBXMPhWX4hdVtFdWWPdb70213mmHYDSV/Hi3TWD8/mLF48ZNGjIoxtD32V3R9IhTI9JU+8w5rfynlNWHTHfm6kE1zMpOcMazqtdfJjpbxgwcP11/jVi1jxk5rhjhbmrIdbAHmuff0RGsHa0Ne/HU7YO8S8kKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tlTPA-0005C2-FE; Fri, 21 Feb 2025 14:49:24 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlTP7-0026xT-29;
	Fri, 21 Feb 2025 14:49:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlTP7-009zCt-1g;
	Fri, 21 Feb 2025 14:49:21 +0100
Date: Fri, 21 Feb 2025 14:49:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/12] net: ethtool: Add PSE new budget
 evaluation strategy support feature
Message-ID: <Z7iEYQzsdpUFmfZE@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
 <20250218-feature_poe_port_prio-v5-7-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-feature_poe_port_prio-v5-7-3da486e5fd64@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

On Tue, Feb 18, 2025 at 05:19:11PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch expands the status information provided by ethtool for PSE c33
> with current port priority and max port priority. It also adds a call to
> pse_ethtool_set_prio() to configure the PSE port priority.

Thank you! Here are some comments...

> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1790,6 +1790,12 @@ Kernel response contents:
>    ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
>                                                        configuration ranges.
>    ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
> +  ``ETHTOOL_A_C33_PSE_BUDGET_EVAL_STRAT``        u32  Budget evaluation strategy
> +                                                      of the PSE
> +  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  Priority maximum configurable
> +                                                      on the PoE PSE
> +  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  Priority of the PoE PSE
> +                                                      currently configured

Please remove _C33_ from these fields, as they are not specific to Clause 33.

>    ==========================================  ======  =============================
>  
>  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
> @@ -1866,6 +1872,51 @@ equal.
>  The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
>  domain.
>  
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_SUPP_MODES`` attribute
> +identifies the priority mode supported by the C33 PSE.
> +When set, the optional ``ETHTOOL_A_C33_PSE_BUDGET_EVAL_STRAT`` attributes is used to
> +identifies the currently configured C33 PSE budget evaluation strategy.
> +The available strategies are:
> +
> +1. Disabled:
> +
> +   In this mode, the port is excluded from active budget evaluation. It
> +   allows the port to violate the budget and is intended primarily for testing
> +   purposes.
> +
> +2. Static Method:
> +
> +   This method involves distributing power based on PD classification. It’s
> +   straightforward and stable, with the PSE core keeping track of the budget
> +   and subtracting the power requested by each PD’s class. This is the
> +   safest option and should be used by default.
> +
> +   Advantages: Every PD gets its promised power at any time, which guarantees
> +   reliability.
> +
> +   Disadvantages: PD classification steps are large, meaning devices request
> +   much more power than they actually need. As a result, the power supply may
> +   only operate at, say, 50% capacity, which is inefficient and wastes money.
> +
> +3. Dynamic Method:
> +
> +   This method monitors the current consumption per port and subtracts it from
> +   the available power budget. When the budget is exceeded, lower-priority
> +   ports are shut down. This method is managed by the PSE controller itself.
> +
> +   Advantages: This method optimizes resource utilization, saving costs.
> +
> +   Disadvantages: Low-priority devices may experience instability.
> +
> +.. kernel-doc:: include/uapi/linux/ethtool.h
> +    :identifiers: ethtool_pse_budget_eval_strategies
> +
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute identifies
> +the C33 PSE maximum priority value.
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
> +identifies the currently configured C33 PSE priority.
> +For a description of PSE priority attributes, see ``PSE_SET``.
> +
>  PSE_SET
>  =======
>  
> @@ -1879,6 +1930,8 @@ Request contents:
>    ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
>    ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
>                                                    power limit
> +  ``ETHTOOL_A_C33_PSE_PRIO``                 u32  Control priority of the
> +                                                  PoE PSE

Please remove _C33_ from these field, as they are not specific to
Clause 33.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

