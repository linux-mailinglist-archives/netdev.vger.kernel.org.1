Return-Path: <netdev+bounces-284654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKYUFqWd+mk+QQMAu9opvQ
	(envelope-from <netdev+bounces-284654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7854D5678
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3FE3032672
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C423C368;
	Wed,  6 May 2026 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWvs2Le9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95D1A9FB0;
	Wed,  6 May 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031972; cv=none; b=PMIobVjNy91tN3KKt9ZH5S44TbiEGGjKYRe7/wmfsg6UYZA4UWC/2xmX99oHcoyiWoO1OS/yL4ray9Eyd/4lgEzc+VrzEf1X2D5FUh7iL//q/vD38avkg0rGfTu5h8m0K0lk7JhXRDgZS9RSljZQEqzemqnNzPV3DXUuEmEcHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031972; c=relaxed/simple;
	bh=ConUqpuXV5m6p0GyI5XqoUJSLDZ8f+XikS9Af51LKfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugYzDlIQquEWLXovq+1YuKUO50TiAeMFU05LcZGx14s2ehtuLoQA4t79Xioa60hCiS/pRNJXHP+ngrNDSpKoC/bgmTb2ATNanB/7BgGy2oKUMvG/ubqqHnSmuEqJCXPh5RqxaGEai66KYg7cNGnFm4PpPmqPGM254jUUQAeXGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWvs2Le9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9EC2BCB4;
	Wed,  6 May 2026 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031971;
	bh=ConUqpuXV5m6p0GyI5XqoUJSLDZ8f+XikS9Af51LKfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWvs2Le9yeRK4GGUTv5gbWugf24G4FAAu4VpI4suNcQqsmUP1i3HkgDsCTzFGzqnE
	 6oNH45pn71LAmShj7qYYA+evdio9BMUXorOvx0Z0Y069mi8zyMqvqZNhlXr+n1LxGU
	 mjQrcF9sx8rMwWPqynzZfiIAzgQswEPKGi3MclZiw8MCWbCQq0wTkFyQR/zCf9KjYx
	 Am7NZnR//lUEEyo0XOKNVWfuoq5ASLx7PPyEUvG9ujOiCSF1awqRYXBGre1RoXPxfJ
	 HKFxl+SNdEBA26W2GAeM1HEwL4gfrG5PfdmGRGTMg39jTYAP9oUxr7EPOlUU5udI9U
	 iiRDDp2Yaa+zg==
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
Subject: Re: [PATCH net-next v4 5/9] net: dsa: lan9645x: add bridge support
Date: Tue,  5 May 2026 18:46:08 -0700
Message-ID: <20260506014609.1616782-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-5-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-5-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE7854D5678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284654-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add bridge support

This patch adds hardware offload support for a single bridge device in
the lan9645x DSA driver. It introduces the fwd_domain_lock mutex and an
ordered workqueue, and wires up the bridge-integration switch ops.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 6fd66ea67cfd..70f6a11f0753 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -67,7 +67,9 @@ static void lan9645x_teardown(struct dsa_switch *ds)
>  {
>  	struct lan9645x *lan9645x = ds->priv;
>  
> +	destroy_workqueue(lan9645x->owq);
>  	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> +	mutex_destroy(&lan9645x->fwd_domain_lock);
>  }

[ ... ]

> @@ -133,6 +135,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  		return err;
>  	}
>  
> +	mutex_init(&lan9645x->fwd_domain_lock);
> +
>  	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
>  	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
>  	       ANA_AGGR_CFG_AC_DMAC_ENA,

[ ... ]

> @@ -239,6 +243,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  
>  	lan9645x_port_set_tail_drop_wm(lan9645x);
>  
> +	lan9645x->owq = alloc_ordered_workqueue("%s-owq", 0,
> +						dev_name(lan9645x->dev));
> +	if (!lan9645x->owq)
> +		return -ENOMEM;
> +

Does this error path leak the fwd_domain_lock initialization and the
NPI port setup?

