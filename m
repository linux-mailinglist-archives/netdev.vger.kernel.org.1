Return-Path: <netdev+bounces-25145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55DD7730E9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F802814A3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99FD174EF;
	Mon,  7 Aug 2023 21:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEF174C3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:10:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD0E5B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691442639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0UqcugjS0RccYNXeQE8DX5IYJH0+T9wqvZIkdmfE2c=;
	b=fRdmZ2x5YxRqdxQ3/iRR50ePpLwMgxMVCb7Vh9uY1I4cEiBEwxYtBOmJifT+QOJ6HdXFSR
	1Dd7YREMfc9NbDqg8NjInOlSrlDphFdLUxTVn9UykuwRG2Y1nZ4tk0XhgPnXPxKYZ83K1l
	kjErt8rJhN1gMtuvoysFPBBPboU78UA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-gCUfklrSMeaN4L8jOZW3bQ-1; Mon, 07 Aug 2023 17:10:37 -0400
X-MC-Unique: gCUfklrSMeaN4L8jOZW3bQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63cf5555f69so41445556d6.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442637; x=1692047437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0UqcugjS0RccYNXeQE8DX5IYJH0+T9wqvZIkdmfE2c=;
        b=BEXARhsBamE+ifR2+TijkzAUuzq/VSPVm5gy2xyPAd1u7NFR60BSizmaBdOWK/ALqL
         qC1BWs9N3zZvb+baB9HcaFmVAGQr6jn42wKE38oUB7eDQDAMm7vmqrwo4pKOdRrsMR1D
         MxqWkin6Z2Q8jWLqFj+rtOZOnbyMbPHovQgoj84PZEqYfRBPQ9e+oaIKVglfdVebMzWQ
         jV7brkPzFwtRZ6zNYutwl+lM0tF5gZH0FCZ44jjh619YOejO2SkAMydsHendqKt6uC9c
         cm3mCWT1Fns0gaWT3A5+LZtyXOydOz4y+H6sCtpkO7S3A9wQm2eijAuZYrVoRpaITMnB
         OrEg==
X-Gm-Message-State: AOJu0YyW2ScqFlsZQUXOwjsvxR4u1/KJ4514u51M1q61Q7gfF6hlWEqN
	7rfUpZTXx0TXBzDRCpjRZgwz4HP71sQel1lU6SveW2c0jQ0vyXn6L8MbJY9exgb7r8WkXVuRdoc
	jZf0Oav/O7YPkJ9/9
X-Received: by 2002:a05:6214:5285:b0:637:2eb:6c23 with SMTP id kj5-20020a056214528500b0063702eb6c23mr10940440qvb.18.1691442637343;
        Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+zDgMXaVHPxp5LJzPa58rANcJME3055x5SPbjCrUnzx2WN7zSjd+W5Z5TVRpgxbKxPeoiLw==
X-Received: by 2002:a05:6214:5285:b0:637:2eb:6c23 with SMTP id kj5-20020a056214528500b0063702eb6c23mr10940418qvb.18.1691442637101;
        Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id q15-20020a0cf5cf000000b0063d4631d1e4sm3134431qvm.68.2023.08.07.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:10:36 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:10:34 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sa8775p: add a node for the second
 serdes PHY
Message-ID: <qdagbipfnukpsn5a7f6hswbktrwutizluf3zom2gq6q4q6w6df@h4lkoi3mjzes>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:34:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

FWIW this seems to match downstream sources.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 7b55cb701472..38d10af37ab0 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -1846,6 +1846,15 @@ serdes0: phy@8901000 {
>  			status = "disabled";
>  		};
>  
> +		serdes1: phy@8902000 {
> +			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
> +			reg = <0x0 0x08902000 0x0 0xe10>;
> +			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
> +			clock-names = "sgmi_ref";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
> -- 
> 2.39.2
> 


