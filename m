Return-Path: <netdev+bounces-97520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960648CBDCF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BDD2825FE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29080C13;
	Wed, 22 May 2024 09:27:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8708F80628
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370021; cv=none; b=iWCk4M08l0od9i4T9jUyvSL8eQqPZgtrXyC1qSAvI104Ta4DdBMqLbUtxswO/Vub72i2g8OX1raMYDB16akvc6TyYWaXGhYe+ND5q9QPaEK/0lRN6X3Iw9TZFI+xO/FbEYocvJ4UzejApy5cXII1hsRU1f1tlKzy+MgpkDhRJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370021; c=relaxed/simple;
	bh=bdTgcLfs9cPHOL1bX3cQFTsw986kHNMQSwNr5GohWDk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=QGBCO81E6W9PamF/uEIby7rshAPbwJkvwJD7I7qKLEwfPbXWY0Mg1tDbUKRWgGVy4Hjq8D9NpXTZCfXzUElf/46W5mABTRlNeZBwk0fpujdPpUz+bTyWryoMOAOhAvjQ/cGXzVQxzSMYuqaQollcB//w4hBC45q5f89nN9B8Y0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 403D87D0B9;
	Wed, 22 May 2024 09:26:53 +0000 (UTC)
References: <cover.1716143499.git.antony.antony@secunet.com>
 <3c5f04d21ebf5e6c0f6344aef9646a37926a7032.1716143499.git.antony.antony@secunet.com>
 <20240519155843.2fc8e95a@hermes.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Antony Antony <antony.antony@secunet.com>, David Ahern
 <dsahern@gmail.com>, netdev@vger.kernel.org, devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>, Eyal Birger
 <eyal.birger@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH RFC iproute2-next 2/3] xfrm: support xfrm SA direction
 attribute
Date: Wed, 22 May 2024 05:26:13 -0400
In-reply-to: <20240519155843.2fc8e95a@hermes.local>
Message-ID: <m2y18242oz.fsf@ja.int.chopps.org>
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


Stephen Hemminger <stephen@networkplumber.org> writes:

> On Sun, 19 May 2024 20:37:23 +0200
> Antony Antony <antony.antony@secunet.com> wrote:
>
>> +	if (tb[XFRMA_SA_DIR]) {
>> +		__u8 dir = rta_getattr_u8(tb[XFRMA_SA_DIR]);
>> +
>> +		fprintf(fp, "\tdir ");
>> +		if (dir == XFRM_SA_DIR_IN)
>> +			fprintf(fp, "in");
>> +		else if (dir == XFRM_SA_DIR_OUT)
>> +			fprintf(fp, "out");
>> +		else
>> +			fprintf(fp, " %d", dir);
>> +		fprintf(fp, "%s", _SL_);
>> +	}
>
> JSON output support please

I would think this should be a different patchset since it would be totally new for iproute xfrm, right?

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZNulwSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlRa8P/35uenY4fQkWXevASh1QNoGNlegX33JF
7mPIv+ViJYUcsjY5cuJnJDbqosRy+z8MeCfToAXioO5PUwKd77ZUlvQc8ZEHubar
3R1zFu4h31fCcdbHqlFxreKQ53PT+A5hduxTFTCwCe+T+Zuas4u/5/3uowB4n37O
XaxJ42qevGOrywJ1t8OFnt3Cl+8AguiZMfDOVa7goGjon4idnWM+Su7Zu4qjPHCo
GyUdLRzSjGMuAFKYlMIHrEianzF8ESyjgtQ0poich5n1t4w52vDC84S5AM8Kn90f
3QqgmhW6Q71NPpl+ilaPhAj2q2WIQJdHsrnbrAk7qRNGpFOVZAv/8u6yV7qOB4+1
KGMgCEdze1F+C4Eak9zCHiZpJAxgEHJhTZFpTfTBhiaBIl2J1z2mU64cwLUDWrhP
F0a+nC1FRT0T4VVBkA/5BMVqZsWDhAd4/j9Ldyg0EV4AJh1O66GeHNRGyK6Eb13s
mlf3eyB97O9ehnhEmMAoy1lwRStBjG+UVhLSgkowRze+/hvKitvUjCna4GDWP6u3
l+jmxqfd2zD8PganILMfFXEenQmaA93sTp6oa3hf+gPLkaS9JZMHKU2K07SnzbbQ
kGKXC4WCXiSzPtaKFSUmjUBjWxBR8ujXtMWvB6CCoTQ8lKNx5NeLGk/JXqpTjPOC
dGYBZYz3iUm5
=owLx
-----END PGP SIGNATURE-----
--=-=-=--

