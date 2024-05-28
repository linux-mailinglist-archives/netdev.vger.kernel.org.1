Return-Path: <netdev+bounces-98480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CB8D18DA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E671F23BCF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212D16B743;
	Tue, 28 May 2024 10:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D613AD3E;
	Tue, 28 May 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893088; cv=none; b=iItB8HgYaarEV1fYwhEuMmRGb07LQM2ijGbs38YCSTwyJ0UmD6a4rqa/aGMTgxVg62D3Lt47JqzhPfxoNAiYglx4VptjT2/9+ytWGWMbvm3RCWkckO2GTTQoC1mlgjcMG3p3zEsTGJYUZ3A4HIVZpPzeyyBdv3+gEJv5W7feofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893088; c=relaxed/simple;
	bh=e728tqOYfNxh4S7HCwxH83gK9m0vcyqIePqt4ju4Srk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJDQKc6VqwszPa4O5JQcduAo9HfQLpq6tMBHMN77X0OJdKMMh1aPDElIEV0y+U5JcNwZScnHek1qEQCck4ZOaqvScQFQyN6Y27pmVC4Ix2Q1vPBKfgeoY6A+lNsrKWq6Jd+7itu4TqvZGTk/okCjzH32gDw9upOHS5twGv6Wdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c07:2740:1619:be25:bafb:489])
	by smtp.qiye.163.com (Hmail) with ESMTPA id D48C27E01CA;
	Tue, 28 May 2024 18:26:08 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Tue, 28 May 2024 18:26:03 +0800
Message-Id: <20240528102603.1016587-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxgaVkJLSh1KGkJJSUJKQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kWGg8SFR0UWU
	FZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8fbebc664503a2kunmd48c27e01ca
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Txw5KjNLIQ5LTA8NQwM2
	STcwCg5VSlVKTEpNQ0JKQk1CTkhNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kIAVlBSkNJTzcG

The rfkill-gpio driver supports setting two optional gpio:
"reset-gpios" and "shutdown-gpios".
The "reset-gpios" property is missing, so document it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 9630c8466fac..d01cefef6115 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -29,6 +29,9 @@ properties:
       - wlan
       - wwan
 
+  reset-gpios:
+    maxItems: 1
+
   shutdown-gpios:
     maxItems: 1
 
-- 
2.25.1


