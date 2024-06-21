Return-Path: <netdev+bounces-105742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB1912910
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF41DB2AF3C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCF7404F;
	Fri, 21 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Cmag7+Pj"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE646542;
	Fri, 21 Jun 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982558; cv=none; b=rNuqMm8gXMFObvrUOrb+zz/0U3yDd77rBOJhFhSS7caEBIT+uBMS/YQgNm5Yb73mBZ9KfGOR9eilVL8ny5IVgJPPN2zCMfNj/THxJkiIdhvPKxHRGLoq6Al2fmikBVOtdPZW0T3cbLOCtSPgpPprvhatRg6tGfczPrm815MwIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982558; c=relaxed/simple;
	bh=FPozGI57ptJ5PFbWNlvuuaCxlurnFDj4WUrEL75l1wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVp9Co95ICSPZHrxG9JMTXUkROPNKUVUYIsSiHQk6aEvClH65mbefEkcErr+k2WMUCtqL1xBulNDSBcEfXi1SAYLlT3Bn+fD2Wm6MY0tDKHIlHcG2wpVeAeTRLHhCg2jWLptF+oCsms2v3xisvcGJBIii4pkLxOJA1cW+KL+LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Cmag7+Pj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718982181;
	bh=FPozGI57ptJ5PFbWNlvuuaCxlurnFDj4WUrEL75l1wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cmag7+PjaAVGiyFO8bmW9BAa+PJFfWhZ6G07aYsGL89xSNjzF7QCwlV475QkhJHPZ
	 bALgn1xIh4pCT4NprzZGWUA2Qtf/d/GzZJhObFdhQStN2mi2uChE9KQxcRwZXghr8j
	 7u46rIs4mUhx4TKY6NdsiUBhSVgb+b9hhwYAoRFgzeWYFXMPX8TZJk+uk55vOmeva3
	 /IA16gGvsZLSWKgfp2I/ovXK0LuwLrUanFTVgc6p46yx4oaHWArKguBVUkqn3rjT5Q
	 4Q4bQjz7j728W7tutV/ejg6RFBDn91AVvl2foqyTXALgaLXQXQZ0F0A2QoIgzAiUEf
	 fbdWyeagaKmNQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 237306007C;
	Fri, 21 Jun 2024 15:03:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id B2F8A200FED;
	Fri, 21 Jun 2024 14:45:28 +0000 (UTC)
Message-ID: <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
Date: Fri, 21 Jun 2024 14:45:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
To: Davide Caratti <dcaratti@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 6/21/24 10:11 AM, Davide Caratti wrote:
> hello Asbjørn,
> 
> some update on this work: I tested your patch after adapting iproute2
> bits (e.g. using TCA_FLOWER_KEY_FLAGS_TUNNEL_<CSUM|DONT_FRAGMENT|OAM|CRIT>

Could you please post your iproute2 code?


> from
> 
> https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/
> 
> Now: functional tests on TCA_FLOWER_KEY_ENC_FLAGS systematically fail. I must
> admit that I didn't complete 100% of the analysis, but IMO there is at least an
> endianness problem here. See below:
> 
> On Tue, Jun 11, 2024 at 11:53:35PM +0000, Asbjørn Sloth Tønnesen wrote:
>> Prepare fl_set_key_flags/fl_dump_key_flags() for use with
>> TCA_FLOWER_KEY_ENC_FLAGS{,_MASK}.
>>
>> This patch adds an encap argument, similar to fl_set_key_ip/
>> fl_dump_key_ip(), and determine the flower keys based on the
>> encap argument, and use them in the rest of the two functions.
>>
>> Since these functions are so far, only called with encap set false,
>> then there is no functional change.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   net/sched/cls_flower.c | 40 ++++++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
>> index eef570c577ac7..6a5cecfd95619 100644
>> --- a/net/sched/cls_flower.c
>> +++ b/net/sched/cls_flower.c
>> @@ -1166,19 +1166,28 @@ static void fl_set_key_flag(u32 flower_key, u32 flower_mask,
>>   	}
>>   }
>>   
>> -static int fl_set_key_flags(struct nlattr **tb, u32 *flags_key,
>> +static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
>>   			    u32 *flags_mask, struct netlink_ext_ack *extack)
>>   {
>> +	int fl_key, fl_mask;
>>   	u32 key, mask;
>>   
>> +	if (encap) {
>> +		fl_key = TCA_FLOWER_KEY_ENC_FLAGS;
>> +		fl_mask = TCA_FLOWER_KEY_ENC_FLAGS_MASK;
>> +	} else {
>> +		fl_key = TCA_FLOWER_KEY_FLAGS;
>> +		fl_mask = TCA_FLOWER_KEY_FLAGS_MASK;
>> +	}
>> +
>>   	/* mask is mandatory for flags */
>> -	if (!tb[TCA_FLOWER_KEY_FLAGS_MASK]) {
>> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
>>   		NL_SET_ERR_MSG(extack, "Missing flags mask");
>>   		return -EINVAL;
>>   	}
>>   
>> -	key = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS]));
>> -	mask = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS_MASK]));
>> +	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
>> +	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));
> 
> 
> I think that (at least) the above hunk is wrong - or at least, it is a
> functional discontinuity that causes failure in my test. While the
> previous bitmask storing tunnel control flags was in host byte ordering,
> the information on IP fragmentation are stored in network byte ordering.
> 
> So, if we want to use this enum
> 
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -677,6 +677,11 @@ enum {
>   enum {
>   	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>   	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> +	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
>   };
>  
> consistently, we should keep using network byte ordering for
> TCA_FLOWER_KEY_FLAGS_TUNNEL_* flags (for a reason that I don't understand,
> because metadata are not transmitted on wire. But maybe I'm missing something).
> 
> Shall I convert iproute2 to flip those bits like it happens for
> TCA_FLOWER_KEY_FLAGS ? thanks!

It is always preferred to have a well-defined endianness for binary protocols, even
if it might only be used locally for now.

I would base it on flags_str in tc/f_flower.c, so it can reuse
flower_parse_matching_flags() and add a new "enc_flags" argument mirroring "ip_flags".
Then there shouldn't be a difference in endianness. The naming of "ip_flags" is
questionable, since it is only named in an IP-specific way in iproute2.

Most of the patches in this series are just extending and mirroring what is already
done for the existing flags, so I am pretty sure that part should work.

The part I am most unsure about is patch 5, since I don't have a lot of experience
with the bitmap infrastructure, I will make another reply to that patch.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

