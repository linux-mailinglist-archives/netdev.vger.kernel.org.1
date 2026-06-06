Return-Path: <netdev+bounces-296028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URkNLA2CI2rmugEAu9opvQ
	(envelope-from <netdev+bounces-296028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2A64C324
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b2N8YgbA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296028-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04B1B303671F
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005D23D7FF;
	Sat,  6 Jun 2026 02:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891352459DD;
	Sat,  6 Jun 2026 02:10:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711859; cv=none; b=ftD8tjw7mKEZ8CBM0pzkai4i8FbqLMiD0cnsZhWHsX01i/T0mpmB6VTY0DethIqyg6NBl1ysjrdSrnF/koJoAYM63CYfLWVtSD+T/W4rNLJRXmxVWY+/Vr/ZqHFaDpA1d3sAAiY3aMLNVBVABL1bPYlye5dM5x0/yPRTPujZr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711859; c=relaxed/simple;
	bh=roqYpp8qjJnmFCSaEVZTkDI+Eq2MllkDNmxdg5JkkRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNhU1GZqGFhjRibZ41CB2eQyDShVrK2Jr0qBrGkGv9r9Z4ORZAHcnV3hytMCD6jg0p+TA6jX3GK6I5BH471QmqqityNSRqWrCCizrJsIp46LNiBbOZg4FdWWqNOKaSHE2dbiA2CYfX+wnvao7IRFUVd2R4pRp4haSk/8QvPqspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2N8YgbA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9846F1F00893;
	Sat,  6 Jun 2026 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711856;
	bh=tswmGQDb5Pqlaiu5DXXgTJ779hQC/SRtU+nbyBqTMic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2N8YgbAWHpWKi2jAZhNNeUE9ydDWjJz1BlC0lOmQGaaA5tdgMJ4TH0mDP/P4SHf6
	 s905fcFvXQJTAHF+J23WKcdWbS2RBCl0rDsKKQvkQvUTIgxO1k6hFsR8mohcCRkGnL
	 j9hk5c1jEajNvid53JJBH05ZsYcGApp2Uj9i9cLC5S3z3Niyj2B/B8woDlkliWRD5s
	 ILQ0TYh6TrTL/0Gbt7+O/ptNYNZQeIUWB/gkKXfuU3TZ6bri+kmNMfqdtPTDnnoLXt
	 X9iZkYIG9RPYJznWyi4HLXrEQg9PrG/r2/Md6xO6eykgLz8DODI62oJZuINM42zmLl
	 5h0pVXx6LXSRg==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/12] dpaa2-switch: offload FDBs added on an upper bond device
Date: Fri,  5 Jun 2026 19:10:54 -0700
Message-ID: <20260606021054.4124776-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603143623.3712024-10-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-10-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296028-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28A2A64C324

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpaa2-switch: offload FDBs added on an upper bond device

This patch adds support for offloading FDB entries added on upper bond
devices.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index fb754dae80697..fadebf6a758d1 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
[ ... ]
> @@ -616,6 +640,91 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
>  		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
>  }
>  
> +static struct dpaa2_mac_addr *
> +dpaa2_switch_mac_addr_find(struct list_head *addr_list,
> +			   const unsigned char *addr, u16 vid)
> +{
> +	struct dpaa2_mac_addr *a;
> +
> +	list_for_each_entry(a, addr_list, list)
> +		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
> +			return a;
> +
> +	return NULL;
> +}
> +
> +static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
> +				    const unsigned char *addr, u16 vid)
> +{
> +	struct ethsw_port_priv *port_priv;
> +	struct dpaa2_mac_addr *a;
> +	int err = 0;
> +
> +	mutex_lock(&lag->fdb_lock);
> +
> +	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
> +	if (a) {
> +		refcount_inc(&a->refcount);

[Severity: High]
If a port leaves the LAG, the fan-out for the FDB delete event will only
reach the remaining ports. Could this result in the refcount decrementing
fewer times than it incremented, preventing it from reaching zero and
permanently leaking the struct dpaa2_mac_addr?

> +		goto out;
> +	}
> +
> +	port_priv = dpaa2_switch_lag_get_primary(lag);

[Severity: High]
The FDB entry is programmed into hardware using this primary port's physical
interface ID. If this primary port leaves the LAG, is there a mechanism to
migrate the existing FDB entries to one of the remaining ports? Without
migration, could traffic be misrouted, and would subsequent deletions fail
because they target the new primary port's ID?

> +	if (!port_priv) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
[ ... ]
> @@ -2856,32 +2996,46 @@ struct ethsw_switchdev_event_work {
>  	struct work_struct work;
>  	struct switchdev_notifier_fdb_info fdb_info;
>  	struct net_device *dev;
> +	struct net_device *orig_dev;
>  	unsigned long event;
> +	u16 vid;
>  };
>  
>  static void dpaa2_switch_event_work(struct work_struct *work)
>  {
>  	struct ethsw_switchdev_event_work *switchdev_work =
>  		container_of(work, struct ethsw_switchdev_event_work, work);
> +	struct net_device *orig_dev = switchdev_work->orig_dev;
>  	struct net_device *dev = switchdev_work->dev;
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
>  	struct switchdev_notifier_fdb_info *fdb_info;
> +	struct dpaa2_switch_lag *lag;
>  	int err;
>  
>  	rtnl_lock();
>  	fdb_info = &switchdev_work->fdb_info;
> +	lag = rtnl_dereference(port_priv->lag);
>  
>  	switch (switchdev_work->event) {
>  	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> -		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
> -						fdb_info->addr);
> +		if (lag)
> +			err = dpaa2_switch_lag_fdb_add(lag, fdb_info->addr,
> +						       switchdev_work->vid);
> +		else
> +			err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
> +							fdb_info->addr);
>  		if (err)
>  			break;
>  		fdb_info->offloaded = true;
> -		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
> +		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, orig_dev,
>  					 &fdb_info->info, NULL);
>  		break;
>  	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> -		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
> +		if (lag)
> +			dpaa2_switch_lag_fdb_del(lag, fdb_info->addr,
> +						 switchdev_work->vid);
> +		else
> +			dpaa2_switch_port_fdb_del(port_priv, fdb_info->addr);

[Severity: High]
Is it possible for a port to be removed from a bond between the queuing of
this event and its execution? If port_priv->lag becomes NULL during this
window, the worker would route the deletion to the standalone path instead
of the LAG path. Could this bypass the LAG refcount decrement and leak the
MAC address?

>  		break;
>  	}
[ ... ]
> @@ -3903,8 +4073,10 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
>  	for (i = 0; i < DPAA2_SWITCH_RX_NUM_FQS; i++)
>  		netif_napi_del(&ethsw->fq[i].napi);
>  
> -	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
>  		dpaa2_switch_remove_port(ethsw, i);
> +		mutex_destroy(&ethsw->lags[i].fdb_lock);
> +	}

[Severity: High]
Are the dynamically allocated struct dpaa2_mac_addr entries in the lag->fdbs
list freed during driver teardown? It appears ethsw->lags is freed shortly
after this without iterating through the fdbs lists, which might cause a
memory leak of all active LAG FDB entries. Could this also happen if all
ports leave a LAG and it becomes unused, inheriting stale entries upon reuse?

>  
>  	kfree(ethsw->fdbs);
>  	kfree(ethsw->filter_blocks);

