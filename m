Return-Path: <netdev+bounces-283023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MZjDqzs82kV8wEAu9opvQ
	(envelope-from <netdev+bounces-283023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:58:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D04A90CD
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8101A302F248
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9B3DBD63;
	Thu, 30 Apr 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTHYrutO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487C3D9DB3;
	Thu, 30 Apr 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593387; cv=none; b=j8Q+bTMT1YhA/V8MldkIqyLnBOln0cCIC8Q/qnnUSQW+HafFPNV/z0E5otVfsKfDj9Kwhaie6A/oGXvbItoUWvgaYSFtCbetK191q5PemlKOtRQBP0gk7HAB7/jiqLxMbLU0w+BC4vsgGOVH88sF2t1Ho/1sVu2SUPeXQfyWj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593387; c=relaxed/simple;
	bh=Xjt9d8An4SheLcIFTQP4r2cQFtRU13RlK74dYzrR/08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsehJ75Dt519NVQS9dQMKHEm66Idds6bBlGAf9HZaSJrkVpcaXkwYudr9nX0wZ/sqS1lYUTUwx5ig4SRQQeVLgDYUUFasT8l2EyNr2ssTb7+cRisvEuURLQmJISIuMPfHZe4xsCaAB0s6AXzaFZcKf8DvgWBTMwip4xktmowUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTHYrutO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52447C2BCB3;
	Thu, 30 Apr 2026 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777593386;
	bh=Xjt9d8An4SheLcIFTQP4r2cQFtRU13RlK74dYzrR/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTHYrutO3wEsiOdD/ieZwOG2d1+2Bpy+B5r+5Yan3tUfspfQxFQPo6eOiss3Icsfl
	 xfJ4YlI2DTKxAjqcNnTkFIApm2yhkGtTHKngkT0rYaTVkjk12Fc0B2JYJvOO+j9r/K
	 9QDzqCtzOVHHOg8RHsN4Nr1doF6dck5t73cMLjq3FhaYbpsa7n/r7UocVLr2H3kFwT
	 VDaZXX6FT5s4vDuGf2j5RLQA4DiXc7vuSf8J6o/SyT1nRxiUYEu7CveyRz5NGo68ks
	 byUduPkOM+7h+uPQfOXWYgXau0cqCSF02bvUVU83cjexXYprjpi2tZpN99qhQmw116
	 3WNVRnWgUhozQ==
From: Jakub Kicinski <kuba@kernel.org>
To: joey@tinyisr.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	andrew@lunn.ch,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: dsa: initial support for MT7628 embedded switch
Date: Thu, 30 Apr 2026 16:56:23 -0700
Message-ID: <20260430235623.3080104-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428185510.261521-5-joey@tinyisr.com>
References: <20260428185510.261521-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C33D04A90CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-283023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[0.0.0.5:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email says "Since Andrew requested some changes already here is the
AI review to look thru as well (could be false positives)."
---
net: dsa: initial support for MT7628 embedded switch

This patch adds a new DSA driver for the MT7628 embedded switch, with
five 100Mbps user ports, a 1Gbps CPU port, and a 16-entry VLAN table
that is used via tag_8021q for port isolation.

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> new file mode 100644
> index 000000000000..1ed99706e41d
> --- /dev/null
> +++ b/drivers/net/dsa/mt7628.c

[ ... ]

> +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +out:

Can these MDIO routines work after the first transaction?

Both mt7628_mii_read() and mt7628_mii_write() first poll for
MT7628_ESW_PCR1_RD_DONE / WT_DONE to be clear, then issue the PCR0
command, then poll for the done bit to become set.  Nothing in the driver
writes-to-clear these done bits.

After a successful read, MT7628_ESW_PCR1_RD_DONE is 1 (that is the loop's
exit condition).  On the next mt7628_mii_read() call the first poll waits
for it to become 0, which only happens if the hardware auto-clears the
done bit on a new PCR0 command write.

Is that hardware behavior documented?  Similar MediaTek DSA drivers
(mt7530/mt7531) do not precede the command with a wait-for-not-done poll.
If the bit does not self-clear on command issue, every MDIO transaction
after the first would spin for ~5ms and return -ETIMEDOUT.

> +	if (ret) {
> +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> +		return ret;
> +	}
> +	return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);
> +}

