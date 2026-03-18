Return-Path: <netdev+bounces-269052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEyxDI3CumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:19:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E012BE11C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2640730E7AD9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98E3DEAFC;
	Wed, 18 Mar 2026 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAtjlSky"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569C3DEACF;
	Wed, 18 Mar 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845599; cv=none; b=KeZtGzjNJcVsYeS5Zv/hhlRwLmb/R9S5rn9ibkFEvxJSfMVFwKZfBpn5VgFzj36h1Lq97a0bxLlJ1BSH/4K+UTs7OS+DAOL+AMN5L8MklbDC7p1zhbUbhzHTGYSYt17XFDNycgK/muPUKt+45Lt2jJxvAZl+iY4UGrGn+COrDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845599; c=relaxed/simple;
	bh=felRz9HjKIpiMojzCYck9P/yFifvYQCbmR4et9IJMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBYimGBsam8lvF67je/JcTUbZvnapqfcrMbp+tZtUAx9qTZS+ygzWjfzAnrg22awR0wbC7Yt0We5prFYWlEB2MKzhycwzU3s4C5XrXyELMRwwXhyV5vhmSRnhUzcD325xhgkRUZQwzAoGZgttCZNWzz1itXzS8Zg+yPKFT7+Ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAtjlSky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C1C19421;
	Wed, 18 Mar 2026 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845599;
	bh=felRz9HjKIpiMojzCYck9P/yFifvYQCbmR4et9IJMCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAtjlSkyrrMyzIBZ7N2NlRzPZBtw8remOkjH7r+8O59bkBW9qIQf+rzgbHGyeJBZK
	 0+T4qwG8pBLnqm5DlGljHViPzqML4ExtKFxOgILq0kFmbQ4uvSAukqpPijCffZKz5k
	 Y7SBwklP6pAK+QeUH6IaeFjQHqZO+bN3SRjdRExWC97ff3txc5AZ03kJMwY0a8UlDW
	 Od9QgSz11fcD99EJ8ap1pH+Sv8ZBKcHDb5mms12ptgEjzCziEJPXor9Pn/4l4lV15A
	 92QuVOu/VnAHsV+FpmWB25zl5ivwjGt0EdgLwJPp1oONsKUcmW0Oon4456rAUBshvk
	 SdVMgMdIqIi2w==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	robh@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	devicetree@vger.kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	chleroy@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,12/14] net: dsa: netc: add more basic functions support
Date: Wed, 18 Mar 2026 14:49:56 +0000
Message-ID: <20260318144954.1893193-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-13-wei.fang@nxp.com>
References: <20260316094152.1558671-13-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,nxp.com,vger.kernel.org,gmail.com,lists.linux.dev,google.com,davemloft.net,armlinux.org.uk,lunn.ch,lists.infradead.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-269052-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.949];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 39E012BE11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: add more basic functions support

This patch expands the NETC switch driver with several foundational
features, including FDB and MDB management, STP state handling, MTU
configuration, port setup/teardown, and host flooding support.
At this stage, the driver operates only in standalone port mode.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 884ee899fc89..fd952b507cbd 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -427,24 +658,57 @@ static int netc_setup(struct dsa_switch *ds)
>  	if (err)
>  		goto free_mdio_bus;
>
> +	INIT_HLIST_HEAD(&priv->fdb_list);
> +	mutex_init(&priv->fdbt_lock);
> +
>  	netc_switch_fixed_config(priv);
>
>  	/* default setting for ports */
>  	dsa_switch_for_each_available_port(dp, ds)
>  		netc_port_default_config(priv->ports[dp->index]);
>
> +	err = netc_add_standalone_vlan_entry(priv);
> +	if (err)
> +		goto free_ntmp_user;
> +
> +	err = netc_add_standalone_fdb_bcast_entry(priv);
> +	if (err)
> +		goto free_ntmp_user;
> +
>  	return 0;
>
> +free_ntmp_user:
> +	netc_free_ntmp_user(priv);
>  free_mdio_bus:
>  	netc_free_mdio_bus(priv);
>
>  	return err;
>  }

