Return-Path: <netdev+bounces-229585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DBBDE8DA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69DAA500752
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23972F5A01;
	Wed, 15 Oct 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CsKF6TcA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED541632C8;
	Wed, 15 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532931; cv=none; b=GEfnnNCFkNOYwVPjwSfxHn59q3rmOttZYowslBYkN9PYB0IEpG36Rglrm81uhDLx/4AZiabfZ/2Iq2c4KBldHotZAwNRWl2BLgzDXJOj3X5R3u2rOPFCMlS5SmJhIoa4PjWCXTcQSnxQySPDQNcCkpwcSvKbMWOfzhRvesTFh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532931; c=relaxed/simple;
	bh=NyCDOZrVB//07BPd6+GXYHFSqEEcVLNlH+OBjCmleEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdKhKhmhKpbUmr5bUnR91MDavYSUJcm+HckBuhrEP/Qw6ZAwpZX+VWYKEfq7pa6TvAeYcAUvTQbxNVxbD2QaUFx90gEsUTxAM90H4jDFhfukcBJEIH3JbIP8MWS4uRzhOuhK7BdOf8ZgTr9dW20V+ZlM14Mpt3tPLt4s+st46Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CsKF6TcA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4967D1A13D8;
	Wed, 15 Oct 2025 12:55:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DD15606F9;
	Wed, 15 Oct 2025 12:55:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B304102F22CE;
	Wed, 15 Oct 2025 14:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760532926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NyCDOZrVB//07BPd6+GXYHFSqEEcVLNlH+OBjCmleEs=;
	b=CsKF6TcAWd5LfvC7ftYlRfzRDPv4j5akgSTQ45lu65C1SVhGdY9r2HNWLqTrnEUvIMvL9u
	8lPLP7bQzTuztsBusuz4954KALlHGlmex6RSYSLvK36KQrJcNmzQDqeRcVct/NL1F5RKvs
	nBrBEQbvpQ44bMOixhIiGNdsRh1QhAjfK7YiYTfPIkIrJUERSKaOvc/PBP8zsnEJRVnpdK
	psbdGr56bEveRnQsfaU3yXP2mMxcKpBL8wkQSSt6RTheJ3mo789W89lSSZjJ7mNxRRcvOu
	Oqf34+rAbXBUUpaLEH7OjF7VG1Azeq2I8FLFeYZ5wryPje6OYDJL0L01S+0UYg==
Date: Wed, 15 Oct 2025 14:55:19 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: stmmac: Add support for coarse
 timestamping
Message-ID: <20251015145519.280b6263@kmaincent-XPS-13-7390>
In-Reply-To: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
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

On Wed, 15 Oct 2025 12:27:20 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello everyone,
>=20
> This is another attempt to support the fine vs coarse timestamping modes
> in stmmac.
>=20
> This mode allows trading off PTP clock frequency adjustment precision
> versus timestamping precision.
>=20
> In coarse mode, we lose the ability to fine-tune the PTP clock
> frequency, but get better timestamping precision instead. This is
> especially useful when acting as a PTP Grand Master, where the PTP clock
> in sync'd to a high-precision GPS clock through PPS inputs.
>=20
> This has been submitted before as a dedicated ioctl() back in 2020 [1].
> Since then, we now have a better representation of timestamp providers
> with a dedicated qualifier (approx vs precise).
>=20
> This series attempts to map these new qualifiers to stmmac's
> timestamping modes, see patch 2 for details.
>=20
> The main drawback IMO is that the qualifiers don't map very well to our
> timestamping modes, as the "approx" qualifier actually maps to stmmac's
> "coars" mode, but we actually gain in timestamping precision (while
> losing frequency precision).

https://elixir.bootlin.com/linux/v6.17.1/source/include/uapi/linux/net_tsta=
mp.h#L16
"approx" was initially added for DMA timestamp point.
Maybe we should add a new enum value here with a more suitable name.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

