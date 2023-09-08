Return-Path: <netdev+bounces-32588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BF7988C0
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70BB281CE6
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8A5385;
	Fri,  8 Sep 2023 14:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1D156EC
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 14:30:23 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C11FE1;
	Fri,  8 Sep 2023 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694183420; x=1725719420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KHR8Qc7/5doglix8W9O2Ns4ouxyrUJKNX4AIFv8kWLY=;
  b=ab+4PIvAr91Hp4S8u4kH/m8e94fkIp/hSiD6ekfZKuvzHh8+tKfGpFDK
   pwxtLAf5K7qjTacizyq5QPQ/nY0191oOdsi8NXU3yYcjdrHrOZmkn8dBo
   PNwe2MkLK0E9Ydby21zsD/Ev92Fjlw5A5LpYtuOvKdpnqwbgzdrb+Lt4E
   HEwdhgACfGVoWcDOH66LmSywXhykT0naKQaUoBi0Y+3G8aj+KFF+ik0Zu
   4m2U9gmtx8+095+D+s7akMUGDGfgHD1dRTHejA8oD3O6hJF1z1pJUS0Pr
   RAcAYTLcPW9nbO4/j+X7Wz+RnS80d20U/9w+YUv8kUKz/Qm7wja5B71uj
   w==;
X-CSE-ConnectionGUID: asNxVD5cQQC9XPoqMIkXxg==
X-CSE-MsgGUID: j/lDpi6ASPmAIXsdJCS8dA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="3643518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 07:30:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 07:29:53 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 07:29:45 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
	<steen.hegelund@microchip.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
	<casper.casan@gmail.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface
Date: Fri, 8 Sep 2023 19:59:13 +0530
Message-ID: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series contain the below updates,
- Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
  net/ethernet/oa_tc6.c.
- Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
  Ethernet driver in the net/ethernet/microchip/lan865x.c.

Parthiban Veerasooran (6):
  net: ethernet: implement OPEN Alliance control transaction interface
  net: ethernet: add mac-phy interrupt support with reset complete
    handling
  net: ethernet: implement OA TC6 configuration function
  net: ethernet: implement data transaction interface
  microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
  microchip: lan865x: add device-tree support for Microchip's LAN865X
    MACPHY

 .../bindings/net/microchip,lan865x.yaml       |  54 ++
 Documentation/networking/oa-tc6-framework.rst | 231 +++++
 MAINTAINERS                                   |  15 +
 drivers/net/ethernet/microchip/Kconfig        |  10 +
 drivers/net/ethernet/microchip/Makefile       |   3 +
 drivers/net/ethernet/microchip/lan865x.c      | 589 +++++++++++++
 drivers/net/ethernet/oa_tc6.c                 | 807 ++++++++++++++++++
 include/linux/oa_tc6.h                        | 130 +++
 8 files changed, 1839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/microchip/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h

-- 
2.34.1


