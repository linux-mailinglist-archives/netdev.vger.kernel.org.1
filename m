Return-Path: <netdev+bounces-232010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76373BFFF2E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657DA1A08307
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020A301037;
	Thu, 23 Oct 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsZGITRr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EC3009DD
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208541; cv=none; b=mnT38XqwMU6gTeivHrOeQJe06svzeo5nu3C4G/PEBvFbi4Ujz7rFn3MWbo2Ln3WWbXGwdsegQThmKqzx3lqTkeLLDByciah53OayS2RZAfMLWm6Igxav4ZaaKdrqnGIw65QgZBOJWhXhvd191krhuKUxjYE3mBk3fqQVqZLPdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208541; c=relaxed/simple;
	bh=QyGq63ZvKspF1jw8uQGnqd963nP/bOUmb/fJ7CbY46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/U6CSbXJz/Zro2HTziG+e7I6rIBR20fS11KoVhhZpAIlXuvmrS6i647KutqffSOmN2lK7kCe2zs0mrcY0vcMX7/UJVBuupFoQRT4pitlBI6GwaboOP803Uned40GBWz33GZq/DCPMEy2XPowCsTm1wUM5yb4fWnHqFVnFn2pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsZGITRr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 65E3BC0C407;
	Thu, 23 Oct 2025 08:35:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B4AF6062C;
	Thu, 23 Oct 2025 08:35:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82B43102F245F;
	Thu, 23 Oct 2025 10:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761208536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QyGq63ZvKspF1jw8uQGnqd963nP/bOUmb/fJ7CbY46Y=;
	b=hsZGITRrOYENYpvBAgl3pGETE+fYzC2CXnRYmMu5tzsNzIIdh1durFekdpZoOLwmfZV8a3
	F1ObWl6rZsxBZpe3WlDU/n6qsDAJGKsFSoaR1gGM9y85lcmCciEX5VpU0H0sUHPOieunKi
	eTO4BYHcjWuXhpc4A9u/Tx909YQk9wb3EKtLvS3EwMu0HxB74XxT/8fdj5RfVqe53JAe+h
	P3cnSol+/+vo0Xy5X/l1lp4oECkwYZ+pCAKNGFLj5FyC28ldLCueb/9DoEaY0VCm6q/tJ+
	9SLL/UDj0DChR20mjFxyJAzD6Zb3eJJ76wFDo3J9vEhKh2e+9sbbvu+mZ9QSJw==
Date: Thu, 23 Oct 2025 10:35:28 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251023103528.0c969be8@kmaincent-XPS-13-7390>
In-Reply-To: <ac505a82-1a01-4c1d-8f9b-826133a07ecf@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
	<20251017182358.42f76387@kernel.org>
	<d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
	<20251020180309.5e283d90@kernel.org>
	<911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
	<20251021160221.4021a302@kernel.org>
	<ac505a82-1a01-4c1d-8f9b-826133a07ecf@bootlin.com>
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

On Thu, 23 Oct 2025 10:29:26 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> On 22/10/2025 01:02, Jakub Kicinski wrote:
> > On Tue, 21 Oct 2025 10:02:01 +0200 Maxime Chevallier wrote: =20
> >> Let me know if you need more clarifications on this =20
> >=20
> > The explanation was excellent, thank you. I wonder why it's designed
> > in such an odd way, instead of just having current_time with some
> > extra/fractional bits not visible in the timestamp. Sigh.
> >=20
> > In any case, I don't feel strongly but it definitely seems to me like
> > the crucial distinction here is not the precision of the timestamp but
> > whether the user intends to dial the frequency. =20
>=20
> Yes indeed. I don't have a clear view on wether this is something unique
> to stmmac or if this is common enough to justify using the tsconfig API.
>=20
> As we discuss this, I would tend to think devlink is the way, as this
> all boils down to how this particular HW works. Moreover, if we use a
> dedicated hwprov qualifier, where do we make it sit in the current
> hierarchy (precise > approx) that's used for the TS source selection ?

That's ok to me. I was not strongly against devlink in either way, and I di=
dn't
have real arguments. Let's go for devlink, we still can move it to tsconfig=
 API
later if it's needed.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

