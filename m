Return-Path: <netdev+bounces-34509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E57A46F9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171A32814E1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F11CA81;
	Mon, 18 Sep 2023 10:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10451C6AF;
	Mon, 18 Sep 2023 10:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E3C433C8;
	Mon, 18 Sep 2023 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033001;
	bh=dP81EaTqhJtwTW8QQL5omQ9zy1uxWNFhA04z1xr2m9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSxFvkipJ+e3AVlxQrb1J7DTWqqGv0wiS/fsdtvpcKV91ONrCPU4pMqd1ZdHyzURL
	 AVIvYAOmK3LGidLT9+7PopqSZUdXA0dVMjl4T5Ma5IImVPxrpnS5bAoXhs29NF3zDV
	 6sTbKqCHQ1azqzassG0isC6sDbAt8WjPx/wiIkbP6GH0PGLJMyDgeYRXX2mWF3ozKO
	 OEQWmP3D7YPA4WO8yrl211E4fW7qcuDPT4n8cGYoqJyvRqs4rIPqksKHWP+BpkRcgT
	 Puz8CS/H6L7g8z/2bezRjQGhzD6NCKnjzCSZMp8PJ6Su9RzgZ9RkxDgEKvrf5G5A3y
	 bUyXyd1nImiRg==
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
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 02/17] dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
Date: Mon, 18 Sep 2023 12:29:04 +0200
Message-ID: <db678ef631a69ed962a6d2f8d9bd0bcbcdcd1b9f.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MT7988 SoC compatibility string in mtk_wed binding.

Acked-by: Rob Herring <robh@kernel.org>
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


