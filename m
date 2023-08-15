Return-Path: <netdev+bounces-27702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41977CEA8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19578281544
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0713AFF;
	Tue, 15 Aug 2023 15:05:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B113AF3
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:05:05 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98596138;
	Tue, 15 Aug 2023 08:05:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7910b9bb891so177731139f.2;
        Tue, 15 Aug 2023 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692111903; x=1692716703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C15dfbyaPCqUx0eSRs2F9I2Y/k4M/cVBWlOvNZGqVdo=;
        b=dwCMArsZfYi5nteJatAUcHS7Ezg/Nxg2NbBJuZWyvH+kS3ebqtR8sJeI9hVHR59xu3
         qO9YV5bkoEx956F/O5iEyM9VIj7GN7hKpt6AqZFQ+J18wb34W7EoGaL3MXdFiPXhyx/K
         804grLRZEvMU3kxURVMoDHGEsoJTN0x32dSGQQVwZQ0Erqips7aDJ3SD3UrDy2BOijsI
         OIuHw8N1Z85v5In/KGPCsSdtbntro0mNyMo9gCbEr+jZWIXtE4aWmR22M7HaVXXg2G+n
         6q4YMxOct/dxOINlzhIckXJQR02lsdq8Frvcg1/oP5dovpz5dB/7mXWP699Wnk1wPdRy
         fV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111903; x=1692716703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C15dfbyaPCqUx0eSRs2F9I2Y/k4M/cVBWlOvNZGqVdo=;
        b=fTdHcOp8qhRjLQvgMt7ivayf0LR7im+vhbYhtjyEbV/hnUI3WKBX+v54uzc115v0Dg
         J62cC0ZpDXMZH4Y6FhrbHZkjg3lXIciyvt84IaZS55Hki/KIMBvaZDZIoHC6mQ4pKQlm
         +MZbKtbd6eMbrVUan3Jn5DsRYTScLAN7ttVwCkKp3+RXd5t41c0yQGpxPCm0wl/D27LG
         2GiaEGdGvJkEgACC8yQA3l3JzLRpAf8O1tSyHvCP643FJ3EX8a0GbL4NWxeNQ7N89TaO
         mq+MKZgQ4pCQiZpie5PIWSSU/9DyWKmsvhL7b9qaM8BGUgngAhk/W9ah133rlqeqYkr6
         qigg==
X-Gm-Message-State: AOJu0YxBDxRiPB287TK+E65QkLHUmA8v8N3jwtAc4Cukc/KYlOZcedAI
	Tmk3//yzdpoYmVV30yLoR6E=
X-Google-Smtp-Source: AGHT+IFbh1lIZ1o+4tSmuL6NIEH8obSbxkyXTWfEyJ61hKXXXnFyoCadxxg6FsLMA3M19uJxDfdGdQ==
X-Received: by 2002:a05:6e02:1be2:b0:348:1a1d:79a5 with SMTP id y2-20020a056e021be200b003481a1d79a5mr21058271ilv.15.1692111902612;
        Tue, 15 Aug 2023 08:05:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17-20020a92cc11000000b00345d3f2bb6asm3980504ilp.56.2023.08.15.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:05:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 15 Aug 2023 08:05:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
