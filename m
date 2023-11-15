Return-Path: <netdev+bounces-47042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD37E7AD0
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700822817DA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE4125A4;
	Fri, 10 Nov 2023 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wg4lb0nM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601812E42
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:27:56 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73512BE39;
	Fri, 10 Nov 2023 01:27:55 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9RqtS007745;
	Fri, 10 Nov 2023 03:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699608472;
	bh=BLiCtDU8nsdSlSYXr+3R3b3TK6oRBbRtfnrRbMla3fQ=;
	h=From:To:CC:Subject:Date;
	b=wg4lb0nM28xuVFrj7xZbsG+0ulGees5j9LtTlUXzsOLNq/re+764g8EUYZaetn0X1
	 WjqduiTMzPHqW18sn6CUfnQGZ8DKCwokL+YsV4bKBKgW8S4dMeUHNyJHiKQGK9AFQ0
	 jJvv6orpPe63CS2BLXhlOm0k9XHEYCK7Mk+CGg4Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AA9Rqfm006658
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Nov 2023 03:27:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 03:27:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 03:27:52 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9RnX8016335;
	Fri, 10 Nov 2023 03:27:50 -0600
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <netdev@vger.kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <nm@ti.com>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>
Subject: [PATCH v2] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
Date: Fri, 10 Nov 2023 14:57:49 +0530
Message-ID: <20231110092749.3618-1-r-gunasekaran@ti.com>
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

Add Siddharth, Roger and myself as reviewers.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v1:
--------------
* Added Roger as reviewer upon on his request

v1: https://lore.kernel.org/all/20231110084227.2616-1-r-gunasekaran@ti.com/

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b151710e8c5..1466699fbaaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21775,7 +21775,9 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
 F:	drivers/counter/ti-eqep.c
 
 TI ETHERNET SWITCH DRIVER (CPSW)
-R:	Grygorii Strashko <grygorii.strashko@ti.com>
+R:	Siddharth Vadapalli <s-vadapalli@ti.com>
+R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
+R:	Roger Quadros <rogerq@kernel.org>
 L:	linux-omap@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.17.1


