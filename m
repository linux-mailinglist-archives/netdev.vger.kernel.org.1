Return-Path: <netdev+bounces-133724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E0996CC4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3997E1F21378
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5819925B;
	Wed,  9 Oct 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="iv+bV3V4"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4F198E7B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481986; cv=none; b=PLyzDa8WvzOLeyfB6QrJRDhZMNLmRo3/AdY8AdMg3yC6RQz+gcmOorLByl5lXtTfJaiHcooWT2nLZLTFJhGQ1dl/+72rDgCWYYwyufCI+bxiIR2qJ1ExEXVd92cAauI9joS+vvE2sid4YdAO5dbWu2DVqHrObSZW5kucpPFFOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481986; c=relaxed/simple;
	bh=WadcYvP8DxOSO/GZf0Bdt2QVNMYzz3tlYzLrLydjC48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nspCswm4duj/o5EqjmsdzlvAovscsY5Q4Rd9V9ZgoVyrM2bXFBU3ErsmujTn1qXle21X1aGSLOcqyrmDXyKm0IGMWLqrXeHH2TD3Kwl7oTQZZVEkj5TlR00OMgJ2hnS6CjkD/+yH1pSPRnMi84Dy43X91ttomviLuGImzQNxjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=iv+bV3V4; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 609E241D8;
	Wed,  9 Oct 2024 15:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728481982;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lCk96be09nsEHc8xwiP87ZSlr1LNPoLpLxcT7lU3aPc=;
	b=iv+bV3V4SYGgCLRFUihO8LepEDwwN5+IusvSLVPXq2UUieYehKFE2DGrTkh0for4
	Q8MGeUh33gt2MvV9Rf/lhGMnJPNEWGGR1clOOvgDLQ/59TTevOnv5avyk+8cBj2yLW7
	0z5SMCoNqdV491iUAzvZPJKgiBRbHvh1ojHPY3oVDlZv2G+lI4jlZ4vPpxnBha/JdFk
	ZfFyza9IR5LxQozxqQw2PI2F6LTKUJmKvSoy13LVRqs2sxEsD85LMAFNw9p0g6FDSk/
	HiW58QDD2TrVcUg6uMdItPwf/0+FeU1G0p+8l56RV38WvMuHh4aU11LLsasxVTLv9/x
	7dI6iSJ55Q==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 9 Oct 2024 15:53:00 +0200 (CEST)
Message-ID: <fcd54618-bed6-4fd4-8438-ff148b7e8b99@unstable.cc>
Date: Wed, 9 Oct 2024 15:53:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: ynl-gen: include auto-generated uAPI header only
 once
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, donald.hunter@gmail.com,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
References: <20241009121235.4967-1-a@unstable.cc>
 <ZwZ7_qjDH_y0JIcN@nanopsycho.orion>
 <fbfc65b2-7614-44a1-9fcb-daa1a8f1e780@unstable.cc>
 <ZwaHF8ZEEHXV7yCE@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ZwaHF8ZEEHXV7yCE@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688

On 09/10/2024 15:37, Jiri Pirko wrote:
> Wed, Oct 09, 2024 at 03:00:42PM CEST, a@unstable.cc wrote:
>> On 09/10/2024 14:50, Jiri Pirko wrote:
>>> Wed, Oct 09, 2024 at 02:12:35PM CEST, a@unstable.cc wrote:
>>>> The auto-generated uAPI file is currently included in both the
>>>> .h and .c netlink stub files.
>>>> However, the .c file already includes its .h counterpart, thus
>>>> leading to a double inclusion of the uAPI header.
>>>>
>>>> Prevent the double inclusion by including the uAPI header in the
>>>> .h stub file only.
>>>>
>>>> Signed-off-by: Antonio Quartulli <a@unstable.cc>
>>>> ---
>>>> drivers/dpll/dpll_nl.c     | 2 --
>>>> drivers/net/team/team_nl.c | 2 --
>>>> fs/nfsd/netlink.c          | 2 --
>>>> net/core/netdev-genl-gen.c | 1 -
>>>> net/devlink/netlink_gen.c  | 2 --
>>>> net/handshake/genl.c       | 2 --
>>>> net/ipv4/fou_nl.c          | 2 --
>>>> net/mptcp/mptcp_pm_gen.c   | 2 --
>>>> tools/net/ynl/ynl-gen-c.py | 4 +++-
>>>> 9 files changed, 3 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>>>> index fe9b6893d261..9a739d9dcfbd 100644
>>>> --- a/drivers/dpll/dpll_nl.c
>>>> +++ b/drivers/dpll/dpll_nl.c
>>>> @@ -8,8 +8,6 @@
>>>>
>>>> #include "dpll_nl.h"
>>>>
>>>> -#include <uapi/linux/dpll.h>
>>>
>>> What seems to be the problem? The uapi headers are protected for double
>>> inclusion, no?
>>> #ifndef _UAPI_LINUX_DPLL_H
>>> #define _UAPI_LINUX_DPLL_H
>>
>> There is no problem to fix, this is just a compile-time micro-optimization by
>> reducing the number of includes to follow.
>>
>> I was recently told there is ongoing effort to reduce the amount of useless
>> includes in order to speed up the compilation process.
> 
> Do you have some numbers?
> 
> So far I had impression that the common practise is to include header
> directly when needed and not to depend on indirect include.

That's the same rule I had been following in the past, but Andrew 
advised to do differently here:

<07050ffc-aa8e-417a-b35b-0cf627fc226f@lunn.ch>

He also says:
"There is a massive patch series crossing the entire kernel which 
significantly reduces the kernel build time by optimising includes."

I trusted his word and I just assumed this was the wanted direction 
nowadays.

@Andrew: maybe you have a pointer to the series?

Thanks.

Regards,


-- 
Antonio Quartulli

