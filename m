Return-Path: <netdev+bounces-29720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3978479F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B91281163
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232A11C2B7;
	Tue, 22 Aug 2023 16:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFC1DDE6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:31:39 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469F137;
	Tue, 22 Aug 2023 09:31:38 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qYUHk-0000G9-2m;
	Tue, 22 Aug 2023 16:31:17 +0000
Date: Tue, 22 Aug 2023 17:30:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 0/4] net: ethernet: mtk_eth_soc: improve support
 for MT7988
Message-ID: <cover.1692721443.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series fixes and completes commit 445eb6448ed3b ("net: ethernet:
mtk_eth_soc: add basic support for MT7988 SoC") and also adds support
for using the in-SoC SRAM to previous MT7986 and MT7981 SoCs.

Changes since v2:
 * fold changes to commit they were supposed to go into

Changes since v1:
 * SRAM is actual memory and doesn't require __iomem
 * Introduce stub ADDR64 operations on 32-bit platforms to avoid
   compiler warning

Daniel Golle (4):
  net: ethernet: mtk_eth_soc: fix register definitions for MT7988
  net: ethernet: mtk_eth_soc: add reset bits for MT7988
  net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
  net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 194 +++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  52 +++++-
 2 files changed, 196 insertions(+), 50 deletions(-)


base-commit: 691b2bf1494620ff8c292626e4967c57e5705a8b
-- 
2.41.0

