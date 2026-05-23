Return-Path: <netdev+bounces-291001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKLiHYMEEWr5gQYAu9opvQ
	(envelope-from <netdev+bounces-291001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE45BC58C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7274630115BC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D122A817;
	Sat, 23 May 2026 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQl9WbjW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF621A9B24;
	Sat, 23 May 2026 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500085; cv=none; b=BY26VuHiAdubWkJOZ6ZQ0lMatLFC2KXp6uD7WUj2FfCBzsVvuvKIzOwdC6Y9Up9DujFXLyKjtcQmDsc62rpZuIy+jQWky/64FOBYhAKRQozSdiO+Ce2MbMvNhmM9/yvuZWj1NAJtDND3/xor4p8gPHt8cqasDECbSzq0VYkDbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500085; c=relaxed/simple;
	bh=0bQxf6Ad688J4n2Ts/lNivUOUM6fRbPYGpN13h7ANMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzmicE8aolvkhztkokI+Py4enEjvZKFGPRkvzQ13pABMiAS6RrJ8h704HCzRM437EyYs+sYXpVSun4dbeE+sB055KE8P3lU+ZWknSIUq83za0LMGoAU4PGKk7kuHoRltDfyDFyeagQGgi6O9Zlg06xmT91Nq+df35WdLHrgpoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQl9WbjW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBAE1F000E9;
	Sat, 23 May 2026 01:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779500084;
	bh=9C5Rl2aGu0ve9hl4uk4iaJuThS9djoOx0t13wKzs+H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQl9WbjW3oKJV0tQn7/EFKVtG/1YFd+cApMHyIcTp1vGp4Kinxfb3PfCd5UAhdx56
	 fRv7COFWXcRR8/jQgfojy3y56apQ+imyu0mqQr6RK6bpwbgEn1e+RTfDGp7VnpLbPQ
	 qpAPJGI2p3ZrcsrYWyMSCU3tvqV4CU25TNCPsADzneCUyVJJQLYqWVOpYVyWdHMLh0
	 /uweVKnaISVFfu20uEgY95MjSssGAyf8Fp1cHEuHIPUv0MOJhAP2wv+4p7sA8+wSNe
	 Pr+6Pw9FDoxSiiR3+WSrOdSWyiKIh8YJjnN5qJq8J1koi2k9JJZaUahcbCva/NrTRM
	 cvxTCnXwTiarA==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namiltd@yahoo.com
Subject: Re: [net-next PATCH v5 5/8] net: dsa: realtek: rtl8365mb: add VLAN support
Date: Fri, 22 May 2026 18:34:33 -0700
Message-ID: <20260523013434.1830894-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519-realtek_forward-v5-5-cb9f702c1782@gmail.com>
References: <20260519-realtek_forward-v5-5-cb9f702c1782@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,yahoo.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 13FE45BC58C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add VLAN support

This commit adds VLAN support to the Realtek RTL8365MB switch driver.
It implements a dynamic allocation scheme to synchronize port membership
across the exhaustive 4K VLAN table and a smaller 32-entry VLANMC table
used primarily for PVID assignment.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
[ ... ]
> @@ -1210,6 +1262,197 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
>  			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
>  }
>  
> +static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
> +					  int igr_port, int egr_port,
> +					  bool enable)
> +{
[ ... ]
> +	return regmap_update_bits(priv->map,
> +			RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(egr_port),
> +			BIT(igr_port), enable ? BIT(igr_port) : 0);
> +}
[ ... ]
> +static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					 bool vlan_filtering,
> +					 struct netlink_ext_ack *extack)
> +{
[ ... ]
> +	/* However, we also enable/disable egress filtering because the switch
> +	 * still consider the egress interface VLAN membership to forward the
> +	 * traffic. We enable/disable that check disabling/enabling transparent
> +	 * VLAN between the ingress port and all other available ports.
> +	 */
> +	dsa_switch_for_each_available_port(dp, ds) {
> +		/* port isolation will still keep traffic inside the bridge */
> +		ret = rtl8365mb_port_set_transparent(priv, port, dp->index,
> +						     !vlan_filtering);
> +		if (ret)
> +			goto undo_transparent;
> +	}

This configures the hardware to bypass egress filtering for traffic
originating from port and destined to dp->index. Does this miss the
inverse operation for traffic destined to port?

When a VLAN-aware port (or the CPU port) sends traffic to this VLAN-unaware
port, the switch evaluates the egress port's VLAN membership. Since the
VLAN-unaware port is generally not a member of the frame's VLAN, will the
switch incorrectly drop the packet?

[ ... ]
> +static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
> +				   const struct switchdev_obj_port_vlan *vlan,
> +				   struct netlink_ext_ack *extack)
> +{
[ ... ]
> +	/* add port to vlan4k. It knows nothing about PVID */
> +	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
> +	if (ret)
> +		return ret;
> +
> +	/* Set PVID if needed */
> +	if (pvid) {
> +		ret = rtl8365mb_vlan_pvid_port_add(ds, port, vlan, extack);
> +		if (ret)
> +			goto undo_vlan_4k;
> +	} else {
> +		/* or try to unset it if not */
> +		ret = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
> +		if (ret)
> +			goto undo_vlan_4k;
> +	}
> +
> +	return 0;
> +
> +undo_vlan_4k:
> +	(void)rtl8365mb_vlan_4k_port_del(ds, port, vlan);
> +	return ret;
> +}

