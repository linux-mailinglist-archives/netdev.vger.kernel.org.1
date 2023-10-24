Return-Path: <netdev+bounces-43803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F87D4D44
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFC328198B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F161250EF;
	Tue, 24 Oct 2023 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pOadOaly"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AF2421D;
	Tue, 24 Oct 2023 10:05:45 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C5D118;
	Tue, 24 Oct 2023 03:05:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83A512000C;
	Tue, 24 Oct 2023 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698141941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MN831TqYZOpqvXC2XriVIlPZsef8tm9lyCIKQly4bCk=;
	b=pOadOalyRqzNXEzU7qu+TIY9M3RWnqbI1XIgDabGwHefnL2/iZJ5dnjy/XB9TZpY+aMTQt
	9nj8KmYLay3idnZ6x0yErnGA8jbnDsXkCVu8gmVi7SGlbqFQvcxiyGyjqw7vs9H+QacyYF
	Q5hATO6pb+tQgcX9nQ6btGQagj3lDiCemrEDBX+TFzQOrNF+9L8um7f9ADf/9XoPUv+95V
	YBAPArUCTegkCaV1wqC8mwdmxnbawPFaSvUK5woxDHGb83xTHmAfM6euGzNVOpaKqt6ORu
	vniZngFevfyrcP/RP333G5SNFysVCY1rkzuumGLimeKy8GEua2M6mszO6LsoMA==
Date: Tue, 24 Oct 2023 12:05:53 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: Romain Gantois <romain.gantois@bootlin.com>, Rob Herring <robh@kernel.org>, 
    Luka Perkov <luka.perkov@sartura.hr>, 
    Konrad Dybcio <konrad.dybcio@somainline.org>, 
    Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Russell King <linux@armlinux.org.uk>, Andy Gross <agross@kernel.org>, 
    davem@davemloft.net, thomas.petazzoni@bootlin.com, 
    Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, 
    Eric Dumazet <edumazet@google.com>, Bjorn Andersson <andersson@kernel.org>, 
    linux-arm-kernel@lists.infradead.org, 
    Robert Marko <robert.marko@sartura.hr>, 
    Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
    Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm
 IPQESS Ethernet switch
In-Reply-To: <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
Message-ID: <498ee025-b1b7-eafc-3758-993c5d564f67@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <169808266457.861402.14537617078362005098.robh@kernel.org> <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com>
 <550cba92-39dc-4e45-beb3-c714d14d9d85@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Tue, 24 Oct 2023, Krzysztof Kozlowski wrote:

> On 24/10/2023 11:54, Romain Gantois wrote:
> > Hello Rob,
> > 
> > On Mon, 23 Oct 2023, Rob Herring wrote:
> > 
> >> pip3 install dtschema --upgrade
> >>
> >> Please check and re-submit after running the above command yourself. Note
> >> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> >> your schema. However, it must be unset to test all examples with your schema.
> >>
> >>
> > 
> > Even after upgrading dtschema to 2023.9, installing yamllint 1.32.0 and running 
> > without DT_SCHEMA_FILES, I can't seem to reproduce this error. I've also tried 
> > rebasing on v6.5-rc1 which didn't show it either. However, It seems like 
> 
> v6.5-rc1 is some ancient version, so how can you rebase on top of it?
I just cherry-picked this patch series on v6.5-rc1. I also tried v6.6-rc1. Since 
Rob mentionned basing his series on rc1 in his last message, I inferred that he 
compiled the dtb checks on the last kernel rc1, but maybe I misunderstood what 
he meant. 

> 
> Which commit this is based on?

This patch series was based on:

6e7ce2d71bb9 net: lan966x: remove useless code in lan966x_xtr_irq_handler

which was the latest commit in net-next/main at the time. Essentially, the patch 
series is meant to be based on net-next.

Best Regards,

Romain

