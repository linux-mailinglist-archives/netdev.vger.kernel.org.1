Return-Path: <netdev+bounces-297134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WfwnEBM1KGqoAAMAu9opvQ
	(envelope-from <netdev+bounces-297134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:45:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F7661EF3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:45:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LcGxZ5Yd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297134-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D0A323E397
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C248AE06;
	Tue,  9 Jun 2026 15:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA176481AAB;
	Tue,  9 Jun 2026 15:29:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018988; cv=none; b=mJi254pyk6vPfit6wcPQsxL5TuPSUmDuE8NnRoCe4IpVR3K2two5d+kewof2y2oZQ/6B0nqvIUzbPvP/GWaliIUiylWDYhPmjyCmmJ+X7NNYoQmUwWmEdfqyDRvGi9bAtsVy9v85RQBjoX7fG3RcgRoaahQJKemVNIJPTS2kQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018988; c=relaxed/simple;
	bh=Iey+KVSHrer1xSDrRH0aoKqVFIwktXA2Q6TNUw2TaQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw4AhlyZsTGzNcz1FjUE2OpRaQmmGsqKPEyQCz0r355VBUC4esB+10uPz766obFrrGHkO5ZQrUEGUHlxf/BvPrnrcdbNot998fMyx0ulON/ZzFGJOtfZRPriGxclhwiQB/+kiQ75rjsQ65aCmFP9TJzmAqTmsY62fYFaAed6TKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcGxZ5Yd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C501F00898;
	Tue,  9 Jun 2026 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018986;
	bh=+2Kg5NxevchnBqZEDOYXv8mXN0J4Mql1Y+krUmmSP5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LcGxZ5Yd4SSlkLWvwpsxzzCCJ4BGALNGtVJQbv1KeDc19iAMoXtq7FIjPlDhlDVx3
	 8ewSnyGjT/87TNzjSh4XRCGtteNVpaLJQLsmRTRrdzunOQaUjfQLcOKEeDjk4sx5Ns
	 OLtSoppPreDg3MHnnOtmpoBhg+oDds16QVWZz8PiGvh0nvbjxctXtg/naOHhs99wke
	 MEDfmlqWxuYlvQMuxlgZYR18RNbj0V+SDOa1xQuwUhryqcDpXaInzNpDVWr737ok1+
	 7WlV71I3MX84Dt3r8ojeE58bZzT+BCvcgdBRZetoNv8LgF4/ij6ROvyoLoY9O9h2tr
	 tBGN4D+HO5fhg==
Date: Tue, 9 Jun 2026 17:29:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v6 12/12] net: airoha: add phylink support
Message-ID: <aigxaDtZDnI-RTwN@lore-desk>
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
 <20260609151212.29469-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m10PdqwZCK4gPtEq"
Content-Disposition: inline
In-Reply-To: <20260609151212.29469-13-ansuelsmth@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297134-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9F7661EF3


--m10PdqwZCK4gPtEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add phylink support for each GDM port. For GDM1 add the internal interface
> mode as the only supported mode. For GDM2/3/4 add the required
> configuration of the PCS to make the external PHY or attached SFP cage
> work.
>=20
> These needs to be defined in the GDM port node using the pcs-handle
> property.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Hi Christian,

some nits inline.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/airoha/Kconfig       |   1 +
>  drivers/net/ethernet/airoha/airoha_eth.c  | 167 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  4 files changed, 181 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/a=
iroha/Kconfig
> index ad3ce501e7a5..38dcc76e5998 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -20,6 +20,7 @@ config NET_AIROHA
>  	depends on NET_DSA || !NET_DSA
>  	select NET_AIROHA_NPU
>  	select PAGE_POOL
> +	select PHYLINK
>  	help
>  	  This driver supports the gigabit ethernet MACs in the
>  	  Airoha SoC family.
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 5a8e84fa9918..eabd7b058f82 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -8,6 +8,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
> +#include <linux/pcs/pcs.h>

Can you please respect the alphabetic order?

