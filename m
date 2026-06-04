Return-Path: <netdev+bounces-295128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3vkoOr5BIWpKCAEAu9opvQ
	(envelope-from <netdev+bounces-295128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5763E674
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lodid3iO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295128-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 040C63072AB0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1F3F5BCE;
	Thu,  4 Jun 2026 09:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB53988F8;
	Thu,  4 Jun 2026 09:03:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563790; cv=none; b=A6mmKSLsycyg+xM294u2XM07LcloeoPVa8aoGP7ETVG8V09bmhC+YVdGCCmBMPSBkKMAc5hacZdctrvWIbCGj9ehXmmh/m8H6d81Fi0Zv/aFSdVE4t4TMa1see7q6jcJvRrpc49PmYjItj1EiYNSNkQIMGByLs1FycLF5aTYe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563790; c=relaxed/simple;
	bh=pdCZW0Nv4rGJC7vYq2kzSF9tdbL4yemU2nDjlN7ZEYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+aOcfifbOseAvhCS2T8CAheuw0arsxnNdT9k3lIDLjMJkxjoWGQvZOEHalgZdgVsjwhjj/XmCC1sLNnRhOI3OWEJOfX6p3j85MekFv8lt5fbNw1weNMJjeTWZmixVE0Wk2zwfi+lxmk7OiaUSk8wp70691Zr/ydIXA55FuCr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lodid3iO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E52C1F00893;
	Thu,  4 Jun 2026 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780563788;
	bh=Vv2KZQzlj+kvn26HfHTSCpLW9E9m5jlROFD0yErTScA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lodid3iOO9V6zyNLwhPJXt6u+NPWJn7LxFFIqnUhbWvp64+ODYM1NorzXtCHdnpeI
	 WBiqdns6vBPwz5oVaj3R9YKbSzH05euPVcXcmOBLwf15tS9vPzAjA9toqmmpYrfUs4
	 8pUSfVerfxTjxxopB3awN8nUgOPueU5TQ3y31ziBHbd9ZcRsznjhtmwpBlWuCfDimE
	 Ywj3qfYCTZh2wGT+Yj+dSnSQhr4AamZjIhiwce14kiRDII0qmF9A8PeDiD3xu6Qmn3
	 ANam/MG/qLIou1nglCcq2OllZncE3sR8ZpxetOaj1QEJ+84o6OwFO5ToPi/sWbU8j9
	 z4bnZIHX6YM5g==
Date: Thu, 4 Jun 2026 11:03:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 6/6] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <aiE_SnocP64Eg54B@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-6-5d476bc2f426@kernel.org>
 <20260604060126.0DF2B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqo63t7tWet7a99i"
Content-Disposition: inline
In-Reply-To: <20260604060126.0DF2B1F00899@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lore-desk:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2C5763E674


--gqo63t7tWet7a99i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The MAC address MSB validation introduces a configuration deadlo=
ck, permanently preventing MAC address MSB updates when multiple interfaces=
 are registered.
> - [High] Unconditional overwrite of `ref_addr` in the interface evaluatio=
n loop breaks MSB validation and corrupts hardware L2 bounds.
> --
>=20
> commit ca5c4a90447cc1f9bdc3a2831da1cfe304652070
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
> MAC addresses. This commit extends the logic to derive the correct minimum
> and maximum values for MAC LSB bounds when multiple interfaces are config=
ured.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 64ee526da2414..8f2608293bb72 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,76 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> [ ... ]
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
> > +	u8 ref_addr[ETH_ALEN] __aligned(2);
> >  	struct airoha_eth *eth =3D dev->eth;
> > -	u32 val, reg;
> > +	u32 reg, val, lmin, lmax;
> > +	int i;
> > +
> > +	eth_zero_addr(ref_addr);
> > +	lmin =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> > +	lmax =3D lmin;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		struct airoha_gdm_port *port =3D eth->ports[i];
> > +		int j;
> > +
> > +		if (!port)
> > +			continue;
> > +
> > +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> > +			struct airoha_gdm_dev *iter_dev;
> > +			struct net_device *netdev;
> [ ... ]
> > +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> > +				continue;
> > +
> > +			ether_addr_copy(ref_addr, netdev->dev_addr);
> > +			val =3D (netdev->dev_addr[3] << 16) |
> > +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> > +			if (val < lmin)
> > +				lmin =3D val;
> > +			if (val > lmax)
> > +				lmax =3D val;
> > +		}
> > +	}
>=20
> [Severity: High]
> Does this loop unconditionally overwrite ref_addr with the last evaluated
> interface? If there are multiple interfaces with mismatched MSBs (e.g., f=
rom
> random boot MACs), it seems ref_addr will only retain the MSB of the final
> interface.
>=20
> Could this cause the validation check below to incorrectly pass if the new
> MAC matches the last interface's MSB but not the earlier ones, while
> erroneously accumulating LSBs from mismatched interfaces into lmin and
> lmax?

As pointed out before the hw design requires all the interfaces configured =
as
LAN (or WAN) to share the mac address MSBs since we have a single register =
to
configure it (we can't configure a range like for lmin or lamx). A
misconfiguration will just affect hw acceleration and the user will be able=
 to
log and fix the configuration (according to the reported log) if the provid=
ed=20
mac addresses do not follow this hw limitation.
The choice of the reference interface is arbitrary and if multiple interfac=
es
have 'wrong' mac address based on the hw requirements, the user should log =
and
fix them one by one.
Please note this limitation is only valid if multiple net_devices are
configured as LAN (or WAN). Since in the current codebase we do not support
multiple interfaces configured as LAN or WAN, we are not introducing any
regression.

>=20
> > +
> > +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
>=20
> [Severity: High]
> Can this validation check create a configuration deadlock?
>=20
> Since the driver requires all LAN or WAN interfaces to share the same
> MAC address 3-byte MSB, and userspace APIs configure interfaces sequentia=
lly
> via ndo_set_mac_address, changing the first interface's MSB will always f=
ail
> this check against the remaining interfaces.
>=20
> How can a user successfully configure a unified custom MAC MSB across all
> devices if the interfaces are assigned random MAC addresses at boot with
> different MSBs?

As pointed out above, the user is supposed to configure the mac addresses b=
ased
on the hw design.

Regards,
Lorenzo

>=20
> > +		/* According to the HW design, hw mac address MSBs must be
> > +		 * the same for each net_device with the same LAN/WAN
> > +		 * configuration.
> > +		 */
> > +		struct net_device *netdev =3D netdev_from_priv(dev);
> > +
> > +		dev_warn(eth->dev,
> > +			 "%s: wrong mac addr, MSBs must be %02x:%02x:%02x\n",
> > +			 netdev->name, ref_addr[0], ref_addr[1],
> > +			 ref_addr[2]);
> > +		dev_warn(eth->dev, "FE hw forwarding won't work properly\n");
> > +
> > +		return -EINVAL;
> > +	}
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260603-airoha-eth-=
multi-serdes-v9-0-5d476bc2f426@kernel.org?part=3D6

--gqo63t7tWet7a99i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiE/SgAKCRA6cBh0uS2t
rAkUAQCKzEQxpcQmY4+jDSdmVPbZ1TRvV8Q82nNN8ukqfNdk5gD8DOCZiqQTs4nN
+J5nLWG7/NLao7/hIc5Z/u9fKEFw/Q4=
=eshO
-----END PGP SIGNATURE-----

--gqo63t7tWet7a99i--

