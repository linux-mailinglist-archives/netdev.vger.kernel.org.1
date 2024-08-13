Return-Path: <netdev+bounces-117999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F448950379
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4464B21043
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9F198A0E;
	Tue, 13 Aug 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="YkyhxEQl"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462A2233A;
	Tue, 13 Aug 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548050; cv=none; b=Zx3of0tNNksVq8ea+ErTCliLmGcLekZ8C09w0acLC5D3QlV4XlVADymXeHR8yJfm4kw46bzIH2vFtBnsksMtK9qvlK8ofONhZX4TeFYMasYGdlW0U/2z9ZCvfWgyMK0079M11zN+Paj/7bsm/S2ltkncPWtUFwbkUGpuuNzwXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548050; c=relaxed/simple;
	bh=BDOUO7wNLkhcUzvZ+QlwVuTVmDENJBeqkpJhrpEl9pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROTdgUOqbcuCFhOI2/9nyVmJPfghZL6GLdMaoh1EqyfO0tkK8TodasSn+0NTZxDMxzeq0B+1aWHTvUsVImRbtXJ0SaJ3P/6ShuOAEbroMF8C3wqye0EX76OmkTfXwkSHzSvgZG2I9pJNuLkUqePF5doWr2J8ddDf7A2ciQJZuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=YkyhxEQl; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6F0C8200BFFA;
	Tue, 13 Aug 2024 13:20:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6F0C8200BFFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723548040;
	bh=0yi3yRsMN4uF4qAafjZ6D1dOt5fcHrar55FVwqmnnTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YkyhxEQlva2j1Hf8tCQhjpbc1MT3sxEZedHTfevcNtSj7eLd/by1URuUZSk2RFjzi
	 S2cGWhN21VCyreQNDIn/rpEq5kdieqVbv2XDJmvEfce/IyXCVWwr8xlZO9ObCd3dV6
	 vqyIDbTpE3awWgQyuj43XMU+WNhH9ZBqY9Fw/JDLMImPkE7h4ieReTvsS5U/G0B74O
	 zBHpD8VBvjRaIslQ/7RBJ960EgBU+7ZJ7F7HJNG08VWhSOToPFOGZc07Vw51G3uljv
	 bOdpSwixWaKrkXV5fejK+bYuALTK0FNQOEBzS1UawR1qmCLO6MbG6uPw0PpugJXcuL
	 uAmYnKqPUUumw==
Message-ID: <bf82e839-585d-47c6-822e-f994d9c92389@uliege.be>
Date: Tue, 13 Aug 2024 13:20:40 +0200
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

Indeed, I realized it too late... thx for the reminder!

Before (= "encap" mode): https://ibb.co/bNCzvf7
After (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq

I'll add these again to -v2.

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

Good catch! I guess we can just ignore "tunsrc" if provided with inline 
mode, instead of returning an error.

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

+1.

Thanks,
Justin

> Cheers,
> 
> Paolo
> 

