Return-Path: <netdev+bounces-29368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39353782F3F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFDE280E08
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78B8C05;
	Mon, 21 Aug 2023 17:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76250748D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4524C433C8;
	Mon, 21 Aug 2023 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692638083;
	bh=MH0wQLIkGLHxG2U7ZihHzC9EFeKAg1wwbkNonW9+XmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlLRBRlXU3TpIsrE1LNM4eOtfxC+6aFHGYBH060E6Qw4p3+SZfOLXGNYYik8y2DWR
	 oI6LJ8ANM5iIvFhjpKnWrII6XRSSJN1G70BkaqgWhl9U1D15Kgt6oDUIDMF5suE2vl
	 /tVHdi67TSjo+yLa5BL53T+JWWyIEgsOHKYl3U4qSDp2e6JhjUqJVQgCrEIok1T0LT
	 Jrl6o2rF9Mq3eYWQRr4v45EMGMTrXS0XfLcGVlqve59tAi+e0l1aqUnLhcH5iK20EE
	 ZnerxQ9HY7A0CPw6ryh604PXvajLCmPMz8FRUzMZAD1mKWwveFBymOBTkxINkYhOOp
	 HPPDVM//gRGYA==
Received: (nullmailer pid 1978426 invoked by uid 1000);
	Mon, 21 Aug 2023 17:14:39 -0000
Date: Mon, 21 Aug 2023 12:14:39 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Eric Dumazet <edumazet@google.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: net: microchip: Allow nvmem-cell usage
Message-ID: <169263807888.1978386.16316859459152478945.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-5-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-5-alexander.stein@ew.tq-group.com>


On Thu, 10 Aug 2023 16:44:49 +0200, Alexander Stein wrote:
> MAC address can be provided by a nvmem-cell, thus allow referencing a
> source for the address. Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: ethernet@1: 'nvmem-cell-names',
>  'nvmem-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


