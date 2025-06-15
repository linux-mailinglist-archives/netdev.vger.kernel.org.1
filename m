Return-Path: <netdev+bounces-197878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB8ADA231
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA91216DCA2
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD38633A;
	Sun, 15 Jun 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="rD/4WxGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738629A1;
	Sun, 15 Jun 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999832; cv=none; b=uF960+U6JUoOHRK35BXaWWgNE2H5hAwglDGZzKUl1rLfAqYtsmknyhUg3krNFZd15icPfmJi7FMc+jEZrptQDboXLsr+7bfRBjvJ6+v2VKwBpqFa6SNz0UR8bKFqyK3zF2g1TBcG+ZPKC6YapL0J5tg7J/qafJvRmFeNqT5D6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999832; c=relaxed/simple;
	bh=1mXX8LN1g+EmMlTpG2st0pc6s7pghy57appvz+tt4io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqhchDd+ZJe+3vZRfP5LFtq5nM7GNeVMDxwoNqpnnaMFnN48Tm2DNoAW9MvOb4RZQdVrh+b4mBr3VZeAFGTzwUK3OtaWEY+X/eenFcLelfYZe5gQ4wKWrByxDoE7CNGI9XXNy1ymg8SSFQl5upCh8UYvj/nak6lc4LxZ+3ZWASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=rD/4WxGJ; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id A183F1005F6;
	Sun, 15 Jun 2025 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749999828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dEj5v7dm6ltMlbxpUVJFd0IqvlQNf25lGrkWUdekOWc=;
	b=rD/4WxGJjG8Nxlm6Abii5nf4oHv828cFU2QyXiqmgQ/hN95IXcTjdthUNVp/LAF1jf2PCT
	/YVSeRpsfzGAAitOCJ0QDewA4ILE1uzqo45jI53r0tSv3wXU7E4iAnCtOT+Gdet9sg+fOG
	DCkY6FZFf68MckDhqCivbmhYjGW/rEg=
Received: from frank-u24.. (fttx-pool-217.61.157.124.bambit.de [217.61.157.124])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 57EDA1226A7;
	Sun, 15 Jun 2025 15:03:48 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v3 0/3] rework IRQ handling in mtk_eth_soc
Date: Sun, 15 Jun 2025 17:03:15 +0200
Message-ID: <20250615150333.166202-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series introduces named IRQs while keeping the index based way
for older dts.
Further it makes some cleanup like adding consts for index access and
avoids loading first IRQ which was not used on non SHARED_INT SoCs.

Frank Wunderlich (3):
  net: ethernet: mtk_eth_soc: support named IRQs
  net: ethernet: mtk_eth_soc: add consts for irq index
  net: ethernet: mtk_eth_soc: change code to skip first IRQ completely

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 56 ++++++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  5 ++
 2 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.43.0


