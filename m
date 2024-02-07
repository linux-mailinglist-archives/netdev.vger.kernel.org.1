Return-Path: <netdev+bounces-69776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048984C885
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18BB1C24E9A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AA25571;
	Wed,  7 Feb 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iGHYtPcn"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2320DCF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301363; cv=none; b=k/whPliHh2QLW9V64j9Hp/3t0o/U5X8OjErK2CqRY5GXt+niL7srXcnS8+F/hFPGmtuGUKMRzf4bFJKFQLDy1v8O23g2XvrlQRVRi9ISYu2lJUWZ8GFA1yz3l0izFgRw1AG3eXZapE0ZV1qa4Vzl2dG1jgUQiN4yOohFiSpsyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301363; c=relaxed/simple;
	bh=UrCEdE2RKwippZQRH5gNyXV5Y7JV344lQyXLn41khhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH2ppc3eryqYXAi05otb4Xw2Iq7B+jr6h5Opdvd6WrbOAHq3twGLEubypHDc5S1i12U7vpUNe5GmbNXdwQ+T48e09f6DbzPsLbBkWexGuyvqvcNis1SBYtVGT/KYCRaB59YoQfAhglidLNUqPdNaLIIloYar1yx2r1K1ic/pFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iGHYtPcn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0F1E6000C;
	Wed,  7 Feb 2024 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707301353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kw7T8Vrms6nIk+zbJmIsnSNdRSFsOuj6MWR+pEJ0wY=;
	b=iGHYtPcnvD9MLOsbUVRJ+5wdaB70q2n4E8a9ISTIZgRubxtwxQi/eCzmf0spioTC2JIhnJ
	ijer+f6KARnF9YowBRBOk9lFTt7wElMCjQm8mYQGcxprOW0nWsjH3CtU/jQXniiyT54Pah
	aHn5pPtvxNGTlD1xq/RTlqUMHehK427GEX1G1T06KQn33CjqUdrwBqDTPXAM6SumIBHniz
	rM8HZZwdqfsWx4Bn/E85Hy4CzDdBzqAioeKDxa81PaYVws16vzLXGbqC4byiIfhdnj8DwS
	CztLx8CxScmdExk1eB7sSiW59HUIysp3rnmSonV4X7/WtGJ9gwmU0z/x2LDNJA==
Date: Wed, 7 Feb 2024 11:22:31 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240207112231.2d555d3e@kmaincent-XPS-13-7390>
In-Reply-To: <BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 6 Feb 2024 18:30:33 +0000
Elad Nachman <enachman@marvell.com> wrote:

> Sorry, that's not how this works.
>=20
> The firmware CPU loader will only reload if the firmware crashed or exit.
>=20
> Hence, insmod on the host side will fail, as the firmware side loader is =
not
> waiting For the host to send a new firmware, but first for the existing
> firmware to exit.

With the current implementation we can't rmmod/insmod the driver.
Also, in case of deferring probe the same problem appears and the driver wi=
ll
never probe. I don't think this is a good behavior.

Isn't it possible to verify that the firmware has already been sent and is
working well at the probe time? Then we wouldn't try to flash it.

Or stop the firmware at remove time and in case of probe defer.
=20
> By design, the way to load new firmware is by resetting both CPUs (this
> should be covered by CPLD).

Are you saying the only way to stop the firmware is to shutdown the CPU?
As ask above, can't we know if the firmware has already been load?

> Can you please explain:
>=20
> 1. What kind of HW / board are you trying this on?
> 2. Who is the customer requesting  this?
> 3. What is the design purpose of this change?

I have no particular request for that.
I was debugging a PoE controller driver that the prestera was depending on,=
 I
was playing with these in a module state to verify the kref free.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

