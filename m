Return-Path: <netdev+bounces-36555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640EC7B0615
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 15B06282CF8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057C38F8D;
	Wed, 27 Sep 2023 14:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEA38F8C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:04:08 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD6121;
	Wed, 27 Sep 2023 07:04:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79f92726f47so378841639f.3;
        Wed, 27 Sep 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695823445; x=1696428245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj000gBP9rdmKXA0ELeXucGsmSs875G0oWEFOqxRClI=;
        b=Wj4W2RzS3zlg2dLgXv2nCaDxAfaTcrOAdNwQanH4ESUwb+J33MV2JlUKdV05O89/dO
         txwzslOI11wNSVESIszz6oQBoQ/CKip29+4aANzb/SuAkMsqc3fPYUPwyO2jemF6ZRed
         RjZOaDcBfUR9JPhLWljCsCMaMI9STRxSPF9rycqdLpI/Tv0bqzIoIO7PWO4aez7a9nAc
         zV5BQKOORv2Pj4KWE+IamERupEzgW+EmFiWdYpCSkqeh+zrl7zN52e9ICaXUBoCD8tAr
         rTkDcl5yr8RsblM3IDpDvUpytVQauVVAvbJ9Xpzbw0GKb6Poc8MxWQWoNEkmoqMWbQUh
         UL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823445; x=1696428245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj000gBP9rdmKXA0ELeXucGsmSs875G0oWEFOqxRClI=;
        b=us7DvtQvfieLWgs5iUo0+LjVLQfoq3Q2WaJh567dgXH1aG3DBZUlYLLN48lZYsSWyw
         BfbfZqv7As3MkF9tSwQ0yQIeep44zijKnRFOV0maPONmTOKGV7EW61o8T5LwCD/2mwKT
         65ynngRxXQ6fu7vFVOFbDOUXOpi3oODfslv0U9nR7lh/BcPX+47gUZo+dk/iAn2B5yhE
         xVsEvIfOtYZlpHQiZYkM9gqQnt30+BckIGQcDp+j4Bxal5YbtCwmb6wnSJzZU1DmAHgv
         od+ZuQf6dGMzDioisEB5KeQ1+kfspLQmhrCRD2o6PF+a++rg/k4/a2ZK5bd3Roha4vD1
         PUzA==
X-Gm-Message-State: AOJu0YxZxppE6zDlJXi3TQ/dLxcv7P6pCp/J3ezHqSZGmvF7oSjGWfQy
	/80iiAgzEpNJhYflpL5amK4=
X-Google-Smtp-Source: AGHT+IEqgRL+rMwMTrlgJEJvY5XieflrlEWZITWcLh/RiAuwAKo6MhInWhVPZ2mV1YvhspFjFrNPIg==
X-Received: by 2002:a5e:950c:0:b0:794:efb0:83d6 with SMTP id r12-20020a5e950c000000b00794efb083d6mr2148868ioj.12.1695823444749;
        Wed, 27 Sep 2023 07:04:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020a6b7f41000000b0079f5265e7b3sm3802025ioq.46.2023.09.27.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:04:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Sep 2023 07:04:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] bnxt_en: Expose threshold temperatures
 through hwmon
