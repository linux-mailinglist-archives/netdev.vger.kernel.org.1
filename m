Return-Path: <netdev+bounces-133692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60621996B44
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD81F21344
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D1192B70;
	Wed,  9 Oct 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="AXq56k6C"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF4194096
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478847; cv=none; b=kukomHSw5/UcIWYozHi/pRfYjwnpNZMOSs/gWtaHXxnMcYxROhFXFW3TIeu9QHby+qsCihbEQW2l0kMNb7YjYbzwNGBCHt/UGeeNhRfLrylM27gRhjBiUjVnj7tqKmohPIVx6VIJkdFPQzprI8CSFMyKy3JF+Wozz7O0tL5rzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478847; c=relaxed/simple;
	bh=6jFkbWr+jAx9YO9khys0ZtYBht4UDnoINcvOm/Fnhyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnR82PcJKuQsWP5XtMu2S6hMG03B1pnKk19rsYvc9jg/7LNe+kVQ0kqHLAY/NjENeLGc+eRL+Pr5yGE9g7JKkodUFng52odP2BAthyoRuLwRGU68tkHYw99lLOMKVXCKv2Zapnh5Nz6fLSsogppn68Ubc+hCaXOaAnw1zvYifd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=AXq56k6C; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id E3EA9980;
	Wed,  9 Oct 2024 15:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728478843;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jlBowv3ZQXHjUyOB+lzdvRXzglt46fFx7urCRPlm8GY=;
	b=AXq56k6C0izo08V7J+6nXsVYE4XjGUt7wYePC72usXVIohEQR7Oy3Zfaxe9ezaDN
	Knr5C3SySo0MjWWh22IWT5PBkabQA907B8LwFZLUUPqwNuJATwd8vaqnsCqMal1P+qj
	hBLvZi1kyhIg+DQEO8wcbq/TQsPzdAWZDpJ4ZZQXhQVHm0tEpAZziDg980Eu8BVNVri
	A6uLp8Se7wEoXJXnDOCQsUh0d5tIvku77YfF/jFv3acA2vDt/A6brFdF15eRe67fOM4
	VroOTriMVOFg/ddPcVdY0YAcFHfdpPMXEkSdlTXjzKg2C4CRZTNohrdyjwxaplT0cAs
	lOt/5RAZ9g==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 9 Oct 2024 15:00:41 +0200 (CEST)
Message-ID: <fbfc65b2-7614-44a1-9fcb-daa1a8f1e780@unstable.cc>
Date: Wed, 9 Oct 2024 15:00:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: ynl-gen: include auto-generated uAPI header only
 once
To: Jiri Pirko <jiri@resnulli.us>
Cc: kuba@kernel.org, netdev@vger.kernel.org, donald.hunter@gmail.com,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
References: <20241009121235.4967-1-a@unstable.cc>
 <ZwZ7_qjDH_y0JIcN@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ZwZ7_qjDH_y0JIcN@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688

On 09/10/2024 14:50, Jiri Pirko wrote:
> Wed, Oct 09, 2024 at 02:12:35PM CEST, a@unstable.cc wrote:
>> The auto-generated uAPI file is currently included in both the
>> .h and .c netlink stub files.
>> However, the .c file already includes its .h counterpart, thus
>> leading to a double inclusion of the uAPI header.
>>
>> Prevent the double inclusion by including the uAPI header in the
>> .h stub file only.
>>
>> Signed-off-by: Antonio Quartulli <a@unstable.cc>
>> ---
>> drivers/dpll/dpll_nl.c     | 2 --
>> drivers/net/team/team_nl.c | 2 --
>> fs/nfsd/netlink.c          | 2 --
>> net/core/netdev-genl-gen.c | 1 -
>> net/devlink/netlink_gen.c  | 2 --
>> net/handshake/genl.c       | 2 --
>> net/ipv4/fou_nl.c          | 2 --
>> net/mptcp/mptcp_pm_gen.c   | 2 --
>> tools/net/ynl/ynl-gen-c.py | 4 +++-
>> 9 files changed, 3 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>> index fe9b6893d261..9a739d9dcfbd 100644
>> --- a/drivers/dpll/dpll_nl.c
>> +++ b/drivers/dpll/dpll_nl.c
>> @@ -8,8 +8,6 @@
>>
>> #include "dpll_nl.h"
>>
>> -#include <uapi/linux/dpll.h>
> 
> What seems to be the problem? The uapi headers are protected for double
> inclusion, no?
> #ifndef _UAPI_LINUX_DPLL_H
> #define _UAPI_LINUX_DPLL_H

There is no problem to fix, this is just a compile-time 
micro-optimization by reducing the number of includes to follow.

I was recently told there is ongoing effort to reduce the amount of 
useless includes in order to speed up the compilation process.

I thought this was an easy fix in this direction :)

Regards,

-- 
Antonio Quartulli

