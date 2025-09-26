Return-Path: <netdev+bounces-226609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51576BA2DCC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9007AAE31
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19A289376;
	Fri, 26 Sep 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AVvbJnjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3B2836A6;
	Fri, 26 Sep 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873415; cv=none; b=HJLO1v48zyLTBWaI6VcZWYSmsdfo4gZTn50CoNj5WI9YZsA86z1SX9ypcAjw6eMgzTUx/3hjD/XMOHysSyACxs7Mkx8aT3GoNBN1cNEMsCT2FCSUm/iXUsVLk6X3u90T1MbtGCO4jCsUI45JkfEXZBnVjujowdK120WYl3bkcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873415; c=relaxed/simple;
	bh=njBp7zsXtJxtFTAt2902aTyJccp8rh6tUb6f+2R9iao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mSTVOXhtt0Muzueq3xRccsQbw/mkiP77/nDsPx+LCW7fJbuoiIRifZFm25RpHmNUMCmCYZ4ifLqiJBNLBi4mStwH5PAPvd5o+6UI5/mWjJvBvY/jqSKQ6GQR+lghuIdX5ERCh4qqNMtXxHDoYq7QdZpl6iyI1JQpfJ0MigRDl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AVvbJnjS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CCA414E40DF5;
	Fri, 26 Sep 2025 07:56:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99F39606B5;
	Fri, 26 Sep 2025 07:56:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C928102F186D;
	Fri, 26 Sep 2025 09:56:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758873409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=njBp7zsXtJxtFTAt2902aTyJccp8rh6tUb6f+2R9iao=;
	b=AVvbJnjSU/S/d96UQfJ7Ydp85ytdEbkM4DXBAUy2j0S3uCBRL4BYqFpdTZNKZmsKXEGT+T
	AoSZRVWcCkveYSQHUM0gra/bTjR8kKZhLIXt/A8NAYCWFRW7cv05mcE5Pl9L0Bz/ZnH0Xp
	ZVLmpJLJqW7CQZk4Ki+YeqAURfOpOf7UuNanfB79/TPJm9EruPKjfhmwQI0bqGHxnXH0yr
	j9BEiUcA7tBm5QUU/EowudkPgtgFLHSE8EOfxVD23NROzeMHCmKmwiaeKBLm4dydYavrTk
	zoB8HMdudFePGtLrR7AH7cqHQI9Oivb6/ppAUN4YjDhb6LAiC7etZKlPi6AJRg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 09:56:25 +0200
Message-Id: <DD2KKUEVR7P1.TFVYX7PES9FS@bootlin.com>
Subject: Re: [PATCH net v6 0/5] net: macb: various fixes
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Sean Anderson" <sean.anderson@linux.dev>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Harini Katakam" <harini.katakam@xilinx.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Sep 23, 2025 at 6:00 PM CEST, Th=C3=A9o Lebrun wrote:
> This would have been a RESEND if it wasn't for that oneline RCT fix.
> Rebased and tested on the latest net/main as well, still working fine
> on EyeQ5 hardware.
>
> Fix a few disparate topics in MACB:
>
> [PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_=
clk
> [PATCH net v6 2/5] net: macb: remove illusion about TBQPH/RBQPH being per=
-queue
> [PATCH net v6 3/5] net: macb: move ring size computation to functions
> [PATCH net v6 4/5] net: macb: single dma_alloc_coherent() for DMA descrip=
tors
> [PATCH net v6 5/5] net: macb: avoid dealing with endianness in macb_set_h=
waddr()

What's the state of maintainers minds for this series? It has been
stable for some time, tested on sam9x75 (by Nicolas Ferre) & EyeQ5
and Simon Horman has added his reviewed-by this morning (thanks!).
But of course I am biased.

I am asking because merging would benefit my pending series.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


