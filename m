Return-Path: <netdev+bounces-119109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57FF954120
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345E2B2181D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764278C7F;
	Fri, 16 Aug 2024 05:26:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F54383A5
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785968; cv=none; b=GRoQBMWI6yCcDQVO8pojd4ghJEaji+RDo4E4pM3DH/YYOnjYwYysvDzrN/IF0p2mFn2Qz9bV/S/7eYX3TKYKVBfJKU0DN4dpQNLz5VkRw90LmdM5UkswrDa13vDgCYOiH3AghrQzU4g46jEW0CbUS77a4q5kWooghVwloUSeecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785968; c=relaxed/simple;
	bh=klz8DQVgYb0ZFYf8PwaGEcJ21Co21aPJgfo0H68llnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOdEjcsmLKiGyJ91NsfL0YwcEFGXAjBda1JBpsJPaHE8WxAfXusop4D9isd6TVWQMaVewBvthqaqMeUqpuM+cQPVcKkWsJJH/SX7HnZO3RY+HflKEXI9hzsFQlhqMViAx+LkpsCaojyw1Zof8Kb5gnTymik1qH0N2hBWnH33c5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so1796939a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 22:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723785965; x=1724390765;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiT5jGUzldCaraUrsbhDWg0gba1DMmi76ZLPV2qxOtM=;
        b=V6x3JXI3OJ8MnbL5mlrF5/t8N+vHF9O9K549dVxbOWWgMnkkDSMcn4/5vYs2a3R6bT
         KGRTYAt+N55awtUCmFtByvIJD7dVz0qlqMP24FSkatmYfVmbFnr3AUAsXY+epIXgZJfK
         8p2Mf/VOs0eqGqlcVRQgQK909VfUAfnnk791K3H2nzkNUYKGNCDhROeBkPd3vIXJ5CkW
         A96tctH/y3W34IIg+05mQ1pBJV8Jj1dHzmMwSzoOhpWaobqGrxKzIwbp8VyUTbV+ZLUm
         jyVjiITgq/IqhSG9W38skTH+aw/Ql9i/mzEnxpR7jjtAv8WYv8tJap14iMOJbHlTgf6W
         f2oQ==
X-Gm-Message-State: AOJu0YzIM1yOsZXBt3LsTIuzHBfdF2n9H+dLBRSN5OyrBsvlyWcg67Kx
	XZvszoXHQ38E0eWvoMY3i8wNmhDSzuNc2YxH/cmQJnEIgo/isiiu
X-Google-Smtp-Source: AGHT+IHGg7D0/i/XNL21Jd1Jrq2AVciAQHdM/9xDySXG7DDbZjgNNyKvq6Mvyr/GuvZiW6oXreIHuQ==
X-Received: by 2002:a17:907:2d08:b0:a7a:8284:c8d6 with SMTP id a640c23a62f3a-a8394f79079mr131815966b.24.1723785964699;
        Thu, 15 Aug 2024 22:26:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d332sm198253166b.224.2024.08.15.22.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 22:26:04 -0700 (PDT)
Message-ID: <ea38ce1d-0b6c-4a49-82f1-4c3d823525b4@kernel.org>
Date: Fri, 16 Aug 2024 07:26:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
References: <20240815125905.1667148-1-vadfed@meta.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240815125905.1667148-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 08. 24, 14:59, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design.

Care to link it here?

> Implement
> additional attributes to expose the information. Fixes tag points to the
> commit which introduced the change.
...
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -316,6 +316,15 @@ struct ptp_ocp_serial_port {
>   #define OCP_SERIAL_LEN			6
>   #define OCP_SMA_NUM			4
>   
> +enum {
> +	PORT_GNSS,
> +	PORT_GNSS2,
> +	PORT_MAC, /* miniature atomic clock */
> +	PORT_NMEA,
> +
> +	PORT_NUM_MAX
> +};
> +

The conversion to the array needs to go to a separate patch, apparently.

> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	struct ptp_ocp_serial_port *port;
> +
> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);

uintptr_t is unusual as Greg points out. It is a correct type per C99 to 
cast from/to pointers, but we usually do "unsigned long". (int wouldn't 
work as it has a different size (on 64bit).)

But looking at the code, uintptr_t is used all over. So perhaps use that 
to be consistent?

> @@ -3960,16 +4017,16 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>   	bp = dev_get_drvdata(dev);
>   
>   	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
> -	if (bp->gnss_port.line != -1)
> +	if (bp->port[PORT_GNSS].line != -1)
>   		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS1",
> -			   bp->gnss_port.line);
> -	if (bp->gnss2_port.line != -1)
> +			   bp->port[PORT_GNSS].line);
> +	if (bp->port[PORT_GNSS2].line != -1)
>   		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS2",
> -			   bp->gnss2_port.line);
> -	if (bp->mac_port.line != -1)
> -		seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->mac_port.line);
> -	if (bp->nmea_port.line != -1)
> -		seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->nmea_port.line);
> +			   bp->port[PORT_GNSS2].line);
> +	if (bp->port[PORT_MAC].line != -1)
> +		seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->port[PORT_MAC].line);
> +	if (bp->port[PORT_NMEA].line != -1)
> +		seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->port[PORT_NMEA].line);

Perhaps you can introduce some to_name() function (mapping enum -> const 
char *)? Can this code be then a three-line for loop?

> @@ -4419,20 +4460,21 @@ ptp_ocp_info(struct ptp_ocp *bp)
>   
>   	ptp_ocp_phc_info(bp);
>   
> -	ptp_ocp_serial_info(dev, "GNSS", bp->gnss_port.line,
> -			    bp->gnss_port.baud);
> -	ptp_ocp_serial_info(dev, "GNSS2", bp->gnss2_port.line,
> -			    bp->gnss2_port.baud);
> -	ptp_ocp_serial_info(dev, "MAC", bp->mac_port.line, bp->mac_port.baud);
> -	if (bp->nmea_out && bp->nmea_port.line != -1) {
> -		bp->nmea_port.baud = -1;
> +	ptp_ocp_serial_info(dev, "GNSS", bp->port[PORT_GNSS].line,
> +			    bp->port[PORT_GNSS].baud);
> +	ptp_ocp_serial_info(dev, "GNSS2", bp->port[PORT_GNSS2].line,
> +			    bp->port[PORT_GNSS2].baud);
> +	ptp_ocp_serial_info(dev, "MAC", bp->port[PORT_MAC].line,
> +			    bp->port[PORT_MAC].baud);
> +	if (bp->nmea_out && bp->port[PORT_NMEA].line != -1) {
> +		bp->port[PORT_NMEA].baud = -1;
>   
>   		reg = ioread32(&bp->nmea_out->uart_baud);
>   		if (reg < ARRAY_SIZE(nmea_baud))
> -			bp->nmea_port.baud = nmea_baud[reg];
> +			bp->port[PORT_NMEA].baud = nmea_baud[reg];
>   
> -		ptp_ocp_serial_info(dev, "NMEA", bp->nmea_port.line,
> -				    bp->nmea_port.baud);
> +		ptp_ocp_serial_info(dev, "NMEA", bp->port[PORT_NMEA].line,
> +				    bp->port[PORT_NMEA].baud);

Maybe even here with if (iterator == PORT_NMEA)?

-- 
js
suse labs


