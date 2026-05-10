Return-Path: <netdev+bounces-286358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOspBMLBAGppMQEAu9opvQ
	(envelope-from <netdev+bounces-286358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6950570B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1593730055A2
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D03B47C1;
	Sun, 10 May 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxRpHHxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F33B3BF2;
	Sun, 10 May 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434491; cv=none; b=eRrMbvLRO4PqTggu/vFqBgs7kCjBsP/WzXi3qud6HwtMH656KWNJeFw0bQ/6wmPjva5sjVMLNHBJAeHnpDG7FQQgzLOTzvmwzbQxR2r1Xa7NGJWa2QhJfhe85ps+mThhwcminyFPZ49w+1tau86fORn6HSTHKl3oLGd7D1t64L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434491; c=relaxed/simple;
	bh=Xcir15zcTFzhYcPFbIGvMFBRePPsOP3hF8+zNx+cU4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcU8wnVEEoY3KLYZXUDYMWLyPMpJOLBB09SzQUtEBKMcivLKZrxE8BHqOcC557LUKgpKPhYRr3ZCpXjE8YCKoMseywqtKo6+jIRhEJQIIqBFplW97+0K98DQTMC6CGch3t9auUmHNY7wiv7WKsYycWy6muy5auPqcit3Gbgpnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxRpHHxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A63DC2BCF7;
	Sun, 10 May 2026 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434490;
	bh=Xcir15zcTFzhYcPFbIGvMFBRePPsOP3hF8+zNx+cU4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxRpHHxZ3uHvHL1NM5TjPRH1waaPLT7irSJ8s5ikQ4ocliSblilf7CaE8vfhv6Ryh
	 8S5V3SNhQd0+pLsMghFO/+7QAttBNQAgaRAOZcLDxS3xy7B+1CfclbDX1vM9spFeep
	 ldwBYvvrLJjwcVSA+YZwk3DyY4zQn/r+j+VREBCIUtnydKR1/bTBmVUAiOI0Dkvq+r
	 hapMWYicVaabwpGJX9fb5PwPU5iW6RdCc0T6GjY04e1q0yFFyv0jtEULwo4RXEeh2V
	 5vMWx3kmWz6PHdSlGbbBDGVRhSu8izec5bPQ2PgHsAit508XURhkRtbjsu8PCT3Hsf
	 dwxFX463mPWCg==
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
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 5/8] net: dsa: realtek: rtl8365mb: add VLAN support
Date: Sun, 10 May 2026 10:34:49 -0700
Message-ID: <20260510173449.3919848-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94C6950570B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286358-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: dsa: realtek: rtl8365mb: add VLAN support

This patch adds VLAN support for the rtl8365mb switch family, using the
4096-entry VLAN4K table as the source of truth for membership and
dynamically allocating entries from the 32-entry VLAN MC table to back
per-port PVID assignments. Standalone ports use VLAN-transparent mode
combined with port isolation, and filtering is toggled per-port via
ingress filtering, transparent mode and the egress tag-mode register.

[Low]
Regarding this portion of the commit message:

    Once a member in a bridge, the port isolation is expanded to include
    the bridge members. When that bridge enables VLAN filtering, the VLAN
    transparent feature is disabled, letting the switch filter based on
    VLAN setup.

This patch does not add port_bridge_join or port_bridge_leave callbacks
and does not adjust the isolation masks when bridge membership changes;
that functionality appears to be introduced by the following patch in the
series (net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}).

Would it be clearer to describe the end state as applying to the full
series, or to move this paragraph to the patch that actually implements
the bridge-driven isolation adjustment?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 7ddb82fcd026..b37aa847a9aa 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> +static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					 bool vlan_filtering,
> +					 struct netlink_ext_ack *extack)
> +{
> +	enum rtl8365mb_vlan_egress_mode mode;
> +	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
> +		vlan_filtering ? "enable" : "disable");
> +
> +	/* When vlan filter is enable/disabled in a bridge, this function is
> +	 * called for all member ports. We need to enable/disable ingress
> +	 * VLAN membership check.
> +	 */
> +	ret = rtl8365mb_port_set_ingress_filtering(priv, port, vlan_filtering);
> +	if (ret)
> +		return ret;
> +
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
> +			return ret;
> +	}
> +
> +	/* When VLAN filtering is disabled, preserve frames exactly as received.
> +	 * Otherwise, the VLAN egress pipeline may still alter tag state
> +	 * according to VLAN membership and untag configuration.
> +	 */
> +	if (vlan_filtering)
> +		mode = RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL;
> +	else
> +		mode = RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP;
> +
> +	return rtl8365mb_port_set_vlan_egress_mode(priv, port, mode);
> +}

