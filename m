Return-Path: <netdev+bounces-282659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIXhGLjf8mmtvAEAu9opvQ
	(envelope-from <netdev+bounces-282659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FAA49D602
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8F76301BA48
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C111A6807;
	Thu, 30 Apr 2026 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="CWJPrFDl"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC23D76
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524662; cv=none; b=CCRzm6KwK/NCrZQw1Zn3bhEi3cCOsHbZgRH1wgb923BZNLDqVqoIfn4P49gAgRpdsJI2MigU/bKTdzVjZTi5DFWle+U4rB2IjS+4YirRRgF24wLkhJjbn3I5zG0hNysaATI+GldSIY/N0xMn2uhbzHQtHHvZ8N1jOkrsh92eYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524662; c=relaxed/simple;
	bh=iq6CSZYTiKKqbyc8F5UbD3NSGiJAmFaOf4CJvl+NaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnd+MczpZN+WnzqrNSuCEA4Gx35Fxyydfmt4UJ8CzIDSUR6ihJPsRu+q8DfiLmQNRxANM+mjY5rcvEZteonSZNMBst9jBe7dvx4iSWESxj2sw3AqkMnlH1yMmMbv9jzp7jiTsSFLbwvwWk1acDRtBFS02umGaF09jZvRMug33Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=CWJPrFDl; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63U4ot9J035305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 30 Apr 2026 13:50:57 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=H81XK4QYpi/JwTadWLTFz0nHm7i6ontMKrB10Pxtklo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777524658; v=1;
        b=CWJPrFDlr16BnRc6sh2HSIbssH4gQ1kWc2Nv7AHS6NLWs031Vmafu91oPwNFkIMS
         HONvnXXx+En7erQ/o4mhT4VWHlWt/WB7+5Qi0DcIlQfxWMbhHeW/RkGs66aGwScD
         JWN78Q80FvkqSxM8+VbLIpANdFESeHsJcUdkO6taCQXdw4Wibwf7h7JmvNKYeMCy
         RTwyiOpKbS/PWgJUMqB2Ti2YJ4KX9T3oV63KX/PGWZCDFcbyOYl1OsGAyDCsTQ70
         l9ZweV07QpCwHXmkBMGdcCrv4R0o9D/Zk8TADb6wUEXOEEL2b5lGq9GNkOjQC/NX
         xnIra8Vm39Y9s5POF5WbAw==
Date: Thu, 30 Apr 2026 13:50:55 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net v1 1/3] net: introduce helper to resolve hardware
 timestamps from skb
Message-ID: <afLew3MP3j_lIOxS@x1>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-2-kohei@enjuk.jp>
 <willemdebruijn.kernel.2d041a6261a02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2d041a6261a02@gmail.com>
X-Rspamd-Queue-Id: D3FAA49D602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282659-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 04/29 17:04, Willem de Bruijn wrote:
> Kohei Enju wrote:
> > Move the logic that resolves a hardware timestamp from an skb, including
> > late timestamp resolution via netdev_get_tstamp(), from net/socket.c to
> > a common helper.
> > 
> > Let's allow other networking code to reuse the same resolution path.
> > 
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> 
> Thanks for the fix series.
> 
> Fixes require a Fixes tag. See also https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html.
> 
> I suggest merging this and the second patch, as this is not a
> standalone fix, and the other is a one-line change.

Thank you for the suggestion, and it looks good to me.
I'll do so in v2.

> 
> > ---
> >  include/linux/skbuff.h | 11 +++++++++++
> >  net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
> >  net/socket.c           | 27 +++------------------------
> >  3 files changed, 41 insertions(+), 24 deletions(-)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 2bcf78a4de7b..651a5ae8b11c 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4731,6 +4731,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
> >  void skb_tstamp_tx(struct sk_buff *orig_skb,
> >  		   struct skb_shared_hwtstamps *hwtstamps);
> >  
> > +/**
> > + * skb_get_hwtstamp - resolve a hardware timestamp from an skb
> > + * @skb:	skb carrying the timestamp
> > + * @cycles:	true to request the free-running cycle-based timestamp
> > + * @if_index:	optional return pointer for the originating netdev ifindex
> > + *
> > + * Return: resolved hardware timestamp, or the stored skb hwtstamp when no
> > + * device-specific late timestamp resolution is needed.
> > + */
> > +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index);
> > +
> >  /**
> >   * skb_tx_timestamp() - Driver hook for transmit timestamping
> >   *
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7dad68e3b518..d11f4e2e9391 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5729,6 +5729,33 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
> >  }
> >  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
> >  
> > +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index)
> > +{
> > +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> > +	struct net_device *orig_dev;
> > +	ktime_t hwtstamp;
> > +
> > +	if (if_index)
> > +		*if_index = 0;
> > +
> > +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV))
> > +		return shhwtstamps->hwtstamp;
> > +
> > +	rcu_read_lock();
> > +	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> > +	if (orig_dev) {
> > +		if (if_index)
> > +			*if_index = orig_dev->ifindex;
> > +		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> > +	} else {
> > +		hwtstamp = shhwtstamps->hwtstamp;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return hwtstamp;
> > +}
> > +EXPORT_SYMBOL_GPL(skb_get_hwtstamp);
> > +
> >  #ifdef CONFIG_WIRELESS
> >  void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
> >  {
> > diff --git a/net/socket.c b/net/socket.c
> > index 22a412fdec07..95b21b16a0fc 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -876,21 +876,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
> >  static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
> >  {
> >  	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
> > -	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> > -	struct net_device *orig_dev;
> > -	ktime_t hwtstamp;
> > -
> > -	rcu_read_lock();
> > -	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> > -	if (orig_dev) {
> > -		*if_index = orig_dev->ifindex;
> > -		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> > -	} else {
> > -		hwtstamp = shhwtstamps->hwtstamp;
> > -	}
> > -	rcu_read_unlock();
> > -
> > -	return hwtstamp;
> > +	return skb_get_hwtstamp(skb, cycles, if_index);
> >  }
> 
> At this point simpler to remove get_timestamp entirely. It's an
> unnecessary layer of indirection.
> 
> Perhaps pass sk_tsflags rather than bool to skb_get_hwtstamp.

Good points. I'll rework this in v2.

Thanks,
Kohei

>   
> >  static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
> > @@ -940,7 +926,6 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
> >  {
> >  	u32 tsflags = READ_ONCE(sk->sk_tsflags);
> >  	ktime_t hwtstamp;
> > -	int if_index = 0;
> >  
> >  	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> >  	    ktime_to_timespec64_cond(skb->tstamp, ts))
> > @@ -950,10 +935,7 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
> >  	    skb_is_swtx_tstamp(skb, false))
> >  		return -ENOENT;
> >  
> > -	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> > -		hwtstamp = get_timestamp(sk, skb, &if_index);
> > -	else
> > -		hwtstamp = skb_hwtstamps(skb)->hwtstamp;
> > +	hwtstamp = get_timestamp(sk, skb, NULL);
> >  
> >  	if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
> >  		hwtstamp = ptp_convert_timestamp(&hwtstamp,
> > @@ -1033,10 +1015,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> >  	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
> >  	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
> >  		if_index = 0;
> > -		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> > -			hwtstamp = get_timestamp(sk, skb, &if_index);
> > -		else
> > -			hwtstamp = shhwtstamps->hwtstamp;
> > +		hwtstamp = get_timestamp(sk, skb, &if_index);
> >  
> >  		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
> >  			hwtstamp = ptp_convert_timestamp(&hwtstamp,
> > -- 
> > 2.53.0
> > 
> 
> 

