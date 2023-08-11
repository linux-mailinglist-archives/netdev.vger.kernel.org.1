Return-Path: <netdev+bounces-26814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2C77912F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A98F1C2167D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330129DF5;
	Fri, 11 Aug 2023 14:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AC63B3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24B3C433C7;
	Fri, 11 Aug 2023 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691762458;
	bh=C4cXeWQX/r0IzEoOEZ08WLIpkcXhN7kt7P6JcA2SsfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rjOirqlUfvyMrYGK2PVWBJ5zUsGe2FKOjHY1dp1jcP9Za9VNrHnzeLPV7j1s1GKa1
	 pnp1TVUnexW5wXbSCI3Uk3aG2vO8T4NzWCjTg3lJK8GOE2Ino+Ns0Y/bKJM3NavB2d
	 3iUhkptkfGP3N80QGn989MfZaaFKYrBXKHxS/3AgluHVulS8sMU19qP0/juWN2eCCY
	 DRFczAh/0LRrjffN/6Wp78U0yrotycsm4dPQ5UJL878xSXCDzRFY+d6EZFHZXMjbS9
	 cuExJx9o92mxn5k/NIJeQDrfDBE/26mqajanE/DM4vYlIGsPLyiz2hHJqA/dR5sOLK
	 H24h7Nxq2gFqQ==
Received: (nullmailer pid 3322998 invoked by uid 1000);
	Fri, 11 Aug 2023 14:00:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Amit Kucheria <amitk@kernel.org>, linux-arm-kernel@lists.infradead.org, Pengutronix Kernel Team <kernel@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, netdev@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20230810144451.1459985-3-alexander.stein@ew.tq-group.com>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-3-alexander.stein@ew.tq-group.com>
Message-Id: <169176235704.3319932.12605780111430379869.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: imx-thermal: Add
 #thermal-sensor-cells property
Date: Fri, 11 Aug 2023 08:00:55 -0600


On Thu, 10 Aug 2023 16:44:47 +0200, Alexander Stein wrote:
> This property is defined in thermal-sensor.yaml. Reference this file and
> constraint '#thermal-sensor-cells' to 0 for imx-thermal.
> Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: tempmon:
>  '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: tempmon: '#thermal-sensor-cells' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810144451.1459985-3-alexander.stein@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


