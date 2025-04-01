Return-Path: <netdev+bounces-178638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA2A7802C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44EC16EA03
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7E92144A6;
	Tue,  1 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bP6hYkDd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5B211A1E;
	Tue,  1 Apr 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524011; cv=none; b=W3Di/Rbp6X2tp92jWd+M/VgNfWAS4Ob9/x7ojHtgMczxYmUYKrrMeIS3OiyJ4wwSIiWv8UGIxjBLUr7JWa4oTHChWHBCJytK8hH1IZ8lkxyXOVzccL+HZe+58+i5MaN7pj8U880g7aCuKKhrZk4BKoYx9nnWc+gBfn4lyxAXOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524011; c=relaxed/simple;
	bh=gQHIFtd7jO6LKnDGPFxQ3YPgospqXdvc41+Z7wLtHwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8h/sd5GUbpy90aoxO8c7qy82zw/p/8B2BVoYbBkvSsrVajbj4NYb9wYuaPBcFYL81JPTph0wbA4iQr9nV53564JmLUtcZDzFSTFxk3O/CQw5cFYCt7Y6FTvaYwk8W9D017KdUNWWmAWlLuYpSr8SrjDdi7tCiCvRh+ZyNIQJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bP6hYkDd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524009; x=1775060009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQHIFtd7jO6LKnDGPFxQ3YPgospqXdvc41+Z7wLtHwo=;
  b=bP6hYkDds5oFhkhYQQDPBnZxcaM2o5UmV8sKy/Nn+e+cznDMpS7RGQut
   hlf59zsgbpMTGWH2onopbvHnpsI0WlC99rfFiZYTuHikFHW6lxUfWJDfu
   vrxjcBVvsOQd6SGezfMZggoZLWfTKxjhxK0BNDlQbD7nsws0k3dskMVa3
   0l+6yphjywfjoLENMaAjGoUn8yh/ZPxBeH7hCFga2uyCEV7jOVLePoDTI
   7Wmh4TvU8SXQwvI4+pbwgheeoZIvkLLUtbYHXe4rLfNUuYtXKc7ZXH6x8
   B7FUrTRlZnivq+JjhUt/2IMlIVMmojMbg/TRcMGt/9DM4+nCg8u4wUC/Q
   g==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: 2KMWCwVCQiOgIjwH19Ge9Q==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512776"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 1/6] dt-bindings: net: cdns,macb: add sama7d65 ethernet interface
Date: Tue, 1 Apr 2025 09:13:17 -0700
Message-ID: <392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743523114.git.Ryan.Wanner@microchip.com>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add documentation for sama7d65 ethernet interface.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 3c30dd23cd4e..eeb9b6592720 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -62,6 +62,7 @@ properties:
       - items:
           - enum:
               - microchip,sam9x7-gem     # Microchip SAM9X7 gigabit ethernet interface
+              - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
           - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
 
   reg:
-- 
2.43.0


