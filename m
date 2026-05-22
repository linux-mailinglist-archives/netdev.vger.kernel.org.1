Return-Path: <netdev+bounces-290913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH4CHrutEGqPcQYAu9opvQ
	(envelope-from <netdev+bounces-290913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0F5B96DE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA64300EF86
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE9377EAF;
	Fri, 22 May 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5e/dvoX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166B3563C7;
	Fri, 22 May 2026 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779477942; cv=none; b=NJdb+XFNkszDxmTsaifV0XAZ531T8K1fr5EdMv/tQw4SOG82p8dYv9tgKtN7e6C4JfmCefzMHrEhQnE5QOCkLYEq8smzGAVxaaZ+8n8qcNnDb6TN092R44uug4n4jyYFYd409d7CYxoEbu9/FRDP7dyeHfDjah4u8Z539TulLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779477942; c=relaxed/simple;
	bh=Or5fQ1YCPE+2AHxAOKBFXorPm++H3+m8dRzh+3qm7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wui6DQlLU3j3BZ3unWP3tfglKRIIgr6KU5uOx6h9LgouqSQ0OLbAbaw4HM5pHsGhuomj4rI9oI6JkDhlU5tNKTRWwYZxwywQM40PL+17JlvXX470H1pZFUaiIaPKG3oLtztHE3TvUREt2WggbgyStHkgy2F7xtccb+q7gJs9ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5e/dvoX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0873A1F000E9;
	Fri, 22 May 2026 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779477940;
	bh=RojEkkbyfvmtTftKGHnFUwJgtWSamSkZZu/jQFeaWSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W5e/dvoXBpz2FofolimiQYP+RaRBPpqcZjGq1ebug4W41tbnF9zi7GkVRIDtLVw+s
	 iqMvWvp9vTm3lqR0yCO4fJYZBeG9aI/sGngE+Mi/fBIE0KJ9ORB73zkdmBDc73AObG
	 KXXMsf0zRcRa3AaiIxPdL+6d5mAHiy6VzbmpakfIurGwOrkSvxGO83W/u/7GaEVxOH
	 cQ2MStyqhRn2XKeCH2zhh3sYQnr1jXWaGT3EWWvekpGWy92kSStx9VVvqgPb88QCh/
	 DFLGz3eFjYrBqsn7Rs2kea6GIvZhgf1/IlCYNfp8giQlCxJbPENSSzv8uu6UjvrRgR
	 RJjy5X/OMKc9Q==
Date: Fri, 22 May 2026 21:25:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <ahCtsVA1VhYmhZq-@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
 <20260520085934.54AD01F00894@smtp.kernel.org>
 <ag2t4eVe4DcfU2yZ@lore-desk>
 <20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jukOReBCAgX4Obp/"
Content-Disposition: inline
In-Reply-To: <20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
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
	TAGGED_FROM(0.00)[bounces-290913-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18A0F5B96DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jukOReBCAgX4Obp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 22, Jakub Kicinski wrote:
> On Wed, 20 May 2026 14:49:37 +0200 Lorenzo Bianconi wrote:
> > > Does this strict OUI validation cause the driver probe to fail when M=
AC addresses
> > > are randomly generated?
> > >=20
> > > If a MAC address is not provided in the device tree, the driver gener=
ates a random
> > > one via eth_hw_addr_random(). For multi-port configurations, each por=
t receives an
> > > independently generated random MAC address.
> > >=20
> > > Since the upper 3 bytes of these random addresses will almost certain=
ly differ,
> > > when register_netdev() is called for the second port, its ndo_init ca=
llback
> > > (airoha_dev_init) will invoke airoha_set_macaddr() and hit this check=
=2E Returning
> > > -EINVAL will fail register_netdev() and abort the entire driver probe=
, leaving
> > > the system without networking.
> > >=20
> > > Does this also prevent users from changing the MAC address OUI?
> > >=20
> > > When an administrator attempts to change the MAC address via standard=
 userspace
> > > tools, only one interface can be modified at a time. The driver will =
compare the
> > > new MAC against the existing MAC of the other port.
> > >=20
> > > If the MSBs differ, the change is rejected. This makes it impossible =
to atomically
> > > change the OUI of both interfaces simultaneously, locking the MAC add=
ress OUI
> > > to its initial probe-time value. =20
> >=20
> > As pointed out before, this is a hw design requirement when multiple
> > net_devices are configured as LAN.
>=20
> What about Clashiko report about the MAC address?

Do you the following one?
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519-airoha-eth-mul=
ti-serdes-v8-0-6bd70e329df6%40kernel.org

- What happens when device tree does not provide MAC addresses for two or
  more same-side GDM interfaces?
  - This is the same comment reported in [0].
    Since the hw exposes just a single register (REG_FE_LAN_MAC_H or
    REG_FE_WAN_MAC_H) for the LAN/WAN mac address MSBs, we need to
    require all the interfaces configured as LAN or WAN to share the
    mac address MSBs and the user needs to select the new mac address
    observing this limitation.
    Please note this limitation is only valid if multiple net_devices
    are configured as LAN (or WAN). Since in the current codebase we
    do not support multiple interfaces configured as LAN or WAN, we are
    not introducing any regression.
    I do not think selecting a "base" for the mac address is helpful
    if the user does not provide the mac address via the DTS or NVME
    (as suggested by sashiko) since it will not help us if the mac
    addresses configured via DTS are "wrong" (if they do not respect
    the limitation described above).  What do you think?
=20
- If airoha_set_macaddr() succeeds (and has just widened the shared
  [lmin, lmax] range to include this dev) and airoha_set_gdm2_loopback()
  then fails, airoha_dev_init() returns the error but there is no=20
  airoha_dev_uninit / ndo_uninit to roll the LMIN/LMAX update back.=20
  The shared range is then wider than the set of currently-registered peers.
  - I guess it is not harmful to keep the already configured mac address
    range if airoha_set_gdm2_loopback() fails and I decided to not unwind
    the changes to keep the code simple.  Moreover, in the current codebase,
    if ndo_init() fails, the airoha_probe() will fail.

Regards,
Lorenzo

[0] https://sashiko.dev/#/patchset/20260519-airoha-eth-multi-serdes-v8-0-6b=
d70e329df6%40kernel.org

--jukOReBCAgX4Obp/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahCtsQAKCRA6cBh0uS2t
rN/wAQCIS+axnhlXTKcfCUsWDcOYLeS/TGc95axOtNeEY9ZKrgEAyXH5klwWATaf
0r/GIfveXTyaKFrvvGF7YTBMOsdbOgE=
=UJ1t
-----END PGP SIGNATURE-----

--jukOReBCAgX4Obp/--

