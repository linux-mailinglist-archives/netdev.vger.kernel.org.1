Return-Path: <netdev+bounces-299659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DNrlJFeNMGphUQUAu9opvQ
	(envelope-from <netdev+bounces-299659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982468A9BB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CyRu2n6w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299659-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE412303E2AB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A335DA75;
	Mon, 15 Jun 2026 23:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433B35CB6B;
	Mon, 15 Jun 2026 23:38:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566733; cv=none; b=c+IwAmdQt9b7NhMAaeAmMgRV00V8UXBTqHXMGkRaTdsVqhF840EO+6sj1QproyHaXZUKjO1eW+AowPaCf8acJ5QSvBjXozpALG10gMn+bPTP97nP12SOMi36pQIvmk9qYRl/fLnfhZF/qzkfkrEKN0F9ydfmrVe6125z2bodha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566733; c=relaxed/simple;
	bh=kO/yjEKOAlW0lqohuGdLgjbg2eM8chwNN+gP0WOvTw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZZLSfWF1td2xH7msc/0ZixzV31ZRUWbfnybb/eWHowTLGICjdbQuLHeXFNSc1s5P0H8U5Dcw7qGPTW5Dp+iTBqrTkWqwQb1QG/b4eCBE0XRy/7BgeJJCiaC9S6LmMohh3pAwCSmLsgPybZ65CckE2p2KSKErK7qkxQP7w5FbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyRu2n6w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9835D1F00A3A;
	Mon, 15 Jun 2026 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566732;
	bh=eS+NwR91Hkmm18M+nsKO2Y244NFaHIMfanAPyooegnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyRu2n6w+7LIYU32FnB97O2VbcDfLtYUvT1Mx/W7SsBhrIp+9kgODMcE4p5Pi4nC7
	 92Otwb1SE61Cf2XR6PDQUDPZtpKG5fd7KU3u4D7cWhRj8KonRyedUbuD6uNtCTael3
	 xhv4GPoNQahewJdkSeOryN+5oIrXREdJLZGBv7JSoiGojyG3nY6iDcSkaP4wBkdv7q
	 sylXtGG+I3iAK9Es4xkNn7d5bz9LIEKeU5rBcZfJ84vZxCfHq9AglCdwwbSE9iH8oa
	 zXMxsJX2nJanEcNxqVvuYaRVd0JHHtimfLyZj0KX0RJ09+A85tLHYJOapJadITygul
	 W8vrn9dy34gOg==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 7/9] net: sparx5: add L3 router infrastructure and leg management
Date: Mon, 15 Jun 2026 16:38:50 -0700
Message-ID: <20260615233850.1042323-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-7-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-7-fc3c10160f49@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jensemil.schulzostergaard@microchip.com,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0982468A9BB

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: sparx5: add L3 router infrastructure and leg management

This commit adds L3 router infrastructure and leg management to the
Microchip Sparx5 switch driver. It handles netdevice and inetaddr events
to intercept VLAN uppers of a bridge device, associating them with router
legs (VMIDs) for hardware offloading.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> new file mode 100644
> index 0000000000000..03923d91fdfb8
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c

[ ... ]

