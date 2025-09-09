Return-Path: <netdev+bounces-221389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0BB506E0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CC1BC2B31
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1202242D9D;
	Tue,  9 Sep 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KJVcGHey"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92F433A0;
	Tue,  9 Sep 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449150; cv=none; b=Gk91dQqp34879xpwUHTCyzkN5L0d4WmSDGHDZ5sbhapLXipRLFR9TVgApAHwWypg6MgfSto04tSAdflA0W1G/wLIClKW8893g+/XgagaiDyBz0DoMU0FRSnwIFfXzsX98bnD0xl98L5QtxLvKhbfzjSs+BpoHkt6yI1QHZZKrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449150; c=relaxed/simple;
	bh=3o1bfZbLCt8J7pWRJRYVzqtmslvWn0MLJ4VQR0em3ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruLwCvmoBwzUegfSm/LtnUIVQ7WW978lLvoQTu5DxrOEPR0MaIIkedrR2yO594fvfgwyaP6vw+oWgHoB8BXvH1+m7b1dzPDstzRHccPNTa1egVk8x/XD5490xT/M+FzQ82Hq1FsDOShINaQO9V6+YCeQVEgVPE2JAmjFfOssLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KJVcGHey; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757449139;
	bh=3o1bfZbLCt8J7pWRJRYVzqtmslvWn0MLJ4VQR0em3ZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJVcGHey7azgW4GL+oD23RM6BVTuehzyp/Pl0yR+78zDsWoty11htmgoFtGUjbQbu
	 8SUqVrfXnWuwsFUBlMgtSVf+yH+FiQvgb/XYCIte5IIfyrlimh7ZTPF2bCTuHKGEMs
	 w/s0bq1AFrztN54+uVzl6G7pj40EP+N7qPT2QTC9jSjKlBe6oloRhzB+diLaAaGAsJ
	 gy+tBaDejUaqN9X8tnKQOBx2WuPB7+YgA3KPQfD+HEhXKxAHiqdhjAjWgAryoB8vUN
	 +fCXXypNnlIgl6H1kXsP6pN7bbcT8hHHiqmH4GMMb0c42VsBJI9CH7ze+PmO0nc5sH
	 2LR4Tvz9P+qqg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6E2746000C;
	Tue,  9 Sep 2025 20:18:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 47950201867;
	Tue, 09 Sep 2025 20:18:54 +0000 (UTC)
Message-ID: <412f5811-bc54-45d4-92cd-7eea02a7ecc0@fiberby.net>
Date: Tue, 9 Sep 2025 20:18:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-10-ast@fiberby.net> <aMBteqR5KP9KGcc3@krikkit>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <aMBteqR5KP9KGcc3@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 6:10 PM, Sabrina Dubroca wrote:
> 2025-09-04, 22:01:33 +0000, Asbjørn Sloth Tønnesen wrote:
>> This patch add support for decoding hex input, so
>> that binary attributes can be read through --json.
>>
>> Example (using future wireguard.yaml):
>>   $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>>     --do set-device --json '{"ifindex":3,
>>       "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   tools/net/ynl/pyynl/lib/ynl.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
>> index a37294a751da..78c0245ca587 100644
>> --- a/tools/net/ynl/pyynl/lib/ynl.py
>> +++ b/tools/net/ynl/pyynl/lib/ynl.py
>> @@ -973,6 +973,8 @@ class YnlFamily(SpecFamily):
>>                   raw = ip.packed
>>               else:
>>                   raw = int(ip)
>> +        elif attr_spec.display_hint == 'hex':
>> +            raw = bytes.fromhex(string)
> 
> I'm working on a spec for macsec and ended up with a similar change,
> but doing instead:
> 
> +        elif attr_spec.display_hint == 'hex':
> +            raw = int(string, 16)
> 
> since the destination attribute is u32/u64 and not binary for macsec.
> 
> So maybe this should be:
> 
> +            if attr_spec['type'] == 'binary':
> +                raw = bytes.fromhex(string)
> +            else:
> +                raw = int(string, 16)
> 
> to cover both cases?
> 
> I think it matches better what's already in _formatted_string.
> 
> (I don't mind having the current patch go in and making this change
> together with the macsec spec when it's ready)

Cool, I will include it in v2, which I hope to get out tomorrow.

