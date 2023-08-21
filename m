Return-Path: <netdev+bounces-29369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BA782F43
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DD81C2093B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679E8C06;
	Mon, 21 Aug 2023 17:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC28C05
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B5EC433C7;
	Mon, 21 Aug 2023 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692638114;
	bh=moX1NDNRIw8jZEhzXh/VvYgaJynBFa9IjTOZmpRM6FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5rju92Kh4lU1L6z7wg4kSVd4xT8r5IdF27ap5RgXT+Wmwqn0nrXtUDMvXoUV2Nki
	 VQ77gyf8z+mOXIpJrmDz/JLWHR0WmGyzsGyMx9T8bBZv824ueq3mz8Q66PwZ3LQZ6B
	 gIw7B449eeVOthZaIIXXULOK4PWSlsc8SUJbuBRrNZM1klN9hmgXFJc4M+izI4sN82
	 6d0O8vPFRKUxhbnQDDqNd7xGVoulVygoTeWMuu62k0vU0RiQIOlqdvIaWD+4o5Eghs
	 fG+jH8Xrdf5M4vUO6nJlGaW/9ayMH8OHSGdeNscOFgcba7ZXUS9tP2sN20+81u3iyv
	 EoOFuyKK3VpMQ==
Received: (nullmailer pid 1979228 invoked by uid 1000);
	Mon, 21 Aug 2023 17:15:11 -0000
Date: Mon, 21 Aug 2023 12:15:11 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>, Eric Dumazet <edumazet@google.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org, Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/6] dt-bindings: timer: add imx7d compatible
Message-ID: <169263811048.1979170.9429510140636771779.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-6-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-6-alexander.stein@ew.tq-group.com>


On Thu, 10 Aug 2023 16:44:50 +0200, Alexander Stein wrote:
> Currently the dtbs_check for imx6ul generates warnings like this:
> 
> ['fsl,imx7d-gpt', 'fsl,imx6sx-gpt'] is too long
> 
> The driver has no special handling for fsl,imx7d-gpt, so fsl,imx6sx-gpt is
> used. Therefore make imx7d GPT compatible to the imx6sx one to fix the
> warning.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


