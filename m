Return-Path: <netdev+bounces-43292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A47D23C8
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A842CB20D12
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3721F517;
	Sun, 22 Oct 2023 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0sbPONC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0271094D
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 15:52:04 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFFA7
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 08:52:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so2364961b3a.0
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697989922; x=1698594722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cb81j50At9+5JKEab6xUzazvRpsBtrLMm/6X3nBa6Po=;
        b=B0sbPONCSAJX1170msYQyKIV0hMXJhb79g1SXQGR6/wt7xzOS3E/NebPKBMV/+hy7o
         HF0ihnBmjNmMYlOsFQJqHt2crsZOnNLmc/J950uRWB2xUDxQ1gMxmcMujX6POUwvBWCp
         jUDyaGPONUYuf+uzxprielEGMwxH8ccgi4rs84KoHdxsEqZVV3pZabWLg55S0H3hCHq3
         j+KN/63A8nSELORPA2gQCjpJWf9zWxe+zYq0ejs9iRRYH6CaEC/EQC7AI0ZrMbQeGT5e
         wUaHtwV+nrktsNJBpmRcsVYRIkQRQ07Ti7JhOgR98S0P4P/5njpaBdkBfdNSsS7ZNboX
         Zymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989922; x=1698594722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb81j50At9+5JKEab6xUzazvRpsBtrLMm/6X3nBa6Po=;
        b=rp8a/g15uzjxt7pTeTFv4sonAKu/BZgdYzZA00dzmFo+7e79jhe0Uk0vJ8MdJJVkv/
         hyhkXTYOIZPW7XMdtpnNE87g+RPXEDYS12FqHGXSFMoafl5LrJYGsLOJ3FbBZyD4XrJx
         jNoMsNRrZMsKhUe3I39HbmWA1KJVVKYAkH11NaItg1tpTX33L4Whu8QZ3v92qy9ba7WD
         +fvEjgMuuR2iZj4BtLp5Orp26OLFiW4YMP/MUwE6Wd3870RxKIoiVoe3EmlznRe+sJUc
         fQVuQz5i4rLC6cUw/7SzhXSYAyic+Hq1jAkYTlX3aZ8eKRHip/NjAOG6DVMt+0xnT9um
         BY2A==
X-Gm-Message-State: AOJu0YyHJaprUoPyGbCJx/UlLUjJgnp7JKfhsbWxcFU80UEPBPBa+SuY
	kotnkLSLEAeRA03SiFnlsbw=
X-Google-Smtp-Source: AGHT+IG2GwAfYXWcQ2jmxvO7hFYCiwOSqCX1kP/A1QxsT7lpZfcV3GiN9K8fv9Rqqe888L4UzqfwRQ==
X-Received: by 2002:a05:6a21:7882:b0:137:74f8:62ee with SMTP id bf2-20020a056a21788200b0013774f862eemr9266294pzc.18.1697989921980;
        Sun, 22 Oct 2023 08:52:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090ad31400b00274b9dd8519sm4324076pju.35.2023.10.22.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 08:52:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3102fdc7-ef2c-37c4-e9f6-ea5c85d2541c@roeck-us.net>
Date: Sun, 22 Oct 2023 08:51:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/8] bnxt_en: Do not call sleeping
 hwmon_notify_event() from NAPI
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gospo@broadcom.com, kalesh-anakkur.purayil@broadcom.com
References: <20231020212757.173551-1-michael.chan@broadcom.com>
 <20231020212757.173551-2-michael.chan@broadcom.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231020212757.173551-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/23 14:27, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Defer hwmon_notify_event() to bnxt_sp_task() workqueue because
