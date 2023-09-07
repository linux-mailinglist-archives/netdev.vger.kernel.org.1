Return-Path: <netdev+bounces-32485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56599797D52
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EC21C20B94
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39B1426E;
	Thu,  7 Sep 2023 20:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7814008
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 20:19:39 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADEA1
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 13:19:38 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6515d44b562so8370346d6.3
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694117977; x=1694722777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5qbxzNwBZdjLBCxSr+IDYuuDQoa4QRZ33zJOVLqRkBE=;
        b=Iv08RcBqTsx5AaKZy/5vTorc7JvKYg+nqUrDy1hkSA9N94llQj8A4zCTBFA7r/5sOU
         DaweUvgi31fJYh8E0YmtmhG6kGPSqGKEcLRYllAjFL9NPAWVvmx+/1BHS7q67KGMh4x0
         6Kl6LbXSxhGTptxBSGHm0lDkjecL+JQkjvd92AIAX96zBaz/n5aZpD1rLwdZ6fFS0yrD
         b/9Y2/6kB8S8Nn5Hb7mMPvhmmYI5JygW6H8Q1u2d1SKqUW4IM0c3Vc1++SWcaCae/L7K
         aTIADvzEHnghQ4CLxzLja0y0MZBvTS6GU6Sra8PwBR+4aZth2L9/IdHIvK3fjjs91gqu
         Su4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694117977; x=1694722777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qbxzNwBZdjLBCxSr+IDYuuDQoa4QRZ33zJOVLqRkBE=;
        b=C3WA7hG5Sy5dVnP/V+OgjR/RQOQw0BSPPA9a/tjLxwC8M84BqZ6zUHKKtFQo3uwvmm
         xpI5sb5jYAGb4aTF4W670BmkJC0aHFxo5suyMZ7Q7oV/mdQTM1VjUoPPYMMK1G5Jh7Ja
         SSrFXI33uynL2eg0ee8Ej6vwkgVNv0quFHSeCN50XFeHSkPKn8PC8u25jhajhX0mHfnu
         cmBtUtBtQX5/0B1ht6/Jn2dzJq4mCOiGxzDDIyzIUD7Ppl1d+E+ob+zij3MJNEW94Q/n
         e91uG+Wcab7zhNde0MVqQvRwM/FMSDdQBiQawTWSv6hSUXbvUmymb82Ejpx+jaJz8gYD
         F3zA==
X-Gm-Message-State: AOJu0YzdGkQOo4o9dYi++ac8ceugrAk93IqarrTn3GXJXSWuNo0O9KcU
	/4QWmDA7woFpr7vCh9GBnWU=
X-Google-Smtp-Source: AGHT+IGBX0hG+VcXgr08Ws9mySf4ayqwxCEdokZh8UVmNv7hnWg9fXFsRzGYuJgQG9be2hcQ67uJiA==
X-Received: by 2002:a0c:dd13:0:b0:631:f9ad:1d43 with SMTP id u19-20020a0cdd13000000b00631f9ad1d43mr315539qvk.14.1694117977387;
        Thu, 07 Sep 2023 13:19:37 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id p17-20020a0ce191000000b0064f4d3bc78csm69852qvl.61.2023.09.07.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 13:19:36 -0700 (PDT)
Date: Thu, 7 Sep 2023 16:19:35 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] pktgen: Introducing a parameter for
 non-shared skb testing
Message-ID: <ZPowVxHPwe+Dvn0i@d3>
References: <20230906103508.6789-1-liangchen.linux@gmail.com>
 <ZPj98UXjJdsEsVJQ@d3>
 <CAKhg4tL+stODiv8hG0YWmU8zCKR4CsDOEvv7XD-S9PMdas5i_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKhg4tL+stODiv8hG0YWmU8zCKR4CsDOEvv7XD-S9PMdas5i_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-07 11:54 +0800, Liang Chen wrote:
> On Thu, Sep 7, 2023 at 6:32 AM Benjamin Poirier
> <benjamin.poirier@gmail.com> wrote:
> >
> > On 2023-09-06 18:35 +0800, Liang Chen wrote:
> > > Currently, skbs generated by pktgen always have their reference count
> > > incremented before transmission, leading to two issues:
> > >   1. Only the code paths for shared skbs can be tested.
> > >   2. Skbs can only be released by pktgen.
> > > To enhance testing comprehensiveness, introducing the "skb_single_user"
> > > parameter, which allows skbs with a reference count of 1 to be
> > > transmitted. So we can test non-shared skbs and code paths where skbs
> > > are released within the network stack.
> >
> > If my understanding of the code is correct, pktgen operates in the same
> > way with parameter clone_skb = 0 and clone_skb = 1.
> >
> 
> Yeah. pktgen seems to treat user count of 2 as not shared, as long as
> the skb is not reused for burst or clone_skb. In that case the only
> thing left to do with the skb is to check if user count is
> decremented.
> 
> > clone_skb = 0 is already meant to work on devices that don't support
> > shared skbs (see IFF_TX_SKB_SHARING check in pktgen_if_write()). Instead
> > of introducing a new option for your purpose, how about changing
> > pktgen_xmit() to send "not shared" skbs when clone_skb == 0?
> >
> 
> Using clone_skb = 0 to enforce non-sharing makes sense to me. However,
> we are a bit concerned that such a change would affect existing users
> who have been assuming the current behavior.

