Return-Path: <netdev+bounces-273003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGCsJlCFyWndygUAu9opvQ
	(envelope-from <netdev+bounces-273003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978B353E83
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C17306F7AD
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904A38551B;
	Sun, 29 Mar 2026 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erzw5uW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75537386C0F;
	Sun, 29 Mar 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814203; cv=none; b=uTRwtnyMeTAGwBZP/6uf2VmyBmeJP4hyglgS0dFM0XjwrSOa+bKAgiBIkz+hZfyjnqkOlc468/y+jzT8QKfY119R6pQN0G0TESUe89sFGrd/jdP2hb10MKvdcSMRui8tR0xf5m9z1Dl9OMOZm2c+fkwhwdeoqaxl6NBx3Z3NFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814203; c=relaxed/simple;
	bh=rzmuSdC783UdanWK5KRP7rxT8rboYecl70TfW8YAGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5bS7t4Drm+/8qRLGqK7rODsJ1Iv/uDU2X7cyXBQ4fmwrw94YepppuI5m1ETsO0D3+oRQwAFzeiUI0H21SRKaMJuHq6Y3eWXDg5HyxNq2k/j9CqbByD780VR4mFDF6wIrR/fH7OkkZDmbPFrlvE2v3l9Ed6TbuD9swD1Tlj6r7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erzw5uW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CDAC2BCB1;
	Sun, 29 Mar 2026 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814201;
	bh=rzmuSdC783UdanWK5KRP7rxT8rboYecl70TfW8YAGFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erzw5uW1zwami3pWq3vSKGV4s2VbQ2uOun4lwWhU2tPuihfwEXm7I3+ZvAIkdP7s2
	 MdM1wePQfVw5wfZHLu0uq5ZQcy1kP03FFg8BVkDl6wlBkdWj7gKsLB+UCG4+TKXaqc
	 FhuMULU1bWjM6Inc/pGDDnrdfo1A6zBPfO5gbfnkzxURWGsBslmvCSFB+UG9vs4zkF
	 II0ULuuMbK+jgM/iun8uX5c2OqNjR0V21ueUsXKJ7WzEZ6WaegNLsk7yO1r1o3eSCE
	 8MCvmOA0hoIbVfjR4BJkrG7xrF3r1E0qzm5yjL+7kHyuNbd72JcmX9UQ2GNWQwqBf0
	 ItPWiQV7NILaQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] net: dsa: lan9645x: add port statistics
Date: Sun, 29 Mar 2026 12:56:39 -0700
Message-ID: <20260329195639.2789284-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-9-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-9-f7504e3b0681@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-273003-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3978B353E83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add port statistics
    
Add statistics support for the port counters. Chip registers are 32 bit,
so this unit is responsible maintaining a 64bit software cache, and
updating it frequently to handle overflows in hardware.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 24a60f40f6b8..9a46c08dad59 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
[ ... ]
> @@ -262,6 +264,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  	if (!lan9645x->owq)
>  		return -ENOMEM;
>  
> +	err = lan9645x_stats_init(lan9645x);
> +	if (err) {
> +		dev_err(dev, "Failed to init stats.\n");
> +		goto owq_destroy;
> +	}
> +
[ ... ]
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> index 000000000000..3e82a859f173
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
[ ... ]
> +static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[] = {
> +	{ "rx_uc",              SCNT_RX_UC },
> +	{ "rx_cat_drop",        SCNT_RX_CAT_DROP },
[ ... ]
> +	{ "tx_uc",              SCNT_TX_UC },
> +	{ "tx_drop",            SCNT_TX_DROP },
[ ... ]
> +};

Is it necessary to duplicate standard networking statistics in the driver
private ethtool output?

The networking subsystem guidelines state that stats possessing a standard UAPI
representation, such as tx_dropped and rx_packets in struct rtnl_link_stats64,
should not be duplicated in the ethtool -S output.

Could these redundant strings be removed since the driver natively supports
them via lan9645x_stats_get_stats64?

