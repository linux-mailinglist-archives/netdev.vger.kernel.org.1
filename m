Return-Path: <netdev+bounces-25172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3498773199
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AFB280F97
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A12717743;
	Mon,  7 Aug 2023 21:48:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C185174EF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:48:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4FF109
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691444882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHEXVCywwxnL3+xyJJPUcqccsbZsOMWnhPL9+GXNqy4=;
	b=eglAUR3THlm/2Vz+uHC7tOHkoZP0mBhs4NbpsQ0Vhe/xD5mu85Cl5YNGecg6bPTtPB6I+a
	dXQcjvVOBSFXxLjtFH2ZolekEE4intnDPnzL76Jq6mNQvmLC1qNXyQC7Z0Od2k0fKL3wHU
	EeBCXX2Bmp2xyB8qGriMOfq/odAZt/U=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-YgjALCJFN-W4REDI_3dvtg-1; Mon, 07 Aug 2023 17:48:00 -0400
X-MC-Unique: YgjALCJFN-W4REDI_3dvtg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56d2cebf66aso7767490eaf.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 14:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444880; x=1692049680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHEXVCywwxnL3+xyJJPUcqccsbZsOMWnhPL9+GXNqy4=;
        b=ctlWdAgH8NNty4XScjEmBSQLFWV6GfM+MW6My13NIoh1gmwgcQXYHgmyKJPp/nHxKT
         Af5Jzfl9FYc8C9Qgoovu2ik31TKSwLaPPFrovs8umu2O5wzbw+n7msYvcNl4pzLTms5K
         X8MRIGn0dSYqyURuUAkNxQxqem//QrjraHPBk1zfv83yEKLdyDccw7q3o+m/VYawcUl5
         IwbL2gzGC04c/YbBP9+NsGnJgTkrcekKsrlnKyqpejRM6dnd7HSG4WPDRuNclQdfKjaU
         m7ZnZDLjC99x6UOJqsv3fOKLxakHC1FQLxN6g1kW+nIXwzoWuJHv9o4C0jVmUTcIlcHg
         WVaw==
X-Gm-Message-State: AOJu0YwmqE6mnNWJ9mh8+OnxRgo8vJ5Eo3P5YhMLaTpxppIAj5xjPKcP
	7rWS2fZmpj1DOsjx2kgzbZWBNjvoeNHb3UJ2iEX3OVeMExnCCNVhZkyyzG8kfBODNAjgEmaewpy
	FJC2fN01tYKtvVibR
X-Received: by 2002:a05:6358:8820:b0:135:3e6b:8430 with SMTP id hv32-20020a056358882000b001353e6b8430mr11287214rwb.5.1691444878687;
        Mon, 07 Aug 2023 14:47:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEjnWBGNLEZDCFW3+e9y490mH2qbmOyX+eUDEAeyBj1lYQvhcrGVAH+Gk1Lc+uBPgQg5MM8g==
X-Received: by 2002:a05:6358:8820:b0:135:3e6b:8430 with SMTP id hv32-20020a056358882000b001353e6b8430mr11287200rwb.5.1691444878415;
        Mon, 07 Aug 2023 14:47:58 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a121100b00767fbfea21dsm2895439qkj.69.2023.08.07.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:47:57 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:47:55 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sa8775p-ride: add the second SGMII
 PHY
Message-ID: <7uf7bii3tuejqocnka4wsa5zdys5vnhjretuj66eikgo3if5tl@mga2qbyqdim7>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-8-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-8-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:35:05PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a second SGMII PHY that will be used by EMAC1 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 55feaac7fa1b..5b48066f312a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -286,6 +286,14 @@ sgmii_phy0: phy@8 {
>  			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
>  			reset-deassert-us = <70000>;
>  		};
> +
> +		sgmii_phy1: phy@a {
> +			compatible = "ethernet-phy-id0141.0dd4";
> +			reg = <0xa>;
> +			device_type = "ethernet-phy";
> +			reset-gpios = <&pmm8654au_2_gpios 9 GPIO_ACTIVE_LOW>;
> +			reset-deassert-us = <70000>;
> +		};

This is connected to the (another) Marvell 88EA1512. I mentioned in the
earlier patch for sgmii_phy0 that you dropped the reset-assert-us.

Unless there was a reason for that, I suspect you want to add it here
too.

Otherwise the description matches the bit of schematic I have access to.

Thanks,
Andrew


