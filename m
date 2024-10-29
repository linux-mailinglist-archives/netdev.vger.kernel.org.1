Return-Path: <netdev+bounces-140006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30D9B4FEA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206741F238D4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9428C1D2796;
	Tue, 29 Oct 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gPUqdL4C"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844919992C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221028; cv=none; b=N1X/DUWzlAsTHc7BYQIG3xiXlp5sSipQRakY2arGYVqUgfMwleejiAa0p5AHVHgADxP6lTABaOS+wxiT0tB58Mx/Epl7RMxHVOr1agz06LWh6Xe+t8u1fIcqd8Of9vB/DT49tSAvvcPZuvhcH9hTYjL0ZYYGnfIKieGqr+ujb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221028; c=relaxed/simple;
	bh=X0jaiMvCjJEEhd7RT+IguPkikO8YjtAW97ZeFQNx5/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpJGZC7pI2WdEaPHC0Eyj9MfPstcCBx75E3tEwGJRmVvIkXu51VIdzpyJ/GK4qqHIrOUOuCPo3iGR4CNMNUtS2Zkdb3RwoM1HocBWCA1M+BNmYBS0ZmSrsZUU0X0d/ubMF0wV06qIGCmXmq7o2H2d6ahd+t8cu4NNQCrn1DJjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gPUqdL4C; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id 5oYSt0wDdqvuo5pVBtCD8O; Tue, 29 Oct 2024 16:55:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5pV7tl03mmNYj5pV7twb2y; Tue, 29 Oct 2024 16:55:26 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=6721137e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=hLRBkJ6lmyVDo42-feIA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RI3obuqQ9kDWIuhA0WGes/O5kbrhm7V31zs2payIIG8=; b=gPUqdL4Cl1PAV31UvlNTxaY8qS
	IT3XfBCwC0vS+hk18SE9jcXSkovV1MGXCdguYO1mhQtPhODfOHqFR7lVOXOnG7Uyv+ArdUMidI3mU
	xxcgNSDusbyTogJ1AnzjbidAsqHCK+BBN0cB1r6Kev+9aw/rTmy9xT6CKHnT2dxtgGfkArftf+xkY
	LdeFxq8WfB6m4Ep0vk8TwQ6ptRASZ1bxbgbD1Xv+tpcDfJVHBbSMu8r+ec+Yrx1H7OQchEiFK9EZ9
	iH0YswiYu2vTIugfu1A+fhNxESR27o3ezqokwcqHshoM/YHEnlVCXnF4+2Slzk7w/N1sPKPW2GPWh
	LiJbZ6Eg==;
Received: from [201.172.173.7] (port=36540 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5pV5-003FnW-1l;
	Tue, 29 Oct 2024 11:55:23 -0500
Message-ID: <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
Date: Tue, 29 Oct 2024 10:55:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241029065824.670f14fc@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241029065824.670f14fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5pV5-003FnW-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:36540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCD3nDwt1lfxL+4CX7TaXvqDoVWMuAk/k5a4VqYBFA/eR3PymArLUCcZOeNthipBcWazerknSmjQIxjj9wJfSV7axI22uLLHCiX5sFhdENfrBpaYG1b8
 fZxpXyBYnDufpGqCwZ6rG4BPgBfiSqBAaEd129iaDfkTKg0QPQYXIhLmo+ySHu5sn/vbqIP77a7vztalYzDXpgfNArNJua7hehw=



On 29/10/24 07:58, Jakub Kicinski wrote:
> On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:
>> @@ -3025,7 +3025,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
>>   {
>>   	struct bnxt *bp = netdev_priv(dev);
>>   	struct bnxt_link_info *link_info = &bp->link_info;
>> -	const struct ethtool_link_settings *base = &lk_ksettings->base;
>> +	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
> 
> Please improve the variable ordering while at it. Longest list first,
> so move the @base definition first.

OK. This would end up looking like:

	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
	struct bnxt *bp = netdev_priv(dev);
	struct bnxt_link_info *link_info = &bp->link_info;



> 
>>   	bool set_pause = false;
>>   	u32 speed, lanes = 0;
>>   	int rc = 0;
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
>> index 7f3f5afa864f..cc43294bdc96 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
>> @@ -663,7 +663,7 @@ static int get_link_ksettings(struct net_device *dev,
>>   			      struct ethtool_link_ksettings *link_ksettings)
>>   {
>>   	struct port_info *pi = netdev_priv(dev);
>> -	struct ethtool_link_settings *base = &link_ksettings->base;
>> +	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
> 
> ditto
> 
>>   	/* For the nonce, the Firmware doesn't send up Port State changes
>>   	 * when the Virtual Interface attached to the Port is down.  So
>> @@ -719,7 +719,7 @@ static int set_link_ksettings(struct net_device *dev,
>>   {
>>   	struct port_info *pi = netdev_priv(dev);
>>   	struct link_config *lc = &pi->link_cfg;
>> -	const struct ethtool_link_settings *base = &link_ksettings->base;
>> +	const struct ethtool_link_settings_hdr *base = &link_ksettings->base;
> 
> and here
> 
>>   	struct link_config old_lc;
>>   	unsigned int fw_caps;
>>   	int ret = 0;
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
>> index 2fbe0f059a0b..0d85ac342ac7 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
>> @@ -1437,7 +1437,7 @@ static int cxgb4vf_get_link_ksettings(struct net_device *dev,
>>   				  struct ethtool_link_ksettings *link_ksettings)
>>   {
>>   	struct port_info *pi = netdev_priv(dev);
>> -	struct ethtool_link_settings *base = &link_ksettings->base;
>> +	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
> 
> and here
> 
>>   	/* For the nonce, the Firmware doesn't send up Port State changes
>>   	 * when the Virtual Interface attached to the Port is down.  So
>> diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
>> index f7986f2b6a17..8670eb394fad 100644
>> --- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
>> +++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
>> @@ -130,7 +130,7 @@ static int enic_get_ksettings(struct net_device *netdev,
>>   			      struct ethtool_link_ksettings *ecmd)
>>   {
>>   	struct enic *enic = netdev_priv(netdev);
>> -	struct ethtool_link_settings *base = &ecmd->base;
>> +	struct ethtool_link_settings_hdr *base = &ecmd->base;
> 
> and here
> 
>>   	ethtool_link_ksettings_add_link_mode(ecmd, supported,
>>   					     10000baseT_Full);
> 
>> @@ -62,7 +62,7 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
>>   {
>>   	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>>   	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
>> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
>> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
> 
> here it was correct and now its not

I don't think you want to change this. `lsettings` is based on `ksettings`. So,
`ksettings` should go first. The same scenario for the one below.

> 
>>   	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>>   	int len, ret;
>>   
>> @@ -103,7 +103,7 @@ static int linkmodes_fill_reply(struct sk_buff *skb,
>>   {
>>   	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>>   	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
>> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
>> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
> 
> same
> 
>>   	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
>>   	int ret;
> 


