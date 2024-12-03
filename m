Return-Path: <netdev+bounces-148630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3689E2AC2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81030166905
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCC1FCCFE;
	Tue,  3 Dec 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JUnQT1Vo"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4831FCCF9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250343; cv=none; b=gTpzHtDrrhEHWFNFQFshrJKVOrUpzLX+M/uJeE//BMytpdF1PXZQU54aE40Vcz0vq4p3VjMfHJWj/hhIA2VkioDy8Q4Cb1VtRR99fcToLAPdaysSC0fiOVgE96XvvFQiOzCmqCZQ3f6lkCaMMAAHSYz/Bl/NlwBqWcq3bW60/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250343; c=relaxed/simple;
	bh=Ya0khzmJq24JDEG4oQJVLfPWFJ3vo2WwmYi6qeNRK9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq5geqwb+LlPqNr98BDnDaL/LUym2cTZoayLn34cNOyoTc1OtIvi43VXqsjCrWL0ylwDl2C9C+zA+HR3RkFKT8Ijh5zhd0lKRSwGrAnPmlOGE3UAuJYIzNf/6a7DXkSUSB+r6eo//4QHgUgjBFCxjG3xv2GFbQTczP9oS4qfPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JUnQT1Vo; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BC73EB0008B;
	Tue,  3 Dec 2024 18:25:32 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id EF22313C2B0;
	Tue,  3 Dec 2024 10:25:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EF22313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733250331;
	bh=Ya0khzmJq24JDEG4oQJVLfPWFJ3vo2WwmYi6qeNRK9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JUnQT1VoRkGehG7WbmCWvhNSA5ggmG18ebXnlGrwLxaPPZP8Ea/SRltWpLifJSfMh
	 mGuakcCBLvsAPiZRD5XOXOvFkVi8NUbApvqkiX9gWBDAnZzkIy8WnZluHo4f5OqpzF
	 2BgkqNY3Vbj7ShYWioEzP9hoK3bEcij5mlZ4RD0c=
Message-ID: <0d30b5d3-d3ce-f959-e30d-d5ec57f2b2f1@candelatech.com>
Date: Tue, 3 Dec 2024 10:25:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: wireguard: Allow binding to specific ifindex
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jason@zx2c4.com, wireguard@lists.zx2c4.com,
 dsahern@kernel.org
References: <20241125212111.1533982-1-greearb@candelatech.com>
 <20241203090927.GA9361@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20241203090927.GA9361@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1733250334-y59WZfVmmPVZ
X-MDID-O:
 us5;ut7;1733250334;y59WZfVmmPVZ;<greearb@candelatech.com>;2cdb4b4c3b48e22c2b551c41c7959e6e
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/3/24 01:09, Simon Horman wrote:
> On Mon, Nov 25, 2024 at 01:21:11PM -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Which allows us to bind to VRF.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> NOTE:  Modified user-space to utilize this may be found here:
>> https://github.com/greearb/wireguard-tools-ct
>> Only the 'wg' part has been tested with this new feature as of today.
> 
> ...
> 
>> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
>> index 0414d7a6ce74..a7cb1c7c3112 100644
>> --- a/drivers/net/wireguard/socket.c
>> +++ b/drivers/net/wireguard/socket.c
>> @@ -25,7 +25,8 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
>>   		.daddr = endpoint->addr4.sin_addr.s_addr,
>>   		.fl4_dport = endpoint->addr4.sin_port,
>>   		.flowi4_mark = wg->fwmark,
>> -		.flowi4_proto = IPPROTO_UDP
>> +		.flowi4_proto = IPPROTO_UDP,
>> +		.flowi4_oif = wg->lowerdev,
>>   	};
>>   	struct rtable *rt = NULL;
>>   	struct sock *sock;
>> @@ -111,6 +112,9 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
>>   	struct sock *sock;
>>   	int ret = 0;
>>   
>> +	if (wg->lowerdev)
>> +		fl.flowi6_oif = wg->lowerdev,
> 
> Hi Ben,
> 
> I think that the trailing ',' on the line above should be a ';'.
> As written, with a ',', the call to skb_mark_not_on_list()
> below will be included in the conditional block above.
> And this doesn't seem to be the intention of the code based on indentation.
> 
> Flagged by clang-19 with -Wcomma

Thank you for noticing that, it was bad copy paste bug on my part.  I'll
submit a v2.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



