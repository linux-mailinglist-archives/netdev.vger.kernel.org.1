Return-Path: <netdev+bounces-35488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617F7A9B53
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696421C20BD9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EEE4735E;
	Thu, 21 Sep 2023 17:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5E41233;
	Thu, 21 Sep 2023 17:49:23 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A8880B5;
	Thu, 21 Sep 2023 10:38:50 -0700 (PDT)
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EAB5BC0A2F;
	Thu, 21 Sep 2023 11:38:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18E4AFF809;
	Thu, 21 Sep 2023 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1695296310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg1KwFh5lSvkfLStS1akS234BD88W219/y2jE+qO6JQ=;
	b=FB+WZwNSKjLpXhOD9eu3aYO9S6xv7RKPVKfQqt6Yyak4R0XVc2bs16R2Ke/+V/3txgPjPr
	wNyBzW42Tn7VAFs2jhEpLj1G9U6dnj08SGVZCzFzU+kN0/r6dBMoRCU2I1O3Q8xtwIolig
	xJ1YEEOth0NiXYYwOeMIAC90CHeyPQYQTN1YQTfV6AKvrznfMYMqllejuEeIHK1xAQoq7D
	B2wVQWekSUN/HVPKuTr+U8nV6amDRMGb5hUj07YiP5dfthswJzspcJcvSs0Fc397s1bG45
	3KvHozxpJJGdRulhdH2AcaicpASeaoEDTfZJ6ynuWsTayDIRxLyeQVsxkaRHLg==
Message-ID: <16710cf9-8911-4fed-8e2d-b19b581446c1@arinc9.com>
Date: Thu, 21 Sep 2023 14:38:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 George McCollister <george.mccollister@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Marek Vasut <marex@denx.de>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 John Crispin <john@phrozen.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Oleksij Rempel <linux@rempel-privat.de>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 Shyam Pandey <radhey.shyam.pandey@xilinx.com>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
 <20230918181319.GA1445647-robh@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230918181319.GA1445647-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.09.2023 21:13, Rob Herring wrote:
> On Sat, Sep 16, 2023 at 02:08:59PM +0300, Arınç ÜNAL wrote:
>> Phylink bindings are required for ethernet controllers that utilise
>> phylink_fwnode_phy_connect() directly or through phylink_of_phy_connect(),
>> and register OF-based only MDIO buses, if they register any.
> 
> What is phylink?
> 
> Don't describe/justify binding changes based on some Linux functions.

I'd like to discuss the influence of the Linux drivers on the devicetree
bindings. Before that let me clarify these "phylink" bindings. They are
certain rules to properly describe the link of the ethernet controller. Any
of the phy-handle, pcs-handle, sfp, and fixed-link properties describe the
link. They are already defined on ethernet-controller.yaml, just not
enforced.

Why I called them phylink bindings, is because when phylink is used on the
ethernet controller driver, only then we can be sure that the link
descriptions on the ethernet controller are needed. Because, some drivers
don't need the link descriptions on the ethernet controller as they can
search a certain MDIO bus to find and connect a MAC to a PHY or set up a
fixed link without looking at the devicetree.

I don't like this approach because, as you said, devicetree bindings should
describe the hardware, not driver policies. So I propose that we don't let
Linux drivers interfere with dt-bindings. To that extent:

- Link descriptions must be required on ethernet controllers. We don't care
   whether some Linux driver can or cannot find the PHY or set up a fixed
   link without looking at the devicetree.

- The MDIO bus description on an ethernet controller describes that the
   hardware comes with an MDIO bus. The MDIO property is optional not
   because some Linux driver can find and map the PHYs to MACs without DT
   descriptions but because the hardware doesn't have to use that or any
   MDIO bus.

Let's also talk about the elephant in the room: DSA bindings. Distributed
Switch Architecture is a Linux subsystem, not a hardware property.
Devicetree bindings are supposed to describe the hardware, yet we have
bindings specifically for DSA so that the DSA driver can properly control
the hardware.

Although I see dsa.yaml and dsa-port.yaml mostly consist of describing an
ethernet switch with CPU port(s), there're properties that are specific to
DSA, such as dsa,member on dsa.yaml and dsa-tag-protocol and label on
dsa-port.yaml.

Depending on how I get responses, I will address my patches. Then I can
further discuss the DSA bindings.

Arınç

