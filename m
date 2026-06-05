Return-Path: <netdev+bounces-295588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wjAwEm0yImoLTwEAu9opvQ
	(envelope-from <netdev+bounces-295588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A2644A95
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:20:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B4HK5iQd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295588-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3AB33037787
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7384C3E8341;
	Fri,  5 Jun 2026 02:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F813E1CED;
	Fri,  5 Jun 2026 02:19:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625947; cv=none; b=nqghgRmYt9JCyEKPjxiKbR3qn66LfcwmHgOBiRn9P0iKIDxdp4jiBM3dzTdspMfi5GSBHDMfnd5D9WRCpslJKkRTMOUq0EjKCsW7AR84xUSyHQpT8EkpYUfiidmOIM39uwmIB2rn18bn11149XMUSK/33UGqlKS/r8D9IC0eC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625947; c=relaxed/simple;
	bh=Rj2sMioJcubYaC2WBlvOyDNK/bwJIArjMGrFkW3dO9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAOpnr+BUnXhhabujF6THR4UpeEkHkvqPZWEu/LtEeu+JKUuW+ctKRSpY4eshloRCDuQ9hqiqs4+46TLn8JvWAFyVrO1qFT9YcX7D9Xuf8I0o2safUTpZiXCkKglBw1BvpH/ut0HEM+pUwPpuujHilZB1VRwHJuvniLFuvDIpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4HK5iQd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474E01F0089B;
	Fri,  5 Jun 2026 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625941;
	bh=yymIECeoFszmyi5ws8XXDw1iy0jT9Ce1kmUxM5cQlGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4HK5iQdXrKSH5NmNoKCWSHY9jbPFqwVJQzyOtscg9SzkjbFqq0woLkUsDPRlspa9
	 c+ck1ysCyuvQSlIyDaNdQ599A33PjXv4UPzjRvz5rOLC2FwUjVY+uR9vAkrD6FlvKY
	 WgOHKdZ3C27DwfjSowphYetuodYBW+mXsMJNzmDFtS7g8uj9dX6anfrh8NSq1HrBWh
	 64ai8EHYLZk+Wdg25HajJRZYXaAtQYpVnhv0V7rfcOjslNwyWqmhcD5qSpsEUp1mxV
	 pocwgcZOs5DaNLXs+GC7qOEtmWp6JHP8IrbMyneZBSM/CiLfPkr2rBcg5PfIywYq3X
	 iKF98Y3Nc4uyA==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	lgirdwood@gmail.com,
	nathan@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	krzk+dt@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org
Subject: Re: [net-next v24 6/7] net: mtip: Extend the L2 switch driver with management operations
Date: Thu,  4 Jun 2026 19:18:59 -0700
Message-ID: <20260605021859.3594656-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601112437.2216043-7-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-7-lukasz.majewski@mailbox.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-295588-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukasz.majewski@mailbox.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD2A2644A95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mtip: Extend the L2 switch driver with management operations

This patch adds switch management helpers (port enable, blocking,
learning, broadcast, multicast, VLAN input/output, VLAN verification,
forced forwarding, port separation) and wires them into the switch
configuration and TX paths.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 212207861e13..76e503e128dd 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -505,8 +505,35 @@ static void mtip_config_switch(struct switch_enet_private *fep)
>  
>  	writel(0, fep->hwp + ESW_BKLR);
>  
> +	/* Do NOT disable learning */
> +	mtip_port_learning_config(fep, 0, 0, 0);
> +	mtip_port_learning_config(fep, 1, 0, 0);
> +	mtip_port_learning_config(fep, 2, 0, 0);
> +
> +	/* Disable blocking */
> +	mtip_port_blocking_config(fep, 0, 0);
> +	mtip_port_blocking_config(fep, 1, 0);
> +	mtip_port_blocking_config(fep, 2, 0);
> +
>  	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
>  	       fep->hwp + ESW_IMR);
> +
> +	mtip_port_enable_config(fep, 0, 1, 1);
> +	mtip_port_enable_config(fep, 1, 1, 1);
> +	mtip_port_enable_config(fep, 2, 1, 1);
> +
> +	mtip_port_broadcast_config(fep, 0, 1);
> +	mtip_port_broadcast_config(fep, 1, 1);
> +	mtip_port_broadcast_config(fep, 2, 1);
> +
> +	/* Disable multicast receive on port 0 (MGNT) */
> +	mtip_port_multicast_config(fep, 0, 0);
> +	mtip_port_multicast_config(fep, 1, 1);
> +	mtip_port_multicast_config(fep, 2, 1);

[Low]
mtip_port_learning_config(), mtip_port_blocking_config(),
mtip_port_enable_config(), mtip_port_broadcast_config() and
mtip_port_multicast_config() all return int, but every return value here
is discarded and mtip_config_switch() itself stays void.

The arguments are compile-time constants today so validation cannot
fail, but if any of these helpers later acquire a real failure mode (for
example, hardware probing or capability gating) the switch would be
silently left in a partially configured state.  Should the return
values be checked, or should these helpers be void?

