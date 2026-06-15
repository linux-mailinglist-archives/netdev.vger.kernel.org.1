Return-Path: <netdev+bounces-299652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8oOF4SGMGp3UAUAu9opvQ
	(envelope-from <netdev+bounces-299652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8A68A8AA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iGwr7zBN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299652-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299652-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3393027732
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357B3BED69;
	Mon, 15 Jun 2026 23:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0B3BED7F;
	Mon, 15 Jun 2026 23:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565045; cv=none; b=Ewb4Emsp/ehEjZ7+L3w8YYQhmrpQkeoxNRpz48fVsQYD7mGsyCJe9K+aVd/S3cyVnOi36Fk08pWj1uK2MXbBKWYFmBBHLvu5v4Jic5OUpNaMNGYkLJANrktXY/dgf9mJcO3afqp4BFvRmXdpMiv55qIlXCAQFJS0rZzlnLTco28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565045; c=relaxed/simple;
	bh=nh2ZVelkHcgHhpvBoS7VgoxxEMRc2vriMNrlcqsI1EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH/bPfmcpHs8f+sU4dHqLwwAmjsjU60BivxnmDrgBFO9YbLrk0WAXEnR0QKVgtW/owYYJxtnFX4VifSon2RMKTGkCSBQHDbbetP93ECYMIjL8+qMaAUTOOqpcb/WCHuRB8ud92rVrkKyq2nMtwj3qyloLwUx5zpp6mhmLNEjxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGwr7zBN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6101F00A3A;
	Mon, 15 Jun 2026 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565043;
	bh=dGbxXT/pVHsXNvjvWTH/s4OWFo76S/tTWfx5JzOHeK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGwr7zBN59E45Eq1/uBBOSQAj5QlUIhTt+JY8W2hohvuo97pXwr84Q/rmZhcMkpWu
	 sOd3jRMj68zipH4xBUKX5bM3thTkTsOc0DFe3IZU+zZxxSKafKovjKeu6/sHzfBcb/
	 dAbDOPF8trhoMdJhrz0yHG/BdEeY3KhmLhawHyzYozrZ0g8mwhYIvK4AP/9vMoGwfp
	 4zdVBq3uBtNe7GiujazQvYNraasQpbJhdyy8MXhJ/qtn/5/b4VEciNfXnOYZDYim4+
	 E6TD19Zt8+p5gshPmKN1dypjUnjp15XbGCuXlXQnUm50QUmgN0HqmqnRz+CvL3bZFW
	 CI5pZH4GSXQIg==
From: Jakub Kicinski <kuba@kernel.org>
To: m-malladi@ti.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	elfring@users.sourceforge.net,
	haokexin@gmail.com,
	vadim.fedorenko@linux.dev,
	devnexen@gmail.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	arnd@arndb.de,
	basharath@couthit.com,
	afd@ti.com,
	parvathi@couthit.com,
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
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Mon, 15 Jun 2026 16:10:41 -0700
Message-ID: <20260615231041.1007484-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610052511.781752-3-m-malladi@ti.com>
References: <20260610052511.781752-3-m-malladi@ti.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:kuba@kernel.org,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,users.sourceforge.net,gmail.com,linux.dev,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF8A68A8AA

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

This patch wires up the ethtool MAC Merge ops (.get_mm, .set_mm,
.get_mm_stats) for the ICSSG PRU Ethernet driver and adds five firmware
preemption counters that feed both the new MM stats and the existing
ethtool -S table.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23a..0620782318ab 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -294,6 +294,103 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,

[ ... ]

> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int err;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	if (!cfg->pmac_enabled) {
> +		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	mutex_lock(&iet->fpe_lock);
> +	iet->verify_time_ms = cfg->verify_time;
> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
> +	iet->fpe_enabled = cfg->tx_enabled;
> +	iet->mac_verify_configure = cfg->verify_enabled;
> +	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	return err;
> +}

[Medium]
Can the cached software state in iet diverge from the hardware here when
icssg_config_ietfpe() fails?

The new fields (verify_time_ms, tx_min_frag_size, fpe_enabled,
mac_verify_configure) are written to iet before icssg_config_ietfpe() is
called, but the error paths in icssg_config_ietfpe() only roll back a
subset of state:

icssg_qos.c:icssg_config_ietfpe() {
    ...
disable_tx:
        icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
fallback:
        writeb(0, config + PRE_EMPTION_ENABLE_TX);
        writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
        iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
        iet->fpe_active =  false;
        return ret;
}

iet->fpe_enabled is left set to cfg->tx_enabled even though the hardware
TX preempt path has been disabled.

Two follow-on effects appear to come from this:

emac_get_mm() reports state->tx_enabled = iet->fpe_enabled, so userspace
sees tx_enabled=true after a set_mm that returned an error and left FPE
disabled in hardware.

icssg_qos_link_state_update() drives icssg_iet_change_preemptible_tcs(),
which calls icssg_config_ietfpe(emac->ndev, iet->fpe_enabled) on every
link transition, so the failed configuration is retried each link-up
without further user action.

Would it make sense to stage cfg into local variables, only commit them
to iet after icssg_config_ietfpe() returns success, or otherwise
restore the previous iet fields on the error return?

> +static void emac_get_mm_stats(struct net_device *ndev,
> +			      struct ethtool_mm_stats *s)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	if (emac->is_sr1)
> +		return;
> +
> +	if (!emac->prueth->pa_stats)
> +		return;
> +
> +	emac_update_hardware_stats(emac);
> +
> +	/* MACMergeHoldCount stats is not tracked by the firmware */
> +	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
> +	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
> +	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
> +	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
> +	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 5ec0b38e0c67..8073deac35c3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>  	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>  	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>  	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>  	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>  	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>  	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),

[Medium]
Are these five new entries duplicating values that already have a
standard uAPI?

The same five firmware counters are exposed through the new
.get_mm_stats callback as the standardized MAC Merge stats
(MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount, MACMergeFragCountRx,
MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
publishes them via emac_get_strings() / emac_get_ethtool_stats() as
ethtool -S strings.

Documentation/networking/statistics.rst describes ethtool -S as the
private-driver-stats interface; counters that have a standard uAPI are
expected to flow only through that uAPI.

Could the firmware-register lookup table used by emac_get_stat_by_name()
be separated from the ethtool -S string table, so the new preemption
counters feed get_mm_stats without also showing up under ethtool -S?

