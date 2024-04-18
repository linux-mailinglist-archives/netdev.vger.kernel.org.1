Return-Path: <netdev+bounces-89071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D548A95B8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1305B281616
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5D15AD91;
	Thu, 18 Apr 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="DBcujdt5";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="l2VrDT16"
X-Original-To: netdev@vger.kernel.org
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0415AAD5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431540; cv=none; b=mBkEDr/Xq3KcBrzMfFfZ0af4YhewSCowfeEBe0ItCP0c7P2LM2gNQS8/TZkTDfO1zvk39gvA38278cHEi7kNfW/RMLVt2mSYCr+x1iEq7R8e00lG4utDKEnkURRJea+CVbAzP4dqsM2F5FJK6s5yQwu62atBGmgil06IjvcxZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431540; c=relaxed/simple;
	bh=1653cXZwkdY1XGP9TZy+tiKha1dxQmkE1Ob1WqnIEbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE+WMvX46gzj7q7VZnw2U+SsmVpSg/+jAt8po5Q8jWDcSCghIbohKgIzOd5+bzfDK3PB5zo8+851K8t/BBPW36Vto6UHv6E81DGo9D5Rs+ZWW9qAU3fxwmQw7ntErgpEKdIJiNMLkleF05mXazjiaX+lCsYxuSR5upJBm8TfnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=DBcujdt5; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=l2VrDT16; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxNoR-wSS1uD-0s;
	Thu, 18 Apr 2024 09:12:11 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 18 Apr 2024 11:12:09 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/1] dt-bindings: net: snps,dwmac: remove tx-sched-sp property
Date: Thu, 18 Apr 2024 11:11:48 +0200
Message-Id: <20240418091148.1968155-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418091148.1968155-1-f.suligoi@asem.it>
References: <20240418091148.1968155-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2024 09:12:09.0335 (UTC) FILETIME=[7DC61870:01DA9170]
X-smtpcorp-track: 1rxNoRwSS1ID0s.mDequQBFaHlff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713431532; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=dIA5kz04Cu10qs9gImcSljfbfip11thLhvuLyaEhzfU=;
 b=DBcujdt5AJFlVDHiI5oDeFKkdmnM0uHmOp/ygUnJt/02g1Mho5KSuWsuAnu4weac5qf3h
 aGmIru3Pm6jyHUv55uMOKbysxlqJrReES95c+iy8cx6BzOjXny4RD6BcgYURi3jS1/ootK0
 C9GTO9ygWxgr5Y5HkpiAtOYTYviaI4mZzkqVOO3qFnL5SvzHstpNSmVfQAQ7ZUKns3wK1VR
 7TBV0fzkr2BlXYNS8pgUGxXjbhmKVZpu0FwCLspQFPFVdmcV+9CxawjM3vpuqNICKCkCEYQ
 hVKlXV2v2Pl6XhHE8ukBP90sUrALua9VBzEhaN3iwMRkqQj7rVaLYD72p8yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713431532; h=from : subject : to
 : message-id : date; bh=dIA5kz04Cu10qs9gImcSljfbfip11thLhvuLyaEhzfU=;
 b=l2VrDT169Aujq/fnwUHVhU0ZW/fL8fuGDVaeqrINCCfsCu8SRekvxvncSk1vC/T9x7A5G
 SDoaf+Z1GuYYNSD59NkhEp+TNC7SxxL3BViYom2NgyP69YuPtLLE57GvC4UV7t+MXBJDNwI
 hv/8VV0AcOyvJmCZnpt1zTNM0UbLxQW2N1jg+Ed2GGNOCvLuNNZ79DLjljO/hv5kEfx6x31
 rf+qkU6teG5yMjXHyFGkNWZQVnbnh1HpF9lOJrD1AKrHxQ7abhMMRbfY74bxfIENmmvKOE/
 Z6ePU6+3rsJ20je9LlkoQgi3p0TaBqbDyn/mXWOaMVR/dQILd9+qZf8S0e2w==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

This property is still in use in the following DT (and it will be removed
in a separate patch series):

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in the DTs above,
since, as seen above, it is a default property of the driver.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 15073627c53a..21cc27e75f50 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -328,9 +328,6 @@ properties:
       snps,tx-sched-dwrr:
         type: boolean
         description: Deficit Weighted Round Robin
-      snps,tx-sched-sp:
-        type: boolean
-        description: Strict priority
     allOf:
       - if:
           required:
@@ -339,7 +336,6 @@ properties:
           properties:
             snps,tx-sched-wfq: false
             snps,tx-sched-dwrr: false
-            snps,tx-sched-sp: false
       - if:
           required:
             - snps,tx-sched-wfq
@@ -347,7 +343,6 @@ properties:
           properties:
             snps,tx-sched-wrr: false
             snps,tx-sched-dwrr: false
-            snps,tx-sched-sp: false
       - if:
           required:
             - snps,tx-sched-dwrr
@@ -355,15 +350,6 @@ properties:
           properties:
             snps,tx-sched-wrr: false
             snps,tx-sched-wfq: false
-            snps,tx-sched-sp: false
-      - if:
-          required:
-            - snps,tx-sched-sp
-        then:
-          properties:
-            snps,tx-sched-wrr: false
-            snps,tx-sched-wfq: false
-            snps,tx-sched-dwrr: false
     patternProperties:
       "^queue[0-9]$":
         description: Each subnode represents a queue.
-- 
2.34.1


