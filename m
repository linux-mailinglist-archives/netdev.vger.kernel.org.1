Return-Path: <netdev+bounces-22017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DF765B6C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FB528247F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037A27159;
	Thu, 27 Jul 2023 18:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A527127
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:36:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77B2D42
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690483014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/ZOuF37rEmg7dV7sW7i6E+d7yQkyDTk71SeAdCrRk4=;
	b=GmKeXmqcCWBoaDfcZOUu+B2DQ/h1yAZRvmrl/TVnpWL2pkxuedZRfI5vYsZ6nbxVJSypZU
	ycBDFhiUwa6aSdWhChlOktM4Iy7l07yYmJwvdt7uDmLy2E7PHuDxOmyQdJYP5sApWm2oLj
	ryVPbG5xYj30Xszd2S1H7pUsw9QFlro=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-LJ_1x16eNNWqRzxiviyE5Q-1; Thu, 27 Jul 2023 14:36:52 -0400
X-MC-Unique: LJ_1x16eNNWqRzxiviyE5Q-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4864b43bb0eso328353e0c.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483009; x=1691087809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/ZOuF37rEmg7dV7sW7i6E+d7yQkyDTk71SeAdCrRk4=;
        b=jPejoDz3dmZVH1K3qaA2vuGXbL97quGCnoPOtDsHRwLQ6FX1XxiyxHWa/KzVb1yVRh
         OokkbDMGq7FzPWUj6pdVF1En/0DFkylGcN215HHqyJwdCvbi1W/KKonxvD7ITKGxnTdC
         rhLylqGDXegx37I/hjs5kRj8CgiPL111hQpGMHPBGnOtKilCdc6/+xCPlVRUclqqzPx5
         p+OEYBjba1a8z5womy3DkXpYcfq25O1Dq9vW2i+MKfZzo2o/uKlF6IAQFxNcfzx+Hmqc
         kOzrkj+oNQzsJnbAGJWJMZ06uY9WfZ0uq5KkPr7oDxxvKINVANtr7O4zmkHQQG1nzcSs
         HMuw==
X-Gm-Message-State: ABy/qLasxnbmXP35et4MzDB/rbAXoLyY87JAskaAcXcnAssQ2zhEijh8
	uDI0f3qlOsYSO3vp/hIk/1DI3skL1YpL9fdNBEK9FzYYqGGpPTSQCYqZxBgJeLW3gI8tS97777I
	0m2L26cnqzXe1s9Xq
X-Received: by 2002:a1f:5f03:0:b0:486:4c0e:9ae5 with SMTP id t3-20020a1f5f03000000b004864c0e9ae5mr376077vkb.13.1690483008998;
        Thu, 27 Jul 2023 11:36:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE53Gop5/7fuUY1ixEZawAnKaFZZ1nwoAdNLa3rzIVQi83+W1FiA0MBHmhVRBUb5DmjYcHCnQ==
X-Received: by 2002:a1f:5f03:0:b0:486:4c0e:9ae5 with SMTP id t3-20020a1f5f03000000b004864c0e9ae5mr376063vkb.13.1690483008694;
        Thu, 27 Jul 2023 11:36:48 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id c3-20020a0ce143000000b0063d32f515bbsm602059qvl.127.2023.07.27.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:36:48 -0700 (PDT)
Date: Thu, 27 Jul 2023 13:36:45 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Simon Horman <simon.horman@corigine.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Wong Vee Khee <veekhee@apple.com>, Revanth Kumar Uppala <ruppala@nvidia.com>, 
	Jochen Henneberg <jh@henneberg-systemdesign.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	imx@lists.linux.dev, Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock
 in fixed-link
Message-ID: <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727152503.2199550-3-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 10:25:03AM -0500, Shenwei Wang wrote:
> When using a fixed-link setup, certain devices like the SJA1105 require a
> small pause in the TXC clock line to enable their internal tunable
> delay line (TDL).
> 
> To satisfy this requirement, this patch temporarily disables the TX clock,
> and restarts it after a required period. This provides the required
> silent interval on the clock line for SJA1105 to complete the frequency
> transition and enable the internal TDLs.
> 
> So far we have only enabled this feature on the i.MX93 platform.
> 

I'd just like to highlight that because of a quirk (I think this is not
standard) in the particular connected switch on a board you're making the
whole "fsl,imx93" platform (compatible) implement said switch quirk.

If you don't think there's any harm in doing that for other fixed-link
scenarios, that's fine I suppose... but just highlighting that.

