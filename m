Return-Path: <netdev+bounces-75300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE68690CA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EFE2864FE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F8135A43;
	Tue, 27 Feb 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="R/sCDGsR"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13413A87E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037784; cv=none; b=BdJ+O2k7rO6ICMhuu8yVLfd+1NyMW4dKsaPSecofXOOWrB6y4T+5o1fhOMJ1R1pwHPW/oepcTkECkwxSljEnX+1opaYE6UKmWHt0ftkvM7vyN4p0PuMJltwMI9W+RkoQtrT9zQbwdxIFod8QA3xCpEeMfcn6/3RfNji6frGANcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037784; c=relaxed/simple;
	bh=n+wQJdTSoj50vSQ78krVXORo16RlnYXdpPZi6E/3PHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENz6kJ4m58opbpgj1guZlxi08uKQw1hl9pz+YjS3MNJf8uKnCNztutWnLMEBlkJ3dclYQzVN3bOJ6BaPcTH0YewWD0++vLinOx6nUHOl0s/7Tg2qk8Ujh8zHvzadeaOMSEPbyuJ7Vp0dr1aVCzT7y8cMIuLVmiqMP9JKsKXkvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=R/sCDGsR; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024022712425774481bacc012f1a98a
        for <netdev@vger.kernel.org>;
        Tue, 27 Feb 2024 13:42:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jWYQ1JRmmUT5LtCqnjxVlqWTBL1SPkD/4bybhyNCHJc=;
 b=R/sCDGsR+Qjt5wPEyawcsNAs0SflpRb4jwmQF8C8xFzegLiNokNdBf6z/43slXd6M5uth+
 wNtXV3iEFmgX/Sp/e5g26NbijlZ8D6jAzgQfsEP5ELPFonQYeP97aLzy5Cvd8GAM+pZWMuL9
 gaoUSw2FjjR8yLR39tNquG+SSGb4s=;
Message-ID: <68938da6-705f-47b8-bbf6-a2d0eba1d802@siemens.com>
Date: Tue, 27 Feb 2024 12:42:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 09/10] net: ti: icssg-prueth: Modify common
 functions for SR1.0
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com, diogo.ivo@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-10-diogo.ivo@siemens.com>
 <0105d616-8e38-471b-a114-f125c16bdef4@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <0105d616-8e38-471b-a114-f125c16bdef4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 2/26/24 17:33, Roger Quadros wrote:
> 
> 
> On 21/02/2024 17:24, Diogo Ivo wrote:
>> Some parts of the logic differ only slightly between Silicon Revisions.
>> In these cases add the bits that differ to a common function that
>> executes those bits conditionally based on the Silicon Revision.
>>
>> Based on the work of Roger Quadros, Vignesh Raghavendra and
>> Grygorii Strashko in TI's 5.10 SDK [1].
>>
>> [1]: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ti.com%2Fcgit%2Fti-linux-kernel%2Fti-linux-kernel%2Ftree%2F%3Fh%3Dti-linux-5.10.y&data=05%7C02%7Cdiogo.ivo%40siemens.com%7C44253ecc112a4f939f5e08dc36f11754%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638445656302550240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=kXkC6HubTh0yeftDSzmIy47tJmlnISQjMbWoOqvEAx0%3D&reserved=0
>>
>> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icssg_common.c | 46 +++++++++++++++-----
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c |  4 +-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +-
>>   3 files changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c

...

>> -	emac->rx_flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
>> -	netdev_dbg(ndev, "flow id base = %d\n", emac->rx_flow_id_base);
>> +	flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
>> +	if (!strcmp(name, "rxmgm")) {
> 
> if (emac->is_sr1 && !strcmp(name, "rxmgm")) ?

Since technically the DT should only contain "rxmgm" for SR1.0 I did not
add the emac->is_sr1 check but it can't hurt to be safer so I'll add it.

...

>>   	if (eth0_node) {
>> -		ret = prueth_get_cores(prueth, ICSS_SLICE0);
>> +		ret = prueth_get_cores(prueth, ICSS_SLICE0, true);
> 
> Isn't this SR2.0 device driver? so is_sr1 parameter should be false?
> 
>>   		if (ret)
>>   			goto put_cores;
>>   	}
>>   
>>   	if (eth1_node) {
>> -		ret = prueth_get_cores(prueth, ICSS_SLICE1);
>> +		ret = prueth_get_cores(prueth, ICSS_SLICE1, true);
> 
> here too?

Yes, you are correct, thank you for catching that.

Best regards,
Diogo

