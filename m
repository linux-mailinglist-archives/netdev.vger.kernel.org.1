Return-Path: <netdev+bounces-272999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM9hMxGEyWnfygUAu9opvQ
	(envelope-from <netdev+bounces-272999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:57:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA7353DCA
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 042DA3001A4F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49338838F;
	Sun, 29 Mar 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsL2LNAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DFF40DFA9;
	Sun, 29 Mar 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814193; cv=none; b=pezQCQeIrLRA+kDDZyg00SF+OQ0oOqXF4y2A7OLkiXbg5Wl5SB7zr3/9Io00jO7dqpeZNZRl2/HC2mVyajtOHV2H9REJdVaAM8dRaGAhTC21zq/PYa+vLYr7ONYJqOqPTmqlZl/6sQUTqNQXNu7FsGKlEe13NYHLElLExM8jdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814193; c=relaxed/simple;
	bh=i2T1CFcPDnOMaQowK7m4si7gej8YKdhMTnXPDpYZjwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lqu/TprxMRHKs+l92dv2ghRjDX3s2lSfZdl9o5u0TR9h+Wp9y3fOgfEhxJiJ3haQ5OE/s3QTq2KWUZv/HvCONe71H/hMGcauuq+k8zez9Jd/cKqMDSiWFuhDxVNfwOWu0BrkIc7hXbJo+M0+HCnmmAWb9pw/ym+ggUGQRKvK/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsL2LNAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A0DC116C6;
	Sun, 29 Mar 2026 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814193;
	bh=i2T1CFcPDnOMaQowK7m4si7gej8YKdhMTnXPDpYZjwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsL2LNAqh9JNlqljhwq8AywvLyNX/6NMVXqX6UU9E1hkSjnVkdkNqR8AppfQo8g0n
	 XrqWY2wduVyYQcj/zT5CQW0XvULuQdtaM1w94O0V8+ojWZ+BdsQnnuDi76J4tI/8B7
	 2hrOxi2/H8WGvhsr3Vnelpq8CDRFm4n3dktcxmSUw0pcXScMEvJNb/Ba+tYwIpes9S
	 xb5waxR0oEmtv7RQ3QvePPQHN55MVw6FGCkP4AGZ81dailW3kwrsfyjlZodIMrf0CS
	 E6g8k3DE+0Ag2Tob4eavAY2bYwyaUfM2GIk59IrOm83l6UUQoyJ/uRadEHv90RhAxk
	 B4z4N3RZb7Hww==
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
Subject: Re: [PATCH net-next v2 5/9] net: dsa: lan9645x: add bridge support
Date: Sun, 29 Mar 2026 12:56:31 -0700
Message-ID: <20260329195631.2789158-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-5-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-5-f7504e3b0681@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-272999-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDDA7353DCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add bridge support

This commit adds support for hardware offloading of the bridge in the
lan9645x DSA driver. It enables a single bridge device to be used with
the switch.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index a0908cbf89c7..599e589c4ec3 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
[ ... ]
> @@ -145,6 +155,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  		return err;
>  	}
>  
> +	mutex_init(&lan9645x->fwd_domain_lock);
> +
>  	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
>  	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
>  	       ANA_AGGR_CFG_AC_DMAC_ENA,
[ ... ]
> @@ -240,6 +252,11 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  
>  	lan9645x_port_set_tail_drop_wm(lan9645x);
>  
> +	lan9645x->owq = alloc_ordered_workqueue("%s-owq", 0,
> +						dev_name(lan9645x->dev));
> +	if (!lan9645x->owq)
> +		return -ENOMEM;
> +

Is it possible that the hardware remains initialized if the call to
alloc_ordered_workqueue fails? Because the setup callback returns an error,
the DSA core will skip the teardown callback. This would bypass
lan9645x_npi_port_deinit, potentially leaving the conduit netdev in a
corrupted state with hardware tagging enabled.

Also in lan9645x_setup, the initialization loop for PGID_ENTRIES iterates
through index 88:

for (int i = 0; i < PGID_ENTRIES; ++i)
        lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
               lan9645x, ANA_PGID_CFG(i));

Could this leave the CPU port's source configuration in an undefined state?
The CPU port is port 9, which has its source analysis register at PGID_SRC
(80) + 9 = 89, but the loop terminates before reaching it.

> @@ -258,6 +275,271 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
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
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(age_secs),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);
> +	return 0;
> +}

Does this function properly disable automatic aging when requested? When the
Linux bridge passes msecs = 0 to disable aging, the max macro evaluates to 1.
Since writing 1 configures an aggressive 2-second aging period, it appears
this might not fulfill the user's intent.

