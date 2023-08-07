Return-Path: <netdev+bounces-25149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6FA77311C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101D91C20CDA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E8174F9;
	Mon,  7 Aug 2023 21:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C787174EC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:18:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145DE76
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691443106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IoOblYBETmyEulfRzdGlHBsHmabJ0o2kE+I2LBLgwC8=;
	b=fPpp9VWGwUV+YmDUFwqxNykExHWovNpzA8V/rv3Jlpw3g4dIQbHrkeMl4qGe29Go7GwE2A
	ORLezFjmmL+lAXnqps+b7M/MQ8bgVqWjVxvF3Oqtia6jWkEMhZ1gLZgAYj8ZHCBR2RyPo7
	3R2HTWfqg4H9nG2UdBfROtV0wkHSxkA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-8lRj2MbTMpeNrhStAl9g7A-1; Mon, 07 Aug 2023 17:18:25 -0400
X-MC-Unique: 8lRj2MbTMpeNrhStAl9g7A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-763c36d4748so472091785a.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 14:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443104; x=1692047904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoOblYBETmyEulfRzdGlHBsHmabJ0o2kE+I2LBLgwC8=;
        b=EEDotALFW1U5Ve2y5gyKvupk+aiZliPBMYvwytutklTImuzK463fzQCPNvs+9ckO58
         5kJNj4QyYvP2ED39HSGmnNaV+QdfDvrjLBUKD8txyZ5JRla/XRfl6ZIJIfCcIFFV0crs
         n3t68AbU91d6837Uxyd8Ey3mAeJJkDLurRlY/KvyAMrqIef21uSH8VEnOYeoAQ7zMWuA
         T5wzNNejV1aaTBIB7qDnfi3u/Ya6SOpVlmDVjPEaCxKzJwjL8VLydHnCAIrBkKCnw7uX
         kJTG0SpGtr1+gDWXBQwKEiFqTF6WDgBagAmaEoYeHGI+C1OT2xCkjrxi7PZ8BhZ9N8Ts
         Y3ZQ==
X-Gm-Message-State: AOJu0Yw1i7jtEv/Z3pm0aHO7FSH39zj58pCrz/i1sQ43oDWrkSra00wF
	ah5z8wHN1xRwovEBxCD+RLww9K7lecrCC75LAjuK2R7/4I1YkIwnNgBJjQs52u6KVI/XeqyKy/i
	8h2MDweIEAR7OsnvI2I+UhlDR
X-Received: by 2002:a05:620a:4407:b0:76c:5952:7317 with SMTP id v7-20020a05620a440700b0076c59527317mr12231396qkp.3.1691443104335;
        Mon, 07 Aug 2023 14:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJiZ/UaGfvXt9A7FbU4f37zUtzcv+NxPI0dw4fVHbqmXGCPAH9jAsqse5T/ZluBmnq31oYbQ==
X-Received: by 2002:a05:620a:4407:b0:76c:5952:7317 with SMTP id v7-20020a05620a440700b0076c59527317mr12231385qkp.3.1691443104055;
        Mon, 07 Aug 2023 14:18:24 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id pj48-20020a05620a1db000b0076cd5b510f1sm2855141qkn.38.2023.08.07.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:18:23 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:18:21 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sa8775p-ride: add pin functions
 for ethernet1
Message-ID: <3ocnhpal77jmsqabcmnvekk4sqgookk5sunrvb3hstaupqfaj2@whnb7uj6w7ue>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:35:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the MDC and MDIO pin functions for ethernet1 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 09ae6e153282..38327aff18b0 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -480,6 +480,22 @@ ethernet0_mdio: ethernet0-mdio-pins {
>  		};
>  	};
>  
> +	ethernet1_default: ethernet1-default-state {
> +		ethernet1_mdc: ethernet1-mdc-pins {
> +			pins = "gpio20";
> +			function = "emac1_mdc";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		ethernet1_mdio: ethernet1-mdio-pins {
> +			pins = "gpio21";
> +			function = "emac1_mdio";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +	};
> +

With the whole "EMAC0 MDIO handles the ethernet phy for EMAC1", this
doesn't seem to make sense.

I don't have all the schematics, but these pins are not connected from
what I see.


