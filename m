Return-Path: <netdev+bounces-103806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16B9098F7
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574BB1C20C50
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECA1DFD2;
	Sat, 15 Jun 2024 15:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C449625
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718467193; cv=none; b=B0gO61IXPNRINdHlPkfzm0vOH7bHYK2LuMylLy2ulQicu1kE13oqXK9WxOWrNcNHaUHZe8Pjr5WC4FwODa2VPPeOjBn9hVLY3VtBK9pWBlP0uFefleXQWR66cn1t3EwzETjFuHJIdb/+jX5ZRx4ZvXhxHGUmqWdpXRI8mR3Zn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718467193; c=relaxed/simple;
	bh=KHGjTMoWuQRlBoNsHFxOocl0TQ1I2SITqYCzam/HvNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaKx710z/b20AULEQMf4RkqrxuRF+FSwKg31UuAK7LVZcrlStYaSZCwhB6Mic2DM8cRVwxQq46LpIiQDstCfOeDJRkS9YDPjUyStgKotuuHV5mXbVTMDSulX/eltp+lXRjiZTlIupkyMkcp8UdMQ/zZxhKwhNiVIyFv6vF8ibQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sIVoZ-0008SV-OF; Sat, 15 Jun 2024 17:59:39 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sIVoW-002XHL-Q3; Sat, 15 Jun 2024 17:59:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sIVoW-00CMu4-2I;
	Sat, 15 Jun 2024 17:59:36 +0200
Date: Sat, 15 Jun 2024 17:59:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <Zm26aJaz7Z7LAXNT@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Köry,

On Fri, Jun 14, 2024 at 04:33:21PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch expands the status information provided by ethtool for PSE c33
> with power limit. It also adds a call to pse_ethtool_set_pw_limit() to
> configure the PSE control power limit.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v3:
> - Add ethtool netlink documentation.
> ---
>  Documentation/networking/ethtool-netlink.rst |  8 ++++++
>  include/uapi/linux/ethtool_netlink.h         |  1 +
>  net/ethtool/pse-pd.c                         | 42 +++++++++++++++++++++++-----
>  3 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 7dbf2ef3ac0e..a78b6aea84af 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1737,6 +1737,7 @@ Kernel response contents:
>                                                    PoE PSE.
>    ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``         u32  power extended substatus of
>                                                    the PoE PSE.
> +  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  power limit of the PoE PSE.
>    ======================================  ======  =============================
>  
>  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
> @@ -1799,6 +1800,9 @@ Possible values are:
>  		  ethtool_c33_pse_ext_substate_power_not_available
>  		  ethtool_c33_pse_ext_substate_short_detected
>  
> +When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute identifies
> +the C33 PSE power limit in mW.
> +
>  PSE_SET
>  =======
>  
> @@ -1810,6 +1814,7 @@ Request contents:
>    ``ETHTOOL_A_PSE_HEADER``                nested  request header
>    ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
>    ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
> +  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  Control PoE PSE power limit
>    ======================================  ======  =============================
>  
>  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
> @@ -1820,6 +1825,9 @@ to control PoDL PSE Admin functions. This option is implementing
>  The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL`` implementing
>  ``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
>  
> +When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute is used
> +to control C33 PSE power limit in mW.


The corresponding name int the IEEE 802.3-2022 seems to be pse_avail_pwr
in 145.2.5.4 Variables and pse_available_power in 33.2.4.4 Variables.

This variable is using classes instead of mW. pd692x0 seems to use
classes instead of mW too. May be it is better to use classes for UAPI
too? 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

