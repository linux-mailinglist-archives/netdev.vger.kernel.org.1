Return-Path: <netdev+bounces-284594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEwnDNZ2+mkQPQMAu9opvQ
	(envelope-from <netdev+bounces-284594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:01:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777454D481F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D65C3011741
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDF301719;
	Tue,  5 May 2026 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfnrDdgr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9C40DFDB;
	Tue,  5 May 2026 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022098; cv=none; b=AHcJJ0H3YV9qdFJLjjecVX7oFSJRyIkh0HoTxaYsogTnIoP958fN3foJ4fVs2697dpZYaA1r9/EcMLsV8eLrAiEFTjBEKayzs0xYjxOeaFyrkjKgI/j/WDv+jR96iBko1ySPKB45QQON/6J8PMN5mttQuBsevZCFIuTKGLzq/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022098; c=relaxed/simple;
	bh=H7sP9cMwnyfmKGYOEd16qRMW7QVBJFHVxVJrCHRni/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbRZf2Vbpt7mBqPb/pkIsqZWzTy1GCmUxkaLpX2yvpeOiHeUpdhBc/fUbi1c8/tCPHpt030mUuOKVbvrJPyu1w/11CoHjjoqSikGaU2m4UKdKTIVlqYHHuASZoqkWrXvZL/tgaBbZJoSIHa77gP0gQSDfbWDxb/a2G3o/tLAIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfnrDdgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3750C2BCB4;
	Tue,  5 May 2026 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778022097;
	bh=H7sP9cMwnyfmKGYOEd16qRMW7QVBJFHVxVJrCHRni/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfnrDdgrl29evIMMxTQZKGPjQjEX3vkihwFmLeDbOP/I87Idorm8HkZoPVLYDDuBS
	 iXpF8qRd2IL4LzrT/tVkkyi3Ty3nDeRdU24mA3DFCNdyEKX8IsAvFKn0GCWy5/Iz3+
	 2U+WOFJLMNW5KLDNjFv3ymYCSbJgwQwJy9ncDwAE+pydklZoLzIFoFOY/0sl3vOIWx
	 pbmnFt+Ic1IyiIY6Cgj5HjUqyTRGaWoem4GwWYcdRFe/JT5q20mFFjgEz+QbDF0TQ3
	 jInJ6Qq2IrmNrM9yrvEN0lKTTllRiNzVIRMzzrS+XZh030VfqL5X6vk8AG7hBDoh7G
	 DeerJvbD5KZSQ==
From: Jakub Kicinski <kuba@kernel.org>
To: m-malladi@ti.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	arnd@arndb.de,
	parvathi@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	vladimir.oltean@nxp.com,
	rogerq@kernel.org,
	danishanwar@ti.com,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srk@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH net-next v5 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Tue,  5 May 2026 16:01:34 -0700
Message-ID: <20260505230134.1369166-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430111723.497113-2-m-malladi@ti.com>
References: <20260430111723.497113-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 777454D481F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ti: icssg-prueth: Add Frame Preemption MAC Merge support

This patch adds QoS infrastructure for Frame Preemption (FPE) support to
the ICSSG Ethernet driver, introducing prueth_qos_iet state tracking,
icssg_config_ietfpe() for firmware IET configuration, MQPRIO qdisc
offload that maps traffic classes to express/preemptible queues, and
link-state driven verify state machine re-triggering.

A few questions on the code below.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b..7657dc1015f0 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c

[ ... ]

> @@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
>  
>  	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
>  
> +	icssg_qos_init(ndev);
> +
>  	ret = pruss_request_mem_region(prueth->pruss,
>  				       port == PRUETH_PORT_MII0 ?
>  				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,

Is the fpe_lock mutex lifecycle balanced on all error paths?

icssg_qos_init() calls mutex_init(&iet->fpe_lock) unconditionally here,
but mutex_destroy() is only invoked in the netdev_unregister label in
prueth_probe() (gated on registered_netdevs[i]) and in prueth_remove().

The remaining paths do not appear to destroy the mutex:

  - Every goto free / goto free_ndev within prueth_netdev_init() itself
    (pruss_request_mem_region failure, platform_get_irq_byname_optional
    failure, of_parse_phandle failure, of_get_phy_mode failure, the
    unsupported phy_if case) calls free_netdev() directly.

  - prueth_netdev_exit() (reached via the netdev_exit label and from
    prueth_remove) frees the netdev without destroying fpe_lock.

  - When register_netdev() succeeds for MAC0 but fails for MAC1 (or
    when prueth_netdev_init() fails for MAC1 after MAC0 succeeded),
    control flows through netdev_exit, which leaks the fpe_lock state
    for the not-yet-registered netdev.

Would it be cleaner to pair mutex_destroy() with free_netdev in
prueth_netdev_exit() rather than at the registered_netdev unwind level?

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..fc4b0ebc7d68
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,232 @@

[ ... ]

> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
> +	u8 preemptible_tcs = p_mqprio->preemptible_tcs;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int prempt_mask = 0, i;
> +	u8 tc;
> +
> +	/* The preemptible traffic classes should only be committed to hardware
> +	 * once TX is active.
> +	 */
> +	if (!iet->fpe_active) {
> +		netdev_dbg(emac->ndev, "FPE not active, skipping preempt mask config\n");
> +		return;
> +	}
> +
> +	/* Configure the queues based on the preemptible tc map set by the user */
> +	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
> +		/* check if the tc is preemptive or not */
> +		if (preemptible_tcs & BIT(tc)) {
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				/* Set all the queues in this tc as preemptive queues */
> +				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask &= ~BIT(i);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^

Is the prempt_mask &= ~BIT(i) here dead code?  prempt_mask is
initialised to 0, so clearing a bit that is already zero has no effect.
The other branch sets bits via prempt_mask |= BIT(i), so it looks like
the clear statement could simply be removed.

> +			}
> +		} else {
> +			/* Set all the queues in this tc as express queues */
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				prempt_mask |= BIT(i);
> +			}
> +		}
> +		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
> +	}
> +	writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +}

