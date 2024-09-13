Return-Path: <netdev+bounces-128205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5658978754
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456591F21FD0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7B86131;
	Fri, 13 Sep 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lvxo4QZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EC84DE4;
	Fri, 13 Sep 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250320; cv=none; b=IEqOdDTowGqPUuUUU50RiZLpGiRG5R9p6eojkMkpkVIJueHTK5Fo1nrttsCbBiorI1KHkBDWcQOeKkg+gaofRLu9nxdN59LmxFRMe3RPtcInmpMdXsVh8riFxUaBztaqxK+BT4UjgQNpsp4qwW3GbuM3qFUZHQM/K7FfA2cfSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250320; c=relaxed/simple;
	bh=OkhiLu30m+oryjFjRxJOSBro4yUbMWyA8Ykvb/voTg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEAifX20clpcUe2fkLc6FlpZowYr7Ngh1ymdaghsJN1Qplo/cFPL1Enf6+KuhzC1FqeU1Fl2r9kK9jItJOo60FbsihdrMiy/DUBrqQ0Z3r/1CbPSV54s2gBQ4FaBT2Z4PcCxXuMrf/KhX1nBbnZEbH9ISSs3VSYtfEFZ5DblEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lvxo4QZZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8c1d08471f911efb66947d174671e26-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dAYFA4v4r/lRr/Fl63USBgf2C6IzZowyjg1mrdzkMRw=;
	b=Lvxo4QZZ9vIsWE7cRvBb8i+HZx76EtbEsJuzKj+TC18iLAZMBvCcqyucq8GvzUW9D03s6ozXqZp152F8npOPlAKlzijtZqxPUxQnG2aITbG8SMFDf2T5ivxEzbFg4akucT5jBzBmXQqlwQgaq0WN6lLqPKGa6I6YY3v1KMxOb7A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b098bca1-9008-4b55-b185-9ba69913abc4,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:1b7c2ed0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c8c1d08471f911efb66947d174671e26-20240914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1627288026; Sat, 14 Sep 2024 01:58:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 01:58:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 14 Sep 2024 01:58:25 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Wang
	<sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>, Macpaul Lin
	<macpaul.lin@mediatek.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v3 1/3] regulator: dt-bindings: mt6323: Convert to DT schema
Date: Sat, 14 Sep 2024 01:57:53 +0800
Message-ID: <20240913175753.6562-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.305700-8.000000
X-TMASE-MatchedRID: NhKiZ9p2PIYLazoQyrpm0ooLoibgjVEXh8Ytn75ClDPOxDyJFXIPjmm0
	zqcSNzI+8iNHpqH9BdjTpx8mj0GpKQHvpLYTRPZ4A9lly13c/gEraL2mh8ZVK7uqk4cq52pzjYm
	hMHKljSB7K5tSEDlvEjlvwKfYC3Nk6qLlkd1ucwbIOn6NK8S1a7iEAx7vTxsO3M5CjuZOAD56HQ
	e588lqzbk8fKyBc/ip5JZWpbmrOY4Ycyu6gJU0ixWCVBr+Ay988XH8gB0IKwjDV+mMbk1eU+J1Z
	55wDcxT3RZ9a0/2ZKnztrsG7YgmNDDP0IvaLA2NwVaayvK71l+PmFSaq6xM+AWLdH3H/apCl9+Z
	xpHSoIvi8zVgXoAltlPcOF1Vw1gmC24oEZ6SpSmb4wHqRpnaDigOEbLfjmA5aooCMGc1W1Hpwhs
	NpfogAb0opK0w56BNLF0tvKPSBORx20zB7k9ZVJsluOOkV58wCKK/N8kLZqAl3wSLGDvECvI2nu
	Dg9d7QFezHPq6MHFSrV/xdKQcFSY0leYQxW8u2ZyMWcibO/JI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.305700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CE9E49EF4B262BE6B04E9E0012D213014BC795A05BF29FEA5AD319B6C9027D852000:8
X-MTK: N

Convert the MT6323 regulator binding from the old text-based format to
the new DT schema style. The property "regulator-name" has been added
as required property to reflect current usage in mt6323.dtsi.

Examples have been streamlined and relocated to the parent schema file:
  mfd/mediatek,mt6397.yaml.

Update maintainer and submitter information with new entries from MediaTek.

The reference document cited in "mediatek,mt7530.yaml" has been updated
to point to this new DT schema file

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml     |   4 +-
 .../regulator/mediatek,mt6323-regulator.yaml  | 120 +++++++++
 .../bindings/regulator/mt6323-regulator.txt   | 237 ------------------
 3 files changed, 122 insertions(+), 239 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

Changes for v1 and v2:
 - This is the first version of converting mt6323-regulator.
   This is because converting mt6323-regulator together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of single patch for each skydives.
 - This patch has been made base on linux-next/master git repo.

Changes for v3:
 - Rebased on linux-next/master git repo near next-20240906.
 - Added 'regulator-name' to 'requried' property to reflect current usage.
 - replace ^(buck_)? and ^(ldo_)? to ^buck_ and ^ldo_ prefix.
 - Update file name of 'mediatek,mt6323-regulator.yaml' in
   'mediatek,mt7530.yaml'

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index ea979bc..413db38 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -129,8 +129,8 @@ properties:
   io-supply:
     description: |
       Phandle to the regulator node necessary for the I/O power.
