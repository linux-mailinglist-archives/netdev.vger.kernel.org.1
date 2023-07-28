Return-Path: <netdev+bounces-22439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD317677FA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383122826E0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28071FB39;
	Fri, 28 Jul 2023 21:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BD1FB28
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:59:01 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA32D5F;
	Fri, 28 Jul 2023 14:59:00 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7CD12000EC;
	Fri, 28 Jul 2023 23:53:33 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E4422000C8;
	Fri, 28 Jul 2023 23:53:33 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
	by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2FEF240553;
	Fri, 28 Jul 2023 14:53:32 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Bauer <mail@david-bauer.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 0/2] fix at803x wol setting
Date: Fri, 28 Jul 2023 16:53:18 -0500
Message-Id: <20230728215320.31801-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v3:
  Break long lines
  Add back error checking of phy_read

Li Yang (2):
  net: phy: at803x: fix the wol setting functions
  net: phy: at803x: remove set/get wol callbacks for AR8032

 drivers/net/phy/at803x.c | 42 +++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

-- 
2.25.1.377.g2d2118b


