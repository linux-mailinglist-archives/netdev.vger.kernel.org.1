Return-Path: <netdev+bounces-32750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EFB79A2F7
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 07:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E317D1C20490
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 05:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE84820EB;
	Mon, 11 Sep 2023 05:43:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D323B3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 05:43:42 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605B1BE;
	Sun, 10 Sep 2023 22:43:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B5hQ2D023693;
	Mon, 11 Sep 2023 00:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694411006;
	bh=B51VOmOeJHKIx5df/yHDfVC4Gmr+c6KUiMfF5KWFi6M=;
	h=From:To:CC:Subject:Date;
	b=V+a9JhfNco6ShCWRYz47JsF6wxN45aSPAcDbEg96VnttIjjlk8axTa0GJV5/CB8+u
	 /3YcAo2o8k9z2saV0iMo+A1rSayY1Kfz3s7NyT/UK5zW1B6G0DIEOojlcHvFuyFBZ8
	 feiggDIIsOCYs55h7FT/Dpx0Lv4CIDD3eeBIRiFA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B5hQKI122218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Sep 2023 00:43:26 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 00:43:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 00:43:25 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B5hPok022747;
	Mon, 11 Sep 2023 00:43:25 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38B5hOO7024302;
	Mon, 11 Sep 2023 00:43:25 -0500
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
Subject: [PATCH net-next v2 0/2] Add support for ICSSG on AM64x EVM
Date: Mon, 11 Sep 2023 11:13:06 +0530
Message-ID: <20230911054308.2163076-1-danishanwar@ti.com>
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

This series adds support for ICSSG driver on AM64x EVM.

First patch of the series adds compatible for AM64x EVM in icssg-prueth
dt binding. Second patch adds support for AM64x compatible in the ICSSG 
driver.

This series addresses comments on [v1] (which was posted as RFC).
This series is based on the latest net-next/main. This series has no
dependency.

Changes from v1 to v2:
*) Made the compatible list in patch 1 alphanumerically ordered as asked
   by Krzysztof.
*) Dropped the RFC tag.
*) Added RB tags of Andrew and Roger.

[v1] https://lore.kernel.org/all/20230830113724.1228624-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (2):
  dt-bindings: net: Add compatible for AM64x in ICSSG
  net: ti: icssg-prueth: Add AM64x icssg support

 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c               | 5 +++++
 2 files changed, 6 insertions(+)


base-commit: 73be7fb14e83d24383f840a22f24d3ed222ca319
-- 
2.34.1


