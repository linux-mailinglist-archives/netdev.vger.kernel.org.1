Return-Path: <netdev+bounces-293275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBBBCU8MGmrO0wgAu9opvQ
	(envelope-from <netdev+bounces-293275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC259609190
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59AC307F297
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263243A9625;
	Fri, 29 May 2026 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1OohYwJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FA3382C9;
	Fri, 29 May 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091864; cv=none; b=e2pO607pCTVyNRjYx4ZoHXIGIrKQdhHfsjrpO3zJkRz79I49xh0GUNbFfJGXTpaoR+/C8RjVR19J2LW5E+tBGx8ki0nzaDQQjruMu5CyxUxlr6e8/mNCoqTY0WSJseSHa/wryZZ6qZwAkC7Soqz/CYppg1Phw/+hPp+a1qpIdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091864; c=relaxed/simple;
	bh=0ncUy0bjjw3uh033Vo4jcVt8nw+84Nck7W6Ulty6pUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hVOw9xcPGKSlDlRKvT5+NK9iJB7VuxyPRWlR2BoD3BePGzLiMmDFtuZ5ics+Idbf9J8U7UwVE3at2meTQLC5B05xGIHWR18cXo8mVKCXpOunu66dSVYHPsxupFqJnYBfKaYCJm2TT0GlNAe+/0ziPfIAE1Znx10om7cnCqdVxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1OohYwJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F98F1F00893;
	Fri, 29 May 2026 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091862;
	bh=DeauKNNMEvurI1Up8wBYkLDFHWoJ8F2968rqmwPuOCs=;
	h=Date:From:To:Cc:Subject;
	b=V1OohYwJHjVEC3Mf5JU3sbm4lrziARqiiUcSwi1ZdU/eIji99w6HsYY3+eC+PKNwx
	 rCkpmTX1vSXDGxpC35drDBRL5neV1oqzzNlSNgy0WGGI8crr1FjfwAe1yIgoIRKDxF
	 S7cQ9SNHBI7IA9dJVdhv5X449Pw9MmlNB5k80zvLw4fqsEBSPd7Dj8hM/QQTi0obZ2
	 ABTfeBpJckrgeXlaAl99wChS1WXnaLCNDILUzFTNCWjeu1dBpfkGA6hy8qvsIpzIGJ
	 hMbeTb3kIAJmwqips7Nus8ezAwmnprbQ1jjGfGI++29n1gZB2OtCV+8QaN23aA6oIx
	 Q4s/Xg83EDsVQ==
Date: Fri, 29 May 2026 22:57:39 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the net tree
Message-ID: <ahoL09FuRZexeALj@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+qvTH49UpCKk9Jo"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC259609190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--U+qvTH49UpCKk9Jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  2982e599fff6f ("esp: fix page frag reference leak on skb_to_sgvec failure")

is missing a Signed-off-by from its author

--U+qvTH49UpCKk9Jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaC9IACgkQJNaLcl1U
h9ApSAf+K5+/kkLZtQIMOCXJFJaXt+Talcd7u+CV6Y4XWUxTjh9TdhA7T7UWlH+A
toDcMdbLA+TSYzOSVpqR0ImVC3Ps/nKfni7RCkoG+BNpKYCpBSupFwnTJM6iCJKV
xpdLc5gwhHuzK9m1yf2vi6ye/a2HGwZI+wTGh5fY9e1jy9T3D8ByBBmPVG73jOlb
cPNH4+z13vlQ/E0Nfxw4kFRXQZrA3SngqsdOiDizzI4L2zyRNMedMKOguROy78G2
voMhXEXBVtQ9ksWGtLmuE92/LdTJ+j7CWlpZ1HLm5Rk7vzkzF/4JMxQ1HdvConjj
pLCmNqtNedhWUf9lMrGNVi1z8q6Xrw==
=g0Vn
-----END PGP SIGNATURE-----

--U+qvTH49UpCKk9Jo--

