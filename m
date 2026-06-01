Return-Path: <netdev+bounces-293803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAz0HDmhHWqncgkAu9opvQ
	(envelope-from <netdev+bounces-293803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5762168A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C777304CFF8
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB63D7A07;
	Mon,  1 Jun 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glpl6Jxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A23D7D6C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326320; cv=none; b=Nbl+9j4w0C+QJR6iRNLrMFY6U5pqRI3q20bZmxx7Y1/V1UlokcDqQYxvIdUworCY0br38WcYK7eMpZv9qxLEEUfwOaWGXKnynbOY8552rlvQWHyT3A3BQLEUYCUsjUhXtbF9NLQ2MIH3dgHdi8TmZ6Hd3iRcpoGV4TmWQA53tUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326320; c=relaxed/simple;
	bh=hjGi1bYWVcIw4nFyNE/NdK86XOltlIEf4AtMsIwzJ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q731t3ZlOs0AQs3XjpPthFOtbxYC31jhQPD5shA8OyVh7G3o0pAzNRurNYFwbVW86HnnbFj8HMYYBnMq8gjNrkQXli4bKRFhYbQ79yJ6WunNdH0lzOSbMyqSmhrCgKCbGA0JHBT/dWkEL0Wi/oYT7bwx+9LXsbpzJ2YYHKEov7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glpl6Jxl; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8423f52af13so959275b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780326318; x=1780931118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJXH/frbGPFYcHm97l2/nyQx8SakwdCyD7+o0ql7Pg4=;
        b=glpl6JxlmXwpfArHYg4T534koVrgFb4Q4LXhCcsD2+7Av5MfEx/JMgsnjornrzsR9P
         4+gurK20isYRfTvzXYNqfeyvih+e6ESAop0YNbtegrDY6p5LuDMjIqws2iLlN6R7wQhr
         3y2ElA25suUo7HrZ+V2nMS1L1S030m0LccEZ3ad4/4GWy69qh4HrYQ+2KFberH0OwAo5
         C93JsbBilojiQob5VUtd2emhdX5diwqNs5PdMJzqxsk3CV3jDYF35gcJ/asLny7JXYVB
         gRdXdV9a+d7Hi+IsPM1ubTUjYPeesUt2LRYblCXxHuuR04h94Hx+DcdlZ7NZHuH4vhnW
         kgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326318; x=1780931118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJXH/frbGPFYcHm97l2/nyQx8SakwdCyD7+o0ql7Pg4=;
        b=LvbPrRxRVrAtlMM3g/RM8dkSsncOTyJ3jNUUgPhr0OrIsQu7lJ1rgnLS/z+4ayxoYC
         bnRNvWGR5IisihR3dvTFH/ICtnyxzB/eMdFYdrSAMorqO5ywi8Uq7qdgMPDW60smdM/8
         ABWOwqa3TIg0Nx2OgrgY5ZAQlBgPTSrNf612pKLnVh9SWBsd1q6OA/zrXTD1va7PzaPM
         QDWu7SVkPD59IxzhgfYGJxjFO/Mb5lTII1eSwQZA2u9fUcxQttZgiHd/C/ptBfXu6Ukc
         2aEBYcPCmFeksbCtab3Qgoo0Al6ivYxwNI6PRg6oqBpeFAqVSmoDxN2bc75g7eWudCKb
         1ZAw==
X-Gm-Message-State: AOJu0YxBIJuNPBEkqnxRzp1Fv/IAhqkcO0N3zpqVGJMsr7BV8Ht/PbXG
	qbydOYpCDVuxcSbtkz5RyNEggPZvBvaNvHtQhcaE5UlD5zd6zkdx5ie6
X-Gm-Gg: Acq92OGT3332CSjOKSqMcf13rll4ZDFiSbxBB/8UKtR7gXdGZAbED3Z9TT0eywru8cB
	BW+0eAE5B3g2uZnTkxztZtbnsIbn0CciUMzQ823yKmf675OJV58SPXb5M7i/BuVjSlPm+sZYOmp
	Q9K0VZ1jni6TcA1DwQF1Kxi5Gx7mkQTOugEK5fDbcTzo3OY7gLQ3FBNklF+RqAFAZT3TFdmnVSO
	obwxPiiYwZiiGQaB7WvcILo2/TbaTI93OPUYcHatErgwMGA9U3sHOccJsZ8eJWLZ3CNI6ZSh2Ec
	6ndsCJQQcg9BFTCmkBjIr2vzBoN8o7pvwheRqcps3r1QVrKt2h74IccqDTrnJVW/Q8nbo0yWJ/y
	Nvs6pg6ofKTNDTkIqV1VyozoYL1Rc5puEyoq0ljC45KIvmdaDFZJ8t2SFH+GQrKjNxtaLuFgCO5
	N5G9JrWdJay36H/XQ4Xa8v+tM7MAg=
X-Received: by 2002:a05:6a00:3317:b0:83e:d996:92fa with SMTP id d2e1a72fcca58-8422535d027mr10076090b3a.11.1780326318015;
        Mon, 01 Jun 2026 08:05:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423aeff467sm5900109b3a.25.2026.06.01.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:05:17 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:05:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] net: add retry mechanism to
 ndo_set_rx_mode_async
Message-ID: <ah2ebGBcjFg-6qeR@devvm7509.cco0.facebook.com>
References: <20260527014117.1401809-1-sdf@fomichev.me>
 <20260527014117.1401809-3-sdf@fomichev.me>
 <20260528172950.0773d48f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528172950.0773d48f@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCF5762168A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/28, Jakub Kicinski wrote:
