Return-Path: <netdev+bounces-261326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DzuBHU9oGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:32:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 666901A5BA8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85D6302AC2E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BA3644D5;
	Thu, 26 Feb 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKSYeHdv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC9285056;
	Thu, 26 Feb 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109148; cv=none; b=nANOcVG7W+eRv8R7x0a6pccts3NLXvokjRYbxmcUblK3wx7bD7r3uIl3KgozlqPidteGjq6w+UhEiTRqkTTdDS5XKp0xileoVye2GoaHiO5brKBYAgVybUerogY2jSgT1f6HCka0Hg7r86Hpr7eZXBm9ql2ADTvnt0IoSlTTSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109148; c=relaxed/simple;
	bh=7G/Xw0vgEtxD1MOJ5DsyAXBv4m0BhjJ7WjEoAC/FN7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qv0kLa04IoSzCJoiyw2YTDjazSCRV3DV7X5KcSpiplCLCmQf3DEg0W3g5kmHgJ+yNG8wUWX9zg1f0/6k56OYFklsNUdq8TOBu1yL7Y+Oz2meMvJ470nugkhfBt+X4tabCPWypY8+fHxKah+7wmGv91qY80xPUcgZfkX+C3KKayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKSYeHdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD23C116C6;
	Thu, 26 Feb 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772109148;
	bh=7G/Xw0vgEtxD1MOJ5DsyAXBv4m0BhjJ7WjEoAC/FN7w=;
	h=Date:From:To:Cc:Subject:From;
	b=rKSYeHdvxwWcz2zrqb4a+n2StLPH4R6X00yArzd/4tsIc141if/3Av3bqcR0HDAfb
	 5Ce8WShRiYCo6DazoQW9TcKFETB6MiQoJ2ofWhyfo74o8db9KYZch6o6dbmjcnvu7V
	 nfWtXqBpsYi+U+tIIBWWJR+RKw77Gdo1MiQ8hU06vW4ziUPny6Dz2NAxUm6aa2exOi
	 WivIaWdw5NwzmxxO61Mwdgu4Ei5pRTaF9rVHYTUdPxzQb0byznAwrZsgO1eDw38QmB
	 +D/t/OcgW34Y+qTRvaoX8h/b8YvKtFKWB2EWKw/P3s1+s66JrFyMUXj2d46V500rOC
	 CAsL3xhl0e59w==
Date: Thu, 26 Feb 2026 12:32:24 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aaA9WOQzW2ylYjRx@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ic8H4ymLkqF9lgLP"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,broadcom.com];
	TAGGED_FROM(0.00)[bounces-261326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 666901A5BA8
X-Rspamd-Action: no action


--Ic8H4ymLkqF9lgLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/drivers/net/hw/rss_ctx.py

between commit:

  ce5a0f4612dba ("selftests: drv-net: rss_ctx: test RSS contexts persist af=
ter ifdown/up")

=66rom the net tree and commit:

  19c3a2a81d2bc ("selftests: drv-net: rss: Generate unique ports for RSS co=
ntext tests")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/drivers/net/hw/rss_ctx.py
index b9b7527c2c6b9,cbeb3a38fdfeb..0000000000000
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@@ -10,9 -9,8 +10,9 @@@ from lib.py import ksft_eq, ksft_ne, ks
  from lib.py import NetDrvEpEnv
  from lib.py import EthtoolFamily, NetdevFamily
  from lib.py import KsftSkipEx, KsftFailEx
 +from lib.py import ksft_disruptive
- from lib.py import rand_port
+ from lib.py import rand_port, rand_ports
 -from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 +from lib.py import cmd, ethtool, ip, defer, GenerateTraffic, CmdExitFailu=
re, wait_file
 =20
 =20
  def _rss_key_str(key):

--Ic8H4ymLkqF9lgLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmgPVcACgkQJNaLcl1U
h9DngAf8CIjoSMK1++TkATfroGzHi2Md2eVH/xtpF5Xr8SjogurNkuDHHi8SxEAy
rcfGmNxQtBuqCNELBAhjW3hRTclHR4IWyRomB3NLMpThfH/QoKXOj/BDjKkZoU1k
+KI5IlHBk/r5zDg/OlMUk2AnrZ3TN0RTFsUgyd2cz46uPh+M0PFG2MHdJMQGeb6n
yCmlNifShHVlFlk59T/bTmsIImaJxXtSFPZiDNcGgO2V+B1P310v/SvMUTgf0W+R
TiWU4H66fSXJMRnS7M/vwzEZbCq+ppF0uNAO0a3nj01YwumKc57w3cB50XU6Cta2
6D4UfgdwNnQvvJpVsnFSjSqgqHw3qA==
=72R2
-----END PGP SIGNATURE-----

--Ic8H4ymLkqF9lgLP--

