Return-Path: <netdev+bounces-273000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFPVLB6EyWndygUAu9opvQ
	(envelope-from <netdev+bounces-273000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF8353DD9
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A9D30162A3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAF389E08;
	Sun, 29 Mar 2026 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjsh19Gx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72A38910E;
	Sun, 29 Mar 2026 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814195; cv=none; b=gZVSdmKzjXwYppgcj7O0/WYnU/Vt3orYAmaop4N/2xvaUbQyFQprDMDMtltlLtmD/bb3DWcT7Gr2rfDVO7Vqwd6wZ4RcA3GXYJQaAcLnLrl3vZB4+4DvIwRDR+kgK0Tss8ZeNpJkm5bl1moGOdWq/HebAz/ANTInJruI6OKcd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814195; c=relaxed/simple;
	bh=MK+ePEwES/dgegXojx7V/J1MPYRFj5607DJ7n5NwjTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPmar9asKlnpLVnt5Wh6gmsk21CWPtmc9mXsH3bUTjUFOuFm0gFHPs2zbkWKzAee/MuVb9FTXLajYa1hgqFpusWver0Ae9pZRJqgTSmvxbibptOCLHl5KobpeyoaOkT7nsnCmib62Od73E33ji7qQz47HqYJJZ+k5gJNu18JSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjsh19Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E591C116C6;
	Sun, 29 Mar 2026 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814195;
	bh=MK+ePEwES/dgegXojx7V/J1MPYRFj5607DJ7n5NwjTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjsh19Gx5HWF3UcVJNBXgAJb9/JnB3g2mXjzVlyFPnUqsKZ9A8QyqyPgLIFdrzORV
	 Kx0PGJGUhS3QjO16PQIpEZuOyuNNgiTeIa74QQoMnQFtYSth8W5OKKmKhoOAfDvIFy
	 IeqnfGnAiAMkySEPxgtbG7kKJIXiyjprt3EtlaiCL0TfNi7++w0vPICCw6M3bFdPS5
	 KTcM8wiYKoluqZkD8YmQOHxn75tXHIYc07gOADZdv4DsRb0Nlmgc/Hi6bx/bIqDYsH
	 QAy1RKyyHCOrhDNChIKb6OgywWgUWAFAjCqiggKDGijEquPrppDR6/bngRZ75SFwiv
	 tVC8SK4ZLnZ5g==
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
Subject: Re: [PATCH net-next v2 6/9] net: dsa: lan9645x: add vlan support
Date: Sun, 29 Mar 2026 12:56:33 -0700
Message-ID: <20260329195633.2789187-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-6-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-6-f7504e3b0681@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-273000-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71EF8353DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add vlan support

Add support for vlanaware bridge. We reserve vid 4095 for standalone
mode, to implement fdb-isolation. A vlan-unaware bridge uses vid 0.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 599e589c4ec3..046c95a72242 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
[ ... ]
> @@ -535,11 +536,54 @@ static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
[ ... ]
> +static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					bool enabled,
> +					struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +	p->vlan_aware = enabled;
> +	lan9645x_vlan_port_apply(p);

In other places, the driver avoids calling egress functions on the npi
port because it conflicts with cpu port header extraction. Since this
unconditionally applies the vlan configuration to both ingress and egress,
could this overwrite the npi port's configuration when the state is
synchronized?

> +
> +	return 0;
> +}
> +
> +static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
[ ... ]
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 000000000000..0459932a626c
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
[ ... ]
> +static void lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
> +{
> +	struct lan9645x_vlan *v = &lan9645x->vlans[vid];
> +	bool cpu_dis = !(v->portmask & BIT(CPU_PORT));
> +	u32 val;
> +
> +	val = ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
> +	      ANA_VLANTIDX_V_INDEX_SET(vid) |
> +	      ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(v->s_fwd_ena) |
> +	      ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(v->fld_dis) |
> +	      ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(v->prv_vlan) |
> +	      ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(v->lrn_dis) |
> +	      ANA_VLANTIDX_VLAN_MIRROR_SET(v->mir) |
> +	      ANA_VLANTIDX_VLAN_SRC_CHK_SET(v->src_chk);
> +
> +	lan_wr(val, lan9645x, ANA_VLANTIDX);
> +	lan_wr(v->portmask, lan9645x, ANA_VLAN_PORT_MASK);
> +	lan_wr(VLANACCESS_CMD_WRITE, lan9645x, ANA_VLANACCESS);

Are these registers written with raw values rather than using their respective
set macros? This circumvents the register abstraction and might risk failures
if the hardware layout changes.

> +
> +	if (lan9645x_vlan_wait_for_completion(lan9645x))
> +		dev_err(lan9645x->dev, "Vlan set mask failed\n");
> +}
[ ... ]
> +static void
> +lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
> +				struct lan9645x_vlan_port_info *info)
> +{
[ ... ]
> +	lan_rmw(REW_TAG_CFG_TAG_TPID_CFG_SET(3) |
> +		REW_TAG_CFG_TAG_CFG_SET(tag_cfg),
> +		REW_TAG_CFG_TAG_TPID_CFG |
> +		REW_TAG_CFG_TAG_CFG,
> +		lan9645x, REW_TAG_CFG(p->chip_port));
> +
> +	lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
> +		REW_PORT_VLAN_CFG_PORT_VID_SET(port_vid),
> +		REW_PORT_VLAN_CFG_PORT_TPID |
> +		REW_PORT_VLAN_CFG_PORT_VID,
> +		lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
> +}

