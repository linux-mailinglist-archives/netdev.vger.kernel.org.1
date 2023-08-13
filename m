Return-Path: <netdev+bounces-27100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87A77A5FE
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3150A1C20755
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6041FCC;
	Sun, 13 Aug 2023 10:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1864A
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 10:50:38 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E0170D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 03:50:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-997c4107d62so452987366b.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691923834; x=1692528634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncTvxirh2VNF/7VoGbZDEfVN4GwlENv4Wa/VOExQ8c8=;
        b=o1qmZfY2pk2lEqatQThSZfsxE4BSto4yPqDE2Lj6EqInUq6i/McJdZewYp7iik59fw
         BeGEzTvxC/X8kyASXv9UDG9jFcWnf3n0wSfZZHQJHG4HX5NNKlx06H1Lt/dCUi+IRrM0
         yskudbqQ8kl9fUPjOLbgqeE2TK0ZpuSpoxgEZi6QDvP7TClbnsKm5y24kzHcw7S4B0wd
         It6xW7TdWARp70ThBph0h6ikG7RMjhYrRYb7aXUugD6oJLJ2y0CVrnAaqh/0tmYEjkOH
         ImkE8EglELuRtb4ZQW02kCMBXl3kQDtJmHa7ZeVM3Kiuy2wlsb/kstLl5V8pemyunNhE
         g/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691923834; x=1692528634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncTvxirh2VNF/7VoGbZDEfVN4GwlENv4Wa/VOExQ8c8=;
        b=Nikth/LoGugfH5CapVUC9hDlA7K97sVmKzW324emakBS56Lo2pubgdRH2esKROVAVY
         pVTZdArSNBlTmcohE3PSZAX7CfSkJLPHBBDZlzoL8y8Lf9JmHOD7EIaRcKPJrVghYV14
         I+RC+qKz5+8vN2WOY73cfzgOJS7XvGwsomH412gSROVnDGk8Dg5wrhHpwJ6ypnJAXzmB
         S5nNmJ9GLCA2v9OJppY7uF/g6oF+fHtEeyEqe/b5J5QPCjtgpNvDNdWqP5ZWEgqjMQyK
         Tbdb1nsrDcbH4O88nv2zuX8c+/owZw3x0Xq7V4c2VcAoHPMJFDqhvaiSKT1MtCTHdZb7
         b2IA==
X-Gm-Message-State: AOJu0Yw4ahfYyk6e32YlEPaN9v1mWEC6/TS9z0/qcSY6GY9w99Iy+XGX
	vyAjM7pp3W+gNI7WW0TeN00=
X-Google-Smtp-Source: AGHT+IHMsxVSVXPZa6HGRni2MNaKBQNeHIPtEcmhQ144PW7ELbOYz4QTaItEbqjYj4dRsoOC9DxXqg==
X-Received: by 2002:a17:906:74d6:b0:997:decf:11e7 with SMTP id z22-20020a17090674d600b00997decf11e7mr5632396ejl.12.1691923834109;
        Sun, 13 Aug 2023 03:50:34 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090637c900b00992b66e54e9sm4429897ejc.214.2023.08.13.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 03:50:33 -0700 (PDT)
Date: Sun, 13 Aug 2023 13:50:31 +0300
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
Message-ID: <20230813105031.zvagj264hiqvu3xb@skbuf>
References: <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
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
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 01:16:00PM +0100, Russell King (Oracle) wrote:
> It's actually better - the vitesse driver uses .adjust_link, which
> means it's excluded from phylink for the DSA/CPU ports.
> 
> So, I think for Vitesse, we just need to set INTERNAL and GMII
> for ports != CPU_PORT, speeds 10..1000Mbps at FD and HD, and also
> sym and asym pause.

Ok.

> That leaves the RTL836x driver, for which I've found:
> 
> http://realtek.info/pdf/rtl8366_8369_datasheet_1-1.pdf
> 
> and that indicates that the user ports use RSGMII which is SGMII with
> a clock in one direction. The only dts I can find is:
> 
> arch/arm/boot/dts/gemini-dlink-dir-685.dts
> 
> which doesn't specify phy-mode for these, so that'll be using the
> phylib default of GMII.
> 
> Port 5 supports MII/GMII/RGMII by hardware strapping, which has three
> modes of operation:
> 
>   MII/GMII (mac mode): 1G (GMII) when linked at 1G, otherwise 100M (MII)
>   RGMII: only 1G
>   MII (phy mode): only 100M FD supported. Flow control by hardware
>   strapping but is readable via a register, but omits to say where.
> 
> There's also some suggestion that asym flow control is supported in 1G
> mode - but it doesn't say whether it's supported in 100M (and since
> IEEE 802.3 advertisements do not make this conditional on speed...
> yea, sounds like a slightly broken design to me.)
> 
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
> +
> +		config->mac_capabilities = MAC_1000 | MAC_100 |
> +					   MAC_SYM_PAUSE;

Missing "return" statement here.

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
> 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