> On Tue, 26 May 2026 18:41:16 -0700 Stanislav Fomichev wrote:
> > When ndo_set_rx_mode_async returns an error, schedule a retry with
> > exponential backoff (1s, 2s, 4s, 8s — 15s total). Give up after the
> 
> Em-dash detected. Issuing a brown bag and initiating shaming procedures.

The badge of honor of an ai-native engineer! 8-)

> > 4th retry and log an error via netdev_err().
> > 
> > This moves retry logic from individual drivers into the core stack.
> 
> 
> > @@ -2327,6 +2329,8 @@ struct net_device {
> >  	struct list_head	rx_mode_node;
> >  	netdevice_tracker	rx_mode_tracker;
> >  	struct netdev_hw_addr_list	rx_mode_addr_cache;
> > +	struct delayed_work	rx_mode_retry_work;
> 
> Either replace the existing work or only add a timer?
> Having two work structs feels odd.

Will try to switch to the timer.

> > +	unsigned long		rx_mode_retry_delay;
> 
> int should be plenty bits for this.
> Actually for clarity maybe it's better to keep a counter here?
> easy enough to (base << dev->bla_retry_counter) at scheduling
> time and that way we don't have to remember what the init value
> should be. Retry counter resetting to 0 is quite obvious, and
> so is the cap value.

SGTM!

> >  #ifdef CONFIG_LOCKDEP
> >  	unsigned char		nested_level;
> >  #endif
> > @@ -5150,6 +5154,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
> >  
> >  /* Functions used for secondary unicast and multicast support */
> >  void dev_set_rx_mode(struct net_device *dev);
> > +void netif_rx_mode_schedule_retry(struct net_device *dev);
> >  int netif_set_promiscuity(struct net_device *dev, int inc);
> >  int dev_set_promiscuity(struct net_device *dev, int inc);
> >  int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 26ac8eb9b259..751d6b5c4e23 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1775,6 +1775,8 @@ static void __dev_close_many(struct list_head *head)
> >  		if (ops->ndo_stop)
> >  			ops->ndo_stop(dev);
> >  
> > +		netif_rx_mode_cancel_retry(dev);
> > +
> >  		netif_set_up(dev, false);
> >  		netpoll_poll_enable(dev);
> >  	}
> > @@ -11720,6 +11722,8 @@ void netdev_run_todo(void)
> >  			continue;
> >  		}
> >  
> > +		if (cancel_delayed_work_sync(&dev->rx_mode_retry_work))
> > +			dev_put(dev);
> 
> trackers required these days
> Perhaps you can avoid the reference if you use disable_.._sync() ?

Sure, will do! disable_.._sync seems like might work, but feels like
a bit less readable? Will spend some time on it..

> >  		netdev_lock(dev);
> >  		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
> >  		netdev_unlock(dev);
> > @@ -12100,8 +12104,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  #endif
> >  
> >  	mutex_init(&dev->lock);
> > -	INIT_LIST_HEAD(&dev->rx_mode_node);
> > -	__hw_addr_init(&dev->rx_mode_addr_cache);
> > +	netif_rx_mode_init(dev);
> >  
> >  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> >  	setup(dev);
> > diff --git a/net/core/dev.h b/net/core/dev.h
> > index 0cf24b8f5008..4352f39c8dfe 100644
> > --- a/net/core/dev.h
> > +++ b/net/core/dev.h
> > @@ -166,8 +166,10 @@ int dev_change_carrier(struct net_device *dev, bool new_carrier);
> >  
> >  void __dev_set_rx_mode(struct net_device *dev);
> >  int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify);
> > +void netif_rx_mode_init(struct net_device *dev);
> >  bool netif_rx_mode_clean(struct net_device *dev);
> >  void netif_rx_mode_sync(struct net_device *dev);
> > +void netif_rx_mode_cancel_retry(struct net_device *dev);
> >  
> >  void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
> >  			unsigned int gchanges, u32 portid,
> > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > index d73fcb0c6785..c02aa05c9975 100644
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> > @@ -23,6 +23,24 @@ static LIST_HEAD(rx_mode_list);
> >  static DEFINE_SPINLOCK(rx_mode_lock);
> >  static DECLARE_WORK(rx_mode_work, netdev_rx_mode_work);
> >  
> > +static void netif_rx_mode_queue(struct net_device *dev);
> 
> No fwd declarations please :/
> 
> > +static void netif_rx_mode_retry(struct work_struct *work)
> > +{
> > +	struct net_device *dev = container_of(work, struct net_device,
> > +					      rx_mode_retry_work.work);
> > +
> > +	netif_rx_mode_queue(dev);
> > +	dev_put(dev);
> > +}
> > +
> > +void netif_rx_mode_init(struct net_device *dev)
> > +{
> > +	INIT_LIST_HEAD(&dev->rx_mode_node);
> > +	__hw_addr_init(&dev->rx_mode_addr_cache);
> > +	INIT_DELAYED_WORK(&dev->rx_mode_retry_work, netif_rx_mode_retry);
> > +}
> > +
> >  /*
> >   * General list handling functions
> >   */
> > @@ -1252,6 +1270,35 @@ static int netif_uc_promisc_update(struct net_device *dev)
> >  	return 0;
> >  }
> >  
> > +void netif_rx_mode_schedule_retry(struct net_device *dev)
> > +{
> > +	unsigned long delay;
> > +
> > +	/* Total retry budget: 1+2+4+8 = 15 seconds. */
> 
> What is the value of this comment..?

Wanted to make it apparent somewhere in the code the total retry timeout.
Let me try to find a better place, maybe the counter in the struct.