Message-ID: <5ae37019-55a9-414d-852d-ecdedaab68d9@roeck-us.net>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-6-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-6-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 08:57:30PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> HWRM_TEMP_MONITOR_QUERY response now indicates various
> threshold temperatures. Expose these threshold temperatures
> through the hwmon sysfs using this mapping:
> 
> hwmon_temp_max : bp->warn_thresh_temp
> hwmon_temp_crit : bp->crit_thresh_temp
> hwmon_temp_emergency : bp->fatal_thresh_temp
> 
> hwmon_temp_max_alarm : temp >= bp->warn_thresh_temp
> hwmon_temp_crit_alarm : temp >= bp->crit_thresh_temp
> hwmon_temp_emergency_alarm : temp >= bp->fatal_thresh_temp
> 
> Link: https://lore.kernel.org/netdev/20230815045658.80494-12-michael.chan@broadcom.com/
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
> bnxt_hwrm_temp_query() now stores the static threshold values once.
> Use new hwmon temperature mappings shown above and remove hwmon_temp_lcrit.
> 
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 57 ++++++++++++++++---
>  2 files changed, 57 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 84cbcfa61bc1..43a07d84f815 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2013,6 +2013,7 @@ struct bnxt {
>  	#define BNXT_FW_CAP_RING_MONITOR		BIT_ULL(30)
>  	#define BNXT_FW_CAP_DBG_QCAPS			BIT_ULL(31)
>  	#define BNXT_FW_CAP_PTP				BIT_ULL(32)
> +	#define BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED	BIT_ULL(33)
>  
>  	u32			fw_dbg_cap;
>  
> @@ -2185,7 +2186,13 @@ struct bnxt {
>  	struct bnxt_tc_info	*tc_info;
>  	struct list_head	tc_indr_block_list;
>  	struct dentry		*debugfs_pdev;
> +#ifdef CONFIG_BNXT_HWMON
>  	struct device		*hwmon_dev;
> +	u8			warn_thresh_temp;
> +	u8			crit_thresh_temp;
> +	u8			fatal_thresh_temp;
> +	u8			shutdown_thresh_temp;
> +#endif
>  	enum board_idx		board_idx;
>  };
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index 05e3d75f3c43..6a2cad5cc159 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -32,8 +32,16 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  	if (rc)
>  		goto drop_req;
>  
> -	*temp = resp->temp;
> -
> +	if (temp) {
> +		*temp = resp->temp;
> +	} else if (resp->flags &
> +		   TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE) {
> +		bp->fw_cap |= BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED;
> +		bp->warn_thresh_temp = resp->warn_threshold;
> +		bp->crit_thresh_temp = resp->critical_threshold;
> +		bp->fatal_thresh_temp = resp->fatal_threshold;
> +		bp->shutdown_thresh_temp = resp->shutdown_threshold;
> +	}
>  drop_req:
>  	hwrm_req_drop(bp, req);
>  	return rc;
> @@ -42,12 +50,23 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  static umode_t bnxt_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type,
>  				     u32 attr, int channel)
>  {
> +	const struct bnxt *bp = _data;
> +
>  	if (type != hwmon_temp)
>  		return 0;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
>  		return 0444;
> +	case hwmon_temp_max:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_emergency:
> +	case hwmon_temp_max_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_emergency_alarm:
> +		if (!(bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED))
> +			return 0;
> +		return 0444;
>  	default:
>  		return 0;
>  	}
> @@ -66,13 +85,39 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
>  		if (!rc)
>  			*val = temp * 1000;
>  		return rc;
> +	case hwmon_temp_max:
> +		*val = bp->warn_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_crit:
> +		*val = bp->crit_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_emergency:
> +		*val = bp->fatal_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_max_alarm:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp >= bp->warn_thresh_temp;
> +		return rc;
> +	case hwmon_temp_crit_alarm:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp >= bp->crit_thresh_temp;
> +		return rc;
> +	case hwmon_temp_emergency_alarm:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp >= bp->fatal_thresh_temp;
> +		return rc;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
>  }
>  
>  static const struct hwmon_channel_info *bnxt_hwmon_info[] = {
> -	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_EMERGENCY | HWMON_T_MAX_ALARM |
> +			   HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY_ALARM),
>  	NULL
>  };
>  
> @@ -96,13 +141,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)
>  
>  void bnxt_hwmon_init(struct bnxt *bp)
>  {
> -	struct hwrm_temp_monitor_query_input *req;
>  	struct pci_dev *pdev = bp->pdev;
>  	int rc;
>  
> -	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> -	if (!rc)
> -		rc = hwrm_req_send_silent(bp, req);
> +	/* temp1_xxx is only sensor, ensure not registered if it will fail */
> +	rc = bnxt_hwrm_temp_query(bp, NULL);
>  	if (rc == -EACCES || rc == -EOPNOTSUPP) {
>  		bnxt_hwmon_uninit(bp);
>  		return;
> -- 
> 2.30.1
> 



