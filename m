Return-Path: <netdev+bounces-29966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493D78564C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841A21C20BF8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09166AD58;
	Wed, 23 Aug 2023 10:54:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223A79D8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:54:42 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0AFCD6;
	Wed, 23 Aug 2023 03:54:41 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692788079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmHgbHhEItbnaHrWyL/jeRkBYJl8ncNrJqVyvLd/saQ=;
	b=anN/lNv5unmqi1nUqtab4bLJR5gSJp6iiya4k1viCB8W5eN5rKibFN+D/O4tjHTG7noX10
	QfNlhQkp+FVRZTDNjIlSgUH17JOgj3RnkrXDqJVGAxNiB5i3f4XRk4ZUpFRlMIYfcjcGBV
	CglhcxA4VGfS74j9Q2dOFPxs8jASarE1W1eqlY7XTj2WPcC5EHe4ZymV/sPNaVyIvVxmrc
	DnlCKjt6CrPQXJLSFiMcGyXxt50Lfbg/wyoK8iHMatQ6EFOfNIbXKB3BDAIHPyihbUrnrD
	zZJ3IPzSbLDlnP5m7IsBYeS2RqL/mGsQEz0/v/BCabrDitFuBTMe5PGuhzMk2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692788079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmHgbHhEItbnaHrWyL/jeRkBYJl8ncNrJqVyvLd/saQ=;
	b=b6PFK7JQ1o0blushrjGnYwuctmmS3/8m0hKdIy2gBeF9gWizfyyBUPqxgB14N1B+W4iihu
	PL9HJiiwCyKxLPBg==
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple
 licenses in SPDX
In-Reply-To: <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
 <87h6oq9k9d.fsf@kurt> <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
Date: Wed, 23 Aug 2023 12:54:37 +0200
Message-ID: <87edju9ggi.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
> On 23/08/2023 11:32, Kurt Kanzenbach wrote:
>> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>>> identifier syntax for multiple licenses to use capital "OR".  Correct it
>>> to keep consistent format and avoid copy-paste issues.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>=20
>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>=20
>> Side note: The SPDX spec in section D.2 says: "License expression
>> operators (AND, OR and WITH) should be matched in a case-sensitive
>> manner.". Should is not must. So I assume checkpatch and spdxcheck
>> should handle both cases. Especially because:
>>=20
>> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
>> |370
>>=20
>
> But "should" denotes preferred rule:

Yes, of course :).

You mentioned checkpatch. But checkpatch doesn't warn about it. Or does
it?=20

|linux (git)-[master] % ./scripts/checkpatch.pl -- drivers/net/dsa/hirschma=
nn/hellcreek.h
|total: 0 errors, 0 warnings, 0 checks, 321 lines checked
|
|drivers/net/dsa/hirschmann/hellcreek.h has no obvious style problems and
|is ready for submission.

What about something like this?

|linux (git)-[master*] % ./scripts/checkpatch.pl -- drivers/net/dsa/hirschm=
ann/hellcreek.h
|WARNING: License expression operators (AND, OR, WITH) should be upper case
|#1: FILE: drivers/net/dsa/hirschmann/hellcreek.h:1:
|+/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
|
|total: 0 errors, 1 warnings, 0 checks, 321 lines checked
|
|NOTE: For some of the reported defects, checkpatch may be able to
|      mechanically convert to the typical style using --fix or --fix-inpla=
ce.
|
|drivers/net/dsa/hirschmann/hellcreek.h has style problems, please review.
|
|NOTE: If any of the errors are false positives, please report
|      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTl5W4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkKfD/9p7DMXuJxhJWoePn8AcmZQDBL7HlAk
4NgAljOSk5P5TAmVWUPRf8EVP2y/4aVDnmq6G0Qg84F5xTMuwLN1Mfkp+lV8HARN
ocAVhiCOR1f/EU2U/MuHiqPMoQwq1eh+9AZiTjXqQCtEZPT4sPKdBKyIxl80eBmo
/onDChcy8CVsGqxXfr9IsllGwBjSppdXTmxUPK4sHW1abnEvmvJ591orfwzCdoX0
htUrY2o2aH2OVFgJmINlHgAE2JU3hnBJeUGT0L69HtACdyUeYjjXsAFMA3f2NeJ3
Ff8muRbSK6TCka7vh0GAmXXjsq/Bw7i02wwfe8JJNNnTUxXIKp+/APAm0Np9g0vC
jSIIwCimO0C6TjPRR/SDggf/lXltCzuMaYzRqkQOHFYfusQF/hSGV6ue6Xw7o+y+
fl58F6qZ81Ga8iv8FjxqWr/ujCU3xuyZocxstZ9uap5D3dJMlptGdhuCOy83Nb+c
AZJVjmbpjeRl5NmBV/mFs8aMBuEvDDEtSTI52VP/Y+iQRDxe34iofJ3iXitcu28V
ehbQiTiS5VqfPUQqe/+50+GCYgzS5rcIvJG4+7nLWR9NTFxdcBLXzevIaN0WS7NS
IL1YTlxvsrQ2Ho4dvxD7ngfTPerrywk29RO8hF5G2Dxowc77tEgmwWJhvqg+FWtO
mc15jJSm9KbbHg==
=gNOL
-----END PGP SIGNATURE-----
--=-=-=--

