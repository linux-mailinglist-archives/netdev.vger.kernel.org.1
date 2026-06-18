Return-Path: <netdev+bounces-300384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aPXjJLfBM2pOFwYAu9opvQ
	(envelope-from <netdev+bounces-300384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C6569F0DE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=motor-comm.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300384-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300384-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A7913044F5D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF93DF009;
	Thu, 18 Jun 2026 09:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37DB3E6387;
	Thu, 18 Jun 2026 09:59:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776798; cv=none; b=fsRySs1Fi+f2o9IipY0cDlGjWDjvviVMi03JSY9k4AUYOIK/GEU0FAsDhjklzFwjtZ5wVUyYlaR7Hpd8pcg1GLHyUsB465GgCnagpucH7RYmujHjtTq/XiRtZTLL7Ncu6G0rXouJcUv1M+y0VzPOVjrZxSh1zrFCuBZmgkMMc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776798; c=relaxed/simple;
	bh=Af5GXg91NjJxXP55nt+FlV/hEz44bkALO5T42DkbsnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LraEjiUOWPtBd5yKD93eKOuEACcCF9mkiiyO6GMfCpdFlCSjctQl7LpR7yOCSSgb9IY5TJ5aYH/khsFUExNaim7WwB+6bOHnQeAnQV8D2eI5SwREinIKnz9R0TNFu92QWBo0yLZhvgZ6g/zLrOrvx0EZWeMQ81cBq5HP0Tl+m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.53
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07466074|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.35648-0.0125712-0.630949;FP=15155477914917510673|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.i.he.P1_1781776784;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i.he.P1_1781776784 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:59:47 +0800
Message-ID: <c853b074-20e5-46fd-9b37-1195a9de7a8a@motor-comm.com>
Date: Thu, 18 Jun 2026 17:59:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: David Yang <mmyangfl@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
 <88f726d5-1617-4d2e-8fbb-d3da9478b386@motor-comm.com>
 <CAAXyoMMYxRTwHD6QmpAkspCtiY853KkYuOAUR=qV0v9g5w9v+g@mail.gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <CAAXyoMMYxRTwHD6QmpAkspCtiY853KkYuOAUR=qV0v9g5w9v+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[motor-comm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300384-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[motor-comm.com:email,motor-comm.com:mid,motor-comm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30C6569F0DE



On 6/17/26 19:15, David Yang wrote:
> On Wed, Jun 17, 2026 at 10:37 AM Kyle Switch <kyle.switch@motor-comm.com> wrote:
>>>> +/* To define the from cpu tag format 8 bytes:
>>>> + *
>>>> + * 0 1 2 3 4 5 6 7 | 0 1 2 3 4 5 6 7
>>>> + *|<----------TPID 0x9988---------->|
>>>> + *|<--RESERVE-->|<-----DST PORT---->|
>>>> + *|-|<---------RESERVE------------->|
>>>> + *|<------------------------------->|
>>>> + */
>>>> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
>>>> +#define YT922X_FORMAT2_TAG_LEN                  8
>>>> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
>>>> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
>>>> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
>>>> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
>>>> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
>>>> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1
>>>
>>> If yt922x tag format shares no common with yt921x, make a new tag driver.
>>
>> Ans: thank you for your suggestion, we will consider whether to create a new driver in the new file.
> 
> I'm not an expert in this, but if yt922x tag does support cpu codes
> and priority, please consider updating yt921x tagger to support it,
> even if you don't use or test these features for now.
> 

Ans: here "updating yt921x tagger" you mean yt922x tag driver to support cpu code and dscp prio? We consider
implementing it in the subsequent patch, but no matter what, when we submit the yt922x dsa driver ,it will support it.

>>>
>>>> +static struct dsa_tag_driver *dsa_tag_driver_array[] = {
>>>> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
>>>> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
>>>> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
>>>> +};
>>>
>>> If both are supported by the chip and 4b does nothing more than 8b
>>> does, do not bother with it.
>>
>> Ans: 4b and 8b dsa tag may have different application scenarios. from my opinion,
>>      1. 4b dsa tag can save 4 bytes of payload
>>      2. 8b dsa tag carry more package info.
> 
> We do not support every tag protocol. For DSA switches,
>   - the conduit interface supports jumbo frames so there is room for
> the DSA header, or
>   - you end up with MTU less than 1500 anyway.
> 4-byte reduction does not make a practical difference here. An
> alternative protocol poses 2x work to everyone else, and unnecessarily
> exposes your driver to interoperability issues, as pointed by Andrew.
> 
> As I've commented before, if there is a particular reason to add
> 4-byte protocol, leave it behind for the moment, and focus on a
> minimal yt922x_dsa_switch_ops + yt922x_netdev_ops for your first
> patchset without any offloading supports. This way, others can easily
> see your changes and move the work forward efficiently.

Ans: Thank you for your advise, 8bytes dsa tag driver will be supported firstly.


