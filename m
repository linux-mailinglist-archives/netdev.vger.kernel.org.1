Return-Path: <netdev+bounces-34297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E57A30D4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D46F28228D
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D7814011;
	Sat, 16 Sep 2023 14:12:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0776134;
	Sat, 16 Sep 2023 14:12:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBB0F3;
	Sat, 16 Sep 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iq/W51Y4PxUlSBTcu/iv8S9S3cNOF7EA7rKpAuqy3m4=; b=l+
	LgtV3mC3yhVy+zseGZM6l+IdmqmeMED7oVT+p+/UFdrRAPMQ7LWfkQSqe6Gv5ZTL9dVo+7C9t/+J6
	g/ByW7FImJdEF53tNjILNlBwPxKG+bnbzIpbWreiTpWL5yoIi5yj5Bos0lczftgDDepnO+c5mXv/v
	JeikwBSqndzczKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhW1L-006dk3-Dh; Sat, 16 Sep 2023 16:11:39 +0200
Date: Sat, 16 Sep 2023 16:11:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	George McCollister <george.mccollister@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Marek Vasut <marex@denx.de>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	John Crispin <john@phrozen.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/10] dt-bindings: net: dsa: define MDIO bus
 child node
Message-ID: <445beba8-2499-44a3-9c36-b9ec761121fb@lunn.ch>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-6-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230916110902.234273-6-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 02:08:57PM +0300, Arınç ÜNAL wrote:
> Some DSA subdrivers register the MDIO bus of the switch they control. Or
> let the DSA driver register the MDIO bus. The node for these buses are
> either required or optional, depending on the subdriver. Document this on
> all of the affected DSA switch schemas.
> 
> The attributes of a DSA subdriver that lets the DSA driver register the
> bus:
> - ds->ops->phy_read() and ds->ops->phy_write() are present.
> - ds->slave_mii_bus is not populated by the DSA subdriver.
> - The bus is registered non-OF-based or OF-based. Registered OF-based if
>   "mdio" child node is defined.
> 
> The affected DSA switch schemas are documented below.
> 
> - brcm,b53.yaml
> 
> drivers/net/dsa/b53/b53_common.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> ---

git uses --- to separate the commit message from additional comments
for the reviewers. Anything after the --- will not be merged. Is that
your intention?

     Andrew

