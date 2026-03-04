Return-Path: <netdev+bounces-263896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OnzKdhYqGk5tgAAu9opvQ
	(envelope-from <netdev+bounces-263896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:07:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50FD203BF5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A92A23083E1C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9B35B631;
	Wed,  4 Mar 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vWRRaKRP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3735DA44;
	Wed,  4 Mar 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639965; cv=none; b=WgAxPQOyCtiiIA5p58lATV1/w/+VAKcwmgbet/CBuO77FL8tTHPgguA2iw1vMPzSR2e94CDi0vLnKYnFQ497d++CDBrU8H/4bq/K8I3GEyAUzZmHKiOoQi666azaKXYfsDjG6Ex2ehECHk4g+G4Ljo4l4oEAe06HwNCcAKkFeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639965; c=relaxed/simple;
	bh=KhQXK8JPVFL5QCVJb7ud/kWELwSJhrejhFasVgXAqQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2nJeKpNOr/UCNFYvLRJBph13fALwHCTluy8JEmFiuXsmvhAjYfJX6NcD8SupXlgxJfdY0Ka8nQ8ZW3RqiU9H9PtM98swenQn6Ki5jF5J7t6elizg1x4vUuhN64+kYioNNG0aPqlscelzYUZn02ftZHceiJWI3yZRwvAkN4nyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vWRRaKRP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VGoeHbwliSqJ+tDOuTffqxe7HbhhTH9uA1Xz7+vlBuE=; b=vWRRaKRPnXMqValWlgfhbekl0r
	Id3SToE5f+gluxeTv2QfxpjsldyympyeKW+stM0ktNwHmUtQsrZopDMF/6pyIqA455dKic73csxY/
	wjosScAgB9EhhlBQEQd2U2VhCcPqL6yS8Qc33xjkMz05kE3AsDYWbtN9Q1P8a/ja1LLH9WSjsqvW6
	8xpMlbInheE+0ngHVF5KWfhlUuuVYA9ki91s/ROtjCgaRXwob19OPKVoNy/yjioWKHSMyIdY+lWYu
	wwUvQ6jkOT8ATS93OEJkbUJN/hMghvi+icRG7elaJUClaJQyxsiaemiMTrzRzPxcif/b7smZRIbf6
	K1wYhhCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxocg-000000006jA-34B2;
	Wed, 04 Mar 2026 15:58:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxocd-0000000081F-1lpi;
	Wed, 04 Mar 2026 15:58:51 +0000
Date: Wed, 4 Mar 2026 15:58:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: C50FD203BF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.028];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:30PM +0100, Jens Emil Schulz Østergaard wrote:
> Add the LAN9645X basic DSA driver with initialization, parent regmap
> requests, port module initialization for NPI, CPU ports and front ports,
> and phylink integration for MAC side configuration.

I'm reviewing the phylink implementation only.

