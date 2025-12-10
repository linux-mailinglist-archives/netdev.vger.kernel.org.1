Return-Path: <netdev+bounces-244232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5DCB2B57
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E1FD30A1AB8
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2660310785;
	Wed, 10 Dec 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11A3USNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8HntsYnw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A830BB89;
	Wed, 10 Dec 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361794; cv=none; b=SsphVNS0c8fpdDskkfCg906iUHEgx3g1G0/02LElk7ldY2WyhwxE0z2qIX3gu+8jIjyUR3HeTfdQnsFOIo3L0LXEzFQqhup/by+uFRfwmtmJjhMaYAGssO+DhQVRY2pz6JTAfFWqsfS0Q+qlR3aw7bpItZYP7N0JguW2VkwT58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361794; c=relaxed/simple;
	bh=x2vW7KhYV5t7SNh4o1euFwUyI1YgLVEkpfW0Y7o5A7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dm6lWU3bVV+qBI9oyVw1JwuzuQ2tQtl3/zVsGqeNYvlXwkDbYkqA2SZ7Xb4GR5z9HxQjeegy7VHactnX6zyPWmpB3v1EYMmX0S2uykWCzDbOOZZAtTr5bRls7f/cXugeXZ5VAk18j/p/MXwb4N6lfxJIGkGELfC5eOWk/TW0TtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11A3USNj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8HntsYnw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765361785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BMSEJ6lggL5sT7YO3szjRGjzmCcBHLP3Iry0cibk5Q=;
	b=11A3USNjquSo0ukyz5OCT3Dbn3R59bsgw70fJgQHXcRJpEEU0EGvffqxCq2U7k59Rkt3bA
	zRV46lZumxoAqxxboqWOzQyBbajL59aO6Btj10JE3J/QvgP5XWvSkVWa76LOhDp02dH/Ld
	h+4zuZsonW3Hfr2VgVSJz0cDlRN1dCX5MS+yDdkjPxXrNoJjsSxXnlVH670YNJSox2CStn
	7waukRQ7cGHVyAKRBJRAS1zVDmJVmxr00gWgd99VAvBhdPkmbOHg2tsFn0FB0rf1f+6CCA
	/3X1w1G+NxtC34GX/pUWEityzGXipzYkJih1wiMWIC9rGBFugdQwKhfvWwuJnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765361785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BMSEJ6lggL5sT7YO3szjRGjzmCcBHLP3Iry0cibk5Q=;
	b=8HntsYnwQlBGhma0mu8LOlkG9W4csnEA7Plii0l1v+8f33XVSUYZOmVBvHmgmsUx7k5fUl
	HNjOTaaXNjEN9uDA==
To: "Behera, VIVEK" <vivek.behera@siemens.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AW: [PATCH v5 iwl-net] igc: Fix trigger of incorrect irq in
 igc_xsk_wakeup function
In-Reply-To: <AS1PR10MB5392FCA415A38B9DD7BB5F218FA0A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB5392B7268416DB8A1624FDB88FA7A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <4c90ed4e-307c-429a-9f8c-29032cc146ee@intel.com>
 <AS1PR10MB5392C71EED7AB2446036FB9F8FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB539202E6B3C43BE259831AD88FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
 <IA3PR11MB89863C74B0554055470B9EE0E5A3A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <IA3PR11MB8986E4ACB7F264CF2DD1D750E5A0A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <AS1PR10MB5392FCA415A38B9DD7BB5F218FA0A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
Date: Wed, 10 Dec 2025 11:16:24 +0100
Message-ID: <878qfaabgn.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Wed Dec 10 2025, Behera, VIVEK wrote:
> Changes in v5:
> - Updated comment style from multi-star to standard /* */ as suggested by  Aleksandr.
>
> From ab2583ff8a17405d3aa6caf4df1c4fdfb21f5e98 Mon Sep 17 00:00:00 2001
> From: Vivek Behera <vivek.behera@siemens.com>
> Date: Fri, 5 Dec 2025 10:26:05 +0100
> Subject: [PATCH v5] [iwl-net] igc: Fix trigger of incorrect irq in
>  igc_xsk_wakeup function
>
> This patch addresses the issue where the igc_xsk_wakeup function
> was triggering an incorrect IRQ for tx-0 when the i226 is configured
> with only 2 combined queues or in an environment with 2 active CPU cores.
> This prevented XDP Zero-copy send functionality in such split IRQ
> configurations.
>
> The fix implements the correct logic for extracting q_vectors saved
> during rx and tx ring allocation and utilizes flags provided by the
> ndo_xsk_wakeup API to trigger the appropriate IRQ.
>
> Changed comment blocks to align with standard Linux comments
>
> Fixes: fc9df2a0b520d7d439ecf464794d53e91be74b93 ("igc: Enable RX via AF_XDP zero-copy")
> Fixes: 15fd021bc4270273d8f4b7f58fdda8a16214a377 ("igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet")
> Signed-off-by: Vivek Behera <vivek.behera@siemens.com>
> Reviewed-by: Jacob Keller <jacob.keller@intel.com>
> Reviewed-by: Aleksandr loktinov <aleksandr.loktionov@intel.com>

Hi,

thanks for this fix. Does the same issue also exist for i210 in the igb
driver? The igb driver also has this split IRQ configuration with 2
queues. Might be good to fix this one as well :).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmk5SHgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjWoD/485rWxJhoXG6maGIgXgnSZ06MZB3ER
/QypdRblVxa6pTV+7sSaXolGSZCrVyfT231q9U0kQA81CWjPPFQbvIxTDISoP6x+
HZqe0tHBqJ0Dj+sH9L5VxhdogKNBxmQ219xpzkhomSFCCTjg0U+wB4SuwsUGDJ6U
h+5YhSMmAH2j92Lbk7+acCsOTM/r9cMEUD2iUhqGfj0banlnwNNox9DAwUeuboFD
EwfzA3Exe9bFIompFdSOoFQ5/kMfyCvF/JxRe71UwqdEuFcwRf4h538kHbF+dwDD
UTZYU7MhnGknSdLsilQL3275WZw7qrXo4sorkD1+gCkkUcMsAep/oC10sT6zXpJR
q216rqXOuI63LC+dcTKlv5472XK+nIhcw5XNK4/OWpGSTnnQ8TwgjnJCVq9qO98U
lVzvUBKAeDftbogUdN5u3WpzdOEsXv81AAJN7vyf41mt/kDcPj1g6XVjdQlHlH0E
PSNEdd8E9EjE+BF/d9KDeojKayF/TqiNRn9TmzBFVJ+EZcC91yUCLy9+oIahOaZB
M+bsDzDDnkjLb0BAlj2G4jre2zeyp8sx+M3y5pAAZTZ8uB5bokEBn0EFt3+HZ+qV
ze37Zi3W7xDA5KVxL3QML9juaIHvu/L41OWTk++H/pMm6u1p2itJloYlx/WDIK8h
WNMHmtvlUE/7+g==
=hm/z
-----END PGP SIGNATURE-----
--=-=-=--

