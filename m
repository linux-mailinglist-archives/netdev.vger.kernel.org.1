Return-Path: <netdev+bounces-220587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FAB471C2
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE26A00E7E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D71F7580;
	Sat,  6 Sep 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="AqObxnK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF918A6DB;
	Sat,  6 Sep 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171449; cv=none; b=PA570ybfZw4cKgQ54GZAWlijoFtbTo5rO1pMOjDoMP5aaHf69SN0uoJJqIf0skiDwIVpTQDPdNxzIVV6ILgIwZIJnhyDBoJNOWVQj01xMrhK/Be6zTokIUx6aMmhi/t2cuaeh9JTNxMH3StLmvOyjSQrx2zXttTKilAMPisKhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171449; c=relaxed/simple;
	bh=+MwpuQIW0KvoU8CYMKv5UJ2RjYizB5o5PqazrYPwT5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfcUUWBD8v/lIluEsAcLfyMGxTRCLrdiaMaGijkz4izdvBr7UCz+PDAREEHJVugKE31ybccLZmWtIJpBHNYLsi1rjM03pLuHHIMuzC2Zsa4kCOmpLUx+YjM9aKSJWtQeCW06+z3tDAnucFGzlB/d4pyPyCuzYcNkdQuP6FSa65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=AqObxnK3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757171443;
	bh=+MwpuQIW0KvoU8CYMKv5UJ2RjYizB5o5PqazrYPwT5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AqObxnK3DibmzTLln6hc42RgV08RTKzumMRVCjJiLv8K3jMDkiWSIdSlZJA2GBOtr
	 c94aJ0RLOzpLfos6g/FukYf3L5Mf148KQAuEd8/0mvX1VpGEHGYvB2EtVOirSSJcFy
	 3xQdJmRKFhOdWR0E7MhP9L1O+aVoPrLwk9EB4Q2zMwBvAta8U4LjL79yMBrlXD2OMW
	 x1ocFKgeHWQEW7SXUNvMdetF9vSjsD0jFeXf5crMihOF3XaIObni+NXsP40uIcv6nA
	 QXe30oP+JiJ8M17nKut/ZpFMowbZsLK6WlXneHWjcfpPBDPXcCmjQ6Djs+TzAo+kFR
	 emZq+0Y5w7FHQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 315796000C;
	Sat,  6 Sep 2025 15:10:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 85BBF201924;
	Sat, 06 Sep 2025 15:10:37 +0000 (UTC)
Message-ID: <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
Date: Sat, 6 Sep 2025 15:10:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
To: Jacob Keller <jacob.e.keller@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
 <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC: Johannes

On 9/6/25 12:24 AM, Jacob Keller wrote:
> On 9/4/2025 3:01 PM, Asbjørn Sloth Tønnesen wrote:
>> In nested arrays don't require that the intermediate
>> attribute type should be a valid attribute type, it
>> might just be an index or simple 0, it is often not
>> even used.
>>
>> See include/net/netlink.h about NLA_NESTED_ARRAY:
>>> The difference to NLA_NESTED is the structure:
>>> NLA_NESTED has the nested attributes directly inside
>>> while an array has the nested attributes at another
>>> level down and the attribute types directly in the
>>> nesting don't matter.
>>
> 
> To me, it would seem like it makes more sense to define these (even if
> thats defined per family?) than to just say they aren't defined at all?
> 
> Hm.

I considered adding some of that metadata too, as I am actually removing
it for wireguard (in comment form, but still).

In include/uapi/linux/wireguard.h in the comment block at the top, it is
very clear that wireguard only used type 0 for all the nested array
entries, however the truth is that it doesn't care. It therefore doesn't
matter if the generated -user.* keeps track of the index in .idx, or that
cli.py decodes a JSON array and sends it with indexes, it's not needed,
but it still works.

In practice I don't think we will break any clients if we enforced it, and
validated that wireguard only accepts type 0 entries, in it's nested arrays.

For the other families, I don't know how well defined it is, Johannes have
stated that nl80211 doesn't care which types are used, but I have no idea
how consistent clients have abused that statement to send random data,
or do they all just send zeros?

This would make a lot more sense if 'array-nest' hadn't been renamed to
'indexed-array' in ynl, because it feels wrong to add 'unindexed: true' now.
We could also call it 'all-zero-indexed: true'.

In cli.py this gives some extra issues, as seen in [1], the nested arrays
are outputted as '[{0: {..}}, {0: {..}}, ..]', but on input has the format
'[{..},{..}, ..]' because it has to be JSON-compatible on input.

If we had an attribute like 'all-zero-indexed' then cli.py, could also output
'[{..},{..}, ..]'.

[1] https://lore.kernel.org/netdev/20250904220255.1006675-3-ast@fiberby.net/

