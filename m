Return-Path: <netdev+bounces-299064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qm4EK1XULWqDkwQAu9opvQ
	(envelope-from <netdev+bounces-299064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05E67FD9D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:06:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RjSUzwTw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299064-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299064-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E88773003BEC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B93A5452;
	Sat, 13 Jun 2026 22:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC103385BE;
	Sat, 13 Jun 2026 22:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388363; cv=none; b=igYSq8TpA73zp3dgdFFsVCqNxu3q4mgNdFD59I6O8gpqfd8EZBXWDcaxO3K1LzSWDv+roN2dxa8AsLy54ljnnOO/dHqanqpx4poqZ9g9KgehD9C9F9YFeYiSWh1Imkkw28OTKpP+mXhYN7jnu0xsY4MbceMcbBtcRYnfAIHsTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388363; c=relaxed/simple;
	bh=zuoGWsKN6Kbf1Hm47j7wRCyyJ8pi2UENCmA20XhHGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhBlbqvIGdgj36IDybTERVNUlMVi5Di/5mXrDWoTtxBXOsbNt4Xfcp6KQ59lUGmLCSFe2absG7n/qWL4T97x3NeoGrdI8w2QyoDwud0ei+6r7V1FaJDQYew1yPtWOjN0p8SncmNhaTryQELk0Qb6tkJxzEJrjIRVv1u5yeqExto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjSUzwTw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F41F000E9;
	Sat, 13 Jun 2026 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388362;
	bh=CWvdRUCfQAYUBOK9c2gPgj90D7DeK4Yn3M0qUYjGfL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RjSUzwTw9i4Hbjl1ecRkkKS1r9whP6T8jtnpp+H5a+mtqpJ6RrJ6w3GFNHeOB1+Ir
	 1L/4/bynVvCveP+vddVAPzu5YuybjWffkzwltaInImEDYon1gulrfm+zgfBbnBS79a
	 pN5GaPTi/pIcIKjAYxY/a2qnY/MoG6c5ShuxwpihT98NdKR/zLz+EGX86l5GkiF89c
	 FFIPMwRPSUVDd6mNTaQJ0XpXUhIJplZ0wpw42W8lFZoplCB0NOwc2ZK9Cnnp1QG5pw
	 6TKy0lic6E7a8RTxC5U8LIR14FqOG3FmOQTinhz4NFKqL535OZfdYlefKEO3g22Pwp
	 eeRmkji6jWVdg==
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
Date: Sat, 13 Jun 2026 15:06:01 -0700
Message-ID: <20260613220601.219718-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299064-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA05E67FD9D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add support for RTL8116af

This commit adds SFP mode support for the RTL8116af. It introduces checks to
ensure the PHY device exists before using it and implements phylink PCS
operations to get link status and speed from the SERDES registers.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

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
> +

[Severity: High]
Can concurrent accesses to the OCP registers corrupt the hardware state?

rtl8169_sds_read() calls r8168_mac_ocp_write() and r8168_mac_ocp_read()
sequentially. These helpers internally acquire and release tp->mac_ocp_lock
for each individual 32-bit operation, but the 3-step sequence itself is not
atomic.

Since rtl8169_sds_read() is called from rtl8169_pcs_get_state(), which can be
executed concurrently by different contexts (such as phylink_resolve() under
state_mutex and phylink_ethtool_ksettings_get() under rtnl_lock), can their
executions interleave? This could cause one thread's address or command write
to be clobbered by another, leading to incorrect register reads.

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

[Severity: Medium]
Does this manual parsing of MII_LPA miss asymmetric pause capabilities and
fail to populate state->lp_advertising?

Phylink requires lp_advertising to be populated for in-band autonegotiation
so it can correctly report partner capabilities and resolve pause. Should
this driver use phylink_mii_c22_pcs_decode_state() to decode the link state
instead of manually checking for LPA_1000XPAUSE?

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

[Severity: Medium]
Will these empty stubs cause user configurations to be silently ignored?

When userspace uses ethtool to change the local advertisement (for example,
to enable or disable pause capabilities), the driver appears to ignore the
request without updating the SerDes advertisement registers or restarting
autonegotiation.

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
>  
>  	rc = register_netdev(dev);

[Severity: Critical]
If r8169_mdio_register() is skipped for RTL_SFP_8168_AF, will tp->phy_irq_domain
remain NULL?

The driver unconditionally unmasks the LinkChg interrupt in tp->irq_mask.
When the SFP link state changes, the hardware asserts the LinkChg interrupt,
which causes the hardirq handler rtl8169_interrupt() to execute:

    if (status & LinkChg)
        generic_handle_domain_irq(tp->phy_irq_domain, 0);

Passing a NULL irq_domain to generic_handle_domain_irq() falls back to the
system's irq_default_domain. This maps hwirq 0 to an unrelated system
interrupt (such as the system timer on x86 architectures). Can this cause
spurious execution of an unrelated interrupt handler and lead to system
lockups or crashes?

