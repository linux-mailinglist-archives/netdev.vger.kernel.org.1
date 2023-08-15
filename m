Return-Path: <netdev+bounces-27694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33877CE59
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B7228151A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C967D13AC7;
	Tue, 15 Aug 2023 14:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829B111B0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:44:21 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52190AB;
	Tue, 15 Aug 2023 07:44:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3492c49c649so17561075ab.3;
        Tue, 15 Aug 2023 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692110659; x=1692715459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dWsgr4GtSkhi8VZSePtyntV6DXxxLpj6twGQjDjRns=;
        b=ketzm6o1YKS9I30ZqFNX7tos66OqYEI7qXUWz5gN2kKfE7YHj9QZoiSv2ZAPbFCb+W
         qsWlCz0pv9bYziOGLoziGsgmQsJSpW0qWKPaaOOFDcboL+BMrL1ab0AJOVMtKDhLon/o
         Nl3lC2wXFcroJjIsuwZAxcSNbcDYaxONmP3OXE9Wx7T4F1omcMpoGmtH2EXRH2N4BogQ
         6dcgjUuLBD1Y3GMeAT20EjRUrJmYnTA/wrF+UKvhbBtHOX8/zSZopeRNa87RvohGdzwn
         wkcTTlWPcpo8lcb7fcepaaVxq1vTYuB+w4dJOcAEw+rfr8wSirUcWxRWNuoEGpUYNtXU
         HiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110659; x=1692715459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dWsgr4GtSkhi8VZSePtyntV6DXxxLpj6twGQjDjRns=;
        b=CGY544cIyZbYItEynGYkjrRGVrsS5Iw8b+WvAjrtWq1s/B4KVcz19EPRdvVF1Mcd3k
         xK9Eo90dVexBsCfWzZXLat3MocJINHEG8mNFStd58A2oHuFiENY14ZN1ukNw2bW8ka+T
         XkvWtM/cL4de1K+87FepEkqMvk8gmAbqiGF+5tqvTkAf3QgYYzpN14jlwu58YydErG1q
         PnV5HuPjl7RyMmoMUUJL0NTgZitrGs4lSG8T40Ahl3nynINO4T6TL9rIXMC+ulKFfeWm
         8Fd8r459UbXfLrE9oXtVkDuiVxEjcY6m7SEtPyXMRy5kVYRmIsni1IP/n62y5coVi/DL
         QLdw==
X-Gm-Message-State: AOJu0YzGzuxfw81gVNvJKTP+jtbEC7xK40MOUCAB0gRO7f8hXibNDTBK
	Etv3gaX+7nblmhUi9kpU/1s=
X-Google-Smtp-Source: AGHT+IFS/RPaAAaI2fymwbZJmbZPb4yPVwvMviDHZlHJHuE3kfzi5mY1KRTobFMi/MmtogTYr6CJzA==
X-Received: by 2002:a05:6e02:b2d:b0:345:c8ce:ff49 with SMTP id e13-20020a056e020b2d00b00345c8ceff49mr20471735ilu.11.1692110659520;
        Tue, 15 Aug 2023 07:44:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020a92d209000000b0034a565bb9fasm2574548ily.57.2023.08.15.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:44:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 15 Aug 2023 07:44:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] bnxt_en: Modify the driver to use
 hwmon_device_register_with_info
Message-ID: <d80f1ebd-303f-475d-8f30-90b62096e725@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-11-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815045658.80494-11-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 09:56:56PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> The use of hwmon_device_register_with_groups() is deprecated.
> Modified the driver to use hwmon_device_register_with_info().
> 
> Driver currently exports only temp1_input through hwmon sysfs
> interface. But FW has been modified to report more threshold
> temperatures and driver want to report them through the
> hwmon interface.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 72 ++++++++++++++-----
>  1 file changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index 476616d97071..20381b7b1d78 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -18,34 +18,74 @@
>  #include "bnxt_hwrm.h"
>  #include "bnxt_hwmon.h"
>  
> -static ssize_t bnxt_show_temp(struct device *dev,
> -			      struct device_attribute *devattr, char *buf)
> +static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
>  {
>  	struct hwrm_temp_monitor_query_output *resp;
>  	struct hwrm_temp_monitor_query_input *req;
> -	struct bnxt *bp = dev_get_drvdata(dev);
> -	u32 len = 0;
>  	int rc;
>  
>  	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
>  	if (rc)
>  		return rc;
>  	resp = hwrm_req_hold(bp, req);
> -	rc = hwrm_req_send(bp, req);
> -	if (!rc)
> -		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
> -	hwrm_req_drop(bp, req);
> +	rc = hwrm_req_send_silent(bp, req);
>  	if (rc)
> +		goto err;
> +
> +	if (temp)
> +		*temp = resp->temp;

Why this NULL pointer check ? This is a static function,
and it is never called with a NULL pointer.

> +err:
> +	hwrm_req_drop(bp, req);
> +	return rc;
> +}
> +
> +static umode_t bnxt_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int bnxt_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			   int channel, long *val)
> +{
> +	struct bnxt *bp = dev_get_drvdata(dev);
> +	u8 temp = 0;
> +	int rc;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		rc = bnxt_hwrm_temp_query(bp, &temp);
> +		if (!rc)
> +			*val = temp * 1000;
>  		return rc;
> -	return len;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
> -static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
>  
> -static struct attribute *bnxt_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +static const struct hwmon_channel_info *bnxt_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT),

Nit: Unnecessary continuation line

>  	NULL
>  };
> -ATTRIBUTE_GROUPS(bnxt);
> +
> +static const struct hwmon_ops bnxt_hwmon_ops = {
> +	.is_visible     = bnxt_hwmon_is_visible,
> +	.read           = bnxt_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info bnxt_hwmon_chip_info = {
> +	.ops    = &bnxt_hwmon_ops,
> +	.info   = bnxt_hwmon_info,
> +};
>  
>  void bnxt_hwmon_uninit(struct bnxt *bp)
>  {
> @@ -72,9 +112,9 @@ void bnxt_hwmon_init(struct bnxt *bp)
>  	if (bp->hwmon_dev)
>  		return;
>  
> -	bp->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
> -							  DRV_MODULE_NAME, bp,
> -							  bnxt_groups);
> +	bp->hwmon_dev = hwmon_device_register_with_info(&pdev->dev,
> +							DRV_MODULE_NAME, bp,
> +							&bnxt_hwmon_chip_info, NULL);
>  	if (IS_ERR(bp->hwmon_dev)) {
>  		bp->hwmon_dev = NULL;
>  		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
> -- 
> 2.30.1
> 



