Return-Path: <netdev+bounces-36556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFEB7B0628
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C5CD4B20AB1
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DE38F90;
	Wed, 27 Sep 2023 14:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BC37C95
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:05:18 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB25FC;
	Wed, 27 Sep 2023 07:05:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fe6da0049so99085039f.1;
        Wed, 27 Sep 2023 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695823516; x=1696428316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrNoU982zJi+/qHYH31J9PxAUzmQOabQ7p9aHUrcB+M=;
        b=MWBsgV6u04bvviXOkNx92ZG5imoq3bmGown2pLVcOC0wedVNFliXuBz9gOf0UW9fpv
         es9+vFKzP4PbXx/NujxAK7+xaFjJyQi7F4X2bPBjbBXnGqo11eCTOCMpb0j6CYc0vaEw
         23f1Mjfj3dEXJ1BLXZl49CuPpWLNeDx6VFLHWR1wF/pAesn3DuTarO5OZHWbYnE+UMBw
         i3V25Q57oC4/nexNyjeIY9vQ/HbWJJHfEfxBbnjol8C4rCUt/bPyxWZyf5WI4r8e2908
         uxf254uHNJrD4rlThA5gsNa7EJ65ntLBb3bF0xU0AZvSD46/j1fwKlNK5zFx3NRjTEpe
         g5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823516; x=1696428316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrNoU982zJi+/qHYH31J9PxAUzmQOabQ7p9aHUrcB+M=;
        b=uuLeBkvSt/fsi/MoWyXNXmnh+rNNHrmmaI8TB3DX01oprs0sYF2ic/bEV1vRR5DgM9
         Pbaql6QeCl/TcJPUmHzFxY9NlYXbGepU1C5/A8gmTIoHubUkBAlV8c/K6jTHI2EeJ7aE
         LfQ/VSR2fzFrfk4+t6SNt+8zeUn40/56WUSYtyZhKtrj8E/KCwv304O+Uw5REPqSgR5Q
         S+keoBUtyjxhqg3FYD5K1qwX4XP4QRotkjIdiJF7ve7Fu8heb1dAKkcrJDaQspp3Qvr6
         fJXFXKn1zVGy59WgNyEm3NvOzUbfjPNrFeR7QgnuFlCVm03/DIburjpEqNDYxhlo4goO
         Erqg==
X-Gm-Message-State: AOJu0Yy+FR8qtJtCKGiZ7UqDP/ThG0uu/fZGC5hoai78tHq+EFn8Wql0
	HsRwTrocAPvgY0jnuPNzAaA=
X-Google-Smtp-Source: AGHT+IGfpMvUWXfl6fueQBNh/sloIdRVuetGsVjuEFGVRClQ1CPzzKt0t/xTN1tSKH186s1hmjzXMw==
X-Received: by 2002:a6b:f012:0:b0:798:312a:5403 with SMTP id w18-20020a6bf012000000b00798312a5403mr2546945ioc.19.1695823516463;
        Wed, 27 Sep 2023 07:05:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm3999675jaq.173.2023.09.27.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:05:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Sep 2023 07:05:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] bnxt_en: Event handler for Thermal event
Message-ID: <444e44a0-2d68-4be6-84bc-c14f6c56b7a2@roeck-us.net>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-8-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 08:57:32PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Newer FW will send a new async event when it detects that
> the chip's temperature has crossed the configured threshold value.
> The driver will now notify hwmon and will log a warning message.
> 
> Link: https://lore.kernel.org/netdev/20230815045658.80494-13-michael.chan@broadcom.com/
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
> Remove hwmon dependencies from bnxt.c.
> 
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 52 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 25 +++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.h   |  5 ++
>  3 files changed, 82 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index b83f8de0a015..7104237272de 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2129,6 +2129,24 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
>  	return INVALID_HW_RING_ID;
>  }
>  
> +#define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
> +	((data2) &							\
> +	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
> +
> +#define BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2)			\
> +	(((data2) &							\
> +	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_MASK) >>\
> +	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_SFT)
> +
> +#define EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1)			\
> +	((data1) &							\
> +	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_MASK)
> +
> +#define EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1)		\
> +	(((data1) &							\
> +	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR) ==\
> +	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_TRANSITION_DIR_INCREASING)
> +
>  static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>  {
>  	u32 err_type = BNXT_EVENT_ERROR_REPORT_TYPE(data1);
> @@ -2144,6 +2162,40 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>  	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD:
>  		netdev_warn(bp->dev, "One or more MMIO doorbells dropped by the device!\n");
>  		break;
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD: {
> +		u32 type = EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1);
> +		char *threshold_type;
> +		char *dir_str;
> +
> +		switch (type) {
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
> +			threshold_type = "warning";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL:
> +			threshold_type = "critical";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL:
> +			threshold_type = "fatal";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN:
> +			threshold_type = "shutdown";
> +			break;
> +		default:
> +			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
> +			return;
> +		}
> +		if (EVENT_DATA1_THERMAL_THRESHOLD_DIR_INCREASING(data1))
> +			dir_str = "above";
> +		else
> +			dir_str = "below";
> +		netdev_warn(bp->dev, "Chip temperature has gone %s the %s thermal threshold!\n",
> +			    dir_str, threshold_type);
> +		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
> +			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
> +			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
> +		bnxt_hwmon_notify_event(bp, type);
> +		break;
> +	}
>  	default:
>  		netdev_err(bp->dev, "FW reported unknown error type %u\n",
>  			   err_type);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index 6d36158df26e..e48094043c3b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -18,6 +18,31 @@
>  #include "bnxt_hwrm.h"
>  #include "bnxt_hwmon.h"
>  
> +void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
> +{
> +	u32 attr;
> +
> +	if (!bp->hwmon_dev)
> +		return;
> +
> +	switch (type) {
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
> +		attr = hwmon_temp_max_alarm;
> +		break;
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL:
> +		attr = hwmon_temp_crit_alarm;
> +		break;
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL:
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN:
> +		attr = hwmon_temp_emergency_alarm;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	hwmon_notify_event(&bp->pdev->dev, hwmon_temp, attr, 0);
> +}
> +
>  static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  {
>  	struct hwrm_temp_monitor_query_output *resp;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> index af310066687c..76d9f599ebc0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> @@ -11,9 +11,14 @@
>  #define BNXT_HWMON_H
>  
>  #ifdef CONFIG_BNXT_HWMON
> +void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type);
>  void bnxt_hwmon_uninit(struct bnxt *bp);
>  void bnxt_hwmon_init(struct bnxt *bp);
>  #else
> +static inline void bnxt_hwmon_notify_event(struct bnxt *bp, u32 type)
> +{
> +}
> +
>  static inline void bnxt_hwmon_uninit(struct bnxt *bp)
>  {
>  }
> -- 
> 2.30.1
> 



