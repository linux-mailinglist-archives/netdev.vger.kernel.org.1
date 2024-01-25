Return-Path: <netdev+bounces-65997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821683CD3C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57891F22731
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA5136651;
	Thu, 25 Jan 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="twBKf6FR"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381279C7
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213769; cv=none; b=E8+Jb8eNlQAHz5PDtpGAI3WVrE4xg3+b9zUTqqmJR04BVLTqrKV9sEUu3lcVJcGahxke5LgO8r6uvGinpvymlq6bgIDjTZwVUfrfvzeXCzLogTaLu3x6L1qf1HUVCDes1WLWhPnL2xRdSwAO1/M/4aA6pqTZxALlTqNflj9EhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213769; c=relaxed/simple;
	bh=4RdZ9J5MXeKwf7WAlNoAVVtnVU/ieNbokDNNyvedFJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTys4lV0gxlIOqhAVtqVZBbN/oBeijjjBGmtNDI6/n8uN5jhB2sPyLQ5RDPReB1w7bM6wUSDNj8N3PQXvTr4hdDWQpHBQmgaS/7cUv1dg8GYqRfWEr5Q6A46lesYfv5PaTCXE7sy6hIWKO4QiX8bVyEVkSSF1h1mC/SC5bwKHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=twBKf6FR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706213757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z5A/5SzMwbcDNCjVJW8fzQYGvVC3KmAKUTtcphn+Ajo=;
	b=twBKf6FRp7Qo75xTuJgYaK8U9Rqrq+WSdkAgOQ4tZxTwvk8sB1dppedF0lVVQZuBPOMUKR
	zNLIX8bn8n1+Ve5uJzaKscoUZq6KpXjRBDsVh1rcT5U4oZJr6fV8FAZmuh5NWLrWMiCbDH
	mDQdvswh5ljyhJGFHp8i37VTA6aG7z6nvpGH7DbpXJSdDCgHG1K+jWhX6w128kneLDqqXZ
	OyUYBlrlrBdq1CJjdlcP4pAOga7cKDLdoG6/cz2hygC953DX9P0JEV0NFxJ8Ddjrk4iD5l
	3ORT5cL9e5k+mQLa38mUTpaWTBXAHcdvx+1ncIoJsqRjfnUC1EofLeIyosqVTA==
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH net-next] dt-bindings: nfc: ti,trf7970a: fix usage example
Date: Thu, 25 Jan 2024 21:15:05 +0100
Message-ID: <20240125201505.1117039-1-t.schramm@manjaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org

The TRF7970A is a SPI device, not I2C.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 9cc236ec42f2..d0332eb76ad2 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -73,7 +73,7 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    i2c {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.43.0


