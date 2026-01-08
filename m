Return-Path: <netdev+bounces-248136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C9D0497B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D263E31BBCA3
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431B135A53;
	Thu,  8 Jan 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hEchSgcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522613FEE
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887393; cv=none; b=qBPz1VEz2Oo7PHwkd6w1kKS7JxNAgZxzle94fRw/Mf4glIO4pDaGPXIGgWO480/vHw3xpKBJ8vh//EGkGtmBMUlADy9euNBsTbpSitybHMmEdmPFSPo+K2IclS4H4n/Zi4nPc7/RB0gawz9ah53AwVZ4cP09MzLDn4lecLZbtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887393; c=relaxed/simple;
	bh=baH0+S5FRCy2ZjSOmeskCbxjbyD4X718iYtRCXvFed0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=jb8LPil4QHwgeNyrbTHn97+sAU4DHAWH1gpqzYIq+n2KUEUYhew++ljyWfTYHEfXb5mJ+1/A/jcy3SDMsowZbBf9962TIWEAG+Frl3hamxlJFzqH0Y+98LS2M/SIgLhWeSinzA6ExNRP1p+tzSYag0qyvayDZySFs9MEwuA42ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hEchSgcR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 93BD8C1ECB4;
	Thu,  8 Jan 2026 15:49:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCE9A6072B;
	Thu,  8 Jan 2026 15:49:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A433103C88A5;
	Thu,  8 Jan 2026 16:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767887387; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+Na8EeoJpHVy9GL8yL3E3EnYoVxE4qmKVaywnb9ABQs=;
	b=hEchSgcRyev5Wdv7QuNPL4hDhDVVQqmHs6DGmRdYNhGE1rsK+bih4eAx2nLriIM3GtKlrl
	grarWnOY9jkcNKnzN9Jn3kXb8GMnxIiV+Yfl7Q7Hbg5ycjuuFh0YifyuN1A3hqJWTBWIv3
	uscHlrOARgD/LDOy2nfPKYICSXFrCslqHp5ERsMhUqqdwY1WnS/rcvdVECyI/uESLOfK7b
	ev4LteAdSbNy4ink12DzY2UacUYJxsXiF7Zc0r756qh6KTrRH1uifdbgjU9aXnGhMy8GgV
	TMmigQhXhWT7h+XhTerOUpHwQ6Gif2cHYpAjpepMniHS2dXcdSgz9lKD19faiw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 16:49:45 +0100
Message-Id: <DFJBRX0BOZ94.1YAHY6PVCGA0L@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 5/8] cadence: macb: add XDP support for
 gem
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-6-pvalerio@redhat.com>
In-Reply-To: <20251220235135.1078587-6-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo, netdev,

On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
> Introduce basic XDP support for macb/gem with the XDP_PASS,
> XDP_DROP, XDP_REDIRECT verdict support.
>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   3 +
>  drivers/net/ethernet/cadence/macb_main.c | 184 ++++++++++++++++++++---
>  2 files changed, 169 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 45c04157f153..815d50574267 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -16,6 +16,7 @@
>  #include <linux/workqueue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/xdp.h>
> +#include <linux/bpf_trace.h>

Shouldn't that land in macb_main.c? Required by trace_xdp_exception().

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 582ceb728124..f767eb2e272e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2004-2006 Atmel Corporation
>   */
> =20
> +#include <asm-generic/errno.h>

This is a mistake. For example compiling for a MIPS target I get all
errno constants redefined. Seeing where it was added it might have been
added by auto-import tooling.

If needed, to be replaced by
   #include <linux/errno.h>

=E2=9F=A9 git grep -h 'include.*errno' drivers/ | sort | uniq -c | sort -nr=
 | head -n3
   1645 #include <linux/errno.h>
     19 #include <asm/errno.h>
      5 #include <linux/errno.h> /* For the -ENODEV/... values */

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


