Return-Path: <netdev+bounces-31084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9940978B4AB
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED87280D77
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F2134C5;
	Mon, 28 Aug 2023 15:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22575134A6
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5C5C433CA;
	Mon, 28 Aug 2023 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693237392;
	bh=l8mBaaM0TYGsK1UM6qYwETDaYnQ3tF3yQqXH6gOzhUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvZr7SMb2mlcEp9LwRjxXi9L36v182tEh1ALZPEzGhL1DI1Ps5MvKmIpbEz4ziNv0
	 Zq+dRtBIiuJd+n05fYVBQ6fW2sAYKSWgz3juJa/cap98jplL2aBtVMzNTnHIjF8iGR
	 wNTLz5GuLPU8J+SA69h+y7vtsxYyRh+v1VpdNKLJlHyNqFrHKLIDfNp26e7/Xjx9/7
	 xYAWGSGNOVN5fQvpY7qm29DYJfMTsAiUmeuMbeZWAu9iwwohsTj9x5DsgNwhdhS0h3
	 y2PsKJM11T8bYUNwu9xjCeYBDaeDWHHR1zEWw0m856BxiKMICiErNGNocG2oRLI+9b
	 DK1mrVWJXcCBg==
Received: (nullmailer pid 607773 invoked by uid 1000);
	Mon, 28 Aug 2023 15:43:09 -0000
Date: Mon, 28 Aug 2023 10:43:09 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Goud <srinivas.goud@amd.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, appana.durga.rao@xilinx.com, naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Message-ID: <20230828154309.GA604444-robh@kernel.org>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>

On Mon, Aug 28, 2023 at 08:28:43PM +0530, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
> 
> xlnx,has-ecc is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
> 
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v3:
> Update commit description
> 
> Changes in v2:
> None

Doesn't apply, dependency?

> 
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..c842610 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN Tx and Rx fifo ECC enable flag (AXI CAN)

has ECC or enable ECC?

> +
>  required:
>    - compatible
>    - reg
> @@ -137,6 +141,7 @@ examples:
>          interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>          tx-fifo-depth = <0x40>;
>          rx-fifo-depth = <0x40>;
> +        xlnx,has-ecc

Obviously not tested.

>      };
>  
>    - |
> -- 
> 2.1.1
> 

