Return-Path: <netdev+bounces-54435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF38070FD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42031C20A11
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151D39FEB;
	Wed,  6 Dec 2023 13:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05789C7;
	Wed,  6 Dec 2023 05:38:12 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rAs5y-00060R-13;
	Wed, 06 Dec 2023 13:37:47 +0000
Date: Wed, 6 Dec 2023 13:37:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [RFC PATCH v2 5/8] net: pcs: add driver for MediaTek USXGMII PCS
Message-ID: <ZXB5J5zO6IeTCy3b@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
 <3cd8af5e44554c2db2d7898494ee813967206bd9.1701826319.git.daniel@makrotopia.org>
 <20231206133403.GA1894508-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206133403.GA1894508-robh@kernel.org>

On Wed, Dec 06, 2023 at 07:34:03AM -0600, Rob Herring wrote:
> On Wed, Dec 06, 2023 at 01:44:38AM +0000, Daniel Golle wrote:
> > Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> > USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
> > Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
> > create a wrapped PCS taking care of the components shared between the
> > new USXGMII PCS and the legacy LynxI PCS.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../bindings/net/pcs/mediatek,usxgmii.yaml    |  46 +-
> 
> Why are you changing the binding you just added?

Oh, that change slipped into the wrong commit by accident, sorry about
that, I will fix it in the next iteration.

> 
> In any case, bindings are separate patches.
> 
> >  MAINTAINERS                                   |   2 +
> >  drivers/net/pcs/Kconfig                       |  11 +
> >  drivers/net/pcs/Makefile                      |   1 +
> >  drivers/net/pcs/pcs-mtk-usxgmii.c             | 413 ++++++++++++++++++
> >  include/linux/pcs/pcs-mtk-usxgmii.h           |  26 ++
> >  6 files changed, 456 insertions(+), 43 deletions(-)
> >  create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
> >  create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

