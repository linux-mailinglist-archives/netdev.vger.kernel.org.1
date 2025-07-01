Return-Path: <netdev+bounces-202699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D964AEEB32
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B031017DF4F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 00:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A242AAF;
	Tue,  1 Jul 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge0GRi71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1D2AE8D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751329179; cv=none; b=sLD6VyoiLvK9OeNqEP8muwt03zZzx6ddoYLSqxNhCE1B4P/ScEwxZzV+U3cEXGCu0PfLWUtmOu1vMLjHkhV5/TPbogI8xS0hM10cXb5kEooo68TWYmi2pSd7I3SurrL/dwQX+5gu8XY3QPGCC0rI1dmZXr6vz+JyB585RmLrpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751329179; c=relaxed/simple;
	bh=TR/Efsk9qcDxTR5blAkbsnPtWLkrs6Gsf7piPXQN4LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyI019zVdfSCQIOH3c8l0FM7iavzseviwp5jweZnPoi7woK4y/fHYMTK7Bm7J8Sri1UADwWXiZ7DGRQNO17dPwC4SO9ODkv6OPBVpTc5klcaTktg8HGAEJK45f73kZcXLIq6sZ1ZgMn88aZJgep1oel+PKNldnAyER8eOGXfbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge0GRi71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BEEC4CEE3;
	Tue,  1 Jul 2025 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751329179;
	bh=TR/Efsk9qcDxTR5blAkbsnPtWLkrs6Gsf7piPXQN4LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ge0GRi711T1ieHRlWh+7K2KuS6QbJxz46qq/UvucWALmDK25DWQwFd7wpYgEqELC7
	 anpXGilrHnnheNxzTS+NXjARyI6rMSpg9vYrx+t1wZG9m7+1UPyIXyEEqwkAAbQ1jx
	 xiL2E0yFspIiK9ecG7nCR7RKEDCKiA5VepVs1ogtmjKiOEi9YyrE0yRBwGHGL2higk
	 SdlolEee0ll971zs+7sBcu66imYTzZhLGPf6nN2dg0agfyC0VVPqqNHA92hrPH3uor
	 3zqvZKJmCvjGV/zfyLYjOFAnw436DVs9wjFunuk2tnoAXDbeMZg0F3bg/BzKXKFcb7
	 +kuQNkaxRoOvQ==
Date: Mon, 30 Jun 2025 17:19:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Loktionov <Alexander.Loktionov@aquantia.com>, David VomLehn
 <vomlehn@texas.net>, Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>, Pavel
 Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in
 _driver
Message-ID: <20250630171938.1d2a0e44@kernel.org>
In-Reply-To: <atr3nxbqeor5azeajgk5qwmnxuxm7q3qsn3pk53j4mbzvqsdc3@qxa3cgbfxdbc>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
	<20250627163652.01104ff4@kernel.org>
	<atr3nxbqeor5azeajgk5qwmnxuxm7q3qsn3pk53j4mbzvqsdc3@qxa3cgbfxdbc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Jun 2025 12:09:34 +0200 Uwe Kleine-K=C3=B6nig wrote:
> If you do=20
>=20
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drive=
rs/net/ethernet/aquantia/atlantic/aq_pci_func.c
> index ed5231dece3f..2ee5900337bb 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
> @@ -208,7 +208,7 @@ static void aq_pci_free_irq_vectors(struct aq_nic_s *=
self)
>  	pci_free_irq_vectors(self->pdev);
>  }
> =20
> -static int aq_pci_probe(struct pci_dev *pdev,
> +static int __init aq_pci_probe(struct pci_dev *pdev,
>  			const struct pci_device_id *pci_id)
>  {
>  	struct net_device *ndev;
>=20
> this is buggy; so it's justified that you get:
>=20
> 	WARNING: modpost: vmlinux: section mismatch in reference: aq_pci_driver+=
0x8 (section: .data) -> aq_pci_probe (section: .init.text)
> 	ERROR: modpost: Section mismatches detected.
>=20
> . However if the driver struct is named "aq_pci_ops", the warning is
> suppressed due to
>=20
>         /* symbols in data sections that may refer to any init/exit secti=
ons */
>         if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
>             match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) =
&&
>             match(fromsym, PATTERNS("*_ops", "*_probe", "*_console")))
>                 return 0;
>=20
> in scripts/mod/modpost.c.

Now it makes perfect sense :) I see you already reposted with a better
message. IIF you have more such patches I'd use the word "suppressed" -
something along the lines "the section mismatch warnings are suppressed
if the function is assigned to a struct with a name ending in _ops".

