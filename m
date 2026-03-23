Return-Path: <netdev+bounces-270478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCJUL3UkwWmTQwQAu9opvQ
	(envelope-from <netdev+bounces-270478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21D2F13C0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B2D3041A6E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91C39657C;
	Mon, 23 Mar 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3X0bzc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E9396560;
	Mon, 23 Mar 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264784; cv=none; b=J1T73LM8O8ohqvmP5V4mQTo8DnKwNSOVN7sxknS7uwjE7dfTFWgXSdYDkgq1ATTMjiywy0oMG4cfjEOObWc1tQJW7FoYBfTvnqhk+GvxAjXYdWlumjwERrQSHb1M8lTMYjQYv4OsJTRshiMLTBJRHMfcvSUwqkb/G+V7mw4JuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264784; c=relaxed/simple;
	bh=pVwLi6PNiZfqcNTznwdxB5XeTQheSThDYv0gKTyXmKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbL/Vs/feU0JqyVCBYLcV25QR0d7IlzU0+VAyQJq5ddy9OaHO8/TH/rEs1xyk7n7EcSNKnt18hxDFES5Ii0pDeWHCnw+kMU1k4+b/IQuINRyXlaUxuhG9g39jU92hIprfKx5zkUm28l26ZYAhOxxfrulugRB1IyM0dp8/H9qcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3X0bzc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE6C4CEF7;
	Mon, 23 Mar 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774264784;
	bh=pVwLi6PNiZfqcNTznwdxB5XeTQheSThDYv0gKTyXmKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b3X0bzc42fmN1tIlhcxGDxvFRnxFFlbhoIfteDOewKc/xYkWM2EywbfMEMU/rEClB
	 6Wyfk0ySeweXax5g9+KuSZuCtZ5XgvFmZ8tdzM2OTxgnWskFzVlrIFgFhY8sgZxgp8
	 BW66fFmBpp427Z4qtH2ufIu0XF9DU/h1HLJ26IJwzfe9bJnXqqPmjN/cqYZS7imA+3
	 VjxjAWdqjuymw20LO7hgWQyk4kHqJf01NdZfM/mvy3VaEuZzaU1o2HVp6upPwa+jdo
	 KEvEC1QvfYpdjR7Szs5nSYaTTY0Dmsn5jM1t/SrL8OaHhOG72h40dbmzaEXtjQA+YX
	 wjcuE+lrYQY5Q==
Message-ID: <c23a41be-afb5-4b28-a26c-2e29c210aa98@kernel.org>
Date: Mon, 23 Mar 2026 12:19:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 weiyongjun1@huawei.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
 <57061768-a136-49b8-b020-609016f217ed@kernel.org>
 <e91bf909-bf4d-4f90-a370-688a9424478b@huawei.com>
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
In-Reply-To: <e91bf909-bf4d-4f90-a370-688a9424478b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 4E21D2F13C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Li,

Sorry for the delay.

On 04/03/2026 10:24, Li Xiasong wrote:
> Hi Matt,
> 
> On 3/4/2026 2:06 AM, Matthieu Baerts wrote:
>> Hi Li,
>>
>> On 02/03/2026 06:26, Li Xiasong wrote:
>>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>>
>>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>>> find available data and never perform actual waiting, leading to a soft
>>> lockup.
>>>
>>> Fix this by adding a 'last' parameter to track the last peeked skb.
>>> This allows sk_wait_data() to make informed waiting decisions and prevent
>>> infinite loops when MSG_PEEK is used.
>>
>> (...)
>>
>>> Fixes: 612f71d7328c ("mptcp: fix possible stall on recvmsg()")
>>> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
>>> ---
>>>  net/mptcp/protocol.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index cf1852b99963..7a65c2101f63 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>>>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>>  				size_t len, int flags, int copied_total,
>>>  				struct scm_timestamping_internal *tss,
>>> -				int *cmsg_flags)
>>> +				int *cmsg_flags, struct sk_buff **last)
>>>  {
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>>  	struct sk_buff *skb, *tmp;
>>> @@ -2058,6 +2058,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>>  			}
>>>  
>>>  			mptcp_eat_recv_skb(sk, skb);
>>> +		} else {
>>> +			*last = skb;
>>
>> Out of curiosity, why only setting *last for MSG_PEEK? Is it not better
>> to always call sk_wait_data() later with the last skb, even when
>> MSG_PEEK is not used?
>>
>> Or will this cause other troubles?
> 
> 
> Yes, unconditionally updating last (like tcp_recvmsg_locked) makes
> sense. The current hesitation is due to mptcp_eat_recv_skb releasing the
> skb in non-MSG_PEEK cases—if the address is reused, keeping a last
> pointer could lead to misjudgment.

I think setting "last" just after having incremented "copied" would not
be confusing.

>>>  		}
>>>  
>>>  		if (copied >= len)
>>> @@ -2263,6 +2265,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>>  {
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>>  	struct scm_timestamping_internal tss;
>>> +	struct sk_buff *last = NULL;
>>
>> Detail: the scope of this variable could eventually be reduced by moving
>> it inside the while-loop. This should hopefully help to reduce conflicts
>> during backports.
>>
> 
> 
> You're right. My initial thought was to move `last` into the while loop,
> but in practice, to retain the last MSG_PEEK skb, `last` must be updated
> very early in __mptcp_recvmsg_mskq as we begin traversing
> &sk->sk_receive_queue. The issue is that if a subsequent step fails—such
> as skb_copy_datagram_msg—we'd then need to roll `last` back to the
> previous skb, which adds significant complexity. This suggests the
> current approach may be the safer trade-off.

I think "last" should be initialised to the last item of the received
queue -- skb_peek_tail(&sk->sk_receive_queue) -- before walking it: that
seems simpler and cover errors in previous calls, no?

>>>  	int copied = 0, cmsg_flags = 0;
>>>  	int target;
>>>  	long timeo;
>>> @@ -2291,7 +2294,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>>  		int err, bytes_read;
>>>  
>>>  		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
>>> -						  copied, &tss, &cmsg_flags);
>>> +						  copied, &tss, &cmsg_flags,
>>> +						  &last);
>>>  		if (unlikely(bytes_read < 0)) {
>>>  			if (!copied)
>>>  				copied = bytes_read;
>>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>>  
>>>  		pr_debug("block timeout %ld\n", timeo);
>>>  		mptcp_cleanup_rbuf(msk, copied);
>>> -		err = sk_wait_data(sk, &timeo, NULL);
>>> +		err = sk_wait_data(sk, &timeo, last);
>>>  		if (err < 0) {
>>>  			err = copied ? : err;
>>>  			goto out_err;
>> Cheers,
>> Matt
> 
> 
> As requested, here are the two minimal test programs.

Thank you. These test programs couldn't be integrated in the test suite
because they required a manual step (check CPU usage). Instead, I wrote
a small packetdrill test:

  https://github.com/multipath-tcp/packetdrill/pull/192

There, you will also find a diff containing the modifications suggested
above. Do you mind sending a v2 with them if that's OK, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