> +
> +	/* Setup VLANs to provide port separation */
> +	if (!fep->br_offload)
> +		mtip_switch_en_port_separation(fep);
>  }
>  
>  static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> @@ -592,6 +619,10 @@ static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
>  
>  	skb_tx_timestamp(skb);
>  
> +	/* For port separation - force sending via specified port */
> +	if (!fep->br_offload && port != 0)
> +		mtip_forced_forward(fep, port, 1);
> +

[High]
This is the per-packet TX path, and mtip_forced_forward() is called for
every non-management transmit.  A few questions about that call:

The helper passes the netdev port index (1 or 2) in as the FD value, but
its body encodes that argument as a bitmap into MCF_ESW_P0FFEN_FD_MASK:

	reg |= FIELD_PREP(MCF_ESW_P0FFEN_FD_MASK, port & GENMASK(1, 0));

For port == 1 the FD field is 0b01, for port == 2 it is 0b10.  If FD is
a destination-port bitmap, does this mean port == 1 forwards to MGNT
port 0 and port == 2 forwards to the first user port?  Is the caller
passing the right value?

The function builds the register value from a fresh u32 reg = 0 and
unconditionally writes ESW_P0FFEN, so the else branch that masks off
MCF_ESW_P0FFEN_FEN never runs in practice (reg already has FEN clear).
Once this path runs once with enable == 1, who clears the FEN bit?

mtip_switch_dis_port_separation() resets PID/VRES/VIMEN/VIMSEL/VLANV/
VOMSEL but not ESW_P0FFEN.  Is forced-forward state expected to remain
asserted across reconfiguration?

>  	dev->stats.tx_bytes += skb->len;
>  	/* If this was the last BD in the ring,
>  	 * start at the beginning again.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> new file mode 100644
> index 000000000000..4c07861a6a3e
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

[ ... ]

> +int mtip_vlan_input_process(struct switch_enet_private *fep,
> +			    int port, int mode, unsigned short port_vlanid,
> +			    int vlan_verify_en, int vlan_domain_num,
> +			    int vlan_domain_port)
> +{
> +	if (mode < 0 || mode > 3) {
> +		dev_err(&fep->pdev->dev,
> +			"%s: VLAN input processing mode (%d) not supported\n",
> +			__func__, mode);
> +		return -EINVAL;
> +	}
> +
> +	if (port < 0 || port > 2) {
> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	if (vlan_verify_en == 1 &&
> +	    (vlan_domain_num < 0 || vlan_domain_num > 32)) {
> +		dev_err(&fep->pdev->dev, "%s: Domain out of range\n", __func__);
> +		return -EINVAL;
> +	}

[Medium]
Is the upper bound here off by one?  ESW_VRES_BASE is 0x280 and
ESW_VRES(x) = 0x280 + 4*x, so vlan_domain_num == 32 produces offset
0x300, which is the ESW_DISCN register.  A call with
vlan_domain_num == 32 would write a VRES bitmap value into the
discard-stats register.  Should the test be > 31 (or >= 32)?

[Low]
The vlan_domain_port parameter is part of the function signature and
the public header but never referenced in the body, and all in-tree
callers pass 0.  Is it intended to control which VRES port bit is set
(currently hardcoded from port), or should the parameter be removed
until it has a use?

> +
> +	writel(FIELD_PREP(MCF_ESW_PID_VLANID_MASK, port_vlanid),
> +	       fep->hwp + ESW_PID(port));
> +	if (port == 0) {
> +		if (vlan_verify_en == 1)
> +			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
> +					  port_vlanid) | MCF_ESW_VRES_P0,
> +			       fep->hwp + ESW_VRES(vlan_domain_num));
> +
> +		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN0,
> +		       fep->hwp + ESW_VIMEN);
> +		writel(readl(fep->hwp + ESW_VIMSEL) |
> +		       FIELD_PREP(MCF_ESW_VIMSEL_IM0_MASK, mode),
> +		       fep->hwp + ESW_VIMSEL);

[Medium]
VIMSEL IMx and VOMSEL OMx are 2-bit fields, but the update here is
read | FIELD_PREP(MASK, mode) without first clearing the field.  Once a
non-zero mode has been programmed for a port, can a subsequent
reprogramming actually replace it?

For example, programming port 0 first with mode 1 (binary 01) and then
with mode 2 (binary 10) would yield 01 | 10 = 11 in IM0.

mtip_config_switch() runs from the switch-restart path
(mtip_open(), mtip_timeout_work(), mtip_adjust_link()) and does not
zero VIMSEL/VOMSEL beforehand, so a restart with a different mode would
hit this.  Should the helpers do reg &= ~MASK; reg |= FIELD_PREP(...)
as the sibling helpers (e.g. mtip_port_enable_config) do?

> +	} else if (port == 1) {

[ ... ]

> +int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
> +			     int mode)
> +{
> +	if (port < 0 || port > 2) {
> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	if (port == 0) {
> +		writel(readl(fep->hwp + ESW_VOMSEL) |
> +		       FIELD_PREP(MCF_ESW_VOMSEL_OM0_MASK, mode),
> +		       fep->hwp + ESW_VOMSEL);

[Medium]
The same accumulating-OR pattern is used here, and there is no
validation of mode (the input variant has it).  Should mode be range
checked, and should the OMx field be cleared before being rewritten?

> +	} else if (port == 1) {

[ ... ]

> +int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
> +			       int vlan_domain_verify_en,
> +			       int vlan_discard_unknown_en)
> +{
> +	if (port < 0 || port > 2) {
> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	if (vlan_domain_verify_en == 1) {

[Low]
Both vlan_domain_verify_en and vlan_discard_unknown_en are tested for
exactly 1 and exactly 0; any other value silently performs no register
update yet the function still returns 0.

Would it be cleaner to declare these parameters bool (as several other
helpers in this file do) or to validate them and return -EINVAL on out
of range input?

> +		if (port == 0)
> +			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV0,
> +			       fep->hwp + ESW_VLANV);

[ ... ]

> +int mtip_port_multicast_config(struct switch_enet_private *fep,
> +			       int port, bool enable)
> +{
> +	u32 reg = 0;
> +
> +	if (port < 0 || port > 2) {
> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	reg = readl(fep->hwp + ESW_DMCR);

[Medium]
A general question that applies to every helper added in this file:
each one performs a read-modify-write on a shared MMIO register
(ESW_BKLR, ESW_PER, ESW_DBCR, ESW_DMCR, ESW_VLANV, ESW_VIMEN,
ESW_VIMSEL, ESW_VOMSEL, ESW_VRES, ESW_IMR) without taking any lock and
without a documented locking precondition, and the helpers are exported
via mtipl2sw.h.

fep->hw_lock already exists for HW configuration but the helpers
neither take it nor call lockdep_assert_held() on it.
mtip_config_switch() itself issues three independent RMWs on the same
register for each helper (one per port).

Today the only caller is mtip_config_switch() during switch restart, so
the race is dormant.  If a future caller (sysfs/netlink/bridge offload
hook) appears, every shared-register update becomes a race.  Should
these helpers take fep->hw_lock internally, or assert it via
lockdep_assert_held()?

[ ... ]

> +int mtip_forced_forward(struct switch_enet_private *fep, int port, bool enable)
> +{
> +	u32 reg = 0;
> +
> +	if (port & ~GENMASK(1, 0)) {
> +		dev_err(&fep->pdev->dev,
> +			"%s: Forced forward for port(s): 0x%x not supported!\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	/* Enable Forced forwarding for port(s) */
> +	reg |= FIELD_PREP(MCF_ESW_P0FFEN_FD_MASK, port & GENMASK(1, 0));
> +
> +	if (enable)
> +		reg |= MCF_ESW_P0FFEN_FEN;
> +	else
> +		reg &= ~MCF_ESW_P0FFEN_FEN;
> +
> +	writel(reg, fep->hwp + ESW_P0FFEN);
> +	return 0;
> +}

