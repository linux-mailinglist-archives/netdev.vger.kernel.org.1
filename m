Return-Path: <netdev+bounces-263653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EuV2D77wp2mGmgAAu9opvQ
	(envelope-from <netdev+bounces-263653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF371FCC7C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6A4E3008683
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5213F39182D;
	Wed,  4 Mar 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="EWKmy0JW"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B3390C98;
	Wed,  4 Mar 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613813; cv=none; b=JeyRldJRcDSkF6SKigovb9NnKk9GL4piWMjMokFWYlqVTIlyL0LuwuFaw3Nnl3DXRZ/Bav3RULyHO5ud6mD8KWo0u5LKKDztzh9+e0Js3oz4/cBvo3jYG7y4MF6ITO31lQz7SewUjZlDvF9jHzlZOnuuhwP2POxobbj4D+/6VBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613813; c=relaxed/simple;
	bh=KsdkQrCVwXharfWSfthTCrBeLRAtyjE1nS2WAo2eSIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/Bf9tSE30SuhCR15JahAYxZI3Tt/fGlYva3Xr6OJh7K1ZeC1/yDFdOztR+r88BVGRloVdMTQgU13uambXMKoZoM5SoIhPTz2+Ixtz0WuFBlQctyutRPMyNt3WS8HKQ5OVF/U9W2Zhkh6yh4q9YTG1/I0v77yO9STpgry2M6cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=EWKmy0JW; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fQmQy6sGYz83x5;
	Wed,  4 Mar 2026 09:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772613803;
	bh=KsdkQrCVwXharfWSfthTCrBeLRAtyjE1nS2WAo2eSIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EWKmy0JWIFw5FU3NKL072hPKMSSM4jwf22Wy1QryEyniF6CXwx7Gxa47c+rU9mk5P
	 pnN40LQEzhgH938xSxEz+ZoPhBFPrP7oobtvzfxRAD9r4ew2N/KlNL33+L75klaA0V
	 KfR7PQqumPvMscA0xjFuO7S+mJrcsDAXXTnsVv7HR1K1V5igHhgyXZzQzUJ+sO98Is
	 aurn690+ODjh0nluY2RR+s36pYGudVtzKNuqlC5BkZZk7ez5E0D+iI261vdKRfbi23
	 5KBa0s/UHir0HQTkFaZi079ndUCsbzYIrsGDIVvSjEoACDUwzrzOED4pDqP623oPT6
	 3vxY05p1ZsgTw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fQmQy68Rrz83rY;
	Wed,  4 Mar 2026 09:43:22 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fQmQy10lZz8svF;
	Wed,  4 Mar 2026 09:43:22 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E7AB65F74A;
	Wed,  4 Mar 2026 09:43:20 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4c851eb9-b990-41c0-928e-ce5a1e597722@leemhuis.info>
Date: Wed, 4 Mar 2026 09:43:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi_wwan: allow max_mtu above hard_mtu to control
 rx_urb_size
To: Laurent Vivier <lvivier@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
 Stefano Brivio <sbrivio@redhat.com>,
 Koen Vandeputte <koen.vandeputte@citymesh.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260302102825.274385-1-lvivier@redhat.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260302102825.274385-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177261380148.3365887.14307366214397269586@mxe9fb.netcup.net>
X-NC-CID: w2sXJKrhjkjeFdA3LQxPiJsv/+koD6twakGv08sma2Mp8/rzY9o=
X-Rspamd-Queue-Id: 9DF371FCC7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,citymesh.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-263653-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/2/26 11:28, Laurent Vivier wrote:
> Commit c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")
> capped net->max_mtu to the device's hard_mtu in usbnet_probe(). While
> this correctly prevents oversized packets on standard USB network
> devices, it breaks the qmi_wwan driver.
> 
> qmi_wwan relies on userspace (e.g. ModemManager) setting a large MTU on
> the wwan0 interface to configure rx_urb_size via usbnet_change_mtu().
> QMI modems negotiate USB transfer sizes of 16,383 or 32,767 bytes, and
> the USB receive buffers must be sized accordingly. With max_mtu capped
> to hard_mtu (~1500 bytes), userspace can no longer raise the MTU, the
> receive buffers remain small, and download speeds drop from >300 Mbps
> to ~0.8 Mbps.
> 
> Introduce a FLAG_NOMAXMTU driver flag that allows individual usbnet
> drivers to opt out of the max_mtu cap. Set this flag in qmi_wwan's
> driver_info structures to restore the previous behavior for QMI devices,
> while keeping the safety fix in place for all other usbnet drivers.
> 
> Fixes: c7159e960f14 ("usbnet: limit max_mtu based on device's hard_mtu")

[disclaimer: I'm not a reviewer, just someone that keeps and eye on
regressions]

Given that the regression afaics was found in a stable series with that
commit backported, would you maybe we willing to add a stable tag to
ensure fast backporting to all affected series? See
Documentation/process/stable-kernel-rules.rst for all details, but
normally this will do:

 Cc: stable@vger.kernel.org

> Reported-by: Koen Vandeputte <koen.vandeputte@citymesh.com>

While at it: please considered linking to the report using a Link or
Closes tag like this

 Link:
https://lore.kernel.org/lkml/CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com/

That is something Linus really wants[1] and actually something that
Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst asks for.

[1] see here:
https://lore.kernel.org/all/CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

Ciao, Thorsten

> Tested-by: Daniele Palmas <dnlplm@gmail.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/net/usb/qmi_wwan.c | 4 ++--
>  drivers/net/usb/usbnet.c   | 7 ++++---
>  include/linux/usb/usbnet.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 3a4985b582cb..05acac10cd2b 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -928,7 +928,7 @@ static int qmi_wwan_resume(struct usb_interface *intf)
>  
>  static const struct driver_info	qmi_wwan_info = {
>  	.description	= "WWAN/QMI device",
> -	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
> +	.flags		= FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
>  	.bind		= qmi_wwan_bind,
>  	.unbind		= qmi_wwan_unbind,
>  	.manage_power	= qmi_wwan_manage_power,
> @@ -937,7 +937,7 @@ static const struct driver_info	qmi_wwan_info = {
>  
>  static const struct driver_info	qmi_wwan_info_quirk_dtr = {
>  	.description	= "WWAN/QMI device",
> -	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
> +	.flags		= FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
>  	.bind		= qmi_wwan_bind,
>  	.unbind		= qmi_wwan_unbind,
>  	.manage_power	= qmi_wwan_manage_power,
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index ed86ba87ca4e..b72ba0803392 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1829,11 +1829,12 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
>  		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>  			net->flags |= IFF_NOARP;
>  
> -		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> +		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
> +		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
>  			net->max_mtu = dev->hard_mtu - net->hard_header_len;
>  
> -		if (net->mtu > net->max_mtu)
> -			net->mtu = net->max_mtu;
> +		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
> +			net->mtu = dev->hard_mtu - net->hard_header_len;
>  
>  	} else if (!info->in || !info->out)
>  		status = usbnet_get_endpoints(dev, udev);
> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
> index b0e84896e6ac..bbf799ccf3b3 100644
> --- a/include/linux/usb/usbnet.h
> +++ b/include/linux/usb/usbnet.h
> @@ -132,6 +132,7 @@ struct driver_info {
>  #define FLAG_MULTI_PACKET	0x2000
>  #define FLAG_RX_ASSEMBLE	0x4000	/* rx packets may span >1 frames */
>  #define FLAG_NOARP		0x8000	/* device can't do ARP */
> +#define FLAG_NOMAXMTU		0x10000	/* allow max_mtu above hard_mtu */
>  
>  	/* init device ... can sleep, or cause probe() failure */
>  	int	(*bind)(struct usbnet *, struct usb_interface *);


