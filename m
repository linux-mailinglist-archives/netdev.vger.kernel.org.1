Return-Path: <netdev+bounces-261066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHq8G3dJn2lEZwQAu9opvQ
	(envelope-from <netdev+bounces-261066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:11:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDFF19C97C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE45030160C5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E573E9F9F;
	Wed, 25 Feb 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmarjDkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011933ADA1
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046709; cv=none; b=WIwOpMkpxobdIUCxewPtzprGKPzXpgXIwS4TkHEZ6I8TUpF/Kt74SOe/lDwAgdYFs5lhBEf66Xa+Uh4HP4xV+M8YW3DPtZwFzlDoE9F4uEtoSJlwHD2wphuWaV5S4o7OBbgizIrUeMIQvnESnYE3XnV6uVI4yoiT21JJGHOd4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046709; c=relaxed/simple;
	bh=FnDd5eNGT7mxmTViTVoSjme7ik4tMeLKewxwF8SBya0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+R+h+lGOtOVhcAOvEz3Xr5DcZ+CqaM0BR879a0e49jyh6CG1pT7z+94xv7l7ZXCJhfh8zFKLu72jQLU8Vv4MNLXb8/Clg6qFFzRt4lB8gBPW5w6QMrhHQX+vxh4mcZpw1aHeEpJ+Sx+EU5KnbQh8ELDuVwgl7TfKrkOMUs2JLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmarjDkN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba895adfeaso17279eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772046707; x=1772651507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0HSZ4dYExbCoLjG4OZkeT7LbBNxZ6IbEkBrJwEZh98=;
        b=HmarjDkNDuQuIhFR8YXwyPTKMfwYtNo4apvOqzcnH7GdAqvQhvJKtNb3PnlLuT4tBM
         yXSpQi+6+PP1Wt4TmlPw0PwYEA9ZI21/IXtT9EkKdDAb47y3/vLZloGGipjFX3FfCGM0
         mr/g9INDnsffR6b7WdbtLvRfK2drpsY/irOKiKrprPj9sdyXTNXuIFd0oqgav9831RZS
         JhT5U8BvBHGltz7mj6a813i2I7SF8ELrpRg9Ouu1K27pjJUTW0o43v9W7IsBV5068qXA
         QL8Q9LlnG4HCZ+XvXLVLvi0CdtNIzCwmyt+8p757niKecuGeQC44KjpabeH/dTSAyVQi
         pULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046707; x=1772651507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z0HSZ4dYExbCoLjG4OZkeT7LbBNxZ6IbEkBrJwEZh98=;
        b=NOf6dhY4+6XMEyShCUnlOiKkE/mNa7a1PdFP2CIwOlQCY4CgshmmXFhqN1H+88nUcu
         OY7UOm7KPUcuYnV9foztsqWnvviuvsJC/FH5lyGuZbkqjJvle//lPZJ57svN/xQgN86/
         tH5dL22yjf9jKuFJZ7cN6sNjKX4HH2aFmJ3frVnftIHfNVP9sp98ONUFiYtB7gM8vKXk
         zAoV2S3clqko4il2/XbF5+7DM4tFNlDDEtRklo/i7mAW/HpNno/aprZVUKiwwAaR3zrT
         SC8am8gwvh7u1TEKloxqbJdc1JE6e8SeaxfkBQmH9UDAyxWVphz+PC7CJ9WRw3LVcjQQ
         w4tA==
X-Forwarded-Encrypted: i=1; AJvYcCX9P7bG/fYIlBtaeXVg1vSskn40IWOLWE8EE5TWHnvb06N/goCC2YILY2iaWuWJoX0sB/vm3dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjPOfPP2iaW6lYrNUCInVzi9jBHMoDFDziK9vBvKdfGBY86w4
	oFSlHy8u9uurlxQUQrYNhny8V8C+6+v1i2dHRSMHQa29Qcud+B3m/QFZ
X-Gm-Gg: ATEYQzw0uQO0oZVulwwTRoqySrcROR5xivb274sN1kktCgJE5zzOP8COXtR7BW8vzQu
	4BlY2yyp1/AOr6cPx5UvaORW/Od8Lqt/OEcsR/oia86BEpdNWAUEJPuvIi2GrU19ZNNcGd+ECJ7
	NOjCelwxdzo82T9b++5/e55PyplMreJRqH3SBPoSnW4MOq9BagVOfKvI0DP1bsv3RpQC1KqSvwP
	MQkImNfy0Idb1ueE35CDVtRMmskXEihZ8BmCde/R9WddNhgDHdteKnoD2Fmp63kWtsfgKxO7Wsg
	LROAfm8xXNxR/VUnwFL+gwSSYdbSv3B3JVVGNfkOEdqz8d2mDlRD2QqC4oZSjjQCwV2lUAJZhE9
	BdPWXCs0amOogkhat3hwgOoBBW9ZKp4SekP7YrNzyS357c23Bzev/Q2sBhtrhsZMeY8qUYIXjc0
	VzpFBnk74V2tDrSK6lnKByXbPY5QRxfBIiGKkZ1Y5HMhNnfno=
X-Received: by 2002:a05:693c:3944:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2bd7bd24e03mr6487750eec.29.1772046706806;
        Wed, 25 Feb 2026 11:11:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm10914523eec.24.2026.02.25.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:11:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 25 Feb 2026 11:11:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH net] dpaa2-switch: add bounds check for if_id in IRQ
 handler
Message-ID: <6027f2f2-43ab-41f9-9fd3-c91c4ae7a70a@roeck-us.net>
References: <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,roeck-us.net:mid]
X-Rspamd-Queue-Id: DBDFF19C97C
X-Rspamd-Action: no action

Hi,

On Thu, Jan 29, 2026 at 12:55:13AM +0800, Junrui Luo wrote:
> The IRQ handler extracts if_id from the upper 16 bits of the hardware
> status register and uses it to index into ethsw->ports[] without
> validation. Since if_id can be any 16-bit value (0-65535) but the ports
> array is only allocated with sw_attr.num_ifs elements, this can lead to
> an out-of-bounds read potentially.
> 
> Add a bounds check before accessing the array, consistent with the
> existing validation in dpaa2_switch_rx().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 24ab724f8a46 ("dpaa2-switch: use the port index in the IRQ handler")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index b1e1ad9e4b48..33f0842b5dc9 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -1531,6 +1531,10 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
>  	}
>  
>  	if_id = (status & 0xFFFF0000) >> 16;
> +	if (if_id >= ethsw->sw_attr.num_ifs) {
> +		dev_err(dev, "Invalid if_id %d in IRQ status\n", if_id);
> +		goto out;
> +	}

An experimental AI code review agent produced the following feedback:

Will jumping to the out label here cause an interrupt storm?

It looks like this bypasses the dpsw_clear_irq_status() call at the end
of the function. If the hardware interrupt status isn't cleared, it might
leave the interrupt asserted and cause the handler to trigger continuously.
Should this code clear the status before returning?

It seems to me that it has a point, and that the code should at least attempt
to reset the interrupt status. Please let me know if this is correct or
if this is not a concern.

Thanks,
Guenter

>  	port_priv = ethsw->ports[if_id];
>  
>  	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
> 
> ---
> base-commit: a040afa3bca415019d96a586b96b5f17b1f55a90
> change-id: 20260129-fixes-98a0f7607a88
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
> 

