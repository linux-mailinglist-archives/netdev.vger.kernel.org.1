Return-Path: <netdev+bounces-32755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A379A33A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DB72810C3
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF623C6;
	Mon, 11 Sep 2023 06:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A223C0
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 06:03:23 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3874B1BE;
	Sun, 10 Sep 2023 23:02:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B629cH000420;
	Mon, 11 Sep 2023 01:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694412129;
	bh=9ATVOVPWJwJ8fvU0+Op5VStbUwr5g7KLMfdJN1X3w/Q=;
	h=From:To:CC:Subject:Date;
	b=AfJ6yI00hfHsA2gv4azcAW/7xHdOYxNHDkT9umOj4k9s2fLGYnQeX3/BBJnz6rQ7a
	 QVZdh4YFI+y0ZGDr6H9Jt9Jv14lfeB2mCDqVl+yfxsxNT0d4UDzv9pqcQ0SI8JcoRd
	 oo5R5HnBkA2/WVo/pXe0nEGg3osF4TZtTSlprq0w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B629jr010613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Sep 2023 01:02:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 01:02:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 01:02:09 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B629fO016131;
	Mon, 11 Sep 2023 01:02:09 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38B628UP000503;
	Mon, 11 Sep 2023 01:02:08 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        MD Danish
 Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman
	<horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH net-next v2 0/2] Add Half Duplex support for ICSSG Driver
Date: Mon, 11 Sep 2023 11:31:58 +0530
Message-ID: <20230911060200.2164771-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds support for half duplex operation for ICSSG driver.

In order to support half-duplex operation at 10M and 100M link speeds, the
PHY collision detection signal (COL) should be routed to ICSSG GPIO pin
(PRGx_PRU0/1_GPI10) so that firmware can detect collision signal and apply
the CSMA/CD algorithm applicable for half duplex operation. A DT property,
"ti,half-duplex-capable" is introduced for this purpose in the first patch
of the series. If board has PHY COL pin conencted to PRGx_PRU1_GPIO10,
this DT property can be added to eth node of ICSSG, MII port to support
half duplex operation at that port.

Second patch of the series configures driver to support half-duplex
operation if the DT property "ti,half-duplex-capable" is enabled.

This series addresses comments on [v1] (which was posted as RFC).
This series is based on the latest net-next/main. This series has no
dependency.

Changes from v1 to v2:
*) Dropped the RFC tag.
*) Added RB tags of Andrew and Roger.

[1] https://lore.kernel.org/all/20230830113134.1226970-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (2):
  dt-bindings: net: Add documentation for Half duplex support.
  net: ti: icssg-prueth: Add support for half duplex operation

 .../bindings/net/ti,icssg-prueth.yaml           |  7 +++++++
 drivers/net/ethernet/ti/icssg/icssg_config.c    | 14 ++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c    | 17 +++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h    |  2 ++
 4 files changed, 38 insertions(+), 2 deletions(-)


base-commit: 73be7fb14e83d24383f840a22f24d3ed222ca319
-- 
2.34.1


