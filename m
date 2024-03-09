Return-Path: <netdev+bounces-78979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC25877282
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B2A1F21A86
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA122EEF;
	Sat,  9 Mar 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar2ccDdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95370BA4D
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006628; cv=none; b=TlSbKnyoQzNvV+X1w1gHiWkajC7GzF3nwFzEvzavXoJ6rcP9wFZoJtLk/vG1Do+7vTwTHmmIn08e0myF20GIWYqg5MIhMyPXrE/u/XIPScsGVpFYsP4AIWrjTaSXxyNomBU7KOR8CelUVCBOZjOPvnRcG8DjSiuun52YjJsj+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006628; c=relaxed/simple;
	bh=H9SxWwtkuoEGXRmemD5AodkzSiaEFmYEKNrb6oO0x08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5W8vPwNn8oy42gBTjsONOVmoI8ba4m0F0ONlmd1sg9lrJIk2EJoEOzNVsVikw1O9co5GYmjlW7uDbAHiy5X8+CNRaXKEbpfwy3ULJI1nHj0ypdNhQr9lcrvCOQFkGbQ5F45xN53h8AVDxqZhFLrFdrlAxjj3+AYJq2EB+sUeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar2ccDdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44699C433F1;
	Sat,  9 Mar 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710006628;
	bh=H9SxWwtkuoEGXRmemD5AodkzSiaEFmYEKNrb6oO0x08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ar2ccDdq5MkreZWrPEuosttE0ns7iVrB6U0+788NzXbCbh6eFhCCybDRigrVQqNrK
	 I1fdRjJQISPGOuTjUBeW8TmBZDLrcpLReSZfeQOepyf64HuhvgSFzIesl3l77Oq73P
	 rT+QGyR3MXzkoS5WT4zxhVOO0Tp6XV0+5yWXoRyvB/yyJV0jcZnOw0kiT5BZw0clo4
	 IYpZb85Oy1YT9ipei8VgP04I8xFQwVqYrft+GTArbqsW68dtX5AAioiDXsUFLFD+Xv
	 I4le40UZynmIXtA1runzK0mNcEe5jlLfUG/BKKVRa7WZTrqH7kh9qznfcwAhY3Z08X
	 LUah4PijAS1Mw==
Message-ID: <9def52e8-89ac-49eb-a2fa-5877d1d638de@kernel.org>
Date: Sat, 9 Mar 2024 10:50:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/7] net: nexthop: Adjust netlink policy
 parsing for a new attribute
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709727981.git.petrm@nvidia.com>
 <a76b651c734d81d1f1c749d16adf105acb9e058c.1709727981.git.petrm@nvidia.com>
 <CANn89i+UNcG0PJMW5X7gOMunF38ryMh=L1aeZUKH3kL4UdUqag@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89i+UNcG0PJMW5X7gOMunF38ryMh=L1aeZUKH3kL4UdUqag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/24 8:02 AM, Eric Dumazet wrote:
> 
> ...
> 
>> -
>>  /* rtnl */
>>  static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>>                            struct netlink_ext_ack *extack)
>>  {
>>         struct net *net = sock_net(skb->sk);
>> +       struct nlattr *tb[NHA_MAX + 1];
> 
> big tb[] array, but small rtm_nh_policy_del[] policy.
> 
>>         struct nl_info nlinfo = {
>>                 .nlh = nlh,
>>                 .nl_net = net,
>> @@ -3020,7 +3010,12 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>>         int err;
>>         u32 id;
>>
>> -       err = nh_valid_get_del_req(nlh, &id, extack);
>> +       err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
> 
> But here you pass NHA_MAX...
> 

existing code always used ARRAY_SIZE on the policy for both tb and
parse; the new del change should use it. Missed that in the review.