I looked into it more and mode netif_receive only supports clone_skb = 0
and normally reuses the same skb all the time. In order to support
shared/non-shared, I think a new parameter is needed, indeed.

Here are some comments on the rest of the patch:

> ---
>  net/core/pktgen.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index f56b8d697014..8f48272b9d4b 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -423,6 +423,7 @@ struct pktgen_dev {
>  	__u32 skb_priority;	/* skb priority field */
>  	unsigned int burst;	/* number of duplicated packets to burst */
>  	int node;               /* Memory node */
> +	int skb_single_user;	/* allow single user skb for transmission */
>  
>  #ifdef CONFIG_XFRM
>  	__u8	ipsmode;		/* IPSEC mode (config) */
> @@ -1805,6 +1806,17 @@ static ssize_t pktgen_if_write(struct file *file,
>  		return count;
>  	}
>  
> +	if (!strcmp(name, "skb_single_user")) {
> +		len = num_arg(&user_buffer[i], 1, &value);
> +		if (len < 0)
> +			return len;
> +
> +		i += len;
> +		pkt_dev->skb_single_user = value;
> +		sprintf(pg_result, "OK: skb_single_user=%u", pkt_dev->skb_single_user);
> +		return count;
> +	}
> +

Since skb_single_user is a boolean, it seems that it should be a flag
(pkt_dev->flags), not a parameter.

Since "non shared" skbs don't really have a name, I would suggest to
avoid inventing a new name and instead call the flag "SHARED" and make
it on by default. So the user would unset the flag to enable the new
behavior.

This patch should also document the new option in 
Documentation/networking/pktgen.rst

>  	sprintf(pkt_dev->result, "No such parameter \"%s\"", name);
>  	return -EINVAL;
>  }
> @@ -3460,6 +3472,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		return;
>  	}
>  
> +	/* If clone_skb, burst, or count parameters are configured,
> +	 * it implies the need for skb reuse, hence single user skb
> +	 * transmission is not allowed.
> +	 */
> +	if (pkt_dev->skb_single_user && (pkt_dev->clone_skb ||
> +					 burst > 1 || pkt_dev->count))
> +		pkt_dev->skb_single_user = 0;
> +

count > 0 does not imply reuse. That restriction can be lifted.

Instead of silently disabling the option, how about adding these checks
to pktgen_if_write()? The "clone_skb" parameter works that way, for
example.

>  	/* If no skb or clone count exhausted then get new one */
>  	if (!pkt_dev->skb || (pkt_dev->last_ok &&
>  			      ++pkt_dev->clone_count >= pkt_dev->clone_skb)) {
> @@ -3483,7 +3503,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE) {
>  		skb = pkt_dev->skb;
>  		skb->protocol = eth_type_trans(skb, skb->dev);
> -		refcount_add(burst, &skb->users);
> +		if (!pkt_dev->skb_single_user)
> +			refcount_add(burst, &skb->users);
>  		local_bh_disable();
>  		do {
>  			ret = netif_receive_skb(skb);
> @@ -3491,6 +3512,12 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  				pkt_dev->errors++;
>  			pkt_dev->sofar++;
>  			pkt_dev->seq_num++;
> +
> +			if (pkt_dev->skb_single_user) {
> +				pkt_dev->skb = NULL;
> +				break;
> +			}
> +

The assignment can be moved out of the loop, with the other 'if' in the
previous hunk.

>  			if (refcount_read(&skb->users) != burst) {
>  				/* skb was queued by rps/rfs or taps,
>  				 * so cannot reuse this skb
> @@ -3509,7 +3536,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		goto out; /* Skips xmit_mode M_START_XMIT */
>  	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
>  		local_bh_disable();
> -		refcount_inc(&pkt_dev->skb->users);
> +		if (!pkt_dev->skb_single_user)
> +			refcount_inc(&pkt_dev->skb->users);
>  
>  		ret = dev_queue_xmit(pkt_dev->skb);
>  		switch (ret) {
> @@ -3517,6 +3545,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  			pkt_dev->sofar++;
>  			pkt_dev->seq_num++;
>  			pkt_dev->tx_bytes += pkt_dev->last_pkt_size;
> +			if (pkt_dev->skb_single_user)
> +				pkt_dev->skb = NULL;

>  			break;
>  		case NET_XMIT_DROP:
>  		case NET_XMIT_CN:

This code can lead to a use after free of pkt_dev->skb when
dev_queue_xmit() returns ex. NET_XMIT_DROP. The skb has been freed by
the stack but pkt_dev->skb is still set.

It can be triggered like this:
ip link add dummy0 up type dummy
tc qdisc add dev dummy0 clsact
tc filter add dev dummy0 egress matchall action drop
And then run pktgen on dummy0 with "skb_single_user 1" and "xmit_mode
queue_xmit"

