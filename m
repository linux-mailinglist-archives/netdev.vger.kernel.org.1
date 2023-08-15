Return-Path: <netdev+bounces-27707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6177CEE5
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC041C20B60
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4FA14271;
	Tue, 15 Aug 2023 15:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6261097E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:16:59 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B21BD0;
	Tue, 15 Aug 2023 08:16:35 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34984bff431so17606975ab.2;
        Tue, 15 Aug 2023 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692112593; x=1692717393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jq72e3gv9obDkYlmkmR/28Rn69ZDFoeuMxfVLnIkIs=;
        b=gw/4ig3q5lkqnyM8L6NCj9SnRsIYjzG11Uh0xVlMsbq3/pIDWzLpX+AiDwOOo0MbEi
         D9eEz7ZV9y3lUt8JT/XzMeFLu83HWzzcImWf+5tSM4HjKfvZwDenL3mOQf4asXgwyvkP
         zNNruOPoP1q8rxNdwCobj2pNL8dNgZc4d8mB70ODoU33RZLdwfavn8qwM287VwSE7Zy7
         LsqLAa74F/8E6WVSApOrgPGQgq0MJDfKEnhLIrXRK/N4rhy9+vuk7/s1hKVKkLQNd715
         TuBUuAo0tUHf9y78gslp4JYssorNw2Pxo/qB8hUxST58UmXvZ64iMGUJ3szNhpV1duSw
         kMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112593; x=1692717393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jq72e3gv9obDkYlmkmR/28Rn69ZDFoeuMxfVLnIkIs=;
        b=Wff6oLi0YaFKg9YygLpaExuZ3iLq8H2DnJe5zaKiiyYz/zQ6DBx5np3gTNSY/anDdB
         9cG0DPffQHolf8TD9Zn5Ex8jRNvuTJNETAz4omhxIoQY29T7A9svYj3U7e/Dzs4aIW1R
         d4hTxRc77+Q95iR0C2OV46Cjgz/wVWESNeuHsyzpmSBCA4cYm6UgtdYZcZVSmb/BEW07
         8VfwXMg8CIo4E3tgJlTkhvZ8EHWgEf2LxypKtaz8JtuFqC3OuUKI8euxYLgXhvYSsGtc
         xiMDtmCvvEK0HMITsLf1sl9Bwn8Sihffz5rQ3WyySCt8M5aKNuUTJFVZnuf8dr8VFe+7
         leyw==
X-Gm-Message-State: AOJu0YxzSlnrbEkDxmKriK0sjDs65Df3VCCMfFyTbIjOxXxQFYCSNRO+
	S/Q/5+z/YG4X6iWS8MgJAqA=
X-Google-Smtp-Source: AGHT+IHSk8ljvenaCQ7eS9jxcAoBh0EUHhkt+iV5SRr3YUHVzSo5yL2wJAcsdNbT5j7Q3+yMy6ucqw==
X-Received: by 2002:a05:6e02:dc1:b0:348:8b42:47d with SMTP id l1-20020a056e020dc100b003488b42047dmr14116907ilj.28.1692112593286;
        Tue, 15 Aug 2023 08:16:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t23-20020a05663801f700b0041a9022c3dasm3538227jaq.118.2023.08.15.08.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:16:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 15 Aug 2023 08:16:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] bnxt_en: Event handler for Thermal event
Message-ID: <58848214-55a1-474c-a7fa-954552ea4019@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815045658.80494-13-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 09:56:58PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Newer FW will send a new async event when it detects that
> the chip's temperature has crossed the configured threshold value.
> The driver will now notify hwmon and will log a warning message.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 44 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   |  8 ++++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.h   |  5 +++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 5e97a3d93e87..c8e04c9501ee 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2130,6 +2130,17 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
>  	return INVALID_HW_RING_ID;
>  }
>  
> +#define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
> +	((data2) & ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
> +
> +#define BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2)					\
> +	(((data2) &									\
> +	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_MASK) >>	\
> +	 ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_THRESHOLD_TEMP_SFT)
> +
> +#define EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1)			\
> +	((data1) & ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_MASK)
> +
>  static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>  {
>  	u32 err_type = BNXT_EVENT_ERROR_REPORT_TYPE(data1);
> @@ -2145,6 +2156,39 @@ static void bnxt_event_error_report(struct bnxt *bp, u32 data1, u32 data2)
>  	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_DOORBELL_DROP_THRESHOLD:
>  		netdev_warn(bp->dev, "One or more MMIO doorbells dropped by the device!\n");
>  		break;
> +	case ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_THERMAL_THRESHOLD: {
> +		char *threshold_type;
> +		u32 attr;
> +
> +		switch (EVENT_DATA1_THERMAL_THRESHOLD_TYPE(data1)) {
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_WARN:
> +			attr = hwmon_temp_lcrit_alarm;

As with previous patch, wrong attribute

> +			threshold_type = "warning";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_CRITICAL:
> +			attr = hwmon_temp_crit_alarm;
> +			threshold_type = "critical";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_FATAL:
> +			attr = hwmon_temp_emergency_alarm;
> +			threshold_type = "fatal";
> +			break;
> +		case ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA1_THRESHOLD_TYPE_SHUTDOWN:
> +			attr = hwmon_temp_max_alarm;

Same here.

Overall it seems to me it would be better to keep hwmon internals out
of this file and just pass the threshold type to the hwmon code.

> +			threshold_type = "shutdown";
> +			break;
> +		default:
> +			netdev_err(bp->dev, "Unknown Thermal threshold type event\n");
> +			return;
> +		}
> +		netdev_warn(bp->dev, "Chip temperature has crossed the %s thermal threshold!\n",
> +			    threshold_type);
> +		netdev_warn(bp->dev, "Temperature (In Celsius), Current: %lu, threshold: %lu\n",
> +			    BNXT_EVENT_THERMAL_CURRENT_TEMP(data2),
> +			    BNXT_EVENT_THERMAL_THRESHOLD_TEMP(data2));
> +		bnxt_hwmon_notify_event(bp, attr);
> +		break;
> +	}
>  	default:
>  		netdev_err(bp->dev, "FW reported unknown error type %u\n",
>  			   err_type);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index f5affac1169a..483571264276 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -18,6 +18,14 @@
>  #include "bnxt_hwrm.h"
>  #include "bnxt_hwmon.h"
>  
> +void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr)
> +{
> +	if (!bp->hwmon_dev)
> +		return;
> +
> +	hwmon_notify_event(&bp->pdev->dev, hwmon_temp, attr, 0);
> +}
> +
>  static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  {
>  	struct hwrm_temp_monitor_query_output *resp;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> index af310066687c..5cf127702764 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> @@ -11,9 +11,14 @@
>  #define BNXT_HWMON_H
>  
>  #ifdef CONFIG_BNXT_HWMON
> +void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr);
>  void bnxt_hwmon_uninit(struct bnxt *bp);
>  void bnxt_hwmon_init(struct bnxt *bp);
>  #else
> +static inline void bnxt_hwmon_notify_event(struct bnxt *bp, u32 attr)
> +{
> +}
> +
>  static inline void bnxt_hwmon_uninit(struct bnxt *bp)
>  {
>  }
> -- 
> 2.30.1
> 



