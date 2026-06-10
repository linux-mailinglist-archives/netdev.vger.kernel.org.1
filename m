Return-Path: <netdev+bounces-297739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5xAQLwGIKWpNYwMAu9opvQ
	(envelope-from <netdev+bounces-297739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B066B0AD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:51:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e5BEHXeZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297739-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B8D339AC98
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92040802D;
	Wed, 10 Jun 2026 15:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FD40DFA3;
	Wed, 10 Jun 2026 15:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106000; cv=none; b=oCsfvmG4nQebF4Ikx8E+fFtA0pwo47GBuw81BnKBXKy8ypFtVRooZuewnyR24Ji+dXUgh3CuWKAH3Ns1C3bx2z0NhNefVZkCKE1mlWA6grwKyv4fUtrXEqOLGZ4A7Z5GrZ/IGxJ/02EouZ8ljThYK9XRqpnQOTspekT5fOf/6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106000; c=relaxed/simple;
	bh=Bmh15MS0dApLq7ubfQP9NwtnSZhaysxdLdEXK+WWqV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG9f/DYoEmSPqkRLsp/pdwB+1oUQNIxcxymZcAMizcUQmPlhrvyD6gJavNuV8UQp/butAFynDMaa9on0O45Kti3L5eez1tYR+BTcElZIWjsxJq/tzT3fg89jn1Oz8DpLY5XOopLigdGGgZk7E68V2ZFTnVl3algeoTQPlinuUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5BEHXeZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222FA1F00893;
	Wed, 10 Jun 2026 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105998;
	bh=8ZbANrE8GbdMPDxfDHruVYL7zrqC8/DtyEufGV4lLNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5BEHXeZOORN+DQPKhYs9rE+nUfdgo9T01IPosTYH9pIiYRk1m08cFBMM8JxlBL0Z
	 s5V+1T4lqGv6S+OczxfjQwFwHzgRd+uZX0IkFDxpxrB95YbPMmGm8RefMHsBTnDJ+6
	 xmNzaYXHSszQtg49BQmlLQgv80Wpew6GtNsDSzrpRS7SNb0X+cNhDnMOnaTIhnvGl4
	 zggCG9ioEveoqeCJdklOwEGBZyuqo8Tj4KM4nIyqFI3lcVR53b634FGVA0aMMZt4Yn
	 zja56u7ZEtmjAtTQqgB8q1X5/Gv/YsNLLb3DIVIMph8IOWwpXG7BAm+H78FUoDZix8
	 iXWYe+ndQMaow==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	marex@denx.de,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	Woojung.Huh@microchip.com,
	devicetree@vger.kernel.org,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 4/5] net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
