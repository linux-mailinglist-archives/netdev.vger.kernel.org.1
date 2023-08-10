Return-Path: <netdev+bounces-26301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A77776C7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9922B28202E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527611F945;
	Thu, 10 Aug 2023 11:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661E1DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230AFC433C7;
	Thu, 10 Aug 2023 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691666494;
	bh=7oqbOFzXbh/vqK1FPdNCgosNW6N8CQUMa/xCbP8Mwpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BFbpuNXAHyl3NEzENNYsswEB2SmoN+KgODBWHLn9jvjgKexkq92M4bz8XFyqxAyWO
	 dNW3upmsdARUZEriqD6zlzQMTWzGL3t+j+5TyTrxhCwtDV+Lj8l6vIiJERbgNNVr0I
	 /Lqd/3C5nnq3xu6PS8hW28kFywncaQevY+H/NLCFqBDUG3wwMXdSJajV23bc0AscE1
	 qT4cvdUm1j0mmUpPV35VkovZlXWMwXlX5XNYaeAWLZrmlz6Y1uxGINotF8kOzU+E2T
	 zpG/9ApkVbBqfzo0uIUXL4mik8TIZPPYqxnCetXhixrr1HdRognSoR6jsCh/khy2Hk
	 NFQSaRYnwL3xw==
Received: (nullmailer pid 64579 invoked by uid 1000);
	Thu, 10 Aug 2023 11:21:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, conor+dt@kernel.org, linux@armlinux.org.uk, devicetree@vger.kernel.org, luka.perkov@sartura.hr, hkallweit1@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org
In-Reply-To: <20230810102309.223183-1-robert.marko@sartura.hr>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
Message-Id: <169166649202.64563.6248344012653953343.robh@kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller:
 add PSGMII mode
Date: Thu, 10 Aug 2023 05:21:32 -0600


On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> Add a new PSGMII mode which is similar to QSGMII with the difference being
> that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.
> 
> It is commonly used by Qualcomm on their QCA807x PHY series.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810102309.223183-1-robert.marko@sartura.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