[Low]
If any of the regmap writes here fails, is the hardware left in a
partially-updated state?

rtl8365mb_port_set_ingress_filtering() is already committed before the
loop runs, and inside the loop each rtl8365mb_port_set_transparent() call
flips a transparent bit on a different egress register. A mid-loop failure
returns the error but leaves earlier ports with transparent mode toggled
and also skips the trailing rtl8365mb_port_set_vlan_egress_mode() write.

Would it be worth reverting already-applied changes on error, so that a
returned failure corresponds to an unchanged port configuration rather
than a port split between the old and new vlan_filtering state?

[ ... ]

> @@ -2035,6 +2266,20 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	if (ret)
>  		goto out_teardown_irq;
>  
> +	ds->configure_vlan_while_not_filtering = true;
> +
> +	/* Set up VLAN */
> +	ret = rtl8365mb_vlan_setup(ds);
> +	if (ret)
> +		goto out_teardown_irq;
> +
> +	/* Set maximum packet length to 1536 bytes */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_CFG0_MAX_LEN_REG,
> +				 RTL8365MB_CFG0_MAX_LEN_MASK,
> +				 FIELD_PREP(RTL8365MB_CFG0_MAX_LEN_MASK, 1536));
> +	if (ret)
> +		goto out_teardown_irq;
> +

[Medium]
Is this RTL8365MB_CFG0_MAX_LEN_REG write intended to be part of this VLAN
patch?

rtl8365mb_setup() already calls rtl8365mb_port_change_mtu(ds,
cpu->trap_port, ETH_DATA_LEN) earlier, which programs the same global
RTL8365MB_CFG0_MAX_LEN_REG with frame_size derived from
ETH_DATA_LEN + VLAN_ETH_HLEN + ETH_FCS_LEN (1522). This new hunk then
unconditionally overwrites that with 1536.

Neither the subject nor the commit message mention any MTU or
frame-length change. Would it make sense to split this MAX_LEN_REG
adjustment into its own patch with a rationale for the 1536 value, rather
than carrying it as an unrelated side-effect of VLAN support?

[ ... ]

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> new file mode 100644
> index 000000000000..a68e0d18a611
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c

[ ... ]

> +static int rtl8365mb_vlan_mc_read(struct realtek_priv *priv, u32 index,
> +				  struct rtl8365mb_vlanmc *vlanmc)
> +{
> +	u16 data[RTL8365MB_VLAN_MC_ENTRY_SIZE];
> +	int ret;
> +
> +	ret = regmap_bulk_read(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
> +			       RTL8365MB_VLAN_MC_ENTRY_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	vlanmc->member = FIELD_GET(RTL8365MB_VLAN_MC_D0_MBR_MASK, data[0]);
> +	vlanmc->fid = FIELD_GET(RTL8365MB_VLAN_MC_D1_FID_MASK, data[1]);
> +	vlanmc->priority = FIELD_GET(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, data[2]);
> +	vlanmc->evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, data[3]);
> +
> +	return 0;
> +}
> +
> +static int rtl8365mb_vlan_mc_write(struct realtek_priv *priv, u32 index,
> +				   const struct rtl8365mb_vlanmc *vlanmc)
> +{
> +	u16 data[4] = { 0 };
> +	int ret;
> +
> +	data[0] |= FIELD_PREP(RTL8365MB_VLAN_MC_D0_MBR_MASK, vlanmc->member);
> +	data[1] |= FIELD_PREP(RTL8365MB_VLAN_MC_D1_FID_MASK, vlanmc->fid);
> +	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_METERIDX_MASK,
> +			      vlanmc->meteridx);
> +	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK,
> +			      vlanmc->policing_en);
> +	data[2] |=
> +		FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, vlanmc->priority);
> +	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPEN_MASK,
> +			      vlanmc->priority_en);
> +	data[3] |= FIELD_PREP(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlanmc->evid);
> +
> +	ret = regmap_bulk_write(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
> +				RTL8365MB_VLAN_MC_ENTRY_SIZE);
> +
> +	return ret;
> +}

[Medium]
Are rtl8365mb_vlan_mc_read() and rtl8365mb_vlan_mc_write() intended to be
symmetric?

