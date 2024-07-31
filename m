Return-Path: <netdev+bounces-114630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F5943451
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92B81F2171A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDB1BD004;
	Wed, 31 Jul 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="oNt6EIHB"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67C1BC09E;
	Wed, 31 Jul 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444314; cv=none; b=c7sYAppUgYVKq4+ey01MAMY68t1eRaUGzZLTaSchEk9xN3PRRCKJuDn6TctokgwTmVsiLRzROhxWQLdd0lFVA63/qUglKABo4DSyDbfp1LwTOqONQOKAf4ylkJr7yIZWIMl0JCUptoCapI9kIQn2Y+SAz+rzljhBDV5V2dWUOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444314; c=relaxed/simple;
	bh=8x9lJEHfZ3jfyxBOiJb3GTpMIoOuy6Gd7KaJ47G4+xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbphbydgy2NydK6DoEqr3JDt5N87Umno8vAF0CjMdOQn/G0LiIPMxxoVfA2l/HfcPwGsmJXV7Im/WQt3OfxP+1Ux7HlaYTTXK1x82IdM8cxL6ZBq4SBMotvDEgyw7/hAXZdpNSpqZ2ZI4fBk+uiLUGpk3Kv/Bai2/45//Q7Vp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=oNt6EIHB; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id DAA962FDA00;
	Thu,  1 Aug 2024 01:45:33 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info DAA962FDA00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722444335; bh=0o9Zv/4IXTu2a6JOrT9Mnt0TyC2AejbKp0bVV7nYd1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oNt6EIHBeDQHhd6CxHCSTe9qoKHrVpfurovs58pG0fOTpOG7a5xICGOAaACFMt8mz
	 e+Xy92Juz28ICUWSVINLKbWdOarFkdz2RPrIWndJ/X5AUNQz+zLg0J6di9vesABUHu
	 mrPVdbkFPIAQqoOrDOQ94Qv3UnL4p5fPgp3StcTM=
Message-ID: <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
Date: Thu, 1 Aug 2024 00:45:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/31 22:12, Willem de Bruijn wrote:
> Randy Li wrote:
>> We need the queue index in qdisc mapping rule. There is no way to
>> fetch that.
> In which command exactly?

That is for sch_multiq, here is an example

tc qdisc add dev  tun0 root handle 1: multiq

tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst 
172.16.10.1 action skbedit queue_mapping 0
tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst 
172.16.10.20 action skbedit queue_mapping 1

tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst 
172.16.10.10 action skbedit queue_mapping 2


The purpose here is taking advantage of the multiple threads. For the 
the server side(gateway of the tunnel's subnet), usually a different 
peer would invoked a different encryption/decryption key pair, it would 
be better to handle each in its own thread. Or the application would 
need to implement a dispatcher here.


I am newbie to the tc(8), I verified the command above with a tun type 
multiple threads demo. But I don't know how to drop the unwanted ingress 
filter here, the queue 0 may be a little broken.

>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>>   drivers/net/tap.c           | 9 +++++++++
>>   drivers/net/tun.c           | 4 ++++
>>   include/uapi/linux/if_tun.h | 1 +
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 77574f7a3bd4..6099f27a0a1f 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -1120,6 +1120,15 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>   		rtnl_unlock();
>>   		return ret;
>>   
>> +	case TUNGETQUEUEINDEX:
>> +		rtnl_lock();
>> +		if (!q->enabled)
>> +			ret = -EINVAL;
>> +
> Below will just overwrite the above ret
Sorry, I didn't verify the tap type.
>
>> +		ret = put_user(q->queue_index, up);
>> +		rtnl_unlock();
>> +		return ret;
>> +
>>   	case SIOCGIFHWADDR:
>>   		rtnl_lock();
>>   		tap = tap_get_tap_dev(q);
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 1d06c560c5e6..5473a0fca2e1 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>>   			return -EPERM;
>>   		return open_related_ns(&net->ns, get_net_ns);
>> +	} else if (cmd == TUNGETQUEUEINDEX) {
>> +		if (tfile->detached)
>> +			return -EINVAL;
>> +		return put_user(tfile->queue_index, (unsigned int __user*)argp);
> Unless you're certain that these fields can be read without RTNL, move
> below rtnl_lock() statement.
Would fix in v2.
>>   	}
>>   
>>   	rtnl_lock();
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c939..2668ca3b06a5 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -61,6 +61,7 @@
>>   #define TUNSETFILTEREBPF _IOR('T', 225, int)
>>   #define TUNSETCARRIER _IOW('T', 226, int)
>>   #define TUNGETDEVNETNS _IO('T', 227)
>> +#define TUNGETQUEUEINDEX _IOR('T', 228, unsigned int)
>>   
>>   /* TUNSETIFF ifr flags */
>>   #define IFF_TUN		0x0001
>> -- 
>> 2.45.2
>>
>

