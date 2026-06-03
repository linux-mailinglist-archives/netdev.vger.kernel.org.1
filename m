Return-Path: <netdev+bounces-294755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cvAwDFowIGpvyQAAu9opvQ
	(envelope-from <netdev+bounces-294755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:47:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2B638394
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:47:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dou+n3Ak;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622F931B32B3
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97876305676;
	Wed,  3 Jun 2026 13:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943830214B;
	Wed,  3 Jun 2026 13:33:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493598; cv=none; b=pPXBCc3w/sHdj26rLnZDbPcXD88NN523953fGVZlvKi9X37OT7rIFHPygbwl9KuckqfBg4ycCl+lKMxXw4JsJw/j1SgcHEtZ1f8x+YFEr06HvsztQHnrsXiR2jQPhK6xSCiCy3Oaf1R1zJYz3pPvILkpBc6wPPNC4YAoh2ofYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493598; c=relaxed/simple;
	bh=b1ysU1fZLrXgVSKfS6bFj4dIWC9zwX/2EijZbkCBY20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PPsCTAI41cBQXDBEnwyyBop+zu8vuBIbmNu67tidoekgx3I/ky4zaIS2SETcgv5JWQcaAu5RsURg4ZbbeKMfFgCed+Lv8nyzmzmXdCRud4OSFCIEYKjgqpfK44rf+kgbZ4Eo+Huptid+LKe6BFU6v4+Gy3jrzliMU5PFALZNwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dou+n3Ak; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC291F00893;
	Wed,  3 Jun 2026 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780493597;
	bh=0Dp5fnxIZ7VliKPMhZv2nE5QC5nqckspwFL9kx66s3w=;
	h=Date:From:To:Cc:Subject;
	b=dou+n3AkisddKVYKT+rWgyjIXMb0KZ8XjQe34zjM+enZnmRoq0fMIQyZnN6JTYXzP
	 5EW3Pk3l904lMMBBKmvAX0kcI8aKOJdcKbB7EMCmidpRRBhnUnWHcv4LEUj8lsRjdj
	 aeoYv5l7kn9XlpV86fCk8auoX6amFySIhkXzgRB8gBO2ek+xy4K6iMxGGCyku/qbti
	 4YLk4AJkD61+IpIwiomwVCJyTNu5WgWo38SsCccC2jIZjPuHS9JVoqxAEKZEL3yXFF
	 OGoLD2h9Wje4d5pcf1KmHVAm6I1W9ekra1e7VwtUdWsLmtVajGNZnvJJI4Ojxkh7Wl
	 mnYxjAgbfXc/A==
Date: Wed, 3 Jun 2026 14:33:13 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Weiming Shi <bestswngs@gmail.com>, Weiming Yang <weiming3@asu.edu>
Subject: linux-next: manual merge of the net-next tree with the wireless tree
Message-ID: <aiAtGZWYjAIM_kta@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykvzMlw6+mJHw3h/"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,asu.edu];
	TAGGED_FROM(0.00)[bounces-294755-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:johannes.berg@intel.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,m:bestswngs@gmail.com,m:weiming3@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97E2B638394


--ykvzMlw6+mJHw3h/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/mac80211/cfg.c

between commit:

  1b659e979685b ("wifi: mac80211: fix NULL dereference of eht_oper in ieee8=
0211_start_ap()")

=66rom the wireless tree and commit:

  a384ae9699025 ("wifi: cfg80211: move AP HT/VHT/... operation to beacon in=
fo")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/mac80211/cfg.c
index 32c3ada18665b,fb4c1c2981596..0000000000000
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@@ -1595,10 -1715,9 +1715,10 @@@ static int ieee80211_start_ap(struct wi
  				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
  				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
  				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
 -		link_conf->eht_disable_mcs15 =3D
 -			u8_get_bits(params->beacon.eht_oper->params,
 -				    IEEE80211_EHT_OPER_MCS15_DISABLE);
++		if (params->.beacon.eht_oper)
 +			link_conf->eht_disable_mcs15 =3D
- 				u8_get_bits(params->eht_oper->params,
++				u8_get_bits(params->beacon.eht_oper->params,
 +					    IEEE80211_EHT_OPER_MCS15_DISABLE);
  	} else {
  		link_conf->eht_su_beamformer =3D false;
  		link_conf->eht_su_beamformee =3D false;

--ykvzMlw6+mJHw3h/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmogLRgACgkQJNaLcl1U
h9AZtgf/fY5yNN8nkwWljWkObqf1kwJlbUxI/8914p3Me7BrkNcxt469l3krYBG5
CoXZ77OYlZLqYHdPyEHk1GqUG6W5MWyZJLkjcJtp66exuJMw4q8KJYyCb7Y5rqXD
eWjJHPiaHQJxK+aFw3/ByoJ1XY7E9gzl/4oJuzDSLAUmUEAnFq8s7I5pQYXAgPuX
7HBN2Oqtga03h2f2kFxTbyc0nCtm1zGJ87x9bIvDWEfQ+SlUWEuTxqST83wUXV/m
7D9xYObCHR0ITtppQiTo0c9z2SQ4DpNPHHNEJXL8kY8w4KvxGWbiFV8OhxnbSCRn
3pBPJryjwMC8uDspv7h8pvm8N15eqw==
=Uo18
-----END PGP SIGNATURE-----

--ykvzMlw6+mJHw3h/--

