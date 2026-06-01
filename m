Return-Path: <netdev+bounces-293598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJY9Fr03HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A075761B032
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590BD300E713
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF495386562;
	Mon,  1 Jun 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVP4LMsB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75A2571A9;
	Mon,  1 Jun 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299423; cv=none; b=DF5qAvzZOR8OiyEuYmpiwpJElJyWh43QB0SzrXHgmykHmAm+7bscQTWlvlesb4nY/OsZ7NfBUdK7OZ42TgykSmVizviCUT9GJmO2z3IcdNS+Gayrs0Em+wcYAokcYy/JP8MxCwI00lGc4HQiFEcYTw16WohYiiQFgVrUAlpXujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299423; c=relaxed/simple;
	bh=mC81qbgcmy38SViJX2b4S2Scv8I8BxByNoAREvN26Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSQex4UkIIwjHmPZpcG1RxRJHyZU8uqbJYBfi0nf2ZsqU2KW311y9PDyzypDiKDL+fdBlUCUert3ymw5gxSxyL3ROlApue/N8ctXIj3T+yFjjCb28cnM/d7nxAHkswZzhq3zCezzwVpAPX+Zj5f3Unj6G6wRRSJ2A8wUePC0N04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVP4LMsB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8C1F00898;
	Mon,  1 Jun 2026 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780299422;
	bh=W3C0w43v+VUaqwsG+cLidNf+MHEhVD0SKjKR4LFNQIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GVP4LMsB1VBljXIETcjY0CUYSzcqEvtMlC4/IRVzDJbfTHIYrRdRrym0RWaWLkNqE
	 L1CGUbYEUYA9ZNFUF/EvXJlnqemnesU+cM4qBxcGTGA2znhowzuEHkVJmXRRRwtIsM
	 /6ySJSUEs24rpRizKKR5FFpUE7G0Br6/5QDpEvE4E1OnoaYrlc9JZ7pQDFJZEXvBS7
	 W6yDMx5b0nUCZSvpY8fcuxd7D2E151fztzDnoS1W1DOquEni4ixzQaIxskv+cPuDHf
	 SbkT/7XJs79pU7Agr1dCz499D6QCEiWJ4kO0pm7jAbx+/dTBahLiJlLo2Ur10me+vD
	 o6nhqNeD0Nokw==
Message-ID: <da187652-64c5-4775-a662-c52eb6cd8549@kernel.org>
Date: Mon, 1 Jun 2026 17:36:54 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 05/11] tcp: allow mptcp to drop TS for some
 packets
Content-Language: fr
To: Eric Dumazet <edumazet@google.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
 <CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com>
 <1f3aea3b-1bb0-4584-8f6d-af14d73df81d@kernel.org>
 <CANn89iLBh-tSEzDuZce5G2dmC6An1agoJ9UNq2qwAAC0+oTuPg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLBh-tSEzDuZce5G2dmC6An1agoJ9UNq2qwAAC0+oTuPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293598-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: A075761B032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/06/2026 17:26, Eric Dumazet wrote:
> On Sun, May 31, 2026 at 11:52 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> Thank you for the review!
>>
>> On 01/06/2026 16:04, Eric Dumazet wrote:
>>> On Sun, May 31, 2026 at 10:25 PM Matthieu Baerts (NGI0)
>>> <matttbe@kernel.org> wrote:
>>>>
>>>> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
>>>> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
>>>> this case, it is then not possible to send the address signal.
>>>>
>>>> The idea is to let MPTCP dropping the TCP-timestamps option for some
>>>> specific packets, to be able to send some specific pure ACK carrying >28
>>>> bytes of MPTCP options, like with this specific ADD_ADDR. A new
>>>> parameter is passed from tcp_established_options to the MPTCP side to
>>>> indicate if the TCP TS option is used, and if it should be dropped. The
>>>> next commit implements the part on MPTCP side, but split into two
>>>> patches to help TCP maintainers to identify the modifications on TCP
>>>> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
>>>> MPTCP sysctl knob.
>>>>
>>>> It is important to keep in mind that dropping the TCP timestamps option
>>>> for one packet of the connection could eventually disrupt some
>>>> middleboxes: even if it should be unlikely, they could drop the packet
>>>> or even block the connection. That's why this new feature will be
>>>> controlled by a sysctl knob.
>>>>
>>>> Note that it would be technically possible to squeeze both options into
>>>> the header if the ADD_ADDR is first written, and then the TCP timestamps
>>>> without the NOPs preceding it. But this means more modifications on TCP
>>>> side, plus some middleboxes could still be disrupted by that.
>>>>
>>>> About the implementation, instead of passing a new boolean (drop_ts),
>>>> another option would be to pass the whole option structure (opts),
>>>> but 'struct tcp_out_options' is currently defined in tcp_output.c, and
>>>> would need to be exported. Plus that means the removal of the TCP TS
>>>> option would be done on the MPTCP side, and not here on the TCP side.
>>>> It feels clearer to remove other TCP options from the TCP side, than
>>>> hiding that from the MPTCP side.
>>>>
>>>> Yet an other alternative would be to pass the size already taken by the
>>>> other TCP options, and have a way to drop them all when needed. But this
>>>> feels better to target only the timestamps option where dropping it
>>>> should be safe, even if it is currently the only option that would be
>>>> set before MPTCP, when MPTCP is used.
>>>>
>>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>> To: Neal Cardwell <ncardwell@google.com>
>>>> To: Kuniyuki Iwashima <kuniyu@google.com>
>>>> ---
>>>>  include/net/mptcp.h   | 3 ++-
>>>>  net/ipv4/tcp_output.c | 6 +++++-
>>>>  net/mptcp/options.c   | 3 ++-
>>>>  3 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>> index f7263fe2a2e4..000b6593bfa4 100644
>>>> --- a/include/net/mptcp.h
>>>> +++ b/include/net/mptcp.h
>>>> @@ -151,7 +151,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>>>>                           struct mptcp_out_options *opts);
>>>>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>>>                                unsigned int *size, unsigned int remaining,
>>>> -                              struct mptcp_out_options *opts);
>>>> +                              bool *drop_ts, struct mptcp_out_options *opts);
>>>>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>>>>
>>>>  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>>>> @@ -270,6 +270,7 @@ static inline bool mptcp_established_options(struct sock *sk,
>>>>                                              struct sk_buff *skb,
>>>>                                              unsigned int *size,
>>>>                                              unsigned int remaining,
>>>> +                                            bool *drop_ts,
>>>>                                              struct mptcp_out_options *opts)
>>>>  {
>>>>         return false;
>>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>>> index ef0c10cd31c7..53ee4c8f5f8c 100644
>>>> --- a/net/ipv4/tcp_output.c
>>>> +++ b/net/ipv4/tcp_output.c
>>>> @@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>>>>          */
>>>>         if (sk_is_mptcp(sk)) {
>>>>                 unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>>>> +               bool drop_ts = opts->options & OPTION_TS;
>>>>                 unsigned int opt_size = 0;
>>>>
>>>>                 if (mptcp_established_options(sk, skb, &opt_size, remaining,
>>>> -                                             &opts->mptcp)) {
>>>> +                                             &drop_ts, &opts->mptcp)) {
>>>>                         opts->options |= OPTION_MPTCP;
>>>>                         size += opt_size;
>>>> +
>>>> +                       if (drop_ts)
>>>> +                               opts->options &= ~OPTION_TS;
>>>>                 }
>>>>         }
>>>
>>> Passing local variables' addresses forces the compiler to use a stack
>>> canary in this hot function, even for non-MPTCP flows.
>>>
>>> I was about to test the following patch, which removes the current
>>> stack canary caused by MPTCP :/
>>
>> Sorry, I didn't know you were planning to do that.
>>
>> Would that be OK for you if I use an unused bit in opts->mptcp? It's a
>> bit "hackish", but it avoids adding a new local variable address. Or do
>> you have another idea?
>>
>> The modifications in net/ipv4/tcp_output.c would then be limited to:
>>
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index ef0c10cd31c7..f4edc9c4f3fc 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -1181,12 +1181,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>>          */
>>         if (sk_is_mptcp(sk)) {
>>                 unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>> +               bool has_ts = opts->options & OPTION_TS;
>>                 unsigned int opt_size = 0;
>>
>>                 if (mptcp_established_options(sk, skb, &opt_size, remaining,
>> -                                             &opts->mptcp)) {
>> +                                             has_ts, &opts->mptcp)) {
>>                         opts->options |= OPTION_MPTCP;
>>                         size += opt_size;
>> +
>> +#if IS_ENABLED(CONFIG_MPTCP)
>> +                       if (opts->mptcp.drop_ts)
>> +                               opts->options &= ~OPTION_TS;
>> +#endif
> 
> SGTM, but maybe the IS_ENABLED() is not needed in this block,
> guarded by  if (sk_is_mptcp(sk))  ?

I didn't think about that, I will check.

> Also I am unsure opts->mptcp.drop_ts is cleared already before
> reaching  tcp_established_options()?

Indeed, it is not. I explicitly reset it in mptcp_established_options,
but I could do it here, that would be clearer.

>>                 }
>>         }
>>
>>
>> I can also avoid adding a new parameter in mptcp_established_options
>> (bool has_ts) by setting opts->mptcp.drop_ts before calling it, but
>> that's clearer with this new parameter I think.
>>
>>> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
>>> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
>>> Function                                     old     new   delta
>>> tcp_options_write.isra                      1423    1407     -16
>>> mptcp_established_options                   2746    2720     -26
>>> tcp_established_options                      553     503     -50
>>> Total: Before=22110750, After=22110658, chg -0.00%
>>>
>>
>> Good reduction!
>>
>> (...)
>>
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..594ec6ba02d5413d43842f79aefbf4d8355c4f3f
>>> 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -1183,10 +1183,11 @@ static unsigned int
>>> tcp_established_options(struct sock *sk, struct sk_buff *skb
>>>                 unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>>>                 unsigned int opt_size = 0;
>>>
>>> -               if (mptcp_established_options(sk, skb, &opt_size, remaining,
>>> -                                             &opts->mptcp)) {
>>> +               opt_size = mptcp_established_options(sk, skb, remaining,
>>> +                                                    &opts->mptcp);
>>> +               if (opt_size) {
>>>                         opts->options |= OPTION_MPTCP;
>>> -                       size += opt_size;
>>> +                       size += (opt_size & 63);
>>
>> Nice trick! What about returning a negative number when the MPTCP option
>> is not needed? Just to avoid playing with masks in the code?
> 
> Yes, that would work, thanks.
> 
> I can provide a patch in a couple of hours.
No hurry, thank you! I will wait for your patches to be applied before
sending a v2.

(While at it, no need to initialise opt_size to 0 here above, and there
was a double ";;" in mptcp_established_options, around "return 64 +
total_size;;" but this code will change anyway.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