rtl8365mb_vlan_mc_read() only extracts member, fid, priority and evid from
the hardware entry, while rtl8365mb_vlan_mc_write() writes member, fid,
meteridx, policing_en (ENVLANPOL), priority, priority_en (VBPEN) and
evid.

In rtl8365mb_vlan_mc_port_set() the pattern is to declare
struct rtl8365mb_vlanmc vlanmc = {0}, call rtl8365mb_vlan_mc_read() when
an entry exists, toggle only vlanmc.member, and write it back. Because
priority_en, policing_en and meteridx are never populated by the read,
the subsequent write unconditionally FIELD_PREPs them as zero.

Would it be safer to unpack VBPEN, ENVLANPOL and METERIDX in
rtl8365mb_vlan_mc_read() as well, so that read/modify/write preserves
those bits? The rtl8365mb_vlan_4k_read()/rtl8365mb_vlan_4k_write() pair
already handles all fields symmetrically.

[ ... ]

> +static int rtl8365mb_vlan_mc_find(struct realtek_priv *priv, u16 vid,
> +				  u8 *index, u8 *first_free)
> +{
> +	u32 vlan_entry_d3;
> +	u8 vlanmc_idx;
> +	u16 evid;
> +	int ret;
> +
> +	*index = 0;
> +	*first_free = 0;
> +
> +	/* look for existing entry or an empty one */
> +	/* vlanmc index 0 is reserved as a neutral PVID value for standalone
> +	 * ports. Traffic reaches the CPU via VLAN transparent mode.
> +	 **/
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

[Low]
Does this function correctly disambiguate "VLAN 0 already programmed"
from "this slot is empty"?

Both conditions use evid == 0 as their signal:

    if (evid == vid) {
        *index = vlanmc_idx;
        return 0;
    }

    if (evid == 0x0 && *first_free < 1)
        *first_free = vlanmc_idx;

When called with vid == 0, the first empty slot encountered satisfies
evid == vid and is returned via *index as if it were a pre-existing
match. rtl8365mb_vlan_mc_port_set() then treats it as an allocated entry
and performs a read-modify-write that silently claims the slot.

The driver's entry points only reject vid > RTL8365MB_MAX_MC_VID; vid ==
0 is not explicitly guarded. Would adding a "used" bit per MC slot (or an
explicit vid == 0 check at the add/del entry points) remove this
ambiguity?

[ ... ]

> +int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
> +	enum rtl8365mb_frame_ingress accepted_frame;
> +	struct realtek_priv *priv = ds->priv;
> +	u8 _unused_first_free_idx;
> +	u8 vlanmc_idx;
> +	int ret;
> +
> +	if (!pvid)
> +		return 0;
> +
> +	/* Find or allocate a new vlan MC and add port to members,
> +	 * although members are not checked by the HW in vlan MC.
> +	 */
> +	ret = rtl8365mb_vlan_mc_port_set(ds, port, vlan, extack, true);
> +	if (ret)
> +		return ret;
> +
> +	/* look for existing entry */
> +	ret = rtl8365mb_vlan_mc_find(priv, vlan->vid, &vlanmc_idx,
> +				     &_unused_first_free_idx);
> +	if (ret) {
> +		RTL_VLAN_ERR("Failed to find a VLAN MC table index");
> +		goto undo_vlan_mc_port_set;
> +	}
> +
> +	if (!vlanmc_idx) {
> +		RTL_VLAN_ERR("VLAN should already exist in VLAN MC");
> +		goto undo_vlan_mc_port_set;
> +	}

[Medium]
Does this error path return success where it intended to return an
error?

At the !vlanmc_idx branch, ret is 0 (rtl8365mb_vlan_mc_find() just
succeeded), and the undo label ends with:

    undo_vlan_mc_port_set:
        (void)rtl8365mb_vlan_mc_port_set(ds, port, vlan, NULL, false);
        return ret;

So rtl8365mb_vlan_pvid_port_add() would return 0 after logging "VLAN
should already exist in VLAN MC" and rolling back the MC allocation.
rtl8365mb_port_vlan_add() then treats the operation as successful and
leaves the VLAN4K membership in place, hiding the inconsistency from the
DSA core.

Should this branch set ret to something like -EIO (or -ENOENT) before
the goto, so the rollback is paired with a returned error?

> +
> +	ret = rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
> +	if (ret) {
> +		RTL_VLAN_ERR("Failed to set port PVID");
> +		goto undo_vlan_mc_port_set;
> +	}

[ ... ]

