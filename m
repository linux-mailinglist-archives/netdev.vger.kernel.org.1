Return-Path: <netdev+bounces-25169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02762773163
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14231C20D64
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF217737;
	Mon,  7 Aug 2023 21:42:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BA174EF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:42:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3561990
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691444522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egEfNuDCQsLqKROh2lnl9MKou5WUYr7YaYDQH/tE4LI=;
	b=Ab+beWyNqlQ50iBqUEbFJrZ9DRCXRWp5GJKT9tMX8RUF7Q416V/gTp4GRoMLPoL6oTCKUX
	nsPVZD+lTNCFBFpNsiMDJGEm/4wG+gbaOvl7iikL6DYsp0/WH/QzwsEIGf2s3KgAV3ZZus
	YiAQbF0sVQlWOvCtFObnUpZ1GHvupZg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Qc-MXBPHMAKoxA285H9_iw-1; Mon, 07 Aug 2023 17:42:01 -0400
X-MC-Unique: Qc-MXBPHMAKoxA285H9_iw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56ccbd1615dso7571995eaf.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 14:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444520; x=1692049320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egEfNuDCQsLqKROh2lnl9MKou5WUYr7YaYDQH/tE4LI=;
        b=iGNBB9xbbc8eFtS0WI3PDOGO/p99SHu7DAfojlIeIz4AkPbfkToqkRrjwBNS8kyHGE
         wcvtgSP9S7lng2swSwbl2z0Rj7ITtUcHcwsuYYs1N9dwVklqcVjbBrdMnFJ7yzQW8gNo
         HrjsmtyBsBsdHm2flByXEVhIAVqSTj3+sqVKFothcidckb/NJYcg1yHjn0n1DddGUH5v
         m/TQzDRGKvdfRjqlIXxTdo6OTop1JIyu682qXFdjbZDBgAddPT+hYgqSbI7OtPVcUuiX
         CJLvMe4klS/rfq9rL84BHfBdkG5eimjnGiRASK3uuAkfVx807yMt8d9a1VOXt7p6xGZK
         9upA==
X-Gm-Message-State: AOJu0YzE0tzAHrqCTUJk4sjLzHMjA6sovLpML5YqA+RKFIaNXhM0w/7+
	oYYloyuz1CkDBWPGIa8r2uB7F/bEn3XqCS2GptKH/mERvmuvm3SBGDXo59UhG/w+u2p9mlXYynO
	1m1W8TRX9R1wVCYvN
X-Received: by 2002:a05:6358:4429:b0:135:a5fe:53e1 with SMTP id z41-20020a056358442900b00135a5fe53e1mr8941590rwc.14.1691444520212;
        Mon, 07 Aug 2023 14:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6cZjmnC7U7J1hQFk8/oMOgrg2mGiHV6bQeg+dmtlvwJQ4+nNS5V86I2xD8n11a+KElJ3Qlg==
X-Received: by 2002:a05:6358:4429:b0:135:a5fe:53e1 with SMTP id z41-20020a056358442900b00135a5fe53e1mr8941581rwc.14.1691444519877;
        Mon, 07 Aug 2023 14:41:59 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t7-20020a0cde07000000b00632191a70aesm3142487qvk.88.2023.08.07.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:41:59 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:41:57 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sa8775p-ride: index the first
 SGMII PHY
Message-ID: <mzluoncplmsjvaohf5jjuencqvevm2sjj6itogt7eof6hskewd@435rhivwyr7g>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-7-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-7-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:35:04PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We'll be adding a second SGMII PHY on the same MDIO bus, so let's index
> the first one for better readability.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 1c471278d441..55feaac7fa1b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -263,7 +263,7 @@ vreg_l8e: ldo8 {
>  
>  &ethernet0 {
>  	phy-mode = "sgmii";
> -	phy-handle = <&sgmii_phy>;
> +	phy-handle = <&sgmii_phy0>;
>  
>  	pinctrl-0 = <&ethernet0_default>;
>  	pinctrl-names = "default";
> @@ -279,7 +279,7 @@ mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		sgmii_phy: phy@8 {
> +		sgmii_phy0: phy@8 {
>  			compatible = "ethernet-phy-id0141.0dd4";
>  			reg = <0x8>;
>  			device_type = "ethernet-phy";
> -- 
> 2.39.2
> 


