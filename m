Return-Path: <netdev+bounces-118008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A969503F4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3D51C21AB4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B51991AA;
	Tue, 13 Aug 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="jtJIaSbF"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E581990D7;
	Tue, 13 Aug 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549412; cv=none; b=SW7FVuf4fTlTPf/8T7v51XRgJXyJfOYa6P7f3a2ZSHbXdwUUU3kB5M9SnZFtZvO5H/0nww7xQsGLLlH/wzqFo14/yYSYB9hq1gsCM54nvfj6sqHixSWMkjRWwU8zbtGL/T9mOb7l+idtJY5UZAlMpNgD+Vy6wxGrwjRn4n4dOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549412; c=relaxed/simple;
	bh=aiqfBHVXvbXqfg9CjaTV+ybmGn8aMCPGWUpQz1eKvwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/kfAPfNlCeCGZHJ0WBN0AM9rko8TJy2DELtFHGfPRrEtl0+sO6gqWuuOQi3UP5mgMGJ+jqYgCq3VaDxHDAAt4q0c7K8vaTP3Z3hFg2lemFnbbg4DTzSvgRJQNID/oBd2BWXEautV7/hMYdoqiEdOA0WPST0jsO9ampzkbns0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=jtJIaSbF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id A8DB4200BFF4;
	Tue, 13 Aug 2024 13:43:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be A8DB4200BFF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723549408;
	bh=3Zwrp9LeAOWPDiDZahZGuaEjNDNgO3Sw9YGT0O4y4+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jtJIaSbFxDYOe57ca/hbB+pNOwFuv5CuW1yNzRFvO7vQk8vSQ8S6d8Hx9vJ3zwBL/
	 vmReB+TWDQ53X6gf+niGOJtGGCxWnpCDEitPFh1aC4Tx7flgO43gkqxexk1oo2WrFP
	 tJ7xRW8jbyTmFFUYsb1LlhFUGqNK5ygOYJBTbO49am3kfXprif9ZA4EXPyL+1XKXI3
	 nJnV2evmyeZCY8L1oNIPl0DbG+VS/ESDFHrWN7CbjB1SAdeYqEiuoORS36uKCJAi0P
	 GiDR1q7wldO5byZcQvfa/WJIPZAlb7lE6e1FgbFqemK2CosN8Nh0asTslVvaup8eE7
	 uS9bUx13yQkUQ==
Message-ID: <5bbba416-9c98-47f3-88b5-66747998bba5@uliege.be>
Date: Tue, 13 Aug 2024 13:43:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ipv6: ioam6: new feature tunsrc
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, justin.iurman@uliege.be
References: <20240809123915.27812-1-justin.iurman@uliege.be>
 <20240809123915.27812-3-justin.iurman@uliege.be>
 <8fe01ef6-2c85-4843-b686-8cb43cc1f454@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <8fe01ef6-2c85-4843-b686-8cb43cc1f454@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 13:06, Paolo Abeni wrote:
