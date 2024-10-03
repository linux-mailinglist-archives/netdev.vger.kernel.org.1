Return-Path: <netdev+bounces-131515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40998EB94
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B91828370F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227C13A87E;
	Thu,  3 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W2UTYVa7"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0ED126C04;
	Thu,  3 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944159; cv=none; b=dbPqooU2mcMRDg1rYGDdv89efb5tOhnD8Bsvb3PDTGYhlq+X2ctyqoKqz8r65MXEFEmuBachhhBSTUzKB9+73ZFbt2fGXG6eGn3kho5mJ66DYGw9JkTOC2jDS8OUqZHigjl9SD12jqZKglbtaK906lSU/oisG2pHuXRhRVHE2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944159; c=relaxed/simple;
	bh=uJlzMmeXXB0U8NB0bXtRaVCFr7dvtXe5EGe4Q/vvwR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/IixORQbiC2MK4jsreVpoQpgYNYPQKOmy6/37opez0o6KdLJ/wPDx5vcZEtvp/kKwYtpTuO6qa9Fg/iJKjFyEdFAeu87orwRP2V7hsXvb7/7jzdyxLlgmlC7QOhISJgRUPvuTiJMVMOQLybKnrOHim4mIQ1TX80qAziEXBRHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W2UTYVa7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15545240029;
	Thu,  3 Oct 2024 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJlzMmeXXB0U8NB0bXtRaVCFr7dvtXe5EGe4Q/vvwR0=;
	b=W2UTYVa7WX5cdiVbJGoLsmPE/EeRdk6oy6PNK0tixbBDXwgOK3pVL+1fUS0rIInvbjEF6v
	fP0dzT+/QFN6uC15ROpUhBmoWsQKgtBBeqpLXrqdE1HjB50vb84eFSTTu+El808axvEhv4
	edwFktuQ7kgNiYja45caMEXfkPgVBcCyzkcYqAhd0yPqbZzsL5O7eZKUKU13nYnlZwClz0
	F+OAA90panGWgWqR/nSniu2QOqqUHqbPh3vfOyDzM90ZuWkN+ylZ9hyKOy8YAuCwfBAG7e
	QeJ3uR3RWAxu+xJUAkQAvPU1CXzS/DtJR4iWqBkLUxs8r70PFaggjTC77Y8g0g==
Date: Thu, 3 Oct 2024 10:29:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <20241003102913.4e5ed2de@kmaincent-XPS-13-7390>
In-Reply-To: <c4b47aaa-3ae6-48cd-906f-cab8a74392ee@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
	<c4b47aaa-3ae6-48cd-906f-cab8a74392ee@lunn.ch>
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

On Thu, 3 Oct 2024 01:57:08 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > This patch also adds support for an OSS GPIO line to turn off all low
> > priority ports in case of an over-current event. =20
>=20
> Does this need a binding update? Or is the GPIO already listed?

Indeed and it is missing. Oops! /o\

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