> +static int lan9645x_rgmii_setup(struct lan9645x *lan9645x, int port, int speed,
> +				phy_interface_t mode)
> +{
> +	bool tx_delay = false, rx_delay = false;
> +	u32 rx_idx, tx_idx;
> +	u8 tx_clk;
> +	int idx;
> +
> +	/* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
> +	idx = port == 8 ? 1 : 0;
> +
> +	if (!phy_interface_mode_is_rgmii(mode))
> +		return 0;
> +
> +	tx_clk = speed == SPEED_1000 ? 1 :
> +		 speed == SPEED_100  ? 2 :
> +		 speed == SPEED_10   ? 3 : 0;
> +
> +	lan_rmw(HSIO_RGMII_CFG_RGMII_RX_RST_SET(0) |
> +		HSIO_RGMII_CFG_RGMII_TX_RST_SET(0) |
> +		HSIO_RGMII_CFG_TX_CLK_CFG_SET(tx_clk),

What exactly is this clock configuration doing?

> +		HSIO_RGMII_CFG_RGMII_RX_RST |
> +		HSIO_RGMII_CFG_RGMII_TX_RST |
> +		HSIO_RGMII_CFG_TX_CLK_CFG,
> +		lan9645x, HSIO_RGMII_CFG(idx));
> +
> +	/* We configure delays on the MAC side. When the PHY is not responsible
> +	 * for delays, the MAC is, which is why RGMII_TXID results in
> +	 * rx_delay=true.
> +	 */
> +	if (mode == PHY_INTERFACE_MODE_RGMII ||
> +	    mode == PHY_INTERFACE_MODE_RGMII_TXID)
> +		rx_delay = true;
> +
> +	if (mode == PHY_INTERFACE_MODE_RGMII ||
> +	    mode == PHY_INTERFACE_MODE_RGMII_RXID)
> +		tx_delay = true;

PHY_INTERFACE_MODE_RGMII means that the delays are provided by the
board layout, so this seems wrong to me. Please review the phylib
documentation concerning RGMII delays. I'd like Andrew to comment on
this too.

> +
> +	/* Setup DLL configuration. Register layout:
> +	 * 0:        RGMII_0_RX
> +	 * 1:        RGMII_0_TX
> +	 * 2:        RGMII_1_RX
> +	 * 3:        RGMII_1_TX
> +	 * ...
> +	 * (N<<1)    RGMII_N_RX,
> +	 * (N<<1)+1: RGMII_N_TX,
> +	 */
> +	rx_idx = idx << 1;
> +	tx_idx = rx_idx + 1;

Nit: I think the shift is too clever here. It's clearly:

	rx_idx = idx * 2;
	tx_idx = idx * 2 + 1;

> +
> +	/* Enable DLL in RGMII clock paths, deassert DLL reset, and start the
> +	 * delay tune FSM.
> +	 */
> +	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> +		HSIO_DLL_CFG_DLL_RST_SET(0) |
> +		HSIO_DLL_CFG_DLL_ENA_SET(rx_delay) |
> +		HSIO_DLL_CFG_DELAY_ENA_SET(rx_delay),
> +		HSIO_DLL_CFG_DLL_CLK_ENA |
> +		HSIO_DLL_CFG_DLL_RST |
> +		HSIO_DLL_CFG_DLL_ENA |
> +		HSIO_DLL_CFG_DELAY_ENA,
> +		lan9645x, HSIO_DLL_CFG(rx_idx));
> +
> +	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> +		HSIO_DLL_CFG_DLL_RST_SET(0) |
> +		HSIO_DLL_CFG_DLL_ENA_SET(tx_delay) |
> +		HSIO_DLL_CFG_DELAY_ENA_SET(tx_delay),
> +		HSIO_DLL_CFG_DLL_CLK_ENA |
> +		HSIO_DLL_CFG_DLL_RST |
> +		HSIO_DLL_CFG_DLL_ENA |
> +		HSIO_DLL_CFG_DELAY_ENA,
> +		lan9645x, HSIO_DLL_CFG(tx_idx));
> +
> +	return 0;
> +}
> +
> +static void lan9645x_phylink_mac_config(struct lan9645x *lan9645x, int port,
> +					unsigned int mode,
> +					const struct phylink_link_state *state)
> +{
> +	if (phy_interface_mode_is_rgmii(state->interface))
> +		lan9645x_rgmii_setup(lan9645x, port, state->speed,
> +				     state->interface);

state->speed will always be SPEED_UNKNOWN here. Please don't use
state->speed here, it's even documented that drivers should not access
this member in their mac_config method().

> +}
> +
> +static int lan9645x_phylink_mac_prepare(struct lan9645x *lan9645x, int port,
> +					unsigned int mode,
> +					phy_interface_t iface)
> +{
> +	switch (port) {
> +	case 0 ... 3:
> +		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> +			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> +			HSIO_HW_CFG);
> +		break;
> +	case 4:
> +		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> +			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> +			HSIO_HW_CFG);
> +
> +		if (phy_interface_mode_is_rgmii(iface))
> +			lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
> +				HSIO_HW_CFG_RGMII_0_CFG,
> +				lan9645x, HSIO_HW_CFG);
> +
> +		break;
> +	case 7 ... 8:
> +		lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
> +			HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x,
> +			HSIO_HW_CFG);
> +		break;
> +	default:
> +		/* Ports 5-6 are SerDes-only and need PCS support (not yet
> +		 * implemented). They are excluded from phylink_get_caps.

... which means phylink_create() will fail, and this function will never
be called for those ports.

> +		 */
> +		return -EINVAL;
> +	}

