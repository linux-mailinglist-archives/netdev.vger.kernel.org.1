Return-Path: <netdev+bounces-33855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C47A079E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DC11C20B6B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951A101E6;
	Thu, 14 Sep 2023 14:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0E18E03;
	Thu, 14 Sep 2023 14:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9260BC433CB;
	Thu, 14 Sep 2023 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702354;
	bh=EsVzeIyCHOXl6PgzNuGZeoWesA2vqyz58aq8GZxby6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6EL81IoUl36SYq+3PUnwJ8BDPeUGtghxPazqu3ODXRMQzzxs76wGqeEqdU/AjZz4
	 E9OE3ESf6j9F13Ke14qmcyFMAzAvhPgNfp2CDhNLMqqby+sc2MXmUOpabwDt3AUwco
	 yqehV3docffvWnldk82A4RD2vLMbAFjwdFH98jnnsByzVYWW7uKi1sadmU+Syx/sZA
	 Tlby2fqiIw5qMp6fmsQI+WYZQ91qrgiFGEdCdd73FvWjbgEEYufT4qci+Frljb4HVh
	 iF5GbKJoqCEf9MLk/OKqnLvrO/FeT+AZHboHKotYaWulrIGgE0sQ57cxzVpZTmowUa
	 VekFCZi3eyJLw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 02/15] dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
Date: Thu, 14 Sep 2023 16:38:07 +0200
Message-ID: <9b84b6b9641a2eebc91e763e2ba9a341e3de1071.1694701767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694701767.git.lorenzo@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MT7988 SoC compatibility string in mtk_wed binding.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
index 28ded09d72e3..e7720caf31b3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7622-wed
           - mediatek,mt7981-wed
           - mediatek,mt7986-wed
+          - mediatek,mt7988-wed
       - const: syscon
 
   reg:
-- 
2.41.0