I have no idea at a higher level how else you'd tackle this. You could
add a dt property for this, but I also don't love that you'd probably
encode it in the MAC (maybe in the fixed-link description it would be
more attractive). At least as a dt property it isn't unconditional.

> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 53ee5a42c071..e7819960128e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -40,6 +40,9 @@
>  #define DMA_BUS_MODE			0x00001000
>  #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
>  #define RMII_RESET_SPEED		(0x3 << 14)
> +#define MII_RESET_SPEED			(0x2 << 14)
> +#define RGMII_RESET_SPEED		(0x0 << 14)
> +#define CTRL_SPEED_MASK			(0x3 << 14)

GENMASK() would be cleaner, as well as BIT() usage, but I do see
the driver currently does shifts.. so /me shrugs

>  
>  struct imx_dwmac_ops {
>  	u32 addr_width;
> @@ -56,6 +59,7 @@ struct imx_priv_data {
>  	struct regmap *intf_regmap;
>  	u32 intf_reg_off;
>  	bool rmii_refclk_ext;
> +	void __iomem *base_addr;
>  
>  	const struct imx_dwmac_ops *ops;
>  	struct plat_stmmacenet_data *plat_dat;
> @@ -212,6 +216,44 @@ static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
>  		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>  }
>  
> +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint mode)
> +{
> +	struct imx_priv_data *dwmac = priv;
> +	int ctrl, old_ctrl, iface;
> +
> +	imx_dwmac_fix_speed(priv, speed, mode);
> +
> +	if (!dwmac || mode != MLO_AN_FIXED)
> +		return;
> +
> +	if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
> +		return;
> +
> +	iface &= MX93_GPR_ENET_QOS_INTF_MODE_MASK;
> +	old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
> +	ctrl = old_ctrl & ~CTRL_SPEED_MASK;
> +
> +	/* by default ctrl will be RGMII */
> +	if (iface == MX93_GPR_ENET_QOS_INTF_SEL_RMII)
> +		ctrl |= RMII_RESET_SPEED;
> +	if (iface == MX93_GPR_ENET_QOS_INTF_SEL_MII)
> +		ctrl |= MII_RESET_SPEED;

I see that ctrl right now would select RGMII, but I think it would
read more clearly if you handled it and made the above an
if/else if/else statement (since they're exclusive of eachother)
vs two independent if's.

> +
> +	writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +
> +	/* Ensure the settings for CTRL are applied */
> +	wmb();

I saw this and recently have been wondering about this sort of pattern
(not an expert on this). From what I can tell it seems reading the
register back is the preferred pattern to force the write out. The above works,
but it feels to me personally akin to how local_lock()
in the kernel is a more fine grained mechanism than using
preempt_disable(). But that's pretty opinionated. See device-io.rst
and io_ordering.rst for how I came to that conclusion.

> +
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> +	usleep_range(50, 100);
> +	iface |= MX93_GPR_ENET_QOS_CLK_GEN_EN;
> +	regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> +			   MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> +
> +	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
> +}

I don't have any documentation for the registers here, and as you can
see I'm an amateur with respect to memory ordering based on my prior
comment.

But you:

    1. Read intf_reg_off into variable iface
    2. Write the RESET_SPEED for the appropriate mode to MAC_CTRL_REG
    3. wmb() to ensure that write goes through
    4. Read intf_reg_off (regmap_update_bits())
    5. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK within intf_reg_off (regmap_update_bits())
    6. Sleep for 50-100 us
    7. Read intf_reg_off (regmap_update_bits())
    8. Write MX93_GPR_ENET_QOS_CLK_GEN_EN | iface (from 1) to
       MX93_GPR_ENET_QOS_INTF_MODE_MASK within intf_reg_off (regmap_update_bits())

I don't know what those bits do, but your description sounds like you
are trying to stop the clock for 50-100 us. In your code, if I
understand the memory ordering correctly, both of the following could
occur:

    1. Write RESET_SPEED
    2. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK
    3. sleep
    4. Restore MX93_GPR_ENET_QOS_CLK_GEN_EN | iface

    or

    1. Write RESET_SPEED
    2. sleep
    3. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK
    4. Restore MX93_GPR_ENET_QOS_CLK_GEN_EN | iface

is the latter acceptable to you, or does that wmb() (or alternative)
need to move? It seems to me only the first situation would stop
the clock before sleeping, but that's going off the names in this driver
only.

In either case, shouldn't regmap_update_bits() force a
read of said bits, which would remove the need for that wmb() altogether
to synchronize the two writes?