As each of the above cases uses the exactly the same preamble, I'm
wondering whether something like:

	u32 mask;

	if (port == 5 || port == 6 || port > 8)
		return -EINVAL;

	mask = HSIO_HW_CFG_GMII_ENA_SET(BIT(port));
	lan_rmw(mask, mask, lan9645x, HSIO_HW_CFG);


	if (port == 4 && phy_interface_mode_is_rgmii(iface))
		lan_rmw(HSIO_HW_CFG_RGMII_0_CFG_SET(1),
			HSIO_HW_CFG_RGMII_0_CFG,
			lan9645x, HSIO_HW_CFG);

would be neater.

> +
> +	return 0;
> +}
> +
> +static int lan9645x_port_is_cuphy(struct lan9645x *lan9645x, int port,
> +				  phy_interface_t interface)
> +{
> +	return port >= 0 && port <= 4 && interface == PHY_INTERFACE_MODE_GMII;
> +}
> +
> +static void lan9645x_phylink_mac_link_up(struct lan9645x *lan9645x, int port,
> +					 unsigned int link_an_mode,
> +					 phy_interface_t interface,
> +					 struct phy_device *phydev, int speed,
> +					 int duplex, bool tx_pause,
> +					 bool rx_pause)
> +{
> +	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
> +	int rx_ifg1, rx_ifg2, tx_ifg, gtx_clk = 0;
> +	struct lan9645x_path_delay *path_delay;
> +	int gspeed = LAN9645X_SPEED_DISABLED;
> +	int mode = 0;
> +	int fc_spd;
> +
> +	/* Configure speed for RGMII modules. */
> +	if (phy_interface_mode_is_rgmii(interface))
> +		lan9645x_rgmii_setup(lan9645x, port, speed, interface);

You shouldn't need to do a full setup of the RGMII state here - all
that should be done is to adjust the transmit clock speed. I would
prefer to see lan9645x_rgmii_setup() split into a "we're configuring
the bulk of RGMII state" function which is called from mac_config(),
and a "we have link up, do the minimal configuration that is dependent
on the resulting link speed" in mac_link_up().

> +
> +	if (duplex == DUPLEX_FULL) {
> +		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> +		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> +		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x5);
> +
> +	} else {
> +		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> +		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> +	}
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x2);
> +		gspeed = LAN9645X_SPEED_10;
> +		break;
> +	case SPEED_100:
> +		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> +		gspeed = LAN9645X_SPEED_100;
> +		break;
> +	case SPEED_1000:
> +		gspeed = LAN9645X_SPEED_1000;
> +		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
> +		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> +		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> +		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> +		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> +		gtx_clk = 1;
> +		break;
> +	case SPEED_2500:
> +		gspeed = LAN9645X_SPEED_2500;
> +		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
> +		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
> +		rx_ifg1 = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1);
> +		rx_ifg2 = DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2);
> +		tx_ifg = DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
> +		break;
> +	default:
> +		dev_err(lan9645x->dev, "Unsupported speed on port %d: %d\n",
> +			p->chip_port, speed);
> +		return;
> +	}
> +
> +	p->speed = gspeed;
> +	p->duplex = duplex;
> +	fc_spd = lan9645x_speed_fc_enc(p->speed);
> +
> +	if (phy_interface_num_ports(interface) == 4 ||
> +	    interface == PHY_INTERFACE_MODE_SGMII)
> +		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);

PHY_INTERFACE_MODE_SGMII in the kernel means Cisco SGMII, and does not
include 1000BASE-X. As SGMII/BASE-X support is incomplete, I can't tell
whether the above is correct.