> On 8/9/24 14:39, Justin Iurman wrote:
>> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
>> "encap") mode of ioam6. Just like seg6 already does, except it is
>> attached to a route. The "tunsrc" is optional: when not provided (by
>> default), the automatic resolution is applied. Using "tunsrc" when
>> possible has a benefit: performance.
> 
> It's customary to include performances figures in performance related 
> changeset ;)
> 
>>
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>> ---
>>   include/uapi/linux/ioam6_iptunnel.h |  7 +++++
>>   net/ipv6/ioam6_iptunnel.c           | 48 ++++++++++++++++++++++++++---
>>   2 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/uapi/linux/ioam6_iptunnel.h 
>> b/include/uapi/linux/ioam6_iptunnel.h
>> index 38f6a8fdfd34..6cdbd0da7ad8 100644
>> --- a/include/uapi/linux/ioam6_iptunnel.h
>> +++ b/include/uapi/linux/ioam6_iptunnel.h
>> @@ -50,6 +50,13 @@ enum {
>>       IOAM6_IPTUNNEL_FREQ_K,        /* u32 */
>>       IOAM6_IPTUNNEL_FREQ_N,        /* u32 */
>> +    /* Tunnel src address.
>> +     * For encap,auto modes.
>> +     * Optional (automatic if
>> +     * not provided).
>> +     */
>> +    IOAM6_IPTUNNEL_SRC,        /* struct in6_addr */
>> +
>>       __IOAM6_IPTUNNEL_MAX,
>>   };
>> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
>> index cd2522f04edf..e0e73faf9969 100644
>> --- a/net/ipv6/ioam6_iptunnel.c
>> +++ b/net/ipv6/ioam6_iptunnel.c
>> @@ -42,6 +42,8 @@ struct ioam6_lwt {
>>       struct ioam6_lwt_freq freq;
>>       atomic_t pkt_cnt;
>>       u8 mode;
>> +    bool has_tunsrc;
>> +    struct in6_addr tunsrc;
>>       struct in6_addr tundst;
>>       struct ioam6_lwt_encap tuninfo;
>>   };
>> @@ -72,6 +74,7 @@ static const struct nla_policy 
>> ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
>>       [IOAM6_IPTUNNEL_MODE]    = NLA_POLICY_RANGE(NLA_U8,
>>                              IOAM6_IPTUNNEL_MODE_MIN,
>>                              IOAM6_IPTUNNEL_MODE_MAX),
>> +    [IOAM6_IPTUNNEL_SRC]    = NLA_POLICY_EXACT_LEN(sizeof(struct 
>> in6_addr)),
>>       [IOAM6_IPTUNNEL_DST]    = NLA_POLICY_EXACT_LEN(sizeof(struct 
>> in6_addr)),
>>       [IOAM6_IPTUNNEL_TRACE]    = NLA_POLICY_EXACT_LEN(
>>                       sizeof(struct ioam6_trace_hdr)),
>> @@ -144,6 +147,11 @@ static int ioam6_build_state(struct net *net, 
>> struct nlattr *nla,
>>       else
>>           mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
>> +    if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
>> +        NL_SET_ERR_MSG(extack, "no tunnel source expected in this 
>> mode");
>> +        return -EINVAL;
>> +    }
> 
> when mode is IOAM6_IPTUNNEL_MODE_AUTO, the data path could still add the 
> encapsulation for forwarded packets, why explicitly preventing this 
> optimization in such scenario?

Actually, this check is correct. We don't want the "tunsrc" with 
"inline" mode since it's useless. If the "auto" mode is chosen, then 
it's fine (same for the "encap" mode). Preventing "tunsrc" for the 
"inline" mode does *not* impact the auto mode. Basically:

tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE -> error
tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_ENCAP -> OK
tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_AUTO -> OK

It aligns better with the semantics of "tundst", which is a MUST for 
"encap"/"auto" modes (and forbidden for the "inline" mode). In the case 
of "tunsrc", it is a MAY for "encap"/"auto" modes (and forbidden for the 
"inline" mode).

>> +
>>       if (!tb[IOAM6_IPTUNNEL_DST] && mode != 
>> IOAM6_IPTUNNEL_MODE_INLINE) {
>>           NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
>>           return -EINVAL;
>> @@ -178,6 +186,14 @@ static int ioam6_build_state(struct net *net, 
>> struct nlattr *nla,
>>       ilwt->freq.n = freq_n;
>>       ilwt->mode = mode;
>> +
>> +    if (!tb[IOAM6_IPTUNNEL_SRC]) {
>> +        ilwt->has_tunsrc = false;
>> +    } else {
>> +        ilwt->has_tunsrc = true;
>> +        ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
> 
> Since you are going to use the source address only if != ANY, I think it 
> would be cleaner to refuse such addresses here. That will avoid an 
> additional check in the datapath.
> 
> Cheers,
> 
> Paolo
> 

