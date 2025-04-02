Return-Path: <netdev+bounces-178883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F1A79564
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4217E1709E1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF619DF61;
	Wed,  2 Apr 2025 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ofeeJhCr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB432E3374;
	Wed,  2 Apr 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619642; cv=none; b=QoKYvX60Fih9zPNr0W3FRyI70oniyadAuTpeeCHgsrOFYpO322mNfHax0/PSdLzV1GLMem+MLtOC431Rxx5txPoRo9LQzGFcu2m5mdye65To3rS6SdLmpPo+0/jvIUo99DOb2BzfjjNKLKyAOw0fcnsR7GgcFb/U6L/kPreYnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619642; c=relaxed/simple;
	bh=Hoa2+ro5EZ5o1RGrqrosAxoZVsV1RUdGM+AjzDAFuaA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MSYk7hi6UL9sEBWfw1nAa8a0RCx6rewXOYPTuONGFsNZhmA0vpU/AcYlf7/HWUQ/q4A1/nLhcbbzy9gh3JCMPMy6t7F0aIRihwYWQdqe+WUX64Kov+LevKRhX/r+B7O+LcRHFiWK303rbffIgXzvuYDjlpyt0D2meJwxnegcZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ofeeJhCr; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743619624; x=1744224424; i=markus.elfring@web.de;
	bh=Yj9RIDQsEt8tzSW+jzu6BqqXOE9MVtLSr5ORhlPBVxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ofeeJhCr8HK3ha0zzlVhDnwFEJxlkRT1ztdiT3X+xO6A+Py76FHgpNOqhMsGiEP/
	 A8cZ4Cnk2ixEKCEPjGizKqa7Mgnb89P3klp48F/B363ebR3wkZ4U1I+RzRmeBEp+r
	 9UGHfshYw42j3/TiwlJeEtWCDNnLduX0tFXXTFvWW55+i21vKHaYgWa2LPwozeGb7
	 Ley93/RkDJwunAsK5V3d2jOlETjpET8RB46eVKdkWTZlBh4xoJ5kMq33n5v5mYXrd
	 XDjfeVrQsZMy8Rw8a7TF7lqxWf/DKpLAXH5xo4RgUv54WP1QRzQDijEVphIOGewLB
	 R8mN2LkJKmMPJiyx6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1tvQXh12PZ-004RVw; Wed, 02
 Apr 2025 20:47:04 +0200
