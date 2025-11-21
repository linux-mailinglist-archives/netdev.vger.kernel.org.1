Return-Path: <netdev+bounces-240711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9725C78273
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E83B434329E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0D345750;
	Fri, 21 Nov 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="1WLHZoBH"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8833F8AC
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717037; cv=none; b=VvG7iHz20d5fmmYaO4dBcMrMkW6HNswzukySrei4b4tbzxirhMRt33Iq/n8ALlz6QDkg4QuBDHveWvxezD4Kp9TKmCl26AQO17MUsyIBaSTKhF/Tm5p+rhjfQk6k4kERKAJYsyA9WmhrZH5l/ebQs88pvDI+ugE/vMt/chKbOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717037; c=relaxed/simple;
	bh=6UpQkWq3FZH6mHuMj3k9PWGIGDhwCBM4NsDTST8GOSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiBYS1P/n299M2It6pO18EPTedbwV+5W5p6AZBUYVJvIZaE00oMe4t5PBgjPYKWiXWgsvDRioazurnAt7bDNfa4AhnuVzyOhsQTn6yl5UNw3v/XwHycAW3KzzQMZ8g+/JleQzKDZ2mDOqoeevAtPJkrXfX8JT4TKUnONfKx0fnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=1WLHZoBH; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C56A1200EEA1;
	Fri, 21 Nov 2025 10:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C56A1200EEA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763717031;
	bh=fE1QvyLVJH/2c3mjXWY+h85BM1V9KAjJVdqjVAYLTCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1WLHZoBHskNdGuEv71vMysC9hoUudRT2H2hrebAxMTfmxb17FvDoquR04c1ajl7hC
	 Z62TeCQVweWRtza6eKLGQcrrR2kiaOWz98vmcqWO4Yx1Cwh7rx6uCvaqXmnZKWgB+O
	 XcgsHe8ZIjAYntNcRMevExZpInG6TrNSEeB0eDCZ0GkvfZbilj9Ma31DMmoyLcLIxc
	 2m3lm8V6m1FeLSAjemaaf4wxd8bBj7RXhFGf9pK8AXVb0c7avQ7wWixqRKgDDioPam
	 jelmCvDXr8K57q0SUk4wHzdbHJsZeb1sG/6EwgQi5bJE34tYBs5fkikrucbgR+9Z39
	 3U6BCViWYwVjw==
Message-ID: <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
Date: Fri, 21 Nov 2025 10:23:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
References: <20251120163342.30312-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20251120163342.30312-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 17:33, Justin Iurman wrote:
> With IPv6, the maximum size of the IOAM Pre-allocated Trace is 244 bytes
> (see IOAM6_TRACE_DATA_SIZE_MAX), due to IPv6 Options length constraint.
> However, RFC9197 defines the Opaque State Snapshot (i.e., a data field
> that may be added by IOAM nodes in the pre-allocated trace) as follows:
> 
>      0                   1                   2                   3
>      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>     |   Length      |                     Schema ID                 |
>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>     |                                                               |
>     ~                        Opaque data                            ~
>     |                                                               |
>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
>     Length:
>        1-octet unsigned integer.  It is the length in multiples of 4
>        octets of the Opaque data field that follows Schema ID.
> 
>     Schema ID:
>        3-octet unsigned integer identifying the schema of Opaque data.
> 
>     Opaque data:
>        Variable-length field.  This field is interpreted as specified by
>        the schema identified by the Schema ID.
> 
> Based on that, IOAM6_MAX_SCHEMA_DATA_LEN was initially set to 1020 bytes
> (i.e., 255 * 4), which is already bigger than what is allowed in a
> pre-allocated trace. As a result, if the Opaque State Snapshot (i.e.,
> schema) configured on an IOAM node exceeds 244 bytes, it would just
> skip the insertion of its data. This patch sets a more realistic
> boundary to avoid any confusion. Now, IOAM6_MAX_SCHEMA_DATA_LEN is set
> to 240 bytes (i.e., IOAM6_TRACE_DATA_SIZE_MAX - 4, to account for its
> 4-byte header).
> 
> Fixes: 8c6f6fa67726 ("ipv6: ioam: IOAM Generic Netlink API")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>   include/uapi/linux/ioam6_genl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ioam6_genl.h b/include/uapi/linux/ioam6_genl.h
> index 1733fbc51fb5..ce3d8bdabd3b 100644
> --- a/include/uapi/linux/ioam6_genl.h
> +++ b/include/uapi/linux/ioam6_genl.h
> @@ -19,7 +19,7 @@ enum {
>   	IOAM6_ATTR_NS_DATA,	/* u32 */
>   	IOAM6_ATTR_NS_DATA_WIDE,/* u64 */
>   
> -#define IOAM6_MAX_SCHEMA_DATA_LEN (255 * 4)
> +#define IOAM6_MAX_SCHEMA_DATA_LEN 240
>   	IOAM6_ATTR_SC_ID,	/* u32 */
>   	IOAM6_ATTR_SC_DATA,	/* Binary */
>   	IOAM6_ATTR_SC_NONE,	/* Flag */

So, just to clarify, I know such changes in the uapi are generally 
prohibited. However, in this specific context, I don't believe it breaks 
backward compatibility (IMO). But I may be wrong...

Adding David to get his opinion from iproute2's point of view.

If we don't want to go that way, the alternative solution is to submit a 
patch to net-next that adds a new constant IOAM6_MAX_SCHEMA_DATA_LEN_NEW 
(=240) and a comment "/* Deprecated */" next to 
IOAM6_MAX_SCHEMA_DATA_LEN. Then, submit a patch to iproute2-next to use 
IOAM6_MAX_SCHEMA_DATA_LEN_NEW instead of IOAM6_MAX_SCHEMA_DATA_LEN.

