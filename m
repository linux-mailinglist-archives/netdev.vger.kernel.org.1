Return-Path: <netdev+bounces-240810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B915C7AE1D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A53E3A131A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAE28466C;
	Fri, 21 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIfJprRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2E2773C1
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743094; cv=none; b=GyjkbGNKXTF6EyWbqrnmbBXq8F1rqS9rqMomFrlXDisP5J+2A96NHmHcdjOlSSFhLpqkF+YQSKWwhbeM6k5zJud5qyzWWXwnRosOfzbfmgNZncREatmNIiTzPGmrnvf5MNnBg155/H1JdMtGJSfsMXXBiGwtPBvEP4GSPPPhik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743094; c=relaxed/simple;
	bh=M+wGC2FqvT2WeCRT/+dFkPsFqMfHWksKZ7kljulG0bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D88QiI6C5OAkPGw/JnxxRSEoewyDt7iKue1g9U1z5BLFdIkHgaIqD9XiJyvsCddLcLgpJlZEjTTaH9mSS2IgMlXnSJpGvXrKU3C+0zlpg3vStTMJO8LZtDNU3FYYDhCAyJLvK5bnLsUUlUUeichtDgeCsDH6w5JJOu6Utxonl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIfJprRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40050C4CEF1;
	Fri, 21 Nov 2025 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743094;
	bh=M+wGC2FqvT2WeCRT/+dFkPsFqMfHWksKZ7kljulG0bU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YIfJprRu9uhTYfl1T5JEzfrM3v2QWGaKeHuZQ2hWgDXolaZhOsIYQ0wulsxRa6X43
	 QUkuKhuwlGqYQ1mvHMAqOPe4ijvuC4iwsABTPHYWodAsGYmBu62BWtJ0wIFBuHY4Rd
	 HgwgMjz4YXQpzDxXgRpcbZ12uUhKCz9yln60U7LHO3AYh8bYgFhp5SnsC1/gS3UgM8
	 5GW0jRI2Tik2RWitcL9rhaesHhlo7N7ePp8Sp2Zw7JWoeH6fRCHcIhEeRnjElCqviz
	 O6FqnJdqkTudyS6tQ14gg7MSPa/U0hGz8gkEdkfASXJz4BjdGBmwmrf3eZFgRUWvjE
	 +nPZUeuJOm+zA==
Message-ID: <6d950048-4647-4e10-a4db-7c53d0cfabd9@kernel.org>
Date: Fri, 21 Nov 2025 09:38:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
Content-Language: en-US
To: Justin Iurman <justin.iurman@uliege.be>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20251120163342.30312-1-justin.iurman@uliege.be>
 <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/25 2:23 AM, Justin Iurman wrote:
> On 11/20/25 17:33, Justin Iurman wrote:
>> With IPv6, the maximum size of the IOAM Pre-allocated Trace is 244 bytes
>> (see IOAM6_TRACE_DATA_SIZE_MAX), due to IPv6 Options length constraint.
>> However, RFC9197 defines the Opaque State Snapshot (i.e., a data field
>> that may be added by IOAM nodes in the pre-allocated trace) as follows:
>>
>>      0                   1                   2                   3
>>      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>     |   Length      |                     Schema ID                 |
>>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>     |                                                               |
>>     ~                        Opaque data                            ~
>>     |                                                               |
>>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>
>>     Length:
>>        1-octet unsigned integer.  It is the length in multiples of 4
>>        octets of the Opaque data field that follows Schema ID.
>>
>>     Schema ID:
>>        3-octet unsigned integer identifying the schema of Opaque data.
>>
>>     Opaque data:
>>        Variable-length field.  This field is interpreted as specified by
>>        the schema identified by the Schema ID.
>>
>> Based on that, IOAM6_MAX_SCHEMA_DATA_LEN was initially set to 1020 bytes
>> (i.e., 255 * 4), which is already bigger than what is allowed in a
>> pre-allocated trace. As a result, if the Opaque State Snapshot (i.e.,
>> schema) configured on an IOAM node exceeds 244 bytes, it would just
>> skip the insertion of its data. This patch sets a more realistic
>> boundary to avoid any confusion. Now, IOAM6_MAX_SCHEMA_DATA_LEN is set
>> to 240 bytes (i.e., IOAM6_TRACE_DATA_SIZE_MAX - 4, to account for its
>> 4-byte header).
>>
>> Fixes: 8c6f6fa67726 ("ipv6: ioam: IOAM Generic Netlink API")
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>> ---
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   include/uapi/linux/ioam6_genl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/ioam6_genl.h
>> b/include/uapi/linux/ioam6_genl.h
>> index 1733fbc51fb5..ce3d8bdabd3b 100644
>> --- a/include/uapi/linux/ioam6_genl.h
>> +++ b/include/uapi/linux/ioam6_genl.h
>> @@ -19,7 +19,7 @@ enum {
>>       IOAM6_ATTR_NS_DATA,    /* u32 */
>>       IOAM6_ATTR_NS_DATA_WIDE,/* u64 */
>>   -#define IOAM6_MAX_SCHEMA_DATA_LEN (255 * 4)
>> +#define IOAM6_MAX_SCHEMA_DATA_LEN 240
>>       IOAM6_ATTR_SC_ID,    /* u32 */
>>       IOAM6_ATTR_SC_DATA,    /* Binary */
>>       IOAM6_ATTR_SC_NONE,    /* Flag */
> 
> So, just to clarify, I know such changes in the uapi are generally
> prohibited. However, in this specific context, I don't believe it breaks
> backward compatibility (IMO). But I may be wrong...
> 
> Adding David to get his opinion from iproute2's point of view.
> 
> If we don't want to go that way, the alternative solution is to submit a
> patch to net-next that adds a new constant IOAM6_MAX_SCHEMA_DATA_LEN_NEW
> (=240) and a comment "/* Deprecated */" next to
> IOAM6_MAX_SCHEMA_DATA_LEN. Then, submit a patch to iproute2-next to use
> IOAM6_MAX_SCHEMA_DATA_LEN_NEW instead of IOAM6_MAX_SCHEMA_DATA_LEN.

It's been 4+ years since 8c6f6fa67726 went in; I think that is way too
long to try to make a change to the uapi like this.

