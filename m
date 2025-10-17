Return-Path: <netdev+bounces-230592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9017BEBB63
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F317448C8
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52B354ADB;
	Fri, 17 Oct 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="D4Gj6rEj"
X-Original-To: netdev@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6752236E9
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733768; cv=none; b=ibxUWXvE2OWQIDqLAOQF1kKBm+KZDUNkNXhydMkhguZj0W5on4U1oKt6GwrDRA2nFcrJszrgnlNwA0455lp/Y1n0MCVrOCgZqK/BkGsTvkPkqMCIgj/7gwnbOzLhxEVkHYDNFo3s5agmS9ocf9t6Wi3pEV/JuXX431NEZCJ7tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733768; c=relaxed/simple;
	bh=SVcF/PaLAuGIFxe5zw6dhfXQYm8TZVZi3nYSoCFeUvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnQlBxaQ70II5q/q3IQ7krMARyCxeNQnskfpH22+XnY5QW3hWCgxImt12iq0eYMTMMTqwL7L2nUiY+Nrr+0knhGgDPobPiH0E2Ew8FKTGYNM682k+irqG3MT7UtjWzRZJ1PW9e1YiwQFNgXP3Vbf47X8+QcwSrqcoSBnWDxrROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=D4Gj6rEj; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yyjHvCff7S959Ew8WCamNJRZ/7RUkGV9tatNmKTFON4=; b=D4Gj6rEjA3GSk9HrBD6VCWWrQv
	3X/uhkBlYy3cZce/E6aomFMmi1HCQtxKTMaMGrZ1yDSbVkjGsssrwG5pE0nbcAR2F3acHuuNrDRSr
	BaHQb/wYftfj0VooBGohh7eNkc8lMZ+nxbBQPqf8F+6hox53JhXpnBpzff2vaBIWx2eY=;
Received: from [93.82.65.102] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9rHf-000000008JC-0uJG;
	Fri, 17 Oct 2025 22:42:43 +0200
Message-ID: <773461fd-3134-4314-849b-53ab1d9db09a@engleder-embedded.com>
Date: Fri, 17 Oct 2025 22:42:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
 <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 17.10.25 22:12, Heiner Kallweit wrote:
> In few places a 100FD fixed PHY is used. Create a helper so that users
> don't have to define the struct fixed_phy_status.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/fixed_phy.c | 12 ++++++++++++
>   include/linux/phy_fixed.h   |  6 ++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index 0e1b28f06..bdc3a4bff 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -227,6 +227,18 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>   }
>   EXPORT_SYMBOL_GPL(fixed_phy_register);
>   
> +struct phy_device *fixed_phy_register_100fd(void)
> +{
> +	static const struct fixed_phy_status status = {
> +		.link	= 1,
> +		.speed	= SPEED_100,
> +		.duplex	= DUPLEX_FULL,
> +	};
> +
> +	return fixed_phy_register(&status, NULL);
> +}
> +EXPORT_SYMBOL_GPL(fixed_phy_register_100fd);
> +
>   void fixed_phy_unregister(struct phy_device *phy)
>   {
>   	phy_device_remove(phy);
> diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
> index d17ff750c..08275ef64 100644
> --- a/include/linux/phy_fixed.h
> +++ b/include/linux/phy_fixed.h
> @@ -20,6 +20,7 @@ extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
>   void fixed_phy_add(const struct fixed_phy_status *status);
>   struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>   				      struct device_node *np);
> +struct phy_device *fixed_phy_register_100fd(void);
>   
>   extern void fixed_phy_unregister(struct phy_device *phydev);
>   extern int fixed_phy_set_link_update(struct phy_device *phydev,
> @@ -34,6 +35,11 @@ fixed_phy_register(const struct fixed_phy_status *status,
>   	return ERR_PTR(-ENODEV);
>   }
>   
> +static inline struct phy_device *fixed_phy_register_100fd(void)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   static inline void fixed_phy_unregister(struct phy_device *phydev)
>   {
>   }

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>


