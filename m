Return-Path: <netdev+bounces-255548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPC0DiCUfml6awIAu9opvQ
	(envelope-from <netdev+bounces-255548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:45:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68FC465D
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189B9300EAAA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5536606F;
	Sat, 31 Jan 2026 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDXTuIol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716662F60A3;
	Sat, 31 Jan 2026 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903125; cv=none; b=MFc57UtnxObznLW6p53RS3drov2Djo0M5payWJlsoDkpvpiWSOdlMubJdMk5oQOxO97kBTGZ7cHSOua+UXnuDzA/uYq69r00wBqLAsdWeHff87ov658scucs080968X7eEmIzVzd65TCaH7gkxscK/jg6OSQJIL/69u4m0qgRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903125; c=relaxed/simple;
	bh=sPHv8uhGY7+4Qtg7+z1Ar04DxRasKsX3aHG0i5up2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbvrfZLDCYwJbzSg4Clqh+c2VTedaOGKWdANHDcRGrVl0RIlNSd71cCGDwYsepG6C3A8ulnkpMYQwZV1BsjePjpkMvY9m0l0kTTcCT7YSYaId62mgKUviIVs6abd381geK+YCw2XRXdHa87str5NMXU3KFxnpLXSwHkCqbXDEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDXTuIol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB2C4CEF1;
	Sat, 31 Jan 2026 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769903125;
	bh=sPHv8uhGY7+4Qtg7+z1Ar04DxRasKsX3aHG0i5up2p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDXTuIolurArlYpC8A6X3YatXA7Bl9lb6JuXxdKfzfot0rDQ8ZOyGjzL2S0IaBNRT
	 nIIHLv9fRgB8awfG03HOJITyT2b3/4Xo8c+Uxb+otWqZBcUgdC0Vb0jgMmkR70iEQc
	 6wvLgQo+vDwXoEGUghKspG4oA/RNRzxepu58CvwmfLNu55keP/mAwNgwfc0nga/iGP
	 KIxTqiN6LQJ3cQdkeRqtK57rzTTICNfDx7HUy+n+/KvT/VzBKXw5Fb+0mEoCD1iV7I
	 nNaSIm3hvbd047JCjzjdMPkYhKPQsArJajAlvz8nt7Vju6P0MCkxjdFt8xzE5X0IRs
	 Kb9HDBrwwKBOw==
Date: Sat, 31 Jan 2026 15:45:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 02/16] net: Implement
 netdev_nl_queue_create_doit
Message-ID: <20260131154523.5e495380@kernel.org>
In-Reply-To: <20260129222830.439687-3-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F68FC465D
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:16 +0100 Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \

nit: please use "ynl --family netdev" instead of ./pyynl/cli.py
--spec...

> Note that the netdevice locking order is always from the virtual to
> the physical device.

There is a big comment in netdevice.h (search for "netdev-scope lock")
documenting the instance lock, since you are adding technical deb^w^w 
an ordering rule we should mention it there concisely and also update
the "netdev instance lock" section of netdevices.rst

> +	int	(*ndo_queue_create)(struct net_device *dev);

please propagate extack to the driver

>  	unsigned int supported_params;
>  };
> @@ -185,7 +191,9 @@ struct netdev_queue_mgmt_ops {
>  void netdev_queue_config(struct net_device *dev, int rxq,
>  			 struct netdev_queue_config *qcfg);
>  
> -bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> +bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx);
> +bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
> +bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);

The new function is internal to the core, please add the declarations
in the appropriate place in net/core/dev.h instead.

Coincidentally we should probably delete netif_rxq_has_unreadable_mp()
completely and pass the "has unreadable mp" as a flag inside qcfg
instead. I'll clean that up after your patches.

