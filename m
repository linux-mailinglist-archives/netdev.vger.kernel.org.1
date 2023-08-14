Return-Path: <netdev+bounces-27387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953377BC38
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596871C20A1C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077AC153;
	Mon, 14 Aug 2023 14:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06341A923
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:59:53 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69741E6A
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:59:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so66116801fa.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025190; x=1692629990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg5JoEqxgYDPgFMmvDX3z7J1VVCT3sZtIBZo9X2mZIo=;
        b=kz5J28owKQbu2I61EGgHFkfpYKyUjwIe0q6D8NBn94SRnNcZ0DfHxg6Kd87ZBM8gFB
         QPrnme8dBStf3JZ78zuxKkA0RSgx+g0UajbElij/oZQxrI9OgQ1b2xONhrJxucgrM5BD
         NNJjg85vgqrHlpiUy0MhhJVhPk5mM82NJZnQbwTcATrzpMXcSio2ZKBarS6s3AxgcN3A
         WFSMuNsngQxiDPjOsmYRKZLUmKgv6ByY7ARDAf1JhgD7FjUqo/Y3O3hmq5rsC6vkD1CW
         Km+GomfT/rBfUS8Ck6tkTiHtxWOmecJDv1xgCS6XJD/RzIT0uzQlhv1kZQmcw6s+sq+a
         SAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025190; x=1692629990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg5JoEqxgYDPgFMmvDX3z7J1VVCT3sZtIBZo9X2mZIo=;
        b=f5RF5fF8sbSk+G1qXECufXJlgq7RbtIzN8B+7z8JqImajEoCsO5/xp1BS5EtwZ8wBG
         iuCASCxUkGWzRyuHTZHbb782v7HSZ97CKdcMdGxXd/N5a0mAwUTZGSHF7N5X7QfqaBYC
         kA/4j1676ozEc4IORis8Dz11LOPjnRwoN37h4Gb8YF6kOZbfIIVUjMfpO107mkzi13uB
         XmuX3Drlq59ExfXHLRJI54lmpTS4RCBgL4ZApWo0ONLa9ck+QNZPQkHpkAovVWVJD2Hr
         MGjckPO/uL7Xg+pNvLxQBKnDs150Lu5Ti6/4XcbIyuBAxWk+cZn4qfgo/xM3nJg4pCfq
         0DgQ==
X-Gm-Message-State: AOJu0Yzm3jgYFbtRrbB7mwaCdJbGPS6yu9lXE31KdVPaVakXvoQWccBW
	YGHkNtbqWjBiyz/WEQT7YHk=
X-Google-Smtp-Source: AGHT+IGgMGmptcIX0lTQFr/0+3GFCDsd9GMKHFG+lxdvMTg934oHjK+J2OSomaALH+h06Sr+ztmi0w==
X-Received: by 2002:a2e:9790:0:b0:2b4:75f0:b9e9 with SMTP id y16-20020a2e9790000000b002b475f0b9e9mr7077054lji.10.1692025190493;
        Mon, 14 Aug 2023 07:59:50 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906d20400b00997cce73cc7sm5786598ejz.29.2023.08.14.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:59:50 -0700 (PDT)
Date: Mon, 14 Aug 2023 17:59:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230814145948.u6ul5dgjpl5bnasp@skbuf>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 01:16:00PM +0100, Russell King (Oracle) wrote:
> So for realtek, I propose (completely untested):
> 
> 8<====
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
>  implementation
> 
> The user ports use RSGMII, but we don't have that, and DT doesn't
> specify a phy interface mode, so phylib defaults to GMII. These support
> 1G, 100M and 10M with flow control. It is unknown whether asymetric
> pause is supported at all speeds.
> 
> The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
> and support speeds specific to each, with full duplex only supported
> in some modes. Flow control may be supported again by hardware pin
> strapping, and theoretically is readable through a register but no
> information is given in the datasheet for that.
> 
> So, we do a best efforts - and be lenient.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index 25f88022b9e4..76b5c43e1430 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -1049,6 +1049,32 @@ static enum dsa_tag_protocol rtl8366_get_tag_protocol(struct dsa_switch *ds,
>  	return DSA_TAG_PROTO_RTL4_A;
>  }
>  
> +static void rtl8366rb_phylink_get_caps(struct dsa_switch *ds, int port,
> +				       struct phylink_config *config)
> +{
> +	unsigned long *interfaces = config->supported_interfaces;
> +	struct realtek_priv *priv = ds->priv;
> +
> +	if (port == priv->cpu_port) {
> +		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
> +		/* Only supports 100M FD */
> +		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
> +		/* Only supports 1G FD */
> +		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);

also, I guess that this should allow all 4 variants of RGMII.

> +
> +		config->mac_capabilities = MAC_1000 | MAC_100 |
> +					   MAC_SYM_PAUSE;
> +	}
> +
> +	/* RSGMII port, but we don't have that, and we don't
> +	 * specify in DT, so phylib uses the default of GMII
> +	 */
> +	__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
> +	config->mac_capabilities = MAC_1000 | MAC_100 | MAC_10 |
> +				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> +}
> +
>  static void
>  rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
>  		      phy_interface_t interface, struct phy_device *phydev,
> @@ -1796,6 +1822,7 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
>  static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
>  	.get_tag_protocol = rtl8366_get_tag_protocol,
>  	.setup = rtl8366rb_setup,
> +	.phylink_get_caps = rtl8366rb_phylink_get_caps,
>  	.phylink_mac_link_up = rtl8366rb_mac_link_up,
>  	.phylink_mac_link_down = rtl8366rb_mac_link_down,
>  	.get_strings = rtl8366_get_strings,
> @@ -1821,6 +1848,7 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
>  	.setup = rtl8366rb_setup,
>  	.phy_read = rtl8366rb_dsa_phy_read,
>  	.phy_write = rtl8366rb_dsa_phy_write,
> +	.phylink_get_caps = rtl8366rb_phylink_get_caps,
>  	.phylink_mac_link_up = rtl8366rb_mac_link_up,
>  	.phylink_mac_link_down = rtl8366rb_mac_link_down,
>  	.get_strings = rtl8366_get_strings,
> -- 
> 2.30.2

