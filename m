Return-Path: <netdev+bounces-25148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26277310D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08831281598
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775F174F8;
	Mon,  7 Aug 2023 21:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE24432
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:15:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2C1722
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691442934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ye5A6Jw6eWidJwu3XWNBZr93qlVRCWc3OvMx6RGhxc4=;
	b=c3dysyfkHkaXJigafXScLcZqd1tc98TZ5ssV0TJeCeD0aPGJrHRsLVEnJr3RISoD5wU4ae
	1A26UN/lj5Vo1RJgFdDls07W5Zeed0GkZxHWk7HJY5mrpYf9QqtY96ObjNPOwhgSrjK1Mh
	ncCKWLMXwPqxvHm4NtzHYvoJyrzhpvo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638--wLu1dbsPKyoQFCNn7quOw-1; Mon, 07 Aug 2023 17:15:32 -0400
X-MC-Unique: -wLu1dbsPKyoQFCNn7quOw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-768197bad1bso399388185a.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 14:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442931; x=1692047731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye5A6Jw6eWidJwu3XWNBZr93qlVRCWc3OvMx6RGhxc4=;
        b=UX3XTYmt5m9pIZDJU8fMNA55+GHmMtTUrn3FjZyd9ceOX2vmm/mSmOYypgRC6/c38m
         IO6Vjnpe7p8PUuoPjsu/FGGtBVvTfaQvzloXVGx8VTvCS4yZOFqmap0VPCPe/iLOOy3g
         3V6JVF7mS1gE4AKGg61NLJfgb3VHC1mai9uKnB5cYSg9E0V+rlGrZt318ARUY2MntIlD
         YkTmAkGCYjWj2VfSE6HUabKDHKV99UAPTOU1oTf6vKXgjgYqE/0j59U2kNNE5g9Ox193
         qlWl6EBywa9V1p6UXhmaSIY7zICL4W6bK1LCjg9mz/+mmxA1vu7wfihoPqDLijN8+Rhx
         Qydw==
X-Gm-Message-State: AOJu0Yw0FcZP6kf360FvYBe4OgZw2PVDe7xeVLKyC+4YUAY7fGrR7lxY
	gXp9KxRYiElLsRcQSZUvteQow4Wtk6sYQHIp3UCN0FzS/3v4/CoywzHuScIPWZq52roRO7WXhcY
	BYSoxG1s+xzrT4Kbr
X-Received: by 2002:a05:620a:44c6:b0:76c:af3e:3c14 with SMTP id y6-20020a05620a44c600b0076caf3e3c14mr8603223qkp.71.1691442931212;
        Mon, 07 Aug 2023 14:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs6cY258Pte+EWAopO2m1NTOSfKDpS5t4ZtseNKSU54HCauQLwYxyIy58E/V+PpQfupC6BsA==
X-Received: by 2002:a05:620a:44c6:b0:76c:af3e:3c14 with SMTP id y6-20020a05620a44c600b0076caf3e3c14mr8603197qkp.71.1691442930969;
        Mon, 07 Aug 2023 14:15:30 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id oq6-20020a05620a610600b0076d0312b8basm1350731qkn.131.2023.08.07.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:15:30 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:15:28 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sa8775p-ride: enable the second
 SerDes PHY
Message-ID: <adcu2mjmpfnncwfhmwkdwwakk26ob6ee2lwyr4lz32n5zes27r@c6qkjmgoaz53>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:35:01PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the second SerDes PHY on sa8775p-ride development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Matches what I see downstream wrt the supply, so:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index ed76680410b4..09ae6e153282 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -448,6 +448,11 @@ &serdes0 {
>  	status = "okay";
>  };
>  
> +&serdes1 {
> +	phy-supply = <&vreg_l5a>;
> +	status = "okay";
> +};
> +
>  &sleep_clk {
>  	clock-frequency = <32764>;
>  };
> -- 
> 2.39.2
> 


