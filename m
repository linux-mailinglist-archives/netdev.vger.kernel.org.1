Return-Path: <netdev+bounces-294289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gSyJCrMGH2pOdgAAu9opvQ
	(envelope-from <netdev+bounces-294289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A96303EE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mvcRqDZw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71B6D307FB4A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05912FDC28;
	Tue,  2 Jun 2026 16:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F161DED4C
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417452; cv=none; b=FbIn8vt5yPmB+qg+feJfKE466JBfq66nk53ICHCNEtocpKQiafmB3BuHCVlO9vCLea83h2rT+igzkGeID7J5eii1yg1SxF/t7vS0zJ3nYDs7Ubx7Wt8jJkIy7BGUDjh9XXrHvAG5+T/vCc2jVxPln4NaQmYIJiHW6i+e6b19Y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417452; c=relaxed/simple;
	bh=CRGdwPAvPEBYtPkd7lnEduHETK6NV7SLTX+S7ubZAcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM5qLXbzIcnDIHAzkOQgENYICvY6bTdeg4ksfgb1u/+mEEmCLuYHFPlnG19twVYe0uDppObUk0KMmKn201IyXCHgvlYcyQ46hBeEKvsVaHdQ8d27zG2E3R//xPYbw7GmaFhWkCPA1xLBqG5bYF/pQfT/hu3HdvrFlA+8lokD78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvcRqDZw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B61F00893;
	Tue,  2 Jun 2026 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417451;
	bh=fQq97OcpVpZJW8A8V7R0IsPh0j5JD4eAPyErZYPXXOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mvcRqDZwjh0F0cqYGHBJATnhwSVFPfRFCuzkFLLiMHtnQ+aQ1sMkIYDXEbTGb1MmH
	 g9FccXITKivqux5TsTcoId8h6WJqNI2BGsK/6MHLUfA20fGVtkhqjZfTUG8u++8sB8
	 JByRgu+OTxrYQtFfme4T6eqU1RBzRBpsdZgkCpzrneoHnMNIaAK8bV4QFXYPmL5ElV
	 dzyf7H3xW/WocE8qawTOrGu3QdAnXoDYRRUT1B6PkYsEmXpPdFGMaS0CnQW/Jszr37
	 VwweQ3X2M+vURpSxUqy8M8Il4AtgYJ+Qtrxhbh+49AZE6vAIiY45TsfPbT2bLLPhuX
	 1DtHkVvdld+9g==
Message-ID: <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org>
Date: Tue, 2 Jun 2026 10:24:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: protect egress device access in the output
 path with rcu_read_lock
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, andrew+netdev@lunn.ch, kuniyu@google.com,
 jlayton@kernel.org, netdev@vger.kernel.org
References: <ahveCu-zzFlpeVut@v4bel> <20260602154523.GA537996@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260602154523.GA537996@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294289-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:imv4bel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 256A96303EE

On 6/2/26 9:45 AM, Ido Schimmel wrote:
> On Sun, May 31, 2026 at 04:06:50PM +0900, Hyunwoo Kim wrote:
>>  drivers/net/vrf.c       | 16 +++++++++++-----
>>  net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
>>  net/ipv4/raw.c          |  4 +++-
>>  net/ipv4/xfrm4_output.c | 13 +++++++++----
>>  net/xfrm/xfrm_output.c  |  4 +++-
>>  5 files changed, 45 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 46209917ae4d..e9a1dd961805 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -833,17 +833,23 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
>>  
>>  static int vrf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  {
>> -	struct net_device *dev = skb_dst(skb)->dev;
>> +	struct net_device *dev;
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	dev = skb_dst_dev_rcu(skb);
>>  
>>  	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
>>  
>>  	skb->dev = dev;
>>  	skb->protocol = htons(ETH_P_IP);
>>  
>> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>> -			    net, sk, skb, NULL, dev,
>> -			    vrf_finish_output,
>> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>> +			   net, sk, skb, NULL, dev,
>> +			   vrf_finish_output,
>> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
>> +	rcu_read_unlock();
>> +	return ret;
>>  }
> 
> Patch LGTM, thanks, but what about the IPv6 counterpart (vrf_output6())
> and the other similar existing issues that Sashiko is flagging?

Common locking at a higher level than dst->output seems like a better
approach. This function is called under rcu_read_lock for some paths.

