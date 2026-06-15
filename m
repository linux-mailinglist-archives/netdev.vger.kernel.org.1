Return-Path: <netdev+bounces-299488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXJmBAgQMGrTMgUAu9opvQ
	(envelope-from <netdev+bounces-299488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D56874E6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mYeejUh5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299488-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0463021CD5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA313FCB2F;
	Mon, 15 Jun 2026 14:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124E3FC5A2;
	Mon, 15 Jun 2026 14:42:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534563; cv=none; b=C+ihAR3GLihJYJozdHsY/fB7Eu47vZUEh/v64dhsag5DendVBpXilSAglRSI+BLoUwbbXHKOLtaC746T8/C2HXCt+ZbyiGn/DCD77rLU0GAC/lQovFNHySu/or9GnpNd1IFTeH2btsUcykSE2IAaTTcHv2Ro/1KDBQVmVgW/9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534563; c=relaxed/simple;
	bh=lyz0o5bIqrQU6GZA9FlIrh0SIJtPiDxC//iPq+MIZlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PAVkgnGZVkrm58rNXK7T34pSYSBILrhiGyeiW45GcUZVQV5iIcD6n32xFdrNqFVWCeHbfMBj0uxWkGSuQjCyNa3ql8jEkTOCG70XMFPnN5iv6HzuUrQV83vcZBAzYSrJSD5FgX6hnHbJniZ5M6YNb7AHi8gG32Z20LRDcLC2KIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYeejUh5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8821F000E9;
	Mon, 15 Jun 2026 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781534562;
	bh=0rbF5ZboVW29ctA9StQPDra1Vwsw3zYmxUpbz90V8XU=;
	h=Date:From:To:Cc:Subject;
	b=mYeejUh5X3i6i8Wi9z4oe4NYq+nCAjPsHkFic3fW1a2OeoPogHrwKgnNz15EH/Dmr
	 +igNibVsxxGQ49+XNLe0a4Ermo5Nvj6gB0m5Nagk/gia/Ah+90ku+Jfx/VtcsbC9m3
	 GG9dYt30y9/fuUeUI7XnBzerccGlI1/i8Jc7BgTA4+2YHwojkTQDB7G+5txsa/nqu+
	 ryUlv+6QKejrjvHIH6/pXXUew7ORNSJvhrjnnwYB8c8KqQxIHWbAldzJVgNvqspyRw
	 jHRX8qcnHUxi6urq4V7zL2t5IFpnkIZLKYUrXqkvJ8J9HHZFRG4MdAsoLYubVzjpIf
	 ncAlflSB/xCGw==
Date: Mon, 15 Jun 2026 15:42:38 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Aditya Garg <gargaditya@linux.microsoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ajAPXu-C_PuTgV-a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/QBcvnCH+4/MDw3o"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299488-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:gargaditya@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C5D56874E6


--/QBcvnCH+4/MDw3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/microsoft/mana/mana_en.c

between commit:

  f8fd56977eeea ("net: mana: guard TX wq object destroy with INVALID_MANA_H=
ANDLE check")

=66rom the net tree and commit:

  d07efe5a6e641 ("net: mana: Use per-queue allocation for tx_qp to reduce a=
llocation size")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/microsoft/mana/mana_en.c
index d7de4c4d25bbe,26aef21c6c2c8..0000000000000
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@@ -2332,14 -2399,15 +2399,16 @@@ static void mana_destroy_txq(struct man
  			napi_synchronize(napi);
  			napi_disable_locked(napi);
  			netif_napi_del_locked(napi);
- 			apc->tx_qp[i].txq.napi_initialized =3D false;
+ 			apc->tx_qp[i]->txq.napi_initialized =3D false;
  		}
 -		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 -		if (apc->tx_qp[i].tx_object !=3D INVALID_MANA_HANDLE)
++		if (apc->tx_qp[i]->tx_object !=3D INVALID_MANA_HANDLE)
- 			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
++			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 =20
- 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
+ 		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 =20
- 		mana_deinit_txq(apc, &apc->tx_qp[i].txq);
+ 		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
+=20
+ 		kvfree(apc->tx_qp[i]);
  	}
 =20
  	kfree(apc->tx_qp);

--/QBcvnCH+4/MDw3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmowD10ACgkQJNaLcl1U
h9DlZAf/SF3nOP+uAj/jqoZYtu4Umt3BpN94o0KIp53+bE0f/nqY3knknrrC+5pd
vCx5Kdy+5+JSELyE6MESO0fx8Pl+MwM7IHWwV7l/2gF6NXEx/I6ltkRIKf4nxyQL
Gi3EA4N4vv2TLN5kP50BzjL7XjCRkV/rlutl8E7ikkc0B5wSVVIyFqyTExD0IPm1
KrBIeOf6r7GmIw2/ENaznOaDMazrGIZ90jit1mHyAfcJQl0x9Hhm0PL6WYZdNVe8
NPM9R6+8kUGLgjxCwGLRXZk6jsYKrJdy9tkKlMy+uEtszzXujCHG3fLUYkbiPR/z
PWlGqYUH3Zm2Fh9Wo1dSA/t6kQlCiA==
=mvno
-----END PGP SIGNATURE-----

--/QBcvnCH+4/MDw3o--

