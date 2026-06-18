Return-Path: <netdev+bounces-300440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3/0kOXrvM2ohJQYAu9opvQ
	(envelope-from <netdev+bounces-300440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:15:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 837986A0639
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kMwaElRg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300440-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0351E300D35C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6316279DAD;
	Thu, 18 Jun 2026 13:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2F280A56;
	Thu, 18 Jun 2026 13:15:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788536; cv=none; b=cfzlRZIpp903ZI5n8Cvy/+nKJqXNBN9Cp4tFNPMkz8CM7hZcszWJbk2MjU+wDEqdsXZOlMAnf329wKCi8BavXfr2KlD3hz6LgU8vD/OlH+6XP6XfWiIlHlUh9x7jsTLJ3AbiJY8b9d2T5K8ztT2kCQCkSKJ+fPQHxEr1PDuWkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788536; c=relaxed/simple;
	bh=ixTRO2pC2ljvSqduN7Mesvx4DF+obeSftTzwY/+j3Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbwslXd9XQWSYFS9J38ujORxkINqRkP6F+ObO4nhh3raHfZVlZjOV9goupMpc6P3m8sYcs4OaMpzwtKKutjSGJtpiAKvnGULJfgap2ZlZbTiopoQyBfNhbJ6MOx7K0nJbuN03XszEzYvRfnWC6foE8v1rgPG/9ngBWD7zQhSFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMwaElRg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD8C1F000E9;
	Thu, 18 Jun 2026 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788533;
	bh=se2VEvwaaMu2VOCsN9h9emYfqka530EJJi0CgvGS/WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kMwaElRg0hhN8Qwm5J8gj8ms3DfexMQKUxzaebGOiyu31Owe41G2aL8BF5YnSRZE8
	 CYTaFmVsPQdgCHEPnelBc4l+WIuRmxR2wZmK2Ke5yDtlDv9MeU3LAptPCRQq3Fvt7V
	 j8XJl2Gfmk3lK+DVEokqiocnhLCvykZXJf0XT8YoxBGBSIjDLxkQIDocD2p+FrPe6f
	 hTpnCmsxT118emtJ8TXyY3a1rWUP5cNtpX4lXe2Gf6ftTcC0tTZoF/jAFvmBvqMM3H
	 02qNdkhAPP0bkboU9rce6WjAr9A8ep42eoDklISqD94R7/Qg/KkaTrZS4GwTg8y/XM
	 R+2ee7Aeutymw==
Date: Thu, 18 Jun 2026 15:15:31 +0200
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
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [RFC PATCH net-next v8 12/12] net: airoha: add phylink support
Message-ID: <ajPvcwbdLpG9cNd6@lore-desk>
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
 <20260618125752.1223-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q//wKL9lmzZ1YScn"
Content-Disposition: inline
In-Reply-To: <20260618125752.1223-13-ansuelsmth@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300440-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 837986A0639


--q//wKL9lmzZ1YScn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

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
> +	if (port->id !=3D AIROHA_GDM4_IDX)
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
> +	spin_lock(&port->lock);

Using a spin_lock seems overkill here to me since airoha_mac_link_up()
run in the process context and the spin_lock you are acquiring here
was just used for stats. Since mac_link_up is running in some cases
acquiring RTNL, I guess you can even do something like:

	bool rtnl =3D rtnl_is_locked();

	if (!rtnl)
		rtnl_lock();
	...
	if (!rtnl)
		rtnl_unlock();

Regards,
Lorenzo

> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDM4_SGMII1_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}  else {
> +		mask =3D GDM4_SGMII0_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}
> +	airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG, mask, val);
> +
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDM4_SGMII1_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx);
> +	} else {
> +		mask =3D GDM4_SGMII0_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx);
> +	}
> +	airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG, mask, val);
> +
> +	spin_unlock(&port->lock);
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
> +				     unsigned int num_possible_pcs)
> +{
> +	struct device *dev =3D config->dev;
> +
> +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> +					num_possible_pcs);
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
> +	config->dev =3D &netdev->dev;
> +	config->type =3D PHYLINK_NETDEV;
> +
> +	/*
> +	 * GDM1 only supports internal for Embedded Switch
> +	 * and doesn't require a PCS.
> +	 */
> +	if (port->id =3D=3D AIROHA_GDM1_IDX) {
> +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10000FD;
> +
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	} else {
> +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10 | MAC_100 | MAC_1000 |
> +					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
> +
> +		config->num_possible_pcs =3D fwnode_phylink_pcs_count(dev_fwnode(confi=
g->dev));
> +		config->fill_available_pcs =3D airoha_fill_available_pcs;
> +
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
> @@ -3231,7 +3411,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  	dev->nbq =3D nbq;
>  	port->devs[index] =3D dev;
> =20
> -	return 0;
> +	return airoha_setup_phylink(netdev);
>  }
> =20
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> @@ -3266,7 +3446,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
>  		return -ENOMEM;
> =20
>  	port->id =3D id;
> -	spin_lock_init(&port->stats_lock);
> +	spin_lock_init(&port->lock);
>  	eth->ports[p] =3D port;
> =20
>  	err =3D airoha_metadata_dst_alloc(port);
> @@ -3457,6 +3637,8 @@ static int airoha_probe(struct platform_device *pde=
v)
>  			netdev =3D netdev_from_priv(dev);
>  			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
>  				unregister_netdev(netdev);
> +			if (dev->phylink)
> +				phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> @@ -3493,6 +3675,7 @@ static void airoha_remove(struct platform_device *p=
dev)
> =20
>  			netdev =3D netdev_from_priv(dev);
>  			unregister_netdev(netdev);
> +			phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 46b1c31939de..a6fef1777c7b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -554,6 +554,9 @@ struct airoha_gdm_dev {
>  	int nbq;
> =20
>  	struct airoha_hw_stats stats;
> +
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  };
> =20
>  struct airoha_gdm_port {
> @@ -561,8 +564,8 @@ struct airoha_gdm_port {
>  	int id;
>  	int users;
> =20
> -	/* protect concurrent hw_stats accesses */
> -	spinlock_t stats_lock;
> +	/* protect concurrent hw_stats and frag register accesses */
> +	spinlock_t lock;
> =20
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 436f3c8779c1..6ad91ca6dcd3 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -358,6 +358,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> =20
> +#define REG_FE_GDM4_TMBI_FRAG		0x2028
> +#define GDM4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDM4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDM4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDM4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
> +#define REG_FE_GDM4_RMBI_FRAG		0x202c
> +#define GDM4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDM4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDM4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDM4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
> =20
> --=20
> 2.53.0
>=20

--q//wKL9lmzZ1YScn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajPvcwAKCRA6cBh0uS2t
rL+4AQCUijQJBrj+Gjuv2DnvPvVIwe5oHlK0vKutEoEeFo1zjAEAxiDyyse+yJms
U7RXnPvswTa1DQ447pQOkBd7hrgv5AM=
=MTUd
-----END PGP SIGNATURE-----

--q//wKL9lmzZ1YScn--