Message-ID: <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815045658.80494-12-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 09:56:57PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> HWRM_TEMP_MONITOR_QUERY response now indicates various
> threshold temperatures. Expose these threshold temperatures
> through the hwmon sysfs.
> Also, provide temp1_max_alarm through which the user can check
> whether the threshold temperature has been reached or not.
> 
> Example:
> cat /sys/class/hwmon/hwmon3/temp1_input
> 75000
> cat /sys/class/hwmon/hwmon3/temp1_max
> 105000
> cat /sys/class/hwmon/hwmon3/temp1_max_alarm
> 0
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 ++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 71 +++++++++++++++++--
>  2 files changed, 73 insertions(+), 5 deletions(-)
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
> index 20381b7b1d78..f5affac1169a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -34,6 +34,15 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  
>  	if (temp)
>  		*temp = resp->temp;
> +
> +	if (resp->flags & TEMP_MONITOR_QUERY_RESP_FLAGS_THRESHOLD_VALUES_AVAILABLE) {
> +		if (!temp)
> +			bp->fw_cap |= BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED;

The if statement seems unnecessary. If the flag was not set
during initialization, the limit attributes won't be visible anyway,
so it doesn't make a difference if it is set now or not.

> +		bp->warn_thresh_temp = resp->warn_threshold;
> +		bp->crit_thresh_temp = resp->critical_threshold;
> +		bp->fatal_thresh_temp = resp->fatal_threshold;
> +		bp->shutdown_thresh_temp = resp->shutdown_threshold;

Are those temperatures expected to change during runtime ? If not it might
make sense to only execute the entire if condition if temp == NULL to
avoid unnecessary reassignments whenever the temperature is read.

> +	}
>  err:
>  	hwrm_req_drop(bp, req);
>  	return rc;
> @@ -42,12 +51,30 @@ static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
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
> +	case hwmon_temp_lcrit:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_emergency:
> +	case hwmon_temp_lcrit_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_emergency_alarm:
> +		if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED)

Seems to me that
		if (!(bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED))
would be much easier to understand.

> +			return 0;
> +		return 0444;
> +	/* Max temperature setting in NVM is optional */
> +	case hwmon_temp_max:
> +	case hwmon_temp_max_alarm:
> +		if (~bp->fw_cap & BNXT_FW_CAP_THRESHOLD_TEMP_SUPPORTED ||
> +		    !bp->shutdown_thresh_temp)
> +			return 0;

Wrong use of the 'max' attribute. More on that below.

> +		return 0444;
>  	default:
>  		return 0;
>  	}
> @@ -66,6 +93,38 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
>  		if (!rc)
>  			*val = temp * 1000;
>  		return rc;
> +	case hwmon_temp_lcrit:
> +		*val = bp->warn_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_crit:
> +		*val = bp->crit_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_emergency:
> +		*val = bp->fatal_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_max:
> +		*val = bp->shutdown_thresh_temp * 1000;
> +		return 0;
> +	case hwmon_temp_lcrit_alarm:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp >= bp->warn_thresh_temp;

That is wrong. lcrit is the _lower_ critical temperature, ie the
temperature is critically low. This is not a "high temperature"
alarm.

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
> +	case hwmon_temp_max_alarm:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp >= bp->shutdown_thresh_temp;

Hmm, that isn't really the purpose of alarm attributes. The expectation
would be that the chip sets alarm flags and the driver reports it.
I guess there is some value in having it, so I won't object.

Anyway, the ordering is wrong. max_alarm should be the lowest
alarm level, followed by crit and emergency. So
		max_alarm -> temp >= bp->warn_thresh_temp
		crit_alarm -> temp >= bp->crit_thresh_temp
		emergency_alarm -> temp >= bp->fatal_thresh_temp
				or temp >= bp->shutdown_thresh_temp

There are only three levels of upper temperature alarms.
Abusing lcrit as 4th upper alarm is most definitely wrong.

> +		return rc;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -73,7 +132,11 @@ static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
>  
>  static const struct hwmon_channel_info *bnxt_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT),
> +			   HWMON_T_INPUT |
> +			   HWMON_T_MAX | HWMON_T_LCRIT |
> +			   HWMON_T_CRIT | HWMON_T_EMERGENCY |
> +			   HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM |
> +			   HWMON_T_MAX_ALARM | HWMON_T_EMERGENCY_ALARM),
>  	NULL
>  };
>  
> @@ -97,13 +160,11 @@ void bnxt_hwmon_uninit(struct bnxt *bp)
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

Ah, that is the reason for the check in bnxt_hwrm_temp_query().
The check in that function should really be added here, not in the
previous patch.

>  	if (rc == -EACCES || rc == -EOPNOTSUPP) {
>  		bnxt_hwmon_uninit(bp);
>  		return;
> -- 
> 2.30.1
> 



