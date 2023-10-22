Return-Path: <netdev+bounces-43293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE47D23C9
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AE51C208C5
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260410782;
	Sun, 22 Oct 2023 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMmP6Zto"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849051094D
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 15:52:17 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB95B4
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 08:52:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so2365068b3a.0
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697989935; x=1698594735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9YYJ0xeR12CjS4RheaJo5V7O1DXA2irz7hax5XTAEFU=;
        b=bMmP6Ztox8hXM0wB+1oquXjepGUtaJQS1RMl/YsQ5YzskqPqmBp/Ewolpcow+wuOKt
         zvA4t3x8maXiFDAhe4DMJBWBEFBI8yE8zsm8f4wbsX/OZxTkciCnSkwzEJhlrjDXJiX4
         045uAZ93/q5DXOe4MBCw7DuglSgetC7T2Bqpga7ufH3Gl8R5d8gDb7acJeoO9Aj3ZesB
         u26TTK/JslM1Tw1sOcnPo/eKUG6LDFCGyo9ZhwlG+ShjOPwd/MpcSY9zVyFDoAC15Xvs
         Yf3+a3al2Wk2baKGgRdD5K2p2iQxvwvaid93fgrgvIt9nCs0D+xtwDPuTMQKwoi88Iug
         y91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989935; x=1698594735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YYJ0xeR12CjS4RheaJo5V7O1DXA2irz7hax5XTAEFU=;
        b=kEVOtAfRFe7tQpVLaENTd3QZzyPoCTkUUILCLRAbT0YTvM4lXIbI6LsxW28aGfPMUP
         MtFnQOnfOWP+mxbBNGpLbghjuBE+/TJdrPsBrG1Z9DXDYYTcL97sYn2NNg4rSPoY1MLb
         a0emcsUvwnUG+iRmdlsCxRF3EsNOzHnoIPLVWiBuI+KHhD4fpJvc0ZgU9fuMwWbf7mjo
         6XSpL3Zz+zUoLqXKO4Rsq1oy7ZDHjZLL1ai5mWNnKnB+iiwShx18UZ65+xk9Hf1TwlI0
         sdzviKmTTowthPUjsn0l8WPZeAxWTVD6AWf1CNOnNoBN8VzY0Gy9thtOq5TPpmOOTW90
         wjaQ==
X-Gm-Message-State: AOJu0Yx0sJSPBTjJGF1zsYG8Nt83yHavLyWbeC/+AquP+Vmus1XDacSQ
	7+WEySPK1domn0eA35LRTmcCYEmDXjA=
X-Google-Smtp-Source: AGHT+IFPeY+GJP3UfuU4CfR5D1285pk7/tstwYbu0lwIHsBl2VqYGh80S2bYT4DHuT2b8iUFL2jSMg==
X-Received: by 2002:a05:6a20:5487:b0:169:7d6f:9f22 with SMTP id i7-20020a056a20548700b001697d6f9f22mr10068088pzk.54.1697989935397;
        Sun, 22 Oct 2023 08:52:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b006be4bb0d2dcsm4861524pfr.149.2023.10.22.08.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 08:52:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e209398-3262-da47-1f6c-aa6fdab8a22f@roeck-us.net>
Date: Sun, 22 Oct 2023 08:52:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/8] bnxt_en: Fix invoking hwmon_notify_event
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gospo@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
References: <20231020212757.173551-1-michael.chan@broadcom.com>
 <20231020212757.173551-3-michael.chan@broadcom.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231020212757.173551-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/23 14:27, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> FW sends the async event to the driver when the device temperature goes
> above or below the threshold values.  Only notify hwmon if the
> temperature is increasing to the next alert level, not when it is
> decreasing.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 7837e22f237b..65092150d451 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2166,6 +2166,7 @@ static bool bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>   	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD: {
>   		u32 type = EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1);
>   		char *threshold_type;
> +		bool notify = false;
>   		char *dir_str;
>   
>   		switch (type) {
> @@ -2185,18 +2186,23 @@ static bool bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>   			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
>   			return false;
>   		}
> -		if (EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1))
> +		if (EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1)) {
>   			dir_str = "above";
> -		else
> +			notify = true;
> +		} else {
>   			dir_str = "below";
> +		}
>   		netdev_warn(bp->dev, "Chip temperature has gone %s the %s thermal threshold!\n",
>   			    dir_str, threshold_type);
>   		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
>   			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
>   			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
> -		bp->thermal_threshold_type = type;
> -		set_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event);
> -		return true;
> +		if (notify) {
> +			bp->thermal_threshold_type = type;
> +			set_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event);
> +			return true;
> +		}
> +		return false;
>   	}
>   	default:
>   		netdev_err(bp->dev, "FW reported unknown error type %u\n",