[High]
Two more notes here in addition to the call-site question above:

The validation accepts port values 0..3 via port & ~GENMASK(1, 0) while
every sibling helper in this file rejects port > 2.  Which convention
is intended for the API?

The function unconditionally overwrites ESW_P0FFEN starting from
u32 reg = 0, instead of doing the readl/modify/writel that every other
helper here does.  Is that intentional, and if so what about other bits
that may live in this register?

> +
> +int mtip_port_learning_config(struct switch_enet_private *fep, int port,
> +			      bool disable, bool irq_adj)
> +{
> +	u32 reg = 0;
> +
> +	if (port < 0 || port > 2) {
> +		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
> +			__func__, port);
> +		return -EINVAL;
> +	}
> +
> +	reg = readl(fep->hwp + ESW_BKLR);
> +	if (disable) {
> +		if (irq_adj)
> +			writel(readl(fep->hwp + ESW_IMR) & ~MCF_ESW_IMR_LRN,
> +			       fep->hwp + ESW_IMR);

[Medium]
Can this RMW on ESW_IMR race with mtip_interrupt()?  The hardirq
handler does its own RMW on the same register with no lock:

	int_imask = readl(fep->hwp + ESW_IMR);
	int_imask &= ~MCF_ESW_IMR_RXF;
	writel(int_imask, fep->hwp + ESW_IMR);

If the hardirq fires between this helper's readl() and writel(), the
interrupt handler's RXF mask clear can be lost on writeback,
re-enabling RXF while NAPI is supposed to be servicing it.

Today mtip_config_switch() calls this helper with irq_adj = 0 so the
ESW_IMR side is dormant, but the function is exported for the explicit
purpose of toggling the LRN mask, so the documented use of the API
trips the race.  Should this take fep->hw_lock with spin_lock_irqsave()
(and have mtip_interrupt() take the same lock around its RMW)?

> +
[ ... ]

