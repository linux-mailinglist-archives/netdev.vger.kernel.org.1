Return-Path: <netdev+bounces-291054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEwNIyNkEWrMlQYAu9opvQ
	(envelope-from <netdev+bounces-291054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:24:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396035BDD7C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 651863015473
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A207346A11;
	Sat, 23 May 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqqpCmA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69615282F04;
	Sat, 23 May 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524639; cv=none; b=ffTebBZqaFcrSTb4OxgPE0AkwAnm3pVZ933IsOuxvLk/p89XocHE85Pxcyq3buRMFK+BjC4SlegeE6XBLKJYqdoIiMInjSjTVx0fmpxKIFOiNJ7WY1p4VUJXCwqP5Awqb3HQGeqRSyqUcfS9PUkj+m8xD6N0NPQPMzvk+7cHNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524639; c=relaxed/simple;
	bh=VyWl2ecvljRK2GJztgVl5Y3zngaCuLCGUKi7ecECibo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tugUn3t4Xn9S36IOPjJtbn6jAwMaT23R0Y8RobjVLKnQ+Aoc88HGANfVXUS0LLDHIf2Jmih6xqMvywvzKc2lBqX1jyCoLOXuC+WBWPZv3Q3pJOrjdH+yiRcIotcxm99ZnZliYX/HjsmC+2W+dP+OEX+omJPIUUfEzs3nrNstEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqqpCmA0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6098D1F000E9;
	Sat, 23 May 2026 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779524637;
	bh=wxHCvPrMAEVSLpBwem3bgINi0YyoThXY2qqtvVEvhn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GqqpCmA0dNpHxxb5cnkJ7n6z97RBSqjKwx4p0TgT1FHkNHATcdkvTuPQMc6Qonhwa
	 882BPQrbSmPLPdPBvRdVeWPZ/pw4rOy6qb1Ew5GD66uVqsx8G+AnluEQY/LbCmZ52P
	 Cax/kd8CbgDKKUOdMgqu/8zgOkVAvGhCgp/H+lcr26i75Xi8Wx6Tm3nF04kOQ3QWsb
	 iI8q1uAWzN7MNFe1HaX8QInERGvjwVppy4/Yrd0I1edwosfWJxcg7FDvqCujlx8nLl
	 x8rGEC0ViN/RmiFvBdvbUPsdakDUKiOxcZrNbIej4QtICP+6d7zMzXP6K5DSAB+xQL
	 pRUqX3X91kLAg==
Date: Sat, 23 May 2026 10:23:55 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <ahFkG32jFRJ7W_cv@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
 <20260520085934.54AD01F00894@smtp.kernel.org>
 <ag2t4eVe4DcfU2yZ@lore-desk>
 <20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
 <ahCtsVA1VhYmhZq-@lore-desk>
 <20260522165820.04839729@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PftFpCMBcfSTQMSG"
Content-Disposition: inline
In-Reply-To: <20260522165820.04839729@kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291054-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 396035BDD7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--PftFpCMBcfSTQMSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 22, Jakub Kicinski wrote:
> On Fri, 22 May 2026 21:25:37 +0200 Lorenzo Bianconi wrote:
> > - What happens when device tree does not provide MAC addresses for two =
or
> >   more same-side GDM interfaces?
> >   - This is the same comment reported in [0].
> >     Since the hw exposes just a single register (REG_FE_LAN_MAC_H or
> >     REG_FE_WAN_MAC_H) for the LAN/WAN mac address MSBs, we need to
> >     require all the interfaces configured as LAN or WAN to share the
> >     mac address MSBs and the user needs to select the new mac address
> >     observing this limitation.
> >     Please note this limitation is only valid if multiple net_devices
> >     are configured as LAN (or WAN). Since in the current codebase we
> >     do not support multiple interfaces configured as LAN or WAN, we are
> >     not introducing any regression.
> >     I do not think selecting a "base" for the mac address is helpful
> >     if the user does not provide the mac address via the DTS or NVME
> >     (as suggested by sashiko) since it will not help us if the mac
> >     addresses configured via DTS are "wrong" (if they do not respect
> >     the limitation described above).  What do you think?
>=20
> If the MACs are not provided something is obviously wrong with the
> device. We should try to provide enough functionality for the user
> to be able to troubleshoot. For an AP perhaps that means SSH / remote
> logs? So switching/routing doesn't have to work, I'd think.=20
>=20
> Will the user be able to log in when REG_FE_LAN_MAC_H does not match
> the MAC of a port?

REG_FE_LAN_MAC_H and REG_FE_WAN_MAC_H regs are used by the FE module to
hw accelerate forwarded traffic and does not prevent the user to log into
the device even if they are set to a different values with respect to the
configured mac addresses (just hw acceleration will not work properly).
To prove it, I set to 0 REG_FE_WAN_MAC_H, REG_FE_WAN_MAC_LMIN and
REG_FE_WAN_MAC_LMAX and I still able to ping the device via the WAN
interface.
I guess the easiest solution is to neglect errors from airoha_set_macaddr()
in airoha_dev_init() (as it is in the current codebase) in order to allow
the device to probe successfully and provide a warning message to the user
regarding the mac address misconfiguration. What do you think?

Regards,
Lorenzo

--PftFpCMBcfSTQMSG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahFkGwAKCRA6cBh0uS2t
rPmIAP9wU8SEqG9TRUqQMAbsMKcXJ8lwb52gxAfRso+cI/KHdgD+NMFXbDB6lGko
mytUyoxheWixRWBj+SLLqp5Gl4dV7gQ=
=jXTB
-----END PGP SIGNATURE-----

--PftFpCMBcfSTQMSG--

