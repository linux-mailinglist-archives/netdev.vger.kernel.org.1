Return-Path: <netdev+bounces-177508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F92A7065C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE501897D1A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860F25D1E2;
	Tue, 25 Mar 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aq0uJpy6"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201743169;
	Tue, 25 Mar 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919144; cv=none; b=fFsapxDpJ2PB+0Epwk2Ctt50whCUBGCbkBrD2pr8vjHKes/q17zlLvuNARfDExks/cMqzHWLH77bLcwpJjVdN+sW8F6mk/v9F68fiHdFQ7FVLZ6RXBGZxpHdEOOd1ivFg/cki00RRhcR0lSfcN+BpW+THf6LckwaKHGcF/MgHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919144; c=relaxed/simple;
	bh=+KdiDrFiarGEbf3kb9HlXSM9P6HlZDF5FlBfLt0MCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHZGXrRhjRLcoSGWkCmqYqn+vJS+RiTbMqEBl0AH0Vj7umEjzbTrgND+DPsxaAyvsXtEv/XW/ILda9RIxqys5VK899F+BPenbCR5fQn++YABbLpB/3re2FeBl2cyvnFbbmbzcLtKHi7DdR2msEYC44JzFCz3j8wpbedzn79fJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aq0uJpy6; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 564B5102F66E4;
	Tue, 25 Mar 2025 17:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742919139; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OCuZIdUEm0QWQuqdvQk8bF8aibatk8qGzYP76myy1Xo=;
	b=aq0uJpy6Wp06yKfxV/hPNUiV24cd6mrnOWV4CE+8kfJBqN4oGmgoSUAcXMxOFAu5K8uoPq
	aOOJI7VMVVHpQssTy9rh+Zxg+zWIJfrKhPErtAqbMYR1HxyWQ1fYv1i8SJbbOPP+jtWK+I
	2w1/G0d9pKzC7lrHR+odcAgZqSkBD+uDrQnr9cIejI7sLvvN8PfA7/+HwmHP0ss0U5amVA
	9uM1StWAo9+ovfCtq9IGG68B3G38MB40YR5IWv+mWqBtE7QZ/JEyCyuG80xA88fZyRURoC
	scOhKT7Y5tgY+UlS0wn/6+bOVsFLoHR69E+bSx8QssbDMQUuBu3c/Mc/ZHJ3iQ==
Date: Tue, 25 Mar 2025 17:12:13 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
Message-ID: <20250325171213.61de8d6b@wsk>
In-Reply-To: <2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-3-lukma@denx.de>
	<2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BTpJUUNgSsmMxe6X4ageVFE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/BTpJUUNgSsmMxe6X4ageVFE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +  phy-reset-gpios:
> > +    deprecated: true
> > +    description:
> > +      Should specify the gpio for phy reset. =20
>=20
> It seem odd that a new binding has deprecated properties. Maybe add a
> comment in the commit message as to why they are there. I assume this
> is because you are re-using part of the FEC code as is, and it
> implements them?

+1

>=20
> 	   Andrew
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/BTpJUUNgSsmMxe6X4ageVFE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfi1d0ACgkQAR8vZIA0
zr2V+gf+JAQoDZbvVcOrU8Xf5yrlKENSX8KVhYJexfgs+qiD+wvn+CS8kUCphBCk
rDQbqUh8g3qjogX3/PH1NWqIlXvz7EO55+P39PQExyszRX3HpW7ibOaTWMgnnWa4
Ik2qLNREr7mWs83euMDjk21zx0+SacLsJ9I8A0k60wY720aUaxwAFm7p/uhTIvTo
TdCeHqeaKWV/2ui8a2fnR5TNaM9LuCF2a+xxbv9OiqYdHlPVLQyFMtm7AZ4RWT+A
AGnhGvNGIX87TACwdl5FRb85sSxbUbd2jLMzT04w268IgsXKhqMRmXyAxmktKSMx
Z4U/nFhivYUqaXt05MM8Id9eAZ20/g==
=vard
-----END PGP SIGNATURE-----

--Sig_/BTpJUUNgSsmMxe6X4ageVFE--

