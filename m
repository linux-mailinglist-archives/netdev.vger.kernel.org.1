Return-Path: <netdev+bounces-131213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290D98D3AC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A70B20AF7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD841CFEDB;
	Wed,  2 Oct 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/ewBtJx"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D21CFED3;
	Wed,  2 Oct 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873587; cv=none; b=AEYCIiv8PXpYzR47YF6vsQQi0ByawTi01Er7r5XSQyzQYptTis7rnj6jheKP5vJ9M4+Xq48DG0UIIrzXcusg4rqA6cbXNPsEoRArrPjh5CWNCQkAGIIUbdJYsQi7st2DRfcGipjC707h6TXUjLjE4lA+dwgJpNcz3fZ8lZaH8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873587; c=relaxed/simple;
	bh=+hbVNBS/hdGx0HFhj+lZ6IipxKC72LYaFWn16QZUFno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5Nnf8wQz02ntLuBJWuY0oM/pnEDuxM3pP/bzoQtRc2azxNzdEAWa96z0FKo4JJ0prvF/n+fZKI0pDguC8vDk0b0Sjruk9p+JMn+i0afymd5ZdOpqzFLW+7GxtADjTXbLbv+2URwcut+RdZphGpQ0iNvNJYNfHi1+sWhvFXqq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/ewBtJx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8A851BF20A;
	Wed,  2 Oct 2024 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727873583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndm+X916tI+KIyPE2tnP9f1DvP/nZaaAQIIeYXzzKzA=;
	b=B/ewBtJxK4a98S9OQ6FQ1J9MRogMAVhBmGWQ6q8R3UTFpl7Uw/c1vufTh61oWX9I/lcs21
	8uucSN0BrsakVDAOJVdaPRquxzniB9wGduuK+4qijebz2E6YL4eqSc8MVfZX4APrwQJHVe
	bpphvi1w37iWUIQkAmJmvvAg0gTG0N8i+TrD1LtgM27sQkAJfzy7bHeDII+eIwAJEqfNiL
	1DzX3VkHAZ/L3uTAAjnkhE1f4s8oTQX0246VVh/xvkM2cTB/8+5tAKI+RnlOsP6fo9uxUq
	+4Ei/LypGb5zHRwFPRD7Ree3S1YbsVput1w6GHv8viP+k2QkFr7C7+HG9t+1ew==
Date: Wed, 2 Oct 2024 14:53:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002145302.701e74d8@kmaincent-XPS-13-7390>
In-Reply-To: <20241002052732.1c0b37eb@kernel.org>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
	<20241002052431.77df5c0c@kernel.org>
	<20241002052732.1c0b37eb@kernel.org>
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

On Wed, 2 Oct 2024 05:27:32 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 2 Oct 2024 05:24:31 -0700 Jakub Kicinski wrote:
> > On Wed,  2 Oct 2024 12:23:40 +0200 Kory Maincent wrote: =20
> > > In the case of 4-pair PoE, this led to incorrect enabled and
> > > delivering status values.   =20
> >=20
> > Could you elaborate? The patch looks like a noop I must be missing some
> > key aspect.. =20
>=20
> Reading the discussion on v1 it seems you're doing this to be safe,
> because there was a problem with x &=3D val & MASK; elsewhere.
> If that's the case, please resend to net-next and make it clear it's
> not a fix.

Indeed it fixes this issue.
Why do you prefer to have it on net-next instead of a net? We agreed with
Oleksij that it's where it should land. Do we have missed something?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