>  /**
>   * DOC: Lockless queue stopping / waking helpers.
> @@ -374,5 +382,10 @@ static inline unsigned int netif_xmit_timeout_ms(struct netdev_queue *txq)
>  	})
>  
>  struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
> -
> -#endif
> +bool netdev_can_create_queue(const struct net_device *dev,
> +			     struct netlink_ext_ack *extack);
> +bool netdev_can_lease_queue(const struct net_device *dev,
> +			    struct netlink_ext_ack *extack);
> +bool netdev_queue_busy(struct net_device *dev, int idx,
> +		       struct netlink_ext_ack *extack);

ditto. FWIW it's fine for ethtool to include using a relative path,
it already does that in a few places

> +#endif /* _LINUX_NET_QUEUES_H */
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index cfa72c485387..967bec9b3c6a 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -30,6 +30,8 @@ struct netdev_rx_queue {
>  	struct napi_struct		*napi;
>  	struct netdev_queue_config	qcfg;
>  	struct pp_memory_provider_params mp_params;

Could you add a comment here explaining whether this pointer is to 
or from the lease or both, depending whether the device is virt?

> +	struct netdev_rx_queue		*lease;
> +	netdevice_tracker		lease_tracker;
>  } ____cacheline_aligned_in_smp;
>  
>  /*
> @@ -59,5 +61,8 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  }
>  
>  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> -
> -#endif
> +void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
> +			   struct netdev_rx_queue *rxq_src);
> +void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
> +			     struct netdev_rx_queue *rxq_src);

dev.h

>  int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	const int qmaxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
> +	const int lmaxtype = ARRAY_SIZE(netdev_lease_nl_policy) - 1;
> +	int err, ifindex, ifindex_lease, queue_id, queue_id_lease;
> +	struct nlattr *qtb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +	struct nlattr *ltb[ARRAY_SIZE(netdev_lease_nl_policy)];
> +	struct netdev_rx_queue *rxq, *rxq_lease;
> +	struct net_device *dev, *dev_lease;
> +	netdevice_tracker dev_tracker;
> +	s32 netns_lease = -1;
> +	struct nlattr *nest;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_LEASE))
> +		return -EINVAL;
> +	if (nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]) !=
> +	    NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_QUEUE_TYPE]);
> +		return -EINVAL;
> +	}
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +
> +	nest = info->attrs[NETDEV_A_QUEUE_LEASE];
> +	err = nla_parse_nested(ltb, lmaxtype, nest,
> +			       netdev_lease_nl_policy, info->extack);
> +	if (err < 0)
> +		return err;
> +	if (NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_IFINDEX) ||
> +	    NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_QUEUE))
> +		return -EINVAL;
> +	if (ltb[NETDEV_A_LEASE_NETNS_ID]) {
> +		netns_lease = nla_get_s32(ltb[NETDEV_A_LEASE_NETNS_ID]);
> +		if (netns_lease < 0) {

Let's add this to the spec / policy then?

checks:
  min: 0

> +			NL_SET_BAD_ATTR(info->extack, ltb[NETDEV_A_LEASE_NETNS_ID]);
> +			return -EINVAL;
> +		}
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +	}
> +
> +	ifindex_lease = nla_get_u32(ltb[NETDEV_A_LEASE_IFINDEX]);
> +
> +	nest = ltb[NETDEV_A_LEASE_QUEUE];
> +	err = nla_parse_nested(qtb, qmaxtype, nest,
> +			       netdev_queue_id_nl_policy, info->extack);
> +	if (err < 0)
> +		return err;
> +	if (NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_ID) ||
> +	    NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_TYPE))
> +		return -EINVAL;
> +	if (nla_get_u32(qtb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_TYPE]);
> +		return -EINVAL;
> +	}
> +
> +	queue_id_lease = nla_get_u32(qtb[NETDEV_A_QUEUE_ID]);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	/* Locking order is always from the virtual to the physical device
> +	 * since this is also the same order when applications open the
> +	 * memory provider later on.
> +	 */
> +	dev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
> +	if (!dev) {
> +		err = -ENODEV;
> +		goto err_genlmsg_free;
> +	}
> +	if (!netdev_can_create_queue(dev, info->extack)) {
> +		err = -EINVAL;
> +		goto err_unlock_dev;
> +	}
> +
> +	net = genl_info_net(info);
> +	if (netns_lease >= 0) {
> +		net = get_net_ns_by_id(net, netns_lease);
> +		if (!net) {
> +			err = -ENONET;
> +			goto err_unlock_dev;
> +		}
> +	}
> +	if (net_eq(net, dev_net(dev)) &&
> +	    ifindex == ifindex_lease) {

Is this check actually needed? The device can't be physical and virtual
at once so the locking safety check would fail anyway, no?

> +		NL_SET_ERR_MSG(info->extack,
> +			"Lease ifindex cannot be the same as queue creation ifindex");
> +		err = -EINVAL;
> +		goto err_put_netns;
> +	}
> +
> +	dev_lease = netdev_get_by_index(net, ifindex_lease, &dev_tracker,
> +					GFP_KERNEL);
> +	if (!dev_lease) {
> +		err = -ENODEV;
> +		goto err_put_netns;
> +	}
> +	if (!netdev_can_lease_queue(dev_lease, info->extack)) {
> +		netdev_put(dev_lease, &dev_tracker);
> +		err = -EINVAL;
> +		goto err_put_netns;
> +	}
> +
> +	dev_lease = netdev_put_lock(dev_lease, &dev_tracker);
> +	if (!dev_lease) {
> +		err = -ENODEV;
> +		goto err_put_netns;
> +	}
> +	if (queue_id_lease >= dev_lease->real_num_rx_queues) {
> +		err = -ERANGE;
> +		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_ID]);
> +		goto err_unlock_dev_lease;
> +	}
> +	if (netdev_queue_busy(dev_lease, queue_id_lease, info->extack)) {
> +		err = -EBUSY;
> +		goto err_unlock_dev_lease;
> +	}
> +
> +	rxq_lease = __netif_get_rx_queue(dev_lease, queue_id_lease);
> +	rxq = __netif_get_rx_queue(dev, dev->real_num_rx_queues - 1);
> +
> +	if (rxq->lease && rxq->lease->dev != dev_lease) {

IIUC the simplification of having all leases from one devices is still
a netkit thing? I mean - there's nothing in the core that depends on
this, just the cleanup / notifier handling in netkit? If that's the
case let's move this check into netkit.

Sorry if you moved this here because I asked to move as much as
possible into the core.

> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Leasing multiple queues from different devices not supported");
> +		goto err_unlock_dev_lease;
> +	}
> +
> +	err = queue_id = dev->queue_mgmt_ops->ndo_queue_create(dev);
> +	if (err < 0) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Device is unable to create a new queue");

As flagged, if we pass extack to the driver it should be able to give us
a more accurate reason

> +		goto err_unlock_dev_lease;
> +	}
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	netdev_rx_queue_lease(rxq, rxq_lease);

nit: the call to __netif_get_rx_queue() could move into
netdev_rx_queue_lease()

> +	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	genlmsg_end(rsp, hdr);
> +
> +	netdev_unlock(dev_lease);
> +	netdev_unlock(dev);
> +	if (netns_lease >= 0)
> +		put_net(net);

