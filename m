Return-Path: <netdev+bounces-242919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F7C96611
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F674E03A8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BC3002B3;
	Mon,  1 Dec 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TkVEgGuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95A2C11C7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581335; cv=none; b=jmZYlzEmxuYs6amsHh+hqoHkvp6NQc0McwOAV2C3t8fgOYkP7O6CnWdfjCrpVIwoEu9gb+4u6HCtBKm+tV802T/DQzffB44PuQ3TngtUIQ7qia75CI77lJj1bhyBvIt/a42TKQ747KNvJo4THg1daMDy8rkX0W2GY/iYqoqzGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581335; c=relaxed/simple;
	bh=j46TXwnWzZWcyeKNk2DJgEMB+BiZE2IA/GOrAlZ0UtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApqmZyc3xDXc6o9b6e+PBWL0JhvLZmePqUW6jhyHn7Gl0gnroGeknkOJW9AonETPTKoczhjOQkDoEUbACexL32HkvBUTVFt6FFT2IM+GwqikhSouIn4wx+HzxPKXON/dobXda3zqJ48nJUwD7yYsBvwSEGcvjpcNwDvctPyS/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TkVEgGuu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C35971A1E77;
	Mon,  1 Dec 2025 09:28:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97FE7606BB;
	Mon,  1 Dec 2025 09:28:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 690D81191246E;
	Mon,  1 Dec 2025 10:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764581322; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j46TXwnWzZWcyeKNk2DJgEMB+BiZE2IA/GOrAlZ0UtI=;
	b=TkVEgGuuKUHGuZefoZeoVBBDJ4VkT+o8LCj2glmv8RZYtK7bKw67KOe7/WexcOzm+IqdSp
	N8i3Fop0MVzRCLt4cAbUo59MMuGtOB635oIxkJCgIYb6wwjxOTlh6iTYoXxUbmrX9EdGU0
	e/31/TR8OfxAmTRxEsjNfAwEn6tXikCOCNo5CHyAS+zYzPkPGG1uNdUi/s/NjcZkeR3vwW
	0NHF5wo4HaJuPWl6qLLSGxLKuNYcRJ7i97KFvN2lkFYccWN2zr+t2rMwNirY7qjP4qOYkG
	AIatx10cCawk/TGTMgNDRUeSFipqPyolzjR6LRGQWmut8fLltT7rsliPPygK4A==
Date: Mon, 1 Dec 2025 10:28:35 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: phy: micrel: add HW timestamp
 configuration reporting
Message-ID: <20251201102835.7a940ef2@kmaincent-XPS-13-7390>
In-Reply-To: <20251129195334.985464-3-vadim.fedorenko@linux.dev>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
	<20251129195334.985464-3-vadim.fedorenko@linux.dev>
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

On Sat, 29 Nov 2025 19:53:32 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

