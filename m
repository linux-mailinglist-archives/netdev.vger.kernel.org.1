Return-Path: <netdev+bounces-300007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v/MgNWYJMmrUtwUAu9opvQ
	(envelope-from <netdev+bounces-300007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A516962C6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:41:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=motor-comm.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300007-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300007-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A083028370
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CE2F8E97;
	Wed, 17 Jun 2026 02:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A52EF67A;
	Wed, 17 Jun 2026 02:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664100; cv=none; b=XI0T+JO4EPZere4AV758wBZBQ6GqJ4vvGwwECKtn7Kw1eh8GsQRSMlhLwb3VEQlnZGUmTlEYYujLimt1I94xiOIRpzqFIuTwk/KIXM/cza4Z9255Tlilghcybho1uFG9tg09lFdDEj9rhOSuflzEpA8AjUCODkHfJAZ7IjbeqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664100; c=relaxed/simple;
	bh=RCEaZstgGigHVXUhy5obX9wbxQ/70GfZufDSzHa8hPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl1NvAG3xBTye9FXDY0czTAvp5Peje6VId6mSoyda7/KUw3Fz5w7yjr1YxGB1vaRfvSSUeflOPKf3IVvunR0ITNF4wTgd7i0t2gQPQhDY5Idinu+/q8czkg0xFuM46aaF9sTeOVHNgwm4g+tXNsZ9ClkEEG+AOYnxc4eXBNFjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1270697|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0316465-0.000470398-0.967883;FP=11662652842634243728|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.i-EXH0W_1781664085;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.i-EXH0W_1781664085 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 10:41:29 +0800
Message-ID: <89ca7f16-4528-4dfa-8b08-3eb7a0a65057@motor-comm.com>
Date: Wed, 17 Jun 2026 10:41:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Julian Braha <julianbraha@gmail.com>, mmyangfl@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
 <eeacfa0d-9303-407f-8e8a-ecc95d1ab1c8@gmail.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <eeacfa0d-9303-407f-8e8a-ecc95d1ab1c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[motor-comm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:julianbraha@gmail.com,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300007-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,motor-comm.com:mid,motor-comm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A516962C6



On 6/15/26 23:01, Julian Braha wrote:
> Hi Kyle,
> 
> On 6/15/26 12:12, Kyle Switch wrote:
> 
>> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
>> new file mode 100644
>> index 000000000000..f40d75e2a3f2
>> --- /dev/null
>> +++ b/drivers/net/dsa/motorcomm/Kconfig
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config MOTORCOMM
>> +	tristate "Motorcomm YT92XX switch family support"
>> +	depends on NET_DSA
>> +	select FIXED_PHY
>> +	help
>> +	  This driver adds support for Motorcomm switch chips. It supports
>> +	  YT921X and YT922X switch.
>> +
>> +choice
>> +	prompt "Motorcomm switch series selection"
>> +	depends on MOTORCOMM
>> +
>> +config MOTORCOMM_YT921X
>> +	bool "Motorcomm YT921X series."
>> +
>> +config MOTORCOMM_YT922X
>> +	bool "Motorcomm YT922X series."
>> +endchoice
>> +
>> +config NET_DSA_MOTORCOMM
>> +	tristate "Motorcomm YT92XX switch DSA driver"
>> +	depends on MOTORCOMM
>> +	depends on (MOTORCOMM_YT921X || MOTORCOMM_YT922X)
>> +	select NET_DSA_TAG_MOTORCOMM
>> +	select NET_IEEE8021Q_HELPERS if DCB
>> +	help
>> +	  Select to enable support for Motorcomm driver.
>> +
>> diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
> NET_DSA_MOTORCOMM already depends on:
> (MOTORCOMM_YT921X || MOTORCOMM_YT922X)
> with both of those options depending on MOTORCOMM due to the 'choice'
> that they're in, so this additional dependency on MOTORCOMM is
> unnecessary.
> 
> You could also consider using a comment to document that this option is
> depended on indirectly.

Ans: agreed, i will fix this later.
> 
> - Julian Braha

