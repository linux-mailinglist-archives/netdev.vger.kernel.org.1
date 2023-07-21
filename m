Return-Path: <netdev+bounces-19734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817B75BE2E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C571C2161B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82703A4A;
	Fri, 21 Jul 2023 06:02:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0E20F0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:02:08 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF963588;
	Thu, 20 Jul 2023 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919289; x=1721455289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yk+GKdkW5U5snvMb+NeGU56kvNagCSdTg8e2+tMyRHg=;
  b=qcHXvIumodws6RG/baFs7kYB+ixmu9BCK0BKgyGJ2vIdL5GaayLBDYjp
   iSzT9ZiGA0hmj8c0HKtWhX75Y1Sw9Y2fsDxbDLCEBj/c2p18FG8sRvzbn
   jmf/qvBKu9ljzOSiRyEr5HlnbCnaNXqgK/aGR82Cq2qaJ4Yv1fuz/Ucg7
   0vS/qSfZNrLWWtcmKMFVJgw8Zjh4J4niYyxtNwz/IFeoCYbhu0YiUs0/F
   ViCWrBx23wYfxqFHL4dIIddV2wkxVJWHdHi9SuwrvSpApcmN3QfYMTaJV
   WceEf3lM2478XmG+vxKtvXFgaogoh2Ft6OBsjdmGSGrmgIRe/YhCjnJLY
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="236881611"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:01:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:01:11 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:01:08 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 0/2] Add support to Fiberstore SFP quirks
Date: Fri, 21 Jul 2023 11:30:55 +0530
Message-ID: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series adds support to Fiberstore(FS)'s SFP quirks for
 - 2.5G copper SFP (SFP-2.5G-T)
 - DAC10G SFP (SFPP-PC01)

Raju Lakkaraju (2):
  net: sfp: add quirk for FS's 2.5G copper SFP
  net: sfp: add quirk for FS's DAC10G SFP (SFPP-PC01)

 drivers/net/phy/sfp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.25.1


