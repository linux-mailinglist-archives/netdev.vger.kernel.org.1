Return-Path: <netdev+bounces-290416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCXRC94CD2oaEQYAu9opvQ
	(envelope-from <netdev+bounces-290416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB95A5594
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20389300275B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE63C8C46;
	Thu, 21 May 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e+21ljY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867B2D3A75;
	Thu, 21 May 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368098; cv=none; b=PNhpAkWxJyYKxJVOvdrkizSwna54pz6P0mpmE0GQodPXi8VNEQzwxw0l88XgJohIgaMzQpvTpFQ1ep373+oMCIcU1N36c20dzWXZkqXZdcHS0duu8EpF2TWceYrALTkmU2sz7RRKQ+G1KxlejouRFerHaWVL76dOt4x+qxKPoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368098; c=relaxed/simple;
	bh=WxAvSACId+FdjWklt7hO86QaBnM3DNfEzwMkr6hcVBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D8eac2xluS8A5xywS7dlXRhxQ8iHBbog9RyQea90PppnZy6+NS2nR2Qrudl7VWx/EgWlXdNpYCU87OjkPMdx/XTTv9tUHEm5/J8+sOjdtdRhOWXmJfS+FYd9nXnYk87ec2XRtJjBJSayjCiakaNm+e57bU0Zsh2XBNLkMKT4MUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e+21ljY7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EB9121A3655;
	Thu, 21 May 2026 12:54:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8E6660495;
	Thu, 21 May 2026 12:54:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A0DF107E8B70;
	Thu, 21 May 2026 14:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779368092; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fRGlozrHREZ2fcUijAxpUrTE+vb3puyPu6g/y7UzeWY=;
	b=e+21ljY7QTAn2QhX//JmNTX4rBlH8H0l3oL+2YeK/uDPl5nteBXk+tetWx9lqwcKXfW3By
	C8mF3IwycaUSfWqARMdDZCG5kAZsiNEdvdJnEqzyLNw6Emr8L/rLO/DtXjhrSgkSANJQ02
	JKx2ZCqBb8ojR/jXJ+1gjR7D5GEoI/C6Ujo8PxeSFq2VP3yGG1neFwQMiRzhlITy9Hkgs5
	W7fVCkar+77PYg4bSYYgasDcHu5gX8tbqjK/w42myr1ACKlNUcvDoOcltzOdf7DUbGbzrJ
	u9h98LiIIUf1m2AG/r64837jJnRDNmAGHr2ADNBmCyLxz3yNSRGHT8xLCUdECQ==
Message-ID: <3681b6a5-7196-4b5a-8a4d-347abb62305c@bootlin.com>
Date: Thu, 21 May 2026 14:54:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net: dsa: mxl862xx: add support for SerDes ports
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1779330653.git.daniel@makrotopia.org>
 <dba64139e769c0e8a2f829363ece1abc1ccea6fe.1779330653.git.daniel@makrotopia.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <dba64139e769c0e8a2f829363ece1abc1ccea6fe.1779330653.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim,st.link:url]
X-Rspamd-Queue-Id: 2EFB95A5594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

