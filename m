Return-Path: <netdev+bounces-289937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLM9CzKqDWpr1AUAu9opvQ
	(envelope-from <netdev+bounces-289937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6B58DC0C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F3A0300C03C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407F3DA5CF;
	Wed, 20 May 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN/NpN+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323653D6CDA;
	Wed, 20 May 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280420; cv=none; b=q1OoGLJKIbsoeb1gzXpaJIDwvD5V+5e2xl0Ugi4ICfl0+eE9fugpMgnsEMqcLTKVLnkXnZGxpAkkYfx9EI+G45DIwUtuAn42mIbse8jiuZD8XoNG1rSRP12qHhTtK1tETQ6VSI42eOvTdvjQhwxQIfdA36wIkSpbSboGdg2XHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280420; c=relaxed/simple;
	bh=0wH35MlgvbCcBrEwZtIsYCL1Mcy4Xom8xZ1IVm/3NG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+HEVZ20dPmGdz5vjER7DD7aHl6I7kig/ClEaDcwUeOWrZdnxZ0hgZIri8NHS2vhuukRv7MyjJc9GTXdP4eA7CImJ0Y+y1KaNDXCMcxTgo1Oy/Xh0hHGPo7QW0QpXB9qx51UsLQpNryAIA3Z5j3hgdAMj/BIp1kBjSb6L1ikoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN/NpN+5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516E21F000E9;
	Wed, 20 May 2026 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280418;
	bh=VyaEOjHP1hqTYE60zgia3ekAoMflkGlYADHxZdY2o5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KN/NpN+5q7A9+ajbzYERRwkgEOwsIbWd4PRPoV4bo4BMGD0EEc8TJzxGjeVXu5SVJ
	 HscKeIqtpFhxImkX9UldTuoLsJeZhGBri47P87/vbspqawn82ZrS1uWKeHah2XO1HY
	 u8pc2EnzFeL0BM6q6TDGf3L77AfFzLOL13TbV+mLqQ/zdzIyU+6rONWRuTL6/T8253
	 XmlB+Bi9lTiVOMtj1KGt8ruAThlT1Jb+S3DhHWaVAT6RRe31iNaefZEnx22OpLcPDi
	 vAJdW62RBdjq+fyQVMRJBQHlqh16Qn3BlybAW4EVvlvd0lOu39Pgen2IDgxNjM7jdt
	 +633Fgu153EdQ==
Date: Wed, 20 May 2026 14:33:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 07/10] net: airoha: Support multiple
 net_devices for a single FE GDM port
Message-ID: <ag2qINUrMh7e3FJr@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-7-6bd70e329df6@kernel.org>
 <20260520085933.35D171F00897@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UWr99hrsTAdlrk3r"
Content-Disposition: inline
In-Reply-To: <20260520085933.35D171F00897@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 16E6B58DC0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--UWr99hrsTAdlrk3r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Port-wide hardware configuration is improperly modified via per-=
net_device callbacks, breaking the newly introduced 1:N relationship.
> - [High] Sequential initialization of multiple net_devices sharing a GDM =
port silently overwrites singleton hardware loopback and WAN configuration =
registers.
> --
>=20
> commit d922e17d3b113696fc139ac4b2b3ef81e2b9ad50
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple net_devices for a single FE GDM port
>=20
> This commit introduces support for multiple net_devices connected to the
> same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw arbiter.
> It updates the airoha_gdm_port structure to hold an array of devices inst=
ead
> of a single device.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index fbb50dc73af84..fc49f0049983e 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> [ ... ]
> > @@ -540,19 +541,20 @@ struct airoha_qdma {
> >  struct airoha_gdm_dev {
> >  	struct airoha_gdm_port *port;
> >  	struct airoha_qdma *qdma;
> > -	struct net_device *dev;
> >  	struct airoha_eth *eth;
> > +	struct net_device *dev;
> > =20
> >  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> >  	/* qos stats counters */
> >  	u64 cpu_tx_packets;
> >  	u64 fwd_tx_packets;
> > +
> > +	int nbq;
> >  };
> > =20
> >  struct airoha_gdm_port {
> > -	struct airoha_gdm_dev *dev;
> > +	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
> >  	int id;
> > -	int nbq;
>=20
> This introduces a 1:N relationship between a GDM port and net_devices, but
> are the net_device lifecycle and MTU callbacks updated to account for sha=
red
> ports?
>=20
> Looking at airoha_dev_stop(), the driver unconditionally drops all traffic
> for the port:
>=20
> airoha_dev_stop()
>     airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id), FE_=
PSE_PORT_DROP);
>    =20
> Since this modifies the forwarding configuration for the entire GDM port,
> does stopping just one net_device silently drop all traffic for the port,
> breaking any other active net_devices sharing it?
>=20
> Similarly, airoha_dev_change_mtu() overwrites port-wide hardware registers
> such as REG_GDM_LEN_CFG. Could this lower the port MTU while another devi=
ce
> still requires a larger MTU?
>=20
> I note this regression is addressed later in the series by commit
> 646f1e7bb6021 (net: airoha: Do not stop GDM port if it is shared).
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 27b214ce2a4ed..8d36ab6cd7854 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1830,7 +1831,7 @@ static int airoha_set_gdm2_loopback(struct airoha=
_gdm_dev *dev)
> >  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> >  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> > =20
> > -	src_port =3D eth->soc->ops.get_sport(port, port->nbq);
> > +	src_port =3D eth->soc->ops.get_sport(port, dev->nbq);
> >  	if (src_port < 0)
> >  		return src_port;
> > =20
>=20
> When multiple net_devices sharing a GDM port are sequentially initialized
> via ndo_init (airoha_dev_init()), they unconditionally call
> airoha_set_gdm2_loopback().
>=20
> Inside this function, global singleton hardware registers are modified:
>=20
> airoha_set_gdm2_loopback()
>     airoha_fe_rmw(eth, REG_FE_WAN_PORT,
>                   WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
>                   FIELD_PREP(WAN0_MASK, src_port));
>=20
> Does initializing the second device on the same port silently overwrite
> the hardware loopback and WAN configuration of the previously initialized
> device?
>=20
> I see this regression is resolved later in the series by commit
> 8a565b44990bb (net: airoha: Introduce WAN device flag).
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260519-airoha-eth-=
multi-serdes-v8-0-6bd70e329df6@kernel.org?part=3D7

Commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519-airoha-eth-mul=
ti-serdes-v8-0-6bd70e329df6%40kernel.org

- The per-port hardware MIB counters live on the GDM port, but
  airoha_dev_get_stats64() returns dev->port->stats and
  airoha_update_hw_stats() reads REG_FE_GDM_*_CNT_*(port->id) into that
  shared structure followed by REG_FE_GDM_MIB_CLEAR.  With two netdevs now
  sharing a single GDM3 or GDM4 port, would both siblings report identical
  combined byte/packet counters via ip -s link show, since there is no
  per-dev SW counter to disambiguate the shared HW MIB?
  - This issue will be fixed with a dedicated patch not in the series.

Regards,
Lorenzo

--UWr99hrsTAdlrk3r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCag2qIAAKCRA6cBh0uS2t
rLASAP9qOxiZFoU4XNPIrr/i/6XoSHz60uQNVvhZvhW3zx8QQgD2PLhU8vp3N6hG
/CQWMan0EGJxQksiQleinr3mg+6fBA==
=hYxz
-----END PGP SIGNATURE-----

--UWr99hrsTAdlrk3r--

