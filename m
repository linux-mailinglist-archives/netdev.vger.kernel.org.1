Return-Path: <netdev+bounces-294793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id feI2Kl9HIGr5zwAAu9opvQ
	(envelope-from <netdev+bounces-294793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E072639249
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fQrLPt8s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7FD53051DB0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E530C144;
	Wed,  3 Jun 2026 14:52:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A50223DE7
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498331; cv=none; b=ktoSUfQobCfpe/cNSsUj9hRTHzR0AH34bLIcU20/xCD6WVb+Sks+78m20zMStQy9tBzRNlzbRJ3wPQAiGf2V2Cq+c/ul2AnHOYvi4JSOzaVhESaBPMMcHMZntMfxPDM8X5rtmNJEoyeOM90jF8Vr3hbOKFjicXBU2/243vseS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498331; c=relaxed/simple;
	bh=HDcr2YiRSuXkaEuCgWS3hOijsOfF03suIpjODhdREo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfNXx+d+A0jJKCZA4ZmhFIhhUZT/2eifY0qPnCAeMg+OIBbpgqHa3qAx8ib+HcOz9BRJW9zgljd9b3TaEMGi0EApZ7o54jJlYkl0WFo1RbzZPyP43wWyKqh+NfrNVDbLDAR7tyZBml31UUY2DxDp1dSwNY4g4icdeOUS/gUyNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQrLPt8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69F91F00893;
	Wed,  3 Jun 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780498330;
	bh=gSpeVldNkFT7EjhXUR5POP7i9/BXwA1U1h9g3EK75yg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fQrLPt8sFkU6kBqoml4VbfiVYYMOVSMeQHhV88bW6Q5TGbCsfdVczqcCQqCzCmlvs
	 pF3v3fgfRYySiRnfixb6LnUF7OAe0+wfRsf/mHz0V7PSK6reUttIi9yEQ5iHJOwX+Z
	 crpP0MSVe7T9hVq8R82DBNVSLqg5QAq2+V7E+NtBmOvm0sGx5OMrQgVwj3oHR7SqxK
	 kxQTeMoIZCLRCCzbmfsrvD9Fxyh/r2wF2eHSfV0qEXuctVAgiDhaym/rwk8mfj4KqG
	 orpG2oKxR0orP/T1XiLp7SfOJtID1duvyI0OdPIXDtow4uqHk3BErmiYezh37UUE+A
	 ZcFH9ok6QPpcg==
Message-ID: <3abb77f3-1484-4e78-a671-321a560b109a@kernel.org>
Date: Wed, 3 Jun 2026 08:52:08 -0600
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
To: Hyunwoo Kim <imv4bel@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, andrew+netdev@lunn.ch, kuniyu@google.com,
 jlayton@kernel.org, netdev@vger.kernel.org
References: <ahveCu-zzFlpeVut@v4bel> <20260602154523.GA537996@shredder>
 <ad40bbe0-f79c-4fd9-9670-5dab01a8e57f@kernel.org> <aiAk2Q-yNs6It6g4@v4bel>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aiAk2Q-yNs6It6g4@v4bel>
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
	TAGGED_FROM(0.00)[bounces-294793-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imv4bel@gmail.com,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:jlayton@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E072639249

On 6/3/26 6:58 AM, Hyunwoo Kim wrote:
> On Tue, Jun 02, 2026 at 10:24:09AM -0600, David Ahern wrote:
>> On 6/2/26 9:45 AM, Ido Schimmel wrote:
>>> On Sun, May 31, 2026 at 04:06:50PM +0900, Hyunwoo Kim wrote:
>>>>  drivers/net/vrf.c       | 16 +++++++++++-----
>>>>  net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
>>>>  net/ipv4/raw.c          |  4 +++-
>>>>  net/ipv4/xfrm4_output.c | 13 +++++++++----
>>>>  net/xfrm/xfrm_output.c  |  4 +++-
>>>>  5 files changed, 45 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>>> index 46209917ae4d..e9a1dd961805 100644
>>>> --- a/drivers/net/vrf.c
>>>> +++ b/drivers/net/vrf.c
>>>> @@ -833,17 +833,23 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
>>>>  
>>>>  static int vrf_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>>>  {
>>>> -	struct net_device *dev = skb_dst(skb)->dev;
>>>> +	struct net_device *dev;
>>>> +	int ret;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	dev = skb_dst_dev_rcu(skb);
>>>>  
>>>>  	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
>>>>  
>>>>  	skb->dev = dev;
>>>>  	skb->protocol = htons(ETH_P_IP);
>>>>  
>>>> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>>>> -			    net, sk, skb, NULL, dev,
>>>> -			    vrf_finish_output,
>>>> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>>>> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
>>>> +			   net, sk, skb, NULL, dev,
>>>> +			   vrf_finish_output,
>>>> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
>>>> +	rcu_read_unlock();
>>>> +	return ret;
>>>>  }
>>>
>>> Patch LGTM, thanks, but what about the IPv6 counterpart (vrf_output6())
> 
> I left ipv6 out because its callers (ip6_send_skb, ip6_xmit, etc.)
> already hold rcu. Though some niche paths may not. (maybe rxe_send?)
> 
>>> and the other similar existing issues that Sashiko is flagging?
> 
> I couldn't find Sashiko's review. Could you share a url?
> 
>>
>> Common locking at a higher level than dst->output seems like a better
>> approach. This function is called under rcu_read_lock for some paths.
> 
> Adding rcu to ip_local_out would protect all functions reached via
> dst_output in one place; raw_send_hdrinc and xfrm_output_resume still
> need their own patches. What do you think of this diff?
> 
> As a follow-up, the rcu in ip_output etc. then becomes redundant and
> should be removed.
> 
> 
> Best regards,
> Hyunwoo Kim
> 
> ---
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 5bcd73cbdb41..26b51ef0763f 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -126,9 +126,11 @@ int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	int err;
> 
> +	rcu_read_lock();
>  	err = __ip_local_out(net, sk, skb);
>  	if (likely(err == 1))
>  		err = dst_output(net, sk, skb);
> +	rcu_read_unlock();
> 
>  	return err;
>  }
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 68e88cb3e55c..555e62eacdc6 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -410,9 +410,11 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  				skb_transport_header(skb))->type);
>  	}
> 
> +	rcu_read_lock();
>  	err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
> -		      net, sk, skb, NULL, rt->dst.dev,
> +		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
>  		      dst_output);
> +	rcu_read_unlock();
>  	if (err > 0)
>  		err = net_xmit_errno(err);
>  	if (err)
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index cc35c2fcbbe0..c5ac360da38d 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -594,6 +594,7 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
>  {
>  	struct net *net = xs_net(skb_dst(skb)->xfrm);
> 
> +	rcu_read_lock();
>  	while (likely((err = xfrm_output_one(skb, err)) == 0)) {
>  		nf_reset_ct(skb);
> 
> @@ -601,12 +602,14 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
>  		if (unlikely(err != 1))
>  			goto out;
> 
> -		if (!skb_dst(skb)->xfrm)
> -			return dst_output(net, sk, skb);
> +		if (!skb_dst(skb)->xfrm) {
> +			err = dst_output(net, sk, skb);
> +			goto out;
> +		}
> 
>  		err = nf_hook(skb_dst(skb)->ops->family,
>  			      NF_INET_POST_ROUTING, net, sk, skb,
> -			      NULL, skb_dst(skb)->dev, xfrm_output2);
> +			      NULL, skb_dst_dev_rcu(skb), xfrm_output2);
>  		if (unlikely(err != 1))
>  			goto out;
>  	}
> @@ -615,6 +618,7 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
>  		err = 0;
> 
>  out:
> +	rcu_read_unlock();
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(xfrm_output_resume);

I prefer this over locking in each of the output functions. IPv6 should
be updated as well.

