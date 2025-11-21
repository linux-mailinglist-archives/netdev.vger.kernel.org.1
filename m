Return-Path: <netdev+bounces-240854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B837BC7B644
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0F36260E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06162D3750;
	Fri, 21 Nov 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="J8mgKllv"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4A2E645
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751338; cv=none; b=rLQI+kuXrhKUA+jKh/B8EOyFfIlN2z+7TyrEMIlUTb6HrlAJMjviIboUNv0mMR+d8hDgUH6VyuD1zrmP7M5o2wZsM9KVjKPhqxLsO8+5Ih7xp/YDnSu1ACPks1OCaOKJ443GgYAYwax4dJWuIkVQZcpQVHf/Aj6QrNHASlMjBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751338; c=relaxed/simple;
	bh=ovgwmdqfTPUoTzvVl9/38UiNmh6Z/f5DNUbY1zMOGt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bavOEzFSmxywpMvhJIjMgW5kX13omNhSS1PKFEML7b7DrJa4DMUco321+k4fA7f963LF/t8El4GLoZGtW7FImV9cyKraJAeIrg9HBrHJposTKZifnS2DDp8HVPcsftI3aOlRxBBmlfQM0D++WK6iaUNodnrNoPe0vIpox+FmfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=J8mgKllv; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 2A976200C964;
	Fri, 21 Nov 2025 19:55:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 2A976200C964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763751328;
	bh=eFYg0cfORNIxmPlErpv5F1DDpwpTeg4+sA8r1MpvSmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J8mgKllvGGiF02aYtywZhq+fuz+lPtmggR2XuR9H+3IdPyD5qXdVkcjEygPav/c0B
	 1ZVkP1t/njvFERudhzvony7Y8Frw/964rNcZz4V+IzEF3Zl5xGc+QgstWqmkX92uR2
	 SWrD+IwkUoYuT9EGAZQr/CFJKsVXX8/7S8jsAZ6kL0jojJjA6cOL7Dm9imCOnC7U4q
	 APV3K+KHuTZ0UlZ3ypdyAs/OFGlod9gs+pLSSi5G/zkzk4ECp5dWYsYCyKnn6ms1S1
	 OcJf9uo0MaRLlOw1N+UIY6C86tCjXalcNbBZWqV6nsfeNAryC0EO3nxQ1UunJ9bZfN
	 7MUGPp5nuIang==
Message-ID: <55c4c96e-c11f-49d7-8207-4f5179d380a7@uliege.be>
Date: Fri, 21 Nov 2025 19:55:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20251120163342.30312-1-justin.iurman@uliege.be>
 <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
 <6d950048-4647-4e10-a4db-7c53d0cfabd9@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <6d950048-4647-4e10-a4db-7c53d0cfabd9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/25 17:38, David Ahern wrote:
> On 11/21/25 2:23 AM, Justin Iurman wrote:
>> On 11/20/25 17:33, Justin Iurman wrote:
>>> With IPv6, the maximum size of the IOAM Pre-allocated Trace is 244 bytes
>>> (see IOAM6_TRACE_DATA_SIZE_MAX), due to IPv6 Options length constraint.
>>> However, RFC9197 defines the Opaque State Snapshot (i.e., a data field
>>> that may be added by IOAM nodes in the pre-allocated trace) as follows:
>>>
>>>       0                   1                   2                   3
>>>       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>      |   Length      |                     Schema ID                 |
>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>      |                                                               |
>>>      ~                        Opaque data                            ~
>>>      |                                                               |
>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>
>>>      Length:
>>>         1-octet unsigned integer.  It is the length in multiples of 4
>>>         octets of the Opaque data field that follows Schema ID.
>>>
>>>      Schema ID:
>>>         3-octet unsigned integer identifying the schema of Opaque data.
>>>
>>>      Opaque data:
>>>         Variable-length field.  This field is interpreted as specified by
>>>         the schema identified by the Schema ID.
>>>
>>> Based on that, IOAM6_MAX_SCHEMA_DATA_LEN was initially set to 1020 bytes
>>> (i.e., 255 * 4), which is already bigger than what is allowed in a
>>> pre-allocated trace. As a result, if the Opaque State Snapshot (i.e.,
>>> schema) configured on an IOAM node exceeds 244 bytes, it would just
>>> skip the insertion of its data. This patch sets a more realistic
>>> boundary to avoid any confusion. Now, IOAM6_MAX_SCHEMA_DATA_LEN is set
>>> to 240 bytes (i.e., IOAM6_TRACE_DATA_SIZE_MAX - 4, to account for its
>>> 4-byte header).
>>>
>>> Fixes: 8c6f6fa67726 ("ipv6: ioam: IOAM Generic Netlink API")
>>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>>> ---
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>    include/uapi/linux/ioam6_genl.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/ioam6_genl.h
>>> b/include/uapi/linux/ioam6_genl.h
>>> index 1733fbc51fb5..ce3d8bdabd3b 100644
>>> --- a/include/uapi/linux/ioam6_genl.h
>>> +++ b/include/uapi/linux/ioam6_genl.h
>>> @@ -19,7 +19,7 @@ enum {
>>>        IOAM6_ATTR_NS_DATA,    /* u32 */
>>>        IOAM6_ATTR_NS_DATA_WIDE,/* u64 */
>>>    -#define IOAM6_MAX_SCHEMA_DATA_LEN (255 * 4)
>>> +#define IOAM6_MAX_SCHEMA_DATA_LEN 240
>>>        IOAM6_ATTR_SC_ID,    /* u32 */
>>>        IOAM6_ATTR_SC_DATA,    /* Binary */
>>>        IOAM6_ATTR_SC_NONE,    /* Flag */
>>
>> So, just to clarify, I know such changes in the uapi are generally
>> prohibited. However, in this specific context, I don't believe it breaks
>> backward compatibility (IMO). But I may be wrong...
>>
>> Adding David to get his opinion from iproute2's point of view.
>>
>> If we don't want to go that way, the alternative solution is to submit a
>> patch to net-next that adds a new constant IOAM6_MAX_SCHEMA_DATA_LEN_NEW
>> (=240) and a comment "/* Deprecated */" next to
>> IOAM6_MAX_SCHEMA_DATA_LEN. Then, submit a patch to iproute2-next to use
>> IOAM6_MAX_SCHEMA_DATA_LEN_NEW instead of IOAM6_MAX_SCHEMA_DATA_LEN.
> 
> It's been 4+ years since 8c6f6fa67726 went in; I think that is way too
> long to try to make a change to the uapi like this.

You're right, it might be too risky. Besides, the current code (i.e., 
IOAM6_MAX_SCHEMA_DATA_LEN=1020) doesn't break anything per se, it was 
mainly for convenience. Do you think it would be OK to introduce a new 
constant in the uapi, as suggested above? Or did your comment also apply 
to that part?

