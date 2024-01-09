Return-Path: <netdev+bounces-62706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DB828A3E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6991288311
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680A3A8E7;
	Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a20LX8RC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3B3A8E2
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCFEC43141;
	Tue,  9 Jan 2024 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818724;
	bh=rsbVW/Bl4c+FvBhvhr8wFlpil8bg3GSeHeoxa4mLOY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a20LX8RCjgH01wprB45AD7M38uO4R7MdgN2l2PpiKzxncWGVt0fdDaTuAZTQC2Dpj
	 gGA0TDl4Z771JEc6MyGu25QL4Z5wIU1i0Fme4eCRMVsM+0+zW+hk0xTKWnIvTl9oo3
	 eiC+I22ORgzymPqrdwqhgeKO3XPIkITYCc/WYcFLnYRFKUqw0mGzyjHjI4yZSpME/x
	 F6FbD6j0DbOev31WHMMBknydyiIB95SKOIwIU/Vt4zrAUrckwnOjfYZi7U10eBEyxw
	 xg6VqtK2GD06TwHoOd0IRL+TH0i54JYnohaygHsDqFcbbnL5ovbAU+6GyiTXLJs8tF
	 jE9OeBsEVLHrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
Date: Tue,  9 Jan 2024 08:45:13 -0800
Message-ID: <20240109164517.3063131-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thomas is still active in other bits of the kernel and beyond
but not as much on the Marvell Ethernet devices.
Our scripts report:

Subsystem MARVELL MVNETA ETHERNET DRIVER
  Changes 54 / 176 (30%)
  (No activity)
  Top reviewers:
    [12]: hawk@kernel.org
    [9]: toke@redhat.com
    [9]: john.fastabend@gmail.com
  INACTIVE MAINTAINER Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: thomas.petazzoni@bootlin.com
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 1c86d25dd131..18ce75d81234 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3038,6 +3038,10 @@ S: Demonstratsii 8-382
 S: Tula 300000
 S: Russia
 
+N: Thomas Petazzoni
+E: thomas.petazzoni@bootlin.com
+D: Driver for the Marvell Armada 370/XP network unit.
+
 N: Gordon Peters
 E: GordPeters@smarttech.com
 D: Isochronous receive for IEEE 1394 driver (OHCI module).
diff --git a/MAINTAINERS b/MAINTAINERS
index ee3fbf1723a6..cad08f4eca0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12830,9 +12830,8 @@ S:	Maintained
 F:	drivers/thermal/armada_thermal.c
 
 MARVELL MVNETA ETHERNET DRIVER
-M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/marvell/mvneta.*
 
 MARVELL MVPP2 ETHERNET DRIVER
-- 
2.43.0


