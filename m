Return-Path: <netdev+bounces-277369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O6XEhrl2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB43D66BA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32B230300D6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876463BC66C;
	Fri, 10 Apr 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8hkTLvd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9930BF5C;
	Fri, 10 Apr 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821977; cv=none; b=Yrr3z+f8of0XwBsEIPZUuzMUBzDiURB2mSxpHEHH4GQfGGp0XmrfS6hE2J957bpgEcttIRA9KSU6Ayl4cWpY7NWm8C6rTn3K+DO24zFjFi9Q566SoiFdq0Ps3STD19/io5gEfGQVhcbvW+afFuxA7yYLaDr08lloVOZQmXdGffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821977; c=relaxed/simple;
	bh=Y4GnJSxmVoLcOsU28nVNoZ44KeRm+qtdWi6Re7neJws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHzfbkMjBMVo+Zc4mV334bnPdG8nEeB2Ldr8thRdSQqlmK9Z0W1FSAyUmvZAkS7R5tPnfMmnPt/SIDxQ9MYmzMQjmBXZIQGQ9R3yeMlbMAwvqcIHmvs1ODbv7sHdoG+I6s4ooI1glUL2n2KSuyRzVDcNavX/X86D72+1riNrgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8hkTLvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B71C19421;
	Fri, 10 Apr 2026 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821977;
	bh=Y4GnJSxmVoLcOsU28nVNoZ44KeRm+qtdWi6Re7neJws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8hkTLvdwmNEtlQbPxwGhpXKFahK7mAw84EdneFSvzt8h2dssZtDjOraINVgKLXVw
	 zCFVOJJr0UaOhh3JHtuGLlFl8kL6eLsvcRTOdeI0ZbjWyJ98VN9BOtayLeSX6jRPfm
	 XsbIfNl2jY9BmQNkieqFqSIKunfkAPedZWAkKJ/x8aygtpXTGcCFXbt/t/4o0Ns7g8
	 TLmmIjcEwypFAgvyUOTa55Gs406EdHlufYK2P5Tv5HN2ZRcLTIoZZccpEWgBC6HmBM
	 CZHB2dAjbMS+jd/Ke1lK6d62Orvfk1YtmGHmghdTeu8RPdsjOVplos307CCBnyvzl4
	 prUynAYuTiZGA==
Date: Fri, 10 Apr 2026 13:52:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/12] net: airoha: Rely on net_device
 pointer in HTB callbacks
Message-ID: <adjklonQX0q7ghZD@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-4-ab6ea49d59ff@kernel.org>
 <20260410025722.1809973-1-kuba@kernel.org>
 <bd486b55-a8d7-4811-965a-aa1f3dc98e30@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i1NM/Tit3uG0u/BY"
Content-Disposition: inline
In-Reply-To: <bd486b55-a8d7-4811-965a-aa1f3dc98e30@genexis.eu>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277369-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1BB43D66BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--i1NM/Tit3uG0u/BY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/04/2026 04:57, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email says "For your consideration."
> > ---
> > net: airoha: Introduce WAN device flag
> >=20
> > This commit introduces a WAN flag to specify whether a device is used to
> > transmit or receive WAN or LAN traffic. It enables specifying multiple =
LAN
> > devices but limits the configuration to a single WAN device.
> >=20
>=20
> [...]
>=20
> > > +		fallthrough;
> > > +	}
> > > +	case AIROHA_GDM2_IDX:
> > > +		/* GDM2 is always used as wan */
> > > +		dev->flags |=3D PRIV_FLAG_WAN;
> > >   		break;
> > >   	default:
> > >   		break;
> > >   	}
> > > -	for (i =3D 0; i < eth->soc->num_ppe; i++)
> > > -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> > > +	airoha_dev_set_qdma(dev);
> > > +	airoha_set_macaddr(dev, netdev->dev_addr);
> >=20
> > Since the commit message notes it is possible to specify multiple LAN
> > devices, does unconditionally calling airoha_set_macaddr() for each
> > device overwrite the single shared hardware LAN MAC register?
> >=20
> > If so, could this cause only the last initialized LAN device to have it=
s MAC
> > correctly programmed into the hardware, leading to dropped unicast
> > packets for the other LAN interfaces?
> >=20
> > > +
> > > +	if (!airoha_is_lan_gdm_dev(dev) &&
> > > +	    (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4=
_IDX)) {
> > > +		int err;
> >=20
> > [ ... ]
>=20
> Hi, the frame engine can be configured with a range of wan mac addresses =
and
> a range of lan mac addresses via registers that set the top 24 bits and t=
hen
> 2 registers that form a range of the low 24 bits.
>=20
> Documentation says that packets that fall into this mac address range eit=
her
> on the lan side or the wan side are to be treated as layer 3 packages and=
 if
> a packet is not then it will be handled as a layer 2 packet.
>=20
> The exact implication of this and if it actually matters is unknown. But
> traffic that comes in on an interface that is not matched by an accelerat=
ion
> flow is usually forwarded to the cpu for further processing.

The assumption here is the mac addresses are read from the SNAND or eMMC and
they all share the upper bits. I will fix the issue with a separated patch =
for
net tree.

Regards,
Lorenzo

>=20
> MvH
> Benjamin Larsson

--i1NM/Tit3uG0u/BY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadjklgAKCRA6cBh0uS2t
rOALAQDChwhT+q+W9kV8svjw4vYBOXlgu4gRACeUn8gsl1GgfQD9HP1z0i1xfifR
9EwKX95S/PvAovnwKbRE5sYz1v1dGQY=
=Za20
-----END PGP SIGNATURE-----

--i1NM/Tit3uG0u/BY--

