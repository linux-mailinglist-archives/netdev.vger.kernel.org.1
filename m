Return-Path: <netdev+bounces-306307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2pjLpvIT2pGoQIAu9opvQ
	(envelope-from <netdev+bounces-306307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51A73354B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:13:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306307-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4F8330045AD
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69743079D;
	Thu,  9 Jul 2026 16:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A23382E5;
	Thu,  9 Jul 2026 16:06:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613198; cv=none; b=pGHnf/tW4s3nLJHKUVTSL3QMa7xT0nxoCE2omeWTYg+7X+yCVzO/yVSYVShemEeS5awtzSzvpIoTKjcclntDvOTBkNQkRUXMBN0aIR+B2PsKvemitsNC7SnasKC3Uvbn2I3KWrT9Dk2wtNIrWLoeaAy+PNHHILwMNrnvH1RUVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613198; c=relaxed/simple;
	bh=pZLCgred6rdnvWnUkEvfxYrToRNIaeBDZSoHQYeKenY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdy6L5LcdcylxwWVLodWZgiXmzZK1GlAYuX2Xlo4CltkWm6cghyzSTFZM0lpTXVJd6L+rZ1gqdTKktVoG2jpob1/YNsPvaSmBLFnwtQmlSdO+0314FA5FrtIw5EJq/YbGPTbrAjnETGBQCG4qZXshhZSDCMvM0zvmMnEVo9XNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Date: Thu, 9 Jul 2026 18:06:09 +0200
From: Brett Sheffield <brett@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <ak_G8auk2xI8PtlM@karahi.librecast.net>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306307-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brett@librecast.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brett@librecast.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brettsheffield.com:url,vger.kernel.org:from_smtp,librecast.net:from_mime,librecast.net:url,librecast.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,karahi.librecast.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D51A73354B

On 2026-07-09 11:55, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> when a qdisc is present") did not show a relevant performance regression
> in my testing but on Brett Sheffield's librecast testbed it shows a
> significant performance drop in a IPv6 multicast testcase. The regression
> can be pinpointed when multiple iperf3 TCP threads are sending. For 8
> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
> the reason why this patch makes the qdisc backpressure behavior opt-in.
> 
> One option to accomplish the opt-in would be to set the default qdisc to
> noqueue at init. However this may also break userspace as users might
> have chosen a custom qdisc even though most of the qdiscs did nothing
> for tun/tap in the past due to missing backpressure...
> 
> This is the reason why in this patch, the flag IFF_BACKPRESSURE is
> introduced instead which is required to enable the backpressure logic.
> This means the stopping logic in tun_net_xmit() and the waking logic in
> __tun_wake_queue() are skipped if the flag is disabled. Setting
> IFF_BACKPRESSURE makes an attached qdisc effective by stopping the queue
> instead of tail-dropping when the internal ring is full.
> 
> To avoid a possible stall due to disabling IFF_BACKPRESSURE, the new
> helper tun_force_wake_queue() is implemented. The helper safely wakes the
> respective netdev queue and resets cons_cnt while the consumer_lock and
> the producer_lock of the ring are held. The helper is run in tun_attach()
> when a queue (re)attaches, in tun_set_iff() for attached tfiles, and
> in tun_queue_resize().
> 
> The documentation in tuntap.rst is updated accordingly.
> 
> Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
> Reported-by: Brett Sheffield <brett@librecast.net>
> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

Tested v3 patch applied to 7.2.0-rc2.  OK.

Tested-by: Brett A C Sheffield <bacs@librecast.net>

> ---
> V2 -> V3:
> - As suggested by MST: Clarify in tuntap.rst and the UAPI header what
>   enabling IFF_BACKPRESSURE opts into: an attached qdisc becomes effective
>   instead of the driver tail-dropping when the internal ring is full.
> - Avoid lines over 75 characters.
> - Update comment in tun_net_xmit() to include IFF_BACKPRESSURE.
> - Brett: Update in commit message that the referenced tests were TCP.
> 
> V1 -> V2:
> - Sashiko: Ensure detached queues are woken on re-attach by calling the
>   new tun_force_wake_queue() helper from tun_attach(), and reuse it
>   across the existing wake paths.
> - Specify the failing test case in the commit message.
> 
> V1: https://lore.kernel.org/netdev/20260704112058.95421-1-simon.schippers@tu-dortmund.de/T/#u
> V2: https://lore.kernel.org/netdev/20260706094242.115992-1-simon.schippers@tu-dortmund.de/T/#u
> 
>  Documentation/networking/tuntap.rst | 22 +++++++++++++
>  drivers/net/tun.c                   | 51 ++++++++++++++++++++---------
>  include/uapi/linux/if_tun.h         |  4 +++
>  tools/include/uapi/linux/if_tun.h   |  1 +
>  4 files changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..5921a924c2ae 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,28 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 qdisc backpressure
> +----------------------
> +
> +Starting with Linux 7.2, IFF_BACKPRESSURE can be set to enable qdisc
> +backpressure. Without it, TX drops occur when the internal ring buffer
> +is full, so any attached qdisc is effectively bypassed and applications
> +only learn about congestion through those drops.
> +
> +With it, the kernel stops instead, letting the qdisc hold and schedule
> +packets, so its AQM, shaping and fairness actually apply. This helps
> +protocols like TCP, which cut throughput in reaction to packet drops.
> +With IFF_BACKPRESSURE, drops then only occur as a rare race. Backpressure
> +requires a qdisc to be attached and has no effect with noqueue.
> +
> +The txqueuelen can be reduced alongside this flag to further shift
> +buffering into the qdisc and reduce bufferbloat, but comes at possible
> +performance cost.
> +
> +When running multiple network streams in parallel through a single
> +TUN/TAP queue, the flag may reduce performance due to the extra overhead
> +of the backpressure mechanism.
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ffbe6f13fb1f..5941e8f302ea 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_device *dev,
>  #define TUN_FASYNC	IFF_ATTACH_QUEUE
>  
>  #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
> -		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
> +		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
> +		      IFF_BACKPRESSURE)
>  
>  #define GOODCOPY_LEN 128
>  
> @@ -694,6 +695,20 @@ static void tun_detach_all(struct net_device *dev)
>  		module_put(THIS_MODULE);
>  }
>  
> +static void tun_force_wake_queue(struct tun_struct *tun,
> +				 struct tun_file *tfile)
> +{
> +	/* Ensure that the producer can not stop the
> +	 * queue concurrently by taking locks.
> +	 */
> +	spin_lock_bh(&tfile->tx_ring.consumer_lock);
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	netif_wake_subqueue(tun->dev, tfile->queue_index);
> +	tfile->cons_cnt = 0;
> +	spin_unlock(&tfile->tx_ring.producer_lock);
> +	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
> +}
> +
>  static int tun_attach(struct tun_struct *tun, struct file *file,
>  		      bool skip_filter, bool napi, bool napi_frags,
>  		      bool publish_tun)
> @@ -737,11 +752,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		goto out;
>  	}
>  
> -	spin_lock(&tfile->tx_ring.consumer_lock);
> -	tfile->cons_cnt = 0;
> -	spin_unlock(&tfile->tx_ring.consumer_lock);
>  	tfile->queue_index = tun->numqueues;
>  	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
> +	tun_force_wake_queue(tun, tfile);
>  
>  	if (tfile->detached) {
>  		/* Re-attach detached tfile, updating XDP queue_index */
> @@ -1077,7 +1090,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	spin_lock(&tfile->tx_ring.producer_lock);
>  	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> -	if (!qdisc_txq_has_no_queue(queue) &&
> +	if ((tun->flags & IFF_BACKPRESSURE) &&
> +	    !qdisc_txq_has_no_queue(queue) &&
>  	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
>  		netif_tx_stop_queue(queue);
>  		/* Paired with smp_mb() in __tun_wake_queue() */
> @@ -1088,8 +1102,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	spin_unlock(&tfile->tx_ring.producer_lock);
>  
>  	if (ret) {
> -		/* This should be a rare case if a qdisc is present, but
> -		 * can happen due to lltx.
> +		/* This should be a rare case if IFF_BACKPRESSURE is enabled and
> +		 * a qdisc is present, but can happen due to lltx.
>  		 * Since skb_tx_timestamp(), skb_orphan(),
>  		 * run_ebpf_filter() and pskb_trim() could have tinkered
>  		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> @@ -2151,8 +2165,12 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  static void __tun_wake_queue(struct tun_struct *tun,
>  			     struct tun_file *tfile, int consumed)
>  {
> -	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
> -						tfile->queue_index);
> +	struct netdev_queue *txq;
> +
> +	if (!(tun->flags & IFF_BACKPRESSURE))
> +		return;
> +
> +	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
>  
>  	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
>  	smp_mb();
> @@ -2764,7 +2782,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  	struct tun_struct *tun;
>  	struct tun_file *tfile = file->private_data;
>  	struct net_device *dev;
> -	int err;
> +	int err, i;
>  
>  	if (tfile->detached)
>  		return -EINVAL;
> @@ -2893,8 +2911,12 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  	/* Make sure persistent devices do not get stuck in
>  	 * xoff state.
>  	 */
> -	if (netif_running(tun->dev))
> -		netif_tx_wake_all_queues(tun->dev);
> +	if (netif_running(tun->dev)) {
> +		for (i = 0; i < tun->numqueues; i++) {
> +			tfile = rtnl_dereference(tun->tfiles[i]);
> +			tun_force_wake_queue(tun, tfile);
> +		}
> +	}
>  
>  	strscpy(ifr->ifr_name, tun->dev->name);
>  	return 0;
> @@ -3693,10 +3715,7 @@ static int tun_queue_resize(struct tun_struct *tun)
>  	if (!ret) {
>  		for (i = 0; i < tun->numqueues; i++) {
>  			tfile = rtnl_dereference(tun->tfiles[i]);
> -			spin_lock(&tfile->tx_ring.consumer_lock);
> -			netif_wake_subqueue(tun->dev, tfile->queue_index);
> -			tfile->cons_cnt = 0;
> -			spin_unlock(&tfile->tx_ring.consumer_lock);
> +			tun_force_wake_queue(tun, tfile);
>  		}
>  	}
>  
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 79d53c7a1ebd..a0ddc50a7534 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -69,6 +69,10 @@
>  #define IFF_NAPI_FRAGS	0x0020
>  /* Used in TUNSETIFF to bring up tun/tap without carrier */
>  #define IFF_NO_CARRIER	0x0040
> +/* Stop the queue instead of dropping when the internal ring is full, so an
> + * attached qdisc applies backpressure instead of being bypassed.
> + */
> +#define IFF_BACKPRESSURE	0x0080
>  #define IFF_NO_PI	0x1000
>  /* This flag has no real effect */
>  #define IFF_ONE_QUEUE	0x2000
> diff --git a/tools/include/uapi/linux/if_tun.h b/tools/include/uapi/linux/if_tun.h
> index 2ec07de1d73b..97b670f5bc0a 100644
> --- a/tools/include/uapi/linux/if_tun.h
> +++ b/tools/include/uapi/linux/if_tun.h
> @@ -67,6 +67,7 @@
>  #define IFF_TAP		0x0002
>  #define IFF_NAPI	0x0010
>  #define IFF_NAPI_FRAGS	0x0020
> +#define IFF_BACKPRESSURE	0x0080
>  #define IFF_NO_PI	0x1000
>  /* This flag has no real effect */
>  #define IFF_ONE_QUEUE	0x2000
> -- 
> 2.43.0
> 

-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

