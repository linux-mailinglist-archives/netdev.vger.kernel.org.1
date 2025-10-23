Return-Path: <netdev+bounces-232133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDAAC019B5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D191A66942
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC7200BA1;
	Thu, 23 Oct 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVJ7yjgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5628373;
	Thu, 23 Oct 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228064; cv=none; b=nv8J7knzdqJYfw+xMOha4he1gwnA5eRHW1Nel+zGySiPtvmlnxRFylC03zGnJMjcszuo0g3zFWXxDw3XZU74tSLysEaHmCafJY+Lv3I1Anu9eNeZtDO1mmypbtwHYhazM9bsl+pUk1VKsEtpWjDf5LqOhGaxwKKreSdawb31cyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228064; c=relaxed/simple;
	bh=O1zDBPNEVxwsWDfD8fBlOO6EtkQk7ptwugbAO7JI3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhmz02GMwbdw9bL1e9vvANRL9kvS6JN9aA8ClnP1mPooV3AxjAW3Mkw22iJHmM6qmjlXfo16lHsjwGb93a3/9HwnZ681aySUEKZ+bclFmikuhTFo1AIOoDiAEdpGb02TCJxbABzPuKAsToKdLXFfGpFQOGoAFyD4+97MTxR0t9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVJ7yjgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E808FC4CEE7;
	Thu, 23 Oct 2025 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228064;
	bh=O1zDBPNEVxwsWDfD8fBlOO6EtkQk7ptwugbAO7JI3ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVJ7yjgUjLqerAfbJRb36HGkzDDAeBtOzh2Q8TVeV93k4DtYdlE+tfO+kNiHmGHGZ
	 CKXKZid0O+x8qmfLh58coUP47zBR0PRlPuxhRGWb0U4oA7z9HkimteVg/oTWIpESfi
	 UyJrEJXWxaG79d47hLXWFiPyMhM7pqtsxdmHW/fXsy10a3kX7vGnywc0ZU6AnvrHFK
	 70RrXe0vbDcBKtiH/y7XsD1zRZn/DPX2AqKBRdMm5CJjcVuaPPZGXEXHz83zQFCcgd
	 vVl30gqMmfVF7PuVr41zNaiW22ykducTOxeTE1I6FjISTebmggKpfW7spwkmZjs/au
	 JvRfep9b23Ojg==
Message-ID: <2f766fe8-374a-44ff-a912-b43190aee400@kernel.org>
Date: Thu, 23 Oct 2025 16:00:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] mptcp: fix incorrect IPv4/IPv6 check
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014122619.316463-1-jiayuan.chen@linux.dev>
 <f046fdda-3bad-4f7f-8587-dca30d183f82@kernel.org>
 <a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

Thank you for your reply (and sorry for the delay, I was unavailable for
a few days).

On 15/10/2025 16:16, Jiayuan Chen wrote:
> October 14, 2025 at 23:27, "Matthieu Baerts" <matttbe@kernel.org> wrote:
>> On 14/10/2025 14:26, Jiayuan Chen wrote:
>>
>>>
>>> When MPTCP falls back to normal TCP, it needs to reset proto_ops. However,
>>>  for sockmap and TLS, they have their own custom proto_ops, so simply
>>>  checking sk->sk_prot is insufficient.
>>>  
>>>  For example, an IPv6 request might incorrectly follow the IPv4 code path,
>>>  leading to kernel panic.
>>>
>> Did you experiment issues, or is it a supposition? If yes, do you have
>> traces containing such panics (or just a WARN()?), and ideally the
>> userspace code that was leading to this?
>>
> 
> 
> Thank you, Matthieu, for your suggestions. I spent some time revisiting the MPTCP logic.
> 
> 
> Now I need to describe how sockmap/skmsg works to explain its conflict with MPTCP:

OK, so the issue is only with sockmap, not TLS, right?

> 1. skmsg works by replacing sk_data_ready, recvmsg, sendmsg operations and implementing
> fast socket-level forwarding logic
> 
> 2. Users can obtain file descriptors through userspace socket()/accept() interfaces, then
>    call BPF syscall to perform these replacements.
> 3. Users can also use the bpf_sock_hash_update helper (in sockops programs) to replace
>    handlers when TCP connections enter ESTABLISHED state (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB or BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)

I appreciate these explanations. I will comment on the v3.

> For MPTCP to work with sockmap, I believe we need to address the following points
> (please correct me if I have any conceptual misunderstandings about MPTCP):
> 
> 1. From client perspective: When a user connects to a server via socket(), the kernel
>    creates one master sk and at least two subflow sk's. Since the master sk doesn't participate
>    in the three-way handshake, in the sockops flow we can only access the subflow sk's.

To be a bit more precise, with MPTCP, you will deal with different
socket types:

- the userspace facing one: it is an MPTCP socket (IPPROTO_MPTCP)

- the in-kernel subflow(s) (= path): they are TCP sockets, but not
  exposed to the userspace.

There is no "master sk" (I hope you didn't look at the previous fork
implementation that was using this name, before the upstreaming
process), but yes, you will have the MPTCP socket, and at least one TCP
socket for the subflow.

>    In this case, we need to replace the handlers of mptcp_subflow_ctx(sk)->conn rather
>    than the subflow sk itself.
>> 2. From server perspective: In BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB,
the sk is the MP_CAPABLE
>    subflow sk, so similar to the client perspective, we need to replace the handlers of
>    mptcp_subflow_ctx(sk)->conn.

On the userspace side, the socket after the 'accept()' is either an
MPTCP socket (IPPROTO_MPTCP) or a TCP one (IPPROTO_TCP) depending on the
request: if the SYN was containing the MP_CAPABLE option or not. If a
plain TCP socket is returned, it is not an MPTCP subflow any more, it is
a "classic" TCP connection.

To get MPTCP support with sockmap, I guess you will need to act at the
MPTCP level: you should never manipulate the data on the TCP subflows
directly, because you will only get a part of the data when multiple
paths are being used. Instead, you should wait for MPTCP to re-order the
data, etc.

> If the above description is correct, then my current patch is incorrect. I should focus on
> handling the sockmap handler replacement flow properly instead.

It would be really great to add MPTCP support in sockmap, but first, I
guess we need a way to prevent issues like the one you saw.

> Of course, this would require comprehensive selftests to validate.
> 
> Returning to the initial issue, the panic occurred on kernel 6.1, but when I tested with the
> latest upstream test environment, it only triggered a WARN().
> I suspect there have been significant changes in MPTCP during this period.

Even if it was only triggering a WARN(), we will still need a fix for
v6.1. Once the series will be ready, do you mind checking what needs to
be done to have the solution working on v6.1? I guess the solution
should be very close to what we will have on v6.18.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


