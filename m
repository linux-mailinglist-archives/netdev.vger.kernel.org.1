Return-Path: <netdev+bounces-231869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4831BFE0E6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E84E16C8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA02F5466;
	Wed, 22 Oct 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="JaL73+ye"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1C2F60B4;
	Wed, 22 Oct 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161842; cv=none; b=briKdrFfpiu6kwXL58GPxynh2K30ZulyTHLt77HrtDGTpSJlKd/O++V2Ecg/TDCkPgINm1wi44oyRlGwRf8IWpfnjGdOvPVYlnGvS3MYQGM3erDOiCyc5AT7qRKMqkbsrLs9Dn6QvcPSXYBfWP8BEx8qEZ4JS1pncKvOMgIMxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161842; c=relaxed/simple;
	bh=0TYebRvbuZCp2Egy8udf+FKsqp2mhDPfM30PftmeBPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzXbeIPrHD5lSx2IAfTkfmj7H0KYYwXSY4VlJOnFGXIQmzSQGUggnNuZJkXObYiMzaNJUNlcAVnBZBJsiklWBhSpaORDOdONWIW4N54cUeZbuoPpiPyzMTy922ygossxE+DfxpczjCdwVEifn23LxBMt6Q7dcTgSg7u4RSCcuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=JaL73+ye; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761161836;
	bh=0TYebRvbuZCp2Egy8udf+FKsqp2mhDPfM30PftmeBPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaL73+yewkM1u0JVqVbdzqOZ0k5bEAE8enr/czIZCAu4E1DFnYsODfPZM67ZPIHlJ
	 5t2BkJbFQCNTkUqpV8+jvBxvQ2mHY1LoYUEbtl1A0tuuPw72l18ZdOJ4/mse4SmJWJ
	 PvuyJNa6DS/G9FvZH1AbuPREyiQH9scSQkuJNkTLeo6r6eSaq/eIoSmYXGkfnskR2M
	 xzFdqOsrbXWwL6PgfZzTgA0eSt6oSyhBLXJVm47WVJ6YP1m7zbFNyYt3pqFN/nEirO
	 MekL1023ispxU3c3KD0kD4mc/X3kPNjCzYskasLETjuTUTwno46U4AaZlSVrZdBZE/
	 ThuNP2NL1X47g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 66F0B6000C;
	Wed, 22 Oct 2025 19:37:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 41751201540;
	Wed, 22 Oct 2025 19:37:11 +0000 (UTC)
Message-ID: <e9cd34d4-2970-462a-9c80-bf6d55ccb6ff@fiberby.net>
Date: Wed, 22 Oct 2025 19:37:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
To: Zahari Doychev <zahari.doychev@linux.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 johannes@sipsolutions.net
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
 <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 5:50 PM, Zahari Doychev wrote:
> On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
>> We need to be selective about what API stupidity we try to
>> cover up in YNL. Otherwise the specs will be unmanageably complex.
>> IMO this one should be a comment in the spec explaining that action
>> 0 is ignore and that's it.
>>
> 
> I am not sure if this applies for all cases of indexed arrays. For sure
> it applies for the tc_act_attrs case but I need to check the rest again.
> 
> Do you think it would be fine to start from 1 for all indexed arrays?
Yes, AFAICT it would. Most of indexed-array attributes that are parsed by
the kernel uses nla_for_each_nested(), and don't use the index. The TC
actions are the only ones I found, that are parsed into a nlattr array.

Disclaimer: I have only mapped out the indexed-arrays that are declared in
the current specs.

See patch 4-7 in this series for the full analysis:
https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/

