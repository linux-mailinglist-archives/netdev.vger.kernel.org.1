Return-Path: <netdev+bounces-33492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC679E308
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB13B2819AC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C061DDD2;
	Wed, 13 Sep 2023 09:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF61DDD1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:10:33 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC51999;
	Wed, 13 Sep 2023 02:10:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D9AL7o122479;
	Wed, 13 Sep 2023 04:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694596221;
	bh=jbpQk+sIiCpU67p3JLXuIRgoFuzXmgtvS7MIJu39eyg=;
	h=From:To:CC:Subject:Date;
	b=SuuJTAmGW39J3xbQjwrOoK0s17+MEcBeTgb0iZpi/AWHvcGuiqDxWxSVmdBDVQtAK
	 ZUqiLcfxR0ctAsqQBpF4sI9AXvPK8CBylecpiGugizIXTzw/RjQE19E9mKPokDAg9r
	 ebcXK0g9VDNKnjW1eUL2wm98fRNkgiVsmAALvFRk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D9ALGD025826
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Sep 2023 04:10:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 04:10:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 04:10:21 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D9AKMd074627;
	Wed, 13 Sep 2023 04:10:20 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38D9AK8Z022758;
	Wed, 13 Sep 2023 04:10:20 -0500
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
Subject: [PATCH net-next v3 0/2] Add Half Duplex support for ICSSG Driver
Date: Wed, 13 Sep 2023 14:40:09 +0530
Message-ID: <20230913091011.2808202-1-danishanwar@ti.com>
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

This series addresses comments on [v2]. This series is based on the latest
net-next/main. This series has no dependency.

Changes from v1 to v2:
*) Changed the description of "ti,half-duplex-capable" property as asked
   by Rob and Andrew to avoid confusion between capable and enable.

Changes from v1 to v2:
*) Dropped the RFC tag.
*) Added RB tags of Andrew and Roger.

[v1] https://lore.kernel.org/all/20230830113134.1226970-1-danishanwar@ti.com/
[v2] https://lore.kernel.org/all/20230911060200.2164771-1-danishanwar@ti.com/

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

-- 
2.34.1