> +
> +	lan_rmw(mode,
> +		DEV_MAC_MODE_CFG_FDX_ENA |
> +		DEV_MAC_MODE_CFG_GIGA_MODE_ENA,
> +		lan9645x, DEV_MAC_MODE_CFG(p->chip_port));
> +
> +	lan_rmw(tx_ifg | rx_ifg1 | rx_ifg2,

It only makes sense to use seperate variables if you're going to be
placing them into the appropriate bitfield locations in a different
part of the code to that which is making decisions about their values.
However, I'm guessing that DEV_MAC_IFG_CFG_RX_IFG1_SET() et.al. are
preparing the field values.

So, I'd prefer to see a single variable called "mac_ifg_cfg" with
the values for each field accumulated into that:

	switch ... {
	case SPEED_1000:
		mac_ifg_cfg = DEV_MAC_IFG_CFG_RX_IFG1_SET(0x1) |
			      DEV_MAC_IFG_CFG_RX_IFG2_SET(0x2) |
			      DEV_MAC_IFG_CFG_TX_IFG_SET(0x6);
	}
	...
	lan_rmw(mac_ifg_cfg,

or separate variables with the creation of the register value at
the use site:

	switch ... {
	case SPEED_1000:
		rx_ifg1 = 0x1;
		rx_ifg2 = 0x2;
		tx_ifg = 0x6;
	}
	...
	lan_rmw(DEV_MAC_IFG_CFG_RX_IFG1_SET(rx_ifg1) |
	        DEV_MAC_IFG_CFG_RX_IFG2_SET(rx_ifg2) |
		DEV_MAC_IFG_CFG_TX_IFG_SET(tx_ifg),

> +		DEV_MAC_IFG_CFG_TX_IFG |
> +		DEV_MAC_IFG_CFG_RX_IFG1 |
> +		DEV_MAC_IFG_CFG_RX_IFG2,
> +		lan9645x, DEV_MAC_IFG_CFG(p->chip_port));
> +
> +	lan_rmw(DEV_MAC_HDX_CFG_SEED_SET(p->chip_port) |
> +		DEV_MAC_HDX_CFG_SEED_LOAD_SET(1),
> +		DEV_MAC_HDX_CFG_SEED |
> +		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
> +		DEV_MAC_HDX_CFG(p->chip_port));
> +
> +	if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
> +		lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
> +			CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
> +			CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
> +	}
> +
> +	lan_rmw(DEV_MAC_HDX_CFG_SEED_LOAD_SET(0),
> +		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
> +		DEV_MAC_HDX_CFG(p->chip_port));
> +
> +	/* Set PFC link speed and enable map */
> +	lan_rmw(ANA_PFC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> +		ANA_PFC_CFG_RX_PFC_ENA_SET(0),
> +		ANA_PFC_CFG_FC_LINK_SPEED |
> +		ANA_PFC_CFG_RX_PFC_ENA,
> +		lan9645x, ANA_PFC_CFG(p->chip_port));
> +
> +	lan_rmw(DEV_PCS1G_CFG_PCS_ENA_SET(1),
> +		DEV_PCS1G_CFG_PCS_ENA, lan9645x,
> +		DEV_PCS1G_CFG(p->chip_port));
> +
> +	lan_rmw(DEV_PCS1G_SD_CFG_SD_ENA_SET(0),
> +		DEV_PCS1G_SD_CFG_SD_ENA,
> +		lan9645x, DEV_PCS1G_SD_CFG(p->chip_port));
> +
> +	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
> +		SYS_PAUSE_CFG_PAUSE_ENA,
> +		lan9645x, SYS_PAUSE_CFG(p->chip_port));
> +
> +	/* Set SMAC of Pause frame (00:00:00:00:00:00) */
> +	lan_wr(0, lan9645x, DEV_FC_MAC_LOW_CFG(p->chip_port));
> +	lan_wr(0, lan9645x, DEV_FC_MAC_HIGH_CFG(p->chip_port));
> +
> +	/* Flow control */
> +	lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> +		SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
> +		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
> +		SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
> +		SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
> +		SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),
> +		SYS_MAC_FC_CFG_FC_LINK_SPEED |
> +		SYS_MAC_FC_CFG_FC_LATENCY_CFG |
> +		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA |
> +		SYS_MAC_FC_CFG_PAUSE_VAL_CFG |
> +		SYS_MAC_FC_CFG_RX_FC_ENA |
> +		SYS_MAC_FC_CFG_TX_FC_ENA,
> +		lan9645x, SYS_MAC_FC_CFG(p->chip_port));
> +
> +	list_for_each_entry(path_delay, &p->path_delays, list) {
> +		if (path_delay->speed == speed) {
> +			lan_wr(path_delay->rx_delay + p->rx_delay,
> +			       lan9645x, SYS_PTP_RXDLY_CFG(p->chip_port));
> +			lan_wr(path_delay->tx_delay,
> +			       lan9645x, SYS_PTP_TXDLY_CFG(p->chip_port));
> +		}
> +	}
> +
> +	/* Enable MAC module */
> +	lan_wr(DEV_MAC_ENA_CFG_RX_ENA_SET(1) |
> +	       DEV_MAC_ENA_CFG_TX_ENA_SET(1),
> +	       lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> +
> +	/* port _must_ be taken out of reset before MAC. */
> +	lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(0),
> +		DEV_CLOCK_CFG_PORT_RST,
> +		lan9645x, DEV_CLOCK_CFG(p->chip_port));
> +
> +	/* Take out the clock from reset. Note this write will set all these
> +	 * fields to zero:
> +	 *
> +	 * DEV_CLOCK_CFG[*].MAC_TX_RST
> +	 * DEV_CLOCK_CFG[*].MAC_RX_RST
> +	 * DEV_CLOCK_CFG[*].PCS_TX_RST
> +	 * DEV_CLOCK_CFG[*].PCS_RX_RST
> +	 * DEV_CLOCK_CFG[*].PORT_RST
> +	 * DEV_CLOCK_CFG[*].PHY_RST
> +	 *
> +	 * Note link_down will assert PORT_RST, MAC_RX_RST and MAC_TX_RST, so
> +	 * we are effectively taking the mac tx/rx clocks out of reset.
> +	 *
> +	 * This linkspeed field has a slightly different encoding from others:
> +	 *
> +	 * - 0 is no-link
> +	 * - 1 is both 2500/1000
> +	 * - 2 is 100mbit
> +	 * - 3 is 10mbit
> +	 *
> +	 */
> +	lan_wr(DEV_CLOCK_CFG_LINK_SPEED_SET(fc_spd == 0 ? 1 : fc_spd),
> +	       lan9645x,
> +	       DEV_CLOCK_CFG(p->chip_port));
> +
> +	/* Core: Enable port for frame transfer */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
> +		QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
> +		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1) |
> +		QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
> +		QSYS_SW_PORT_MODE_PORT_ENA |
> +		QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
> +		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE |
> +		QSYS_SW_PORT_MODE_TX_PFC_ENA,
> +		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> +
> +	lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(0) |
> +		AFI_PORT_CFG_FRM_OUT_MAX_SET(16),
> +		AFI_PORT_CFG_FC_SKIP_TTI_INJ |
> +		AFI_PORT_CFG_FRM_OUT_MAX,
> +		lan9645x, AFI_PORT_CFG(p->chip_port));

