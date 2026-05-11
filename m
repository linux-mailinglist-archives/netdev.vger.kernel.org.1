Return-Path: <netdev+bounces-286502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB5pN72JAWpJcwEAu9opvQ
	(envelope-from <netdev+bounces-286502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2B509848
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06C9830087EC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A13A6F0D;
	Mon, 11 May 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJi/rCct"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B293A5430;
	Mon, 11 May 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485629; cv=none; b=WkQr2kidUQcGr4Gym7wkil19N6vVIJABnabAFOWWbIHKxX3CTwjU7+FThX36dATznAgEYrDNqO6xhGHndTWp5n2PWDYpCHlPb9K8IUbsRbwET9gW0AjunnTVwKtpupQff/QAlcuoiuTxYJSyt0JxYmD5+TxwvGxtbQVK04GUwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485629; c=relaxed/simple;
	bh=W6aPnQGxFvV5pxspo8KdT3OU3FU42+Tsl5qJ9Cz1T2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMxOJ69tDXMgcGGN7ZNKo45Ac68k5Qjlzj9/HB6j3VNHlCq+uqie9WWeo9ZHgH11dXogN6Wsg0JlO8Zk/VNAGukp4sQj0xIGAZHB2SIXIldzmXFfJPErJYsKIZ55h0FtKjbNKq8n8wLvjsTdgmEWno2llvSgYmUBoeK2MuhksW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJi/rCct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB21C2BCF5;
	Mon, 11 May 2026 07:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485627;
	bh=W6aPnQGxFvV5pxspo8KdT3OU3FU42+Tsl5qJ9Cz1T2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJi/rCctlOINEtcmwwKI0m1Qyw7ZipkxQA9/9UewVsJVEH6L32P1GLYxN+jYdeU4S
	 E3dlLGK5mg8ccrMBBfFw/8QMyUoheooWdP3ZBZpRKkq8J5FoC0oUq4m59sQEirx09Q
	 7azeMg4EYT+vhpOUQI4PFAToG37dC4kg1WukjV0LgwXtGiFMQYOe/33FmTELtc51jZ
	 4CauPM4USfteYm9Dt1rrj2c0BLvC7TQ87Qx5GQfrMY4rKjUgiUkXXGjX2dqpUd+jYO
	 y77V85MCeJCQ6NGVAMvm5EdmswCDkpmSkdKQzqTN1lcwcYTptoADYXU/Dc0an0Ev+B
	 hqGndeYF7Vr1w==
Date: Mon, 11 May 2026 09:47:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/12] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <agGJeIrmDdRmHoAA@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-9-805e38edc2aa@kernel.org>
 <20260510140505.2C772C2BCF6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AoE5hKwc3VX7KL8z"
Content-Disposition: inline
In-Reply-To: <20260510140505.2C772C2BCF6@smtp.kernel.org>
X-Rspamd-Queue-Id: C5B2B509848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286502-lists,netdev=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--AoE5hKwc3VX7KL8z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The `GDM_STAG_EN_MASK` configuration is port-global but is modif=
ied unconditionally per net_device, leading to silent clobbering when multi=
ple devices share a port.
> - [Medium] The hardware MTU (`REG_GDM_LEN_CFG`) is not recalculated when =
a device sharing the port is stopped, leaving the MAC configured to accept =
inappropriately large frames.
> --
>=20
> commit b896e320dcf0d56db7e0654191126c23e6f485fd
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> net: airoha: Do not stop GDM port if it is shared
>=20
> This commit introduces a users counter to the GDM port structure to allow
> multiple independent net_device instances to share the same hardware port
> without prematurely stopping it. It also conditionally updates the MTU so
> that the largest MTU requested by any sharing device is used.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index be31f639f4be3..ebb24e60f1de3 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1733,10 +1733,20 @@ static int airoha_dev_open(struct net_device *n=
etdev)
> >  		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
> >  				GDM_STAG_EN_MASK);
>=20
> Since GDM_STAG_EN_MASK is a port-global configuration, will this clear th=
e=20
> flag for the entire port if a secondary non-DSA net_device is brought up?
>=20
> If the primary master device relies on this hardware tag parsing, it appe=
ars
> a secondary device could silently break it by clearing the mask during
> its open routine. Should this configuration be protected or refcounted wh=
en
> multiple devices share a port?

This is not a real issue since the hw design supports DSA just on GDM1 wher=
e we
can't configure multiple net_devices.

>=20
> > -	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > -		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> > -		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> > -		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +	cur_len =3D airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > +				GDM_LONG_LEN_MASK);
> > +	if (!port->users || len > cur_len) {
> > +		/* Opening a sibling net_device with a larger MTU updates the
> > +		 * MTU of already running devices. This is required to allow
> > +		 * multiple net_devices wht different MTUs to share the same
> > +		 * QDMA block.
> > +		 */
> > +		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > +			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> > +			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> > +			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +	}
> > +	port->users++;
>=20
> [ ... ]
>=20
> > @@ -1766,8 +1776,10 @@ static int airoha_dev_stop(struct net_device *ne=
tdev)
> >  	for (i =3D 0; i < netdev->num_tx_queues; i++)
> >  		netdev_tx_reset_subqueue(netdev, i);
> > =20
> > -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> > -				    FE_PSE_PORT_DROP);
> > +	if (!--port->users)
> > +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> > +					    REG_GDM_FWD_CFG(port->id),
> > +					    FE_PSE_PORT_DROP);
>=20
> If multiple devices are sharing the port and the device with the largest =
MTU
> is stopped, the hardware MTU in REG_GDM_LEN_CFG doesn't appear to be
> recalculated or shrunk.
>=20
> Since the MTU is only expanded in airoha_dev_open() and airoha_dev_change=
_mtu(),
> does this leave the MAC configured to accept inappropriately large frames
> for the remaining devices indefinitely?

ack, I will fix it in v6.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D9

--AoE5hKwc3VX7KL8z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGJeAAKCRA6cBh0uS2t
rIC0AQCB4vNpyNwAWhilwrdVKDSwmfIC2mmckVm7kjpBYSFVZwD8Cx27ZuqAmZWr
5tnKUNCiIHou0///+CnTMfZQZvocXwc=
=XNlR
-----END PGP SIGNATURE-----

--AoE5hKwc3VX7KL8z--

