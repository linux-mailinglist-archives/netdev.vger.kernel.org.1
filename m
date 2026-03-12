Return-Path: <netdev+bounces-267212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFP+J0kts2ksSwAAu9opvQ
	(envelope-from <netdev+bounces-267212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D436279DD4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01058314DC63
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DDD38B124;
	Thu, 12 Mar 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clkxEPBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4E3B47EA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350079; cv=none; b=kc2f+MMR90M5w7vxU0K521UpORbDF9qBBOYQCvJobjho60KBpGLYlFuSNUAMfjKBNGTwu0PybbNY1USZt1bTLW669eQNZ19eRFS6LZ7xf6BbnA36qWnILl0cEGbdRo6iw/i5zd7Pi0Xs98ZjR3XQHQNM5zMpmyn2LkNqiIfbmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350079; c=relaxed/simple;
	bh=PI0QF6B7GTpvs2phHUpBZw7BOsfXgNyP/NfUwECWnrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmoie01nwHidFudCeij9T4DLep/uk3vwGF3W3X0ynCi0tI85YdqvFI8AhEC3zzyMukWQaecAwa23bPYR7zQwycy6Me/N9p0gr/FWzawqe4lafLF6Z71Sh+VMmovU3RDfdkp+XWfqvu2kq6UCz2Et7qVv9Y/nse3I5LJmeIoyQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clkxEPBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF7FC4CEF7;
	Thu, 12 Mar 2026 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773350078;
	bh=PI0QF6B7GTpvs2phHUpBZw7BOsfXgNyP/NfUwECWnrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clkxEPBKZxEf659r5ImYpASzkk9EJQaPrZpJfHhDr81HRo8Un+bWQ1x/DZoTK1VYS
	 jKCQKBN2NTj7eIX+eEYhb98SKzN0GuqCCIIVXLbXv3UIeNeU6hhQx/K736A9gxBnu7
	 Heq2q+j6rbsvy8e4IRwA67aZUA6x19egSiOOPdEyJebBl2eZjOAU3qf1U7OJBwkc04
	 HBtoe4AubLHSj7Jys1zlysVWhllflJ5GMTQtKaGc1g22BBA92wFdVgh363oAbGFwPU
	 98YKpYspsudCb1rMglQnFP/f52la01xFU2fNptxEbPGJsWVDiqqDES6qgTIGYZrBSm
	 4XPlMxZzMyOOw==
Date: Thu, 12 Mar 2026 22:14:36 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <abMsvOMnnuTdoG-9@lore-desk>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
 <20260312172430.GA1267298@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aKPrcNYyqP8X8EOx"
Content-Disposition: inline
In-Reply-To: <20260312172430.GA1267298@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267212-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3D436279DD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--aKPrcNYyqP8X8EOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Mar 10, 2026 at 03:46:53PM +0100, Lorenzo Bianconi wrote:
> > Select the QDMA block used to send the traffic to host cpu according to
> > LAN/WAN port confiugration:
> > - QDMA0 is used for LAN devices
> > - QDMA1 is used for WAN devices
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> Is this a bug fix?
> If so, perhaps it is for net with a fixes tag.

I guess we do not need to target net tree since airoha_eth driver currently
supports just the LAN interface via the MT7530 DSA switch connected to GDM1
and there are no WAN interfaces officially supported (PCS/external phy is n=
ot
merged mainline yet, it is only available in OpenWrt).

>=20
> And at any rate, could you add some description of the before and after
> behaviour?

Theoretically, before this patch, GDM ports were equally distributed between
QDMA0 and QDMA1 while this patch assigns LAN interfaces to QDMA0 and WAN
interface to QDMA1. However, for the reason explained above, this change is
not currently visible to the user.

Regards,
Lorenzo

--aKPrcNYyqP8X8EOx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabMsvAAKCRA6cBh0uS2t
rFDmAP93V3ccszOsfcw+0zhgr1R1obkSmoIKk52roRfL4F4otQEA5pU4amZ23tfr
L8d+Ej1Fj3I3fcJLP56yYMmhSvkcTAA=
=5Q0S
-----END PGP SIGNATURE-----

--aKPrcNYyqP8X8EOx--