What happens to the port's hardware state if rtl8365mb_vlan_pvid_port_add()
fails (for example, the 32-entry VLAN MC table is exhausted, returning -E2BIG)?

Looking at rtl8365mb_vlan_pvid_port_add() below, it unconditionally removes the
existing PVID via rtl8365mb_vlan_pvid_port_del() before attempting to allocate
the new one. If the allocation fails, the error path aborts without restoring
the old PVID.

Furthermore, the error path then jumps to undo_vlan_4k and blindly calls
rtl8365mb_vlan_4k_port_del(). Could this permanently strip the port of its
previous PVID and disconnect it from its previously configured VLAN, leaving
hardware state desynchronized from the software bridge?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
[ ... ]
> +static int
> +rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
> +			   const struct switchdev_obj_port_vlan *vlan,
> +			   struct netlink_ext_ack *extack,
> +			       bool include)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb_vlan4k vlan4k = {0};
> +	int ret;
[ ... ]
> +	ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
> +	if (ret) {
> +		RTL_VLAN_ERR("Failed to read VLAN 4k table");
> +		return ret;
> +	}
> +
> +	if (include)
> +		vlan4k.member |= BIT(port);
> +	else
> +		vlan4k.member &= ~BIT(port);
[ ... ]
> +	ret = rtl8365mb_vlan_4k_write(priv, &vlan4k);

Since the switch uses read-modify-write operations to update the global
VLAN 4K and VLAN MC tables, could this cause a Time-of-Check to Time-of-Use
race?

While the underlying priv->map_lock protects individual read or write queries,
it is released between them. If concurrent switchdev operations are triggered
on different ports for the same VLAN ID, could one update silently overwrite
and revert the other?

[ ... ]
> +static int rtl8365mb_vlan_mc_find(struct realtek_priv *priv, u16 vid,
> +				  u8 *index, u8 *first_free)
> +{
[ ... ]
> +	for (vlanmc_idx = 1; vlanmc_idx <= RTL8365MB_VLAN_MCMAX; vlanmc_idx++) {
> +		/* just read the 4th word, where the evid is */
> +		ret = regmap_read(priv->map,
> +				  RTL8365MB_VLAN_MC_REG(vlanmc_idx) + 3,
> +				  &vlan_entry_d3);
> +		if (ret)
> +			return ret;
> +
> +		evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlan_entry_d3);
> +
> +		if (evid == vid) {
> +			*index = vlanmc_idx;
> +			return 0;
> +		}
> +
> +		if (evid == 0x0 && *first_free < 1)
> +			*first_free = vlanmc_idx;
> +	}
> +	return 0;
> +}

Does treating evid == 0x0 as an empty slot risk corrupting PVID assignments if
a user configures VID 0 as a valid PVID?

Linux supports configuring VID 0 (for priority-tagged frames) on user ports.
If a port sets VID 0 as its PVID, it will be assigned a hardware slot where
evid = 0.

When a subsequent port requests a different PVID, the allocator might see
evid == 0, assume the slot is free, and overwrite it. Should the allocator
verify the member mask instead to determine if a slot is genuinely empty?

[ ... ]
> +int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan)
> +{
[ ... ]
> +	/* Changing accept frame is what really removes PVID */
> +	accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
> +	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);

When a PVID is removed, the driver sets the port's frame filter to
RTL8365MB_FRAME_TYPE_TAGGED_ONLY to drop untagged frames.

If the port later transitions to a VLAN-unaware bridge or standalone mode,
rtl8365mb_port_vlan_filtering(ds, port, false, ...) is called.

Since that function disables ingress filtering but leaves the frame filter
untouched, will the port continue to silently drop all untagged traffic at the
MAC level, breaking standard network connectivity?