> hwmon_notify_event() can try to acquire a mutex shown in the stack trace
> below.  Modify bnxt_event_error_report() to return true if we need to
> schedule bnxt_sp_task() to notify hwmon.
> 
>    __schedule+0x68/0x520
>    hwmon_notify_event+0xe8/0x114
>    schedule+0x60/0xe0
>    schedule_preempt_disabled+0x28/0x40
>    __mutex_lock.constprop.0+0x534/0x550
>    __mutex_lock_slowpath+0x18/0x20
>    mutex_lock+0x5c/0x70
>    kobject_uevent_env+0x2f4/0x3d0
>    kobject_uevent+0x10/0x20
>    hwmon_notify_event+0x94/0x114
>    bnxt_hwmon_notify_event+0x40/0x70 [bnxt_en]
>    bnxt_event_error_report+0x260/0x290 [bnxt_en]
>    bnxt_async_event_process.isra.0+0x250/0x850 [bnxt_en]
>    bnxt_hwrm_handler.isra.0+0xc8/0x120 [bnxt_en]
>    bnxt_poll_p5+0x150/0x350 [bnxt_en]
>    __napi_poll+0x3c/0x210
>    net_rx_action+0x308/0x3b0
>    __do_softirq+0x120/0x3e0
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: a19b4801457b ("bnxt_en: Event handler for Thermal event")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 17 ++++++++++++-----
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  2 ++
>   drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c |  4 ++--
>   drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h |  4 ++--
>   4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 16eb7a7af970..7837e22f237b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2147,7 +2147,8 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
>   	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR) ==\
>   	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING)
>   
> -static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
> +/* Return true if the workqueue has to be scheduled */
> +static bool bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>   {
>   	u32 err_type = BNXT_EVENT_ERROR_REPORT_TYPE(data1);
>   
> @@ -2182,7 +2183,7 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>   			break;
>   		default:
>   			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
> -			return;
> +			return false;
>   		}
>   		if (EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1))
>   			dir_str = "above";
> @@ -2193,14 +2194,16 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>   		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
>   			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
>   			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
> -		bnxt_hwmon_notify_event(bp, type);
> -		break;
> +		bp->thermal_threshold_type = type;
> +		set_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event);
> +		return true;
>   	}
>   	default:
>   		netdev_err(bp->dev, "FW reported unknown error type %u\n",
>   			   err_type);
>   		break;
>   	}
> +	return false;
>   }
>   
>   #define BNXT_GET_EVENT_PORT(data)	\
> @@ -2401,7 +2404,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
>   		goto async_event_process_exit;
>   	}
>   	case ASYNC_EVENT_CMPL_EVENT_ID_ERROR_REPORT: {
> -		bnxt_event_error_report(bp, data1, data2);
> +		if (bnxt_event_error_report(bp, data1, data2))
> +			break;
>   		goto async_event_process_exit;
>   	}
>   	case ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE: {
> @@ -12085,6 +12089,9 @@ static void bnxt_sp_task(struct work_struct *work)
>   	if (test_and_clear_bit(BNXT_FW_ECHO_REQUEST_SP_EVENT, &bp->sp_event))
>   		bnxt_fw_echo_reply(bp);
>   
> +	if (test_and_clear_bit(BNXT_THERMAL_THRESHOLD_SP_EVENT, &bp->sp_event))
> +		bnxt_hwmon_notify_event(bp);
> +
>   	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
>   	 * must be the last functions to be called before exiting.
>   	 */
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 9ce0193798d4..80846c3ca9fc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2094,6 +2094,7 @@ struct bnxt {
>   #define BNXT_FW_RESET_NOTIFY_SP_EVENT	18
>   #define BNXT_FW_EXCEPTION_SP_EVENT	19
>   #define BNXT_LINK_CFG_CHANGE_SP_EVENT	21
> +#define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
>   #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
>   
>   	struct delayed_work	fw_reset_task;
> @@ -2196,6 +2197,7 @@ struct bnxt {
>   	u8			fatal_thresh_temp;
>   	u8			shutdown_thresh_temp;
>   #endif
> +	u32			thermal_threshold_type;
>   	enum board_idx		board_idx;
>   };
>   
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index e48094043c3b..669d24ba0e87 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -18,14 +18,14 @@
>   #include "bnxt_hwrm.h"
>   #include "bnxt_hwmon.h"
>   
> -void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
> +void bnxt_hwmon_notify_event(struct bnxt *bp)
>   {
>   	u32 attr;
>   
>   	if (!bp->hwmon_dev)
>   		return;
>   
> -	switch (type) {
> +	switch (bp->thermal_threshold_type) {
>   	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
>   		attr = hwmon_temp_max_alarm;
>   		break;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> index 76d9f599ebc0..de54a562e06a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> @@ -11,11 +11,11 @@
>   #define BNXT_HWMON_H
>   
>   #ifdef CONFIG_BNXT_HWMON
> -void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type);
> +void bnxt_hwmon_notify_event(struct bnxt *bp);
>   void bnxt_hwmon_uninit(struct bnxt *bp);
>   void bnxt_hwmon_init(struct bnxt *bp);
>   #else
> -static inline void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
> +static inline void bnxt_hwmon_notify_event(struct bnxt *bp)
>   {
>   }
>   


