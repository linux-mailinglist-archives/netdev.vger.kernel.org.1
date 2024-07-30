Return-Path: <netdev+bounces-114016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB8940B45
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949C12843FB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085819309A;
	Tue, 30 Jul 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r/US5xdh"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748001922E9;
	Tue, 30 Jul 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327895; cv=none; b=ejLHgqc0wEOqmmnFZi29uv+tIIJLYB4vh25cY5GL2Tg44BDZu8cJG8kdyntKNMwGhWz0qx0mVvJtqS1jC4FLID6+ScbKTj/XUTkb8HVY/EEanwxZrnU+fvATNOK3KV2fz/11Ef9EIc3cROPr9qhk16In8GyrQ5cfXqsSW+DYm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327895; c=relaxed/simple;
	bh=B1ZWnvuPcmpAB7hNwGJQts7LZNzJFwcDdnxhyCZgRXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgqfbksgjbgzaWXS/50+fJO5fq9ACnTvryrJwYwf4Ev+YqGLFIYPL7LnAgPCPaGV/nucP0b0/1z1QeGudKss3G1L5u9IweMDOS28gMeSpaHKmKjo7TXeg3SxFnu8ZaqgnMVXStWzRc7kxiyW6Ltz25j6z0/Zk2FgrpeD4+VyVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r/US5xdh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2aa4c69c4e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OgSW6dVNnAhswj/7R39SfuUk1XTOlWR2Zu3pfGWM3Eg=;
	b=r/US5xdhe3zjcVnU6o5EZigh2fHSco9ACC72LTaEeDVLgeM+j5+OG3hR1jxOzrE4YLcP+Bfh2JYjFKXNMlQAYbFBMwjz6u85PqMYkvOwa2T0WIp+N9rG3JDDAbxON5k1bMzecNWOPQCogF/sRXdPPZD7Yoy6x3fbhCJNlr84/C0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:caa53f5e-4502-47af-b4f0-f42329feb094,IP:0,U
	RL:25,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:c01c11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2aa4c69c4e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1285623739; Tue, 30 Jul 2024 16:24:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:36 +0800
From: Liju-clr Chen <liju-clr.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Catalin Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liju-clr Chen
	<Liju-clr.Chen@mediatek.com>, Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v12 03/24] dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
Date: Tue, 30 Jul 2024 16:24:15 +0800
Message-ID: <20240730082436.9151-4-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.852200-8.000000
X-TMASE-MatchedRID: 9nkzMtsPLI7HCChNBbZThW3NvezwBrVmUXlp1FHYSPVQvOmOsSGiOvpo
	C/IwAOldqznouEQxFp8YGNM7XoZ5vCCzhzaU0wjghK8o4aoss8pNedaYR0zWEeg3wNKii1r5whl
	d5aALkfjI4b5i74dtIeme0b2Wkjaj05iwHvhHt5ydVNZaI2n6/yhRWQHuJ8me/5qbzhvkAsRm+j
	6YVbX2YCsiEc3CIbVZXAa2d/45j8QGtTV246rrNLcPsR57JkIza/fioJ9l4HjczkKO5k4APgXGJ
	JNKRfMg9ySTLtgiPs+wPPg9S3J+Rda/jIZoZyKFjtK7dC6UBnmANGXBz7BHpz/90OQ2nJ+7W2os
	qlcuMzDi8zVgXoAltlPcOF1Vw1gmC24oEZ6SpSkj80Za3RRg8FR0hM9p4bA9p13SbwOLufQAVtc
	ygMZANnTu9q9rxGQ2rW7Lspl6Tvo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.852200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 632E139271ECEFA57A57B4814670D119EE01D35F456617E2B6A5A0C9DB6C13132000:8
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

Add documentation for GenieZone(gzvm) node. This node informs gzvm
driver to start probing if proprietary geniezone hypervisor firmware is
available and capable of executing virtual machine operations.

[Reason to use dt solution]
The GenieZone hypervisor acts as a vendor firmware to enable platform
virtualization, offering an implementation that is independent of
Linux-specific implementations.
- Previously, our approach involved probing via hypercalls to detect the
  presence of our hypervisor firmware. However, this method raised
  concerns about potential impacts on all systems, including those
  without the embedded GenieZone hypervisor.[1]
- By utilizing the device tree solution, we can accurately identify the
  GenieZone hypervisor's presence without relying on hypercalls,
  ensuring a more targeted and efficient detection process that
  minimizes the risk of unintended consequences on non-GenieZone systems.

[1] https://lore.kernel.org/all/2fe0c7f9-55fc-ae63-3631-8526a0212ccd@linaro.org/

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 .../bindings/firmware/mediatek,geniezone.yaml | 34 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml

diff --git a/Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml b/Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
new file mode 100644
index 000000000000..9955890cb8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/mediatek,geniezone.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek GenieZone hypervisor
+
+maintainers:
+  - Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+
+description:
+  GenieZone is a proprietary type-II hypervisor firmware developed by MediaTek,
+  providing an isolated execution environment for mTEE (MediaTek Trusted
+  Execution Environment) and AVF (Android Virtualization Framework) virtual
+  machines. This binding facilitates the integration of GenieZone into the
+  Android Virtualization Framework (AVF) with Crosvm as the VMM. The driver
+  exposes hypervisor control interfaces to the VMM for managing virtual
+  machine lifecycles and assisting virtual device emulation.
+
+properties:
+  compatible:
+    const: mediatek,geniezone
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    hypervisor {
+        compatible = "mediatek,geniezone";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a61f74e258f8..e9d600ae48bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9450,6 +9450,7 @@ GENIEZONE HYPERVISOR DRIVER
 M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
 M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Liju Chen <liju-clr.chen@mediatek.com>
+F:	Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
 F:	Documentation/virt/geniezone/
 
 GENWQE (IBM Generic Workqueue Card)
-- 
2.18.0


