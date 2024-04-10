Return-Path: <netdev+bounces-86752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A38A027D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A9C1C21E69
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CE184111;
	Wed, 10 Apr 2024 21:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D7184107
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786258; cv=none; b=OU/2znZFAJL0JsVb5lrV94EKv4OiLYmvsriLF659N+qp8m31B04L0rpewYBL2qDW+Tcl54A9dpJOPbXnOQZMXHn1AnEf9JuBAAfbs729RkHkxKjdo1ovDGx6mxxFP+kDE+ReyVCpN6TAQrBDgBJuZ0BdSpGZjxzvpkSbe81XeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786258; c=relaxed/simple;
	bh=po7pDch0GS5NrwjKsdOySP/T9aR3iE/Iqcy0JyURtL0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=XbV/7OJKWKfKDBXwxFwPgXCgNkTTFsfVpJctg38wFWMxPZ22ehg9HvBH3OmigYKQ56QpoBwLNf/qKtFAeLqQMYpA0s+gPvaJLkjGvL55FkgaOL41qPC67X2zyMEjS12VlCDAg48qU7H3WRxKlnXXzgGD+xPDq8nDP4vGF9Odfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id BF6047D011;
	Wed, 10 Apr 2024 21:57:28 +0000 (UTC)
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog> <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog> <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog> <ZhbFVGc8p9u0xQcv@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Antony Antony <antony.antony@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Date: Wed, 10 Apr 2024 17:41:54 -0400
In-reply-to: <ZhbFVGc8p9u0xQcv@Antony2201.local>
Message-ID: <m2frvskhiz.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony via Devel <devel@linux-ipsec.org> writes:

> On Wed, Apr 10, 2024 at 10:56:34AM +0200, Sabrina Dubroca wrote:
>> 2024-04-09, 19:23:04 +0200, Antony Antony wrote:
>> > On Mon, Apr 08, 2024 at 03:02:31PM +0200, Sabrina Dubroca wrote:
>> > > 2024-04-07, 10:23:21 +0200, Antony Antony wrote:
>> > > I think it would also make sense to only accept this attribute in
>> > > xfrm_add_sa, and not for any of the other message types. Sharing
>> >
>> > > xfrma_policy is convenient but not all attributes are valid for all
>> > > requests. Old attributes can't be changed, but we should try to be
>> > > more strict when we introduce new attributes.
>> >
>> > To clarify your feedback, are you suggesting the API should not permit
>> > XFRMA_SA_DIR for methods like XFRM_MSG_DELSA, and only allow it for
>> > XFRM_MSG_NEWSA and XFRM_MSG_UPDSA? I added XFRM_MSG_UPDSA, as it's used
>> > equivalently to XFRM_MSG_NEWSA by *swan.
>>
>> Not just DELSA, also all the *POLICY, ALLOCSPI, FLUSHSA, etc. NEWSA
>> and UPDSA should accept it, but I'm thinking none of the other
>> operations should. It's a property of SAs, not of other xfrm objects.
>
> For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in
> DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set in
> DELSA, it would also be disregarded. Attempting to introduce validations for
> DELSA and other methods seems like an extensive cleanup task. Do we consider
> this level of validation within the scope of our current patch? It feels
> like we are going too far.

I think a general clean up feels like a distinct patch to me.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmYXC0USHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlpfEP/2bZP3/mjBuS9YiKwARwLL2iPaMldv7p
i6WLHeNGlFtEJqsxLFdDiqc9d2PBUPzs6uvnsxWGIVd86jeYJUvT3mLAJw8rVpvo
5SedYOof0kXIUe/fl2X/KjOoFsQv+BnB2HAI7NX8RpzrpFrKESsj17/hLQ7mfj8f
IP8nA4IpwFo4znr4HMFG0wnilyyepr4uqz4Ao2ACadyY+d8xYHEGGIVAzHpoge2z
ovVW9r+CQSK6EWZm5BAxdnhhaJBZd/t5nYP4HAJ1rHELaknFB9fhFIzF+1C+oGwZ
viT/9vJzMzbnYsEWDJAF+d/azlMvCFub83oOLQ16Spv0FioqNf6j73QMSJsla5KQ
EmaJL0LHXBfaIjWRGgw/HpIVHW+FCeUJ/LRqmp+WrGDjBBXoQlAw6mtlippvWILs
3FcygKKtwxDzl8LI/WEBKsLF8nFSfWwC1ET7k4eL1m6dLujYN3M63JTZ2Mbu3K4D
8/8AVq4FR0n4eMLdDh3T0LXG0K0kkWQGXKF3IlHbAdXyDvwIaYBVpTwIEyRDRQws
mSLJKXYvT2MrmjvYSoglQmDp6mq0dAwxglqI2wkzHtXHvSuPiWAZwJ/bf7lxmPGF
/PjxhsNPy+3Y2RNMmVZTErk4Ktwj2VhEFQQqrL27yiiAt1PtRdvDHfvodnbPErY5
5wbnOvPS8hxT
=Fca2
-----END PGP SIGNATURE-----
--=-=-=--