Date: Wed, 10 Jun 2026 08:39:55 -0700
Message-ID: <20260610153955.1685913-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ks8995-to-ksz8-v6-4-d91eb43edcc5@kernel.org>
References: <20260608-ks8995-to-ksz8-v6-4-d91eb43edcc5@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:kuba@kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:nb@tipi-net.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,denx.de,armlinux.org.uk,vger.kernel.org,tipi-net.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 205B066B0AD

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This patch adds support for the Microchip KSZ8995XA (a.k.a. Micrel
KS8995XA) switch to the KSZ DSA driver, introducing a new chip entry, a
restricted dev_ops/switch_ops set, and a ksz_is_ksz8995xa() helper for
future KSZ8995E/MA differentiation.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 0f84b2e7d25d..0b02588e22fc 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -137,7 +138,18 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
>  
>  static int ksz8_reset_switch(struct ksz_device *dev)
>  {
> -	if (ksz_is_ksz88x3(dev)) {
> +	if (ksz_is_ksz8995xa(dev)) {
> +		unsigned int port;
> +
> +		/* KSZ8995XA is "reset" by stopping the switch and starting it */
> +		ksz_cfg(dev, REG_SW_ID_1, SW_START_SWITCH, false);
> +		usleep_range(10, 100);
> +		ksz_cfg(dev, REG_SW_ID_1, SW_START_SWITCH, true);

[Medium]
For KSZ8995XA, ksz8_reset_switch() asserts SW_START_SWITCH before
ksz8_setup() programs broadcast storm rate, REG_SW_CTRL_2,
REG_SW_CTRL_9 SW_SPECIAL_TAG, port-membership and the
PORT_INSERT_TAG/PORT_REMOVE_TAG bits. Other variants in this same file
(for example ksz88x3) keep the forwarding engine quiescent during
configuration and only assert SW_START at the end of ksz8_setup() via:

    regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
                       SW_START, SW_START);

For KSZ8995XA, ksz8995xa_regs has [S_START_CTRL] = 0x01, the same
register written here, so by the time ksz8_setup() reaches its final
"start switch" step the engine has been forwarding throughout the
reconfiguration window. Is that intentional? Could the switch be left
stopped here and only started at the end of ksz8_setup() like the
other variants?

> +
> +		/* Often boot loaders have fun with ports, so reset them */
> +		for (port = 0; port < dev->info->port_cnt; port++)
> +			ksz_port_cfg(dev, port, 0x0f, BIT(4), true);

[Medium]
This writes BIT(4) at port-relative offset 0x0F once per port and
never clears it, with no readback or settling delay before the rest of
the setup proceeds to read/write port registers. If that bit is a
level-triggered reset, every port is left held in reset; if it is
self-clearing or a feature bit, the code happens to work.

The KSZ8863 path in this same function explicitly clears its reset
bit:

    ksz_cfg(dev, KSZ8863_REG_SW_RESET,
            KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
    ksz_cfg(dev, KSZ8863_REG_SW_RESET,
            KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, false);

and the KSZ87xx path uses an explicit power-down/power-up pair. Could
this code use named macros in ksz8_reg.h (matching the other named
constants added in this patch like SW_SPECIAL_TAG, SW_START_SWITCH,
PORT_INSERT_TAG, PORT_REMOVE_TAG) and document whether the bit is
self-clearing or whether a paired clear is needed?

> +	} else if (ksz_is_ksz88x3(dev)) {
>  		/* reset switch */
>  		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
>  			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);

[ ... ]

> @@ -1693,14 +1729,16 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  		offset = P1CR1;
>  	ksz_port_cfg(dev, port, offset, PORT_BROADCAST_STORM, true);
>  
> -	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
> +	if (!ksz_is_ksz8995xa(dev)) {
> +		ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);

[Medium]
ksz_chip_data for KSZ8995XA sets .num_tx_queues = 4, and ksz8_setup()
unconditionally does:

    ds->num_tx_queues = dev->info->num_tx_queues;

But ksz8_port_setup() now skips ksz8_port_queue_split() for
KSZ8995XA, so the chip's queue-split hardware registers are left at
their power-on default while DSA is told there are 4 TX queues. If the
default is not a 4-queue split, classification decisions made by the
stack (priority/PCP/DSCP-to-queue mapping) will not correspond to the
queues the hardware actually uses.

Should .num_tx_queues reflect the actual default for this chip, or
should the queue-split registers be programmed?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 57c8abfe0147..ac27beb3054b 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1485,6 +1499,21 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.internal_phy = {true, true, true, true, false},
>  	},
>  
> +	[KSZ8995XA] = {
> +		.chip_id = KSZ8995XA_CHIP_ID, /* Also known as KS8995XA */
> +		.dev_name = "KSZ8995XA",
> +		.cpu_ports = 0x10,	/* can be configured as cpu port */
> +		.port_cnt = 5,		/* total cpu and user ports */
> +		.num_tx_queues = 4,
> +		.num_ipms = 4,
> +		.ops = &ksz8995xa_dev_ops,
> +		.switch_ops = &ksz8995xa_switch_ops,
> +		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
> +		.regs = ksz8995xa_regs,
> +		.supports_mii = {true, true, true, true, true},
> +		.internal_phy = {true, true, true, true, false},
> +	},

[Low]
The KSZ8995XA chip data omits .num_vlans, .num_alus, and .num_statics,
so they default to 0. ksz8_setup() then unconditionally calls:

    dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
                                   dev->info->num_vlans, GFP_KERNEL);
    if (!dev->vlan_cache)
            return -ENOMEM;

