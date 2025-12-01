Return-Path: <netdev+bounces-242945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FA6C96AD8
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1943A2C32
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94733019C4;
	Mon,  1 Dec 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXB29inx"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FD286D70
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585282; cv=none; b=cNXxv0EMylDOCAFsLI2UVMuZW0B63stTj8tc7jtIe8JHl8YHb4mgkqsl/oiAyDDzxRq3FuGCeABkudjjJpXN4T0ZOeqwhjIluf/2vugOhTw+QKNZgiOfMOEwU3F6XszhgDIGd6+hkc8Vw5Z+lJQxfuGdSvzIe/YEJPfEZ/iOUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585282; c=relaxed/simple;
	bh=RxQYXhwNjFVrv8Qspl6NjpmuEb/9fnguYjdzplYNhWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvXtXg0QZDflT5d4eh2t5+s2gHRtkuC7kdu6Sw5aoW9B4jE+NgTfwJnC72TPvBS6VULZJbagYn2T7TqogfaE1N0K6vEt/awsaThw2nD2dIWWjYLLzqtRn7VThKsTFQ690JWaNcCocQqqNN0X6G9O58tkMlXMu74SPgKh0tz596M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXB29inx; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <287e67fa-44fc-4f70-8399-49dea01e8262@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764585278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmbqYir9bvzdY/p77/YiLaLmam9vP0EW2QN6nswCBtg=;
	b=xXB29inxZEgFKvaGWmSfJxlOHm9lpxRa5ygy3Cu/lT5VULrqu2WmJcLcJJ1tz20OPDGSsK
	20i93N+0saTTFMYcM3AreThp4VO/px3RV1GLnwyBax4UNzs7MFp80B8IuaN+9j5Kr17/gB
	2ttv7H3YKd/wMawUjwurHJkRzMm/kkU=
Date: Mon, 1 Dec 2025 10:34:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/4] net: phy: micrel: improve HW timestamping
 config logic
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
 <20251129195334.985464-2-vadim.fedorenko@linux.dev>
 <20251201103321.47cb4ceb@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251201103321.47cb4ceb@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/12/2025 09:33, Kory Maincent wrote:
> On Sat, 29 Nov 2025 19:53:31 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The driver was adjusting stored values independently of what was
>> actually supported and configured. Improve logic to store values
>> once all checks are passing
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/phy/micrel.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 05de68b9f719..1ada05dd305c 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -3157,9 +3157,6 @@ static int lan8814_hwtstamp_set(struct mii_timestamper
>> *mii_ts, int txcfg = 0, rxcfg = 0;
>>   	int pkt_ts_enable;
>>   
>> -	ptp_priv->hwts_tx_type = config->tx_type;
>> -	ptp_priv->rx_filter = config->rx_filter;
>> -
>>   	switch (config->rx_filter) {
>>   	case HWTSTAMP_FILTER_NONE:
>>   		ptp_priv->layer = 0;
>> @@ -3187,6 +3184,18 @@ static int lan8814_hwtstamp_set(struct mii_timestamper
>> *mii_ts, return -ERANGE;
>>   	}
>>   
>> +	switch (config->rx_filter) {
> 
> You want to check tx_type here, not rx_filter.
> 
>> +	case HWTSTAMP_TX_OFF:
>> +	case HWTSTAMP_TX_ON:
>> +	case HWTSTAMP_TX_ONESTEP_SYNC:
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
>> +	ptp_priv->hwts_tx_type = config->tx_type;
>> +	ptp_priv->rx_filter = config->rx_filter;
>> +
>>   	if (ptp_priv->layer & PTP_CLASS_L2) {
>>   		rxcfg = PTP_RX_PARSE_CONFIG_LAYER2_EN_;
>>   		txcfg = PTP_TX_PARSE_CONFIG_LAYER2_EN_;
>> @@ -5051,9 +5060,6 @@ static int lan8841_hwtstamp_set(struct mii_timestamper
>> *mii_ts, int txcfg = 0, rxcfg = 0;
>>   	int pkt_ts_enable;
>>   
>> -	ptp_priv->hwts_tx_type = config->tx_type;
>> -	ptp_priv->rx_filter = config->rx_filter;
>> -
>>   	switch (config->rx_filter) {
>>   	case HWTSTAMP_FILTER_NONE:
>>   		ptp_priv->layer = 0;
>> @@ -5081,6 +5087,9 @@ static int lan8841_hwtstamp_set(struct mii_timestamper
>> *mii_ts, return -ERANGE;
>>   	}
>>   
>> +	ptp_priv->hwts_tx_type = config->tx_type;
>> +	ptp_priv->rx_filter = config->rx_filter;
> 
> I there a reason to not add the check in the hwtstamp ops for lan8841 as well?
> because the issue is also present.

Hm... I thought I added it... Well, looks like I shouldn't work during
vacation :) Going to add it in v3, thanks!

> 
> Regards,


