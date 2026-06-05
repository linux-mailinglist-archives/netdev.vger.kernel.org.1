Return-Path: <netdev+bounces-295584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AwntAhgyImrlTgEAu9opvQ
	(envelope-from <netdev+bounces-295584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A953644A4A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:19:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LDH7CrjP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295584-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D20F23017EF2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF96175A97;
	Fri,  5 Jun 2026 02:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258243B7767;
	Fri,  5 Jun 2026 02:18:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625939; cv=none; b=e6gQZ36etCfJyUg3s3WRqM1L8/LWZmf4wT09NC6uO8Mv1UEbdBQDeH9SLk0UewBtU8hJoHznVZOhKRMhSNRkB8gDuRUeST1kA4WNGyc1MukBNGPYDoAU7E7aS74WJaUVpV6CFcMPszKCnBgl8RhZVfI7rYYYyQZrUD/QWSG7li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625939; c=relaxed/simple;
	bh=BdOOgWUzMVVsGjU9jkwhgYUWGg5mF0GzMhYn7AIKQmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQGtxN0CMx5SumjnKY68t5VIFhzfBPnOPIJI97Zgv/2czUTYorbMqq3Fv7hQYJnQitia2R2RzkmmAckUDDjAvbEaa3WlD73BYzIyRTn5Mt3ploEqnzYWGVpVAScxfLitzLF5MgBAHLENrbp5edzzjXLrkhBCw08k852+ibKFb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDH7CrjP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF451F00893;
	Fri,  5 Jun 2026 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625933;
	bh=zrkc0GhW/oOLTIoJH9JhkWhKT+HfutzlNHyT1CCjAik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LDH7CrjPBywNb5+Ib4MCEv1AFUn00S8nOW+ftRhXJJhioCBG5hqazwHg9IOKuYSRD
	 /A0FMMNNR6RfVSVMzDROQgX1w8jYZVKhoNivSRAFXeaSR7qYUR/qVWXKtZWQXYvLiq
	 6o2Fs8ND+iEg0xeYrCHaOE8Wb5dtijvMPq4V6TaXRVwYHgrTwDjbKVoY24lQpeedyH
	 9Q2n/puXqSZv27B2JgobYSZXokPBtcSDcFlGbXSUO7eMTxVmPm+1oz+UT7Tmytr6qw
	 tr815FEcG8SL1+fDUhPunnodaP4qz7knWTNXkeSkKstoRU74sdZXXVGUfzvkStWdQD
	 7PpvB5GX59R4g==
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
Subject: Re: [net-next v24 2/7] net: mtip: The L2 switch driver for imx287
Date: Thu,  4 Jun 2026 19:18:50 -0700
Message-ID: <20260605021851.3594517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601112437.2216043-3-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-3-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lukasz.majewski@mailbox.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A953644A4A

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mtip: The L2 switch driver for imx287

This patch adds a new driver for the MoreThanIP L2 switch embedded in
the i.MX287 SoC.  The two-port switch sits between uDMA[01] and the
MAC-NET[01] blocks and can be used as an alternative to the existing
FEC driver.

A few questions inline below.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..1d1005a42306
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static void mtip_switch_restart(struct net_device *dev, int duplex0,
> +				int duplex1)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int i;
> +
> +	 /* Perform a reset. We should wait for this. */
> +	writel(MCF_ESW_MODE_SW_RST, fep->hwp + ESW_MODE);

[High]
Should this routine hold a lock?  fep->hw_lock is declared and
initialised in mtip_sw_probe() with the comment "/* Lock for HW
configuration */" but neither mtip_switch_restart() nor mtip_adjust_link()
acquire it.

The two ports each get their own phy_device via of_phy_connect(), and
phylib serialises adjust_link callbacks per phy_device, not across them.
If both ports' state machines fire mtip_adjust_link() at the same time,
both CPUs end up inside mtip_switch_restart() in parallel, racing on
ESW_MODE_SW_RST, ESW_BMPC, ESW_ISR, ESW_RDSR/ESW_TDSR, fep->cur_tx /
cur_rx / dirty_tx, and fep->full_duplex[].

> +	/* Reset SKB transmit buffers */
> +	for (i = 0; i <= TX_RING_MOD_MASK; i++) {
> +		if (fep->tx_skbuff[i]) {
> +			dev_kfree_skb_any(fep->tx_skbuff[i]);
> +			fep->tx_skbuff[i] = NULL;
> +		}
> +	}

[High]
Can two concurrent invocations of this loop double-free a tx_skbuff[i]
entry?  Both CPUs read the same non-NULL pointer, both call
dev_kfree_skb_any() on it, and only then race on the NULL store.

> +
> +	fep->full_duplex[0] = duplex0;
> +	fep->full_duplex[1] = duplex1;
> +
> +	mtip_configure_enet_mii(fep, 1);
> +	mtip_configure_enet_mii(fep, 2);
> +
> +	/* And last, enable the transmit and receive processing */
> +	writel(MCF_ESW_RDAR_R_DES_ACTIVE, fep->hwp + ESW_RDAR);
> +
> +	/* Enable interrupts we wish to service */
> +	writel(0xFFFFFFFF, fep->hwp + ESW_ISR);
> +	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
> +	       fep->hwp + ESW_IMR);
> +
> +	mtip_config_switch(fep);
> +}
> +
> +static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
> +{
> +	struct switch_enet_private *fep = ptr_fep;
> +	irqreturn_t ret = IRQ_NONE;
> +	u32 int_events, int_imask;
> +
> +	/* Get the interrupt events that caused us to be here */
> +	int_events = readl(fep->hwp + ESW_ISR);
> +	writel(int_events, fep->hwp + ESW_ISR);
> +
> +	if (int_events & (MCF_ESW_ISR_RXF | MCF_ESW_ISR_TXF)) {
> +		ret = IRQ_HANDLED;
> +		/* Disable the RX interrupt */
> +		if (napi_schedule_prep(&fep->napi)) {
> +			int_imask = readl(fep->hwp + ESW_IMR);
> +			int_imask &= ~MCF_ESW_IMR_RXF;
> +			writel(int_imask, fep->hwp + ESW_IMR);
> +			__napi_schedule(&fep->napi);
> +		}
> +	}
> +
> +	return ret;
> +}

