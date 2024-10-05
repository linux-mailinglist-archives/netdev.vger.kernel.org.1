Return-Path: <netdev+bounces-132343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4E9914DB
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FEA283454
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFC36B17;
	Sat,  5 Oct 2024 06:26:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0625777
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728109619; cv=none; b=TYHlG0uTWoC0ph9ZnlO+ORABCg5uhPDReP54i7o3WtZzDSUBwW/d1qMjbqOiwVdLJvi9kQGjOomMHLP+O0XKfikcj03MkWVVOj1GPFp31fxL7ZOD1qVDKXvWnKehjoWNOfUdc7CZEiw7m89lcOqkdKotj+YiheePpuB9BfgMFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728109619; c=relaxed/simple;
	bh=iXfbEm5iLcmVFW+aGb9NJHK2R5M98gGi6Ft+W8I4V1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnic+//S/5BANL1+GbE1gAnTbFTmfYvfFDj180yObPqJMD06DBg7PSQTeUdU0wiFbGyBk3ggaaPaEEW1I2HhYtyA6XozvqEYzX7kP+3xzaVAwKEgLS5GxcjlxPz0pv76+DgVoNhPgbuU+Ekpm9Bu4uYIEVBEoQ/b6m5QQOw8Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swyFX-0006Ph-Ny; Sat, 05 Oct 2024 08:26:43 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swyFQ-003lmn-Qr; Sat, 05 Oct 2024 08:26:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swyFQ-00CVQz-2K;
	Sat, 05 Oct 2024 08:26:36 +0200
Date: Sat, 5 Oct 2024 08:26:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <ZwDcHCr1aXeGWXIh@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 02, 2024 at 06:28:02PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch expands the status information provided by ethtool for PSE c33
> with current port priority and max port priority. It also adds a call to
> pse_ethtool_set_prio() to configure the PSE port priority.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 16 ++++++++++++++++
>  include/uapi/linux/ethtool_netlink.h         |  2 ++
>  net/ethtool/pse-pd.c                         | 18 ++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 295563e91082..15208429a973 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1763,6 +1763,10 @@ Kernel response contents:
>                                                        limit of the PoE PSE.
>    ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
>                                                        configuration ranges.
> +  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  priority maximum configurable
> +                                                      on the PoE PSE
> +  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  priority of the PoE PSE
> +                                                      currently configured
>    ==========================================  ======  =============================
>  
>  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
> @@ -1836,6 +1840,12 @@ identifies the C33 PSE power limit ranges through
>  If the controller works with fixed classes, the min and max values will be
>  equal.
>  
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute identifies
> +the C33 PSE maximum priority value.
> +
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
> +identifies the currently configured C33 PSE priority.
> +
>  PSE_SET
>  =======
>  
> @@ -1849,6 +1859,8 @@ Request contents:
>    ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
>    ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
>                                                    power limit
> +  ``ETHTOOL_A_C33_PSE_PRIO``                 u32  Control priority of the
> +                                                  PoE PSE
>    ======================================  ======  =============================
>  
>  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
> @@ -1871,6 +1883,10 @@ various existing products that document power consumption in watts rather than
>  classes. If power limit configuration based on classes is needed, the
>  conversion can be done in user space, for example by ethtool.
>  
> +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
> +control the C33 PSE priority. Allowed priority value are between zero
> +and the value of ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute.
 
We need to introduce a new attribute to effectively manage PSE priorities. With
the addition of the `ETHTOOL_A_C33_PSE_PRIO` attribute for setting priorities,
it's important to know which PSE controller or domain each port belongs to.

Initially, we might consider using a PSE controller index, such as
`ETHTOOL_A_PSE_CONTROLLER_ID`, to identify the specific PSE controller
associated with each port.

However, using just the PSE controller index is too limiting. Here's why:

- Typical PSE controllers handle priorities only within themselves. They
usually can't manage prioritization across different controllers unless they
are part of the same power domain. In systems where multiple PSE controllers
cooperate—either directly or through software mechanisms like the regulator
framework—controllers might share power domains or manage priorities together.
This means priorities are not confined to individual controllers but are
relevant within shared power domains.

- As systems become more complex, with controllers that can work together,
relying solely on a controller index won't accommodate these cooperative
scenarios.

To address these issues, we should use a power domain identifier instead. I
suggest introducing a new attribute called `ETHTOOL_A_PSE_POWER_DOMAIN_ID`.

- It specifies the power domain to which each port belongs, ensuring that
priorities are managed correctly within that domain.

- It accommodates systems where controllers cooperate and share power
resources, allowing for proper coordination of priorities across controllers
within the same power domain.

- It provides flexibility for future developments where controllers might work
together in new ways, preventing limitations that would arise from using a
strict controller index.

However, to provide comprehensive information, it would be beneficial to use
both attributes:

- `ETHTOOL_A_PSE_CONTROLLER_ID` to identify the specific PSE controller
associated with each port.

- `ETHTOOL_A_PSE_POWER_DOMAIN_ID` to specify the power domain to which each
port belongs.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

