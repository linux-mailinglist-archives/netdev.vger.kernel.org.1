Return-Path: <netdev+bounces-283292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKs0HXwR9WmTIAIAu9opvQ
	(envelope-from <netdev+bounces-283292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463B4AF928
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44AC33005A8B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494A35E929;
	Fri,  1 May 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Q+HcyuR3"
X-Original-To: netdev@vger.kernel.org
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33F13A258
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668473; cv=none; b=WKHnkKL8CROjly9qY2Ii577kVJkIid4jL9BfCTT+ApmVxbod9KqlebhMXpV9UbgkIgfucMRrVzvlsZnZm9/9vUPCinh+BAKGxSssMVWTfbQphuN8pgMDrIhpjLcxz++oT0yiIbA2NqVqCVA/LAaOfXgvUv9XZfj5HHx0k3l1Cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668473; c=relaxed/simple;
	bh=TRF8fYcONnVHsqExPz8C4knbfeRtaR0EMW0cFytgqBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGWMnaofEo0TAexOx/PkKjWDMQUAr8MA4E+Zv4RpDdcNsIF+eRn7293h7H0pJAru7O1hsdlbAFAClz5TU1OUcy8tvxMKGCN3MlpRtMv4P990ohNtj84Vt/cez7Vzp7r4rf+gSX4L7e8NbzAug4ccjih8yG9wwTl4T4/uLIN8qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Q+HcyuR3; arc=none smtp.client-ip=81.19.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ii3eHhzkLI+6nKE4urymVZnvYkYeIzlV9G6N13Nz3OE=; b=Q+HcyuR3ZfqpcBvY+UKekE2NVx
	r/fgS33NxxaIhLzvs/NBNDGh4C8YGgCsavU7F32gFFezRQGYDeTLENHlfZ0LU2KsT6B8iG113hP6O
	ZJlgB03f7Y/vXaLawwP1t2bqbqsbwHi1aFrCYNOAjrGpGpRQP3BuDi8V3NEBicwwf+0E=;
Received: from [188.22.4.84] (helo=[10.0.0.160])
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1wIuQz-0000000055u-11e0;
	Fri, 01 May 2026 22:26:01 +0200
Message-ID: <1c81fd5a-1699-408d-a7ca-f08a13764186@engleder-embedded.com>
Date: Fri, 1 May 2026 22:25:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/3] net: introduce helper to resolve hardware
 timestamps from skb
To: Kohei Enju <kohei@enjuk.jp>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-2-kohei@enjuk.jp>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20260429091632.26509-2-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Rspamd-Queue-Id: 1463B4AF928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[engleder-embedded.com:s=dkim11];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[engleder-embedded.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283292-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.778];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerhard@engleder-embedded.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[engleder-embedded.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,engleder-embedded.com:mid]

On 29.04.26 11:16, Kohei Enju wrote:
> Move the logic that resolves a hardware timestamp from an skb, including
> late timestamp resolution via netdev_get_tstamp(), from net/socket.c to
> a common helper.
> 
> Let's allow other networking code to reuse the same resolution path.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   include/linux/skbuff.h | 11 +++++++++++
>   net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
>   net/socket.c           | 27 +++------------------------
>   3 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b..651a5ae8b11c 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4731,6 +4731,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
>   void skb_tstamp_tx(struct sk_buff *orig_skb,
>   		   struct skb_shared_hwtstamps *hwtstamps);
>   
> +/**
> + * skb_get_hwtstamp - resolve a hardware timestamp from an skb
> + * @skb:	skb carrying the timestamp
> + * @cycles:	true to request the free-running cycle-based timestamp
> + * @if_index:	optional return pointer for the originating netdev ifindex
> + *
> + * Return: resolved hardware timestamp, or the stored skb hwtstamp when no
> + * device-specific late timestamp resolution is needed.
> + */
> +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index);
> +
>   /**
>    * skb_tx_timestamp() - Driver hook for transmit timestamping
>    *
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7dad68e3b518..d11f4e2e9391 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5729,6 +5729,33 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>   }
>   EXPORT_SYMBOL_GPL(skb_tstamp_tx);
>   
> +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> +	struct net_device *orig_dev;
> +	ktime_t hwtstamp;
> +
> +	if (if_index)
> +		*if_index = 0;

if_index is set to 0 here the second time when called from
__sock_recv_timestamp(). IMO you can remove these two
lines, because in skb_get_tx_timestamp() if_index has been
removed by your commit.

> +
> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV))
> +		return shhwtstamps->hwtstamp;
> +
> +	rcu_read_lock();
> +	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> +	if (orig_dev) {
> +		if (if_index)
> +			*if_index = orig_dev->ifindex;
> +		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> +	} else {
> +		hwtstamp = shhwtstamps->hwtstamp;
> +	}
> +	rcu_read_unlock();
> +
> +	return hwtstamp;
> +}
> +EXPORT_SYMBOL_GPL(skb_get_hwtstamp);
> +
>   #ifdef CONFIG_WIRELESS
>   void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
>   {
> diff --git a/net/socket.c b/net/socket.c
> index 22a412fdec07..95b21b16a0fc 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -876,21 +876,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
>   static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
>   {
>   	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
> -	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> -	struct net_device *orig_dev;
> -	ktime_t hwtstamp;
> -
> -	rcu_read_lock();
> -	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> -	if (orig_dev) {
> -		*if_index = orig_dev->ifindex;
> -		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> -	} else {
> -		hwtstamp = shhwtstamps->hwtstamp;
> -	}
> -	rcu_read_unlock();
> -
> -	return hwtstamp;
> +	return skb_get_hwtstamp(skb, cycles, if_index);
>   }
>   
>   static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
> @@ -940,7 +926,6 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
>   {
>   	u32 tsflags = READ_ONCE(sk->sk_tsflags);
>   	ktime_t hwtstamp;
> -	int if_index = 0;

if_index is useless in this function, so it can be removed.
This was introduced with 2410251cde0b. Maybe removing
if_index here could be a separate commit, as this clean up
makes sense on its own.

>   
>   	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
>   	    ktime_to_timespec64_cond(skb->tstamp, ts))
> @@ -950,10 +935,7 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
>   	    skb_is_swtx_tstamp(skb, false))
>   		return -ENOENT;
>   
> -	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> -		hwtstamp = get_timestamp(sk, skb, &if_index);
> -	else
> -		hwtstamp = skb_hwtstamps(skb)->hwtstamp;
> +	hwtstamp = get_timestamp(sk, skb, NULL);
>   
>   	if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
>   		hwtstamp = ptp_convert_timestamp(&hwtstamp,
> @@ -1033,10 +1015,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>   	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>   	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
>   		if_index = 0;
> -		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> -			hwtstamp = get_timestamp(sk, skb, &if_index);
> -		else
> -			hwtstamp = shhwtstamps->hwtstamp;
> +		hwtstamp = get_timestamp(sk, skb, &if_index);
>   
>   		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
>   			hwtstamp = ptp_convert_timestamp(&hwtstamp,

Gerhard