[ ... ]

> +static void mt7628_switch_init(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +
> +	regmap_write(esw->regmap, MT7628_ESW_REG_FCT0,

[ ... ]

> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_PFC1,
> +			   MT7628_ESW_PFC1_EN_VLAN,
> +			   FIELD_PREP(MT7628_ESW_PFC1_EN_VLAN,
> +				      MT7628_ESW_PORTS_ALL));
> +}

Should mt7628_switch_init() also initialize MT7628_ESW_REG_POC0's
PORT_DISABLE field to a known state?

DSA only invokes .port_enable / .port_disable for ports described in the
DT and brought up by the stack.  The CPU port and the non-existent port 5
are never touched, so they stay at the hardware reset default.  If the
default is enabled, traffic may be forwarded on ports the driver believes
are inactive; if disabled, the CPU port may never come up because
mt7628_port_enable() is only called for user ports.

Other DSA drivers (for example b53_common.c) explicitly set all port
enable bits to a known state in .setup() before letting per-port callbacks
modify them.  Is a similar initialization needed here?

[ ... ]

> +static void mt7628_vlan_sync(struct dsa_switch *ds)
> +{

[ ... ]

> +}
> +
> +static int mt7628_setup(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	int ret;
> +
> +	reset_control_reset(esw->rst_esw);
> +	usleep_range(1000, 2000);
> +	reset_control_reset(esw->rst_ephy);
> +	usleep_range(1000, 2000);
> +	/*
> +	 * all MMIO reads hang if esw is not out of reset
> +	 * ephy needs extra time to get out of reset or it ends up misconfigured
> +	 */
> +	mt7628_switch_init(ds);

Should the return values from reset_control_reset() be checked?

The comment in this function says "all MMIO reads hang if esw is not out
of reset".  reset_control_reset() can fail with -EBUSY, -ENOTSUPP and
similar (see drivers/reset/core.c), and on failure mt7628_switch_init()
proceeds to issue regmap writes/reads against a block still held in
reset, which by this comment hangs the CPU.

Can these return values be propagated from mt7628_setup()?

[ ... ]

> +static void mt7628_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	switch (port) {
> +	case 6:
> +		config->mac_capabilities |= MAC_1000;
> +		fallthrough;
> +	case 0 ... 4:
> +		config->mac_capabilities |= MAC_100 | MAC_10;
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	default:
> +		break;		/* port 5 does not exist on MT7628 */
> +	}
> +}

How is port 5 meant to be handled?

ds->num_ports is set to MT7628_ESW_NUM_PORTS (7), but this function
comments that port 5 does not exist on MT7628 and leaves its capabilities
empty.  DSA iterates 0..num_ports-1 in several generic paths (for
example the tag_8021q setup loop), and phylink setup on a port with
empty mac_capabilities and no supported_interfaces will warn.

The driver appears to rely on the DT never declaring a port@5 node.  Is
that implicit contract intentional, and should it be documented or
enforced (for example by rejecting a port@5 in probe)?

> +
> +static int mt7628_dsa_8021q_vlan_add(struct dsa_switch *ds, int port,
> +				     u16 vid, u16 flags)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct mt7628_vlan *vlan = NULL;
> +	int i;
> +
> +	for (i = 0; i < MT7628_NUM_VLANS; i++) {
> +		struct mt7628_vlan *check_vlan = &esw->vlans[i];
> +
> +		if (!check_vlan->active && !vlan) {
> +			vlan = check_vlan;
> +		} else if (check_vlan->vid == vid) {
> +			vlan = check_vlan;
> +			break;
> +		}
> +	}

Is the else-if branch here intentional for inactive slots?

mt7628_dsa_8021q_vlan_del() clears members, untag and active, but leaves
vlan->vid untouched:

	vlan->members &= ~BIT(port);
	vlan->untag &= ~BIT(port);

	if (!vlan->members)
		vlan->active = false;

