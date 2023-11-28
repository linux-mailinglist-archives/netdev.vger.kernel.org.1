Return-Path: <netdev+bounces-51812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA47FC4F6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B3B213AD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9340BFF;
	Tue, 28 Nov 2023 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Sn2nq0bN"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5CF4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:12:14 -0800 (PST)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 82NQrJiSmhqFd84RJrnstu; Tue, 28 Nov 2023 20:12:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 84RIrHJSJkUbt84RIrFAmY; Tue, 28 Nov 2023 20:12:12 +0000
X-Authority-Analysis: v=2.4 cv=WpU4jPTv c=1 sm=1 tr=0 ts=6566499c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=2Hst6vopFtGx82aOUKEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OsKcEDvP0RJqOniczsfYwBsWjtoeOoLyMxdYiyznFe8=; b=Sn2nq0bNlhLS7bFh9GNAEbCmvF
	Iu9IUfJA9BcST3mlzJZ/nVxt0u8R8sZwXnBqGKQqXneNRQ0SKC3J7t822YgSfquvt4I10nXWe11hB
	7B2yCijnOBhuwInkCAWNNsmpWAzS9XYbKIOw4u7sLjWB+/KZwwjwJFyV/MTcAf9+3EuugFdiUDP87
	bos+E4MxIAe8JWJ8ELgVvFZnKUoH7O+dMD9j8Oq4hO2XUfcJcOiIk1qgECF635awfjOAFdumxuj85
	WXmKiAUQk36sdY9XhmNXcdql6uNrny28p+mgwrGk3TOaHzWHha/VLopoAnnfRgIQj5Y1mwLGh4VnE
	7GgMqoKQ==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:12895 helo=[192.168.0.9])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r84RH-002N7Y-1K;
	Tue, 28 Nov 2023 14:12:11 -0600
Message-ID: <a1656a7c-7eb0-4a21-8c49-89014beeb7ed@embeddedor.com>
Date: Tue, 28 Nov 2023 14:12:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Content-Language: en-US
To: Joey Gouly <joey.gouly@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bill Wendling <morbo@google.com>,
 Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZWJoRsJGnCPdJ3+2@work>
 <20231128111028.GA2382233@e124191.cambridge.arm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231128111028.GA2382233@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.122
X-Source-L: No
X-Exim-ID: 1r84RH-002N7Y-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.156.122]:12895
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIrM7L7Oocyy0rgGnLpFO/F1plUyq2akqEjA1vcHcppdpPQ2zZROPoSw0WORvIal8ymZCb+ObTuNX5SBMjLEi+m2XtnjoMiRZTS/+vdozv6hFUsmNELq
 HUe9kOcJvGuBYy4+nN6jSX78fm3xJH3zWt1K9/+MESBaS/0TiHXvdDgLpC0wM8/S3MJfHpWCRlnc6YzLx5gtggA+3W1bltwClAU=


>> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
>> index 07022bb0d44d..0d28172193fa 100644
>> --- a/include/net/neighbour.h
>> +++ b/include/net/neighbour.h
>> @@ -162,7 +162,7 @@ struct neighbour {
>>   	struct rcu_head		rcu;
>>   	struct net_device	*dev;
>>   	netdevice_tracker	dev_tracker;
>> -	u8			primary_key[0];
>> +	u8			primary_key[];
>>   } __randomize_layout;
>>   
>>   struct neigh_ops {
> 
> Fixes the crash for me!

Awesome. :)

--
Gustavo

