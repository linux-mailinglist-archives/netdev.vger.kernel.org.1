Return-Path: <netdev+bounces-120937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C077795B3D1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761811F2223A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5821C93B9;
	Thu, 22 Aug 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3yDF96F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0E1C6F7B;
	Thu, 22 Aug 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326183; cv=none; b=QN2rZUEiF5UzBiHKwC3drJTzTh5z7785PEYVYA7BBSVmlmmgG9j0lCscaHh9Q4ORMGzLKP7q6eG/4diz/X9gU1z4U0I8gubG/d9CB+OtCvVDp5T4F5TzG7Yg2P5JaiLmeOnp+IfdLPpgIm/yBM2IcXFk1lBV9yMjJoAOjXFei44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326183; c=relaxed/simple;
	bh=q6UIfNHozIo9lEeHbj8R4JHekY2b0yfbW64o+5TUkZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRLCU487KkThMXpEOFfNSFjUItrywoowvenhFacnTbEaZ5QPn60fhRHwClXEerMjJVt5nbXOooHVy4rZo9JF1yOi0dg+aalGRzl/tHOBfo/7FR2dpzQUAYTST3bIJyXDhEo/uneZYvegb6zzOX6UI5GWLHFJSGYyKNb61dIVf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3yDF96F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0DEC32782;
	Thu, 22 Aug 2024 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724326183;
	bh=q6UIfNHozIo9lEeHbj8R4JHekY2b0yfbW64o+5TUkZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o3yDF96FpD5ELAgrOaIwPW62mW7Ko6AaQmsBoJrGSOZHoAhaIvQf89uV1PloObtX9
	 2trP5mpwciCzyhyQpwds6H/TG5FKOhpaKsBqRA9C9JrXv9sEH9Y51Aem5uDirebuK5
	 764pEesFS5FDgJpO4XuyuQUpivDHT57xfNykDRK1OJPFwG3Zgouuwx2c0dnF4KzwbP
	 kZvtHy55Fb4k7Q/2VyC5cEq0Ggj/gwDVQYRo1/mmqJKQHjV3+DQHOqwBeolCF5c3YS
	 xk06cSHF8IhY1XylqaU7SJR3PRW80lNP2PH8aI0TfcWiBI/inRF35B5IHRIUoF8CYK
	 H0kylfDl8mUEg==
Message-ID: <42f29ba8-e341-474e-9e2a-59f55850803a@kernel.org>
Date: Thu, 22 Aug 2024 14:29:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
 Sai Krishna <saikrishnag@marvell.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
 <20240820091657.4068304-3-danishanwar@ti.com>
 <03172556-8661-4804-8a3b-0252d91fdf46@kernel.org>
 <79dfc7d2-d738-4899-aadf-a6b4df338c23@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <79dfc7d2-d738-4899-aadf-a6b4df338c23@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/08/2024 08:28, MD Danish Anwar wrote:
> 
> 
> On 21/08/24 6:05 pm, Roger Quadros wrote:
>>
>>
>> On 20/08/2024 12:16, MD Danish Anwar wrote:
>>> Add support for dumping PA stats registers via ethtool.
>>> Firmware maintained stats are stored at PA Stats registers.
>>> Also modify emac_get_strings() API to use ethtool_puts().
>>>
>>> This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
>>> and creates a new array named icssg_all_pa_stats for PA Stats.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
> 
> [ ... ]
> 
>>> +
>>>  #define ICSSG_STATS(field, stats_type)			\
>>>  {							\
>>>  	#field,						\
>>> @@ -84,13 +98,24 @@ struct miig_stats_regs {
>>>  	stats_type					\
>>>  }
>>>  
>>> +#define ICSSG_PA_STATS(field)			\
>>> +{						\
>>> +	#field,					\
>>> +	offsetof(struct pa_stats_regs, field),	\
>>> +}
>>> +
>>>  struct icssg_stats {
>>
>> icssg_mii_stats?
>>
> 
> Sure Roger. I will name it icssg_miig_stats to be consistent with
> 'struct miig_stats_regs'
> 
>>>  	char name[ETH_GSTRING_LEN];
>>>  	u32 offset;
>>>  	bool standard_stats;
>>>  };
>>>  
>>> -static const struct icssg_stats icssg_all_stats[] = {
>>> +struct icssg_pa_stats {
>>> +	char name[ETH_GSTRING_LEN];
>>> +	u32 offset;
>>> +};
>>> +
>>> +static const struct icssg_stats icssg_mii_g_rt_stats[] = {
>>
>> icssg_all_mii_stats? to be consistend with the newly added
>> icssg_pa_stats and icssg_all_pa_stats.
>>
>> Could you please group all mii_stats data strucutres and arrays together
>> followed by pa_stats data structures and arrays?
>>
> 
> Sure Roger, I will group all mii stats related data structures and
> pa_stats related data structures together.
> 
> The sequence and naming will be something like this,
> 
> struct miig_stats_regs
> #define ICSSG_MIIG_STATS(field, stats_type)
> struct icssg_miig_stats
> static const struct icssg_miig_stats icssg_all_miig_stats[]
> 
> struct pa_stats_regs
> #define ICSSG_PA_STATS(field)
> struct icssg_pa_stats
> static const struct icssg_pa_stats icssg_all_pa_stats[]
> 
> Let me know if this looks ok to you.

This is good. Thanks!

> 
>>>  	/* Rx */
>>>  	ICSSG_STATS(rx_packets, true),
>>>  	ICSSG_STATS(rx_broadcast_frames, false),
>>> @@ -155,4 +180,11 @@ static const struct icssg_stats icssg_all_stats[] = {
>>>  	ICSSG_STATS(tx_bytes, true),t
>>>  };
>>>  
>>> +static const struct icssg_pa_stats icssg_all_pa_stats[] = > +	ICSSG_PA_STATS(fw_rx_cnt),
>>> +	ICSSG_PA_STATS(fw_tx_cnt),
>>> +	ICSSG_PA_STATS(fw_tx_pre_overflow),
>>> +	ICSSG_PA_STATS(fw_tx_exp_overflow),
>>> +};
>>> +
>>>  #endif /* __NET_TI_ICSSG_STATS_H */
>>
> 

-- 
cheers,
-roger

