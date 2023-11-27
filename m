Return-Path: <netdev+bounces-51390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44E7FA7F0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BECC1C20ADE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C762F381B2;
	Mon, 27 Nov 2023 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nF/gRJ8x"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA085;
	Mon, 27 Nov 2023 09:28:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4FC14000B;
	Mon, 27 Nov 2023 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701106101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgRUTwLXcNd58EG84hnaXaWLqxXMccudnE3zQ48EYVQ=;
	b=nF/gRJ8xfx+oSU3Q8tKHoRZUEPdMORtKkZXe1y9wvSBw1LzUXyhzdMd5avFCzZ6iaSZTzh
	ygc0xDl00VLDGTbWbG1KcXy06Iutu8rta3w9rAU+rXz4piOf8BXP0hGyEHjgjOyjmhA1GF
	6O8IJKtjly+NQEmAwu3BpvxS2eqbh68CSdriYdPRAh7aEuj2pG4NUbv44RtfAZAt/qBzPj
	oQ1Ml6uEn44cMzzyEIWj2acon53DwEflAJU7sKnLoBnZAPg7L3SHUmXyrzKu5PM3sSzGa9
	7GXGLwAoxlF+Z62ykJgSjmfRN23UTP/cRg8QvZgN0HMNZusvH6N617R1QRttWQ==
Date: Mon, 27 Nov 2023 18:28:19 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231127182819.11ee98d2@kmaincent-XPS-13-7390>
In-Reply-To: <cde6c19f-01ba-4f6c-9e73-00e4789fb69c@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
	<45694d77-bcf8-4377-9aa0-046796de8d74@lunn.ch>
	<20231122174828.7625d7f4@kmaincent-XPS-13-7390>
	<cde6c19f-01ba-4f6c-9e73-00e4789fb69c@lunn.ch>
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

On Wed, 22 Nov 2023 18:11:25 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Is the firmware in Motorola SREC format? I thought the kernel had a
> > > helper for that, but a quick search did not find it. So maybe i'm
> > > remembering wrongly. But it seems silly for every driver to implement
> > > an SREC parser. =20
> >=20
> > Oh, I didn't know this format. =20
>=20
> Its often used in small deeply embedded systems. Microcontrollers,
> rather than something which can run Linux.
>=20
> > The firmware seems indeed to match this format
> > specification.
> > I found two reference of this Firmware format in the kernel:
> > https://elixir.bootlin.com/linux/v6.5.7/source/sound/soc/codecs/zl38060=
.c#L178
> > https://elixir.bootlin.com/linux/v6.5.7/source/drivers/staging/wlan-ng/=
prism2fw.c
> > =20
>=20
> Ah, all inside a header file. Probably why i missed it. But ihex is
> not SREC. ihex came from Intel. SREC from Motorola.
>=20
> So i would follow the basic flow in include/linux/ihex.h, add an
> include/linux/srec.h but adapt it for SREC.

In fact the ihex.h header is only adding the ihex_validate_fw and the
request_ihex_firmware functions. In my case I do not use request firmware b=
ut
sysfs firmware loader. I could add srec_validate_fw but I am already
checking the firmware during the flashing process due to its special flashi=
ng
process.
I could not treat the firmware to one blob to be send. Each byte need to be
send in one i2c messages and at the end of eaxch line we need to wait a "\r=
\n"
(within 30ms) before sending next line. Yes, it takes time to be flashed!

Do you see generic helper that I could add?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

