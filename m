Return-Path: <netdev+bounces-304149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P6liBBtRRmqeQgsAu9opvQ
	(envelope-from <netdev+bounces-304149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F766F710A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:52:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="hpqU/3DM";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304149-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4BD306F203
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A84842A7BB;
	Thu,  2 Jul 2026 11:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EA3C1F54;
	Thu,  2 Jul 2026 11:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992181; cv=none; b=o7c1lnKF/uPsG/yNjh9NusHd5JR7r5ih2f+qNfXJ6+x83TNX2LmPz3dNQTQdTCMOD26rr2JuY5YYgwLSjcg5EYoi6Qq1UqIkka6H61Fhb9zFiEnt/iO2J9hk3S7tRbP2xZBfn4dF+mBh1eaIpAhbkitvLeUfg4vLGVCM7clRwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992181; c=relaxed/simple;
	bh=WBsZvj1YrnX58paoW/oC3TjZ0/Gv4u7ilYA7XgCMMMw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MnK4DFxvB3IwSlrIdz9XMyIc3LWC2/hORPtfccC3Fxnnvu12+Jo/cmPtwout0/BVnHXjobXKbutDxeTuDdStP9V86WKlLm5TR21S6hpHwv7qCCSY640MehIc1P/tXTtxdiAyJ2i1MFTJxbhW1QX46zkeWcR8FUVy11hMiqY1Tb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hpqU/3DM; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18A6BA47CD;
	Thu,  2 Jul 2026 13:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782992175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j6ZsQauM6gIautaKWkv5Fv+2Mz2AdmTwz4GLhRe+aUc=;
	b=hpqU/3DMkCZCsAsjBZI3GxR2NCPAAiTnokDwocmGf1poIdcqxEiz7nqpfEgkL4SpBfFbJ1
	j565OgfUzUjczyl1/RC/Iv1kWXVhZIL0Ye8rOtKCkItf9J9jTAd/f9vWC3iKjEQleYUizs
	ugeeJzaATWnuLko+8OlmTMIEa5NlX7CcbJuOlMKMmWQGdnJ6puHGF86zHz1VOU44ZstNJv
	d6VF7T3RelbZxH8LAQFK/WShQpqjcveSevoeHoHD7yHfH+N8GdX3nFcNvB+9kc7oIPxpmP
	kX/FFLwBfkUuUt32vpIr9QCBd6R+imD3mMQyNXxSByphMKascWAMCHtVMoxWrA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 13:36:13 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: enrico.pozzobon@dissecto.com
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan
 Sundararajan <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
In-Reply-To: <20260701-lan78xx-vlan-promisc-v2-1-fe3b18066728@dissecto.com>
References: <20260701-lan78xx-vlan-promisc-v2-1-fe3b18066728@dissecto.com>
Message-ID: <aef78533a81c88a362885c24928a7c60@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:enrico.pozzobon@dissecto.com,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304149-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,msgid.link:url,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71F766F710A

Hi Enrico

On 1.7.2026 15:09, Enrico Pozzobon via B4 Relay wrote:
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
> Changes in v2:
> - moved VLAN filter logic into lan78xx_update_vlan_filter()
> - Link to v1: 
> https://patch.msgid.link/20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com
> 
> To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
> To: Rengarajan Sundararajan <Rengarajan.S@microchip.com>
> To: UNGLinuxDriver@microchip.com
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Woojung.Huh@microchip.com
> Cc: netdev@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/usb/lan78xx.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c4cebacabcb5..cb782d81d84f 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1499,6 +1499,17 @@ static void 
> lan78xx_deferred_multicast_write(struct work_struct *param)
>  	return;
>  }
> 
> +static void lan78xx_update_vlan_filter(struct lan78xx_priv *pdata,
> +				       struct net_device *netdev,
> +				       netdev_features_t features)
> +{
> +	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +	    !(netdev->flags & IFF_PROMISC))
> +		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
> +	else
> +		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
> +}
> +
>  static void lan78xx_set_multicast(struct net_device *netdev)
>  {
>  	struct lan78xx_net *dev = netdev_priv(netdev);
> @@ -1533,6 +1544,8 @@ static void lan78xx_set_multicast(struct 
> net_device *netdev)
>  		}
>  	}
> 
> +	lan78xx_update_vlan_filter(pdata, dev->net, dev->net->features);
> +
>  	if (netdev_mc_count(dev->net)) {
>  		struct netdev_hw_addr *ha;
>  		int i;
> @@ -3074,10 +3087,7 @@ static int lan78xx_set_features(struct 
> net_device *netdev,
>  	else
>  		pdata->rfe_ctl &= ~RFE_CTL_VLAN_STRIP_;
> 
> -	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> -		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
> -	else
> -		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
> +	lan78xx_update_vlan_filter(pdata, netdev, features);
> 
>  	spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
> 
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260623-lan78xx-vlan-promisc-83af8a48a7ec
> 
> Best regards,
> --
> Enrico Pozzobon <enrico.pozzobon@dissecto.com>

AFAIU the findings from Sashiko [1] on v1 are either false positives or 
pre-existing
issues unrelated to this change, so LGTM.

@Thangaraj / maintainers:
The mails to Rengarajan are bouncing since a few series - does the 
MAINTAINERS entry need an update?

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

[1] 
https://sashiko.dev/#/patchset/20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f%40dissecto.com

Thanks
Nicolai

