Return-Path: <netdev+bounces-159237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784DA14E15
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C91889C4C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B951FAC55;
	Fri, 17 Jan 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy7LpmlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE21F8905;
	Fri, 17 Jan 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111653; cv=none; b=Cog4oa2oVVVMUZAvUjH0n26mO4897jMhM/dpc7iGgl5W519d1p+lDGqphjiyEJMYcv+ELMtAopo9etjz/E41rG35JiV4Lz7+eQXKMABdFM05Scgw6QryAYiFFXP4FYBlSlKj7Vs12HbyQlmL/T7vLtbK+ccIs0I8lZuwpSRD4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111653; c=relaxed/simple;
	bh=0gwNO16h70l6NqWKLpd0tr5AR9HgvRqD4Li+9VRdGD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwgtIH/H2wqXs2k3B3WuniLVJZjwfv4i9FKUPPHOfVXE8uxJjhsunN3yNk+Wj0Cdu9Ea+HDgQogTi65EBKZfBd7pGbBuAnJa8F7Qf5Xx1HXSODKzlyZM23WX3TTkTtiD5oEXfv2Xd9E2I/ui6wkVkbJl7xHmK8rSHOG6ajsqXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy7LpmlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA3FC4CEDD;
	Fri, 17 Jan 2025 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737111653;
	bh=0gwNO16h70l6NqWKLpd0tr5AR9HgvRqD4Li+9VRdGD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dy7LpmlFlptRpzqVNtxcTjlv1kdo9e5N7M5yrzlGrRtZ5loOSdVBucm14zTi0C/Zd
	 v8IPqt55eCmXeX9uOSBLOWb5d1ZUJcLBFX069k6OpqvN4rj0V82AJ5xOKSkaW26Hbi
	 ZYaycj34h+B93GuG5mO4h5TK5lx+JrXQZoGRbNR0WAYkJdU9vzLoTfMw8KqC6qVsPk
	 4F6VwywnGYHjcjTZ1ucK6ZeddOUUN6IGbmHuCq5Z0ukbRqqVYgrvA4uHWycEhbQMar
	 Z+v5pYpBzgBBLMt0002bLgHqwYjosH5GxBnoQtsMttMTXmXmPenEGW2vlHEmjVskkV
	 o17jyIw0k8EqA==
Message-ID: <4453abfb-93ac-470e-b67e-71a918e7825c@kernel.org>
Date: Fri, 17 Jan 2025 12:00:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 11/15] mptcp: pm: add id parameter for get_addr
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
 <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-11-c0b43f18fe06@kernel.org>
 <20250117104336.GJ6206@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250117104336.GJ6206@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 17/01/2025 11:43, Simon Horman wrote:
> On Thu, Jan 16, 2025 at 05:51:33PM +0100, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> The address id is parsed both in mptcp_pm_nl_get_addr() and
>> mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
>>
>> So this patch adds a new parameter 'id' for all get_addr() interfaces.
>> The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
>> it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> ...
> 
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 853b1ea8680ae753fcb882d8b8f4486519798503..392f91dd21b4ce07efb5f44c701f2261afcdc37e 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
>>  	return -EMSGSIZE;
>>  }
>>  
>> -int mptcp_pm_nl_get_addr(struct genl_info *info)
>> +int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
>>  {
>>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>> -	struct mptcp_pm_addr_entry addr, *entry;
>> +	struct mptcp_pm_addr_entry *entry;
>>  	struct sk_buff *msg;
>>  	struct nlattr *attr;
>>  	void *reply;
>>  	int ret;
>>  
>> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
>> -		return -EINVAL;
>> -
>> -	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
>> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
>> -	if (ret < 0)
>> -		return ret;
>> -
> 
> Hi Matthieu and Geliang,
> 
> This hunk removes the initialisation of attr...
> 
>>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>  	if (!msg)
>>  		return -ENOMEM;
>> @@ -1803,7 +1795,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
>>  	}
>>  
>>  	rcu_read_lock();
>> -	entry = __lookup_addr_by_id(pernet, addr.addr.id);
>> +	entry = __lookup_addr_by_id(pernet, id);
>>  	if (!entry) {
>>  		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
> 
> ... but attr is still used here.
> 
> Flagged by clang-19 W=1 builds and Smatch.

Thank you for having looked at that!

Indeed, I missed that when rebasing and fixing conflicts, my bad, sorry.

This part of the code is moved in the patch to pm.c, where 'attr' is
initialised properly. What's a shame is that, just before sending the
series, I thought about squashing this patch with the next one :)

Anyway, I will fix that in a v2.

I hope that's OK if I add an extra patch in the same series or in parallel.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