> +static void sparx5_rr_inet6_make_mask_le(int logmask, u8 *mask)
> +{
> +	/* Caller must ensure 0 <= logmask <= 128 */
> +	int rem, byte_prefix = logmask;
> +
> +	rem = do_div(byte_prefix, BITS_PER_BYTE);

[Severity: High]
Will this do_div() call cause a build failure or stack corruption?

The do_div() macro expects a 64-bit unsigned integer for the dividend. Passing
byte_prefix, which is a 32-bit int, causes a compiler error on architectures
like x86. On architectures like ARM, it can overwrite stack memory since the
macro assumes the pointer points to a 64-bit value.

Could byte_prefix be defined as a u64, or could this use a standard division
operation instead?

[ ... ]

> +static bool
> +sparx5_rr_router_leg_addr_list_empty_rcu(struct sparx5_rr_router_leg *leg)
> +{
> +	struct inet6_dev *inet6_dev;
> +	struct in_device *in_dev;
> +
> +	in_dev = __in_dev_get_rcu(leg->dev);
> +	if (in_dev && in_dev->ifa_list)
> +		return false;

[Severity: Medium]
Does this code miss an RCU pointer annotation?

The ifa_list pointer in struct in_device is annotated with __rcu, so accessing
it directly violates RCU rules and can cause sparse warnings.

Could this be updated to use rcu_access_pointer() since it's just doing a
boolean check?

[ ... ]

> +/* Called in atomic context. */
> +static int sparx5_rr_inet6addr_event(struct notifier_block *nb,
> +				     unsigned long event, void *ptr)
> +{
> +	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
> +	struct sparx5_rr_inet6addr_event_work *work;
> +	struct net_device *dev = if6->idev->dev;
> +	struct sparx5_router *router;
> +
> +	if (event != NETDEV_DOWN)
> +		return NOTIFY_DONE;
> +
> +	work = kzalloc_obj(*work, GFP_ATOMIC);
> +	if (!work)
> +		return NOTIFY_BAD;

[Severity: High]
Does returning NOTIFY_BAD during a NETDEV_DOWN event illegally abort the atomic
notification chain?

The inet6addr_chain is an atomic notifier chain, so returning NOTIFY_BAD stops
chain traversal. Because NETDEV_DOWN is a post-action event indicating the
address has already been removed, halting the chain prevents subsequent
notifiers (e.g., routing tables, IPsec) from observing the removal. This
leaves stale state that can cause use-after-free or routing blackholes.

Should this driver log an error and return NOTIFY_DONE or NOTIFY_OK instead
if memory allocation fails?

[ ... ]

> +/* Called with RTNL. */
> +static int sparx5_rr_inetaddr_valid_event(struct notifier_block *nb,
> +					  unsigned long event, void *ptr)
> +{
> +	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
> +	struct net_device *dev = ivi->ivi_dev->dev;
> +	struct sparx5_router *router;
> +
> +	ASSERT_RTNL();
> +
> +	if (event != NETDEV_UP)
> +		return NOTIFY_DONE;
> +
> +	router = container_of(nb, struct sparx5_router, inetaddr_valid_nb);
> +
> +	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event);
> +}

[Severity: High]
Does allocating hardware resources in the validator chain cause a leak?

The driver allocates a hardware router leg (VMID) via
sparx5_rr_router_leg_create() and takes a netdev_hold reference during the
NETDEV_UP validation phase.

If a downstream validator rejects the address addition, or if the addition
natively fails, NETDEV_DOWN is never fired. Because there is no rollback hook
handling this failure, the VMID and net_device tracker reference are leaked. A
leaked reference permanently prevents the net_device from being unregistered,
hanging unregister_netdevice() in netdev_wait_allrefs().

[ ... ]

> +/* Called with RTNL. */
> +static int sparx5_rr_netdevice_event(struct notifier_block *nb,
> +				     unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	unsigned char mac[ETH_ALEN] __aligned(2);
> +	struct sparx5_router *router;
> +	struct sparx5 *sparx5;
> +
> +	ASSERT_RTNL();
> +
> +	router = container_of(nb, struct sparx5_router, netdevice_nb);
> +	sparx5 = router->sparx5;
> +
> +	/* Allow single bridge. Global router leg MAC tracks bridge mac. */
> +	if (!netif_is_bridge_master(dev))
> +		return NOTIFY_OK;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEADDR:
> +		ether_addr_copy(mac, dev->dev_addr);
> +		sparx5_rr_leg_base_mac_set(sparx5, mac);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

[Severity: High]
Does this notifier miss network namespace and offload ownership checks?

The netdevice and inetaddr notifiers process events globally. In
sparx5_rr_netdevice_event(), it only checks netif_is_bridge_master(dev). The
driver doesn't verify if the bridge actually contains Sparx5 physical ports or
if it is inside the target network namespace (init_net).

An unprivileged user inside a user or network namespace could create dummy
VLAN-aware bridges and change their MAC addresses or assign IPs. This would
trigger these global notifiers, causing the driver to program physical
hardware registers, overwrite the global router leg MAC, and exhaust the
finite 511 VMID slots, potentially leading to a denial of service.

