Return-Path: <netdev+bounces-21430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B122376395F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28081C2130E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1161DA34;
	Wed, 26 Jul 2023 14:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BD1DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:39:57 +0000 (UTC)
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 07:39:56 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C410DB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690381915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8zkmEooAd3ivhBI5159aRXGkQXjdZ6DaWps5lwao+8=;
	b=BKP68AtHg+sp03VT6ikDKu6RX6Sh+A4yjAxzN5bhI1jkNTxFPjHCgf4ufAUlqSRRvKEMQ9
	AGBcWytXmqNfU/Fy/GVq2mOP4s8Il4tHFwFKO8znxgwg5/q4OPFRlGAo801nrVoSgjaUty
	ndAAoOs/h2LWMIHCM6YndnI7JWPfeHA=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yuehaibing@huawei.com, YueHaibing <yuehaibing@huawei.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3326948.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--nextPart3326948.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0

On Wed, 26 Jul 2023 22:25:25 +0800, YueHaibing wrote:
> Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
> batadv_recv_tt_query() is not used.
> And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
> left behind batadv_recv_roam_adv().
> 
> 

Applied, thanks!

[1/1] batman-adv: Remove unused declarations
      commit: 5af81b30fd8fc8dcaf2c20e91c9f1f053bf2b4f5
--nextPart3326948.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTBLlgACgkQXYcKB8Em
e0aN+A/+NNABiED0zziMTAwSLZoKYqPEfBGuh+wDQZNdXvb7GJI0ufIdlMrwNEIx
FPsrWyEdD09oOldgb1PJSGsDRel9VaUmK/1J6/bUHH6cFOhywZ2tpsjMb7XDnvhE
5hq6VeRV1uapfxD9l6yupSX9qLeUjB/kk9DSqkDIlX1xDYU1ubojC1chlXpFxmjJ
EJsg/w/1rJrT73aWBesCODU0mHJoF0ouCTXN1t5MCJnnHK45u2rb+18piR+z95y5
iXcCVCAlz8G8Ahg8f4++7kengv6EjJ0+dsocs5bf5aceyE4D0Axy9CN0cQGf+60k
uihHpN5t+oaTZvccqavi/W0c1EbW4S5/7he0B7GekQLD3lUwPD4NULjljSEqofKl
XV+kngsN9e6lMZYIBZZTlkvNL/jyYzUDF5fx2kqtm/0Y1Z69zTRZPO5xPPQQicj+
NkCqUklTY+uTzNohwj2Lwt6/D9q1P0ldqCkz0a9scqoLUPKWuRsu0tg34/vAEUJk
xqVptkrfWZQWWcCb+bAfOw+bgspLh1U26zTIrHwcMyhujaICSAeSQeh5ejFm0Otn
xwPBuxju3WuvTsAMECPsyr/e5khZB27bMPOnioDh+Nx8qj4eXxffPQduPWRk5DKi
26eCmmVTXmkQNSe8TPryajqONF1/O088DOyztpsygO8dLMUpcj8=
=7Jpv
-----END PGP SIGNATURE-----

--nextPart3326948.aeNJFYEL58--




