Return-Path: <netdev+bounces-227960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD3BBE187
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70DF1896FD9
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A5283C8E;
	Mon,  6 Oct 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lEn2B4uw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2423184A;
	Mon,  6 Oct 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755038; cv=none; b=Cf8zttqeEPs8KZCAypz13o6kObVNTX6A9uKmmjGU3YZhYYVPjQzoHzeHn22w9OdE4ZuvPO/5TxWDieFSPbY9a7oLE7n/XXGJqvqygpZMmVsPfXy1+Hc1UmlO+NaWg0vGWXwtFv7MLnmGiUJiON9rFJd2aSP/fIbbBWOcmLRA0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755038; c=relaxed/simple;
	bh=kYiKWQmzMbtUkllnAm349wrPB8WGu76wtpaFtalnQlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK2t9zmKJtSX/iHdZXvigxQZ1uxNsXSYs6WcHKPpmfsViSdh6PU4YZ0IaInaDH1vHhtncDSvZNKvWy2RlnGl4a5VS2a5urf8kaSYyUwp4nrPTaNPjwyFQT2HNMFAX8Doe7fm3B6k86qcHTphWBjDIAiE9DcJJYw5k0wNuTbAtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lEn2B4uw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4144EC085C8;
	Mon,  6 Oct 2025 12:50:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72AA8606B7;
	Mon,  6 Oct 2025 12:50:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EDC2102F1D5F;
	Mon,  6 Oct 2025 14:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759755032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HcH66wMM4eQ4Whyz8ULRoHgYEmdhg12oyr1b9VLT23k=;
	b=lEn2B4uwQ9/yNySE7aT/KZZc9y/3R29djf1x3iSE7eHt2m9b5f2WvDpP73Wgg+dvFVhzz+
	xXT8N0ASk7bj7ODV70wxxuOrZ15c/ee7FfgY945NAEbEDtG5oOVcq1QQN69H//NlbyAmZf
	6EvjYFPHxQ6zkLIa79fgqDZlIYfw2arHqQhkxxPaS0wmiLiDEJ2un14DbV+Y+9qusYIJkf
	0f2LICmx8q/OK40MymvJkhqVM9rfj6huaPY/jSoB4F2Rnh9yz1kyCmnU20D5gj9EYi4qV8
	IQUquvyAeLp/L+ToTdRtZjk3zvWeq+fvRynQUGIGBuAe4ENT3KHfqxtcyubVpg==
Date: Mon, 6 Oct 2025 14:50:29 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: pse-pd: tps23881: Fix current measurement
 scaling
Message-ID: <20251006144911.702fed49@kmaincent-XPS-13-7390>
In-Reply-To: <20251004180351.118779-4-thomas@wismer.xyz>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-4-thomas@wismer.xyz>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sat,  4 Oct 2025 20:03:49 +0200
Thomas Wismer <thomas@wismer.xyz> wrote:

> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> The TPS23881 improves on the TPS23880 with current sense resistors reduced
> from 255 mOhm to 200 mOhm. This has a direct impact on the scaling of the
> current measurement. However, the latest TPS23881 data sheet from May 2023
> still shows the scaling of the TPS23880 model.

Didn't know that. Where did you get that new current step value if it's not
from the datasheet?

Also as the value reported was wrong maybe we need a fix tag here and send =
it
to net instead of net-next.
=20
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> ---
>  drivers/net/pse-pd/tps23881.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index 63f8f43062bc..b724b222ab44 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -62,7 +62,7 @@
>  #define TPS23881_REG_SRAM_DATA	0x61
> =20
>  #define TPS23881_UV_STEP	3662
> -#define TPS23881_NA_STEP	70190
> +#define TPS23881_NA_STEP	89500
>  #define TPS23881_MW_STEP	500
>  #define TPS23881_MIN_PI_PW_LIMIT_MW	2000
> =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