Does the error path handle the mutex properly?

In netc_setup(), the mutex is initialized with mutex_init(&priv->fdbt_lock).
If netc_add_standalone_vlan_entry() or netc_add_standalone_fdb_bcast_entry()
fails, the error path jumps to free_ntmp_user:

drivers/net/dsa/netc/netc_main.c:netc_setup() {
	...
	INIT_HLIST_HEAD(&priv->fdb_list);
	mutex_init(&priv->fdbt_lock);
	...
	err = netc_add_standalone_vlan_entry(priv);
	if (err)
		goto free_ntmp_user;

	err = netc_add_standalone_fdb_bcast_entry(priv);
	if (err)
		goto free_ntmp_user;

	return 0;

free_ntmp_user:
	netc_free_ntmp_user(priv);
free_mdio_bus:
	netc_free_mdio_bus(priv);

	return err;
}

But netc_free_ntmp_user() and netc_free_mdio_bus() don't call
mutex_destroy(&priv->fdbt_lock) to clean up the mutex.

Looking at the normal teardown path in netc_teardown(), it calls
netc_destroy_all_lists() which properly handles both the FDB list and
mutex cleanup:

drivers/net/dsa/netc/netc_main.c:netc_destroy_all_lists() {
	netc_destroy_fdb_list(priv);
	mutex_destroy(&priv->fdbt_lock);
}

drivers/net/dsa/netc/netc_main.c:netc_teardown() {
	struct netc_switch *priv = ds->priv;

	netc_destroy_all_lists(priv);
	netc_free_host_flood_rules(priv);
	netc_free_ntmp_user(priv);
	netc_free_mdio_bus(priv);
}

Should the error path in netc_setup() call netc_destroy_all_lists() before
calling netc_free_ntmp_user()?

> @@ -595,6 +859,261 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = val & IPBRR0_IP_REV;
>  }
>
> +static void netc_destroy_all_lists(struct netc_switch *priv)
> +{
> +	netc_destroy_fdb_list(priv);
> +	mutex_destroy(&priv->fdbt_lock);
> +}
> +
> +static void netc_free_host_flood_rules(struct netc_switch *priv)
> +{
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		struct netc_port *np = priv->ports[dp->index];
> +
> +		kfree(np->host_flood);
> +		np->host_flood = NULL;
> +	}
> +}

[Simon says: I think this is a false positive and the clean-up
 suggestion is not needed in tear down]

Does this properly clean up the hardware state?

netc_free_host_flood_rules() just frees the host_flood memory and sets
the pointer to NULL:

drivers/net/dsa/netc/netc_main.c:netc_free_host_flood_rules() {
	struct dsa_port *dp;

	dsa_switch_for_each_user_port(dp, priv->ds) {
		struct netc_port *np = priv->ports[dp->index];

		kfree(np->host_flood);
		np->host_flood = NULL;
	}
}

But it doesn't delete the hardware IPFT entry or disable the PIPFCR register.

Compare with netc_port_remove_host_flood() which performs complete cleanup:

drivers/net/dsa/netc/netc_main.c:netc_port_remove_host_flood() {
	struct netc_switch *priv = np->switch_priv;

	if (!np->host_flood)
		return;

	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
	kfree(np->host_flood);
	np->host_flood = NULL;
	np->uc = false;
	np->mc = false;
	/* Disable ingress port filter table lookup */
	netc_port_wr(np, NETC_PIPFCR, 0);
}

In netc_teardown(), netc_free_host_flood_rules() is called before
netc_free_ntmp_user(), so the NTMP command infrastructure is still
operational at that point.

Should netc_free_host_flood_rules() call netc_port_remove_host_flood(np)
for each user port instead of directly calling kfree()?

