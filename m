Return-Path: <netdev+bounces-240043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74CBC6F966
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B3E6B2904E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695402D94BB;
	Wed, 19 Nov 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMwV8BNE"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE0286D73
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565292; cv=none; b=C2m4ViUJfJWgEZ9Q5kTioVP+yOmnSWP4ezDBb7sLcA6kuP9ahlfNpmxWNxRRRyF18NvWoM+5qXldW8z63G/tn8dIbEqe3Z4t+DPIuWVF53BzMQeRr23mBr9NDL5CU/EKZOyOydi2g3anB9cDpVqvaD5NswUZmPY+QQprdbuV9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565292; c=relaxed/simple;
	bh=Jxv/lhFZ7xKICOF+NVpbUicTlvdi9zXcmVq1OSWwfDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkdp27OZTrlG5M3rAOtFdZ9gwDlWKIJkjjnEv/WvPfRijEKh2l4jypldZGGON/3LD/SFXdKQXZr6auUC0W1YPxiF4e7Kl/8Z+c1Bina7w5Pwo5XDGBV1fZPRE5nMDiQ9L70fdOOeVR7nbWShhS9Tz/oKb1MmkpFb8V0bZ4xhCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMwV8BNE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1d94667-e57d-48a4-a5b7-86706a24efe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763565287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yksXkNlI8TPUuqFUurR+5lOLZ7BKL70mOgqtZZcT1E=;
	b=FMwV8BNEkG7ny5iLSMjJ+O6OSm3JCxs71Sc7O1/NkhBSZASX+UZDY0Te18a6zRdyrbQc6C
	L8mvov081Prtd8ZfakoJ69L7onQPbV2Ula1Lb4xCGuJMtObaCkWIFdHo6gKXTQTpvchklf
	VnvumQAYouvXfhDZzfs+SDXDas6Uuko=
Date: Wed, 19 Nov 2025 15:14:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 9/9] ptp: ptp_ines: add HW timestamp
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
 <20251119124725.3935509-10-vadim.fedorenko@linux.dev>
 <20251119155949.5a69551f@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251119155949.5a69551f@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2025 14:59, Kory Maincent wrote:
> On Wed, 19 Nov 2025 12:47:25 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The driver partially stores HW timestamping configuration, but missing
>> pieces can be read from HW. Add callback to report configuration.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/ptp/ptp_ines.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
>> index 56c798e77f20..790eb42b78db 100644
>> --- a/drivers/ptp/ptp_ines.c
>> +++ b/drivers/ptp/ptp_ines.c
>> @@ -328,6 +328,28 @@ static u64 ines_find_txts(struct ines_port *port, struct
>> sk_buff *skb) return ns;
>>   }
>>   
>> +static int ines_hwtstamp_get(struct mii_timestamper *mii_ts,
>> +			     struct kernel_hwtstamp_config *cfg)
>> +{
>> +	struct ines_port *port = container_of(mii_ts, struct ines_port,
>> mii_ts);
>> +	unsigned long flags;
>> +	u32 port_conf;
>> +
>> +	cfg->rx_filter = port->rxts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT
>> +					    : HWTSTAMP_FILTER_NONE;
>> +	if (port->txts_enabled) {
>> +		spin_lock_irqsave(&port->lock, flags);
>> +		port_conf = ines_read32(port, port_conf);
>> +		spin_unlock_irqrestore(&port->lock, flags);
>> +		cfg->tx_type = (port_conf & CM_ONE_STEP) ?
>> HWTSTAMP_TX_ONESTEP_P2P
>> +							 : HWTSTAMP_TX_OFF;
> 
> You could also update txts_enabled to int and save the tx type as you did in
> other patches. I don't know what the best approach is, but in either way, this
> is ok to me.

I was thinking of this, but it can be treated as logic change, which I
would like to avoid in this series. But I totally agree, there is no
real need to read register each time if we can store the config. Unless 
the value can be changed by some event outside of kernel configuration
flow.

> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!


