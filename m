Return-Path: <netdev+bounces-33854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139F7A0795
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070D61C20A05
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44728E35;
	Thu, 14 Sep 2023 14:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC610A02;
	Thu, 14 Sep 2023 14:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970ACC433C8;
	Thu, 14 Sep 2023 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702351;
	bh=Ruv2x+AxMFAY05kafZgsuUzxSPVlmNqIubkGcvMlyRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2mIIobFDMOV9kqkWSqIuMkSForVh87qtJy+dmi4OvVWHItJzjLVrslEw5lR6OA6+
	 vLtwuG3P+4DzjoOPSy4a8TuifLGVT6vWK+AWRG/Ze8tMSx+QsSZ/LIJOStrAzLRBJL
	 yBZ4reqmEMV+s9q9gTdNOBMUYgKw6WZKgc8SO/opE7SJxnStc4TXMnmmMqULgFKT7G
	 GqjuqTvM07lfr/QBqOwq7XkSQZLqZ723dzzt9wevmznKkPj/Q/7WRgM4wMvkfr/YYo
	 1tDw2jWsLZPLLmfPqJcDt1UcH+2E1NRsBLmoS5mpUShgWDWmMjRTNgejERYwi2CtXf
	 zLOSvB1seaB6g==
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
Subject: [PATCH net-next 01/15] dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
Date: Thu, 14 Sep 2023 16:38:06 +0200
Message-ID: <148f4f9ff2ec891955f9e9292aff9595f07beded.1694701767.git.lorenzo@kernel.org>
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

Introduce MT7988 SoC compatibility string in mt7986-wo-ccif binding.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
index f0fa92b04b32..3b212f26abc5 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt7986-wo-ccif.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - mediatek,mt7986-wo-ccif
+          - mediatek,mt7988-wo-ccif
       - const: syscon
 
   reg:
-- 
2.41.0