[ ... ]
> +static const struct lan9645x_view_stats lan9645x_view_stat_cfgs[] = {
> +	[LAN9645X_STAT_PORTS] = {
> +		.name = "ports",
> +		.type = LAN9645X_STAT_PORTS,
> +		.layout = lan9645x_port_stats_layout,
> +		.num_cnts = ARRAY_SIZE(lan9645x_port_stats_layout),
> +		.num_indexes = NUM_PHYS_PORTS,
> +	},
> +};
[ ... ]
> +static u64 *lan9645x_stats_view_idx_update(struct lan9645x *lan9645x,
> +					   enum lan9645x_view_stat_type vtype,
> +					   int idx)
> +{
> +	struct lan9645x_stats *s = lan9645x->stats;
> +
> +	mutex_lock(&s->hw_lock);
> +	__lan9645x_stats_view_idx_update(lan9645x, vtype, idx);
> +	mutex_unlock(&s->hw_lock);
> +
> +	return STAT_COUNTERS(lan9645x, vtype, idx);
> +}

Does this code overflow the allocated buffer when called for the CPU port?

The stats buffer cnts is allocated using num_indexes, which is NUM_PHYS_PORTS
(9). This covers ports 0 to 8. However, the CPU port is defined as index 9
(CPU_PORT = 9).

When the DSA core invokes stat callbacks like get_ethtool_stats or get_stats64
for the CPU port, the idx argument is 9. While the helper
__lan9645x_stats_view_idx_update skips the hardware read for out-of-bounds
indices, lan9645x_stats_view_idx_update ignores that failure and returns the
result of STAT_COUNTERS(lan9645x, vtype, idx).

This computes a pointer past the end of the cnts array, which the callers then
blindly dereference, potentially leaking kernel memory or causing a crash. Can
bounds checking be added to the callers, or should the buffer be sized to
include the CPU port?

[ ... ]
> +void lan9645x_stats_get_ethtool_stats(struct lan9645x *lan9645x, int port,
> +				      u64 *data)
> +{
> +	struct lan9645x_stats *stats = lan9645x->stats;
> +	u64 *c;
> +	int i;
> +
> +	c = lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	spin_lock(&stats->sw_lock);
> +	for (i = 0; i < ARRAY_SIZE(lan9645x_port_ethtool_stats); i++)
> +		*data++ = c[lan9645x_port_ethtool_stats[i].idx];
> +	spin_unlock(&stats->sw_lock);
> +}
[ ... ]
> +/* Called in atomic context */
> +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> +				struct rtnl_link_stats64 *stats)
> +{
> +	struct lan9645x_stats *s = lan9645x->stats;
> +	u64 *c;
> +
> +	c = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	spin_lock(&s->sw_lock);

Can this code deadlock when a softirq interrupts a process holding the lock?

The sw_lock spinlock protects the 64-bit software stats counters. In
lan9645x_stats_get_stats64, which acts as the ndo_get_stats64 callback, this
lock is acquired using a plain spin_lock. The code comment notes this function
is called in atomic context (such as from NET_RX_SOFTIRQ via dev_get_stats).

Concurrently, process context paths like lan9645x_stats_get_ethtool_stats and
lan9645x_check_stats_work also acquire sw_lock using plain spin_lock. Because
plain spin_lock does not disable softirqs, if a softirq preempts the execution
on a CPU while process context holds sw_lock, the softirq will spin
indefinitely waiting for the lock.

Should the process-context acquisitions use spin_lock_bh instead?

[ ... ]
> +int lan9645x_stats_init(struct lan9645x *lan9645x)
> +{
> +	const struct lan9645x_view_stats *vs;
> +	struct lan9645x_stats *stats;
> +	int err, i;
> +
> +	lan9645x->stats = devm_kzalloc(lan9645x->dev, sizeof(*stats),
> +				       GFP_KERNEL);

Will this memory be leaked when the DSA switch unbinds and rebinds?

The lan9645x_stats_init function allocates lan9645x->stats, vstat->cnts, and
vstat->buf using devm_kzalloc and devm_kcalloc. This function is called from
lan9645x_setup, which is the DSA .setup callback.

The DSA tree lifecycle is independent of the platform device lifecycle. If the
master netdevice is unbound and bound again, the DSA switch's .teardown and
.setup callbacks will be invoked multiple times. Because .teardown cannot free
devres-managed memory, the memory tied to the platform device will be leaked
on every setup cycle until the switch's platform device itself is destroyed.

Could this use standard kzalloc allocations paired with kfree in teardown?