[ ... ]
> +static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x, int port,
> +					   bool uc, bool mc)
> +{
> +	bool mc_ena, uc_ena;
> +
> +	lockdep_assert_held(&lan9645x->fwd_domain_lock);
> +
> +	/* We want promiscuous and all_multi to affect standalone ports, for
> +	 * debug and test purposes.
> +	 *
> +	 * However, the linux bridge is incredibly eager to put bridged ports in
> +	 * promiscuous mode.
> +
> +	 * This is unfortunate since lan9645x flood masks are global and not per
> +	 * ingress port. When some port triggers unknown uc/mc to the CPU, the
> +	 * traffic from any port is forwarded to the CPU.
> +	 *
> +	 * If the host CPU is weak, this can cause tremendous stress. Therefore,
> +	 * we compromise by ignoring this host flood request for bridged ports.
> +	 */
> +	if (lan9645x_port_is_bridged(lan9645x_to_port(lan9645x, port)))
> +		return;

Will ignoring the host flood request for bridged ports break IPv6 Neighbor
Discovery? IPv6 ND relies on multicast, and the PGID_MC and PGID_MCIPV6 masks
do not include the CPU port by default. By ignoring the bridge's request to
enable multicast flooding, the CPU port may fail to receive ICMPv6 ND packets.

[ ... ]
> +/* Called in atomic context */
> +static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int port,
> +					 bool uc, bool mc)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_host_flood_work *w;
> +
> +	w = kzalloc_obj(*w, GFP_ATOMIC);

Is kzalloc_obj an available kernel function? Using it might cause a build
error, as the standard API would be kzalloc(sizeof(*w), GFP_ATOMIC).

> +	if (!w)
> +		return;

Are there consequences to returning silently when the allocation fails?
If this allocation fails under memory pressure, the network stack will still
assume the configuration was successfully applied, leaving the hardware state
out of sync.

[ ... ]
> +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
> +{
[ ... ]
> +	/* The bridge puts ports in IFF_ALLMULTI before calling
> +	 * port_bridge_join, so clean up before the port is marked as bridged.
> +	 */
> +	__lan9645x_port_set_host_flood(lan9645x, port, false, false);
> +	lan9645x->bridge_mask |= BIT(p->chip_port);
> +
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +
> +	/* Later: stp_state_set updates forwarding */
> +
> +	return 0;
> +}

Could clearing the host flood masks here lead to lost hardware state when the
port leaves the bridge? If a user previously enabled IFF_PROMISC or
IFF_ALLMULTI on the standalone port, the software netdev flags remain set.
When lan9645x_port_bridge_leave is called, it does not restore the hardware's
promiscuous or multicast state to match the unchanged software flags.

> +static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, int port,
> +					       u8 state)
> +{
> +	struct lan9645x *lan9645x;
> +	struct lan9645x_port *p;
> +	bool learn_ena;
> +
> +	lan9645x = ds->priv;
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	mutex_lock(&lan9645x->fwd_domain_lock);
> +
> +	p->stp_state = state;
> +
> +	if (state == BR_STATE_FORWARDING)
> +		lan9645x->bridge_fwd_mask |= BIT(p->chip_port);
> +	else
> +		lan9645x->bridge_fwd_mask &= ~BIT(p->chip_port);
> +
> +	learn_ena = (state == BR_STATE_LEARNING ||
> +		     state == BR_STATE_FORWARDING) && p->learn_ena;
> +
> +	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(learn_ena),
> +		ANA_PORT_CFG_LEARN_ENA, lan9645x,
> +		ANA_PORT_CFG(p->chip_port));
> +
> +	lan9645x_update_fwd_mask(lan9645x);
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +}

Are ingress data frames correctly dropped for ports in non-forwarding STP
states? When the port is removed from bridge_fwd_mask,
lan9645x_update_fwd_mask calculates the source PGID mask as
bridge_mask & bridge_fwd_mask & ~BIT(dp->index).

This evaluates to the set of all other forwarding ports in the bridge. Since
ingress forwarding is not explicitly disabled on the port (for example, by
setting ANA_PORT_CFG_PORTID_VAL to NONE), data frames received on a blocking
or learning port can enter the analyzer and be forwarded.

> +static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
> +				       struct dsa_bridge bridge)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	mutex_lock(&lan9645x->fwd_domain_lock);
> +
> +	lan9645x->bridge_mask &= ~BIT(p->chip_port);
> +
> +	/* Last port leaving clears bridge dev */
> +	if (!lan9645x->bridge_mask)
> +		lan9645x->bridge = NULL;
> +
> +	lan9645x_update_fwd_mask(lan9645x);
> +
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +}

Should p->learn_ena be reset when a port leaves the bridge?

During port_bridge_flags, p->learn_ena is set to true. When leaving the
bridge, this flag remains true. The DSA core will transition the leaving
port to BR_STATE_FORWARDING, which calls lan9645x_port_bridge_stp_state_set
and leaves hardware learning enabled. This can pollute the shared FDB with
MAC addresses from standalone ports, leading to silent packet drops if
bridged ports attempt to forward traffic to them.

