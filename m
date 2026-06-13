Return-Path: <netdev+bounces-299069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KwgYDFTVLWrzkwQAu9opvQ
	(envelope-from <netdev+bounces-299069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:10:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC767FE1E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:10:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D37qnfiV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299069-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299069-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550F5306A3AF
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B0352036;
	Sat, 13 Jun 2026 22:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F43A6EF0;
	Sat, 13 Jun 2026 22:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388388; cv=none; b=YdqxmKuvXQNOfWHx1s8DePRZlzFfSxjUm6e+qLrQtpxQC6mPaKEfRGQ6W8BQ/WO3Nf95a7woNfLlZJraNn8oLon08V1+vRsp0xnx87IoWXCo2jByEIKZWDj3r6zUJTZSQc3Oay8RrlgwN11J6IKDJ6ai/TFo1LkXLa4i5C7q/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388388; c=relaxed/simple;
	bh=IMFoujnMb4vxPCulRjHJU3S0b2Wgz4XsWnTJKsb74+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZPTs3V2zbJ6RktihdowYfcj5feG3ps4e6GpbExQ0LT7CPAWrwyz+q4o+mIeWknAfZqwc2doUM6PEbVpO6Fr97tJAmyTxRisYp6l5TMJ2AR+JBKPafw/XfKFY1JDuLlyh5aYMT7JtorMvedyyPt4VH9bwHhuNiMhtaAaKyBL0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D37qnfiV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05311F000E9;
	Sat, 13 Jun 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388387;
	bh=9n6IB9JjS2UlkWGfuxpNZcvcrVSoze0sZ9VGpLTkBz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D37qnfiVAQEhIKfAAM6+eIwSEP9A7BpUExz07murG/CvrWS5s9VrI7LcdWxG4A4Ln
	 pB3rH3c3iD06Ha+UHvuCTQwJBdGWgEG9C24HtJuvqCHyJDNmgEl3rYUJr5qY1lnHje
	 iDd6IkyDoQqFj/FgayMM8AinGiHOTevzdORcL9e7Ec5wvuUwRlo/OkvYYzfY94xHpo
	 GOfQmKPovf02p5PblXAVUDjbxnWHa+RPxu/zkHnPVz9dKW4PKqghBWM/49ZKti70y7
	 45SE9nnggv2Ix3M0jNe/Yv17DylzFUjGNBDI+DQum2eDQdei6vo4rEcqwaKNCxI+jj
	 KbFlKIQSNpAAA==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] r8169: add support for RTL8116af
Date: Sat, 13 Jun 2026 15:06:26 -0700
Message-ID: <20260613220626.220220-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-5-javen_xu@realsil.com.cn>
References: <20260611094345.880-5-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:kuba@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DBC767FE1E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add support for RTL8116af

This change adds support for RTL8116af, a SerDes/SFP variant of the
RTL_GIGA_MAC_VER_52 family that has no internal PHY. It introduces a
phylink_pcs implementation that reads link state directly from the
SerDes registers via OCP and skips r8169_mdio_register() so that no
phy_device is bound, with NULL guards added in several callers.

A few questions about the change below.

[Low]
The commit message says:

  Phylink uses pcs to get the link status and speed from its serdes
  reg, instead of standard phy reg.

Looking at rtl8169_pcs_get_state(), only link / an_complete / lpa
appear to come from the SerDes registers. The speed and duplex are
hardcoded:

    if (state->link) {
        state->speed = SPEED_1000;
        state->duplex = DUPLEX_FULL;
    }

Is that mismatch with the commit message intentional, given that for
1000BASE-X 1000FD is the only valid mode anyway?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 615bd4107359..a73c0215b240 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -3703,12 +3748,14 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  
>  	rtl_pcie_state_l2l3_disable(tp);
>  
> -	rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> -	if (rg_saw_cnt > 0) {
> -		u16 sw_cnt_1ms_ini;
> +	if (tp->phydev) {
> +		rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> +		if (rg_saw_cnt > 0) {
> +			u16 sw_cnt_1ms_ini;
>  
> -		sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> -		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> +			sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> +			r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> +		}
>  	}

[Medium]
rtl_hw_start_8117() is shared between RTL8117 and the new RTL8116af
since both are RTL_GIGA_MAC_VER_52. With this change the calibration
of MAC register 0xd412 from PHY register 0x0c42:0x13 is silently
skipped for 8116af, leaving 0xd412 at its reset value rather than a
calibrated 1ms count.

Does 8116af actually not need 0xd412 configured, or does it need an
alternative calibration source? The commit log does not mention either
case.

[ ... ]

> @@ -5647,6 +5696,10 @@ static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *ph
>  static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
>  					      phy_interface_t interface)
>  {
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	if (interface == PHY_INTERFACE_MODE_1000BASEX || interface == PHY_INTERFACE_MODE_SGMII)
> +		return &tp->pcs;
>  	return NULL;
>  }
>  
> @@ -5655,6 +5708,55 @@ static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
>  {
>  }
>  
> +static u16 rtl8169_sds_read(struct rtl8169_private *tp, u16 sds_reg)
> +{
> +	r8168_mac_ocp_write(tp, OCP_SDS_ADDR_REG, sds_reg);
> +	r8168_mac_ocp_write(tp, OCP_SDS_CMD_REG, SDS_CMD_READ);
> +	return r8168_mac_ocp_read(tp, OCP_SDS_DATA_REG);
> +}

[Medium]
The three-step SDS sequence (write addr, write cmd, read data) is
implemented with three separate r8168_mac_ocp_*() calls, each of which
takes and releases tp->mac_ocp_lock independently.

rtl8169_pcs_get_state() can run from phylink_resolve() (workqueue) and
also from the ethtool/mii ioctl paths, e.g.:

    phylink_ethtool_ksettings_get()
      -> phylink_mac_pcs_get_state()
        -> pcs->ops->pcs_get_state()

