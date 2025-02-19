Return-Path: <netdev+bounces-167635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE4A3B299
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47034188EFDF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BE1C245C;
	Wed, 19 Feb 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0PDkQz+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNW1Ivzn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61F1C07EE
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950753; cv=none; b=TBUPfyVg5fQulC/CP8iS/Klghsv/man5bdgMjd+tB0kRFjStzbjl+FJJbCyR4T+Y9J2y6AlSmoDIluDiNTilvJe/+DbuoAMg3tHB14tRunKpK3V8cLLm0AdjV8zwiRzrXVoKLddi5lkYv60GDLG/fQ8mvK7Qlc/fJ4a/Rgh7kLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950753; c=relaxed/simple;
	bh=cZyhIf6nJ9+7h9izRSQB51sdbF49s4FF9n3hIEFfuzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rWlRBMbyMSGo4MbQFd/vGOmYOozJVNRASy1IXSsdGybev40pTue+3xyJJNakavUd0EpIvEf1bo7yipL1jLJNwRYwCTxSQtgPzznkhxjVcrvIiynHOAhA7T/4mF1HIF6vzYeoGH/c1pKhOJJMY915U/5+zUPIQiG5gFlk1B4YDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0PDkQz+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNW1Ivzn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739950750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZyhIf6nJ9+7h9izRSQB51sdbF49s4FF9n3hIEFfuzA=;
	b=U0PDkQz+9kP8X6+xsFhP66Z4aaQiS+vXyAx2xOLMXSJZ3ZHvMvQSCm6bcDMimvGrHf5Ngy
	goAI/XpO5gmTSKtKeb79ixIZObo/VH2Mtm6aRB6ep3VIcrpjjt34I8M6SGSDDwDiFnCZhh
	eRLJN5no9/mEuA9Wq7bzmS87OqHkLsANg2uNFwhit+lzmEbdzcBps2DlwWfUS2WcV77Ll8
	qswjujf9aoWWi15q4MYpq3yvEsfxr34Kk/B/s61JBvEi7JF19MYtbjPY9rjLsZwRkdRLBU
	StW9h53cZZ3hrVJxkbV9kNcvWl4Nj1GM82l3Z8iWTP1AtUYhR0jJldP4zfZ61Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739950750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZyhIf6nJ9+7h9izRSQB51sdbF49s4FF9n3hIEFfuzA=;
	b=wNW1Ivznoo31IUxaE4Eg05/hvT7XDxDJtqZNrbGq9mOxf8lyULSOs5xYeLyITf4PpcxFHR
	QBCKmO+IAkyJBvBA==
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Gerhard Engleder
 <gerhard@engleder-embedded.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
In-Reply-To: <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
Date: Wed, 19 Feb 2025 08:39:08 +0100
Message-ID: <878qq22xk3.fsf@kurt.kurt.home>
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
Content-Transfer-Encoding: quoted-printable

On Tue Feb 18 2025, Joe Damato wrote:
> On Mon, Feb 17, 2025 at 12:31:20PM +0100, Kurt Kanzenbach wrote:
>> This is a follow up for the igb XDP/ZC implementation. The first two=20
>> patches link the IRQs and queues to NAPI instances. This is required to=
=20
>> bring back the XDP/ZC busy polling support. The last patch removes=20
>> undesired IRQs (injected via igb watchdog) while busy polling with=20
>> napi_defer_hard_irqs and gro_flush_timeout set.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>> Changes in v2:
>> - Take RTNL lock in PCI error handlers (Joe)
>> - Fix typo in commit message (Gerhard)
>> - Use netif_napi_add_config() (Joe)
>> - Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9=
df@linutronix.de
>
> Thanks for sending a v2.

Thanks for the review.

>
> My comment from the previous series still stands, which simply that
> I have no idea if the maintainers will accept changes using this API
> or prefer to wait until Stanislav's work [1] is completed to remove
> the RTNL requirement from this API altogether.

I'd rather consider patch #2 a bugfix to restore the busy polling with
XDP/ZC. After commit 5ef44b3cb43b ("xsk: Bring back busy polling
support") it is a requirement to implement this API.

The maintainers didn't speak up on v1, so i went along and sent v2.

@Jakub: What's your preference? Would you accept this series or rather
like to wait for Stanislav's work to be finished?

>
> [1]: https://lore.kernel.org/netdev/20250218020948.160643-1-sdf@fomichev.=
me/
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme1ipwTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgv/gD/4gY0K9/kkjLMJzWgVHmC5XMh7QYc27
A0HdOrtjCn3hKKtAMOVdjkQGgY1b4boeBvkGE4MKJaE6+XmSEpwnN7zJj/wqcy2s
AElHtM4R2ihPzYGOXpE/OeWjW8nQ0xaPqOOl5QURe1XdEitNY+bUjMMeALbcxye5
P93UwTQxakSL+O5+gPXcs4sHshPFw0RpS0jQXy0RFm7kc+w5gmOCjrLorNnC8tMw
sG6+Yqf4f6DZ76NazVcRHXTT6Wby4e99d1silfz8LWuIO3isIYrz6lKP5F9D27XR
KblZM3D9s4mwz/udWIXmBTQtiacZ7azKlAPlRgq+gtG1msy622mukOh15ycaPNAz
jJ0VNA2mGY1srMZ1gOT15GBwkRYKoU8A1d3udEL4Xxi9ILdjfOa6ItNDUfm4CGc5
F8bVgPQzagqmQU7Kpc+zxuL7fb7TPKCNNTy3Nfdw3GZu0IJpeSg0yDpLU8pxk4h7
FgrYJE3j0hr+C+lxVQuXtLs0cJltmFuevzkmoCINhO7BjJPBtbwQciq5b512llLE
K2TDOKg/2lqEq8Ob5E8vM6NZGQ2l1QAyTHjVeYeQcp9pIhAUMycEKq/pSHWA6NPJ
0C/RZbgsjC3TmBxT6uC2hY3Z6pF512+DgFLGp6ZNqlzhF4/Knk6lbKsGP73ky+ej
O/BH8SY8Q45mvg==
=2MYZ
-----END PGP SIGNATURE-----
--=-=-=--

