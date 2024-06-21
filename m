Return-Path: <netdev+bounces-105607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F9911F35
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1679FB20ECD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191116D4F0;
	Fri, 21 Jun 2024 08:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5F16D9C6
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959635; cv=none; b=Mh9J33N8LoJJdiX5OlF6Gh2B2tdfeLmX9spqmMK+9XstVH9KWaXYHaYBAj/oppAHzQksnZURcwkrAly7cVYMLRFDktFBL0Q45YhMCkyJLzIg1Z1Tes/TIKPF4Fp/KWWvkW/lT05fS2DQlIM9SLQv6+vJa/WZBu3jXNM5ixCOtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959635; c=relaxed/simple;
	bh=OHaFAIancPg5B97CYC7U7qpvfYJQGIcnfVSOoitJsTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpCdtymMvOPfYvFeoUswcJTbGo55wCM4Je85igjJtvJJqwBBglmzKUJ0Aac9bWmDiw57RbeLim9v0FVimCdWmC7p1coiVTAzWQqKDT5yIKJ9O3r5mT8WdDfjAWEHxNK39Ma6dKUK3k1F+58ZAtaOB5PRYVX9prR2/ZPFYlcZlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZvB-0001Wd-Ft; Fri, 21 Jun 2024 10:47:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZvA-003txB-Ko; Fri, 21 Jun 2024 10:47:00 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53A292EE5B7;
	Fri, 21 Jun 2024 08:47:00 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:47:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de, 
	socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: j1939: Initialize unused data in j1939_send_one()
Message-ID: <20240621-sociable-juicy-kakapo-b225cc-mkl@pengutronix.de>
References: <20240517035953.2617090-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4a2nfbhzpnjrazrl"
Content-Disposition: inline
In-Reply-To: <20240517035953.2617090-1-syoshida@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--4a2nfbhzpnjrazrl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2024 12:59:53, Shigeru Yoshida wrote:
> syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
> creates full frame including unused data, but it doesn't initialize it.
> This causes the kernel-infoleak issue. Fix this by initializing unused
> data.

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4a2nfbhzpnjrazrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1PgEACgkQKDiiPnot
vG+pfAf9ErIVSKFNz5AlblKgvg1U9veRg7zbWZn4TdM3efLMglkmTTabPtZ9q3W0
aq2NxoIasl6kqyBMjCkITaeu0p1Gix/sEnzCLy0u/GlZgc0d6WqhpaUCjcH9EnBw
gCgFS5lRxz+eL3WtptU4X24S4xyh4LJgTBw2mg8e6rKZl7CYGcqE3daa8r1tnkfg
Eh/gOx9PzNq/rFBrMJxOhic5cP+/SGdT2UtIyyg/WyHzKKdFQgdkNZa1SuXvQd7x
bmZETXl93AuRjUDLAk/iLitQGyOrLNuqBPiI7awGUQ1IxDQgx6rOPIBj49H1vOK1
FWvTmlIixuMq1FQL+RHxR7kUDD2edQ==
=17GV
-----END PGP SIGNATURE-----

--4a2nfbhzpnjrazrl--