Message-ID: <8bb290ee-615a-4e88-b7d4-776239c07ae7@web.de>
Date: Wed, 2 Apr 2025 20:46:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250402135036.44697-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v3] arcnet: Add NULL check in com20020pci_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250402135036.44697-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IJYrwiTEnWcW+yavwbIq47Sbbyd8KqFJersVQRVS63XObx8b575
 WNfEw9gGkWKOP04BQTFZgxDK7PKSMCncyH+tdjbYXeNawA6k6T2rBZBjUNMS/xVNHtMvQ6j
 6Cuu2RyWq2Uaps56o60tmbELU/xp2zcqIOQIw8+M+6rJ3twOJu74arW+mhB8IFQImmpqVvP
 R3ddrqqkDW0Gy2BKgnTMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vogOzPIWMks=;yC88XCTv66/Z1sYoK8LVqd+iWPR
 1v62xz3jHNFCYnnroCdQh8wWfS6kq7OULbk1NYSkFSfgjQs4koofmrkR7PIpa+e2iJv1qx6nn
 YSQTq2AwBY+yrlbUHWVQ4n/kGYDOvqp7pQJZ0juiwrZzN+Mf+JU2Fx3OpzXH2MsogTluWRMEm
 cVXaIcJvID1hkg1BJ/jYPm5gs5ZZd06RtemhU8I7BQ1zYPSY0bVbEf4VYPIyVhITH9BtbrjjM
 sTpCGhheFQA32+OLS0yjmYmOjfKP/UqUWwwk2udvUjjcy7kolialY+DDgppX4sq9Q/chBkjFD
 q+U57cM0Oqjh1zv9BAQZny5wXejf55SoQp2/odlUJd+rJzRLHfLT7oIjkYhIzL+6FUjR3wYDv
 UlXU5wVvSbmbmjb284R7jhkbuSJTmXUEyvFV9w38wUXnEf6WbH0dTZ8mDR4yJ3YCXsUWmFsvQ
 xfCFI5wERMS/msJPZ767RzRGUWPVmYThpYUEiR0M4+7jfRbj45JEm8xv1+Lkbdl4yEamnvKIP
 S2AojHz/RnLKXPSYVGG//iHhu72i6JTmC7J8rIc4pj0dLO4oCotc2wvCoUp/QzoBw4prAvwqL
 4P0r6WQuSE3ib+ZfcjtdxCaH14EMWHZxcC/WLFAX0OfcDcPq3iBPhPOULcqHpXTjE5XRm+jJk
 6aNJzAs217eOZtPJUcS4Vg+oMfZmX6MbZZlfg0XSeCetJxOVAOHdgECuJrcR+g+RiTG5sov9+
 wFJBGfbVX/NP4C5uGu1RCOuPAw3g02/FYaSNgXaKNxwV76A+T5hwC7eDJkOIGROVdUdpoJmcc
 mf0A4hEToQhYiTVxb4okIIqUHcS5oAKRYLqbZVahIz4ZicMWeCHtV6Gl2KXNG7R0QpjjEYqAu
 WfvDwlPfNdbhMYHDTSnUi74PI5V7CZET5v5gi+Tg5G45Zv+eLUKhCfwZxdUemxMjaSTV1e/HK
 ntn7znzO2RplnOPEb5giq+g+Wyyvd2G+uTYJ3D8QdVMmIN3SJXGX5tIg3X7+qmmzZON0nEZ4/
 rlPtxx4mfguJm1F9zWi61SQmIXnLdzWvpj6mHJbni/vehPIHm7D6F9mgi2JDnUvruNfl/sq69
 xDFfWmruWZ8lgxal/SRydUE6D+ShwN0OUbj3SwRb/Lv5s4j5WzEUASByTWvkUpdVUiMCKel+o
 0txxc85BtZztpZcdgYO56AG5MXO4gHT1NpfK0H88Uhc+iLpedoDl0TSIYw/MWXEYaaPYyPQVs
 3a2YgWGKYaAwBG6Jt6I+bd6/Fc8acZrTHxnRBiGakjA6MJXOQ7E7aOgxajpOrWSvn+wGuw3B2
 /IzTdeoYphmPeO4oN/+xDw39uXnu0NjYLA8CNv6cUVLXysbb2qjlCQZNs/YMr0W673ky8afKz
 Zunho/HyXK2ZTiJSlsByIcuytmaBC1ft8STIBVfu5YW/iknzT1i72g992ZdXH/mRD1unS80SQ
 CgRorGx3cD7+baEDVjgBmcqNuRWnNa4M47i/6jA9AOfdnue3B

=E2=80=A6
> Add NULL check after devm_kasprintf() to prevent this issue and ensure
> no resources are left allocated.

I hope that further refinement possibilities can be taken better into acco=
unt.


=E2=80=A6
> ---
> V2 -> V3: Reuse label err_free_arcdev for exception handing.
=E2=80=A6
> +++ b/drivers/net/arcnet/com20020-pci.c
> @@ -251,18 +251,33 @@ static int com20020pci_probe(struct pci_dev *pdev,
>  			card->tx_led.default_trigger =3D devm_kasprintf(&pdev->dev,
>  							GFP_KERNEL, "arc%d-%d-tx",
>  							dev->dev_id, i);
> +			if (!card->tx_led.default_trigger) {
> +				ret =3D -ENOMEM;
> +				goto err_free_arcdev;
> +			}
=E2=80=A6

I propose to avoid duplicate source code also for the shown completion of
the corresponding exception handling.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution(copy_process()fromLinuxkernel)

See also once more:
* https://lore.kernel.org/linux-kernel/?q=3De_nomem

* https://docs.kernel.org/process/maintainer-netdev.html

Regards,
Markus

