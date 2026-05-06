Return-Path: <netdev+bounces-284657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG8QBA6e+mk8QQMAu9opvQ
	(envelope-from <netdev+bounces-284657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:49:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58424D56EE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327043090F63
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C85282F03;
	Wed,  6 May 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBob+eX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5527E056;
	Wed,  6 May 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031980; cv=none; b=oA6D5lv9faha9mpn6lCMSnts8k4MNRu5AC8oy56jjD3YbO/MUiOaigPPCpmk4kgSdbdf9EphpMPiNMtVBKErjkuLZC4GL0wEDLXt8kD9X0GOaWneLYTxYBkyDlHNK1Rnq5nVKyog7b5P4zeviAAVG3uLL2uaxdOWrhfuus8RjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031980; c=relaxed/simple;
	bh=ajK/2ALniFAv2I10bYvLOXAbvpyPHkHkekEnWZ4LHgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyxf0U1hAutG8j8i4DDwIVLkqm1hIoj/honrtLBX4fns0rvt3whc+GZmdnQcKnPHyWBMz1NoWl3sFkgClyGYabVYkGkE3zp3LW/X0w1MHRgsiYbjN8Yvhi/2vBC7hswR8gLHgwvnhNUbbkOszxc6Qv3WOVZaZhUgdUxOKf0YA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBob+eX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35931C2BCF4;
	Wed,  6 May 2026 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031979;
	bh=ajK/2ALniFAv2I10bYvLOXAbvpyPHkHkekEnWZ4LHgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBob+eX77LxtMnqQt/2VSlP2EQRCvVQQtGddkfvLUFBlXPW6woxPJHKzSCWhAWNMz
	 E6F/7gTNm8PSW68R6isMLK0rCrFfD/hFzV57Dxs/q5YUNlqTx/KMF4IvK8cUWEAbDB
	 cvcNGfWmkIn6qSvx5bo6wdsFPhWBSaz6KbS9+/3CH/sY7GwuYtbdS6wTmR4epW52MS
	 6Wkeyb+/Uo1S1bjx3C0FkGSzd9o4rqHrRez5DH+YM4yVfJyZ7gDNBzdS4sB6N9dh+v
	 H+MR3B/ATY7d8BQPUqus4r80D9MpjBRzdCgvlzFKkRhEnDt+7K/rlcapOerCDk5itv
	 ucDHAz8F8qiwg==
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
Subject: Re: [PATCH net-next v4 9/9] net: dsa: lan9645x: add port statistics
Date: Tue,  5 May 2026 18:46:18 -0700
Message-ID: <20260506014618.1616861-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-9-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-9-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A58424D56EE
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
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284657-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add port statistics

This patch wires up ethtool -S, standard ethtool group stats,
and ndo_get_stats64 for the lan9645x DSA driver. A delayed work
polls the 32-bit hardware counters every 3 seconds and accumulates
them into a 64-bit software cache to handle hardware wraparound.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 15a493c1f215..cea46bfe729e 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -255,6 +257,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  	if (!lan9645x->owq)
>  		return -ENOMEM;
>  
> +	err = lan9645x_stats_init(lan9645x);
> +	if (err) {
> +		dev_err(dev, "Failed to init stats.\n");
> +		goto owq_destroy;
> +	}
> +
>  	ds->mtu_enforcement_ingress = true;
>  	ds->assisted_learning_on_cpu_port = true;
>  	ds->fdb_isolation = true;
> @@ -265,6 +273,10 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
>  
>  	return 0;
> +
> +owq_destroy:
> +	destroy_workqueue(lan9645x->owq);
> +	return err;
>  }

Is this owq_destroy error path reachable today?

Looking at lan9645x_stats_init():

    int lan9645x_stats_init(struct lan9645x *lan9645x)
    {
        struct lan9645x_stats *stats = lan9645x->stats;

        queue_delayed_work(stats->queue, &stats->work,
                           LAN9645X_STATS_CHECK_DELAY);

        return 0;
    }

it unconditionally returns 0, so the goto owq_destroy branch is dead.

If a future change either makes lan9645x_stats_init() return an error, or
adds any fallible step after it in lan9645x_setup(), the cleanup would
fall through owq_destroy without calling lan9645x_stats_deinit(), leaving
the self-requeuing delayed work armed on stats->queue.

Also, dsa_switch_setup() in net/dsa/dsa.c does not invoke ds->ops->teardown
when ops->setup() itself fails, so lan9645x_teardown (which is where
lan9645x_stats_deinit is called today) will not run in that scenario.

