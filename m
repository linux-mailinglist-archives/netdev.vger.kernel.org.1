Return-Path: <netdev+bounces-144785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE289C86EB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A90B287384
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AB1F8F11;
	Thu, 14 Nov 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cqo8o8Hz"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D731F7097;
	Thu, 14 Nov 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578898; cv=none; b=f5sfV7xLReU3m/FRFSED11bIi4KzkVJcH45RXGHgXWeld70r4CDcY6CtcLyl8K7zK8B/ka3UnutsKhk4+TaMSH1Yxk2iIyD2QoWo1s/MtDtN3HGk2KfxANmlfz/uNg/x4Rc01BhfFzzHfr5lQ5JhLEM91IHy0KEAQb7FSLfcCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578898; c=relaxed/simple;
	bh=+T7zJWsnL96H+zjaNN/L5YeRWGH7NRHm/d1ZxqSbAGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agKDcijUeqaXG1ra7uQgRTOUw/Q9qr1zQMcX+Smscte8BhmsCVub0bqkMth0Aj8fy6SuQtewgI4kVNMlmJGt+vVYCYyJAGXHXSUedz/HvGLh8YW+uSHb8Qj0SbFi7QmOyT2DMIbNAqUZ6A1Str6439es+IYJibsMeQLY9sWiziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cqo8o8Hz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5693531ea27011efbd192953cf12861f-20241114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NeZfIxfE73lDEasKhP0FSNvN7LjURM3GXgvN0vxDtZk=;
	b=cqo8o8HzZGQVlMvcaGOhnqZ8EpllxXW+K97JLT3fvIPUvpT8FpsZR+4eQmg37ixW5UcwCFNksmPtpwFJiydNHN+0ZGNawqhenScC6R/rv5br54WejBqSoUYC6PFtiBilhSsV9Tij0uEkkuUUh/fWQcneQ0JVHPySReEC7epbtDI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:0f8530bc-7c50-4ed0-8503-ec875d049a85,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d66b1307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5693531ea27011efbd192953cf12861f-20241114
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 388720392; Thu, 14 Nov 2024 18:08:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Nov 2024 02:08:03 -0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Nov 2024 18:08:03 +0800
From: Liju-clr Chen <liju-clr.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Richard Cochran
	<richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liju-clr Chen <Liju-clr.Chen@mediatek.com>, Yingshiuan Pan
	<Yingshiuan.Pan@mediatek.com>, Ze-yu Wang <Ze-yu.Wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>, Chi-shen Yeh
	<Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: [PATCH v13 03/25] dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
Date: Thu, 14 Nov 2024 18:07:40 +0800
Message-ID: <20241114100802.4116-4-liju-clr.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
index 000000000000..c9610ed27a1a
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
+  GenieZone is a proprietary type-I hypervisor firmware developed by MediaTek,
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
index bd119e707b7f..291f46017f3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9675,6 +9675,7 @@ GENIEZONE HYPERVISOR DRIVER
 M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
 M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Liju Chen <liju-clr.chen@mediatek.com>
+F:	Documentation/devicetree/bindings/firmware/mediatek,geniezone.yaml
 F:	Documentation/virt/geniezone/
 
 GENWQE (IBM Generic Workqueue Card)
-- 
2.18.0