An inactive slot that previously held the same VID will therefore match
via check_vlan->vid == vid and be reused.  For vid == 0 every pristine
zero-initialized slot also matches, making slot selection
non-deterministic.

tag_8021q currently composes non-zero VIDs (see DSA_8021Q_RSV in
net/dsa/tag_8021q.c), so vid == 0 is not reachable via tag_8021q today,
but the .tag_8021q_vlan_add API itself accepts any u16.  Would guarding
the match with check_vlan->active (or clearing vid on delete) make the
allocator more robust?

> +
> +	if (!vlan)
> +		return -ENOSPC;
> +
> +	vlan->vid = vid;
> +	vlan->active = true;
> +	vlan->members |= BIT(port);
> +
> +	if (flags & BRIDGE_VLAN_INFO_PVID)
> +		esw->tag_8021q_pvid[port] = vid;
> +
> +	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
> +		vlan->untag |= BIT(port);
> +
> +	mt7628_vlan_sync(ds);
> +	return 0;
> +}
> +
> +static int mt7628_dsa_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct mt7628_vlan *vlan = NULL;
> +	int i;
> +
> +	for (i = 0; i < MT7628_NUM_VLANS; i++) {
> +		struct mt7628_vlan *check_vlan = &esw->vlans[i];
> +
> +		if (!check_vlan->active || check_vlan->vid != vid)
> +			continue;
> +		vlan = check_vlan;
> +		break;
> +	}
> +	if (!vlan)
> +		return -ENOENT;
> +
> +	vlan->members &= ~BIT(port);
> +	vlan->untag &= ~BIT(port);
> +
> +	if (!vlan->members)
> +		vlan->active = false;
> +
> +	mt7628_vlan_sync(ds);
> +	return 0;
> +}

Should vlan_del also clear esw->tag_8021q_pvid[port] when the VID being
deleted is the port's current PVID?

mt7628_vlan_sync() unconditionally programs esw->tag_8021q_pvid[port]
into MT7628_ESW_REG_PVIDC for every port:

	for (i = 0; i < ds->num_ports; i++)
		mt7628_esw_set_pvid(esw, i, esw->tag_8021q_pvid[i]);

If the VLAN being deleted becomes inactive (members == 0), the hardware
PVID for the port still references that VLAN slot, which will be
reprogrammed with empty members/untag.  Untagged ingress on that port
would then be tagged with a VID whose VLAN table entry has no members.

In the normal bridge_join/bridge_leave flow
(dsa_tag_8021q_bridge_join/leave in net/dsa/tag_8021q.c) the replacement
VID is added (with BRIDGE_VLAN_INFO_PVID) before the old one is deleted,
which masks the issue.  On teardown/unbind
(dsa_tag_8021q_port_teardown() deletes without a preceding add) the
stale pvid can linger and be re-applied by any later vlan_sync.

> +
> +static void mt7628_teardown(struct dsa_switch *ds)
> +{
> +	rtnl_lock();
> +	dsa_tag_8021q_unregister(ds);
> +	rtnl_unlock();
> +}
> +
> +static struct dsa_switch_ops mt7628_switch_ops = {
       ^^^^^^

This isn't a bug, but should mt7628_switch_ops be const?  struct
dsa_switch holds a const struct dsa_switch_ops *ops, and other DSA
drivers (mt7530, sja1105, felix, ...) declare their ops tables const so
the vtable lives in .rodata.

> +	.get_tag_protocol = mt7628_get_tag_proto,
> +	.setup = mt7628_setup,
> +	.teardown = mt7628_teardown,
> +	.port_enable = mt7628_port_enable,
> +	.port_disable = mt7628_port_disable,
> +	.phylink_get_caps = mt7628_phylink_get_caps,
> +	.tag_8021q_vlan_add = mt7628_dsa_8021q_vlan_add,
> +	.tag_8021q_vlan_del = mt7628_dsa_8021q_vlan_del,
> +};

[ ... ]