Setting the port tpid to 0x88a8 causes untagged ingress frames to egress trunk
ports with 802.1ad tags. Could this break interoperability with standard
networks that expect 0x8100 tags?

> +static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
> +{
[ ... ]
> +	/* Drop frames with multicast source address */
> +	val = ANA_DROP_CFG_DROP_MC_SMAC_ENA_SET(1);
> +	if (p->vlan_aware && !pvid)
> +		/* If port is vlan-aware and tagged, drop untagged and priority
> +		 * tagged frames.
> +		 */
> +		val |= ANA_DROP_CFG_DROP_UNTAGGED_ENA_SET(1) |
> +		       ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
> +		       ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
> +
> +	lan_wr(val, lan9645x, ANA_DROP_CFG(p->chip_port));
> +}

Does this overwrite the entire 32-bit register and silently clear other
initialized bitfields? Would it be safer to use a read-modify-write here
instead?

[ ... ]
> +static int lan9645x_vlan_cpu_add(struct lan9645x_port *p, u16 vid, bool pvid,
> +				 bool untagged)
> +{
> +	struct lan9645x_vlan *v;
> +
> +	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);

Is it intentional that this bypasses the bounds check on the vlan id?

> +	v->portmask |= BIT(CPU_PORT) | BIT(p->chip_port);
> +	lan9645x_vlan_hw_wr(p->lan9645x, vid);
> +	lan9645x_vlan_port_apply_ingress(p);
> +
> +	return 0;
> +}
> +
> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{
[ ... ]
> +void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
> +{
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	struct lan9645x_vlan *v;
> +
> +	if (!vid)
> +		return;
> +
> +	v = lan9645x_vlan_port_modify(p, vid, false, false);

There is a check for the maximum vlan id when adding a vlan, but no bounds
check when deleting one. Could userspace use this to delete the reserved
vid 4095 and break standalone forwarding?

> +	v->portmask &= ~BIT(p->chip_port);
> +
> +	if (p->chip_port == lan9645x->npi)
> +		v->portmask &= ~BIT(CPU_PORT);
> +
> +	lan9645x_vlan_hw_wr(lan9645x, vid);
[ ... ]
> +void lan9645x_vlan_init(struct lan9645x *lan9645x)
> +{
[ ... ]
> +	for (vid = 1; vid < VLAN_N_VID; vid++)
> +		lan9645x_vlan_hw_wr(lan9645x, vid);

If the indirect table access times out, the write function prints an error
but does not return a status code. Will this cause the initialization loop
to stall for the full timeout duration 4095 consecutive times if the
hardware is unresponsive?

> +
> +	/* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PVID */
> +	lan9645x->vlans[HOST_PVID].portmask = all_ports;

