Return-Path: <netdev+bounces-238153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CC6C54C0E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 23:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 117A9348661
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093CF2DEA71;
	Wed, 12 Nov 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JlxUY58N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027C1F8AC8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988038; cv=none; b=Q3I2YFwyMgZ4MjScEFnFrBpYS3D8iUGn0zpAVEuW8nO6D559dE1h3woGLUFuzlqXQAWO+uwmC01OROpPscR1Fv7BRxsrecsr0E8E1uO5FUIWthUqkAlfbUY+eb9IJXiRfCZ4TdKKD1w8a5brJJTYi47nTnZJuWQ/1oURBrTtqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988038; c=relaxed/simple;
	bh=kZUg8h+pAyF8W+dWXMDF+CYdktskWDqIBLZUfvlDPkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg7yEKnFjf3FKSqS1DH0mZnfWjQe6FKJSqkPVSO732x1xLyrYMlahRTN/sXEsIMvZjg45Gaf5HkMz2SF09GeiEw9ofx6tpAnGFr3yd1ABBzmaRu1x4lrdEmN3aBmWwx1IdS41RvZf+L+T3fUtsYJO8pGVRCQl7ByfuNfssx0/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JlxUY58N; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-297d4a56f97so1433955ad.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988037; x=1763592837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouleVIS9yie9yc9gOqHnUx2ZwQk7GLQ0xprFOvbjpas=;
        b=ATOTzFEHPh+J+IrSMc5Wye06IrSlfS/q5+5NKNJ65ZpO9RwSGk5NVpNACmS7FGwCUS
         bZOc8KADMNsbZt8mBreN9ES2pweLqhTcWbizlKxMiFiojweAV5hDODAbA2vAEjRnT6/c
         louTVoYbsqY7XQ3+46UznufOcg2LpGZq9MVg8DAwg0HkZSGBM7CvMeV+v6gueTVIc/wh
         cYCfyviHm0r4l0Uc95IEaqKt6qi0zZLmapF9OjBbcd4TN3OUm/BsNqxa25XeMVfyo6oh
         g9ayn6Kp1iox+sZjAvCSNwmfOqInCDIZci/asa1f8GM6c0LujTx5HRqNtvjvWkJFjkoq
         /Hlg==
X-Gm-Message-State: AOJu0YxL6nM2Y5Per40VouHHrT7uk4hL0fedD0zwvJm51hKkjx3QTWB6
	FRtV77keVPkbG/ZalJJRYYudNfHGb4+AOnqIAptykHIgKPsVcgWN/9py/eIGMLa7ifQNcQpnMzt
	cF4XNCy+SX8gl2svBun64DdhdaZlKuV6NTHhQ1PTEHPeul7+ZlNaRKgfVCs+uLvkvRTd7ILlkG2
	hSxnP/RgmrIPzG45jF1CzwGlzbkqF40knSIUREJl+XqhdBw9Z+cCEfTqJf6GvDdyiPHzBhHU0v5
	J4mE80KaAbbhoBY
X-Gm-Gg: ASbGncuEEVHO1jGaXSn/1qvAHWlwBv4z9BDVILEtxIlkCqtgy6gVMPKbFbfWx5cwihL
	OLrHKyV+B6tit8rKJS1WGcmStco3IZmXv6gEj7hEfIfn8tuQ5rIwH2y8zygSjQdRN9upO70+F32
	LCVqEYZypaUVtYc2UYXjQTLiKxc9s8QZaKLIBNUDNgDIo2Tbm2qsdJuip7jGCOnh5ZsGLUW4Dx9
	C4G/vpE9RgJ4FORxHlsTHuGzfSfi+fvBUjbSqQaEuN0wHI9KQThftbUchRxk/UMKUcwgk0+67p9
	GmjcuaXrUJx/zSCiy4eIm6BetAWsv0Vh1pjh8nw6AzK6ai14QkqVjoIjzjxNhcdmggVbsmmkYuN
	5spBV2ErgJ0C7M/hfegqXvZKVjCN027IB6yKydJ+7O96tKtoG/yS9BrymGMrn7rdgZPw7oqpQag
	nTDe8ER+/9uamXtmk0MD9Yl8Cx9jW4D3q1mRJbZL4=
