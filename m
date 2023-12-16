Return-Path: <netdev+bounces-58177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CB8156EB
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 04:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D8C287AD7
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACBA23D4;
	Sat, 16 Dec 2023 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Yf/0Qb7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDB32C64
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1079845a12.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702697427; x=1703302227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvJvZX9MVMaNFrVGKDw+JqESfxfEY0+7o4ksFuEFYe4=;
        b=Yf/0Qb7dWqWK4NnTDfg5tAtz1lt0p6FQTv16+ySDKSOgMhjB1D7AkWUVlMILFROlWD
         lrRNV4WfSwJ4MUtanhC+K0o8vl7sZAXC0RJq9hcODJdcZ4pzYA2JAmNxTlFXmTEZCxek
         zhWc7faY1xpF3TzwllPjjv4qBHyue3C2tgQ8I+1f8H41pdwiAC4/4Rjp6PaTx91ON5+W
         3CCMAfnDlysKb+DaMfKSpKTaUTj7fzu8u/Y4PCe49Pdtgutx/JMclqBKxDg57WPrdJFF
         1pnu80cYvpKfEf2fL7mqDWhrk5cT+PXn6AXImqIocl2OhhBFr1jTWiKWaHdYKd7NSiGo
         7xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702697427; x=1703302227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvJvZX9MVMaNFrVGKDw+JqESfxfEY0+7o4ksFuEFYe4=;
        b=t0yVGcW4dpFDaOJUWAjh0Qes/bY2RyjexNTHavhuF5rkbpQo9UgXkzWzIKx8q30dVP
         cPYE73kIS8JNwDEQTW/Bp1QHpYxzzcHnSnU5WwCt0AS2FPplkx6ghNcetOO1XJjfFD8R
         cfav/SgtEVQDnpThlIult8C3s0s6960rMWOOnfzZqjbUQltplarqRgY66Sc65ZApoBzQ
         Z8SfVZLHufHUgqJE9RLcs18N7VtUtrS9CIM8jWGRU2w74C+UT+mawMFhpCyafdyOj9OE
         9Ljogl69y/6MX6vReKqZex4k6MHOsVBmYlyoHShGQBWoIIYtdFSzBlrjo9TnKa8vBlwR
         jZtA==
X-Gm-Message-State: AOJu0YwhfDJWLySRhw9ebbszekAq08n7ZKWCbVZZ4vL14gEXu6u7Qfb1
	HM+J3GPRNaa+BIpXJYzt8w13AQ==
X-Google-Smtp-Source: AGHT+IG6s8lfUZo0Vxcy0w9JOjCtXYSHv/DZCAkJhN2T5J+mSH0L5DYWqC5tRqgOciFsbejRWHeRjw==
X-Received: by 2002:a05:6a20:100b:b0:193:fd0c:a268 with SMTP id gs11-20020a056a20100b00b00193fd0ca268mr1376550pzc.29.1702697427348;
        Fri, 15 Dec 2023 19:30:27 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ka38-20020a056a0093a600b006d28dec8a40sm506709pfb.56.2023.12.15.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 19:30:26 -0800 (PST)
Date: Fri, 15 Dec 2023 19:30:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, mdf@kernel.org
Subject: Re: [PATCH] RFC: net: ipconfig: temporarily bring interface down
 when changing MTU.
Message-ID: <20231215193024.02819d85@hermes.local>
In-Reply-To: <20231216010431.84776-1-gsmecher@threespeedlogic.com>
References: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
	<20231216010431.84776-1-gsmecher@threespeedlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 17:04:31 -0800
Graeme Smecher <gsmecher@threespeedlogic.com> wrote:

> Several network drivers (sh_eth, macb_main, nixge, sundance) only allow
> the MTU to be changed when the interface is down, because their buffer
> allocations are performed during ndo_open() and calculated using a
> specific MTU.
> 
> Kick-tested using QEMU (rtl8139, e1000).
> 
> Tested-by: Graeme Smecher <gsmecher@threespeedlogic.com>
> ---
>  net/ipv4/ipconfig.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index c56b6fe6f0d7..69c2a41393a0 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -396,9 +396,21 @@ static int __init ic_setup_if(void)
>  	 */
>  	if (ic_dev_mtu != 0) {
>  		rtnl_lock();
> -		if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
> -			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
> -			       ic_dev_mtu, err);
> +		/* Some Ethernet adapters only allow MTU to change when down. */
Check if interface was already down first.

> +		if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))

Please do not combine function call with err test. Surprised checkpatch doesn't complain about hat.

> +			pr_err("IP-Config: About to set MTU, but failed to "
> +				 "bring interface %s down! (%d)\n",

Don't break lines in error messages.
> +				 ic_dev->dev->name, err);
> +		else {
> +			if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
> +				pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
> +				       ic_dev_mtu, err);
> +
> +			if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))
> +				pr_err("IP-Config: Trying to set MTU, but unable "
> +					 "to bring interface %s back up! (%d)\n",
> +					 ic_dev->dev->name, err);
> +		}
>  		rtnl_unlock();
>  	}
>  	return 0;


