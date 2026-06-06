Return-Path: <netdev+bounces-296029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbRDCx+CI2rqugEAu9opvQ
	(envelope-from <netdev+bounces-296029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FF64C32C
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:12:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L4I3lhKf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81F2B305459C
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFC2459DD;
	Sat,  6 Jun 2026 02:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449A23D7FF;
	Sat,  6 Jun 2026 02:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711865; cv=none; b=r+DaWjvm5eWLP7QVg96pT2UW7CAxD2oC5H+4YCdrrAQVDqzYeM+ivhA+DI1GLvquROGXgNoWK8mmX9Og/ve+GRGaJ7TmstyBRRvKNd116nFb7kMpCUKJMZ7OBlYZGcrWXZm90msHiaEY0d5trYCJBTZ7LX18qcDfisIJJJtPNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711865; c=relaxed/simple;
	bh=EQ0mIaWOwOiJUdytRZiw5SGt0/hRQVx6FLYuBRkvG6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D36nufxvnUyE1wDtWClkQc/1BCQX5BULs6tWttEmtmxr85q/+Q5S63UGh7fgDO0ztwE9XMoiVbt6I18AnAYQVBX+8UuR8niWvV8L9s5p9iXUZ03SOXjbdfRUmyI9FEHvFp+5UGEXUAtBSSlZhc3NroaGGgUIensF/Vwy/pRuNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4I3lhKf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25171F00893;
	Sat,  6 Jun 2026 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711864;
	bh=bkM1T8WvjdKeepkxoFveBwIsZkZytEQYIQkITGNKS40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4I3lhKf5CROggVA4J2+VjZrNowo3b8SSqzmXqPemq4UUO4CbdVB0dasuNCoib3uU
	 GenK6hiF+8M/8JgfI6cLu6UaBZEXa9eIRT/ey4T8yvFsoeHQtbNggeIth13FU+ShbS
	 YG70ormx+WfGXqCmZwuz2WsbXUcJeCXuN3ru06KsNWw9m4/O8bhVyYd26QFHvDy8DD
	 AaU2cjZHziVFNLMIYQa84EWIx6sfsNKcL8+tl7hfCBGthmG1TeH1t/zfwphWPCjAsq
	 G2W5ZCeOy6aYaa6Cu6O+wlsrXwcAloIhOlMJypWCcYU4IZ0UhR37KrhCKSoVd6bZCy
	 3Adqu31kKrmcA==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/12] dpaa2-switch: offload port objects on an upper bond device
Date: Fri,  5 Jun 2026 19:10:56 -0700
Message-ID: <20260606021056.4124819-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603143623.3712024-11-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-11-ioana.ciornei@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-296029-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 991FF64C32C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpaa2-switch: offload port objects on an upper bond device

This patch adds support for offloading port objects, VLANs and MDBs,
added on upper bond devices. It introduces switchdev_handle_*() replication
helpers for port objects and a refcount mechanism for handling MDBs in bond
devices.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index fadebf6a758d1..9aba5f348abc0 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2096,30 +2096,46 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
>  				     const struct switchdev_obj_port_mdb *mdb)
>  {
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct dpaa2_switch_lag *lag;
>  	int err;
>  
>  	/* Check if address is already set on this port */
>  	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
>  		return -EEXIST;

[Severity: High]
Does this incorrectly block valid MDB additions for the same MAC address but
different VLAN IDs?

Looking at dpaa2_switch_port_lookup_address(), it checks the VLAN-unaware
netdev->mc list. If an MDB with the same MAC but different VID is added,
it returns -EEXIST.

Later, if the user attempts to delete the un-added MDB,
dpaa2_switch_port_mdb_del() finds the MAC from the first MDB, skips hardware
removal due to VID mismatch, and successfully calls dev_mc_del(). 

When the legitimate MDB is later deleted, the lookup fails with -ENOENT,
skipping dpaa2_switch_lag_fdb_del() and permanently leaking the dynamically
allocated struct dpaa2_mac_addr and the hardware FDB entry.

[ ... ]

> @@ -2215,14 +2231,17 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
>  				     const struct switchdev_obj_port_mdb *mdb)
>  {
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct dpaa2_switch_lag *lag;
>  	int err;
>  
>  	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
>  		return -ENOENT;

[Severity: High]
Does returning an error here abort the switchdev_handle_port_obj_del()
replication loop for the remaining bond slaves?

This patch uses switchdev_handle_port_obj_del() to replicate object
deletions across all slave devices. If a driver callback returns an error
other than -EOPNOTSUPP on one of the slaves, the replication loop aborts,
skipping all remaining slaves.

For example, dpaa2_switch_port_mdb_del() returns -ENOENT if the MAC is not
found, and dpaa2_switch_port_vlans_del() propagates hardware deletion errors.

Will this leave the remaining slave ports with stale VLANs and MDBs fully
active in software and hardware, causing silent data leaks and inconsistent
state?

[ ... ]

> @@ -3128,37 +3154,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
>  	}
>  }
>  
> -static int dpaa2_switch_port_obj_event(unsigned long event,
[ ... ]
>  static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
>  					    unsigned long event, void *ptr)
>  {
>  	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
> +	int err;
>  
>  	switch (event) {
>  	case SWITCHDEV_PORT_OBJ_ADD:
> +		err = switchdev_handle_port_obj_add(dev, ptr,
> +						    dpaa2_switch_port_dev_check,
> +						    dpaa2_switch_port_obj_add);
> +		return notifier_from_errno(err);

[Severity: High]
Can this code leak memory and hardware MDBs when a slave leaves a bond?

When switchdev_handle_port_obj_add() replicates MDB additions across all
bond slaves, it increments the a->refcount in lag->fdbs for each slave. 

If a slave leaves the bond (e.g., via ip link set eth1 nomaster), shouldn't
dpaa2_switch_port_bond_leave() be updated to decrement the slave's share
of the MDB refcounts?

Without this, when the bond is later removed from the bridge,
SWITCHDEV_PORT_OBJ_DEL replicates only over the remaining slaves. The MDB
refcounts will not reach zero because the decrements from the departed
slaves are permanently lost. This would leak struct dpaa2_mac_addr memory
and leave the hardware MDB permanently programmed on the LAG.

