Return-Path: <netdev+bounces-240042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5414C6F9D0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF74EBE79
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400D366567;
	Wed, 19 Nov 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lg4s/VWr"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A32BD030
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565067; cv=none; b=asCHNd+hJ6LkEQ0SsOLFbjYQ5kKgnsDjk4+Pqawunxhn6SzqXHiJXebhG0feExgkp4OP6ZUhWc/npNSmcZ57hULQqrTwaAtpm1A7xB5WIX7zUMUd+GGXT8AfHeUwHtOxdbDOs41dwV84hZiKc132fMaLiTGsGa8Sif3H9fBOA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565067; c=relaxed/simple;
	bh=1KsVPD1dcDQJjmrl4NWPz3s5zk8s9HD+FAWv2U4Uoc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpGXqEPi9FofrIKa1U86cvJXpwvb1ua0pqTP2dq7XIyWAFfDBtKG0RY6QCtE+fhpkwvDhslHAM9brwJcZxP/OmgZl5h63K7AWiKZxTsiUXfadmrvaXQAwEO1sJGLomjk+O1JdcZ5bDAo3dhoPR4GRMD7ih4Rv9unjNczF4+57hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lg4s/VWr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a1cab05-bc20-43ae-b5e7-3fd22b7feed6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763565060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhGZ8Dal/CiWk5QDAZATjSivrzoxtJBftckf2eHixVg=;
	b=Lg4s/VWrIEyCqKX56UR11fyhEYjdWbwXw2ItVL404qv0kzOp4IqYRvSYeoObEz2LxePsGB
	HUb6u/uyzKXYPGNEZ4svCzi57RH6EGmm+D/7+UcAmGZRK5u6C4xmZM8Z55Og0N+JE2KHAy
	aUw+I1TJJzXzIiit5UppXXiZQOz+jyg=
Date: Wed, 19 Nov 2025 15:10:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 5/9] net: phy: micrel: add HW timestamp
 configuration reporting
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
 <20251119124725.3935509-6-vadim.fedorenko@linux.dev>
 <20251119154448.2ca40ac9@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251119154448.2ca40ac9@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2025 14:44, Kory Maincent wrote:
> On Wed, 19 Nov 2025 12:47:21 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The driver stores HW timestamping configuration and can technically
>> report it. Add callback to do it.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 05de68b9f719..b149d539aec3 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device
>> *phydev, bool egress) lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
>> PTP_TSU_INT_STS); }
>>   
>> +static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
>> +				struct kernel_hwtstamp_config *config)
>> +{
>> +	struct kszphy_ptp_priv *ptp_priv =
>> +			  container_of(mii_ts, struct kszphy_ptp_priv,
>> mii_ts); +
>> +	config->tx_type = ptp_priv->hwts_tx_type;
>> +	config->rx_filter = ptp_priv->rx_filter;
>> +
>> +	return 0;
>> +}
>> +
>>   static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
>>   				struct kernel_hwtstamp_config *config,
>>   				struct netlink_ext_ack *extack)
>> @@ -4390,6 +4402,7 @@ static void lan8814_ptp_init(struct phy_device *phydev)
>>   	ptp_priv->mii_ts.rxtstamp = lan8814_rxtstamp;
>>   	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
>>   	ptp_priv->mii_ts.hwtstamp_set = lan8814_hwtstamp_set;
>> +	ptp_priv->mii_ts.hwtstamp_get = lan8814_hwtstamp_get;
>>   	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
>>   
>>   	phydev->mii_ts = &ptp_priv->mii_ts;
>> @@ -5042,6 +5055,19 @@ static void lan8841_ptp_enable_processing(struct
>> kszphy_ptp_priv *ptp_priv, #define LAN8841_PTP_TX_TIMESTAMP_EN
>> 443 #define LAN8841_PTP_TX_MOD			445
>>   
>> +static int lan8841_hwtstamp_get(struct mii_timestamper *mii_ts,
>> +				struct kernel_hwtstamp_config *config)
>> +{
>> +	struct kszphy_ptp_priv *ptp_priv;
>> +
>> +	ptp_priv = container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
>> +
>> +	config->tx_type = ptp_priv->hwts_tx_type;
>> +	config->rx_filter = ptp_priv->rx_filter;
> 
> Something related to this patch, it seems there is an issue in the set
> callback:
> https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/net/phy/micrel.c#L3056
> 
> The priv->rx_filter and priv->hwts_tx_type are set before the switch condition.
> The hwtstamp_get can then report something that is not supported.
> Also HWTSTAMP_TX_ONESTEP_P2P is not managed by the driver but not returning
> -ERANGE either so if we set this config the hwtstamp_get will report something
> wrong as not supported.
> I think you will need to add a new patch here to fix the hwtstamp_set ops.

I agree, that there is a problem in the flow, but such change is out of
scope of this patch set. I'm going to provide some logic improvements on
per-driver basis as follow up work.

> Maybe we should update net_hwtstamp_validate to check on the capabilities
> reported by ts_info but that is a bigger change.

In this case we have to introduce validation callback and implement it
in drivers. Some drivers do downgrade filter values if provided value is
not in the list of what was provided in ethtool::ts_info. And we have to
keep this logic as otherwise it may be considered as API breakage.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
>>   				struct kernel_hwtstamp_config *config,
>>   				struct netlink_ext_ack *extack)
>> @@ -5925,6 +5951,7 @@ static int lan8841_probe(struct phy_device *phydev)
>>   	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
>>   	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
>>   	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
>> +	ptp_priv->mii_ts.hwtstamp_get = lan8841_hwtstamp_get;
>>   	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
>>   
>>   	phydev->mii_ts = &ptp_priv->mii_ts;
> 
> 
> 


