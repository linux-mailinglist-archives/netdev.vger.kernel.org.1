Return-Path: <netdev+bounces-253556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBMGKXqkd2k9jwEAu9opvQ
	(envelope-from <netdev+bounces-253556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:29:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D39418B79C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B4E63008C29
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83034C98C;
	Mon, 26 Jan 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emNAK8Ca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0022425B;
	Mon, 26 Jan 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448560; cv=none; b=prrsEbO3Jfpa4h9JG4PBZlaBSa8eFxs3o5AV8nhYlpGErgz+55rQG3aaKzqpKrSD/64EsrlLiDngJ6KIpZ5uEPIZVOHoR0sfwkiZeKIpsHcir9zy2R4z1D83r+cQbBF/vvhhtqZsUkMmUh15wXnRH/INSmRYjJbDDhEnxdHBCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448560; c=relaxed/simple;
	bh=Zl/sz5JxPdJBFc7UhewHGLry9GR2H34k1pBIhH4BcVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ENxtH5UsaBu2Eiu/GjUItr7qskT185P5D4+NOurkF0nSxwWe1rrV2b0G9o6aqFOwC7FdiP65TQtWkTniy91nGPpLo1nt6hOcEmalasytUmyc2YeGZmXzDJd0Cfior1GjaLqNmSuJMio3ZgVT9UCs7BaLV6VWFbWkPy63QDkTw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emNAK8Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85956C2BC86;
	Mon, 26 Jan 2026 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769448560;
	bh=Zl/sz5JxPdJBFc7UhewHGLry9GR2H34k1pBIhH4BcVg=;
	h=Date:From:To:Cc:Subject:From;
	b=emNAK8CabNLu47KYx54Qh1iSQ6mDkHIAr51MWfo6PHWCiolHUKFPtAHd9kLDeEgYv
	 r5I/GUi+c41nR6nIdeYbsTIfch7igkZLwuWZXFypfaW1zEwD3zQhu7+evNvDBN+Jc3
	 HX/mQbgCwIGrp/6LVq2KZXad3R9pcqqcxqWxtRrNYpi2Dfs1PKkLZMHi6Q7FSQZ45s
	 Bp/m2TCSOZv1XJGPq4mugKB8mAhSjnajtBCWY8fLt/ZKD+290NPmPDdkwylQzH/bhM
	 c30/C+w+XS5S6+72EM0PBzGriYFkfZPXcx4EShWxluazK4d6c+ocrA3+NmnzC+BJX2
	 IuE1LxtRudH1w==
Date: Mon, 26 Jan 2026 17:29:15 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <aXeka0KYBnrkwUcF@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Be5jyZhEdi46WJsj"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253556-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D39418B79C
X-Rspamd-Action: no action


--Be5jyZhEdi46WJsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the net-next tree, today's linux-next build (arm64
defconfig) failed like this:

/tmp/next/build/net/core/sysctl_net_core.c: In function 'proc_do_rss_key':
/tmp/next/build/net/core/sysctl_net_core.c:333:23: error: implicit declaration of function 'hex_byte_pack' [-Wimplicit-function-declaration]
  333 |                 pos = hex_byte_pack(pos, netdev_rss_key[i]);
      |                       ^~~~~~~~~~~~~
/tmp/next/build/net/core/sysctl_net_core.c:333:21: error: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  333 |                 pos = hex_byte_pack(pos, netdev_rss_key[i]);
      |                     ^

Caused by commit

   37b0ea8fef56c (net: expand NETDEV_RSS_KEY_LEN to 256 bytes)

I have used the tree from 20260123 instead.

--Be5jyZhEdi46WJsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml3pGsACgkQJNaLcl1U
h9Dw/gf+N+Rh7tqMkxLOertiD58s4VyQ0vuv2dpx4El31mUPYJOa3zFRCu8K6QFx
jeLcB4GW36GXf2vvzy0Rz3zs1wQV17Mga2baRq7XvexnkSLZ4zlDTZuvTeJmkDEl
/PCXhHTgYgYEItdtr/1WaHqTqdlX88bVvGafO/iDW5ctLTMjc6AbWVjlO91zr9oG
QUCX1s+qhfcWiJHAQ6PG95P0yfn4v6R7oKG3FzZbG2ScIWc+krHV8ev9XhZ4a92f
DOIBxqvuFTrI9g9h4tn2nM1G9cYdzb4nGyDZPFLpE2yKZAndvKEvoGAE5f2oALXe
lozfoPuFWy3q/jt/J/eq/U5ibZcCuw==
=T6/r
-----END PGP SIGNATURE-----

--Be5jyZhEdi46WJsj--

