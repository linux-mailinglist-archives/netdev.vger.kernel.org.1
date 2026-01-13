Return-Path: <netdev+bounces-249417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA72D1859F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BFB0302DDCE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882A39280C;
	Tue, 13 Jan 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FRRzpuZs"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B793921F5;
	Tue, 13 Jan 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302026; cv=none; b=j+I2yPp1ACZf2JXUirXrdeNkIcyJuQ0GG/5UQXJeGQmX2+YgPec43KX7nHh8MimkiKQvEVemzDsvu5CHXPl51nWNeRWQJSW++qR6D/RonVp4LcMKgPhc09k4HS5Wfn2jWbg7GAIZDkEuU0qVqE++BHcJagmTs4Ajif3e9m5seYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302026; c=relaxed/simple;
	bh=bptASkFhv+DFWmJaUioaR4+nnGLEW+O7QNQvsPtTfRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu7wlqO+AeDhWYSRpqB4ap9xKosWWpXN7OceTSZ5wo0Y30eRRfuFRgn0Ipj7JRz75oX8wmuq8Z9uycXOkj1nNjHfGe3JxRKbg+UsLJidr6aO7tXch9miLGkt3palaJ/Duj9gtUgPnwV0iT0M9D4junpGobwVDaSObg9ujtthRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FRRzpuZs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302023;
	bh=bptASkFhv+DFWmJaUioaR4+nnGLEW+O7QNQvsPtTfRY=;
	h=From:To:Cc:Subject:Date:From;
	b=FRRzpuZsRCG2syqd6Tqb2fUsVzd5AdIvPvCQZ6fqoOt+GnShliDyo5VQ2KnH5WxE9
	 +yHjGsyBVgp8IW1Ws3j4pQLjLIArQ/xTieBSpYOQN8xijIwKNf553Ep3lILwyymD8o
	 t4oLPuOc7+qDIjJ98D1YMMUV3KkkNIE8PHPk8AGs4KdL2jaFzBF0QoKHzwR/zZCQBp
	 4LIozmvDrwo0gwF+rrwdIOrDSw6REscztK4+nUtj9BhA4r8rM3k6bIRMvsLU/BwhC5
	 Cm9x9T5JRp7A04lYKHImRXTa0FIz1piJf/W3nMfPg55nOzTl667ZuRGTeWKCGbP157
	 Edv0ROtmthdzg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF68017E11FF;
	Tue, 13 Jan 2026 12:00:22 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: devicetree@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	daniel@makrotopia.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: net: dsa: mt7530: Allow interrupts-extended dependency
Date: Tue, 13 Jan 2026 12:00:20 +0100
Message-ID: <20260113110020.37013-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MT7530 switch is configured as an interrupt-controller it
also needs an interrupt but, in this case, only "interrupts" was
allowed.

Some devicetrees instead use the interrupts-extended property as a
shorter form, and in place of "interrupts" and "interrupt-parent",
as an equivalent.

For this reason, when interrupt-controller is present, depend on
either `interrupts` or `interrupts-extended`; this also resolves
some dtbs_check warnings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 815a90808901..ffeb8d5836fe 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -279,8 +279,11 @@ allOf:
         - resets
         - reset-names
 
-  - dependencies:
-      interrupt-controller: [ interrupts ]
+  - anyOf:
+      - dependencies:
+          interrupt-controller: [ interrupts ]
+      - dependencies:
+          interrupt-controller: [ interrupts-extended ]
 
   - if:
       properties:
-- 
2.52.0