I've only very briefly looked at this, so I'm afraid my comments aren't 
really about the logic, see bellow :(

On 5/21/26 04:41, Daniel Golle wrote:
> The MxL862xx has two XPCS/SerDes interfaces (XPCS0 for ports 9-12,
> XPCS1 for ports 13-16). Each can operate in various single-lane modes
> (SGMII, 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, USXGMII) or as
> QSGMII or 10G_QXGMII providing four sub-ports per interface.
> 
> Implement phylink PCS operations using the firmware's XPCS API:
> 
>    - pcs_config: configure negotiation mode and CL37/SGMII advertising.
>    - pcs_get_state: read link/speed/duplex/LPA from firmware and decode
>      using phylink's standard CL37, SGMII, and USXGMII decoders, with
>      firmware-resolved speed/duplex override for downshift detection.
>    - pcs_an_restart: restart CL37 or CL73 auto-negotiation.
>    - pcs_link_up: force speed/duplex for SGMII.
>    - pcs_inband_caps: report per-mode in-band status capabilities.
> 
> Register a PCS instance for each SerDes interface and
> QSGMII/10G_QXGMII sub-ports during setup. Advertise the supported
> interface modes in phylink_get_caps based on port number.
> 
> Lacking support for expressing PHY-side role modes in Linux only the
> MAC-side of SGMII, QSGMII, USXGMII and 10G_QXGMII are implemented for
> now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2:
>   * add __{LE,BE}_BITFIELD layouts to ABI structs
>   * per-sub-port QSGMII AN restart via usx_subport / usx_lane_mode
>   * shared-SerDes refcount in pcs_disable via per-XPCS slot bitmap
>   * let every sub-port call pcs_config
>   * cache phy_interface_t instead of firmware type
>   * skip pcs_link_up when inband-AN enabled
>   * gate phylink_get_caps SerDes modes on same FW version as select_pcs
>   * interpret xpcs_pcs_cfg.result as signed (s16)
>   * drop dead MXL862XX_PCS_PORT macro
>   * drop misleading "downshift detection" line from commit message
> 
>   drivers/net/dsa/mxl862xx/mxl862xx-api.h     | 358 ++++++++++++++++++++
>   drivers/net/dsa/mxl862xx/mxl862xx-cmd.h     |   9 +
>   drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 332 +++++++++++++++++-
>   drivers/net/dsa/mxl862xx/mxl862xx-phylink.h |   7 +
>   drivers/net/dsa/mxl862xx/mxl862xx.c         |   6 +-
>   drivers/net/dsa/mxl862xx/mxl862xx.h         |  31 ++
>   6 files changed, 740 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> index fb21ddc1bf1c..f55544772376 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> @@ -1366,4 +1366,362 @@ struct mxl862xx_rmon_port_cnt {
>   	__le64 tx_good_bytes;
>   } __packed;
>   
> +/**
> + * enum mxl862xx_xpcs_if_mode - XPCS interface mode
> + * @MXL862XX_XPCS_IF_SGMII: SGMII
> + * @MXL862XX_XPCS_IF_1000BASEX: 1000BASE-X
> + * @MXL862XX_XPCS_IF_2500BASEX: 2500BASE-X
> + * @MXL862XX_XPCS_IF_USXGMII: USXGMII (single or quad)
> + * @MXL862XX_XPCS_IF_10GBASER: 10GBASE-R
> + * @MXL862XX_XPCS_IF_10GKR: 10GBASE-KR
> + * @MXL862XX_XPCS_IF_5GBASER: 5GBASE-R
> + * @MXL862XX_XPCS_IF_QSGMII: QSGMII
> + */
> +enum mxl862xx_xpcs_if_mode {
> +	MXL862XX_XPCS_IF_SGMII = 0,
> +	MXL862XX_XPCS_IF_1000BASEX = 1,
> +	MXL862XX_XPCS_IF_2500BASEX = 2,
> +	MXL862XX_XPCS_IF_USXGMII = 3,
> +	MXL862XX_XPCS_IF_10GBASER = 4,
> +	MXL862XX_XPCS_IF_10GKR = 5,
> +	MXL862XX_XPCS_IF_5GBASER = 6,
> +	MXL862XX_XPCS_IF_QSGMII = 7,
> +};
> +
> +/**
> + * enum mxl862xx_xpcs_neg_mode - PCS negotiation mode
> + * @MXL862XX_XPCS_NEG_NONE: no inband negotiation
> + * @MXL862XX_XPCS_NEG_INBAND_AN_OFF: inband selected but AN disabled
> + * @MXL862XX_XPCS_NEG_INBAND_AN_ON: inband with AN enabled
> + */
> +enum mxl862xx_xpcs_neg_mode {
> +	MXL862XX_XPCS_NEG_NONE = 0,
> +	MXL862XX_XPCS_NEG_INBAND_AN_OFF = 1,
> +	MXL862XX_XPCS_NEG_INBAND_AN_ON = 2,
> +};
> +
> +/**
> + * enum mxl862xx_xpcs_role - PCS protocol role
> + * @MXL862XX_XPCS_ROLE_MAC: local end is MAC side (TX_CONFIG = 0)
> + * @MXL862XX_XPCS_ROLE_PHY: local end is PHY side (TX_CONFIG = 1)
> + *
> + * Selects the role the XPCS plays in protocols that have an asymmetric
> + * AN code word (Cisco SGMII / QSGMII / USXGMII). Drives
> + * VR_MII_AN_CTRL.TX_CONFIG: 0 means the local end receives the partner's
> + * AN word, 1 means it sources one. Ignored for symmetric protocols
> + * (1000BASE-X, 2500BASE-X, 10GBASE-R/KR).
> + */
> +enum mxl862xx_xpcs_role {
> +	MXL862XX_XPCS_ROLE_MAC = 0,
> +	MXL862XX_XPCS_ROLE_PHY = 1,
> +};
> +
> +/**
> + * enum mxl862xx_xpcs_usx_lane_mode - USXGMII lane mode
> + * @MXL862XX_XPCS_USX_SINGLE: single USXGMII lane
> + * @MXL862XX_XPCS_USX_QUAD: quad USXGMII (4 ports per lane)
> + */
> +enum mxl862xx_xpcs_usx_lane_mode {
> +	MXL862XX_XPCS_USX_SINGLE = 0,
> +	MXL862XX_XPCS_USX_QUAD = 1,
> +};
> +
> +/**
> + * union mxl862xx_xpcs_an_word - XPCS AN code word, tagged by interface mode
> + * @cl37: 16-bit base-page word exchanged over the CL37 hardware AN path
> + *        (SR_MII_AN_ADV on write, SR_MII_LP_BABL on read). Carries the
> + *        802.3 CL37 base page for 1000BASE-X/2500BASE-X and the Cisco
> + *        SGMII config word for SGMII/QSGMII.
> + * @usx: USXGMII 16-bit AN code word, MDIO_USXGMII_* layout
> + * @cl73: CL73 48-bit base page (10GBASE-KR), three 16-bit registers per
> + *        802.3 Annex 28C
> + * @cl73.adv1: CL73 SR_AN_ADV1 / SR_AN_LP_ABL1
> + * @cl73.adv2: CL73 SR_AN_ADV2 / SR_AN_LP_ABL2
> + * @cl73.adv3: CL73 SR_AN_ADV3 / SR_AN_LP_ABL3
> + *
> + * The host picks the right member based on the interface field of the
> + * surrounding struct (and, for the asymmetric protocols, on the role).
> + */
> +union mxl862xx_xpcs_an_word {
> +	__le16 cl37;
> +	__le16 usx;
> +	struct {
> +		__le16 adv1;
> +		__le16 adv2;
> +		__le16 adv3;
> +	} cl73;
> +} __packed;
> +
> +/**
> + * enum mxl862xx_xpcs_speed - PCS speed values
> + * @MXL862XX_XPCS_SPEED_UNKNOWN: unknown speed
> + * @MXL862XX_XPCS_SPEED_10: 10 Mbps
> + * @MXL862XX_XPCS_SPEED_100: 100 Mbps
> + * @MXL862XX_XPCS_SPEED_1000: 1000 Mbps
> + * @MXL862XX_XPCS_SPEED_2500: 2500 Mbps
> + * @MXL862XX_XPCS_SPEED_5000: 5000 Mbps
> + * @MXL862XX_XPCS_SPEED_10000: 10000 Mbps
> + */
> +enum mxl862xx_xpcs_speed {
> +	MXL862XX_XPCS_SPEED_UNKNOWN = 0,
> +	MXL862XX_XPCS_SPEED_10 = 10,
> +	MXL862XX_XPCS_SPEED_100 = 100,
> +	MXL862XX_XPCS_SPEED_1000 = 1000,
> +	MXL862XX_XPCS_SPEED_2500 = 2500,
> +	MXL862XX_XPCS_SPEED_5000 = 5000,
> +	MXL862XX_XPCS_SPEED_10000 = 10000,
> +};

These seem unused

> +
> +/**
> + * enum mxl862xx_xpcs_duplex - PCS duplex mode
> + * @MXL862XX_XPCS_DUPLEX_HALF: half duplex
> + * @MXL862XX_XPCS_DUPLEX_FULL: full duplex
> + */
> +enum mxl862xx_xpcs_duplex {
> +	MXL862XX_XPCS_DUPLEX_HALF = 0,
> +	MXL862XX_XPCS_DUPLEX_FULL = 1,
> +};
> +
> +/**
> + * enum mxl862xx_xpcs_loopback_mode - XPCS loopback mode
> + * @MXL862XX_XPCS_LB_DISABLE: disable all loopback
> + * @MXL862XX_XPCS_LB_PCS_SERIAL: PCS TX-to-RX serial loopback
> + * @MXL862XX_XPCS_LB_PCS_PARALLEL: PCS RX-to-TX parallel loopback
> + * @MXL862XX_XPCS_LB_PMA_SERIAL: PMA TX-to-RX serial loopback
> + * @MXL862XX_XPCS_LB_PMA_PARALLEL: PMA RX-to-TX parallel loopback
> + */
> +enum mxl862xx_xpcs_loopback_mode {
> +	MXL862XX_XPCS_LB_DISABLE = 0,
> +	MXL862XX_XPCS_LB_PCS_SERIAL = 1,
> +	MXL862XX_XPCS_LB_PCS_PARALLEL = 2,
> +	MXL862XX_XPCS_LB_PMA_SERIAL = 3,
> +	MXL862XX_XPCS_LB_PMA_PARALLEL = 4,
> +};
> +
> +/**
> + * enum mxl862xx_xpcs_reset_type - XPCS reset type
> + * @MXL862XX_XPCS_RESET_VR: vendor-specific reset (fast)
> + * @MXL862XX_XPCS_RESET_SOFT: PCS soft reset
> + * @MXL862XX_XPCS_RESET_HARD: full hardware reset
> + */
> +enum mxl862xx_xpcs_reset_type {
> +	MXL862XX_XPCS_RESET_VR = 0,
> +	MXL862XX_XPCS_RESET_SOFT = 1,
> +	MXL862XX_XPCS_RESET_HARD = 2,
> +};

These too

> +
> +/**
> + * struct mxl862xx_xpcs_pcs_cfg - PCS configuration parameters
> + * @port_id: XPCS port index (0-3)
> + * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
> + * @neg_mode: PCS negotiation mode. See &enum mxl862xx_xpcs_neg_mode
> + * @permit_pause: Allow pause to MAC
> + * @usx_lane_mode: USXGMII lane mode.
> + *                 See &enum mxl862xx_xpcs_usx_lane_mode
> + * @role: PCS protocol role. See &enum mxl862xx_xpcs_role
> + * @usx_subport: Sub-port (0-3) within the XPCS. Used by the firmware
> + *               to set MAC pause per sub-port; ignored for the
> + *               XPCS-wide bringup, which is idempotent across slots.
> + * @advertising: AN code word the local end transmits. The active union
> + *               member is selected by @interface (and, for the asymmetric
> + *               protocols, by @role). Ignored when the local end does
> + *               not transmit an AN word (role=MAC for SGMII/QSGMII/
> + *               USXGMII, 10GBASE-R, 5GBASE-R) or when @neg_mode is not
> + *               INBAND_AN_ON. Pass all-zero to keep the firmware default
> + *               advertisement.
> + * @result: Firmware result. >0 means the host must follow with an AN
> + *          restart, 0 means no host follow-up is needed, <0 is an errno.
> + */
> +struct mxl862xx_xpcs_pcs_cfg {
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8 port_id:2;
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> +	u8 permit_pause:1;
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 role:1; /* enum mxl862xx_xpcs_role */
> +	u8 usx_subport:2;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 port_id:2;
> +	u8 usx_subport:2;
> +	u8 role:1; /* enum mxl862xx_xpcs_role */
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 permit_pause:1;
> +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> +#else
> +#error "Unknown bitfield endianness"
> +#endif
> +	union mxl862xx_xpcs_an_word advertising;
> +	__le16 result;
> +} __packed;
> +
> +/**
> + * struct mxl862xx_xpcs_pcs_state - PCS link state
> + * @port_id: XPCS port index (0-3) (input)
> + * @interface: PCS interface mode (input).
> + *             See &enum mxl862xx_xpcs_if_mode
> + * @usx_lane_mode: USX lane mode (input)
> + * @usx_subport: USX sub-port 0-3 (input)
> + * @link: Link up (1) / down (0) (output)
> + * @an_complete: Auto-negotiation complete (output)
> + * @duplex: Duplex mode (output). See &enum mxl862xx_xpcs_duplex
> + * @pcs_fault: PCS fault (output)
> + * @pause: Pause negotiation result, bit 0 symmetric, bit 1 asymmetric
> + *         (output)
> + * @lp_eee_cap: Link partner supports EEE (output)
> + * @lp_eee_cs_cap: Link partner supports EEE clock-stop (output)
> + * @__rsv: reserved
> + * @__pad: padding
> + * @speed: Resolved speed (output). See &enum mxl862xx_xpcs_speed
> + * @lpa: Link partner ability word (output). Same union as
> + *       &union mxl862xx_xpcs_an_word; the host picks the member based on
> + *       @interface.
> + */
> +struct mxl862xx_xpcs_pcs_state {
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8 port_id:2;
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 usx_subport:2;
> +	u8 link:1;
> +	u8 an_complete:1;
> +	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
> +	u8 pcs_fault:1;
> +	u8 pause:2;
> +	u8 lp_eee_cap:1;
> +	u8 lp_eee_cs_cap:1;
> +	u8 __rsv:4;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 port_id:2;
> +	u8 pcs_fault:1;
> +	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
> +	u8 an_complete:1;
> +	u8 link:1;
> +	u8 usx_subport:2;
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 __rsv:4;
> +	u8 lp_eee_cs_cap:1;
> +	u8 lp_eee_cap:1;
> +	u8 pause:2;
> +#else
> +#error "Unknown bitfield endianness"
> +#endif
> +	u8 __pad;
> +	__le16 speed; /* enum mxl862xx_xpcs_speed */
> +	union mxl862xx_xpcs_an_word lpa;
> +} __packed;
> +
> +/**
> + * struct mxl862xx_xpcs_pcs_disable - PCS disable parameters
> + * @port_id: XPCS port index
> + * @__pad: padding
> + * @result: Firmware result. 0 on success, <0 on error.
> + *
> + * Asserts IDDQ + PHY + XPCS resets to power down the SERDES when the
> + * port is admin-down or no module is plugged in. The next PCS config
> + * implicitly powers it back up and reprograms the desired interface.
> + */
> +struct mxl862xx_xpcs_pcs_disable {
> +	u8 port_id;
> +	u8 __pad;
> +	__le16 result;
> +} __packed;
> +
> +/**
> + * struct mxl862xx_xpcs_an_restart - AN restart parameters
> + * @port_id: XPCS port index (0-3)
> + * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
> + * @usx_lane_mode: USX lane mode
> + * @usx_subport: Sub-port (0-3) within the XPCS. Selects the lane
> + *               whose AN is restarted for QSGMII and QUSXGMII;
> + *               ignored by single-lane modes.
> + * @__rsv: reserved
> + * @result: Firmware result. 0 on success, <0 on error.
> + *
> + * Restarts auto-negotiation on a single sub-port of the XPCS. The
> + * SERDES must already be configured.
> + */
> +struct mxl862xx_xpcs_an_restart {
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8 port_id:2;
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 usx_subport:2;
> +	u8 __rsv:4;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 port_id:2;
> +	u8 __rsv:4;
> +	u8 usx_subport:2;
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +#else
> +#error "Unknown bitfield endianness"
> +#endif
> +	__le16 result;
> +} __packed;
> +
> +/**
> + * struct mxl862xx_xpcs_pcs_link_up - PCS link-up parameters
> + * @port_id: XPCS port index (0-3)
> + * @interface: PCS interface mode. See &enum mxl862xx_xpcs_if_mode
> + * @duplex: Duplex mode. See &enum mxl862xx_xpcs_duplex
> + * @usx_lane_mode: USX lane mode (USXGMII only; ignored otherwise).
> + *                 See &enum mxl862xx_xpcs_usx_lane_mode
> + * @usx_subport: USX sub-port 0-3 (QUSXGMII only; ignored otherwise)
> + * @__rsv0: reserved
> + * @speed: Resolved speed. See &enum mxl862xx_xpcs_speed
> + * @result: Firmware result. 0 on success, <0 is errno.
> + *
> + * Called once per link-up event after the host has resolved the
> + * line-side speed/duplex (from the PHY's read_status, from a preceding
> + * PCS get-state, or from a fixed-link description).
> + */
> +struct mxl862xx_xpcs_pcs_link_up {
> +#ifdef __LITTLE_ENDIAN_BITFIELD
> +	u8 port_id:2;
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 usx_subport:2;
> +	u8 __rsv0:3;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> +	u8 port_id:2;
> +	u8 __rsv0:3;
> +	u8 usx_subport:2;
> +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> +	u8 duplex:1; /* enum mxl862xx_xpcs_duplex */
> +#else
> +#error "Unknown bitfield endianness"
> +#endif
> +	__le16 speed; /* enum mxl862xx_xpcs_speed */
> +	__le16 result;
> +} __packed;
> +
> +/**
> + * struct mxl862xx_xpcs_loopback_cfg - loopback control
> + * @port_id: XPCS port index
> + * @mode: loopback mode. See &enum mxl862xx_xpcs_loopback_mode
> + * @result: firmware result
> + */
> +struct mxl862xx_xpcs_loopback_cfg {
> +	u8 port_id;
> +	u8 mode; /* enum mxl862xx_xpcs_loopback_mode */
> +	__le16 result;
> +} __packed;

This too

> +
> +/**
> + * struct mxl862xx_xpcs_reset_cfg - XPCS reset
> + * @port_id: XPCS port index
> + * @reset_type: reset type. See &enum mxl862xx_xpcs_reset_type
> + * @result: firmware result
> + */
> +struct mxl862xx_xpcs_reset_cfg {
> +	u8 port_id;
> +	u8 reset_type; /* enum mxl862xx_xpcs_reset_type */
> +	__le16 result;
> +} __packed;

This too

> +
>   #endif /* __MXL862XX_API_H */
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> index f1ea40aa7ea0..c87a955c13c4 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> @@ -24,6 +24,7 @@
>   #define MXL862XX_SS_MAGIC		0x1600
>   #define GPY_GPY2XX_MAGIC		0x1800
>   #define SYS_MISC_MAGIC			0x1900
> +#define MXL862XX_XPCS_MAGIC		0x1a00
>   
>   #define MXL862XX_COMMON_CFGGET		(MXL862XX_COMMON_MAGIC + 0x9)
>   #define MXL862XX_COMMON_CFGSET		(MXL862XX_COMMON_MAGIC + 0xa)
> @@ -71,6 +72,14 @@
>   
>   #define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
>   
> +#define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
> +#define MXL862XX_XPCS_PCS_GET_STATE	(MXL862XX_XPCS_MAGIC + 0x2)
> +#define MXL862XX_XPCS_PCS_DISABLE	(MXL862XX_XPCS_MAGIC + 0x4)
> +#define MXL862XX_XPCS_AN_RESTART	(MXL862XX_XPCS_MAGIC + 0x5)
> +#define MXL862XX_XPCS_PCS_LINK_UP	(MXL862XX_XPCS_MAGIC + 0x7)
> +#define MXL862XX_XPCS_LOOPBACK		(MXL862XX_XPCS_MAGIC + 0x8)
> +#define MXL862XX_XPCS_RESET		(MXL862XX_XPCS_MAGIC + 0x9)
> +
>   #define MMD_API_MAXIMUM_ID		0x7fff
>   
>   #endif /* __MXL862XX_CMD_H */
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> index f17c429d1f1d..55be53d77cec 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> @@ -11,16 +11,343 @@
>   #include <net/dsa.h>
>   
>   #include "mxl862xx.h"
> +#include "mxl862xx-api.h"
> +#include "mxl862xx-cmd.h"
> +#include "mxl862xx-host.h"
>   #include "mxl862xx-phylink.h"
>   
>   void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
>   			       struct phylink_config *config)
>   {
> +	struct mxl862xx_priv *priv = ds->priv;
> +
>   	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
>   				   MAC_100 | MAC_1000 | MAC_2500FD;
>   
> -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> -		  config->supported_interfaces);
> +	switch (port) {
> +	case 1 ... 8:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 9:
> +	case 13:
> +		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
> +			break;
> +		__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_10GKR, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII, config->supported_interfaces);
> +		fallthrough;
> +	case 10 ... 12:
> +	case 14 ... 16:
> +		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
> +			break;
> +		__set_bit(PHY_INTERFACE_MODE_QSGMII, config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, config->supported_interfaces);
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (port == 9 || port == 13)
> +		config->mac_capabilities |= MAC_10000FD | MAC_5000FD;
> +}
> +
> +static struct mxl862xx_pcs *pcs_to_mxl862xx_pcs(struct phylink_pcs *pcs)
> +{
> +	return container_of(pcs, struct mxl862xx_pcs, pcs);
> +}
> +
> +static int mxl862xx_xpcs_if_mode(phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		return MXL862XX_XPCS_IF_SGMII;
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		return MXL862XX_XPCS_IF_QSGMII;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		return MXL862XX_XPCS_IF_1000BASEX;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return MXL862XX_XPCS_IF_2500BASEX;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10G_QXGMII:
> +		return MXL862XX_XPCS_IF_USXGMII;
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		return MXL862XX_XPCS_IF_10GBASER;
> +	case PHY_INTERFACE_MODE_10GKR:
> +		return MXL862XX_XPCS_IF_10GKR;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mxl862xx_xpcs_neg_mode(unsigned int neg_mode)
> +{
> +	if (!(neg_mode & PHYLINK_PCS_NEG_INBAND))
> +		return MXL862XX_XPCS_NEG_NONE;
> +	if (neg_mode & PHYLINK_PCS_NEG_ENABLED)
> +		return MXL862XX_XPCS_NEG_INBAND_AN_ON;
> +	return MXL862XX_XPCS_NEG_INBAND_AN_OFF;
> +}
> +
> +static void mxl862xx_pcs_disable(struct phylink_pcs *pcs)
> +{
> +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> +	struct mxl862xx_priv *priv = mpcs->priv;
> +	struct mxl862xx_xpcs_pcs_disable dis = {};

Reverse xmas tree I guess :)

> +
> +	/* The SerDes is shared across QSGMII/QUSXGMII sub-ports; only
> +	 * power it down once the last active sub-port goes away.
> +	 */
> +	priv->serdes_active[mpcs->serdes_id] &= ~BIT(mpcs->slot);
> +	if (priv->serdes_active[mpcs->serdes_id])
> +		return;
> +
> +	dis.port_id = mpcs->serdes_id;
> +
> +	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_PCS_DISABLE, dis);
> +}
> +
> +static int mxl862xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			       phy_interface_t interface,
> +			       const unsigned long *advertising,
> +			       bool permit_pause_to_mac)
> +{
> +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> +	struct mxl862xx_priv *priv = mpcs->priv;
> +	struct mxl862xx_xpcs_pcs_cfg cfg = {};
> +	int if_mode, ret;
> +	u16 adv;
> +
> +	mpcs->interface = interface;
> +	priv->serdes_active[mpcs->serdes_id] |= BIT(mpcs->slot);
> +
> +	if_mode = mxl862xx_xpcs_if_mode(interface);
> +	if (if_mode < 0) {
> +		dev_err(priv->ds->dev, "unsupported interface: %s\n",
> +			phy_modes(interface));
> +		return if_mode;
> +	}
> +
> +	/* The XPCS bringup is per-instance and idempotent in the
> +	 * firmware: every QSGMII/QUSXGMII sub-port may call pcs_config
> +	 * and the firmware will skip the bringup if the requested mode
> +	 * matches the cached one, then update MAC pause for the
> +	 * sub-port indicated by @usx_subport.
> +	 */
> +	cfg.port_id = mpcs->serdes_id;
> +	cfg.usx_subport = mpcs->slot;
> +	cfg.usx_lane_mode = (interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
> +			    MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
> +	cfg.interface = if_mode;
> +	cfg.neg_mode = mxl862xx_xpcs_neg_mode(neg_mode);
> +	cfg.role = MXL862XX_XPCS_ROLE_MAC;
> +	cfg.permit_pause = permit_pause_to_mac ? 1 : 0;
> +
> +	if (neg_mode & PHYLINK_PCS_NEG_INBAND) {
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +		case PHY_INTERFACE_MODE_2500BASEX:
> +			adv = linkmode_adv_to_mii_adv_x(advertising,
> +				ETHTOOL_LINK_MODE_1000baseX_Full_BIT);
> +			cfg.advertising.cl37 = cpu_to_le16(adv);
> +			break;
> +		case PHY_INTERFACE_MODE_SGMII:
> +		case PHY_INTERFACE_MODE_QSGMII:
> +			cfg.advertising.cl37 = cpu_to_le16(ADVERTISE_SGMII);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_CONFIG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return (s16)le16_to_cpu(cfg.result) > 0 ? 1 : 0;
> +}
> +
> +static void mxl862xx_pcs_get_state(struct phylink_pcs *pcs,
> +				   unsigned int neg_mode,
> +				   struct phylink_link_state *state)
> +{
> +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> +	struct mxl862xx_priv *priv = mpcs->priv;
> +	struct mxl862xx_xpcs_pcs_state st = {};
> +	int if_mode, ret;
> +	u16 bmsr;
> +
> +	if_mode = mxl862xx_xpcs_if_mode(state->interface);
> +	if (if_mode < 0)
> +		return;
> +
> +	st.port_id = mpcs->serdes_id;
> +	st.interface = if_mode;
> +	st.usx_subport = mpcs->slot;
> +
> +	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_GET_STATE, st);
> +	if (ret)
> +		return;
> +
> +	state->link = st.link && !st.pcs_fault;
> +	state->an_complete = st.an_complete;
> +
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		bmsr = (state->link ? BMSR_LSTATUS : 0) |
> +		       (state->an_complete ? BMSR_ANEGCOMPLETE : 0);
> +		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr,
> +						 le16_to_cpu(st.lpa.cl37));
> +		break;
> +
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10G_QXGMII:
> +		if (state->link)
> +			phylink_decode_usxgmii_word(state,
> +						    le16_to_cpu(st.lpa.usx));
> +		break;
> +
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_10GKR:
> +		if (state->link) {
> +			state->speed = SPEED_10000;
> +			state->duplex = DUPLEX_FULL;
> +		}
> +		break;
> +
> +	default:
> +		state->link = false;
> +		break;
> +	}
> +}
> +
> +static void mxl862xx_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> +	struct mxl862xx_priv *priv = mpcs->priv;
> +	struct mxl862xx_xpcs_an_restart an = {};
> +	int if_mode;
> +
> +	if_mode = mxl862xx_xpcs_if_mode(mpcs->interface);
> +	if (if_mode < 0)
> +		return;
> +
> +	an.port_id = mpcs->serdes_id;
> +	an.interface = if_mode;
> +	an.usx_subport = mpcs->slot;
> +	an.usx_lane_mode = (mpcs->interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
> +			   MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
> +
> +	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_AN_RESTART, an);
> +}
> +
> +static void mxl862xx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				 phy_interface_t interface, int speed,
> +				 int duplex)
> +{
> +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> +	struct mxl862xx_priv *priv = mpcs->priv;
> +	struct mxl862xx_xpcs_pcs_link_up lu = {};
> +	int if_mode;

here aswell

> +
> +	/* With inband-AN enabled (role=MAC), the XPCS auto-resolves
> +	 * speed/duplex from the partner's AN word and the firmware
> +	 * short-circuits link_up.  Skip the firmware round-trip, same
> +	 * as pcs-mtk-lynxi.
> +	 */
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		return;
> +
> +	if_mode = mxl862xx_xpcs_if_mode(interface);
> +	if (if_mode < 0)
> +		return;
> +
> +	lu.port_id = mpcs->serdes_id;
> +	lu.interface = if_mode;
> +	lu.duplex = (duplex == DUPLEX_FULL) ? MXL862XX_XPCS_DUPLEX_FULL :
> +					      MXL862XX_XPCS_DUPLEX_HALF;
> +	lu.speed = cpu_to_le16(speed);
> +
> +	MXL862XX_API_WRITE(priv, MXL862XX_XPCS_PCS_LINK_UP, lu);
> +}
> +
> +static unsigned int mxl862xx_pcs_inband_caps(struct phylink_pcs *pcs,
> +					     phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_QSGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10G_QXGMII:
> +	case PHY_INTERFACE_MODE_10GKR:
> +		return LINK_INBAND_ENABLE;
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		return LINK_INBAND_DISABLE;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct phylink_pcs_ops mxl862xx_pcs_ops = {
> +	.pcs_disable = mxl862xx_pcs_disable,
> +	.pcs_config = mxl862xx_pcs_config,
> +	.pcs_get_state = mxl862xx_pcs_get_state,
> +	.pcs_an_restart = mxl862xx_pcs_an_restart,
> +	.pcs_link_up = mxl862xx_pcs_link_up,
> +	.pcs_inband_caps = mxl862xx_pcs_inband_caps,
> +};
> +
> +void mxl862xx_setup_pcs(struct mxl862xx_priv *priv, struct mxl862xx_pcs *pcs,
> +			int port)
> +{
> +	pcs->priv = priv;
> +	pcs->serdes_id = MXL862XX_SERDES_PORT_ID(port);
> +	pcs->slot = MXL862XX_SERDES_SLOT(port);
> +	pcs->interface = PHY_INTERFACE_MODE_NA;
> +
> +	pcs->pcs.ops = &mxl862xx_pcs_ops;
> +	pcs->pcs.poll = true;
> +
> +	__set_bit(PHY_INTERFACE_MODE_QSGMII, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, pcs->pcs.supported_interfaces);
> +	if (pcs->slot != 0)
> +		return;
> +
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_10GBASER, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_10GKR, pcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_USXGMII, pcs->pcs.supported_interfaces);
> +}
> +
> +static struct phylink_pcs *
> +mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
> +				phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct mxl862xx_priv *priv = dp->ds->priv;
> +	int port = dp->index;
> +
> +	if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
> +		return NULL;
> +
> +	switch (port) {
> +	case 9 ... 16:
> +		return &priv->serdes_ports[port - 9].pcs;
> +	default:
> +		return NULL;
> +	}
>   }
>   
>   static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> @@ -48,4 +375,5 @@ const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
>   	.mac_config = mxl862xx_phylink_mac_config,
>   	.mac_link_down = mxl862xx_phylink_mac_link_down,
>   	.mac_link_up = mxl862xx_phylink_mac_link_up,
> +	.mac_select_pcs = mxl862xx_phylink_mac_select_pcs,
>   };
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> index c3d5215bdf60..03bb9caad9aa 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
> @@ -7,8 +7,15 @@
>   
>   #include "mxl862xx.h"
>   
> +#define MXL862XX_SERDES_SLOT(port) \
> +	(((port) - MXL862XX_FIRST_SERDES_PORT) % MXL862XX_SERDES_SLOTS)
> +#define MXL862XX_SERDES_PORT_ID(port) \
> +	(((port) - MXL862XX_FIRST_SERDES_PORT) / MXL862XX_SERDES_SLOTS)
> +
>   extern const struct phylink_mac_ops mxl862xx_phylink_mac_ops;
>   void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
>   			       struct phylink_config *config);
> +void mxl862xx_setup_pcs(struct mxl862xx_priv *priv, struct mxl862xx_pcs *pcs,
> +			int port);
>   
>   #endif /* __MXL862XX_PHYLINK_H */
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 0b1a23364eb5..0af41efccbc6 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -622,7 +622,7 @@ static int mxl862xx_setup(struct dsa_switch *ds)
>   	int n_user_ports = 0, max_vlans;
>   	int ingress_finals, vid_rules;
>   	struct dsa_port *dp;
> -	int ret;
> +	int ret, i;
>   
>   	ret = mxl862xx_reset(priv);
>   	if (ret)
> @@ -632,6 +632,10 @@ static int mxl862xx_setup(struct dsa_switch *ds)
>   	if (ret)
>   		return ret;
>   
> +	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
> +		mxl862xx_setup_pcs(priv, &priv->serdes_ports[i],
> +				   i + MXL862XX_FIRST_SERDES_PORT);
> +
>   	/* Calculate Extended VLAN block sizes.
>   	 * With VLAN Filter handling VID membership checks:
>   	 *   Ingress: only final catchall rules (PVID insertion, 802.1Q
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> index 79fd32c4db4e..d5879094ffd3 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
> @@ -11,6 +11,9 @@
>   struct mxl862xx_priv;
>   
>   #define MXL862XX_MAX_PORTS		17
> +#define MXL862XX_FIRST_SERDES_PORT	9
> +#define MXL862XX_SERDES_SLOTS		4
> +
>   #define MXL862XX_DEFAULT_BRIDGE		0
>   #define MXL862XX_MAX_BRIDGES		48
>   #define MXL862XX_MAX_BRIDGE_PORTS	128
> @@ -242,6 +245,26 @@ struct mxl862xx_port {
>   	spinlock_t stats_lock; /* protects stats accumulators */
>   };
>   
> +/**
> + * struct mxl862xx_pcs - link SerDes interfaces to bridge ports
> + * @pcs:       &struct phylink_pcs instance
> + * @priv:      pointer to &struct mxl862xx_priv
> + * @serdes_id: SerDes instance index (0 or 1)
> + * @slot:      slot within the SerDes (0-3 for QSGMII/QUSXGMII, 0 otherwise)
> + * @interface: cached PHY interface, last value passed to pcs_config().
> + *             %PHY_INTERFACE_MODE_NA before the first successful
> + *             pcs_config().  Used by pcs_an_restart() to populate the
> + *             firmware command and by pcs_disable() to skip the
> + *             firmware power-down for shared (QSGMII/QUSXGMII) modes.
> + */
> +struct mxl862xx_pcs {
> +	struct phylink_pcs pcs;
> +	struct mxl862xx_priv *priv;
> +	int serdes_id;
> +	int slot;
> +	phy_interface_t interface;
> +};
> +
>   /**
>    * union mxl862xx_fw_version - firmware version for comparison and display
>    * @major: firmware major version
> @@ -293,6 +316,12 @@ union mxl862xx_fw_version {
>    *                      flooding)
>    * @fw_version:         cached firmware version, populated at probe and
>    *                      compared with MXL862XX_FW_VER_MIN()
> + * @serdes_ports:       SerDes interfaces incl. sub-interfaces in case of
> + *                      10G_QXGMII or QSGMII
> + * @serdes_active:      per-XPCS bitmap, BIT(slot) set while that
> + *                      sub-port's PCS is enabled by phylink.  pcs_disable
> + *                      only powers the XPCS down once the last bit
> + *                      clears.  Updates are serialised by rtnl.
>    * @ports:              per-port state, indexed by switch port number
>    * @bridges:            maps DSA bridge number to firmware bridge ID;
>    *                      zero means no firmware bridge allocated for that
> @@ -311,6 +340,8 @@ struct mxl862xx_priv {
>   	unsigned long flags;
>   	u16 drop_meter;
>   	union mxl862xx_fw_version fw_version;
> +	struct mxl862xx_pcs serdes_ports[8];
> +	u8 serdes_active[2];
>   	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
>   	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
>   	u16 evlan_ingress_size;

Thanks :)


