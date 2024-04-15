Return-Path: <netdev+bounces-87880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE38A4D86
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50591F21B82
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5B5C90F;
	Mon, 15 Apr 2024 11:21:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6F1E896
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180090; cv=none; b=KADHIuwHru/aOzf3w1gUF4oMk54q07NiO6zet797kDgmD2+OvJcjD6VuERNkQ720hbozJpc8zYOOICxJMuApHoqBNUjBoyiInVrE5ClSaVBSeFY6gHO8xvRqPQquxfLXrR9FB4CuCdzIMIpznJSaY858HyQlhPWv2e933XXsf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180090; c=relaxed/simple;
	bh=c+cohnEOnISd5QPWKiXTfsEopWKnOmDHHAe8PkxHX7o=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mkHdAR1eYvl4OTyza/Wh9BwqlTiJ/kFi2XIiPd44mDvXcJECUS6iSNtyEppSiwtUQaVNHmEAsZHH9PM4vQZ5RUxhAuPF0XkSwutVlrEFHnBg3+2Dfa/1MpMHNgb5YrCUFWTSVDIH5Q1rtehPfPCwVbD0mWH+lUPTE2H224Br/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (unknown [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id D5A8B7D01E;
	Mon, 15 Apr 2024 11:21:20 +0000 (UTC)
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal> <ZhfEiIamqwROzkUd@Antony2201.local>
 <20240411115557.GP4195@unreal> <ZhhBR5wTeDAHms1A@hog>
 <20240414104500.GT4195@unreal> <Zhz1DmZZCrMq__B_@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Leon Romanovsky <leon@kernel.org>, Antony Antony <antony@phenome.org>,
 antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eyal Birger <eyal.birger@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8] xfrm: Add Direction to the
 SA in or out
Date: Mon, 15 Apr 2024 07:12:03 -0400
In-reply-to: <Zhz1DmZZCrMq__B_@hog>
Message-ID: <m2ttk2j2he.fsf@ja.int.chopps.org>
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


Sabrina Dubroca via Devel <devel@linux-ipsec.org> writes:

> 2024-04-14, 13:45:00 +0300, Leon Romanovsky wrote:
>> Right, but what about new iproute2, which eventually will users get
>> after system update and old scripts?
>
> I suspect that new iproute2 will add an option to set the direction
> (otherwise it'd have to guess a value, that's not the goal of xfrm
> support in iproute), and only pass XFRMA_SA_DIR when the user gave
> that extra argument, so nothing will change there either?

Indeed.

I have a set of iproute2 changes for iptfs, and I was going to update those with the "in"/"out" keyword if it hadn't been added by the time I submit them, I would associate the corresponding iptfs attributes with one of those flags.

I hadn't planned on changing any restrictions for existing iproute2 options/flags as doing so might break user scripts etc :)

Thanks,
Chris.

>
> --
> Sabrina


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmYdDa0SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlkxYP/jxnVBYH8erv+zwHRc1MRNK3qJYf5gO4
wlq/85yQff7CMS+XD+CAgKunMQYNIHEqWc8L5ST76dsUPWBTNGi6ZtlFPYuUX6sG
t6Ik3Jyzz1PBp0Fdpzv3yTYLaZ89PNdkkuUZJD1d7JEsK/hvLAnR+BDjJyvwwG2y
adOS4lnkbM4wSJJlyK3DoMnO0lpMdV4f+G9AoHgGfFna9PiLSRx0OYjSHqmBzzEA
RTEnE3FObRgRv8IUJGmdfxEsMYOd8pM1icXi/TPWpl0W2MJg9Qn+ExBhvfiJkx1/
ZHB5T70wBQOcN+JPcbPSlI4eBnP96hjnWuVM2RPcFIEKUDhVNPDqvBUNuJemCaxY
P+oostWfCs1TmXsH77C8luo7J1QjJn22yFUUAI4aOb0Zp/UdCuL/VPkJJSrHDoGA
hfueFwUeIwawIfEiwaU/uS23636EkjbsdfvOybtGSp6jBRK0YnkSt1S/03jSfugd
5ssnOpwYC/J0F/NJLoBkCWEa+KybVCZDqPZp69Li4BEaf876yMJyT4XdS0tBi20H
yYNBNobb303z56NvCXuWex80q6/VFSY/7dT8GqrI41zRXpIMDyaIcTTKQu9C049N
Ip3K0sPgivEFiYmiYaxtsDWD8FaQLHplloSE24uIMY8EfFz92zyXgx1f0kVZgyr5
A+Cg+YrfJx4h
=EmWp
-----END PGP SIGNATURE-----
--=-=-=--

