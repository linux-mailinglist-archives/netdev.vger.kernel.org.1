Return-Path: <netdev+bounces-117009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6694C582
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61211C21395
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6858146A61;
	Thu,  8 Aug 2024 20:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347D9460
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147589; cv=none; b=UGRBmLVaHwsb2xXwuDbhnOWwmXPQdwCWINUOp+9BwkXYwzw9T2mQmRCDZ/i9W+51Z7rWQZp/zzW4dFQChj7NIIixrsvqF0+ZCi5aDWveN+9VU/imbAUqii1pSDjtlhvkkSBHSZT9JWEsRSNSrjsYujruaRvS9YnIyBVRYzc+xSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147589; c=relaxed/simple;
	bh=GKV+kmuT7YJsGcFX+PR1U747oQhpo9uU91b2Y7acLAk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=pl0LxuYJCQN3hhClrW8g8NkLIvvLceqM0LLocU06RCH3Fx3xeGqtO20sUq6tL3FPWyY9Xh5vbos5jkeELyIfxaMeyx7pEd23gggSrj0e4DYwp7gM30b3FPF60kup8bJYCMtPripQQj5nJoVQDZXmIpqq1RnsGpcDemTA0kT8Xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 150327D064;
	Thu,  8 Aug 2024 20:06:20 +0000 (UTC)
References: <20240807211331.1081038-1-chopps@chopps.org>
 <ZrSTQnisAPkwlvWW@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Florian
 Westphal <fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH ipsec-next v9 00/17] Add IP-TFS mode to xfrm
Date: Thu, 08 Aug 2024 10:22:25 -0400
In-reply-to: <ZrSTQnisAPkwlvWW@Antony2201.local>
Message-ID: <m21q2yok3o.fsf@ja-home.int.chopps.org>
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


Antony Antony <antony@phenome.org> writes:

> Hi Chris,
>
> On Wed, Aug 07, 2024 at 05:13:14PM -0400, Christian Hopps wrote:
>> * Summary of Changes:
...
>> v8->v9 (8/7/2024)
>>   - factor common code from skbuff.c:__copy_skb_header into ___copy_skb_header
>>     and use in iptfs rather that copying any code.
>>   - change all BUG_ON to WARN_ON_ONCE
>>   - remove unwanted new NOSKB xfrm MIB error counter
>>   - remove unneeded copy or share choice function
>>   - ifdef CONFIG_IPV6 around IPv6 function
>
> I noticed a build error with CONFIG_XFRM_IPTFS=m. This error also shows up
> in in NetDev NIPA tester. However, it kernel builds with CONFIG_XFRM_IPTFS=y

Indeed. Added the missing EXPORT_SYMBOL_GPL(___copy_skb_header) now..


> a@laya:~/git/linux (iptfs-patchset-v9-20240808)$ make
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   MODPOST Module.symvers
> ERROR: modpost: "___copy_skb_header" [net/xfrm/xfrm_iptfs.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/home/a/git/linux/Makefile:1878: modpost] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> NIPA tester also noticed the build error.
> https://netdev.bots.linux.dev/static/nipa/877576/13756764/build_clang/stderr
> I wonder why the  kernel test robot hasn't caught this yet.

It just hasn't gotten there yet. :)

> Also note a few minor issues with the patches, specifically for the patch
> ipsec-next,v9,14/17
> https://netdev.bots.linux.dev/static/nipa/877576/13756763/build_clang/stderr

I'll fix these, they are transient warnings based on how I split the patchset.

Thanks,
Chris.


>
> -antony


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAma1JTsSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlQbMP+wSbTpOlO/uomv6ooRyKzmc1vxhoeIty
yp4S24aM3hY07W0y6Q29sI6aigd8jvJ6ND0kGBn0uoH8WBedhBS6oYzveobmhyH4
TFCJQyudzF85rSVDXcepD7qhQsG0NDiSzm/MGt7rZohCO/oD6K4vGxY99XVFgPu3
Sg44CoHZ0H6XtiGsGScbwmVwUmLf9EZomiH0Jbk3zrN1jUCkNuENPyhP+Qk8pXFv
nhdCioyzhOwyTclrhlV7riR6iJGap0MsVH+nQVzQLkWhrQAKgwxaVTm7Y3ehjTe0
ixbQTS1eoleFFcWZmZR4yxkd3dG+yfLtbl4wut/NLFh/AttM1/cUasjwyLAhuaG+
HeDyxM85XBRC8GAuqiPqXWdT9TxUqZ+YoOZWMeODZ9FtwzL4pbSlWrKV5xjieOh2
NoF2gKHpUrE+rQYyS0N5f5B2iIthtlPLLQBtj7AdsMGIcdBQYbpIf7HBxgS15GKe
RmlO5di8YdnyT+qUQ1IbTcf2t0BOM9O6YfyBnJlctSEqxm/clC+V5/6mqIttmEkp
MO5nTzIS4NPkHZb1MTpuFGB/PuJwxFi7oFJCLZH8rbGz0/hZ3gXnSI+CYw5o9WEA
8jcRi584a1J1PqMHTsX0OrnS30+NBIHhABuXN0P/Fmu5HwNVtB7xdmtFBsVx+WEr
RN/3SacJk5Rk
=dX2d
-----END PGP SIGNATURE-----
--=-=-=--

