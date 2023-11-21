Return-Path: <netdev+bounces-49590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63C7F29A8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CD628119B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAF3C690;
	Tue, 21 Nov 2023 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="crT5w6He"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CF11A;
	Tue, 21 Nov 2023 02:02:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD4ACC000B;
	Tue, 21 Nov 2023 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700560938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKnahUa3X0OEYKLHF3ihgq745BsVV7IxE68JfJBRJ+c=;
	b=crT5w6HesfV/u6xGyERcYeNgZCgsabD1xFYjej/WUZ42D13pCT0TXWq4f5+ecD17lChEKW
	cAm7dkphnYA3l+kkOe8nRrOmzZfEr7Qwuf3Nu8WJtXvURbj8nlKG4EDIMbNP3En5myljqy
	/Is2eA8NsUUVc2MHiF+F4vLoMzU1LlStER3YnrbDv/y4tauA3eEk4cnH5p806gIFzG14Vv
	xyaX9XHZ8r9GQ34T2k7nGSkaQfwUpYkQLwXwdKOPzPG4zc00kYrfVCPO24a3ZQWXoAieLQ
	/fUmbVgbCuI/ajqo5djqrPPd+NmmthXZn+DFnpCd0gpLBkNBEFIiDBazustzxQ==
Date: Tue, 21 Nov 2023 11:02:15 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <20231121110215.07f61e55@kmaincent-XPS-13-7390>
In-Reply-To: <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
	<04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
	<20231120110944.66938859@kmaincent-XPS-13-7390>
	<20231120111008.GC590719@pengutronix.de>
	<2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
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

On Mon, 20 Nov 2023 19:00:03 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > Official name for "PoE" is "Power via Media Dependent Interface". PoE is
> > not used in the IEEE 802.3-2018. Using names not used in the specificat=
ion,
> > make development even harder :)
> > Especially since there are even more marketing names (names not used in=
 the
> > specification) for different PoE variants:
> > - 802.3af (802.3at Type 1), PoE
> > - 802.3at Type 2, PoE+
> > - 802.3bt Type 3, 4PPoE or PoE++
> > - 802.3bt Type 4, 4PPoE or PoE++ =20
>=20
> From the 2018 standard:
>=20
>   1.4.407 Power Sourcing Equipment (PSE): A DTE or midspan device that
>   provides the power to a single link section. PSEs are defined for
>   use with two different types of balanced twisted-pair PHYs. When
>   used with 2 or 4 pair balanced twisted-pair (BASE-T) PHYs, (see IEEE
>   Std 802.3, Clause 33), DTE powering is intended to provide a single
>   10BASE-T, 100BASE-TX, or 1000BASE-T device with a unified interface
>   for both the data it requires and the power to process these
>   data. When used with single balanced twisted-pair (BASE-T1) PHYs
>   (see IEEE Std 802.3, Clause 104), DTE powering is intended to
>   provide a single 100BASE-T1 or 1000BASE-T1 device with a unified
>   interface for both the data it requires and the power to process
>   these data. A PSE used with balanced single twisted-pair PHYs is
>   also referred to as a PoDL PSE.
>=20
> So it seems like, anything not PoDL PSE does not have a name :-(
>=20
> However, everything not PoDL PSE seems to be clause 33. So how about:
>=20
> 	enum ethtool_podl_pse_admin_state podl_admin_control;
> 	enum ethtool_c33_pse_admin_state c33_admin_control; =20
>=20
> At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> are visible to userspace, but if we don't have a better name, maybe we
> have to use c33 in userspace as well.
>=20
> I do think naming like this makes it clear we are talking about two
> parallel technologies, not a generic layer and then extensions for
> podl.
>=20
> What do you think?

If we decide to add a prefix, "c33" is precise but less easily understandab=
le,
why not using simply "poe" prefix?
Maybe as POE were originally PMDI you prefer to use c33 which won't change =
over
time?=20

Should I also modify the content of the enum?
ETHTOOL_PSE_ADMIN_STATE_* to ETHTOOL_C33_PSE_ADMIN_*
ETHTOOL_PSE_PW_D_STATUS_* to ETHTOOL_C33_PSE_PW_D_STATUS_*


--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

