Return-Path: <netdev+bounces-122305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7DD9609D4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFCC1C22A6F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3DD1A0730;
	Tue, 27 Aug 2024 12:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16A19DF97;
	Tue, 27 Aug 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761103; cv=none; b=JC99kI5Y7oFFxYB9ie+bxBiClmbt8TFUXRPgoGLLjfiB5LqxdmU//U/u2sXG+76yTw17VqMPL88qyG8N5RRFmSlAcmNRv96mHut55BnXmPhx8t9/aAK+I6DLd7zzbMZ3iTJmmwTeiHxwbNWMcsYqJC0sAEIKi7TMm0kCkAeqBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761103; c=relaxed/simple;
	bh=XrKo7BgEbXwr0g6lhrGm2tqmwrC0mCd15I5ko3rQJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYbn3Esh5yHAVIIaCHfe+4VL/r70dRKFKfSviga/OpIyd7JN5BUSyavQ3693kUE/yvcNVwL0Z99ckBI6UmXaLsx4kvSEBJZ3uwasrfJfEaWaHvSEu2zAbHVRunZvnJPglKBWLU0KiuhwPpSig84l8PPqdAVIxtfAt599kbG6HkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a868b739cd9so652105166b.2;
        Tue, 27 Aug 2024 05:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761100; x=1725365900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ldg0C6C8gUg0Mw1/T0yY1ppe51hsxkql3LZnSGcFOtA=;
        b=YlXQKxJpabqVSQMQhQZ4d9R9B4gykFSJiZWQ178Aczp1ypAK4XURpqMWtdWa0SgE73
         SwHFS0hNQMj1O0qL5jM4gJRLXP2ap4Bi5T72/4HW8nArYKwtCH06DxHKGPRfqXRxu2M+
         KIUnGXLFhWzkH8QhmYU4J8+ldYQ6Gtsu/OKn5thBSgVY9i6lFiCmL4Caf+sPsFpdq4HJ
         RZNl/6rMnJeg54supgz+IqnZjwbb12qYbui0BmiYIBxFNJ4h18uwwJ8IYDwMps7ee4mr
         ZWOMlCRbHEEqsTCUSDBNZqhCrFrYQXt9wgYRuvKpxiLcdxz/S8i+2I8/VSddpx4hxYZz
         DGPg==
X-Forwarded-Encrypted: i=1; AJvYcCVE1/Y+zOXCGkDZjcdrQD5crwltqSTfJ2kf4cufyNSIjDbbQE6i99R6qCw+JqlmgGie6QUmrOq1@vger.kernel.org, AJvYcCXofD/A+5i4tGicW71Hr5SYp5nmw7gFgHDleMr/Qbav1zFp/UPcHgEJ710oA/n8Pm066482f3yJvVP9Zic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD62OqJtTntYmr5OqIQCVy/bsTJzIsSstWkOty2BSUuAsXkz0R
	s2cRN1ReeR01L+4tWFtFjnspAx1vCytgbjBn4tgMxRzAoztRS61u
X-Google-Smtp-Source: AGHT+IEVsjDlS+XlwCWM4HBqYlpFnazL068brbR7e3UpU7b1vz8wW2TMS6o2/Q4dAr7xGxt73Kt+Ug==
X-Received: by 2002:a17:907:5c8:b0:a80:7ce0:8b2a with SMTP id a640c23a62f3a-a86e39dc919mr195156666b.19.1724761099688;
        Tue, 27 Aug 2024 05:18:19 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm103689966b.130.2024.08.27.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:18:19 -0700 (PDT)
Date: Tue, 27 Aug 2024 05:18:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <Zs3EB+p+Qq1nYObX@gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240824215130.2134153-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824215130.2134153-2-max@kutsevol.com>

On Sat, Aug 24, 2024 at 02:50:24PM -0700, Maksym Kutsevol wrote:
> Enhance observability of netconsole. UDP sends can fail. Start tracking at
> least two failure possibilities: ENOMEM and NET_XMIT_DROP for every target.
> Stats are exposed via an additional attribute in CONFIGFS.
> 
> The exposed statistics allows easier debugging of cases when netconsole
> messages were not seen by receivers, eliminating the guesswork if the
> sender thinks that messages in question were sent out.
> 
> Stats are not reset on enable/disable/change remote ip/etc, they
> belong to the netcons target itself.
> 
> Signed-off-by: Maksym Kutsevol <max@kutsevol.com>

Would you mind adding a "Reported-by" me in this case?

https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 9c09293b5258..45c07ec7842d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -82,6 +82,13 @@ static DEFINE_SPINLOCK(target_list_lock);
>   */
>  static struct console netconsole_ext;
>  
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +struct netconsole_target_stats  {
> +	size_t xmit_drop_count;
> +	size_t enomem_count;

I am looking at other drivers, and they use a specific type for these
counters, u64_stats_sync.

if it is possible to use this format, then you can leverage the
`__u64_stats_update` helpers, and not worry about locking/overflow!?

> @@ -1015,6 +1035,25 @@ static struct notifier_block netconsole_netdev_notifier = {
>  	.notifier_call  = netconsole_netdev_event,
>  };
>  
> +/**
> + * count_udp_send_stats - Classify netpoll_send_udp result and count errors.
> + * @nt: target that was sent to
> + * @result: result of netpoll_send_udp
> + *
> + * Takes the result of netpoll_send_udp and classifies the type of error that
> + * occurred. Increments statistics in nt->stats accordingly.
> + */
> +static void count_udp_send_stats(struct netconsole_target *nt, int result)
> +{
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +	if (result == NET_XMIT_DROP) {
> +		nt->stats.xmit_drop_count++;

If you change the type, you can use the `u64_stats_inc` helper here.

> @@ -1126,7 +1167,11 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  			this_offset += this_chunk;
>  		}
>  
> -		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
> +		count_udp_send_stats(nt,
> +				     netpoll_send_udp(&nt->np,
> +						      buf,
> +						      this_header + this_offset)
> +		);

as Jakub said, this is not a format that is common in the Linux kenrel.

