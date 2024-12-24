Return-Path: <netdev+bounces-154162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C59FBCE6
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4AA1881719
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D11B4F08;
	Tue, 24 Dec 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYP1+T0O"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE71990A2
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735039089; cv=none; b=EWWyqBEMRlgJEGtSSTPAIwbSkrlMGPxRdlPoi9kmXqgq+GndvKX3am3SqIZz8+Ggwfq5+cjiMYPBQY7uJMt6JFDgxh2A6428alaSd3el3POd4Jofyg5PKZV2m96RGIAjbZQ+8F3OLMZ9gUzjapWcvi5hINxhxAs6bY/1AJ0V40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735039089; c=relaxed/simple;
	bh=cD5rUdco79iyVWIzmdcPzjzRo+I2kPeHFhx2WOhYDv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byJlEFo1Zg2vj4rxa4bnRIftfS+vcWPxsBXSSSu7HmBHIE/WHiDUQfQSAGjKVStshVoIhDHkg8+2MJmo2gCIeWUOW+hoPlz9GRRJ7QxzHrsT/3JjIigWzXopCgAnUnUYcODRN8VGCiuG8eF3XnDgNK8vYsGexvEKS/bWcZFV5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYP1+T0O; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9842ec6-a7c4-4d17-98e2-c59b4d0ec3af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735039081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6KqOsvDuYgxtKncUsMawtgjKb2hqKRcrK+zi0ZnUiU=;
	b=nYP1+T0OGOvLUZPv/gDMHrxfkGJedPH3SPQlSY7UT3r2YsBsq5fkiS64MkpH+0aP5xR99A
	7Z3dZXSLcNZk8KuMCn/zQjGYkwkOhz+fCXrG7rMlRlWksrbg2fpZAuSry6930YH4u0AE/2
	bzMh9pVeHyUr4OUSdB/XESrQklJzo64=
Date: Tue, 24 Dec 2024 11:17:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ptp: ocp: constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241222-sysfs-const-bin_attr-ptp-v1-1-5c1f3ee246fb@weissschuh.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241222-sysfs-const-bin_attr-ptp-v1-1-5c1f3ee246fb@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22/12/2024 20:08, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks!
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   drivers/ptp/ptp_ocp.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 5feecaadde8e05a2a2bb462094434e47e5336400..7f08c70d81230530fda459eefa9b7098dcbba79f 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3692,7 +3692,7 @@ DEVICE_FREQ_GROUP(freq4, 3);
>   
>   static ssize_t
>   disciplining_config_read(struct file *filp, struct kobject *kobj,
> -			 struct bin_attribute *bin_attr, char *buf,
> +			 const struct bin_attribute *bin_attr, char *buf,
>   			 loff_t off, size_t count)
>   {
>   	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> @@ -3727,7 +3727,7 @@ disciplining_config_read(struct file *filp, struct kobject *kobj,
>   
>   static ssize_t
>   disciplining_config_write(struct file *filp, struct kobject *kobj,
> -			  struct bin_attribute *bin_attr, char *buf,
> +			  const struct bin_attribute *bin_attr, char *buf,
>   			  loff_t off, size_t count)
>   {
>   	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> @@ -3750,11 +3750,11 @@ disciplining_config_write(struct file *filp, struct kobject *kobj,
>   
>   	return err;
>   }
> -static BIN_ATTR_RW(disciplining_config, OCP_ART_CONFIG_SIZE);
> +static const BIN_ATTR_RW(disciplining_config, OCP_ART_CONFIG_SIZE);
>   
>   static ssize_t
>   temperature_table_read(struct file *filp, struct kobject *kobj,
> -		       struct bin_attribute *bin_attr, char *buf,
> +		       const struct bin_attribute *bin_attr, char *buf,
>   		       loff_t off, size_t count)
>   {
>   	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> @@ -3789,7 +3789,7 @@ temperature_table_read(struct file *filp, struct kobject *kobj,
>   
>   static ssize_t
>   temperature_table_write(struct file *filp, struct kobject *kobj,
> -			struct bin_attribute *bin_attr, char *buf,
> +			const struct bin_attribute *bin_attr, char *buf,
>   			loff_t off, size_t count)
>   {
>   	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> @@ -3812,7 +3812,7 @@ temperature_table_write(struct file *filp, struct kobject *kobj,
>   
>   	return err;
>   }
> -static BIN_ATTR_RW(temperature_table, OCP_ART_TEMP_TABLE_SIZE);
> +static const BIN_ATTR_RW(temperature_table, OCP_ART_TEMP_TABLE_SIZE);
>   
>   static struct attribute *fb_timecard_attrs[] = {
>   	&dev_attr_serialnum.attr,
> @@ -3867,7 +3867,7 @@ static struct attribute *art_timecard_attrs[] = {
>   	NULL,
>   };
>   
> -static struct bin_attribute *bin_art_timecard_attrs[] = {
> +static const struct bin_attribute *const bin_art_timecard_attrs[] = {
>   	&bin_attr_disciplining_config,
>   	&bin_attr_temperature_table,
>   	NULL,
> @@ -3875,7 +3875,7 @@ static struct bin_attribute *bin_art_timecard_attrs[] = {
>   
>   static const struct attribute_group art_timecard_group = {
>   	.attrs = art_timecard_attrs,
> -	.bin_attrs = bin_art_timecard_attrs,
> +	.bin_attrs_new = bin_art_timecard_attrs,
>   };
>   
>   static const struct ocp_attr_group art_timecard_groups[] = {
> 
> ---
> base-commit: bcde95ce32b666478d6737219caa4f8005a8f201
> change-id: 20241222-sysfs-const-bin_attr-ptp-7aec7d5332a8
> 
> Best regards,


