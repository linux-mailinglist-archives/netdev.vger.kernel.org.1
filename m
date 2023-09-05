Return-Path: <netdev+bounces-32039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E47921F5
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7FF1C2032B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492DC2DF;
	Tue,  5 Sep 2023 10:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9EA38
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 10:47:32 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BA19B;
	Tue,  5 Sep 2023 03:47:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so363738466b.3;
        Tue, 05 Sep 2023 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693910849; x=1694515649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylraY1bvUuQnreeVGed5Ze1UUnktenaNDedxk7atBiM=;
        b=lb2Me9GNx1fPEiDl3hA/yei1QLQYpH7aXrLuj64oG2j62B9/Guz+S76ZVbQ+PM6Lfd
         hVRN47ttS/kU+Id6ZID7pHcZ4zUrkI3XGOhU5GkqHnywHknABho8vtSmZLgb5KM4SobB
         9U3Vwo3vWYNpHtJdJZL2k6UBLwPLRMUJX4MUkNbVX+s44dtgrUXYu4IdZtNTCGhE2TQQ
         qDrPDeWJ65xR6K50Dh0VXH0AMz/EI28HURRp5YFp50hm7Rd+HzCwUpH6gnsiaUHB3Biz
         hLevKSd8NSSo9lHjE7u1+X18Qd1LciComQ+jRGr24tJJVBYWB3WwVhEDlZveZYbzgqIV
         iiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910849; x=1694515649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylraY1bvUuQnreeVGed5Ze1UUnktenaNDedxk7atBiM=;
        b=ENuKfJnxqDzZLsMhc4+fiETBJroH6KQ5p7MIzN3f115Ixgi2QdrOfgLly2HxX9W4sm
         6bm0NIN4sT9UBXZZfJcT30XMq/PCEhgm43h01HHVd8ott13Ynv9JCvm3I9Bpax8NIA+y
         Aemh+eu8b0CUFTYTuuUz5r/6LHDJtfDtghhxZ8yfGO4DYcDF9XSMq2gOA8kVwenYbe7a
         P9AQp4U/oFXcQZ6nl5OFH2Wx7wI5dupJPxW6N8QthB+Lb/UrF4AjFU45U+9L8ZsK3lCH
         wYqfbQ1NNJjsSJLZQttSJWY+I/I1OuLeKmfZ7wCycb7lBhjunDgoN+UkwEjFp2gUKgOI
         X8Cw==
X-Gm-Message-State: AOJu0YwnGe4ITBQEalv28aMu+uLh49FLP/e414Wp9Cy1CXQu2y75ZIPb
	yG/GpMEFAMccDLKJjZ/LgAU=
X-Google-Smtp-Source: AGHT+IGzlXoU4ahgQWnI0/fEP2DnjcqAWH/vgi1wGGJSCl4GEf7S0dNOn79RGnRaJr4CULguHFkMuQ==
X-Received: by 2002:a17:906:f252:b0:9a1:f81f:d0d5 with SMTP id gy18-20020a170906f25200b009a1f81fd0d5mr8432690ejb.54.1693910848805;
        Tue, 05 Sep 2023 03:47:28 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906255600b0099cd008c1a4sm7399184ejb.136.2023.09.05.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:47:28 -0700 (PDT)
Date: Tue, 5 Sep 2023 13:47:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904120209.741207-5-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 02:02:09PM +0200, Lukasz Majewski wrote:
> This patch provides the common KSZ (i.e. Microchip) DSA code with support
> for HSR aware devices.
> 
> To be more specific - generic ksz_hsr_{join|leave} functions are provided,
> now only supporting KSZ9477 IC.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - None
> 
> Changes for v3:
> - Do not return -EOPNOTSUPP for only PRP_V1 (as v2 will not be caught)

Should be squashed into patch 3/4. The split does not make the code
easier to review for me.

> ---
>  drivers/net/dsa/microchip/ksz_common.c | 69 ++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 579fde54d1e1..91d1acaf4494 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -16,6 +16,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/if_bridge.h>
>  #include <linux/if_vlan.h>
> +#include <linux/if_hsr.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_mdio.h>
> @@ -3433,6 +3434,72 @@ u16 ksz_hsr_get_ports(struct dsa_switch *ds)
>  	return 0;
>  }
>  
> +static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
> +{
> +	struct dsa_port *partner = NULL, *dp;
> +	struct ksz_device *dev = ds->priv;
> +	enum hsr_version ver;
> +	int ret;
> +
> +	ret = hsr_get_version(hsr, &ver);
> +	if (ret)
> +		return ret;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		if (!(ver == HSR_V0 || ver == HSR_V1))
> +			return -EOPNOTSUPP;

move the "default: return -EOPNOTSUPP" statement from below here.

> +	}

I don't see any restriction to allow offloading a single HSR device.
Looking at patch 3/4, that will obviously not work due to some hardware
registers which are global and would be overwritten by the second HSR
device.

For example, a5psw_port_bridge_join() has a similar restriction to
offload a single bridge device.

If you return -EOPNOTSUPP, then DSA should fall back to an unoffloaded,
100% software-based HSR device, and that should work too. It would be
good if you could verify that the unoffloaded HSR works well after the
changes too.

> +
> +	/* We can't enable redundancy on the switch until both
> +	 * redundant ports have signed up.
> +	 */
> +	dsa_hsr_foreach_port(dp, ds, hsr) {
> +		if (dp->index != port) {
> +			partner = dp;
> +			break;
> +		}
> +	}
> +
> +	if (!partner)
> +		return 0;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		return ksz9477_hsr_join(ds, port, hsr, partner);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ksz_hsr_leave(struct dsa_switch *ds, int port,
> +			 struct net_device *hsr)
> +{
> +	struct dsa_port *partner = NULL, *dp;
> +	struct ksz_device *dev = ds->priv;
> +
> +	dsa_hsr_foreach_port(dp, ds, hsr) {
> +		if (dp->index != port) {
> +			partner = dp;
> +			break;
> +		}
> +	}
> +
> +	if (!partner)
> +		return 0;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		return ksz9477_hsr_leave(ds, port, hsr, partner);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct dsa_switch_ops ksz_switch_ops = {
>  	.get_tag_protocol	= ksz_get_tag_protocol,
>  	.connect_tag_protocol   = ksz_connect_tag_protocol,
> @@ -3452,6 +3519,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
>  	.get_sset_count		= ksz_sset_count,
>  	.port_bridge_join	= ksz_port_bridge_join,
>  	.port_bridge_leave	= ksz_port_bridge_leave,
> +	.port_hsr_join		= ksz_hsr_join,
> +	.port_hsr_leave		= ksz_hsr_leave,
>  	.port_stp_state_set	= ksz_port_stp_state_set,
>  	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
>  	.port_bridge_flags	= ksz_port_bridge_flags,
> -- 
> 2.20.1
> 


