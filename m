Return-Path: <netdev+bounces-30909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB2789CA0
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6401C20985
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2B5665;
	Sun, 27 Aug 2023 09:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90A612E
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 09:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0200C433D9;
	Sun, 27 Aug 2023 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693128544;
	bh=3H/C787IUUTONRgCHUAFunTHHLv9u+5ZpTBnpCOyCHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYKmeQgbEOQh8IKiqgQjAimBbboRM9Qxfu+NAuYNdwv+ig/vI2jwQ5Zc0Hb91OAKm
	 yYIL06xUZp92dTRw8WqVlc0uDele9Nxdxq4eUXjhA9gMvqF0CewLSdBBy+OoBhpX72
	 Vdx7evBjHKVyPXtoabWrPbq3rafGctKwQd+rFl/QuHJ+b4IRpVicq3PscxIRN4OL75
	 4e7bHWcf4QgEz8Zat1wSHU8Q9dSZewA0KaugWGNT+dPNM6m9+G1Gy0RehOHpMv1pPF
	 q3DfKfEcXPQj+nc84IWeLO1SaIHLW84K2qW8wMshHBGgKiPJosBO4IRb4unenXUx+h
	 XgaeZOYPQN0rQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
	Coquelin@web.codeaurora.org, Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
Date: Sun, 27 Aug 2023 17:17:08 +0800
Message-Id: <20230827091710.1483-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827091710.1483-1-jszhang@kernel.org>
References: <20230827091710.1483-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snps dwmac 3.70a also supports setting pbl related properties, such as
"snps,pbl", "snps,txpbl", "snps,rxpbl" and "snps,no-pbl-x8".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..b196c5de2061 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -586,6 +586,7 @@ allOf:
               - qcom,sa8775p-ethqos
               - qcom,sc8280xp-ethqos
               - snps,dwmac-3.50a
+              - snps,dwmac-3.70a
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
               - snps,dwmac-5.20
-- 
2.40.1


