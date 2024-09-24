Return-Path: <netdev+bounces-129464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DA98408F
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEAB280AA7
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48414D2BD;
	Tue, 24 Sep 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VbvZCdpE"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B133398E;
	Tue, 24 Sep 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166844; cv=none; b=Lt1PUi4tQPoGkDCI+3+aAPS2GWJvAy5TXRBxoj1Od9+B2opa5ltk3PwSeXk16gmbQabHg49fAqAZGQCrw7EMyXx5XunN0hK3Z+6OmNlPgbThwPp/lof6iStccvszq1remTT9BDB9sydJy5KVyu9E2u8FDDQZN9LMQLpdeMNrrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166844; c=relaxed/simple;
	bh=3Pw8oakgfodkUMH7S2qM9pbAetVn14M1tcOpKS5dvgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMPZB5biIjqFAw+ndAWmXXtDmnWdf4F9EPr2hCgu5SgdptBc0pOqoTO1iSq7HDc97pdd3gAMaewqGnfv6fhSUosSL9Ad2QEh14adfJOyrb6A1114289ymLpJeSJETe7r5mwNrUhimrdlIsAXEfMcxSqvaE9yUvAuNPKvLtAnx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VbvZCdpE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C41D11C0009;
	Tue, 24 Sep 2024 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727166839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Pw8oakgfodkUMH7S2qM9pbAetVn14M1tcOpKS5dvgY=;
	b=VbvZCdpExVYKzCCmgFiJgbFbmkdZlhF3HsYtV2BOsJTXRbHwvxhjhG2bdzo6WqZMd8Ynlm
	RK/Aah6ssE2UcpKwKq7oat+mvGTTjUczIoAwZRa00CP+yYNK39w3ynqBaXLzOUVno/iZ7K
	6zIGbi/dnfj6YEtxRGpFiJ2IaWr7WbdHFNdnz+cUmkm2BAU1TjCFc7y/PploXYJS9/QTZD
	QS7B3b58sg5VF42NRAqDvY3ag2I3PaFC1nv8cvkhFWZPdgwE7UJj9Pfdf8D7XRkz0Ln8CZ
	Pn+uTxVwbycsSczbBu64fGT7eFFpGzYnqWa+g3/eI0ZacEB0KGke0VtEv5ChHg==
Date: Tue, 24 Sep 2024 10:33:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 thomas.petazzoni@bootlin.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <20240924103357.1ca3d22f@kmaincent-XPS-13-7390>
In-Reply-To: <20240924082612.GF4029621@kernel.org>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
	<20240924071839.GD4029621@kernel.org>
	<20240924101529.0093994d@kmaincent-XPS-13-7390>
	<20240924082612.GF4029621@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 24 Sep 2024 09:26:12 +0100
Simon Horman <horms@kernel.org> wrote:

> > Don't know about it but if I can remove it from my driver it would be n=
ice.
> > :) =20
>=20
> Right, no question from my side that this change is a good one.
> I'm just wondering if it is best for net or net-next.

Indeed, I don't know the policy on this. Do you think it shouldn't go to ne=
t?
I will let net maintainers decide. ;)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