[ ... ]

> +/* Direct synchronous configuration of IET FPE.
> + * Caller must hold iet->fpe_lock.
> + */
> +void icssg_config_ietfpe(struct prueth_emac *emac, bool enable)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +	u8 val;
> +
> +	/* return early if FPE is not active and need not be enabled */
> +	if (!iet->fpe_enabled && !iet->fpe_active)
> +		return;
> +
> +	if (!netif_running(emac->ndev)) {
> +		netdev_dbg(emac->ndev, "cannot change IET/FPE state when interface is down\n");
> +		return;
> +	}
> +
> +	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
> +	 * fpe_enabled is set to enable MM in Tx direction
> +	 */
> +	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
> +
> +	/* If FPE is to be enabled, first configure MAC Verify state
> +	 * machine in firmware as firmware kicks the Verify process
> +	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
> +	 * received.
> +	 */
> +	if (enable && iet->mac_verify_configure) {
> +		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
> +		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
> +	} else {
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +	}
> +
> +	/* Send command to enable FPE Tx side. Rx is always enabled */
> +	ret = icssg_set_port_state(emac,
> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +	if (ret) {
> +		netdev_err(emac->ndev, "TX preempt %s command failed\n",
> +			   str_enable_disable(enable));
> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +		return;
        ^^^^^^^

Can this disable path leave the software and hardware state out of sync?

When called with enable=false, PRE_EMPTION_ENABLE_TX has already been
written to 0 above before the firmware command is issued.  If
icssg_set_port_state(ICSSG_EMAC_PORT_PREMPT_TX_DISABLE) then fails, the
function returns without updating iet->fpe_active, so fpe_active stays
true even though the TX-enable register now reads 0.

Later calls will then skip the !fpe_enabled && !fpe_active early return
and icssg_iet_set_preempt_mask() will keep writing preempt masks as if
TX were still active.

> +	}
> +
> +	if (enable && iet->mac_verify_configure) {
> +		ret = icssg_iet_verify_wait(emac);
> +		if (ret) {
> +			netdev_err(emac->ndev, "MAC Verification failed with timeout\n");
> +			return;
                        ^^^^^^^

On the verify-wait timeout path (and the PRE_EMPTION_ACTIVE_TX != 1
path below), the driver has already written PRE_EMPTION_ENABLE_TX=1,
PRE_EMPTION_ENABLE_VERIFY=1, PRE_EMPTION_ADD_FRAG_SIZE_LOCAL,
PRE_EMPTION_VERIFY_TIME, and issued the
ICSSG_EMAC_PORT_PREMPT_TX_ENABLE firmware command.  This error path
returns without reverting any of those writes, and iet->fpe_active
remains false.

A later user-driven disable will then hit the early return:

    if (!iet->fpe_enabled && !iet->fpe_active)
        return;

so the hardware stays configured for FPE while the driver believes it
is off.  Should these error paths also perform rollback like the
icssg_set_port_state() failure branch does?

> +		}
> +	} else if (enable) {
> +		/* Give firmware some time to update PRE_EMPTION_ACTIVE_TX state */
> +		usleep_range(100, 200);
> +	}
> +
> +	if (enable) {
> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
> +		if (val != 1) {
> +			netdev_err(emac->ndev,
> +				   "Firmware fails to activate IET/FPE\n");
> +			return;
> +		}
> +		iet->fpe_active = true;
> +	} else {
> +		iet->fpe_active = false;
> +	}
> +
> +	icssg_iet_set_preempt_mask(emac);

On the disable path (enable=false), fpe_active was just set to false,
but icssg_iet_set_preempt_mask() early-returns precisely on
!fpe_active:

    if (!iet->fpe_active) {
        netdev_dbg(emac->ndev, "FPE not active, skipping preempt mask config\n");
        return;
    }

So on a normal enable -> disable cycle, the EXPRESS_PRE_EMPTIVE_Q_MAP
per-queue entries and the EXPRESS_PRE_EMPTIVE_Q_MASK register keep the
preemptible markings that were written on the prior enable.  Also,
PRE_EMPTION_ENABLE_VERIFY is only zeroed on the error branch above; the
successful disable does not clear it.  Is a subsequent re-enable with a
different mqprio layout intended to see the stale markings from the
previous layout?

> +	netdev_err(emac->ndev, "IET FPE %s successfully\n",
        ^^^^^^^^^^

Is netdev_err the right severity for a success message?  Every link
up/down event while FPE is active goes through emac_adjust_link() ->
icssg_qos_link_state_update() -> icssg_config_ietfpe(), so this will
emit a KERN_ERR line on every link flap.  netdev_info() or
netdev_dbg() might be more appropriate.

> +		  str_enable_disable(iet->fpe_active));
> +}
> +EXPORT_SYMBOL_GPL(icssg_config_ietfpe);

