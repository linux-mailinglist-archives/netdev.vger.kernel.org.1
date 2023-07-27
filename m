Return-Path: <netdev+bounces-21830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE3764EC5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205FE1C21581
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543EFBEF;
	Thu, 27 Jul 2023 09:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90898467
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:10:11 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F695B92;
	Thu, 27 Jul 2023 02:09:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5973D20002;
	Thu, 27 Jul 2023 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690448995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rK0kgw5LzcKtfaISYOOP5YAwk737ZNSt9k6WE/IR5iU=;
	b=Zwk9FRWmX7HtxhycqPP+GSgdJ/lE0Jsf02fG5eRjCnrnNZdzdBeO3YgnQihx1VtKrAmoHu
	R+0fUpDKNNSvxBL0sOdsfTkUTdxLJcK2e+JZfYc0cSUDB5fpsHtZqGaxUsNmy6IFaMmuiz
	dzpVaJAU0Qm7BptVX7fr77ZTMdjJ+WBVFl1VyLwsAx0VzlYMw72vhsGb6BbtbtId7re+rG
	wdUrJrAqrkpatIxufuuSXEgZH0QIUrPoKcVDJ/w/T9BgSHStT8mQmL1ENohCMeFat8FBGp
	lN6gQStuXkUsJpILuQdCU3oeVTw6XMMCMt/6OO6NPj+uuYPoHKtcIf2ONnIQIg==
Date: Thu, 27 Jul 2023 11:09:48 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230727110948.7926a532@bootlin.com>
In-Reply-To: <20230727-talcum-backside-5bdbe2171fb6@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
	<20230726150225.483464-6-herve.codina@bootlin.com>
	<20230727-talcum-backside-5bdbe2171fb6@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Conor,

On Thu, 27 Jul 2023 09:19:59 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jul 26, 2023 at 05:02:01PM +0200, Herve Codina wrote:
> > The QMC (QUICC mutichannel controller) is a controller present in some
> > PowerQUICC SoC such as MPC885.
> > The QMC HDLC uses the QMC controller to transfer HDLC data.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > new file mode 100644
> > index 000000000000..8bb6f34602d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QMC HDLC  
> 
> "QMC HDLC" seems excessively terse.

The name was based on the fsl,qmc-audio.yaml already present upstream.
  https://elixir.bootlin.com/linux/v6.4/source/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml

If needed, I can change to:
  title: QMC (QUICC Multichannel Controller) HDLC
Let me known if it is better to you.

> 
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to transfer
> > +  HDLC data.
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,qmc-hdlc
> > +
> > +  fsl,qmc-chan:  
> 
> Perhaps I am just showing my lack of knowledge in this area, but what is
> fsl specific about wanting a reference to the channel of a "QMC"?
> Is this something that hardware from other manufacturers would not also
> want to do?

The QMC and the QMC channel are something specific to the SoC. This IP is only
available on some Freescale/NXP SoCs.

When I upstreamed the 'fsl,qmc-audio.yaml', I first used a generic name for this
property and Kristoff asked to change to a vendor prefixed name.
  https://lore.kernel.org/linux-kernel/1dfade07-f8c4-2e16-00dc-c7d183708259@linaro.org/

Based on this, as the property 'fsl,qmc-chan' has the exact same meaning in
fsl,qmc-audio.yaml and fsl,qmc-hdlc.yaml, I use the same name.

Best regards,
Hervé

> 
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to QMC node
> > +          - description: Channel number
> > +    description:
> > +      Should be a phandle/number pair. The phandle to QMC node and the QMC
> > +      channel to use.
> > +
> > +required:
> > +  - compatible
> > +  - fsl,qmc-chan
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    hdlc {
> > +        compatible = "fsl,qmc-hdlc";
> > +        fsl,qmc-chan = <&qmc 16>;
> > +    };
> > -- 
> > 2.41.0
> >   

