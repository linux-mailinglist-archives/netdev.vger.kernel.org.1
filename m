Return-Path: <netdev+bounces-93105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD38BA0CA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE41F23110
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535F174EF4;
	Thu,  2 May 2024 18:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8FE16FF2B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676248; cv=none; b=NkAVaxFzu5tyPpUuoBmKKSgswBUE6XWsS1i3xBNbc/YfTb3dJyWwf7HKrcVsxdIygYrJtNiBJTkCJiURPNDGVyTJnDAKu4t7sSeCROy4V2Pn1p2C/QRxsgTfp4eM1bPiSXUODcOhIehxHblbR2VgK4DauUAv6l7QPW/3ci2d6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676248; c=relaxed/simple;
	bh=r3v1hsbCzzE0NijatEE6FEhxIbLw2bvmFXPGCPUr+GA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9D1wOWReKxuq/BWKmz1xsFEoK+zQJ1J8RCaTAXIs185ZYSo00w8NM+aM4iGMzCoyGsmg2hnCXez3NzaOP1LIMQE5Qysp++GaF8rHqur+RO7DNLnl7dPQgzGCU5NwD4sA0xGnbL7DQMx+tZJvlh1S9rti2nz8R//XbXH6eyHIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 442Ifjhw032568;
	Thu, 2 May 2024 11:41:46 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, bharat@chelsio.com, kuba@kernel.org, horms@kernel.org
Subject: [PATCH net] MAINTAINERS: update cxgb4 and cxgb3 network drivers maintainer
Date: Thu,  2 May 2024 14:42:09 -0400
Message-Id: <20240502184209.2723379-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself(Bharat) as maintainer for cxgb4 and cxgb3 network drivers.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 157135b470fa..362d91c16bf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5709,7 +5709,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/cxd2820r*
 
 CXGB3 ETHERNET DRIVER (CXGB3)
-M:	Raju Rangoju <rajur@chelsio.com>
+M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.chelsio.com
@@ -5730,7 +5730,7 @@ W:	http://www.chelsio.com
 F:	drivers/crypto/chelsio
 
 CXGB4 ETHERNET DRIVER (CXGB4)
-M:	Raju Rangoju <rajur@chelsio.com>
+M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.chelsio.com
@@ -5759,7 +5759,7 @@ F:	drivers/infiniband/hw/cxgb4/
 F:	include/uapi/rdma/cxgb4-abi.h
 
 CXGB4VF ETHERNET DRIVER (CXGB4VF)
-M:	Raju Rangoju <rajur@chelsio.com>
+M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.chelsio.com
-- 
2.39.1


