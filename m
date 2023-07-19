Return-Path: <netdev+bounces-18915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B2759135
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3704E2816AF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B111095A;
	Wed, 19 Jul 2023 09:10:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950910954
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:10:15 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93210B;
	Wed, 19 Jul 2023 02:10:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E6A2E000A;
	Wed, 19 Jul 2023 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1689757811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FJQzHgUn5jtZR7Bvu9wqnoFa2PUx0KKZisBZ3qh5ts=;
	b=CEqBSdpXtoJJIly0zhY3fqAJqW661RVnOreX1YIbR4gVdP3CJAb173FWIwJwzbRQiDs2qt
	JNVQAHDW2a6e3zc28720LFvZ/s7zxqCgBsgisodSemofjr8xMUk3fjvKdbsOaq8OPFvfU+
	gQh96Q+mlHUbyA+BLSiVOx2p9wuAX6ppJIArAky7hnpHhuy9Jipj2DHYqs9ioedS6aSnGF
	Ghoo2ngUykvFdwxxHRQZ4knqIS+jtoCv5szyLB21vOhpwIOBxCKVRILxy90RnHcEOrJ++d
	Ea5+Opu2YzgnjOgGQYTF3oRafHBFa/MQWlu3UBjp965JJ6+IzdC2XC7A3Hh9/Q==
Date: Wed, 19 Jul 2023 11:10:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: i3c: Add mctp-controller
 property
Message-ID: <20230719091009dd6fd57b@mail.local>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
 <20230717040638.1292536-2-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717040638.1292536-2-matt@codeconstruct.com.au>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 12:06:36+0800, Matt Johnston wrote:
> This property is used to describe a I3C bus with attached MCTP I3C
> target devices.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> ---
> 
> v2:
> 
> - Reworded DT property description to match I2C
> 
>  Documentation/devicetree/bindings/i3c/i3c.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
> index fdb4212149e7..b052a20d591f 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> @@ -55,6 +55,12 @@ properties:
>  
>        May not be supported by all controllers.
>  
> +  mctp-controller:
> +    type: boolean
> +    description: |
> +      Indicates that the system is accessible via this bus as an endpoint for
> +      MCTP over I3C transport.
> +
>  required:
>    - "#address-cells"
>    - "#size-cells"
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

