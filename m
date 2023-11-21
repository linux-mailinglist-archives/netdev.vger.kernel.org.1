Return-Path: <netdev+bounces-49694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9767F31BA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91342282F35
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44738537F9;
	Tue, 21 Nov 2023 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hU4JPsdt"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E012C;
	Tue, 21 Nov 2023 06:56:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC6211BF211;
	Tue, 21 Nov 2023 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700578613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khxP4fXOUOIWA699Z/Zj5Syc66Lt+5ABqJOlzJsvRtk=;
	b=hU4JPsdtnkyQxT0F1F4Q5i4r1EhdISiflUXXD+Zw5eUJr8WZIcQW19HeeaLH7/1JzDSjJ/
	uYVtkf7/wrGLZEgPF3tsHEGkkY0oJUg99DV5oTPUKiAe1jBE6C2JbprD0TrXJnquTnbsQb
	s6HBH5N/JeJ3Zf/JTqrKTbESTrtS/b3mlxmslNlvYglR6iOjgZuEdCM4cXX2Cn5359gzYD
	BOLNGRlsvLYpfKbjSqtw3tAovnZxcIEpJrkwtjQeFA7M3i5umBvrKepydR9WMRKzke9d3n
	j3b7NlNBxg/ZztRAjckYV9zWXd4Pr8LTyVXwPfDcSj9HAT0ODMcMSVYmyf0ooA==
Date: Tue, 21 Nov 2023 15:56:50 +0100
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
Message-ID: <20231121155650.5c0d2f82@kmaincent-XPS-13-7390>
In-Reply-To: <44cbe9d3-dbd2-438c-b413-af525426781a@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
	<04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
	<20231120110944.66938859@kmaincent-XPS-13-7390>
	<20231120111008.GC590719@pengutronix.de>
	<2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
	<20231121110215.07f61e55@kmaincent-XPS-13-7390>
	<44cbe9d3-dbd2-438c-b413-af525426781a@lunn.ch>
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

On Tue, 21 Nov 2023 15:19:19 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > However, everything not PoDL PSE seems to be clause 33. So how about:
> > >=20
> > > 	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > 	enum ethtool_c33_pse_admin_state c33_admin_control; =20
> > >=20
> > > At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> > > are visible to userspace, but if we don't have a better name, maybe we
> > > have to use c33 in userspace as well.
> > >=20
> > > I do think naming like this makes it clear we are talking about two
> > > parallel technologies, not a generic layer and then extensions for
> > > podl.
> > >=20
> > > What do you think? =20
> >=20
> > If we decide to add a prefix, "c33" is precise but less easily
> > understandable, why not using simply "poe" prefix? =20
>=20
> I suspect poe has the exact opposite problem, its too imprecise. Its
> too much of a marketing name, with no clear meaning. It could even be
> some people call podl poe.
>=20
> To some extent, this is a user space UX problem. We can be precises in
> the kernel and the kAPI. What ethtool decides to show to the user
> could be different. Although it basically is the same problem.

Alright, thanks for your answer.

> Do you have ethtool patches? What does the output look like?  Oleksij
> did say a hybrid could be possible, so we probably want ethtool to
> group these properties together and make it clear what is PoDL and
> !PoDL.

No I don't, I am only using ynl for now.
I would be similar to podl:
https://kernel.googlesource.com/pub/scm/network/ethtool/ethtool/+/e6cc6807f=
87c74d4e5b1f1e9d21d3a74e75a258b/netlink/pse-pd.c

Duplicating the PoDL part with c33. Using the same --set-pse and --show-pse
options.

> > Maybe as POE were originally PMDI you prefer to use c33 which won't cha=
nge
> > over time?=20
> >=20
> > Should I also modify the content of the enum?
> > ETHTOOL_PSE_ADMIN_STATE_* to ETHTOOL_C33_PSE_ADMIN_*
> > ETHTOOL_PSE_PW_D_STATUS_* to ETHTOOL_C33_PSE_PW_D_STATUS_* =20
>=20
> Yes. That will help avoid getting PODL and C33 properties missed up.

Alright.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

