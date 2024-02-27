Return-Path: <netdev+bounces-75288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA28B868FA5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1C61C213E1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0D13A24A;
	Tue, 27 Feb 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="RY9yAnaS"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727417F0
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035531; cv=none; b=UvuNzEBihQ6ekKWUYbO4/q8pdw9BWGp0GyVWzgrjl2iRSSKAbHmXMOgNfoK9rgiTOX33N5g9Fi2G62epb11GXLIWf4YvL13zEq+LauCdIbLY7VWZO3Fdm3U7kUjV5d6JRYBFo4muOnk2JodXp/UB4AXqROARN93rEsiUjfxVAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035531; c=relaxed/simple;
	bh=KilOZnPbGja8OjCgg5bSsmOJcGBOID+SVk/EPzR1HxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQz3nlbp5QxnKdudfnF4uKcwsYbIa8jMU7xvDxtN5aJhcoSxIxHnhv47b1qZuV3HtTETux5HV0SsdaJ0DsNK0P06qkjwXx3lQkUusNPMTKage7mOzk/bUwh1TTiP9R2OumC4HAim8bFS3z4PHmr6WHThSVwU4V6YqO2frVTlrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=RY9yAnaS; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240227120520c1cbc54d560bc72789
        for <netdev@vger.kernel.org>;
        Tue, 27 Feb 2024 13:05:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JSS/Onm9x1STdhGhG8cPOY0JxtIy2ct7R/sNC7L4Urc=;
 b=RY9yAnaSw9MaQAKc+CDonDXv155xzAyfTsQCA5CaTVHhY3Ah21AVPPmHoYNHGs/kcDmd39
 EJlInKfI6UphtaugWCOyLQz2vSIPzkYZAtail+XHqgBPaSbudS84a0EoSlgBywq7LbOIYpOZ
 EFWUS2L67Z10gLPeXQyqcWAzecMfk=;
Message-ID: <39ca8e5f-7fba-4f8c-a0f7-59153382bcf3@siemens.com>
Date: Tue, 27 Feb 2024 12:05:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 10/10] net: ti: icssg-prueth: Add ICSSG
 Ethernet driver for AM65x SR1.0 platforms
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org, vigneshr@ti.com,
 arnd@arndb.de, wsa+renesas@sang-engineering.com, vladimir.oltean@nxp.com,
 andrew@lunn.ch, dan.carpenter@linaro.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
 diogo.ivo@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-11-diogo.ivo@siemens.com>
 <20240222133103.GB960874@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <20240222133103.GB960874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 2/22/24 13:31, Simon Horman wrote:
> On Wed, Feb 21, 2024 at 03:24:16PM +0000, Diogo Ivo wrote:
>> Add the PRUeth driver for the ICSSG subsystem found in AM65x SR1.0 devices.
>> The main differences that set SR1.0 and SR2.0 apart are the missing TXPRU
>> core in SR1.0, two extra DMA channels for management purposes and different
>> firmware that needs to be configured accordingly.
>>
>> Based on the work of Roger Quadros, Vignesh Raghavendra and
>> Grygorii Strashko in TI's 5.10 SDK [1].
>>
>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Cfebc5e0f6a1b476c366d08dc33aa89ee%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638442054773860177%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=YxcCwUMV7Zzyycb1Ss6xoCq9BK1vYsvuoF30XXA2tRI%3D&reserved=0
>>
>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> 
> ...
> 

...

>> +	config.rx_flow_id = emac->rx_flow_id_base; /* flow id for host port */
>> +	config.rx_mgr_flow_id = emac->rx_mgm_flow_id_base; /* for mgm ch */
>> +	config.rand_seed = get_random_u32();
> 
> Hi Diogo and Jan,
> 
> The fields of config above are all __le32.
> However the last three lines above assign host byte-order values to these
> fields. This does not seem correct.
> 
> This is flagged by Sparse along with some problems.
> Please ensure that new Sparse warnings are not introduced.
> 

You are correct, thank you for catching the inconsistency, this will be
fixed in v4.

...

>> +static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
>> +{
>> +	dma_addr_t desc_dma, buf_dma;
>> +	struct prueth_tx_chn *tx_chn;
>> +	struct cppi5_host_desc_t *first_desc;
>> +	u32 *data = emac->cmd_data;
>> +	u32 pkt_len = sizeof(emac->cmd_data);
>> +	void **swdata;
>> +	int ret = 0;
>> +	u32 *epib;
> 
> In new Networking code please express local variables in reverse xmas tree
> order - longest line to shortest.

Noted, will fix for v4.

...

> There is also one such problem in Patch 06/10.
Here xmastree reported the same problem in patch 08/10 rather than 
06/10, I assumed you meant that one.

Best regards,
Diogo