These contexts share no common lock. Can two SDS transactions
interleave between the address/cmd writes and the data read, so the
engine sees an addr from one caller and a cmd from another and returns
data for the wrong register?

The existing r8168_mac_ocp_modify() uses a single
raw_spin_lock_irqsave around __r8168_mac_ocp_read/write to keep its
RMW atomic. Should this SDS helper do the same across the three
accesses?

[Medium]
After writing SDS_CMD_READ (0x0001) to OCP_SDS_CMD_REG, the data
register is read immediately without polling for completion. Other
indirect accessors in this driver follow a kick-then-poll pattern, for
example r8168_phy_ocp_read():

    RTL_W32(tp, GPHY_OCP, reg << 15);
    return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
        (RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;

and rtl_eri_read, rtl_efuse_read, rtl_ephy_read, rtl_csi_read and
r8169_mdio_read_reg all wait on a completion bit before reading the
data register.

Is the SerDes engine guaranteed to complete synchronously here, or can
the read of OCP_SDS_DATA_REG return stale data from the previous
transaction, leading to wrong BMSR / LPA values being reported back to
phylink?

> +
> +static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
> +				  unsigned int neg_mode,
> +				  struct phylink_link_state *state)
> +{
> +	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
> +	u16 bmsr, lpa;
> +
> +	bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
> +	lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
> +
> +	state->link = !!(bmsr & BMSR_LSTATUS);
> +	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
> +	if (state->link) {
> +		state->speed = SPEED_1000;
> +		state->duplex = DUPLEX_FULL;
> +	} else {
> +		state->speed = SPEED_UNKNOWN;
> +		state->duplex = DUPLEX_UNKNOWN;
> +	}
> +
> +	if (lpa & LPA_1000XPAUSE)
> +		state->pause |= MLO_PAUSE_RX | MLO_PAUSE_TX;
> +}

[Low]
The 1000BASE-X LPA encodes pause as two bits, LPA_1000XPAUSE and
LPA_1000XPAUSE_ASYM, which together describe four states (none, sym,
asym TX, asym RX). Treating any peer that sets LPA_1000XPAUSE as full
bidirectional pause looks like it ignores the asymmetric cases.

Could this use phylink_mii_c22_pcs_decode_state() (or equivalent
decoding logic) so both LPA pause bits are interpreted correctly?

> +
> +static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
> +			      phy_interface_t interface,
> +			      const unsigned long *advertising,
> +			      bool permit_pause_to_mac)
> +{
> +	return 0;
> +}
> +
> +static int rtl8169_pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
> +				const struct phylink_link_state *state)
> +{
> +	return 0;
> +}
> +
> +static void rtl8169_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +}

[Medium]
pcs_config and pcs_an_restart are both empty stubs. phylink calls
pcs_an_restart from phylink_ethtool_nway_reset(), so an
ethtool -r ethN on an 8116af interface will return success but will
not actually trigger AN restart in hardware. Similarly, pcs_config is
called whenever the inband advertisement changes, so changes via
ethtool -s ... advertise ... are silently dropped.

There does not appear to be any other code path that programs the
SerDes for 1000BASE-X mode or AN advertisement, so the chip seems to
rely on the bootloader leaving the PCS pre-configured.

Should pcs_an_restart at least write BMCR_ANRESTART to the SerDes
BMCR, and pcs_config program the advertisement?

[ ... ]

> @@ -5828,12 +5947,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	tp->aspm_manageable = !rc;
>  
> -	if (rtl_is_8125(tp)) {
> -		u16 data = r8168_mac_ocp_read(tp, 0xd006);
> -
> -		if ((data & 0xff) == 0x07)
> -			tp->sfp_mode = true;
> -	}
> +	tp->sfp_mode = rtl_get_sfp_mode(tp);

[Low]
After detection as RTL8116af, chip still resolves to the
RTL_GIGA_MAC_VER_52 entry in rtl_chip_infos[] whose name is
"RTL8168fp/RTL8117". The probe banner

    netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
                chip->name, ...);

therefore identifies an 8116af device as RTL8168fp/RTL8117. Should
chip->name be overridden when rtl_get_sfp_mode() returns
RTL_SFP_8168_AF so that dmesg reports the actual variant?

[ ... ]

> @@ -5941,10 +6055,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	rc = r8169_mdio_register(tp);
> -	if (rc) {
> -		phylink_destroy(tp->phylink);
> -		return rc;
> +	if (tp->sfp_mode != RTL_SFP_8168_AF) {
> +		rc = r8169_mdio_register(tp);
> +		if (rc) {
> +			phylink_destroy(tp->phylink);
> +			return rc;
> +		}
>  	}

[High]
r8169_mdio_register() is the only function that initializes
tp->phy_irq_domain via irq_domain_add_linear(). Skipping it for
RTL_SFP_8168_AF leaves tp->phy_irq_domain as NULL.

rtl_set_irq_mask() is unchanged, so the LinkChg bit remains set in
tp->irq_mask. On a SerDes link transition, rtl8169_interrupt() still
runs:

    generic_handle_domain_irq(tp->phy_irq_domain, 0);

with tp->phy_irq_domain == NULL. Inside __irq_resolve_mapping() this
falls back to irq_default_domain, which on some architectures will
look up hwirq 0 in an unrelated domain, while on others
handle_irq_desc(NULL) just returns -EINVAL silently.

Since pcs.poll = true is already set for 8168_AF, link state is
polled via phylink anyway. Should LinkChg be masked out of
tp->irq_mask for 8168_AF, or should the generic_handle_domain_irq()
call be guarded by tp->phy_irq_domain (or tp->phydev)?

