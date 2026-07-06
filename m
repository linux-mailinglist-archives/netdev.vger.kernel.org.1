Return-Path: <netdev+bounces-305072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54yxLdC0S2p4YwEAu9opvQ
	(envelope-from <netdev+bounces-305072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:59:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 447867119C3
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WMr6XcQ+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305072-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3178D305BBD4
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E734D92C;
	Mon,  6 Jul 2026 13:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFC31619C;
	Mon,  6 Jul 2026 13:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345738; cv=none; b=bILJsFGwlqAIW31r3+eX0+Xkpwt84069ermOfHikK0Q4xvNwE2fL1OiXqLh9kSRMy2qOxJ8vC68PftwBbgb5YgXTMgv7yLvk/lsw69qpndlfFkfB+ivBXD7NPLYswBBlqQg9rr+GhbVawR/csiqRngsruqBLonA4IkWZ1QbvdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345738; c=relaxed/simple;
	bh=XRZKJZ4/dXD7MfZQeO8CA/MSwruwfGfCBENJB88OinU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H96abq52lxIHPWF1gia6VYHn27rSG6zd823uB2eyhsvCH/xaOlJuuPkkq7E3DbgDgUIFnCuCudZxeP/vEvkjhgKrkb3wAHLAnplSxY/YydnZd3xN+esaXwno5IsDmS8ik5LjDIVm0mpVJCD9lWyqZZm+Jvmp6WcE8q8HKcMJmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMr6XcQ+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7621F000E9;
	Mon,  6 Jul 2026 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783345736;
	bh=jVV7bp2HWv2rNP0PffEi0gwhgBaqZkkFggdogt0+07s=;
	h=Date:From:To:Cc:Subject;
	b=WMr6XcQ+IcKqrfRumAIcVd5dJ80KFPZKU8OZxTHj8egk1OudoX7hNDLLAZPzU3W8r
	 aCFZI5dkkVmJGBQlXkDcL/Ct5qw5oJJSceSaEYw6v2Oo6Rr9yov201tzpDg4B9R8EL
	 7Dc0Z9LkDF6EqB70NgeDZ6DNuPHNXd53Ph/cX7dp59YTsZDhVkB5rh+23XDaE4PSpb
	 CnKjuDqe3wheJvAToK+UeQTgf9fmR1RPRD64heFmfyNJd02yJxetfY1YHLmQXl7fFb
	 CP9ybTeSqNMaWr+KzGNuxvB/rzSL41BvX+bAjxkRqHATS/7q61dNiqxnaouLDkA6d3
	 maP3ZKEQisOzw==
Date: Mon, 6 Jul 2026 14:48:52 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Nirmoy Das <nirmoyd@nvidia.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <akuyRPMJsZkyJnx0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gy5knwxr8P5bZ+WD"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,m:nirmoyd@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 447867119C3


--gy5knwxr8P5bZ+WD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/lib.sh

between commit:

  dd6a23bac306b ("selftests: net: make busywait timeout clock portable")

=66rom the net tree and commit:

  895bad9cc4cec ("selftests: net: make busywait timeout clock portable")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/net/lib.sh
index d46d2cec89e45,d389a965d8f19..0000000000000
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@@ -93,10 -89,8 +89,9 @@@ loopy_wait(
  {
  	local sleep_cmd=3D$1; shift
  	local timeout_ms=3D$1; shift
- 	local start_time
 +	local current_time
 =20
- 	start_time=3D$(timestamp_ms) || return
+ 	local start_time=3D$(timestamp_ms)
  	while true
  	do
  		local out

--gy5knwxr8P5bZ+WD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLskMACgkQJNaLcl1U
h9Bp7Af/RvykH3dJh4/vhScpTYl5MhyYOquAh8krSszLd0R3XSfeckxfkWIsQNO3
7FzeRE5dEerdD5n2dMPvDdfFkLtE2iiGZN2Pba17NLy3A5DpLG5TPOK3ap5NBYLO
z5d/wEiP1SfAYTB/tLqv01tRw+fsBeJmn+Y+YeWoH6UxFIJVyhp2LXHBBnH6r+H7
cBcifOcDyjhy4QPR601fz7Qtjhv69Gq/NDumseaMmk1U34IzNTFX8LyNZyYhNd7p
DIvDP3BSv5kja5HW39xgRd85UE+b8wVLgFNbiH28pfgTZl/tjOh9on24XPSnVqLb
s6H4t/9zL8qhEkKJifzgu1v1wsLxzQ==
=p66H
-----END PGP SIGNATURE-----

--gy5knwxr8P5bZ+WD--