When alloc_ordered_workqueue() fails, lan9645x_setup() returns -ENOMEM
directly.  In DSA, dsa_switch_setup() handles a failed ds->ops->setup()
by jumping past the teardown label:

    err = ds->ops->setup(ds);
    if (err < 0)
        goto unregister_notifier;

So lan9645x_teardown() is never invoked on the setup failure path, and
the mutex_destroy(&lan9645x->fwd_domain_lock) and
lan9645x_npi_port_deinit() calls it contains are skipped.

With CONFIG_DEBUG_MUTEXES or lockdep enabled, the mutex debug state is
left dangling against devm-managed memory, and the NPI port hardware
configuration performed by lan9645x_tag_npi_setup() is left in place
until the next reset_switch().

Should the failure path of lan9645x_setup() unwind the mutex_init()
and lan9645x_tag_npi_setup() it performed earlier?

>  	ds->mtu_enforcement_ingress = true;
>  	ds->assisted_learning_on_cpu_port = true;
>  	ds->fdb_isolation = true;
> @@ -257,6 +266,272 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
>  	lan9645x_phylink_get_caps(ds->priv, port, config);
>  }
>  
> +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> +{
> +	u32 age_secs = max(1, msecs / MSEC_PER_SEC / 2);
> +	struct lan9645x *lan9645x = ds->priv;
> +
> +	/* Entry is must suffer two aging scans before it is removed, so it is
> +	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
> +	 * An age period of 0 disables automatic aging.
> +	 */
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);
> +	return 0;
> +}

Can this silently truncate user-supplied ageing times that exceed the
hardware field?

ANA_AUTOAGE_AGE_PERIOD is GENMASK(20, 1), so the maximum representable
age_secs is 2^20 - 1 = 1048575.  ANA_AUTOAGE_AGE_PERIOD_SET() expands
to FIELD_PREP(), whose runtime path in include/linux/bitfield.h is:

    ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)

which masks the value without any range check or warning.

The driver does not populate ds->ageing_time_min or ds->ageing_time_max,
and dsa_switch_ageing_time() gates its -ERANGE checks on those being
non-zero:

    if (ds->ageing_time_min && ageing_time < ds->ageing_time_min)
        return -ERANGE;
    if (ds->ageing_time_max && ageing_time > ds->ageing_time_max)
        return -ERANGE;

so a large ageing time set via "ip link set br0 type bridge ageing_time
<large>" reaches this callback and is silently truncated to a short
period.  Should lan9645x set ageing_time_min/max so out-of-range values
are rejected instead?

[ ... ]

> +static void lan9645x_host_flood_work_fn(struct work_struct *work)
> +{
> +	struct lan9645x_port *p = container_of(work, struct lan9645x_port,
> +					       host_flood_work);
> +	struct lan9645x *lan9645x = p->lan9645x;
> +
> +	mutex_lock(&lan9645x->fwd_domain_lock);
> +	__lan9645x_port_mark_host_flood(lan9645x, p->chip_port,
> +					p->host_flood_uc, p->host_flood_mc);
> +	__lan9645x_port_set_host_flood(lan9645x);
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +}
> +
> +/* Called in atomic context. */
> +static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int port,
> +					 bool uc, bool mc)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	p->host_flood_uc = uc;
> +	p->host_flood_mc = mc;
> +	queue_work(lan9645x->owq, &p->host_flood_work);
> +}

Can the worker observe a mixed (uc, mc) tuple that no caller requested?

The atomic-context writer stores p->host_flood_uc and p->host_flood_mc
as two independent unsynchronized writes and then queues the work.  The
worker takes fwd_domain_lock and reads both, but the writer never takes
that lock (it cannot — it is called in atomic context, and fwd_domain_lock
is a mutex).

If a second update arrives between the worker's two reads, the worker
can program PGID_UC/MC/MCIPV4/MCIPV6 on the CPU port with a combination
that was never requested by either call.  The state converges on the
next work run triggered by the second queue_work(), but the hardware is
transiently programmed with a tuple nobody asked for.

Would it be safer to bundle both booleans into a single atomic word, or
to use a spinlock that can be taken in atomic context to protect the
pair of stores?

> +
> +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)

[ ... ]

