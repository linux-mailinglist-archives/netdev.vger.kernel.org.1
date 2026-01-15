Return-Path: <netdev+bounces-250156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F82D2457E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A68FA30010D9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896D3793AF;
	Thu, 15 Jan 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FW2hr4f2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4F34D911
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478307; cv=none; b=Jur3HnfzqqMFoAGzbOHD5YhvdCH1Swfl74ji8zrTUR6qRi4tyLX52dfmardR2zqfjVhTQYAAxa4AatA7WFQQwQ1mnM5AIK2+DPxC8fLNGdMLkny3i8n+4uAoD1BDzSLiriZUVSGRWRfmqyUTj51oIiq3nLDLbfi8gUAn+meMF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478307; c=relaxed/simple;
	bh=14bOHJ1JcFL4fF0W+8b6eUUmHribqN5/rmNWb8qZKoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zh5WdRKtBHGG+aUP9yiYWbKdZisuG61o3V99hdJJ3WEFKhWsWXSZLspIxKh30L04knyOWCtHfd9Brn3uqGJ5bDgQxq9fxTW4yuDwvHDv012drK7KRuKUVxeH/9J2XAvIrsdNNInAiSIztyZWzNwwy1hA54cehBnzZbit6T1o4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FW2hr4f2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 785C01A2877;
	Thu, 15 Jan 2026 11:58:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47A66606B6;
	Thu, 15 Jan 2026 11:58:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B1DC10B685A9;
	Thu, 15 Jan 2026 12:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768478301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=14bOHJ1JcFL4fF0W+8b6eUUmHribqN5/rmNWb8qZKoA=;
	b=FW2hr4f2npkZbF0uTZiv+DDJzI2bxtf5RzhbHLznFJdLXKh6kphgFuzwftHhHkPEr4gvy9
	zzgLoTrsLfonV1z7hZ7Iag6YSw9DSmg4rfhy4EhYtAh7r+0Qt2BqUMASzK7chjl/O7noFX
	pDG5gjWO7cLcVpiTwpl1qG2TFho33fOmpYj2nNQF1MoESqwRtogY3cgvBt4F9a4daZMeLG
	Nmyr8L/3PWCA2CB8UFPMOjWyC2nkcPgz7+srjzxZ+CbEORkXGMkXsZXEityIsKSkktH9us
	sr1yFer3L50OSDiSaAgIwr6qtKuAbq3XEDryjDdf7vBpV70bbLRIb8ptAUlhDQ==
Date: Thu, 15 Jan 2026 12:58:15 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: remove legacy way to get/set HW
 timestamp config
Message-ID: <20260115125815.299accc6@kmaincent-XPS-13-7390>
In-Reply-To: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
References: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
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

On Wed, 14 Jan 2026 22:44:13 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> With all drivers converted to use ndo_hwstamp callbacks the legacy way
> can be removed, marking ioctl interface as deprecated.

Thanks for all this work converting drivers to ndo_hwtstamp!

Maybe you can also remove this:
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/ulp/ip=
oib/ipoib_main.c#L1834

And in the driver development part of the documentation to avoid any new dr=
iver
with it:
https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/networking/=
timestamping.rst#L630

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

