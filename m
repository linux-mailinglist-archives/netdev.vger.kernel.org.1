Return-Path: <netdev+bounces-34451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBDE7A4386
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5971C20C4F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474113AD7;
	Mon, 18 Sep 2023 07:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114A12B8C;
	Mon, 18 Sep 2023 07:53:24 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E11BD0;
	Mon, 18 Sep 2023 00:49:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 192671C0010;
	Mon, 18 Sep 2023 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695023364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq92VItbpebpi+AAk+tulF6SdXTqL6RjdDfqVeDE5xo=;
	b=bKzpDWqL4wy2lgA4oF72ODGz2HbwhnGQ1MHg89SIqXO7C3XMOP5fcypy9OYJIiOXUHsb5p
	b2zZT+/ydnplhw8ng2fhW/q0fazvMIZWGZYS7qC5sclzYVVRnAj/sD4rlWReNMrDelxP9/
	O0r9pe799hmI0Qsq8ISYaFjcHAVPzkL8XlWv75+Gv7/LVaSA2bJfiDSimchGhtKK83n0lv
	tZ8T+QrsO3q2zh5akIaJqMPz7gxPfXwwN+1GRuFO8ap2uLt+yRCgmpRO+1rB908nWufkEl
	esTIJsuZ5+AO+HdzGYxiJ8HKeCoQZPqNgYyM6md7bddOZK1/taiGNAxCxatrlA==
Date: Mon, 18 Sep 2023 09:49:19 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Conor Dooley <conor@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, Simon Horman <horms@kernel.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 25/31] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230918094919.03835d40@bootlin.com>
In-Reply-To: <992a2b31-e21f-eee3-8bfc-a65b69fe5bd7@csgroup.eu>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
	<20230912101444.225809-1-herve.codina@bootlin.com>
	<20230912-overplay-donated-080eb97803d6@spud>
	<992a2b31-e21f-eee3-8bfc-a65b69fe5bd7@csgroup.eu>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christophe,

On Tue, 12 Sep 2023 18:49:26 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 12/09/2023 à 20:13, Conor Dooley a écrit :
> > Yo,
> > 
> > I'm not au fait enough with this to leave particularly meaningful
> > comments, so just some minor ones for you.
> > 
> > On Tue, Sep 12, 2023 at 12:14:44PM +0200, Herve Codina wrote:  
> >> The Lantiq PEF2256 is a framer and line interface component designed to
> >> fulfill all required interfacing between an analog E1/T1/J1 line and the
> >> digital PCM system highway/H.100 bus.
> >>
> >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>  
> > 
> > Missing a co-developed-by?  
> 
> No, I guess it's a left-over of version v4 that I sent-out while Hervé 
> was AFK.
> 
> If a v6 is sent I think this line can be removed.

May I move to reviewed-by ?

> 
> Christophe



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

