Return-Path: <netdev+bounces-21532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577B763D33
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E141C2130C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511731AA93;
	Wed, 26 Jul 2023 17:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D031AA80
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 17:03:46 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679972712
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:03:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317798b359aso21833f8f.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690391020; x=1690995820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RidFgmIYodB4LoijuDUvWl2A58yPKSzZPeSa6pREuP4=;
        b=eWH5pKbpRVoI/ESaC8uvPUlYLQ4GjPOPmCqDQ3/0VsVJ0iMBCevILPbEzc9DYDgbKN
         NielMbT9E5i6K6cOpJBhw94g7iAFwUnTVLJ1edqJ8+2YZ7ueD47XIbGq5BxVToWpAgkS
         7bZmrUlcrAAWhFovk6EGiV6f34/lPk9r6LaDWXJ0MS9FA0i/Y+jl7jNJVLyzEHKnd8bU
         CdV7Eg2HSD8ftHrHknGOAwBLDASr3qogT7tj0zgVhHGpVuvDfbyb9dnH5mwSwjhXjzR4
         JcMb48/PXpHEBxnUtw71iWz29+0Ki5f1bBku9jjmbFUZBE6tUA3Ks2TzC1+F/UA1t0DT
         lBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391020; x=1690995820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RidFgmIYodB4LoijuDUvWl2A58yPKSzZPeSa6pREuP4=;
        b=UPSDP18xozpzMxIgTInmrYEHSHdzJSEMO5o8oBMGf0px0bAkH5qblAw9W2UQmgx8aR
         g4qliVOsjE6VwqOZeTqmjqzJAqPQK43evPtfsfZSIAGrfqmByLB3ST5PY4dSgjODidTj
         1zVY5GQaxrCKDt4yxgpbTH/IgdAXPyAHK7KcX4O3XVtC6qYkNtHowOl1NAaP8HRjOp2O
         Rkzi0LcoZs4aRgMZWObYPCVVdfEx+rWK/EkgJK/vZbblp5QgGEPTGrfIlKoPSDnyM57C
         YXx9pT/jjfTzoxCuyvdh9RTONWH+733eb7LYT1dCoX+aAvt8s5kshN+UQwUTp9IysO69
         wtfA==
X-Gm-Message-State: ABy/qLbOAVRVmx6B5p0O6D4HgRTEf9ytosl+2Z//mhB3xhUb+ppxr68L
	ePO69dB3Lnze+CLOqoR2Hk0=
X-Google-Smtp-Source: APBJJlFvg7Yxfd2N1g9PwD8D88WAdjE44Fv6yFqKb8JhOXAIlUE51SrUpYGeR/UUqRlsRrfxQZvSuQ==
X-Received: by 2002:a5d:65d1:0:b0:317:6efd:3a6b with SMTP id e17-20020a5d65d1000000b003176efd3a6bmr1889672wrw.24.1690391020221;
        Wed, 26 Jul 2023 10:03:40 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id h4-20020adfe984000000b003175f00e555sm10449511wrm.97.2023.07.26.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 10:03:39 -0700 (PDT)
Date: Wed, 26 Jul 2023 20:03:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Message-ID: <20230726170336.4t4wuw2v34haftk7@skbuf>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
 <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 05:29:30PM +0100, Russell King (Oracle) wrote:
> On Wed, Jul 26, 2023 at 04:10:11PM +0000, Shenwei Wang wrote:
> > > So, plat->phy_node will never ever be equal to your "dn" above.
> > > plat->phylink_node is the same as dwmac->dev->of_node above, and
> > > so plat->phylink_node will never be your "dn" above either.
> > >
> > > Those two together means that imx_dwmac_is_fixed_link() will _always_ return
> > > false, and thus most of the code you're adding is rather useless.
> > >
> > > It also means the code you're submitting probably hasn't been properly tested.
> > >
> > > Have you confirmed that imx_dwmac_is_fixed_link() will actually return true in
> > > your testing? Under what conditions did your testing reveal a true return value
> > > from this function?
> > >
> > 
> > We can't make that assumption. In my testing code, I had trace statements in that
> > section to indicate the code was actually executed. You may get some clues from the following DTS:
> > 
> > +&eqos {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_eqos_rgmii>;
> > +       phy-mode = "rgmii-rxid";
> > +       phy-handle = <&fixed0>;
> > +       status = "okay";
> > +
> > +       fixed0: fixed-link {
> > +               speed = <1000>;
> > +               full-duplex;
> > +       };
> 
> This is just totally botched up.
> 
> "fixed0" is _not_ a PHY, therefore you should NOT be referencing it
> in phy-handle. Please see the DT binding document:
> 
>   phy-handle:
>     $ref: /schemas/types.yaml#/definitions/phandle
>     description:
>       Specifies a reference to a node representing a PHY device.
> 
>   fixed-link:
>     oneOf:
>       - $ref: /schemas/types.yaml#/definitions/uint32-array
>         deprecated: true
> ...
>       - type: object
>         additionalProperties: false
>         properties:
>           speed:
> ...
> 
> As I said, fixed-link is _not_ a PHY, and thus phy-handle must *not*
> be used to point at it.
> 
> The mere presence of a node called "fixed-link" will make this "eqos"
> device use that fixed-link node, and the phy-handle will be ignored.
> 
> So sorry, but as far as your patch goes, it's a hard NAK from me
> right now until the DT description is actually correct.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

Shenwei, the correct way to describe the link between the eQOS and the
SJA1105 port in imx93-11x11-evk-sja1105.dts is:

#include "imx93-11x11-evk.dts"

&eqos {
	/delete-property/ phy-handle;
	clk_csr = <5>;

	fixed-link {
		speed = <1000>;
		full-duplex;
	};

	mdio {
		/delete-property/ ethernet-phy@1;

		/* TJA1102 */
		phy0: ethernet-phy@8 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0x8>;

			phy1: ethernet-phy@9 {
				reg = <0x9>;
			};
		};

		/* TJA1102 */
		phy2: ethernet-phy@e {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0xe>;

			phy3: ethernet-phy@f {
				reg = <0xf>;
			};
		};
	};
};

&iomuxc {
	pinctrl_lpspi8: lpspi8grp {
		fsl,pins = <
			MX93_PAD_GPIO_IO12__GPIO2_IO12  0x3fe
			MX93_PAD_GPIO_IO13__LPSPI8_SIN  0x3fe
			MX93_PAD_GPIO_IO14__LPSPI8_SOUT 0x3fe
			MX93_PAD_GPIO_IO15__LPSPI8_SCK  0x3fe
		>;
	};
};

&lpspi8 {
	fsl,spi-num-chipselects = <1>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_lpspi8>;
	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
	pinctrl-assert-gpios = <&pcal6524_b 3 GPIO_ACTIVE_LOW>;
	status = "okay";

	ethernet-switch@0 {
		reg = <0x0>;
		compatible = "nxp,sja1105q";
		#address-cells = <1>;
		#size-cells = <0>;
		spi-max-frequency = <4000000>;
		spi-cpha;
		status = "okay";

		ethernet-ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				ethernet = <&eqos>;
				phy-mode = "rgmii-id";
				tx-internal-delay-ps = <2000>;
				rx-internal-delay-ps = <2000>;
				reg = <0>;

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};

			port@1 {
				phy-handle = <&phy0>;
				label = "swp1";
				phy-mode = "mii";
				reg = <1>;
			};

			port@2 {
				label = "swp2";
				phy-handle = <&phy1>;
				phy-mode = "mii";
				reg = <2>;
			};

			port@3 {
				label = "swp3";
				phy-handle = <&phy2>;
				phy-mode = "rmii";
				reg = <3>;
			};

			port@4 {
				phy-handle = <&phy3>;
				label = "swp4";
				phy-mode = "rmii";
				reg = <4>;
			};
		};
	};
};

The "mdio" node under "eqos" is just the OF node of the MDIO bus.
It doesn't necessarily mean that the net_device corresponding to the
stmmac uses all those PHYs. It uses just the PHY that it has a
phy-handle to. It may not even have a phy-handle at all, just a
fixed-link, like above.

