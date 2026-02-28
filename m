Return-Path: <netdev+bounces-262220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DCVGhZYo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:03:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF451C8BB4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 736463004619
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275513090D5;
	Sat, 28 Feb 2026 21:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A0430B8F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772312596; cv=none; b=TR3BSPK+8Kcgl0qRfeBjYxYYiOLUY+EIxAhpE4Bf/op5aVvU3d3ZiHyI17gtAKZgSdIZvMOK/rzSjpKmw24fNjmssvUuiuWdR3x19hLpOilP045BgcD+3p7BE85W1Bu2zEdFS9ADOU42xe94idsXYD2/BwJjxuSWBn/jUzusGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772312596; c=relaxed/simple;
	bh=/x1Y15GHOfJeUVpQTmAr9n0DYHrRpyVUFDTxh6ATBV8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t4mKhO2OxOUG5vRXkOtrN6yhgj5CzhkNbyZWmqNLfJyHLWoyihIPsV63pAdOu0wr1Ss2IKeXuYX0zPD73nKijZLZyd7Uz5m+yxcOpY8RHaxmYcI+mWePxrzJb3fcRrifjRVZAEckJabhHmXZ51OrFHlUReLRzGqqNtTYpQR3BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4398f9e3b40so3444006f8f.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772312593; x=1772917393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O35uonhRxUErn8PehDwzDaZtvJOLmBpPigcsBhrJPWA=;
        b=sKHuYuOws2POMBpiDW5h5n44YVWK1U1bHyW2lY1WZ1GNG/oNeXxqzK8glLr62PW58D
         oyi+O2MuSm/vuEP5IZSkcEW0LXLon3eiT2koyDmaYizb27ryrzYgI1rP1aznGfCgCcSm
         x1exYUZinQL6iBvZ/uyxWIrfk97RwC86yx/fj50+AezGRUBtOOT4vt5HQyGeAzaOMu3n
         1VlR0A9tilg+KyQSFchvBUNMf+Ej2J40suUg+ZAEpkFkJWB3agMW5YjGyOrx/gxxvaAa
         vzoCqZQAazI/vA+0tLG8EgFyCQlULcGaRubLGU4givxocrZgyIhmZV7SyDaYLNHuzcGO
         MCCA==
X-Forwarded-Encrypted: i=1; AJvYcCX/JxOPkwq/EC43b+UxsYZu5nrUW56TZlydeVqYJB1EFOokTXtCUv3AxX6X8DN6qb6mPYgyJO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0ml//dAQSPz1kNlBtThzf3bCyq0ygJbjy01uChqwlFUXTk6A
	371X1K24M8Cob44BG5Wy+m61106LqvKTLYLW4v4kB5Bi7/RjXdjegu/n
X-Gm-Gg: ATEYQzz2MZxJYPFdJLF2RjS88WOQmi8PUKFFsxiuYFlOtG3IDffCeYmls8tYdzwztol
	YCW9Fvbt7WsFJQW0dtr4+BVgZn4AIjlfgPvDjEgDZbwy31C1bJj0KIgYSL2BR9IHc7yw23t8HFT
	WBXGMrZ6aEWsaXdwsq2GO/SlctXBE9GVBJ40l/pyoZKEsIa8NEXOXpB0xTwyXCoPJXZaok4a8lW
	fGu0qqfSG9n14GfYgpQFbX0Eg07T4YbKC/ls7nfQS79xkC/ke326jZkM5ytUzoDQb6OcSKXJbnE
	MW/GxBMb1paQXvkB/fhrbR2u3fznNPkXZhtaff2ovfVn9ox54sy3App3e6BMuHas583iaFdUUij
	LoMQdV24WmcXdCAj42Obq8Ca4KFSPJpunR+TiUZ2KsBFYliTsPQjLPJRP3jsbGtAbvvuT1g+BFi
	Sy/JOE02brVPq7vpmN1ebbryy3VRgHFTh3nS/iPZOAjohF4JyqQ4ow7rVsyiI=
X-Received: by 2002:a05:6000:2890:b0:435:bbd7:18d8 with SMTP id ffacd0b85a97d-4399de14ab6mr13743316f8f.17.1772312592719;
        Sat, 28 Feb 2026 13:03:12 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ab6ebe56sm4851210f8f.15.2026.02.28.13.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 13:03:12 -0800 (PST)
Message-ID: <476d32c9-87b0-42e0-a2dd-abc365abc758@ovn.org>
Date: Sat, 28 Feb 2026 22:03:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
Subject: Re: [PATCH net v2] net: openvswitch: clean up some kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260228010058.2385110-1-rdunlap@infradead.org>
 <4bf254a7-8e4c-4436-befb-1e0a2835100d@ovn.org>
 <b57d3819-b531-4901-81db-b0cd1f16eed5@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <b57d3819-b531-4901-81db-b0cd1f16eed5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-262220-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ovn.org:mid]
X-Rspamd-Queue-Id: 0DF451C8BB4
X-Rspamd-Action: no action

On 2/28/26 9:47 PM, Randy Dunlap wrote:
> Hi Ilya,
> Thanks for your careful review of these changes.
> 
> On 2/28/26 9:55 AM, Ilya Maximets wrote:
>> On 2/28/26 2:00 AM, Randy Dunlap wrote:
> 
>>>
>>>  include/uapi/linux/openvswitch.h |   72 ++++++++++++++++++++++++++---
>>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>>
>>> --- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
>>> +++ linux-next-20260227/include/uapi/linux/openvswitch.h
> 
> 
> 
>>> @@ -291,12 +313,13 @@ enum ovs_vport_attr {
>>>  
>>>  /**
>>>   * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
>>
>> Not a problem of this patch, but this line is also wrong, there are no
>> such commands.  These are attributes for OVS_VPORT_ATTR_UPCALL_STATS.
> 
> I corrected that.
> 
> 
>>> @@ -652,6 +681,8 @@ enum ovs_flow_attr {
>>>   * %UINT32_MAX samples all packets and intermediate values sample intermediate
>>>   * fractions of packets.
>>>   * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
>>> + * @OVS_SAMPLE_ATTR_ARG: same as @OVS_SAMPLE_ATTR_PROBABILITY, for in-kernel
>>> + * use, passing &struct sample_arg.
>>
>> I wouldn't call it 'the same', more like 'extended', or just omit that part of
>> the description, keeping only what's after the comma.  Or maybe "For in-kernel
>> use, passing &struct sample_arg derived from other attributes.".
>>
>>>   * Actions are passed as nested attributes.
>>
>> This line belongs to OVS_SAMPLE_ATTR_ACTIONS.
> 
> OK, moved it.
> 
> 
>>>   * @OVS_ACTION_ATTR_PUSH_MPLS: Push a new MPLS label stack entry onto the
>>>   * top of the packets MPLS label stack.  Set the ethertype of the
>>>   * encapsulating frame to either %ETH_P_MPLS_UC or %ETH_P_MPLS_MC to
>>> @@ -997,6 +1050,7 @@ enum ovs_psample_attr {
>>>   * start of the packet or at the start of the l3 header depending on the value
>>>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>>>   * argument.
>>> + * @OVS_ACTION_ATTR_DEC_TTL: Nested OVS_DEC_TTL_ATTR_* action.
>>
>> "Decreate TTL or hop limit of the packet.  Execute nested %OVS_DEC_TTL_ATTR_*
> 
>    Decrement
> ?

Ugh.  Yes.  Certainly a typo.  A fairly strange one. :)

> 
>> actions if the value is less or equal to 1."
> 
> thanks.