-      See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
-      details for the regulator setup on these boards.
+      See Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
+      for details for the regulator setup on these boards.
 
   mediatek,mcm:
     type: boolean
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
new file mode 100644
index 0000000..01b0aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6323-regulator.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6323-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6323 Regulator
+
+maintainers:
+  - John Crispin <john@phrozen.org>
+  - Sen Chu <sen.chu@mediatek.com>
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+description: |
+  Regulator node of the PMIC. This node should under the PMIC's device node.
+  All voltage regulators provided by the PMIC are described as sub-nodes of
+  this node.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt6323-regulator
+
+patternProperties:
+  "^buck_v(pa|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(camio|cn18)$":
+    description: LDO with fixed 1.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v((io|rf)18)$":
+    description: LDOs with fixed 1.825V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(a|rtc|tcxo|(cn|io)28)$":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(usb)$":
+    description: LDOs with fixed 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(cn33_(bt|wifi))$":
+    description: LDOs with variable 3.3V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+  "^ldo_v(cama|camaf|camd|emc3v3|gp[123]|ibr|m|mc|mch|sim[12])$":
+    description: LDOs with variable output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-allowed-modes: false
+
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+required:
+  - compatible
+
+additionalProperties: false
+
diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
deleted file mode 100644
index a48749d..0000000
--- a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
+++ /dev/null
@@ -1,237 +0,0 @@
-Mediatek MT6323 Regulator
-
-All voltage regulators are defined as subnodes of the regulators node. A list
-of regulators provided by this controller are defined as subnodes of the
-PMIC's node. Each regulator is named according to its regulator type,
-buck_<name> and ldo_<name>. The definition for each of these nodes is defined
-using the standard binding for regulators at
-Documentation/devicetree/bindings/regulator/regulator.txt.
-
-The valid names for regulators are::
-BUCK:
-  buck_vproc, buck_vsys, buck_vpa
-LDO:
-  ldo_vtcxo, ldo_vcn28, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_va, ldo_vcama,
-  ldo_vio28, ldo_vusb, ldo_vmc, ldo_vmch, ldo_vemc3v3, ldo_vgp1, ldo_vgp2,
-  ldo_vgp3, ldo_vcn18, ldo_vsim1, ldo_vsim2, ldo_vrtc, ldo_vcamaf, ldo_vibr,
-  ldo_vrf18, ldo_vm, ldo_vio18, ldo_vcamd, ldo_vcamio
-
-Example:
-
-	pmic: mt6323 {
-		mt6323regulator: regulators {
-			mt6323_vproc_reg: buck_vproc{
-				regulator-name = "vproc";
-				regulator-min-microvolt = < 700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vsys_reg: buck_vsys{
-				regulator-name = "vsys";
-				regulator-min-microvolt = <1400000>;
-				regulator-max-microvolt = <2987500>;
-				regulator-ramp-delay = <25000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vpa_reg: buck_vpa{
-				regulator-name = "vpa";
-				regulator-min-microvolt = < 500000>;
-				regulator-max-microvolt = <3650000>;
-			};
-
-			mt6323_vtcxo_reg: ldo_vtcxo{
-				regulator-name = "vtcxo";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <90>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcn28_reg: ldo_vcn28{
-				regulator-name = "vcn28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_vcn33_bt_reg: ldo_vcn33_bt{
-				regulator-name = "vcn33_bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_vcn33_wifi_reg: ldo_vcn33_wifi{
-				regulator-name = "vcn33_wifi";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-enable-ramp-delay = <185>;
-			};
-
-			mt6323_va_reg: ldo_va{
-				regulator-name = "va";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcama_reg: ldo_vcama{
-				regulator-name = "vcama";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vio28_reg: ldo_vio28{
-				regulator-name = "vio28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vusb_reg: ldo_vusb{
-				regulator-name = "vusb";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-boot-on;
-			};
-
-			mt6323_vmc_reg: ldo_vmc{
-				regulator-name = "vmc";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vmch_reg: ldo_vmch{
-				regulator-name = "vmch";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vemc3v3_reg: ldo_vemc3v3{
-				regulator-name = "vemc3v3";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-				regulator-boot-on;
-			};
-
-			mt6323_vgp1_reg: ldo_vgp1{
-				regulator-name = "vgp1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vgp2_reg: ldo_vgp2{
-				regulator-name = "vgp2";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vgp3_reg: ldo_vgp3{
-				regulator-name = "vgp3";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vcn18_reg: ldo_vcn18{
-				regulator-name = "vcn18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vsim1_reg: ldo_vsim1{
-				regulator-name = "vsim1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vsim2_reg: ldo_vsim2{
-				regulator-name = "vsim2";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vrtc_reg: ldo_vrtc{
-				regulator-name = "vrtc";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcamaf_reg: ldo_vcamaf{
-				regulator-name = "vcamaf";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vibr_reg: ldo_vibr{
-				regulator-name = "vibr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <36>;
-			};
-
-			mt6323_vrf18_reg: ldo_vrf18{
-				regulator-name = "vrf18";
-				regulator-min-microvolt = <1825000>;
-				regulator-max-microvolt = <1825000>;
-				regulator-enable-ramp-delay = <187>;
-			};
-
-			mt6323_vm_reg: ldo_vm{
-				regulator-name = "vm";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vio18_reg: ldo_vio18{
-				regulator-name = "vio18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			mt6323_vcamd_reg: ldo_vcamd{
-				regulator-name = "vcamd";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-
-			mt6323_vcamio_reg: ldo_vcamio{
-				regulator-name = "vcamio";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <216>;
-			};
-		};
-	};
-- 
2.45.2


