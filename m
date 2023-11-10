Return-Path: <netdev+bounces-47020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9284E7E7A3B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07765281556
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF86FD8;
	Fri, 10 Nov 2023 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w3ddfsMw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98446CA44
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:42:35 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE61A260;
	Fri, 10 Nov 2023 00:42:34 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AA8gVvC093208;
	Fri, 10 Nov 2023 02:42:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699605751;
	bh=GDDIgQqEdMJ8Qp1iKhCS90P+3gCsxxxX61Dh7aFZiuI=;
	h=From:To:CC:Subject:Date;
	b=w3ddfsMw3c44I+40SFTi1b+37uTMgjT4C96YGDAZCwk/AMhMvUG9xj0Djtl7Z+3FH
	 F7WPyYI3MvILS+IunGo7vrcY8rePocXx0H2MZrLZlb2AW1kWZELVJU4A6qwvgqaY6o
	 hRf1LRtG5xOp3cx7+qvOIRP5wRwo5cuXUUhXZ0Hg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AA8gVWQ038635
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Nov 2023 02:42:31 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 02:42:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 02:42:30 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AA8gRt6097273;
	Fri, 10 Nov 2023 02:42:28 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <netdev@vger.kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <nm@ti.com>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>
Subject: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
Date: Fri, 10 Nov 2023 14:12:27 +0530
Message-ID: <20231110084227.2616-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Grygorii is no longer associated with TI and messages addressed to
him bounce.

Add Siddharth and myself as reviewers.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b151710e8c5..bd52c33bca02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
 F:	drivers/counter/ti-eqep.c
 
 TI ETHERNET SWITCH DRIVER (CPSW)
-R:	Grygorii Strashko <grygorii.strashko@ti.com>
+R:	Siddharth Vadapalli <s-vadapalli@ti.com>
+R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.17.1