[Medium]
Should this also clear MCF_ESW_IMR_TXF here?  The condition above
schedules NAPI on either RXF or TXF, and the NAPI poll re-enables both
bits together:

	writel(MCF_ESW_IMR_RXF | MCF_ESW_IMR_TXF,
	       fep->hwp + ESW_IMR);

With only RXF masked here, every TX completion while NAPI is running
re-asserts the IRQ line; mtip_interrupt() runs again, napi_schedule_prep()
returns false because NAPI is already scheduled, and the handler returns
IRQ_HANDLED having done nothing useful.  Once mtip_switch_tx() is filled
in by the later patch in the series, would this turn into a sustained
IRQ storm on TX-busy workloads?

[ ... ]

> +static int mtip_mii_init(struct switch_enet_private *fep,
> +			 struct platform_device *pdev)
> +{
> +	struct device_node *node;
> +	int err = -ENXIO;
> +
> +	/* Clear MMFR to avoid to generate MII event by writing MSCR.
> +	 * MII event generation condition:
> +	 * - writing MSCR:
> +	 *      - mmfr[31:0]_not_zero & mscr[7:0]_is_zero &
> +	 *        mscr_reg_data_in[7:0] != 0
> +	 * - writing MMFR:
> +	 *      - mscr[7:0]_not_zero
> +	 */
> +	writel(0, fep->hwp + MCF_FEC_MII_DATA);
> +	/* Clear any pending transaction complete indication */
> +	writel(MCF_ENET_MII, fep->enet_addr + MCF_FEC_EIR);

[Medium]
Is the base address for the MMFR clear correct here?

fep->hwp is the switch base (fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET,
i.e. enet_addr + 0x8000), while MCF_FEC_MII_DATA (0x040) is an offset
within the MAC register space.  At offset 0x040 from fep->hwp the header
defines:

	#define ESW_MCR             (0x040)

So this writel() goes to the switch's Mirror Configuration Register
rather than to MMFR.  The very next line correctly uses fep->enet_addr +
MCF_FEC_EIR for the EIR clear, and mtip_mdio_read()/mtip_mdio_write()
also use fep->enet_addr + MCF_FEC_MII_DATA for the actual MDIO accesses.
Should this writel() also use fep->enet_addr?

[ ... ]

> +static int mtip_open(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int ret, port_idx = priv->portnum - 1;
> +
> +	if (fep->usage_count == 0) {
> +		ret = clk_enable(fep->clk_ipg);

[ ... ]

> +	ret = mtip_mii_probe(dev);
> +	if (ret)
> +		goto mtip_mii_probe_err;
> +
> +	phy_start(fep->phy_dev[port_idx]);
> +
> +	if (fep->usage_count == 0) {
> +		napi_enable(&fep->napi);
> +		mtip_switch_restart(dev, 1, 1);
> +
> +		netif_start_queue(dev);
> +	}

[High]
Can phy_start() race with the mtip_switch_restart() call below it?
Once phy_start() returns, the phylib state machine workqueue may invoke
mtip_adjust_link() on another CPU, which calls mtip_switch_restart() on
link-up.  That can run concurrently with the mtip_switch_restart(dev,
1, 1) here, and both paths walk fep->tx_skbuff[] freeing entries and
reprogram switch HW registers without synchronisation.

Would it be safer to start the PHY only after the switch HW has been
configured (and to take a lock around mtip_switch_restart())?

[ ... ]

> +static int mtip_parse_of(struct switch_enet_private *fep,
> +			 struct device_node *np)
> +{
> +	struct device_node *p;
> +	unsigned int port_num;
> +	int ret = 0;
> +
> +	p = of_get_child_by_name(np, "ethernet-ports");
> +
> +	for_each_available_child_of_node_scoped(p, port) {
> +		if (of_property_read_u32(port, "reg", &port_num))
> +			continue;

[Medium]
If of_get_child_by_name() returns NULL (no "ethernet-ports" node), the
for_each_available_child_of_node_scoped() loop is skipped entirely, ret
stays 0, and mtip_parse_of() returns success with no ports parsed.
Similarly, if every child fails the "reg" read above, the continue keeps
ret at 0.

After such a "success" return, mtip_ndev_init() calls
alloc_netdev(sizeof(struct mtip_ndev_priv), fep->ndev_name[i],
NET_NAME_USER, ether_setup) with fep->ndev_name[i] still NULL.
alloc_netdev_mqs() then calls strscpy_pad() on a NULL name and oopses.

Should missing "ethernet-ports", missing "reg", or having no parsed
ports be treated as errors here?

[ ... ]

> +		fep->phy_np[port_num - 1] = of_parse_phandle(port,
> +							     "phy-handle", 0);
> +		if (!fep->phy_np[port_num - 1]) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: PHY handle not defined!\n", __func__);
> +			ret = -ENODEV;
> +			goto of_get_err;
> +		}
> +	}
> +
> + of_get_err:
> +	mtip_parse_of_cleanup(fep);
> +	of_node_put(p);
> +
> +	return ret;
> +}

[High]
Does the success path fall through into of_get_err: unconditionally?

There is no return ret; (or success label) before the of_get_err label,
so on a successful parse mtip_parse_of_cleanup(fep) runs and calls
of_node_put() on every fep->phy_np[i] just acquired by
of_parse_phandle().  mtip_parse_of_cleanup() also does not NULL the
slots:

	static void mtip_parse_of_cleanup(struct switch_enet_private *fep)
	{
		int i;

		for (i = 0; i < SWITCH_EPORT_NUMBER; i++)
			if (fep->phy_np[i])
				of_node_put(fep->phy_np[i]);
	}

After probe, mtip_open()->mtip_mii_probe() then passes the same
fep->phy_np[i] pointers to of_phy_connect() — does this dereference an
OF node the driver no longer holds a reference on?

The error and remove paths (the of_free_references label, the explicit
cleanup after devm_request_irq() failure, and mtip_sw_remove() ->
mtip_parse_of_cleanup()) call mtip_parse_of_cleanup() again on the same
non-NULL pointers, which would underflow the OF refcount on each.

Should there be a return ret; before of_get_err: and a NULL-out of the
slot in mtip_parse_of_cleanup() after each of_node_put()?

[ ... ]

> +static int mtip_sw_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	ret = devm_request_irq(&pdev->dev, fep->irq, mtip_interrupt, 0,
> +			       dev_name(&pdev->dev), fep);
> +	if (ret) {
> +		mtip_parse_of_cleanup(fep);
> +		return dev_err_probe(&pdev->dev, ret, "Could not alloc IRQ\n");
> +	}

[Medium]
Can a stale IRQ here dereference an uninitialised napi struct?

netif_napi_add(dev, &fep->napi, mtip_rx_napi) is only called from
mtip_open(), so between this devm_request_irq() and the first ndo_open
fep->napi is zero-initialised (no poll, no dev, no state).  Probe also
doesn't write 0 to ESW_IMR before requesting the IRQ — it relies on the
register's reset value.

If the bootloader or a warm reset left the switch with IMR set and
events pending in ESW_ISR, mtip_interrupt() can fire immediately on
enable, see RXF/TXF, call napi_schedule_prep(&fep->napi) (which sets
NAPIF_STATE_SCHED unconditionally and returns true), and queue the
zero-initialised napi struct.  net_rx_action() would then call
n->poll == NULL.

Would it help to either mask all interrupts (writel(0, fep->hwp +
ESW_IMR)) before request_irq, or defer request_irq until after
netif_napi_add()?
-- 
pw-bot: cr

