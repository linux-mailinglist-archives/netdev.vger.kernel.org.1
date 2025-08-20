Return-Path: <netdev+bounces-215421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4CB2E912
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49775E5086
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D02E1C58;
	Wed, 20 Aug 2025 23:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1020AF67;
	Wed, 20 Aug 2025 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734254; cv=none; b=apA383Pq3ccyLZ91HgKHoB+MvpSPwgiJM+aa/E5AO5EtW+zv1tHnf3vGomgzMzoQmpexsoWeqiH+NzAlNNWi+YXRBvgBCmO9y8Uz6pdiKZlZvAt16sLULcY5COVulNkH6ajCGbaXJd1DZki4t7pN/nngbKMyD7fg5A3r8b6iUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734254; c=relaxed/simple;
	bh=PDY2e9HSYdBjJZMvUwCRkIpgLlaBbsEDE7evAMl9kQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czHaCtPSfiLe06qXilhfV2m/kTzT4pKm3PgHuzoxIYB9d9Pbg6nkErM2B850O/sIsHkMIjmY7vmEUJ4W1uB8NO1IyYJXnT3+mYUfgaFlwEaKsHyEOaD3e5hM+JHoHHbWMnEPA0F8wpy3eDW7fmBQxLJZt3jRyc6rO2nvuBYqsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uosgD-000000003Ep-49Dy;
	Wed, 20 Aug 2025 23:57:22 +0000
Date: Thu, 21 Aug 2025 00:57:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <aKZg3TviLUDgKgLz@pidgin.makrotopia.org>
References: <cover.1755654392.git.daniel@makrotopia.org>
 <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>

On Wed, Aug 20, 2025 at 02:55:49AM +0100, Daniel Golle wrote:
> Store the switch API version in struct gswip_priv (in host endian) to
> prepare supporting newer features such as 4096 VLANs and per-port
> configurable learning.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use __force for version field endian exception (__le16 __force) to
>     fix sparse warning.
> v2: no changes
> 
>  drivers/net/dsa/lantiq_gswip.c | 3 +++
>  drivers/net/dsa/lantiq_gswip.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index f8a43c351649..8999c3f2d290 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -28,6 +28,7 @@
>  #include "lantiq_gswip.h"
>  #include "lantiq_pce.h"
>  
> +#include <linux/byteorder/generic.h>
>  #include <linux/delay.h>
>  #include <linux/etherdevice.h>
>  #include <linux/firmware.h>
> @@ -1936,6 +1937,8 @@ static int gswip_probe(struct platform_device *pdev)
>  					     "gphy fw probe failed\n");
>  	}
>  
> +	priv->version = le16_to_cpu((__le16 __force)version);

I've researched this a bit more and came to the conclusion that while the
above works fine because all Lantiq SoCs with built-in switch are
big-endian machines it is still wrong.
I base this conclusion on the fact that when dealing with more recent
MDIO-connected switches (MaxLinear GSW1xx series) the host endian doesn't
play a role in the driver -- when dealing with 16-bit values on the MDIO
bus, the bus abstraction takes care of converting from/to host endianess.

The above statement will turn into a no-op on little-endian machines
(lets ignore the truncation to 16-bit for now). However, also on little-
endian machine the 'version' field is byte-swapped.

Hence I believe my original approach (using swab16) is better in my
opinion because rather than delcaring a specific endian, what needs to be
expressed is simply that this field is in opposite byte order than all the
other fields.

Hence I believe this should simply be a swab16() which will always result
in the version being in the right byte order to use comparative operators
in a meaningful way.

Sorry for the confusion.

> +
>  	/* bring up the mdio bus */
>  	err = gswip_mdio(priv);
>  	if (err) {
> diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
> index 0b7b6db4eab9..077d1928149b 100644
> --- a/drivers/net/dsa/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq_gswip.h
> @@ -258,6 +258,7 @@ struct gswip_priv {
>  	struct gswip_gphy_fw *gphy_fw;
>  	u32 port_vlan_filter;
>  	struct mutex pce_table_lock;
> +	u16 version;
>  };
>  
>  #endif /* __LANTIQ_GSWIP_H */
> -- 
> 2.50.1
> 

