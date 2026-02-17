Return-Path: <netdev+bounces-259138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sWPZEYDDlGmFHgIAu9opvQ
	(envelope-from <netdev+bounces-259138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:37:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DF14FADB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1963024C80
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440C36C5BF;
	Tue, 17 Feb 2026 19:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5E1684B0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357053; cv=none; b=rheot9Llw3SeGB8kpvAakhsr8z3x+kP3zGzOJLwDMjhhh0SzB11bugvVXlim76owSe0SQS0Q6mngCzfsyHAyQTHZvST0PekJMmL9t5Ej3GVvF2jIlUTvwUFLeJl+13HQjdC9HA+ks5Jf1a4qajHDoBI9In3TegtdodiVN09Pdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357053; c=relaxed/simple;
	bh=bx5/IDJ766S1nWvOvNHGC13fyuKb+iFnkYS4dDktWq8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=keHZWEnZmTt8GVOjhf+UQKm94z8sYlgF+agDMH2Ubwtq2s0Byikc2AALeG74BtTlBvktUTp7Kfox0ninZbr++WZgqEG1hmxeunsWzR1XCKgKIluhandesbW39yBHKms+NbZ4t1SOG5nRMB09oRIU7bvmlb8HdcVf/o7K8BUUBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483770e0b25so40802645e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357050; x=1771961850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwVRFwdARvzzYKaevpc7B86ITGB+GpGt8pa5nBbKSes=;
        b=mjWl8xyrmIjNOhD1wFHuDxBZBVHG9Cp5YK37WatFW0Xocx+9hRXkWRH1pPCH4AxbiE
         H8bUoA3Sa5k/hNjKb2+Qhm8L94IO9eMoBM9rJVt+FpTAnvFmP96v8uTIUig8o9lRfzIw
         5k8IwtJS9Sao+rzDrI7nTVK9lr6C8I/RQ9+4cJPLXLHkHQd5sAe6q1a3ZR16+ctExzZL
         OUnzo/qT7eVHKxvJ5EHmM5Dc5extZUhAeDIwyrPBh8aKqojWOmwJHFYqIokLs7CWmIVN
         bcCBN8BUOOG5CArx1Or6ilXyOwojE0lMXhdHuMrK4iQFpOKMXcnVhU8sTmVWG0On2vgd
         xj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXXahgZ/YaxYnslLU9ovmIw29Ujke0la+1XBfzG8dHbO2QsiVufAwasj9+jQ6dbSPhENmCgXIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcmgrRbxVU4PHkwHFd+VLTMx6T3EMQ+OCAxRTAfV6tSDEWK2/
	y5veBTcQF9AZbRcnSUNl7tFWbwrUuPsMidtuWBlH3yhVKcSZws3O0+WA
X-Gm-Gg: AZuq6aKXVatWnzk4hHdx2X8aXiFVjCglhTqDo79HkZnrvNYlkLilGjtTpFDYQhLvxHd
	n1uVfykpK+pfQL5eTytnJao2sRLJz2wmAoixBhOgSxaZ0LY8NTQmVZZceA4g7D7L/EKErwUDpcq
	4KYF9oonaZVIiNj7oN5l0ImUQWbX8pLBy4m3qlN4W72nhI7I4OoG39x1Xsjrlz/AFcY28BbkjtX
	yJPcX/Aoy4NhFPNsiBIxV0mCYOSGgmhv+ncYC+itZbXPLP0qRkr3deCxBZtAmP1uC8ofBu4LVS8
	v5AkRkNvhhnnl9h2/cyvEF89+Br9ACh9RiKVFvbpCvWTeDPEoFTUU7BeVBaX9DhWHNs1DQcgkGS
	z2J8V4lFKT21zau9OVJJmSvXEOgAQ4g0dTjej6GUK3HP75PWAi8zBMONRMlRQkQeh49MChzunvG
	gwBmBkRYoQm5Zcs+Xh4DU1AAdJ0qBwnhBT3wZKBH/qL9T9dE5yQopw3GlM1eQ=
X-Received: by 2002:a05:600c:37c6:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483710960dcmr258560705e9.34.1771357050108;
        Tue, 17 Feb 2026 11:37:30 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfb28dsm488337845e9.11.2026.02.17.11.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 11:37:29 -0800 (PST)
Message-ID: <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
Date: Tue, 17 Feb 2026 20:37:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
 <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
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
In-Reply-To: <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-259138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7D2DF14FADB
X-Rspamd-Action: no action

On 2/17/26 4:52 PM, Paolo Abeni wrote:
> Adding Florian, too
> 
> On 2/17/26 3:49 PM, Ilya Maximets wrote:
>> On 2/17/26 10:38 AM, Paolo Abeni wrote:
>>> Since the blamed commit below, classify can return TC_ACT_CONSUMED while
>>> the current skb being held by the defragmentation engine. As reported by
>>> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
>>> later on tries to tuch again such packet.
>>>
>>> act_ct was never meant to be used outside of the ingress path. Making
>>> defrag really works for act_ct outside such constraints range from very
>>> difficult to completely impossible.
>>>
>>> Address the issue making act_ct drop any packet when not attached to the
>>> ingress path and additionally emit a warning about the bad
>>> configuration.
>>>
>>> Reported-by: GangMin Kim <km.kim1503@gmail.com>
>>> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
>>> CC: stable@vger.kernel.org
>>> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442afa7.1770394932.git.pabeni@redhat.com
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> Catching the bad configuration at runtime instead of init time to reduce
>>> complexity
>>> ---
>>>  net/sched/act_ct.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
>>> index 81d488655793..e8eb0d195f4a 100644
>>> --- a/net/sched/act_ct.c
>>> +++ b/net/sched/act_ct.c
>>> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>>>  	tcf_lastuse_update(&c->tcf_tm);
>>>  	tcf_action_update_bstats(&c->common, skb);
>>>  
>>> +	if (!skb_at_tc_ingress(skb)) {
>>> +		pr_warn_once("act_CT should be attached at ingress!\n");
>>
>> Hi, Paolo.  I didn't test this yet, but I'm a little concerned about this
>> change.  For TC offload of OVS tunnels, we create egress qdisc for internal
>> ports, a.k.a. bridge ports.  This is necessary for tunnels to work.
>> A typical setup looks like this:
>>
>>     Bridge br-int (10.0.0.1)
>>         Port br-int
>>             Interface br-int
>>                 type: internal
>>         Port vm
>>             Interface vm
>>         Port vxlan0
>>             Interface vxlan0
>>                 type: vxlan
>>                 options: {remote_ip="172.31.1.1"}
>>
>>     Bridge br-phy (172.31.1.100)
>>         Port br-phy
>>             Interface br-phy
>>                 type: internal
>>         Port eth0
>>             Interface eth0
>>
>> When a VM sends a packet that supposed to go through the tunnel, it enters
>> from the vm port and OVS forwards it into vxlan0 LWT with an appropriate
>> tunnel metadata.  Then it gets encapsulated and put into kernel routing to
>> find the next hop, which is via br-phy bridge.  Packet enters br-phy and
>> OVS forwards the packet to eth0.  There can be stateful processing in the
>> br-phy bridge involving passing packets through conntrack.
>>
>> With the TC offload enabled, OVS creates following filters:
>>
>> 1. Ingress filter on vm interface that forwards packets to vxlan0.
>> 2. Egress filter on br-phy interface that forwards encapsulated packets
>>    to eth0 interface.
>>
>> If some stateful processing is involved, both of those could have act_ct
>> in them.
>>
>> AFAIU, we have to use Egress qdisc for the br-phy, because the packet is
>> egressing from the kernel routing via br-phy and the ingress qdisc is not
>> invoked.  Ingress will be at play when packets are flowing in the opposite
>> direction from eth0 to br-phy, as that's where they will ingress into
>> standard kernel routing.
>>
>> If act_tc will not be allowed on Egress, then stateful processing will
>> not be possible in this case in br-phy bridge.
>>
>> Thoughts?
> 
> This looks very problematic. A slightly different patch tried to
> somewhat preserve functionality, but it simply can't work in presence of
> IP fragments.
> 
> Why stateful processing on  br-int/port vm ingress is not enough?

In general we don't know where the packet will go after encapsulation,
so we do not know beforehand if it will end up in another OVS bridge
or not.  Hence the processing has to be split in two parts, the ingress
on vm port and egress on the other bridge port.

At the same time, thinking more about potential use cases, I don't see
a good one for running encapsulated traffic through conntrack.  Most
of the time it's a UDP unidirectional traffic with hashes for source
ports.  Not sure what functionality would require to do anything
stateful on such packets.  So, maybe it's fine to prohibit act_ct on
the egress after all.


For the implementation however, let's look at a different very simple
use case:

   Application on the host -> br-phy -> NAT -> eth0.

This is a very common thing to NAT traffic before it leaves the host.
It can be for load balancing reasons, e.g. if a destination is a service
IP with multiple backends and we want multiple applications to hit
different backends.

There is no actual reason to try and offload such traffic to TC, as it
would not be possible to offload it to hardware (since the traffic
source is an application on the host).

However, since OVS doesn't really know that it's not possible to offload
to hardware and TC by itself allows creation of such filter, it will
create the filter on the egress qdisc on the bridge port and that egress
filter will be performing act_ct with the NAT.

With this patch applied, all this traffic will be just dropped.  If we're
going to prohibit act_ct on egress, that should be done at the moment of
creation of this action on the egress qdisc, so the user knows that it's
not supposed to be there.  E.g. if OVS will try to create such action and
fail, it will keep forwarding the traffic successfully through the normal
openvswitch datapath.  But if the TC filter creation succeeds, all traffic
will be just dropped by it.  That doesn't sound right.

Best regards, Ilya Maximets.

