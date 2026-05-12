Return-Path: <netdev+bounces-286971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDCaJffPAmoXxgEAu9opvQ
	(envelope-from <netdev+bounces-286971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:00:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA551B674
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DC330156E3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5440855;
	Tue, 12 May 2026 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJ5mYdYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91E36F8E9
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569200; cv=none; b=DgGXl8l937DGD1aNIQLXeny/kvJjtXit/IEoUqAUl/rpvYTRfnLktfpjOyCozOJbzgCcE0rLLDJBxvy5pIF4mKsZDMYmF9lBvj+W9Umv5YyaD0yqpY44TGIZabfIpW3ZXqrlKkCKlODDjx8Ckt5Wmt4WjR1vRVMbBWNXuaw9U9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569200; c=relaxed/simple;
	bh=jkciTllYk6CF6sRnmPRvot2mO2RNOjSUmV3yCZOiUUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX+qIoFPFJMP6+QcqQgnYkHdLA2wcauS5CEdqq0RLeyh49Zkkn5ddiy7M050iwOoDFBxYtMqpWiK84C7qCnJICar3kpADg8N3LpY+QlSLsv6XT8HqYETKDGWMnhPAcD7HoeuWMFaSGebP2uQ1HKDV2A4heFftoGfwb6/GUY+FeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJ5mYdYv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 620804E42C11;
	Tue, 12 May 2026 06:59:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EDBE60646;
	Tue, 12 May 2026 06:59:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F8CE11AF82F7;
	Tue, 12 May 2026 08:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778569187; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ifWJI6u4+GlWnZV6F3nXd/Owj+owW9w1lKV/Fx3tyFE=;
	b=RJ5mYdYv/VtDs7i2NcQ7mEpvXHUr56Rb50swwE/9k5Ww4Fh9F9wweyzWH3Gtbkqj0C3U6o
	3yef/oLQgep8Qxdp3YmLmza+n5k/9PiP4AQZIoGN7BT7mD9zHwtAgn3nuS+SCVF7OKfS78
	h195CzezzMO01Kd/LTM1D73KGRx7eBWTIgnw9NXeD34JSKtP3tpkyarCoDbCpKlaAtXAhP
	RV+Oy3984Ip6OrqSvTBWFD311HLb0f0QxLF7QtyRljiy2ZqCb2KAqQQNB1kyPQ5A+7l+nY
	SMGDPa5KGI2K6/8p0YwTKcyStTC94QCKlm9XYSlV5GvIDVvgWnjkBj5RVtFqsg==
Message-ID: <75232e5f-4370-42db-8d54-1dbcc1816fd7@bootlin.com>
Date: Tue, 12 May 2026 08:59:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: phy: avoid NULL deref when PHY driver
 is unbound
To: David Carlier <devnexen@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260509215046.107157-1-devnexen@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260509215046.107157-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 15BA551B674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286971-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi,

On 5/9/26 23:50, David Carlier wrote:
> phydev->drv can become NULL while the phy_device is still attached to
> its net_device, namely after the PHY driver is unbound via sysfs:
> 
> 	echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind
> 
> phy_remove() clears phydev->drv but doesn't call phy_detach(), so the
> phy_device stays in the link topology xarray and ethnl_req_get_phydev()
> still hands it back. ETHTOOL_MSG_PHY_GET then oopses on:
> 
> 	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
> 
> drvname is already treated as optional by phy_reply_size(),
> phy_fill_reply() and phy_cleanup_data(), so just skip the allocation
> when there is no driver bound.
> 
> Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
> Cc: stable@vger.kernel.org # 6.13.x
> Signed-off-by: David Carlier <devnexen@gmail.com>

I was able to reproduce the bug, and your fix does solve it.

Thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>   net/ethtool/phy.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index f76d94d848d6..ddc6eab701ed 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -94,10 +94,12 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>   	if (!rep_data->name)
>   		return -ENOMEM;
>   
> -	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
> -	if (!rep_data->drvname) {
> -		ret = -ENOMEM;
> -		goto err_free_name;
> +	if (phydev->drv) {
> +		rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
> +		if (!rep_data->drvname) {
> +			ret = -ENOMEM;
> +			goto err_free_name;
> +		}
>   	}
>   
>   	rep_data->upstream_type = pdn->upstream_type;