This looks overly complicated for link-up events. Please look to see
how much of this can be moved to the mac_prepare, mac_config and
mac_finish methods, which are supposed to be doing the bulk of
configuring the port for operating in the specified PHY interface mode.

mac_link_up is only supposed to configure for the negotiated parameters
such as speed, duplex, and pause and enable transmission/reception.

Conversely, mac_link_down should just stop the transmission/reception
of packets.

The PCS state fiddling concerns me greatly (although I do appreciate
you don't have that implemented fully yet) but given its presence in
mac_link_up, I think this will cause you future problems, especially
with inband support - the PCS link needs to remain active so it can
participate in negotiation, thereby allowing this method to be called.

You also don't want to be resetting the PCS on the mac_link_down()
method for the same reason.

> +}
> +
> +void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port)
> +{
> +	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
> +	u32 val;
> +
> +	/* 0.5: Disable any AFI */
> +	lan_rmw(AFI_PORT_CFG_FC_SKIP_TTI_INJ_SET(1) |
> +		AFI_PORT_CFG_FRM_OUT_MAX_SET(0),
> +		AFI_PORT_CFG_FC_SKIP_TTI_INJ |
> +		AFI_PORT_CFG_FRM_OUT_MAX,
> +		lan9645x, AFI_PORT_CFG(p->chip_port));
> +
> +	/* wait for reg afi_port_frm_out to become 0 for the port */
> +	if (lan9645x_rd_poll_slow(lan9645x, AFI_PORT_FRM_OUT(p->chip_port),
> +				  val,
> +				  !AFI_PORT_FRM_OUT_FRM_OUT_CNT_GET(val)))
> +		dev_err(lan9645x->dev, "AFI timeout chip port %u",
> +			p->chip_port);
> +
> +	/* 2: Disable MAC frame reception */
> +	lan_rmw(DEV_MAC_ENA_CFG_RX_ENA_SET(0),
> +		DEV_MAC_ENA_CFG_RX_ENA,
> +		lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> +
> +	/* 1: Reset the PCS Rx clock domain  */
> +	lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(1),
> +		DEV_CLOCK_CFG_PCS_RX_RST,
> +		lan9645x, DEV_CLOCK_CFG(p->chip_port));
> +
> +	p->speed = LAN9645X_SPEED_DISABLED;
> +	p->duplex = DUPLEX_UNKNOWN;
> +
> +	/* 3: Disable traffic being sent to or from switch port */
> +	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
> +		QSYS_SW_PORT_MODE_PORT_ENA,
> +		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> +
> +	/* 4: Disable dequeuing from the egress queues  */
> +	lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(1),
> +		QSYS_PORT_MODE_DEQUEUE_DIS,
> +		lan9645x, QSYS_PORT_MODE(p->chip_port));
> +
> +	/* 5: Disable Flowcontrol */
> +	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(0),
> +		SYS_PAUSE_CFG_PAUSE_ENA,
> +		lan9645x, SYS_PAUSE_CFG(p->chip_port));
> +
> +	/* 5.1: Disable PFC */
> +	lan_rmw(QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
> +		QSYS_SW_PORT_MODE_TX_PFC_ENA,
> +		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> +
> +	/* 6: Wait a worst case time 8ms (10K jumbo/10Mbit) */
> +	usleep_range(8 * USEC_PER_MSEC, 9 * USEC_PER_MSEC);
> +
> +	/* 7: Disable HDX backpressure. */
> +	lan_rmw(SYS_FRONT_PORT_MODE_HDX_MODE_SET(0),
> +		SYS_FRONT_PORT_MODE_HDX_MODE,
> +		lan9645x, SYS_FRONT_PORT_MODE(p->chip_port));
> +
> +	/* 8: Flush the queues associated with the port */
> +	lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(3),
> +		QSYS_SW_PORT_MODE_AGING_MODE,
> +		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> +
> +	/* 9: Enable dequeuing from the egress queues */
> +	lan_rmw(QSYS_PORT_MODE_DEQUEUE_DIS_SET(0),
> +		QSYS_PORT_MODE_DEQUEUE_DIS,
> +		lan9645x, QSYS_PORT_MODE(p->chip_port));
> +
> +	/* 10: Wait until flushing is complete */
> +	if (lan9645x_rd_poll_slow(lan9645x, QSYS_SW_STATUS(p->chip_port),
> +				  val, !QSYS_SW_STATUS_EQ_AVAIL_GET(val)))
> +		dev_err(lan9645x->dev, "Flush timeout chip port %u", port);
> +
> +	/* 11: Disable MAC tx */
> +	lan_rmw(DEV_MAC_ENA_CFG_TX_ENA_SET(0),
> +		DEV_MAC_ENA_CFG_TX_ENA,
> +		lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
> +
> +	/* 12: Reset the Port and MAC clock domains */
> +	lan_rmw(DEV_CLOCK_CFG_PORT_RST_SET(1),
> +		DEV_CLOCK_CFG_PORT_RST,
> +		lan9645x, DEV_CLOCK_CFG(p->chip_port));
> +
> +	/* Wait before resetting MAC clock domains. */
> +	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
> +
> +	lan_rmw(DEV_CLOCK_CFG_MAC_TX_RST_SET(1) |
> +		DEV_CLOCK_CFG_MAC_RX_RST_SET(1) |
> +		DEV_CLOCK_CFG_PORT_RST_SET(1),
> +		DEV_CLOCK_CFG_MAC_TX_RST |
> +		DEV_CLOCK_CFG_MAC_RX_RST |
> +		DEV_CLOCK_CFG_PORT_RST,
> +		lan9645x, DEV_CLOCK_CFG(p->chip_port));
> +
> +	/* 13: Clear flushing */
> +	lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(1),
> +		QSYS_SW_PORT_MODE_AGING_MODE,
> +		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
> +}
> +
> +static void lan9645x_phylink_mac_link_down(struct lan9645x *lan9645x, int port,
> +					   unsigned int link_an_mode,
> +					   phy_interface_t interface)
> +{
> +	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
> +
> +	lan9645x_phylink_port_down(lan9645x, port);
> +
> +	/* 14: Take PCS out of reset */
> +	lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
> +		DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
> +		DEV_CLOCK_CFG_PCS_RX_RST |
> +		DEV_CLOCK_CFG_PCS_TX_RST,
> +		lan9645x, DEV_CLOCK_CFG(p->chip_port));
> +}
> +
> +static struct lan9645x_port *
> +lan9645x_phylink_config_to_port(struct phylink_config *config)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	return lan9645x_to_port(dp->ds->priv, dp->index);
> +}
> +
> +static void
> +lan9645x_port_phylink_mac_config(struct phylink_config *config,
> +				 unsigned int mode,
> +				 const struct phylink_link_state *state)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +
> +	lan9645x_phylink_mac_config(p->lan9645x, p->chip_port, mode, state);
> +}
> +
> +static void lan9645x_port_phylink_mac_link_up(struct phylink_config *config,
> +					      struct phy_device *phydev,
> +					      unsigned int link_an_mode,
> +					      phy_interface_t interface,
> +					      int speed, int duplex,
> +					      bool tx_pause, bool rx_pause)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +
> +	lan9645x_phylink_mac_link_up(p->lan9645x, p->chip_port, link_an_mode,
> +				     interface, phydev, speed, duplex, tx_pause,
> +				     rx_pause);
> +}
> +
> +static void lan9645x_port_phylink_mac_link_down(struct phylink_config *config,
> +						unsigned int link_an_mode,
> +						phy_interface_t interface)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +
> +	lan9645x_phylink_mac_link_down(p->lan9645x, p->chip_port, link_an_mode,
> +				       interface);
> +}
> +
> +static int lan9645x_port_phylink_mac_prepare(struct phylink_config *config,
> +					     unsigned int mode,
> +					     phy_interface_t iface)
> +{
> +	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
> +
> +	return lan9645x_phylink_mac_prepare(p->lan9645x, p->chip_port, mode,
> +					    iface);
> +}
> +
> +const struct phylink_mac_ops lan9645x_phylink_mac_ops = {
> +	.mac_config			= lan9645x_port_phylink_mac_config,
> +	.mac_link_up			= lan9645x_port_phylink_mac_link_up,
> +	.mac_link_down			= lan9645x_port_phylink_mac_link_down,
> +	.mac_prepare			= lan9645x_port_phylink_mac_prepare,

Please order the functions, and the initialisers here in the same order
that they appear in struct phylink_mac_ops, which is:

	mac_prepare (this will be called first)
	mac_config (this will be called second)

	mac_link_down
	mac_link_up (this will be called last when bringing up the link)

The configuration functions (prepare, config, finish) are specifically
arranged in the order that they are called which helps make the code
more readable - and if you arrange the functions in the file in the
same order, then when one reads through the code, one reads the code in
the order it will be executed.

What you have is a bit like a book where the preface is oddly located
after the main body of the text!

> +};
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> new file mode 100644
> index 000000000000..038868ae0a32
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Microchip Technology Inc.
> + */
> +
> +#include "lan9645x_main.h"
> +
> +int lan9645x_port_init(struct lan9645x *lan9645x, int port)
> +{
> +	struct lan9645x_port *p;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +
> +	/* Disable learning on port */
> +	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(0),
> +		ANA_PORT_CFG_LEARN_ENA,
> +		lan9645x, ANA_PORT_CFG(p->chip_port));
> +
> +	lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
> +
> +	lan9645x_phylink_port_down(lan9645x, port);
> +
> +	if (phy_interface_num_ports(p->phy_mode) == 4)
> +		lan_rmw(DEV_CLOCK_CFG_PCS_RX_RST_SET(0) |
> +			DEV_CLOCK_CFG_PCS_TX_RST_SET(0),
> +			DEV_CLOCK_CFG_PCS_RX_RST |
> +			DEV_CLOCK_CFG_PCS_TX_RST,
> +			lan9645x, DEV_CLOCK_CFG(p->chip_port));

Two things I don't like here:

1. the use of phy_mode rather than working out another way to handle
   this.

2. I think the above is just a complex way of saying
	if (p->phy_mode == PHY_INTERFACE_MODE_QSGMII)

   since you don't support QUSGMII or 10G_QXGMII.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

