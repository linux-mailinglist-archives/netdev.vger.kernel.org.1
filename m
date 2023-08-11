Return-Path: <netdev+bounces-26850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95877937D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94322822FB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F82AB38;
	Fri, 11 Aug 2023 15:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA95692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EAEC433C7;
	Fri, 11 Aug 2023 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691768947;
	bh=HFSuChC49w6nabt+nxfBzErUssKeJ9LDoQh9jdgPbEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvzH50v1+E7Uu4vImDoYHqvF+GAWEChbMQhofNG0xvVf3y7feiK0o9efQclKPdEey
	 almszqXw7hvmZsgz+ZOtBZExFisKp0MAPqJ8FQsusxhEyIjM+1nLqde3odEW8TSX1A
	 VTN5O8bjvziywxBtBtB8lrQA0zx0+2WNZEXey5sLHOekckUjwaaMBllkURznGeKBkn
	 ri4rQcZtq9X1eA8Z6rSRKeqNWvJ3u2/r5UJzewAgbnXxphoIbGKPogfRZBnQvFFPvs
	 r5I523qPywsYbmUBG9vBdwVWmJ+aUcUMhjPdPocBiGbwWaYx8ZuWakX7jjxcTPCsxd
	 uHg2cbyxhShgQ==
Received: (nullmailer pid 3520409 invoked by uid 1000);
	Fri, 11 Aug 2023 15:49:03 -0000
Date: Fri, 11 Aug 2023 09:49:03 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Amit Kucheria <amitk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, David Airlie <airlied@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-pm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/6] dt-bindings: trivial-devices: Remove national,lm75
Message-ID: <169176894187.3520330.14434038424194995552.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-2-alexander.stein@ew.tq-group.com>


On Thu, 10 Aug 2023 16:44:46 +0200, Alexander Stein wrote:
> Starting with commit 3e37c9d48f7a ("dt-bindings: hwmon: Convert lm75
> bindings to yaml") 'national,lm75' has it's own dedicated (YAML) binding.
> If kept in this file device specific properties as 'vs-supply' are
> considered excessive. Remove compatible here so it can be checked with
> more specific binding.
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: sensor@48: 'vs-supply' does not
> match any of the regexes: 'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/trivial-devices.yaml
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Applied, thanks!


