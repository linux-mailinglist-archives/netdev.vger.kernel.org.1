Return-Path: <netdev+bounces-264261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHycHpFTqWmG5QAAu9opvQ
	(envelope-from <netdev+bounces-264261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:57:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001620F23A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBFE030065E7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C63793C2;
	Thu,  5 Mar 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ8o35VZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08419DFAB
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704622; cv=none; b=Gv4f+MTHpcL5RdiyKL+xQoeTfgOpS7hOLR4BhZMmazS45BTXgq6YxCpAAhZM/j18hn8qvKqr2IhOkVlOBmVHWPqLZsPOneOEuGoDqRjsQBQ9WHwe3J7Z/jLmu2ZYKBAyyoLro8kPp5U4kM85ZcbKuW3ErJxYgrclPEewNO3/fsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704622; c=relaxed/simple;
	bh=R4o8LmzUXpzex1d7EeK2gX5l1LpwQHAZjoxay6bMrc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvMizcuVrecG+hxCx2Lhi4oHcY15SA1rZ2oqsm5vLnqh7j4SKloUGrXYezr+SCJV+nt+8I8d3YUI0Coz5xb0bTzkueDOnFkMnVA6iGRLUAvhtpUsx0AqdQHJnc72yW/xEqF8wGGQWR6yDNXRj8Tv0H4u6X1JrhXSrCzFSwbwyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ8o35VZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4830f029407so14276715e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772704620; x=1773309420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbmCDjNl+TQje26CyVv5dT/rLJSPHA1oxjNl1owywyI=;
        b=HZ8o35VZfypQLkgCDw3gwCiy70LVEnyFTeGq7JLW6ZLivv17i/JEnlRaYFFRlfNGvX
         TzL4SO+hj9WuHsMGBrG8RCdymH1Vrcq3lg2HdkgvkSuZNZkUktlWcwSUxo2Wyp9i6LVD
         j8AvCdoERa9gkMO2NthaGUoMl28h6I0oUT/pzEJAbIYC0OYnc9aT1fXyzzPEeootCmtD
         NhvGmVprRyZ31tSmYLUxNtDPyqVDOWZvRf/IXLE5dQhMhAzERCSizyvBMI6vnHdCz2NW
         LlHcvE+ZRr5XKVNoe/tiUfD838Z5yIPvfDr0reTcCFLAEEP7mCosmHB7ARf5HtR5Wmaf
         FPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704620; x=1773309420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbmCDjNl+TQje26CyVv5dT/rLJSPHA1oxjNl1owywyI=;
        b=Wavq56LVmSTtgGqi3Es1/0UeDoZEUvF6kWVr5jqU1iYgbkcl2IffEOrZT1q39QPy3r
         l35k0hd873WVEHTPvGBk+goh/uFxGPeU4KrZKNG59ozRrMW8OryWHyJHK3aNGJjXmRgv
         EGlz5dXVfCGTmIJ44rklcflZySYQRGBEjN/0RcYKpOkAXFR5bxsANlk1SHfnv+DTidM+
         vui0LwMk5xyHW07lIBi9lAxrYOYm8wXGiuBpEpIvxsqsxBvj6SdbFIfWA3uClWQ+7+eJ
         qPBAdmDw8+gMQk9VbJJIiKueu79ClpH3OPcx1i6GTiuEbaKRRi78peNMp3tK9OpNyLm2
         HRHg==
X-Forwarded-Encrypted: i=1; AJvYcCWhkAZ27csqS/BaVJbd9AdQ8857d0Moe6X6J8HU+Hux0okXWZhE2ApKUoB8POmcxOWNrP5yGZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNyP7qpf0Buv2N7SBb44hE8dROfdte87V8UhuDbMR11q+sCGg
	k4rNKrc3G1XLpr6m8tmlBFAGgEcL2lg/POyRHIaE27hH+DYLkj4ZfmLX
X-Gm-Gg: ATEYQzwjnvWJp4pTbmGXN4DDwPduqHYcNN7i8nFUg6skyrNmHuioQeOV2SPZrYbpljU
	rpcpVwAIbSgCR82fE4pIUqJuMKJ7lRGGeWH7fCJU9VKuhG7gcs8IKQ39ezNp8nCyIZHUtAkzjeM
	godJ7Q7objKF7CqOA5BUk/zHM7CC6K+cekh/mj7IXV/ueH7mf80jAYRuOVfTfMLpBZfxmfm60JA
	Lc+QwKTzYwYqI35JZEmXx2idce4m7thdpbX9zQjdpWpaFuXlM5iz6kkzPUczUHl5hhUdgOSvPLK
	YbgzwZ/PB3qw/uxcf1Xrk2pEDC19z1eYlRoAgJnFEIfk6iL6/pUlbG4BtU4SxIxc2GkvTdKsFok
	W4yp6V19Ts2OSEAs1Q5CmIjZ08b8DVdBVcRLeqcIkSkgH+zCWWr9Js3Fyq6jivkDZrIb3rGlUBa
	3PoRS6jFfM3BsBN9oT9ljYhvnUKQ==
X-Received: by 2002:a05:600c:81c8:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-48519863aebmr48569575e9.4.1772704619462;
        Thu, 05 Mar 2026 01:56:59 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm33366173f8f.12.2026.03.05.01.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:56:58 -0800 (PST)
Date: Thu, 5 Mar 2026 11:56:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260305095656.vlyaztv6nbdqrmil@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
X-Rspamd-Queue-Id: 2001620F23A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264261-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:18:52AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> @@ -2890,14 +2899,18 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
>  	unsigned int nhandled = 0;
>  	struct ksz_device *dev;
>  	unsigned int sub_irq;
> -	u8 data;
> +	u16 data;
>  	int ret;
>  	u8 n;
>  
>  	dev = kirq->dev;
>  
> -	/* Read interrupt status register */
> -	ret = ksz_read8(dev, kirq->reg_status, &data);
> +	/*
> +	 * Most of the KSZ switches have a 8-bits long interrupt status
> +	 * register, but the KSZ8463 has a 16-bits long one. The overread here
> +	 * is safe because we only iterate over kirq->nirqs in the below loop.

FWIW, this isn't the only thing making an overread "safe".
If the adjacent register also has "clear on read" semantics, that's not
good.

I can't tell whether that's the case here, though. There are just too
many hardware variations to check for. I just wanted to point out that
the reasoning is incomplete.

> +	 */
> +	ret = ksz_read16(dev, kirq->reg_status, &data);

I guess I don't fully understand the KSZ_REGMAP_TABLE() layer, but I
have a concern here.

Take the normal ksz_girq_setup() case for example, where we set
kirq->reg_status = REG_SW_PORT_INT_STATUS__1.

With ksz_read8(), we read u8 data from address REG_SW_PORT_INT_STATUS__1.
With ksz_read16(), how do we read u16 data? Don't we read
data[15:8] from REG_SW_PORT_INT_STATUS__1 and
data[7:0] from REG_SW_PORT_INT_STATUS__1 + 1?
But then we still look at the 0..kirq->nirq bits, effectively from address
REG_SW_PORT_INT_STATUS__1 + 1 now?

Or are the registers at address i 16-bits wide without spilling over
into address i+1? Because if that's the case, I don't understand the
comment/concern about overreading.

>  	if (ret)
>  		goto out;

