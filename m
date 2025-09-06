Return-Path: <netdev+bounces-220590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D5B4733D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCA91C201F9
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3722538F;
	Sat,  6 Sep 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BhKe6DCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3C221264;
	Sat,  6 Sep 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174357; cv=none; b=Nel7CD/WdQ9/JqhXQBmpezm8jiVBURs2cN/I7dd2XU7//XGy///UIpoUu+C/NO1r0fR6eJMcFO1X4QBVe6F08T7dm6oTr9Xf1aiF/elcLCJj01qpgeOlg5lG9edvU+3xU4PF+/r5Slx9afKpqu9oE/BeAv2UNrqtJYwh5jckXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174357; c=relaxed/simple;
	bh=XzuoT0WSkJbb6iiSwS7U92Qd0e3ls3F0BkGucQXz1Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1qGYXtikYF60N6ropv73Ql9Ur7sZVbn0IpmCqNnQqPcoBsCyvGLtEdlm/nvfgVbD8aLCR3YUS1KU0EHontldV/XJRl0fPQP8TrOkxuPXvic19fOZ3OeF2VfOY8AZvS7BYApfb4lvpxaezRhqnaRi1lUClE6OakP+BrilIu8X5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BhKe6DCS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757174351;
	bh=XzuoT0WSkJbb6iiSwS7U92Qd0e3ls3F0BkGucQXz1Wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BhKe6DCS6msxct+OYYzo3wFMOUo2t7DP8KsaQkhrTgjY9mmBggADOXmB2wSJcsihs
	 s+3HZqDxnYYhcwDdRovP9TEfAdjl1fpnPHKVIbIqO/VtMcsUzLvBb80gCoL+SBI259
	 P8P3k/KVlTRw9nsBsK0ApOTbojRG8B4h4ii/Yua4vXHQUPDSHaPff3XUn0sFfexFxm
	 uvyaUStaEWqgg6Fo5tx5T2Z5IEismxmGDI93gsqFs46UQuE6T92RuKiT9f7Bwn/A8j
	 06Cq2n9Nj7DQzaekOe5O9MERpSC6mkSbFpaqLRF0nSozEB0lI/+xERcNkCgIVJcQ5B
	 60icJeU/6N8KQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BE8416000C;
	Sat,  6 Sep 2025 15:59:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 5FD50201DC8;
	Sat, 06 Sep 2025 15:59:07 +0000 (UTC)
Message-ID: <228eae2b-5a52-48c0-a3a2-afbd3e45adf2@fiberby.net>
Date: Sat, 6 Sep 2025 15:59:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/11] tools: ynl: add ipv4-or-v6 display hint
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-11-ast@fiberby.net> <m2cy85xj9h.fsf@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <m2cy85xj9h.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/25 10:53 AM, Donald Hunter wrote:
> Asbjørn Sloth Tønnesen <ast@fiberby.net> writes:
>> The attribute WGALLOWEDIP_A_IPADDR can contain either an IPv4
>> or an IPv6 address depending on WGALLOWEDIP_A_FAMILY, however
>> in practice it is enough to look at the attribute length.
>>
>> This patch implements an ipv4-or-v6 display hint, that can
>> deal with this kind of attribute.
>>
>> It only implements this display hint for genetlink-legacy, it
>> can be added to other protocol variants if needed, but we don't
>> want to encourage it's use.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> 
> I suspect there are occurrences of ipv4 or ipv6 in the existing specs
> that really should be ipv4-or-ipv6 but the python code doesn't care.

I haven't been able to find any, containing 'ip' or 'addr'.

Speaking of display hints, then WGPEER_A_ENDPOINT is another interesting
case, it is struct sockaddr_in or struct sockaddr_in6, I have left that
as a plain binary for now, but maybe that could be a struct map, based
on struct length.

attribute-sets:
   -
     name: wgpeer
     [..]
     attributes:
       [..]
       -
         name: endpoint
         type: binary
         struct-map:
           - sockaddr_in
           - sockaddr_in6

With the requirement being, that all structs must have a unique length.

