Return-Path: <netdev+bounces-36554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822057B05DE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2A54928241D
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED542374FA;
	Wed, 27 Sep 2023 13:56:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D61C681
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:56:18 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE9136;
	Wed, 27 Sep 2023 06:56:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79faba5fe12so298482439f.3;
        Wed, 27 Sep 2023 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695822975; x=1696427775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAveGVM8W0FdsON7ZKmGd0DvdcUZDDmwBnlkrDtyA08=;
        b=au9yBzDX+qSJKK9tdLMYUqwBGIspP+0Gyql+c/SLwdE4Kr2FWRWURGbbGPeVhY1Z1Z
         GsQ6AR2MUIbcSqrFW7ZF/DzfDn0utNmKxFgMzw9Nv6WwXM3UcfY30zSPrf6HN5+QhMuv
         PylIacCDn+ajb+EbRwK/kGbuXgcsQ/rREKByVS+XFNB791wf2Y9a+VY+khpTahJ378vA
         HQGPJyC0HfWbzYJOp0goxc+uu0uyJP3K8rSn6SoSvfC1nEeGf/X48qmC5Urv8u3PtLrg
         mEsG2ptT2ItpNYEn/Zxaqx0ZdPRsP8CG+DdwcxmHBQsY/OmoJS7nZUMIVHJj2gdSiESo
         j3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822975; x=1696427775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAveGVM8W0FdsON7ZKmGd0DvdcUZDDmwBnlkrDtyA08=;
        b=ZpVouxdJuhIfvXplW7513ftKKjXCneYJXoT1vicl+4vaCFTLC+YL4debx2gOUA4DT0
         Zsdg/tONCna0yX8kEoJIB9Yaacl1B5rCCrZ0VqalvBwJ1ehcUCDtgcshobCmQpwMRUpQ
         IrO3RPmpgSEtrNWvsummtbIhmN8S7/wJq5qE6PXPDs7ZYqaDYHyOeoq663h4xieOcZcF
         5rZ0HnIlVZ/uo1H8IKorHf+KCilafVdmeb3xGnt4y37O+m+1u9l77mCL7/5mc3pBrk/x
         FokTeXBJzWYja5teqS/7CSCc2jF8KapY05vcf8wN0dHQGx3wazZOvBVXb/npUmJZNYXM
         Vhdw==
X-Gm-Message-State: AOJu0YxRCIDlXQ/TNA7ATKGnNoKpktx+esxc+ORBb4ZbowmfczpM1vRO
	2WaHAvZIARD+kgTX7RzIe7s=
X-Google-Smtp-Source: AGHT+IGsFTy5UmQA+/fPHR194reUJcEmEplTO/zx9jHWwQGMum161x3vviW86ilq0T7Y04TSth/9HQ==
X-Received: by 2002:a05:6e02:dd4:b0:34b:af03:e2a with SMTP id l20-20020a056e020dd400b0034baf030e2amr1957499ilj.31.1695822975010;
        Wed, 27 Sep 2023 06:56:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021bc300b003513b61b472sm2226729ilv.38.2023.09.27.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:56:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Sep 2023 06:56:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/9] bnxt_en: Modify the driver to use
 hwmon_device_register_with_info
Message-ID: <659f1653-2166-4c49-a737-ab7dc4717e47@roeck-us.net>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-5-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 08:57:29PM -0700, Michael Chan wrote:
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

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 71 ++++++++++++++-----
>  1 file changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index 476616d97071..05e3d75f3c43 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -18,34 +18,73 @@
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
> +		goto drop_req;
> +
> +	*temp = resp->temp;
> +
> +drop_req:
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
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
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
> @@ -72,9 +111,9 @@ void bnxt_hwmon_init(struct bnxt *bp)
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



