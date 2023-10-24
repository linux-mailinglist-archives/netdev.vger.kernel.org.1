Return-Path: <netdev+bounces-43755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E147D492F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB581C20A65
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4514F9E;
	Tue, 24 Oct 2023 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZhpE6DLR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CCCA51;
	Tue, 24 Oct 2023 08:01:48 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEAA10E;
	Tue, 24 Oct 2023 01:01:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A369E0009;
	Tue, 24 Oct 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698134504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXSyIwNPdYoqMmZdYVydwIght1sBMANhzc18yNPNSho=;
	b=ZhpE6DLRcEXWm+QE6JtlA+DMkRtgI38j1hNa1wJO7zAonXyNCpbkfIdxXMrHA+HuDqFlm1
	7uGf9N1fjDuBD6wZzBLc5T3qAwk78wiyOjppc9aadM2zivjB595m3L1qVQy+VJJrz/trIa
	wdzM5WsxXqhEuzdHLer4P+HGbD/cu6x85IZ4U8XlaBT+pdSKCX5VQGNgmJRixHSzYIIaT5
	g1YF0i9c4YYxrxVWH4KL0C1LowK142P6Tu31SQB6054E7V7kq59DxUR+/+0oGY/6KugXcA
	dEBSBXCc+O5p7R+H7ygfaX3v1LJ7xrYbcu32g7vrot1DOSFrrrG1j7+wsHjenw==
Date: Tue, 24 Oct 2023 10:01:56 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    Vladimir Oltean <vladimir.oltean@nxp.com>, 
    Luka Perkov <luka.perkov@sartura.hr>, 
    Robert Marko <robert.marko@sartura.hr>, Andy Gross <agross@kernel.org>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@somainline.org>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
In-Reply-To: <81d7b86e-aee2-4222-8c7a-52d0b710a2f2@linaro.org>
Message-ID: <ad6b786f-5c06-02ca-2e8b-388692b24c57@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <81d7b86e-aee2-4222-8c7a-52d0b710a2f2@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


Hello Krzystof,

On Mon, 23 Oct 2023, Krzysztof Kozlowski wrote:
[...]
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm IPQ4019 Ethernet switch subsystem driver
> 
> Bindings should be about hardware. Please drop "driver". "Subsystem"
> also sounds like Linuxism.

The "driver" part was a mistake, I will drop it. However, the "subsystem" 
terminology seems relevant here, as the SoC documentation refers to this IP 
group as the "Ethernet Switch Subsystem". If it's okay with you, I'll change 
this to "Qualcomm IPQ4019 Ethernet Switch Subsystem (ESS)" in the v2.

> > +properties:
> > +  compatible:
> > +    const: qca,ipq4019-qca8337n
> 
> 
> What do you want to express here? ipq4019 is not qca. This is Qualcomm
> (so qcom) SoC.
Agreed, I'll change the compatible.

Thanks,

Romain