Is EXPORT_SYMBOL_GPL(icssg_config_ietfpe) needed?  The only caller
outside this file (in the follow-up ethtool MAC Merge patch) lives in
icssg_ethtool.c, which is part of the same icssg-y module as
icssg_qos.c, so no export is required.

> +
> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	iet->emac = emac;
        ^^^^^^^^^^^^^^^

Is the iet->emac back-pointer used anywhere?  A grep across
drivers/net/ethernet/ti/icssg shows it is only written here; every
function in icssg_qos.c that needs emac either receives it as a
parameter or derives it from netdev_priv().  If it has no readers, the
field and this assignment can be removed.

> +	mutex_init(&iet->fpe_lock);
> +}

[ ... ]

> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct prueth_qos_mqprio *p_mqprio;
> +	u8 num_tc = mqprio->qopt.num_tc;
> +	int tc, offset, count;
> +
> +	p_mqprio = &emac->qos.mqprio;
> +
> +	if (!num_tc) {
> +		netdev_reset_tc(ndev);
> +		p_mqprio->preemptible_tcs = 0;
> +		p_mqprio->mqprio.qopt.num_tc = 0;
> +		goto reset_tcs;
> +	}

In the num_tc == 0 (qdisc deletion) path, only software bookkeeping is
reset here.  icssg_iet_set_preempt_mask() iterates tc = 0 .. num_tc, so
with num_tc=0 no writeb() is issued to the EXPRESS_PRE_EMPTIVE_Q_MAP
table and per-queue markings written by a prior configuration persist
in firmware memory.  Should the qdisc-deletion path clear the per-queue
map as well?

> +
> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
> +	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;

Can these writes race against emac_adjust_link()?

struct prueth_qos_iet documents that p_mqprio is protected by fpe_lock,
and icssg_iet_set_preempt_mask() reads preemptible_tcs, qopt->num_tc,
qopt->offset[] and qopt->count[] under fpe_lock via
icssg_iet_change_preemptible_tcs().

However, emac_tc_setup_mqprio() writes p_mqprio here without taking
fpe_lock.  ndo_setup_tc runs under RTNL, but emac_adjust_link() is
invoked from the phylib state-machine workqueue which holds only
phydev->lock, not RTNL, so the two paths can run concurrently on
different CPUs.  While this memcpy is in flight, adjust_link can
acquire fpe_lock and observe a torn p_mqprio (for example new num_tc
with old offset/count arrays) and program incorrect
EXPRESS_PRE_EMPTIVE_Q_MAP / EXPRESS_PRE_EMPTIVE_Q_MASK values.

Should fpe_lock be held around the p_mqprio writes in
emac_tc_setup_mqprio(), rather than only around the HW-commit step?

Also, p_mqprio->preemptible_tcs is u8 while
tc_mqprio_qopt_offload::preemptible_tcs is unsigned long.  Any bits
above bit 7 are silently dropped with no error returned to userspace.
The current 4-queue hardware makes this unreachable in practice, but
should the driver either validate num_tc <= 8 via NL_SET_ERR_MSG_MOD or
widen the storage?

It also looks like mqprio->mode, mqprio->shaper, mqprio->flags, and the
min_rate[]/max_rate[] arrays are never inspected.  A user requesting
TC_MQPRIO_MODE_CHANNEL, a shaper, or rate limits will get 0 (success)
back from the kernel, but only the queue-to-TC mapping is applied.
Should the driver reject offload parameters it does not implement?

> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		count = qopt->count[tc];
> +		offset = qopt->offset[tc];
> +		netdev_set_tc_queue(ndev, tc, count, offset);
> +	}
> +
> +reset_tcs:
> +	icssg_iet_change_preemptible_tcs(emac);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_init);
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this EXPORT_SYMBOL_GPL placed at the intended function?  It follows
the closing brace of emac_tc_setup_mqprio() rather than
icssg_qos_init().  emac_tc_setup_mqprio is static so it cannot be
exported; the export of icssg_qos_init compiles regardless because the
macro references the name directly, but the placement reads like a
copy/paste slip.

> +
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,

[ ... ]