>  #include <linux/u64_stats_sync.h>
>  #include <net/dst_metadata.h>
>  #include <net/page_pool/helpers.h>
> @@ -1779,6 +1780,15 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  	u32 cur_len, pse_port =3D FE_PSE_PORT_PPE1;
>  	struct airoha_qdma *qdma =3D dev->qdma;
> =20
> +	err =3D phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> +	if (err) {
> +		netdev_err(netdev, "%s: could not attach PHY: %d\n", __func__,
> +			   err);

Do we need specify the __func__ argument here?

> +		return err;
> +	}
> +
> +	phylink_start(dev->phylink);
> +
>  	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(dev, true);
>  	if (err)
> @@ -1876,6 +1886,9 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  		}
>  	}
> =20
> +	phylink_stop(dev->phylink);
> +	phylink_disconnect_phy(dev->phylink);
> +
>  	return 0;
>  }
> =20
> @@ -3148,6 +3161,153 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
th,
>  	return false;
>  }
> =20
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_config(struct phylink_config *config, unsigned in=
t mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy=
_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_dev *dev =3D container_of(config, struct airoha_gdm_d=
ev,
> +						  phylink_config);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +	u32 mask, val;
> +
> +	/* TX/RX frag is configured only for GDM4 */
> +	if (port->id !=3D 4)

	if (port->id !=3D AIROHA_GDM4_IDX)
		...

> +		return;
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx =3D 8;
> +		frag_size_rx =3D 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx =3D 2;
> +		frag_size_rx =3D 1;
> +		break;
> +	default:
> +		frag_size_tx =3D 1;
> +		frag_size_rx =3D 0;
> +	}
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDMA4_SGMII1_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDMA4_SGMII1_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}  else {
> +		mask =3D GDMA4_SGMII0_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}
> +	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG, mask, val);
> +
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDMA4_SGMII1_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDMA4_SGMII1_RX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	} else {
> +		mask =3D GDMA4_SGMII0_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}
> +	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG, mask, val);
> +}
> +
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_link_down(struct phylink_config *config, unsigned=
 int mode,
> +				 phy_interface_t interface)
> +{
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops =3D {
> +	.mac_config =3D airoha_mac_config,
> +	.mac_link_up =3D airoha_mac_link_up,
> +	.mac_link_down =3D airoha_mac_link_down,
> +};
> +
> +static int airoha_fill_available_pcs(struct phylink_config *config,
> +				     struct phylink_pcs **available_pcs,
> +				     unsigned int num_available_pcs)
> +{
> +	struct device *dev =3D config->dev;
> +
> +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> +					&num_available_pcs);
> +}
> +
> +static int airoha_setup_phylink(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct device_node *np =3D netdev->dev.of_node;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct phylink_config *config;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +	int err;
> +
> +	err =3D of_get_phy_mode(np, &phy_mode);
> +	if (err) {
> +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> +		return err;
> +	}
> +
> +	config =3D &dev->phylink_config;

remove new-line here.

> +
> +	config->dev =3D &netdev->dev;
> +	config->type =3D PHYLINK_NETDEV;
> +	config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |  MAC_1000=
0FD;
> +	if (port->id > AIROHA_GDM1_IDX)

maybe
	if (port->id !=3D AIROHA_GDM1_IDX)
		...

> +		config->mac_capabilities |=3D MAC_10 | MAC_100 | MAC_1000 |
> +					    MAC_2500FD | MAC_5000FD;
> +
> +	err =3D fwnode_phylink_pcs_parse(dev_fwnode(&netdev->dev), NULL,
> +				       &config->num_available_pcs);
> +	if (err)
> +		return err;
> +
> +	config->fill_available_pcs =3D airoha_fill_available_pcs;
> +
> +	/*
> +	 * GDM1 only supports internal for Embedded Switch
> +	 * and doesn't require a PCS.
> +	 */
> +	if (port->id =3D=3D AIROHA_GDM1_IDX) {
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	} else {
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +			  config->supported_interfaces);
> +
> +		phy_interface_copy(config->pcs_interfaces,
> +				   config->supported_interfaces);
> +	}
> +
> +	phylink =3D phylink_create(config, of_fwnode_handle(np),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	dev->phylink =3D phylink;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  				   struct airoha_gdm_port *port,
>  				   int nbq, struct device_node *np)
> @@ -3210,7 +3370,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  	dev->nbq =3D nbq;
>  	port->devs[index] =3D dev;
> =20
> -	return 0;
> +	return airoha_setup_phylink(netdev);
>  }
> =20
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> @@ -3435,8 +3595,10 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  				continue;
> =20
>  			netdev =3D netdev_from_priv(dev);
> -			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
> +			if (netdev->reg_state =3D=3D NETREG_REGISTERED) {
> +				phylink_destroy(dev->phylink);
>  				unregister_netdev(netdev);
> +			}
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> @@ -3472,6 +3634,7 @@ static void airoha_remove(struct platform_device *p=
dev)
>  				continue;
> =20
>  			netdev =3D netdev_from_priv(dev);
> +			phylink_destroy(dev->phylink);
>  			unregister_netdev(netdev);
>  			of_node_put(netdev->dev.of_node);
>  		}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..1b25603dc64d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -554,6 +554,9 @@ struct airoha_gdm_dev {
> =20
>  	u32 flags;
>  	int nbq;
> +
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  };
> =20
>  struct airoha_gdm_port {
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 436f3c8779c1..27f2583e143a 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -358,6 +358,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> =20
> +#define REG_GDMA4_TMBI_FRAG		0x2028
> +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
> +#define REG_GDMA4_RMBI_FRAG		0x202c
> +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
> =20
> --=20
> 2.53.0
>=20

--m10PdqwZCK4gPtEq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaigxaAAKCRA6cBh0uS2t
rHFPAP97cmj+8BfYEl8mUIGN3PZbVXiliyedKeir67osftOllgEA3Y4ia6CUElbJ
pr3Ro2MngcwyDQnAkJsLtyiN4LGLRgA=
=jfk1
-----END PGP SIGNATURE-----

--m10PdqwZCK4gPtEq--

