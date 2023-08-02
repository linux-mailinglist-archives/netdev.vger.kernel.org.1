Return-Path: <netdev+bounces-23769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674876D789
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E381C20AF4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4810782;
	Wed,  2 Aug 2023 19:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C277101EC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:13:54 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5EEEC;
	Wed,  2 Aug 2023 12:13:52 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D65B1A1066;
	Wed,  2 Aug 2023 21:13:51 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DE1F1A105C;
	Wed,  2 Aug 2023 21:13:51 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
	by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D1AD0405DF;
	Wed,  2 Aug 2023 12:13:49 -0700 (MST)
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
Subject: [PATCH v4 0/2] fix at803x wol setting
Date: Wed,  2 Aug 2023 14:13:45 -0500
Message-Id: <20230802191347.6886-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v3:
  Break long lines
  Add back error checking of phy_read

v4:
  Disable WoL in 1588 register for AR8031 in probe

Li Yang (2):
  net: phy: at803x: fix the wol setting functions
  net: phy: at803x: remove set/get wol callbacks for AR8032

 drivers/net/phy/at803x.c | 47 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.25.1.377.g2d2118b


