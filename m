Return-Path: <netdev+bounces-252526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAoRLxeDcmkUlwAAu9opvQ
	(envelope-from <netdev+bounces-252526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:05:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C96D515
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EB253004DBC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724339CED2;
	Thu, 22 Jan 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clfw6A0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18107346A04
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112338; cv=none; b=n6/ZGeup+c43DTIg2IWDyfw4s8JA2erjhD7cphC8d8XTEjfMYu+IoHSCioWXHgiLnBDvdlY7gqkegSXgVgssYyivhBnCNPUOOWy5BwCbFzBGwjGetnOsuVwkQaWkWjumXoAhIjMkCAmFNjwpdjW894YThnK66rBSLAtYbDKgFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112338; c=relaxed/simple;
	bh=eWihy3VUCeEi3epkPHxvkcRSpVRAyqmLAcirtp7FW9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImGxY5k28w0NePXMJa7T/woWiwh37Uwq0MWY+YT+wlX1lRe1Wt0HDLNigkyGyosWmC+RTkkoAIsJdWHX/o89hO4/HZ3MrAJAQbdVBIvTK2e/1z+H8movtY4ubYG9fM/42Tt1FSh22tHiQTF0bL7nzPmd260UoBLQ85uFGBF6uaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clfw6A0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FA2C116C6;
	Thu, 22 Jan 2026 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769112336;
	bh=eWihy3VUCeEi3epkPHxvkcRSpVRAyqmLAcirtp7FW9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Clfw6A0B/gvwOxK/BZB8riW6G3sZ4O1F9MevvP7LomTQ6wkPmZA2CnZO2PUTpMvOY
	 xVVqht+VnWtw57WkJBS+Ha+ah8ncYU3eOny2RDW/XDVe0U7leFj4bdzPlmszvNKt6Y
	 SEVEwWdz6r1ITFo5I8FWxU6XDPJCyQmYRWbxCWCBEVGW3jEBJ34AS0aEWgj8JRPslD
	 HfA34NeWqnWTA8mta88cvgi0xHI5bXpEEA9rUyjRyA9Pw0UDcwh0htMf91jYbQ0Co6
	 +R9InK2Ro1x9503zGqj89XoLUKXsi1svUymU2FyNOQ9NJUS3yl5FFoJ66YboUfA1qQ
	 NEeYsZ3dbITTw==
Message-ID: <60f5b633-d214-450c-a1ce-26df8f2d8f26@kernel.org>
Date: Thu, 22 Jan 2026 13:05:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: igmp: annotate data-races around
 idev->mr_maxdelay
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260122172247.2429403-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260122172247.2429403-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC6C96D515
X-Rspamd-Action: no action

On 1/22/26 10:22 AM, Eric Dumazet wrote:
> idev->mr_maxdelay is read and written locklessly,
> add READ_ONCE()/WRITE_ONCE() annotations.
> 
> While we are at it, make this field an u32.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/inetdevice.h | 2 +-
>  net/ipv4/igmp.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
> index 5730ba6b1cfaff25f2b9d206722662e1e62b88fc..dccbeb25f70141982160c776f3cc727296def2b7 100644
> --- a/include/linux/inetdevice.h
> +++ b/include/linux/inetdevice.h
> @@ -38,11 +38,11 @@ struct in_device {
>  	struct ip_mc_list	*mc_tomb;
>  	unsigned long		mr_v1_seen;
>  	unsigned long		mr_v2_seen;
> -	unsigned long		mr_maxdelay;
>  	unsigned long		mr_qi;		/* Query Interval */
>  	unsigned long		mr_qri;		/* Query Response Interval */
>  	unsigned char		mr_qrv;		/* Query Robustness Variable */
>  	unsigned char		mr_gq_running;
> +	u32			mr_maxdelay;
>  	u32			mr_ifc_count;
>  	struct timer_list	mr_gq_timer;	/* general query timer */
>  	struct timer_list	mr_ifc_timer;	/* interface change timer */
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 7182f1419c2a4d4ea1e90ef6857f6af895dd2770..0adc993c211d7a3901f9a0e9ee816e7fddc598cd 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -227,7 +227,7 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
>  
>  static void igmp_gq_start_timer(struct in_device *in_dev)
>  {
> -	int tv = get_random_u32_below(in_dev->mr_maxdelay);
> +	int tv = get_random_u32_below(READ_ONCE(in_dev->mr_maxdelay));

u32 tv? fix that type while at it.

>  	unsigned long exp = jiffies + tv + 2;
>  
>  	if (in_dev->mr_gq_running &&
> @@ -1009,7 +1009,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
>  		if (!max_delay)
>  			max_delay = 1;	/* can't mod w/ 0 */
> -		in_dev->mr_maxdelay = max_delay;
> +		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);

max_delay can also be u32; only scope creep with this patch set is
fixing up igmp_mod_timer to take u32.


>  
>  		/* RFC3376, 4.1.6. QRV and 4.1.7. QQIC, when the most recently
>  		 * received value was zero, use the default or statically

Reviewed-by: David Ahern <dsahern@kernel.org>


