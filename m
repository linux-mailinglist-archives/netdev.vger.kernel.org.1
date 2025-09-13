Return-Path: <netdev+bounces-222812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40323B563B5
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B6317FF1C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EE2C0F6F;
	Sat, 13 Sep 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="au2HTKcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C52C08D0;
	Sat, 13 Sep 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805300; cv=none; b=CADWCeWsQ0txaENBNzBshr2Wbx39pd++uF1PPru9ujz3N8mDw1U7c/9nna5cYZQoh2t9RWy42ymr0oSqKwXPkTEMKvSGE5e4+zV+ylKg6Om6t29ARygIS4lEeGOjZbzJXxzsDP0eLJ20QfzqEkbiV/FnO8AOjOC+hPo6pqAdjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805300; c=relaxed/simple;
	bh=nPyCEBL3SzibQsaSizD1nfxfHhjF0nqEeAFl/+cQcjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqFRpCacNFC05iMAmRkBO+xOiXZzLsder/7T8o8m1o8aMxuVQfOjCLOjGIhwN8TCNZ6bJeRFiFrOPjabBBV/MigSjEYcYmzASDGI4jiVIaUh9ZHlGEYXafHjBG/AoKivAx2Oop7mqo1FRan1cYumK9rIQOQ6b/4qdnL2FPyOcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=au2HTKcY; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757805289;
	bh=nPyCEBL3SzibQsaSizD1nfxfHhjF0nqEeAFl/+cQcjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=au2HTKcYXdNYLFsy5GGwZmaoF+fmwPTRaQX16l4IOR1haJWiDEvGJf+qGTLlwCOx0
	 zBL5QDU6Lyj0x9dGUA+LZtyBDY68SShbbulfNnbSmDsdlLJ/K4NWUUMUAgAmgXg9F2
	 /6JgSL3+TkiGzxiCtTzVKRUvnJOPZtHFo7tTOq6RV4PriXWlUFZG6/BKcKxFas/ifC
	 y8a86qfhGOU14+IKHmIbVFdFQvUZ6+LHoekvpxzbySyqqPXzO9wnFlSjfzAldNe71Z
	 JahPrs7Yj+Vs5QVhvRRs8rZ9cMhX9FkJVSmW/Nxced2OgV7Kob9l9yLWyG561q4x+g
	 wvDMiLGcG4Bew==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C8FBA60078;
	Sat, 13 Sep 2025 23:14:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 39B30202B83;
	Sat, 13 Sep 2025 23:14:36 +0000 (UTC)
Message-ID: <254c0f1c-da49-4ba4-a36b-a79753316662@fiberby.net>
Date: Sat, 13 Sep 2025 23:14:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/13] tools: ynl-gen: refactor local vars for
 .attr_put() callers
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911200508.79341-1-ast@fiberby.net>
 <20250911200508.79341-5-ast@fiberby.net> <20250912171954.7c020c60@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250912171954.7c020c60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/25 12:19 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 20:04:57 +0000 Asbjørn Sloth Tønnesen wrote:
>> +    def attr_put_local_vars(self):
>> +        local_vars = []
>> +        if self.presence_type() == 'count':
>> +            local_vars.append('unsigned int i;')
>> +        return local_vars
>> +
>>       def attr_put(self, ri, var):
>>           raise Exception(f"Put not implemented for class type {self.type}")
>>   
>> @@ -840,6 +846,10 @@ class TypeArrayNest(Type):
>>                        '}']
>>           return get_lines, None, local_vars
>>   
>> +    def attr_put_local_vars(self):
>> +        local_vars = ['struct nlattr *array;']
>> +        return local_vars + super().attr_put_local_vars()
> 
> Doesn't feel right. The Type method is a helper which is compatible
> with the specific types by checking presence, then you override it,
> and on top of that combine the output with super(). I don't like.

I prefer to keep the array variable as a detail isolated to TypeArrayNest,
so I have given it another spin in v4.

