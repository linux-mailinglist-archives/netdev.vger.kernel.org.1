Return-Path: <netdev+bounces-79006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C839387759D
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544B32833EF
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204D2566;
	Sun, 10 Mar 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="HexphMuC"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FF8480
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710055844; cv=none; b=fmcQ1WJ9MdC4g/Vuu1bB0Jl0fUNOZjQSEMRh+Jx0lZapWAYmkk4D5WhfI43PBWHzG2qP4t4s69qtwFlTvhmm2wtB2TYcroxPKVJCMoERGoACTk7qKxS/GsG/nAy3LrpJrAv6/W+JAuJakbciTJcnnUkOQmQLzxF19kh+8NXhyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710055844; c=relaxed/simple;
	bh=KeBLP/NCbPJo8e7X7mjC3ihGgJGMXHoX+98UB2fM7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJMSIuPfIimYXVWvyW1D/xjomBz5ule7orA4jmopPWoWKtOF4gki3yCpNZrue9e30Z/6Dy6Y9FjXBkZ8qsngRZmwWU93UHTYRNnLWyTL64bnE2FGNEnNLt8AjtRzMkRV0FhFSc1DvgEZ5cWyZCJo/JA+PLykcE5qBdVLrme+4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=HexphMuC; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1710055365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h17KIwzOrUekHzB5+mlymxvuEPwRYsg3TcII5Vg/o+I=;
	b=HexphMuCuMRkyacOvdRVnTdMb4UJ4zokFC7urfUIJ4G2uYHkTJBURimHAcxJQ7L0KM9wUH
	5WpvsfQ67RUXDx8DUhMs4bAwqZpkRDn6ptC3IOKw0kV4EUyXu5neGSJcko/zI21HnFrYPE
	obtd/HCl4exokdEwOjpQdgUgcw45yYc=
From: Sven Eckelmann <sven@narfation.org>
To: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, Jakub Kicinski <kuba@kernel.org>, Jason@zx2c4.com,
 mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 pshelar@ovn.org, andriy.shevchenko@linux.intel.com,
 wireguard@lists.zx2c4.com, dev@openvswitch.org
Subject: Re: [PATCH net-next 3/3] genetlink: remove linux/genetlink.h
Date: Sun, 10 Mar 2024 08:22:35 +0100
Message-ID: <4554322.LvFx2qVVIh@sven-l14>
In-Reply-To: <20240309183458.3014713-4-kuba@kernel.org>
References:
 <20240309183458.3014713-1-kuba@kernel.org>
 <20240309183458.3014713-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2320315.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2320315.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] genetlink: remove linux/genetlink.h
Date: Sun, 10 Mar 2024 08:22:35 +0100
Message-ID: <4554322.LvFx2qVVIh@sven-l14>
In-Reply-To: <20240309183458.3014713-4-kuba@kernel.org>
MIME-Version: 1.0

On Saturday, 9 March 2024 19:34:58 CET Jakub Kicinski wrote:
> genetlink.h is a shell of what used to be a combined uAPI
> and kernel header over a decade ago. It has fewer than
> 10 lines of code. Merge it into net/genetlink.h.
> In some ways it'd be better to keep the combined header
> under linux/ but it would make looking through git history
> harder.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[...]
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 75119f1ffccc..8e0f44c71696 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -14,7 +14,6 @@
>  #include <linux/crc32c.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> -#include <linux/genetlink.h>
>  #include <linux/gfp.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
> @@ -38,6 +37,7 @@
>  #include <linux/string.h>
>  #include <linux/workqueue.h>
>  #include <net/dsfield.h>
> +#include <net/genetlink.h>
>  #include <net/rtnetlink.h>
>  #include <uapi/linux/batadv_packet.h>
>  #include <uapi/linux/batman_adv.h>
> diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> index 0954757f0b8b..9362cd9d6f3d 100644
> --- a/net/batman-adv/netlink.c
> +++ b/net/batman-adv/netlink.c
> @@ -15,7 +15,6 @@
>  #include <linux/cache.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/genetlink.h>
>  #include <linux/gfp.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>


Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart2320315.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXtX7wACgkQXYcKB8Em
e0ZBNQ//fHhWrp8So5pa2gvNTn5gSGE8Jq/IIcyGWdk8bHyznaYbVxyJNteajKde
CdRlZ6I63j0si/FHk57YzT3Lcf1e5yhM7vDVlt3oMzySuVYl0Xc1MI9sNQ3SU6ZO
TyG4LLQQav7noOmtOm54Tousu8Bolp1aAS9wIg6jjECDkZpR+B9U3MGgq+owanhP
qvhMSrVH6O2I/9eNnE+zaTevEzOnpDY98rNG8LX3ju+ZTpxWFbTqzukoOZqz96IS
hG3vhBZkI20J9bxs0W6rd5NDPcWKe0Yo9KRGWH+klzMqwzK3giluog3EqdkmXjn8
272USZIl1ekhkF52reNVrTUh8RqqX6DclA+wcfwp7eRsm4NBBW0nYTAbKN9NCQvz
P5+Xj4y4LIjo5zkjIfCk/mcIxHx2x089NojbbBae5yUpZcOKvJCk1P8tAdmCgEeG
n+NYPZTzYRZloVE9X7F5wCceL+DgeeSGDAr/FEJlG1opoXwAguh3jVVTgHhtgaFr
jSpvVWzbZLhB2wo7TUq2FtS1LMG5U922XAbkRf04mNFr0oxHxoU1imMbzi+VniIT
hZED8QP3F08hM4LqEKjXmrZwHLx4+v5mz8QtyVEOSvbzWTHjSQhnWexwRS/1UVLy
kGdKTWyLiOLF+ROo7UXRbl6k3+Iqvpkm66w/oBXrBSoq+TbDiCs=
=BNz5
-----END PGP SIGNATURE-----

--nextPart2320315.ElGaqSPkdT--