devm_kcalloc with n = 0 returns ZERO_SIZE_PTR, which is non-NULL and
therefore not caught by the !dev->vlan_cache check. Today every
dereference of vlan_cache is gated by !ksz_is_ksz8995xa(dev) or by the
absence of VLAN ops in ksz8995xa_switch_ops, so there is no crash, but
any future shared helper that touches vlan_cache without a chip-id
gate would dereference ZERO_SIZE_PTR.

Could the allocation be skipped for KSZ8995XA, or could .num_vlans be
set to a value that makes the !NULL check meaningful?

[ ... ]

> @@ -2826,6 +2855,10 @@ void ksz_init_mib_timer(struct ksz_device *dev)
>  {
>  	int i;
>  
> +	/* KSZ8995XA lacks MiB features */
> +	if (ksz_is_ksz8995xa(dev))
> +		return;
> +
>  	INIT_DELAYED_WORK(&dev->mib_read, ksz_mib_read_work);

[Low]
This early return skips INIT_DELAYED_WORK(&dev->mib_read, ...). The
patch then relies on the undocumented invariant that mib_read_interval
== 0 means dev->mib_read must not be touched.

ksz_suspend()/ksz_resume() in ksz_common.c call
cancel_delayed_work_sync(&dev->mib_read) and
schedule_delayed_work(&dev->mib_read, ...) without any chip-id gate.
ksz8995xa_switch_ops happens to omit .suspend/.resume today, so there
is no current crash, but any future addition of those ops or any other
unguarded user of dev->mib_read on this chip will operate on
uninitialised work_struct memory.

Would it be safer to call INIT_DELAYED_WORK unconditionally and only
skip the schedule for KSZ8995XA?

[ ... ]

> @@ -4662,6 +4700,10 @@ int ksz_switch_register(struct ksz_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Override ops with something simpler for this legacy chip */
> +	if (ksz_is_ksz8995xa(dev))
> +		dev->ds->ops = &ksz8995xa_switch_ops;
> +

[Low]
Is this assignment a no-op in the supported flow? ksz_switch_alloc()
has already set ds->ops = chip->switch_ops, and
ksz_switch_chips[KSZ8995XA].switch_ops is &ksz8995xa_switch_ops, so
the same pointer is being written back.

The comment "Override ops with something simpler for this legacy chip"
implies a transformation that does not actually occur, and no other
chip in the family does this. Could this hunk be dropped, or the
comment reworded to match what the code does?

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index b67038cf1bd0..661a82026e47 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -751,7 +752,13 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
>  static inline bool ksz_is_8895_family(struct ksz_device *dev)
>  {
>  	return dev->chip_id == KSZ8895_CHIP_ID ||
> -	       dev->chip_id == KSZ8864_CHIP_ID;
> +	       dev->chip_id == KSZ8864_CHIP_ID ||
> +	       dev->chip_id == KSZ8995XA_CHIP_ID;
>  }

[Low]
This silently expands ksz_is_8895_family() to include KSZ8995XA, which
through is_ksz8()/is_ksz88xx() classifies the new chip as an 8895
family member across ksz_dcb.c, ksz8.c and ksz_common.c.

Today every potentially-divergent path is explicitly gated by
ksz_is_ksz8995xa() opt-outs or by the dev->ds->ops override, but this
"opt in via family helper, then opt out via per-chip checks" pattern
is brittle: future helper-driven logic touching the 8895 family will
silently include KSZ8995XA, and comments such as "/* KSZ8864, KSZ8895
*/" in ksz88xx_get_tag_protocol/ksz88xx_connect_tag_protocol become
inaccurate.

The commit message also does not acknowledge this expansion or
explain why a feature-bit approach in ksz_chip_data was not used,
especially given that the KSZ8995E/MA variants are mentioned as
future work. Could the commit message cover this design choice, or
could the family classification be reconsidered?

