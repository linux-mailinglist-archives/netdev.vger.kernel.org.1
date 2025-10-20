Return-Path: <netdev+bounces-230881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116ABF0E76
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4998318A3AC6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016C3019C5;
	Mon, 20 Oct 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2U6egRXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CA2F5A0B;
	Mon, 20 Oct 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960704; cv=none; b=a6mT7Ox4V8aykfWLLE0tMtOoP1un4UCeGmkHTZaximNzk4nnsrMNlYCQC51CxgxVe5wkC0+lKedIwOA6KLQYFcrRf3E1gJwgmk2ExhveFJnrPzscvRyIFM+OQKbmNmFmiRs3QvypVYpaDxtnpf19uCy3d6+eVdrI834u3HVLbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960704; c=relaxed/simple;
	bh=9yWniy+HNlosjfDXbkJDHdJJFXLkOJ7jzI4nRZ/wWFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KiBip+3Dv8h+2wDh1cIVHIIfOMAd+6PZl0KxTQsZqm4tylzY73hKvEz284lVWo8JU5+IB8h+Didmb0aVQ5mm/LZE/yXcoFsLfBefA76My3M3Uz7J+ihA6Bl64g7Mg437tZSiLLbEpXk7T4szpBmEoqc6GuuEFLrUX/y6bFWdSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2U6egRXA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 415DA1A1543;
	Mon, 20 Oct 2025 11:45:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 140D1606D5;
	Mon, 20 Oct 2025 11:45:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B488D102F0848;
	Mon, 20 Oct 2025 13:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760960699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9yWniy+HNlosjfDXbkJDHdJJFXLkOJ7jzI4nRZ/wWFw=;
	b=2U6egRXAMGsKXfEJ1CtxeBIZqH4xHj780YooziZY3DNF91sHJ4LCyhlTyUQ9nVnvqLeX+A
	qQt/2UNqO7dq7FivqiLZDOi0jWLaVEmSs0bPjywJY20I8dDdu0L5HLQdTec1bMprpoYpaB
	m6X6WbBlI4ZK5a4XsDkGtNXdSKSbj10jFB9eDYOxj7gQLlPRx1j1bgnq6kh7xgNluz0dsE
	iMtF23b/E8FBDutQg+CawLz9i5MBEti9zaBTXL7A9Z2SXM64H0M16k0OKvoHEYSDrGHS9q
	myHq1/v38jIQOmR5Rr0kyEIw4BmSreaucpbrSnZ9WnYQSRWCXuPJkC+pJDuQkA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 13:44:43 +0200
Message-Id: <DDN4GPV4RONM.1Z2JDM26J7D8E@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "David Laight" <david.laight.linux@gmail.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 11/15] net: macb: replace min() with umin()
 calls
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-11-31cd266e22cd@bootlin.com>
 <20251019151059.10bb5e18@pumpkin>
In-Reply-To: <20251019151059.10bb5e18@pumpkin>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Oct 19, 2025 at 4:10 PM CEST, David Laight wrote:
> On Tue, 14 Oct 2025 17:25:12 +0200
> Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:
>
>> Whenever min(a, b) is used with a and b unsigned variables or literals,
>> `make W=3D2` complains. Change four min() calls into umin().
>
> It will, and you'll get the same 'error' all over the place.
> Basically -Wtype-limits is broken.
>
> Don't remove valid checks because it bleats.

In theory I agree. In practice, this patch leads to a more readable
`make W=3D2 drivers/net/ethernet/cadence/` stderr output, by removing a
few false positives, and that's my only desire (not quite).

I am not sure what you mean by "Don't remove valid checks"; could you
clarify? My understanding is that the warning checks are about the
signedness of unsigned integers. Are you implying that we lose
something (safety?) when switching from min(a, b) to umin(a, b) with
a/b both unsigned ints?

Thanks David,

[0]: https://lore.kernel.org/lkml/176066582948.1978978.752807229943547484.g=
it-patchwork-notify@kernel.org/
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3Df26c6438a285

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


