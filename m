Return-Path: <netdev+bounces-303492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ck/RL2C7RGr3zgoAu9opvQ
	(envelope-from <netdev+bounces-303492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297236EA6A4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:01:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=ECc5Rtjw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303492-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303492-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ECA430547F2
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A63B388B;
	Wed,  1 Jul 2026 06:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2911F0E25;
	Wed,  1 Jul 2026 06:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889087; cv=none; b=PUqrTCxq7yrhVUW995GyHGyXHrrCfN807gNutORrGGYO7gfYfKOaKMSHRaIGiqyfR+83uZesbhWeuro9oJEalIENORzUMTLGLVTYPkpKcGWkGqEVFFGuqA1RYfbksQJJgDm/4Nx/wpF3m/EIZ4LjREmaIV8d+W72JKKbOI+LfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889087; c=relaxed/simple;
	bh=bLdoS07tbGVp0trP/myZ9hyqCySu9UwIvaC5xa43064=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cBqf/hPqhc/0F8u39PmRrts9ITewjM1mE5MosjVJVLMF5mUGwmAd9BMhUE06lBo9LHUsFBUk9TYj5rjLDVl5rbEPj5oFMnmbUM0+yJBxLodYG7Kh7LHx+6vXWnNbqBG9NwNXdyFthSYQXECncbFOe7jpQdNErcco1YMogWgwfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ECc5Rtjw; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C86CA38D4;
	Wed,  1 Jul 2026 08:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782889074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f4MXihyQe/D1JcyYwuGidDbu2z428fVDqLCoOVo9Fkw=;
	b=ECc5RtjwiMclFiVSL5OJt3SfN3jQ5hY0grzQXHMb8+2W52nX0/KIqpKgYcaZ9BYS3KUrBt
	CZX1pP+APWFeftxw2bxJCbpmfGtKqsyv22truxGJdSjOyAfHatVZxuh/m/92ciB7yy+BHv
	B7E+bpIu0SRA9VEsURfrDH2BzIpEZUxCAIzbVTxRhM3JSfQ771VAZxIm7W3KPD1yyslH/4
	DsuLdmcnmuyg+Fto0d9s0u9XcNgrvFGPPGRcdYtWXMb5nHiR93Y6pzngimQzbiYV1+N/Lr
	+KkxF4NX6mkqGr27/vH9szEHVEzn5atiSJtIo8YNfJfjaXMQkz8Tx/DZ3hV09g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Jul 2026 08:57:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: enrico.pozzobon@dissecto.com
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: disable VLAN filter in promiscuous
 mode
In-Reply-To: <20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com>
References: <20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com>
Message-ID: <c5cd452bae7891e386458e93c0d2df45@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:enrico.pozzobon@dissecto.com,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303492-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dissecto.com:email,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 297236EA6A4

Hi Enrico

On 30.6.2026 16:15, Enrico Pozzobon via B4 Relay wrote:
> From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> 
> The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged 
> frames
> whose VID has not been registered via lan78xx_vlan_rx_add_vid(). It is
> left enabled in promiscuous mode, so packet capture (e.g. tcpdump or
> Wireshark) does not see tagged frames for unregistered VIDs.
> 
> Clear the filter while the interface is promiscuous and restore it from
> NETIF_F_HW_VLAN_CTAG_FILTER otherwise. Enforce the same condition in
> lan78xx_set_features() so netdev_update_features() cannot re-enable the
> filter while promiscuous.
> 
> Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 
> Ethernet device driver")
> Signed-off-by: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
> ---
> Currently, on microchip lan7801, enabling promiscuous mode does not
> result in VLAN tagged packets being captured. This patch fixes this,
> forcing the RFE_CTL_VLAN_FILTER_ flag to be off when promiscuous mode 
> is
> enabled.
> ---
>  drivers/net/usb/lan78xx.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c4cebacabcb5..a1a53ef85cb9 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1525,7 +1525,14 @@ static void lan78xx_set_multicast(struct 
> net_device *netdev)
>  	if (dev->net->flags & IFF_PROMISC) {
>  		netif_dbg(dev, drv, dev->net, "promiscuous mode enabled");
>  		pdata->rfe_ctl |= RFE_CTL_MCAST_EN_ | RFE_CTL_UCAST_EN_;
> +		/* bypass VLAN filter so all tagged frames are captured */
> +		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
>  	} else {
> +		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +			pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
> +		else
> +			pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
> +
>  		if (dev->net->flags & IFF_ALLMULTI) {
>  			netif_dbg(dev, drv, dev->net,
>  				  "receive all multicast enabled");
> @@ -3074,7 +3081,9 @@ static int lan78xx_set_features(struct net_device 
> *netdev,
>  	else
>  		pdata->rfe_ctl &= ~RFE_CTL_VLAN_STRIP_;
> 
> -	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +	/* keep VLAN filter off while promiscuous */
> +	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +	    !(netdev->flags & IFF_PROMISC))
>  		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
>  	else
>  		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;

nit: Could this be addressed as helper for both callers?

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

