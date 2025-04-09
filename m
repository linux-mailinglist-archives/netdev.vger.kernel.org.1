Return-Path: <netdev+bounces-180621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11118A81E50
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64490880F97
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779AA193062;
	Wed,  9 Apr 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Kl6fa6l+"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145A125B9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183859; cv=none; b=tOZQ3t0YkxX4ZLIbT/wzPLHz53VDa6n6bxwRYS2vrL4iYxrUumdznbBlJOkj0nIud9mhpST5+czMFpKmG2K5ZEhHA/aivi0xf9Vjo9xaYM2zAjUP/1RXorU0iEdX22S0j7sFkKHlH22a0PxfKVuegbHBUJaXGGVBq0bjJvThFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183859; c=relaxed/simple;
	bh=U7zZD/TujA1vbjQKOFH3wi0oc8Il7ccNrDO+VIMQ1+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0RbvBv+CT441tpo+xhmXfr2Yiqykft96aPCc3/gh5pC3esbRYpCFhnd7N/kv0Lx5zoe334OFNOsMFakqxElpMB7i1NWrhdvlp9YptpMIULUBzhiuGf8CdNSuRcYK7y8unTsVw6mIWLNQ79XrM6n46SacLZeNO1YnP04MOsevvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Kl6fa6l+; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744183855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7a4dAjNQusOdsThgxDSIy+4F08KxjxwHQblu5OrF+WM=;
	b=Kl6fa6l+IH9jAyJF5uUXtuCgQb+fpKa8ukujuYQdkowfe3i3O7f1xkfY7cC6f8uAnCC7xt
	mqTkWnq5pMmb9molkDK+FjpMYgb2RgPmfsaY7I4YEO2gUrGlmA9CWiDJ3Brjoo9+lu4BC3
	9H77dirlfU6J/NlJhkQuu/gf5+20OiI=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: batman-adv: Fix double-hold of meshif when getting enabled
Date: Wed, 09 Apr 2025 09:30:52 +0200
Message-ID: <6178198.MhkbZ0Pkbq@ripper>
In-Reply-To: <20250409073000.556263-1-sven@narfation.org>
References: <20250409073000.556263-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1961712.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1961712.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Date: Wed, 09 Apr 2025 09:30:52 +0200
Message-ID: <6178198.MhkbZ0Pkbq@ripper>
In-Reply-To: <20250409073000.556263-1-sven@narfation.org>
References: <20250409073000.556263-1-sven@narfation.org>
MIME-Version: 1.0

On Wednesday, 9 April 2025 09:30:00 CEST Sven Eckelmann wrote:
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
> index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d1696430909b7af67b4 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>  
>  	kref_get(&hard_iface->refcount);
>  
> -	dev_hold(mesh_iface);
>  	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
>  	hard_iface->mesh_iface = mesh_iface;
>  	bat_priv = netdev_priv(hard_iface->mesh_iface);
> 

Sorry, from wrong folder
--nextPart1961712.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/YiLAAKCRBND3cr0xT1
y/u1AQDvWc+3llxL1qDqtrnLD4jc5XvmWsi2gS8qWZjs66UEhAD/fJj59QbZ6hqU
Xpm+c6rx8N6WbXRz+zjy5GkUf3WORA8=
=cyyR
-----END PGP SIGNATURE-----

--nextPart1961712.VLH7GnMWUR--




