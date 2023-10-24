Return-Path: <netdev+bounces-43792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588547D4D02
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7A1C20BA3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276624A15;
	Tue, 24 Oct 2023 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L+Xqh5Fx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853F249FD;
	Tue, 24 Oct 2023 09:54:39 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7866118;
	Tue, 24 Oct 2023 02:54:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B12B1BF20A;
	Tue, 24 Oct 2023 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698141274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6kpnCauGpieWhcMLKeK1rtS0Ofn4S7bu6jwngyl3s0=;
	b=L+Xqh5Fx2hVbFpW0OYWntx/WrCJXy4GXTE0DVdPVQGEU879NpTo2VCtqKl8EecnRz+us/n
	0eD2Ic3DphekNkJwZoe+ZlO94pwlwIDomXT9/GSlERM8WEgEm1YrCjqPIlZVHAI7kgiyhs
	r0GcytSD7vlUQSAMaTYwW+V03QMztxGa47Dr6e/bT96j/6Fgxml91yQ+xUK9LiNDiIs6qy
	LRryjMKU7CT96ixVyiNFy/WS4g+LdKXMsAHFMsj/Scx36mCSgQE+urHwzz3u9U7/bY4sw5
	F40xBEdfI9hKDfjRExeWrretWdk+w4dLhS4xyrpiuD90jSaU7gYi2YY3ct8ezA==
Date: Tue, 24 Oct 2023 11:54:44 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Rob Herring <robh@kernel.org>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
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
In-Reply-To: <169808266457.861402.14537617078362005098.robh@kernel.org>
Message-ID: <35ec9e4b-21ee-1436-da00-02e11effdc23@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-2-romain.gantois@bootlin.com> <169808266457.861402.14537617078362005098.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Rob,

On Mon, 23 Oct 2023, Rob Herring wrote:

> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
> 

Even after upgrading dtschema to 2023.9, installing yamllint 1.32.0 and running 
without DT_SCHEMA_FILES, I can't seem to reproduce this error. I've also tried 
rebasing on v6.5-rc1 which didn't show it either. However, It seems like 
the error is related to the psgmii-ethphy node which I'm planning on 
removing anyway.

Thanks,

Romain

