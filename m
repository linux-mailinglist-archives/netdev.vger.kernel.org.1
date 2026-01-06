Return-Path: <netdev+bounces-247425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0553CFA42E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C43132DA34D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B2366577;
	Tue,  6 Jan 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qSJdaJpA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BC36657D
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722083; cv=none; b=o++PyQYFw9uq0WQeocj4vDI3dud/tGAHWjNIJAGigJLarXjFkhV8s1ERfN6ntG8395OY3MybBzHyEhGNNSDTpTE2qITuGuGUm76WKwI9e+lC4Q/X6xLRJmrQsRcYfyfBMytfTf+HvYoS6s9kh4S818OWsMnX3lsPASBwbCR8Eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722083; c=relaxed/simple;
	bh=Vi6eMOHqUflJf+yDJcRrDwfOT5w3edGMWPaLQFX+kc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tr7iAqLslKJdWTpFlPz2UsuI2GBDmvERmCO3APfnWE8mzrksgB4/XlqbEyi8JZ75u5agM1I4Fnsq2RSUyauIvuuKOj4yH3RxV/7oSur8rdSQKDJuCvups+EamkVU0tIXMgD034PzA6tdV5NCihzjcRF+JHvb6CWXY5pQ5HzwT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qSJdaJpA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12F8B1A26A6;
	Tue,  6 Jan 2026 17:54:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2B7960739;
	Tue,  6 Jan 2026 17:54:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDCE5103C80A9;
	Tue,  6 Jan 2026 18:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767722077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2ElzZugsBSoaESz+H/NavZAykvuMLbFqdBNVzKVU2+w=;
	b=qSJdaJpAmR6c3G5bguqVRzJrdGqhC/nsXL+Dh6ymFQtY8lHSsx6Rxlba5u007BIWaOB1v8
	ltL9I2FtCd0MAtLt8IGFHw7oXGCTuGGrfuCfKsd1k4+aToyoIE3v+OKS80JYpOujxclqro
	vkVP05Fg4V6oQ9pCvvhX+Nb+6o4GE5WAk0gSw6HHmkXbXIUCREFWkFxOiVYpVBRAuw13Hm
	xR68ZDW5uHrsTnsvpi/bNqHWMs0ENs1ZFtbQ+WGHyaxDVXxd1nj0bYXsIA4tN5hFYsW/o4
	qvzXCDBXtj30dMa0V6jHXTjWE4UpqkeMkFtZBfnqPt6l238t5wN09l0+Dz91wA==
Date: Tue, 6 Jan 2026 18:54:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: phy: micrel: improve HW
 timestamping config logic
Message-ID: <20260106185432.62086ff9@kmaincent-XPS-13-7390>
In-Reply-To: <20260106160723.3925872-2-vadim.fedorenko@linux.dev>
References: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
	<20260106160723.3925872-2-vadim.fedorenko@linux.dev>
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

On Tue,  6 Jan 2026 16:07:20 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver was adjusting stored values independently of what was
> actually supported and configured. Improve logic to store values
> once all checks are passing
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