X-Google-Smtp-Source: AGHT+IFKRWbSNt355MfCg7p1BC/fK8n6TJnTSzo5VbT9t0Qy95q/DujuMaBHREYowbvMNRQvWkYSV1Evt8fo
X-Received: by 2002:a17:902:db0c:b0:295:586d:677d with SMTP id d9443c01a7336-2984edd22e0mr60119905ad.41.1762988036727;
        Wed, 12 Nov 2025 14:53:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2985c241beasm332725ad.19.2025.11.12.14.53.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:53:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24a25cff5so70744085a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762988035; x=1763592835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ouleVIS9yie9yc9gOqHnUx2ZwQk7GLQ0xprFOvbjpas=;
        b=JlxUY58NRhVhGygDfYGOe76fqCFGyzzLS+IcCVF3KxbizW2llVlBKsnI2D25WhVfTW
         B2s7TVIF0NmQvkjTFOs8yLMPe357dbpKNsDIGwXqciDYiRdFExMkSQiErtlmaqUd7ETB
         V7k69lKw+68DyGP18hejqQFE6Nb/VnK7wtRZg=
X-Received: by 2002:a05:620a:40d4:b0:8b2:7777:f662 with SMTP id af79cd13be357-8b29b829f8bmr722240385a.64.1762988035307;
        Wed, 12 Nov 2025 14:53:55 -0800 (PST)
X-Received: by 2002:a05:620a:40d4:b0:8b2:7777:f662 with SMTP id af79cd13be357-8b29b829f8bmr722237285a.64.1762988034894;
        Wed, 12 Nov 2025 14:53:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af042ca7sm12130085a.43.2025.11.12.14.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:53:53 -0800 (PST)
Message-ID: <9109c963-4544-4c4b-8d75-3293d8173cd5@broadcom.com>
Date: Wed, 12 Nov 2025 14:53:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: ethernet: Allow disabling pause on
 panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Antoine Tenart <atenart@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Yajun Deng <yajun.deng@linux.dev>, open list <linux-kernel@vger.kernel.org>
References: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
 <20251107002510.1678369-2-florian.fainelli@broadcom.com>
 <20251110171036.733aa203@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251110171036.733aa203@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/10/25 17:10, Jakub Kicinski wrote:
> On Thu,  6 Nov 2025 16:25:09 -0800 Florian Fainelli wrote:
>> Development devices on a lab network might be subject to kernel panics
>> and if they have pause frame generation enabled, once the kernel panics,
>> the Ethernet controller stops being serviced. This can create a flood of
>> pause frames that certain switches are unable to handle resulting a
>> completle paralysis of the network because they broadcast to other
>> stations on that same network segment.
>>
>> To accomodate for such situation introduce a
>> /sys/class/net/<device>/disable_pause_on_panic knob which will disable
>> Ethernet pause frame generation upon kernel panic.
>>
>> Note that device driver wishing to make use of that feature need to
>> implement ethtool_ops::set_pauseparam_panic to specifically deal with
>> that atomic context.
> 
> Some basic review comments below (no promises if addressing those will
> make me for one feel any warmer towards the concept).
> 
>>   Documentation/ABI/testing/sysfs-class-net | 16 +++++
>>   include/linux/ethtool.h                   |  3 +
>>   include/linux/netdevice.h                 |  1 +
>>   net/core/net-sysfs.c                      | 39 +++++++++++
>>   net/ethernet/Makefile                     |  3 +-
>>   net/ethernet/pause_panic.c                | 79 +++++++++++++++++++++++
> 
> panic.c or shutdown.c is probably a slightly better name,
> more likely we'd add more code in that.
> 
>>   6 files changed, 140 insertions(+), 1 deletion(-)
>>   create mode 100644 net/ethernet/pause_panic.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
>> index ebf21beba846..da0e4e862aca 100644
>> --- a/Documentation/ABI/testing/sysfs-class-net
>> +++ b/Documentation/ABI/testing/sysfs-class-net
>> @@ -352,3 +352,19 @@ Description:
>>   		0  threaded mode disabled for this dev
>>   		1  threaded mode enabled for this dev
>>   		== ==================================
>> +
>> +What:		/sys/class/net/<iface>/disable_pause_on_panic
>> +Date:		Nov 2025
>> +KernelVersion:	6.20
>> +Contact:	netdev@vger.kernel.org
>> +Description:
>> +		Boolean value to control whether to disable pause frame
>> +		generation on panic. This is helpful in environments where
>> +		the link partner may incorrect respond to pause frames (e.g.:
>> +		improperly configured Ethernet switches)
>> +
>> +		Possible values:
>> +		== =====================================================
>> +		0  do not disable pause frame generation on kernel panic
>> +		1  disable pause frame generation on kernel panic
>> +		== =====================================================
> 
> please no sysfs for something as niche as this feature

Would you prefer ethtool in that case?
-- 
Florian

