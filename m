Return-Path: <netdev+bounces-232563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D4C069A7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D0B4E97D4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CDF2DCBE6;
	Fri, 24 Oct 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RliSbp5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7D186E40
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314578; cv=none; b=RWpAkW4EpWUimhCi1W5fgf4CCOqGRIbvfTmbKN/AcNNU1iVgB0EGcO3bvRVrxVFHys8f8RczZ+Q5ZxhauuOGBdy7ajpsslm8OeC8UxIbrraykOHba842rvsSAFVExPRpMtgU46WJNtmt9ejwX3UGOZMLRgX2a+aI1YD68DrwTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314578; c=relaxed/simple;
	bh=l6H3NSSBmlZvFpq1PqXPWWYmJopFN8+2OfEuhS0ok7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahh6iJp+dKcAGmROLcOcnYX0hnJnzj2fTod16T4KTOmX4gN7/EOeRNzum9YBmR8VyKs+knZgQzuCjxPXmQSbv5IwrZUOiDr4kpAvUOm5055puDsx4/ZzA/iCuehC3u2D0E8MfRBzKiJ2YWJKSdBU6wxSlig5YQn5zF7H0uSgRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RliSbp5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B2EC4CEF1;
	Fri, 24 Oct 2025 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761314577;
	bh=l6H3NSSBmlZvFpq1PqXPWWYmJopFN8+2OfEuhS0ok7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RliSbp5LWnuhWATmDUGCxW3fD1sgz1uGTgCAlnR6w81XApsR/kjW/Yk2b7U/ZtxH8
	 QZeZC7Mh/RK0dcFCkum8fTcNustIiyefK9DJTej54QBJOgoxlEaLKepFik6G3PkWVi
	 SgUnZrXd7ahWZYvtwWzh4LDn0TOnUpZ00LvTlKHDHmmgA14vLRRPij93s3AwOE0ebS
	 Nktkz0FaQFNAHxIUMT5X8S6depb2b37iunyQVKdwJ+eo5HR3Qb2gNN0fBQh+DGIyXR
	 HEC5QiWpOWkT5vXIGfnAGyzgd82+aSLHLto/tu4OI9Jim+hNM8W5TA4HJLsFicc/wi
	 NLzDu4DDm6Dsg==
Message-ID: <44b10f91-1e19-48d0-9578-9b033b07fab7@kernel.org>
Date: Fri, 24 Oct 2025 16:02:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to
 tcp_rcvbuf_grow()
Content-Language: en-GB, fr-BE
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251024075027.3178786-1-edumazet@google.com>
 <20251024075027.3178786-3-edumazet@google.com>
 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
 <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 24/10/2025 13:19, Eric Dumazet wrote:
> On Fri, Oct 24, 2025 at 3:09 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Hi Eric,
>>
>> Many thanks for tracking this down!
>>
>> Recently we are observing mptcp selftests instabilities in
>> simult_flows.sh, Geliang bisected them to e118cdc34dd1 ("mptcp: rcvbuf
>> auto-tuning improvement") and the rcvbuf growing less. I *think* mptcp
>> selftests provide some value even for plain tcp :)
>>
>> On 10/24/25 9:50 AM, Eric Dumazet wrote:
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec65657ec179cfd52ede483 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>>>   * - mptcp does not maintain a msk-level window clamp
>>>   * - returns true when  the receive buffer is actually updated
>>>   */
>>> -static bool mptcp_rcvbuf_grow(struct sock *sk)
>>> +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>>>  {
>>>       struct mptcp_sock *msk = mptcp_sk(sk);
>>>       const struct net *net = sock_net(sk);
>>> -     int rcvwin, rcvbuf, cap;
>>> +     u32 rcvwin, rcvbuf, cap, oldval;
>>>
>>> +     oldval = msk->rcvq_space.copied;
>>> +     msk->rcvq_space.copied = newval;
>>
>> I *think* the above should be:
>>
>>         oldval = msk->rcvq_space.space;
>>         msk->rcvq_space.space = newval;
>>
> 
> You are right, thanks for catching this.
> 
> I developed / tested this series on a kernel where MPTCP changes were
> not there yet.
> 
> Only when rebasing to net-next I realized MPTCP had to be changed.

Thank you for the fix, and for having adapted MPTCP as well!

>> mptcp tracks the copied bytes incrementally - msk->rcvq_space.copied is
>> updated at each rcvmesg() iteration - and such difference IMHO makes
>> porting this kind of changes to mptcp a little more difficult.
>>
>> If you prefer, I can take care of the mptcp bits afterwards - I'll also
>> try to remove the mentioned difference and possibly move the algebra in
>> a common helper.
> 
> Do you want me to split this patch in two parts or is it okay if I
> send a V2 with
> the a/msk->rcvq_space.copied/msk->rcvq_space.space/ ?

If you send a v2, could it eventually target "net" instead please?

If the idea is to delay the fix to stable, it is always possible to ask
the stable team to backport it to stable in a few weeks / months, e.g.

  Cc: <stable@vger.kernel.org> # after -rc6

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