Then in lan9645x_remove() -> lan9645x_stats_free() -> destroy_workqueue(),
the queue would be drained with a chained self-requeue still live. Would
adding a dedicated label that calls lan9645x_stats_deinit() before falling
through to owq_destroy be safer for future edits?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> new file mode 100644
> index 000000000000..46ac62b4016f
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c

[ ... ]

> +static const struct lan9645x_ethtool_stat lan9645x_port_ethtool_stats[] = {
> +	{ "rx_cat_drop",        SCNT_RX_CAT_DROP },
> +	{ "rx_red_prio_0",      SCNT_RX_RED_PRIO_0 },

Per Documentation/networking/statistics.rst and the netdev stats hierarchy,
counters that have a standard uAPI must not be duplicated in ethtool -S.

The rx_cat_drop counter is summed into stats->rx_dropped in
lan9645x_stats_get_stats64():

    stats->rx_dropped = c[SCNT_RX_LONG] +
                        c[SCNT_DR_LOCAL] +
                        c[SCNT_DR_TAIL] +
                        c[SCNT_RX_CAT_DROP] +
                        ...

Since rtnl_link_stats64.rx_dropped is reachable via "ip -s link show",
does exposing rx_cat_drop here duplicate a value already covered by the
standard uAPI?

[ ... ]

> +	{ "tx_drop",            SCNT_TX_DROP },

Similarly, tx_drop feeds stats->tx_dropped:

    stats->tx_dropped = c[SCNT_TX_DROP] + c[SCNT_TX_AGED];

Should tx_drop be dropped from the ethtool -S list for the same reason?

[ ... ]

> +	{ "tx_aged",            SCNT_TX_AGED },
> +	{ "tx_bufdrop",         SCNT_TX_BUFDROP },

tx_aged is also summed into stats->tx_dropped in
lan9645x_stats_get_stats64(), so does it fall under the same duplicate-uAPI
concern as tx_drop?

A related question about tx_bufdrop: if SCNT_TX_BUFDROP represents transmit
frames dropped due to buffer exhaustion, why is it not included in
stats->tx_dropped alongside SCNT_TX_DROP and SCNT_TX_AGED?

    stats->tx_dropped = c[SCNT_TX_DROP] + c[SCNT_TX_AGED];

If tx_bufdrop is in fact a transmit-drop cause, would users of
ip -s link show see an under-reported tx_dropped relative to the private
ethtool counter?

> +	{ "dr_local",           SCNT_DR_LOCAL },
> +	{ "dr_tail",            SCNT_DR_TAIL },

dr_local and dr_tail are also fed into stats->rx_dropped:

    stats->rx_dropped = c[SCNT_RX_LONG] +
                        c[SCNT_DR_LOCAL] +
                        c[SCNT_DR_TAIL] +
                        ...

Would it be appropriate to drop these from the ethtool -S list as well,
given they are already aggregated into the standard rx_dropped counter?

[ ... ]

> +};

[ ... ]

> +static void lan9645x_check_stats_work(struct work_struct *work)
> +{
> +	struct delayed_work *del_work = to_delayed_work(work);
> +	struct lan9645x_stats *stats;
> +
> +	stats = container_of(del_work, struct lan9645x_stats, work);
> +
> +	lan9645x_stats_update(stats->lan9645x);
> +
> +	queue_delayed_work(stats->queue, &stats->work,
> +			   LAN9645X_STATS_CHECK_DELAY);
> +}

The commit message says this worker "update[s] it frequently to handle
overflows in hardware."

Looking at lan9645x_stats_add_cnt():

    static inline void lan9645x_stats_add_cnt(u64 *cnt, u32 val)
    {
        if (val < (*cnt & U32_MAX))
            *cnt += (u64)1 << 32; /* value has wrapped */

        *cnt = (*cnt & ~(u64)U32_MAX) + val;
    }

this compensates for at most one 32-bit wrap per polling interval. If two
or more wraps happen between reads, the low-half comparison no longer
detects the missed wrap and the 64-bit counter silently loses 2^32 per
missed wrap.

At the chip's 2.5 Gbps line rate (LAN9645X_SPEED_2500 in lan9645x_main.h),
a 32-bit byte counter wraps roughly every 13.7 s, so two wraps happen in
about 27.5 s. The polling interval is LAN9645X_STATS_CHECK_DELAY = 3 * HZ,
but there is no upper bound on the actual elapsed time between reads:
delayed work can be stretched by system suspend/resume, heavy CPU load, or
regmap/SPI contention.

Would it be worthwhile to either bound the worst-case polling gap
(e.g. a suspend/resume hook that forces a read, or a timestamp-based
sanity check that detects a stretched interval and logs a warning) so
that rx_bytes/tx_bytes reported to ndo_get_stats64 and ethtool cannot
silently undercount by multiples of 2^32?

[ ... ]

