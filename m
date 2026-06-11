Return-Path: <netdev+bounces-298013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Ks1JWd3Kmq8pwMAu9opvQ
	(envelope-from <netdev+bounces-298013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E06700AA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FTPvoN4z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298013-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A193226D04
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906F368276;
	Thu, 11 Jun 2026 08:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0230C366;
	Thu, 11 Jun 2026 08:49:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167787; cv=none; b=UnKi4orS7OTLaofmAgVQqnkLU1MjWNlGnpDuQY22X7LfoQb3+zHKHKL7Rvw2Cr1vOTbV6DAcKE+Ha0gdeNG48wlBCGYHj3JDZxRPhhUE5NvcJNEEz9GGs6SmckplPei6dkvhuoprm99GrpMRfYSPbuzQeSswR2XjBEoy6bkMsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167787; c=relaxed/simple;
	bh=GeUC8+xemqPGEoaXIeRvXCM5236BY9QRiaYPx1Y9bzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdmseCwxp1TTyx9hLjyA2V2z6Tvk82m9WBTUw8gqEa8MWxIM3V2OLyZ8TMflV1vFPWBqo63jq6HyVdifNFU8X/cv7cPokbtGEla7HpXxuHheGZNYZHx8fLM+4duruC5qn1Nd7sfeuCNzASMCMbEkUretw5t5X84HKoFL1z4c7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTPvoN4z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1FA1F00899;
	Thu, 11 Jun 2026 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781167786;
	bh=dgCHkfsDYTb+PLoUOahbDNE1Y1mu3UmrNxGmUg1qxyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FTPvoN4z3/wgCcL9zZQ/0e7BgjicCtGoYqDRicIsI4WkE0WBFes5W/ZaSETICFcRi
	 GB6qk6sXcGaBqDUaIvZLOY1LEpO0kHBc9G9w5Ez6KVWSDShiBQ/fSkV7NF5Xcy3qNZ
	 YQcAlk9hA+Zpz0Bz8Eh6SyQ/T9DnHLW9gfyWQoUeAo86B8J7rOwxlwqjxvRQe+nDyM
	 k93QRGGfa5By8f8xhZiQ66hsBgBG36AfHLoZq0Prw0KxBOhPlbz1/okY/TBzTO+bM6
	 20KnlZXEMbwnkw0cdHdNGJNnsZqxX+YT2DO8J8+Rj9qbwnrp2kewK4jCdcg9oXl3sZ
	 qh8Ym0SWvAAUQ==
Message-ID: <1014329c-d60f-432a-b165-62866ca6a4b4@kernel.org>
Date: Thu, 11 Jun 2026 10:49:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
 <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com>
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
In-Reply-To: <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298013-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E16E06700AA

Hi Paolo, Eric,

On 11/06/2026 09:39, Paolo Abeni wrote:
> Hi Eric,
> 
> On 6/5/26 11:21 AM, Matthieu Baerts (NGI0) wrote:
>> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
>> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
>> this case, it is then not possible to send the address signal.
>>
>> The idea is to let MPTCP dropping the TCP-timestamps option for some
>> specific packets, to be able to send some specific pure ACK carrying >28
>> bytes of MPTCP options, like with this specific ADD_ADDR. A new
>> parameter is passed from tcp_established_options to the MPTCP side to
>> indicate if the TCP TS option is used, and if it should be dropped. The
>> next commit implements the part on MPTCP side, but split into two
>> patches to help TCP maintainers to identify the modifications on TCP
>> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
>> MPTCP sysctl knob.
>>
>> It is important to keep in mind that dropping the TCP timestamps option
>> for one packet of the connection could eventually disrupt some
>> middleboxes: even if it should be unlikely, they could drop the packet
>> or even block the connection. That's why this new feature will be
>> controlled by a sysctl knob.
>>
>> Note that it would be technically possible to squeeze both options into
>> the header if the ADD_ADDR is first written, and then the TCP timestamps
>> without the NOPs preceding it. But this means more modifications on TCP
>> side, plus some middleboxes could still be disrupted by that.
>>
>> In this implementation, an unused bit is used in mptcp_out_options
>> structure to avoid passing an address to a local variable. Reading and
>> setting it needs CONFIG_MPTCP, so the whole block now has this #if
>> condition: mptcp_established_options() is then no longer used without
>> CONFIG_MPTCP.
>>
>> About alternatives, instead of passing a new boolean (has_ts), another
>> option would be to pass the whole option structure (opts), but
>> 'struct tcp_out_options' is currently defined in tcp_output.c, and it
>> would need to be exported. Plus that means the removal of the TCP TS
>> option would be done on the MPTCP side, and not here on the TCP side.
>> It feels clearer to remove other TCP options from the TCP side, than
>> hiding that from the MPTCP side.
>>
>> Yet an other alternative would be to pass the size already taken by the
>> other TCP options, and have a way to drop them all when needed. But this
>> feels better to target only the timestamps option where dropping it
>> should be safe, even if it is currently the only option that would be
>> set before MPTCP, when MPTCP is used.
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> - v2: Avoid passing local variables' addresses to
>>   mptcp_established_options not to force the compiler to use a stack
>>   canary in this hot function, even for non-MPTCP flows. (Eric Dumazet)
>> To: Neal Cardwell <ncardwell@google.com>
>> To: Kuniyuki Iwashima <kuniyu@google.com>
>> ---
>>  include/net/mptcp.h   | 13 +++----------
>>  net/ipv4/tcp_output.c | 10 +++++++++-
>>  net/mptcp/options.c   |  2 +-
>>  3 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 24d1016a4664..71b9fc5a5796 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -72,7 +72,8 @@ struct mptcp_out_options {
>>  	u8 reset_reason:4,
>>  	   reset_transient:1,
>>  	   csum_reqd:1,
>> -	   allow_join_id0:1;
>> +	   allow_join_id0:1,
>> +	   drop_ts:1;
>>  	union {
>>  		struct {
>>  			u64 sndr_key;
>> @@ -153,7 +154,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>>  bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>>  			  struct mptcp_out_options *opts);
>>  int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>> -			      unsigned int remaining,
>> +			      unsigned int remaining, bool has_ts,
>>  			      struct mptcp_out_options *opts);
>>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>>  
>> @@ -269,14 +270,6 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
>>  	return false;
>>  }
>>  
>> -static inline int mptcp_established_options(struct sock *sk,
>> -					    struct sk_buff *skb,
>> -					    unsigned int remaining,
>> -					    struct mptcp_out_options *opts)
>> -{
>> -	return -1;
>> -}
>> -
>>  static inline bool mptcp_incoming_options(struct sock *sk,
>>  					  struct sk_buff *skb)
>>  {
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index d3b8e61d3c5e..26dd751ec72a 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -1175,6 +1175,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>>  		size += TCPOLEN_TSTAMP_ALIGNED;
>>  	}
>>  
>> +#if IS_ENABLED(CONFIG_MPTCP)
>>  	/* MPTCP options have precedence over SACK for the limited TCP
>>  	 * option space because a MPTCP connection would be forced to
>>  	 * fall back to regular TCP if a required multipath option is
>> @@ -1183,15 +1184,22 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>>  	 */
>>  	if (sk_is_mptcp(sk)) {
>>  		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>> +		bool has_ts = opts->options & OPTION_TS;
>>  		int opt_size;
>>  
>> -		opt_size = mptcp_established_options(sk, skb, remaining,
>> +		opts->mptcp.drop_ts = 0;
>> +
>> +		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
>>  						     &opts->mptcp);
>>  		if (opt_size >= 0) {
>>  			opts->options |= OPTION_MPTCP;
>>  			size += opt_size;
>> +
>> +			if (opts->mptcp.drop_ts)
>> +				opts->options &= ~OPTION_TS;
> 
> I'm wondering if you are ok with this patch in the current form?
> 
> One thing that was discussed on the mptcp ML was exposing the
> tcp_out_options layout so that mptcp_established_options() could receive
> such argument and likely clean-up a bit this code.
> 
> Not done here because placing tcp_out_options under `include` felt a bit
> "too much". Perhaps adding a `net/ipv4/tcp_option.h` header (and
> including it from the mptcp code) would be more palatable?

Note that I also didn't do this because that would mean the removal of
the TCP TS option would be done from the MPTCP side, and not here from
the TCP side. That didn't feel right to hide this from the MPTCP side.
But I'm fine to change if preferred.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


