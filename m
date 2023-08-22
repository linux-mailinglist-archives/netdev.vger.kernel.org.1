Return-Path: <netdev+bounces-29589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777C783EB3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF411C20ACB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32011C90;
	Tue, 22 Aug 2023 11:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9999472
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:28:14 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA198CD1;
	Tue, 22 Aug 2023 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692703693; x=1724239693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zy+oNUnTax/2/pEu8NMMXhkiT6EE1L1FvMZzPOAdESU=;
  b=BSlOARM642jhazFoceCL9TjAzy6VAmYpTvDYumrJ2Q4yYvIi4yVoA9vH
   70OYgMuKaXEzJsSxoZ+Gnm79S9XT5yfG1oi8hUyb/PSuEErPJSy0Bx0xs
   JYTJ8vYsA3B6FOfRQUFnq7hfsLm6xVnxix7yp6ztZPlcy5PlklhYbSxue
   2K9yvuSTDtA1MGJEc2oHn492LnCHukCsRuEd1iLfwrYCRLJi5FxnOClTF
   x2v5jKOzbhF6/hRm2k45wpuopm63vodR8pmVUSE4NPzvB7fOcCrxvQHxS
   Y9ErmVV7j/0gShupMIYNiL7i9w2j0S4zsQI0ZMKnR37bQoH/PdasdocHD
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684792800"; 
   d="scan'208";a="32561792"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Aug 2023 13:28:10 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D857280075;
	Tue, 22 Aug 2023 13:28:10 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: net: microchip: Allow nvmem-cell usage
Date: Tue, 22 Aug 2023 13:28:10 +0200
Message-ID: <4855037.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <169263807888.1978386.16316859459152478945.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com> <20230810144451.1459985-5-alexander.stein@ew.tq-group.com> <169263807888.1978386.16316859459152478945.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Am Montag, 21. August 2023, 19:14:39 CEST schrieb Rob Herring:
> On Thu, 10 Aug 2023 16:44:49 +0200, Alexander Stein wrote:
> > MAC address can be provided by a nvmem-cell, thus allow referencing a
> > source for the address. Fixes the warning:
> > arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: ethernet@1: 'nvmem-cell-name=
s',
> >=20
> >  'nvmem-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
> >  From schema: Documentation/devicetree/bindings/net/microchip,lan95xx.y=
aml
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks. But while reading your comment on patch 3, I'm wondering if=20
additionalProperties should be changed to unevaluatedProperties here as wel=
l.
This way local-mac-address and mac-address canbe removed as well, they are=
=20
defined in ethernet-controller.yaml already.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



