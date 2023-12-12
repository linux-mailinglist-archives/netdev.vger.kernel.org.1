Return-Path: <netdev+bounces-56526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6980F366
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EA628182D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7F7A223;
	Tue, 12 Dec 2023 16:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F39E3;
	Tue, 12 Dec 2023 08:43:14 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rD5qP-0006en-2c;
	Tue, 12 Dec 2023 16:42:55 +0000
Date: Tue, 12 Dec 2023 16:42:45 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Conor Dooley <conor@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 1/8] dt-bindings: phy:
 mediatek,xfi-pextp: add new bindings
Message-ID: <ZXiNhSYDbowUiNvy@makrotopia.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org>
 <20231212-renderer-strobe-2b46652cd6e7@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231212-renderer-strobe-2b46652cd6e7@spud>

On Tue, Dec 12, 2023 at 04:21:38PM +0000, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 03:46:26AM +0000, Daniel Golle wrote:
>=20
> > +  mediatek,usxgmii-performance-errata:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      USXGMII0 on MT7988 suffers from a performance problem in 10GBase=
-R
> > +      mode which needs a work-around in the driver. The work-around is
> > +      enabled using this flag.
>=20
> Why do you need a property for this if you know that it is present on
> the MT7988?

Because it is only present in one of the two SerDes channels.
Channel 0 needs the work-around, Channel 1 doesn't.

See also this commit in the vendor driver for reference[1].

We previously discussed that[2] and it was decided that a property
would be the prefered way to represent this as there aren't any other
per-instance differences which would justify another compatible.


[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/a500d94cd47e279015ce22947e1ce396a7516598%5E%21/#F0

[2]: https://patchwork.kernel.org/comment/25592845/

