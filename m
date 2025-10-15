Return-Path: <netdev+bounces-229565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C0BDE4B3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC63BBBF1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6191321F2E;
	Wed, 15 Oct 2025 11:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C33218C3;
	Wed, 15 Oct 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528324; cv=none; b=gxYfLDDVMkZSMVkBvLAZgNBr7IB8jfwMratvpMCWxsVyy6X8TGPuIY3oR9oAsL/s1kbCHdlVemlZkNqwu2aJn3VJUAeCCSCQj0QhdCEWjvxTOp6PSfU7zSjzJbJ9f+BVl8SpKvp337JWUGRiso4lOPpuhwGMTPYHgiqtAqjoSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528324; c=relaxed/simple;
	bh=lErbwYj5ee1pzJRsvUD9ax3R1cr+LldWhx71p1/ER2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cIRRcmTGE7oNh8bRTgqZuEnNV/UPaMaVwVbIYywvbLvYQV7uZYug7+Bf78o/OPZhg1PXtiyrZ+bQgxn36hQ3DvPLIMXt5N+VWy2Qmha6/CmK+BQRwXruP+9bB+2+DFZ6ziVBXfzqeS0eywU+NJIKjV+5RpGtgGSygBDhIXqK6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgAHHg+Sh+9oXyELAQ--.26792S2;
	Wed, 15 Oct 2025 19:37:57 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	jan.petrous@oss.nxp.com,
	inochiama@gmail.com,
	jszhang@kernel.org,
	0x1207@gmail.com,
	boon.khai.ng@altera.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: [PATCH v8 0/2] Add driver support for Eswin eic7700 SoC ethernet controller
Date: Wed, 15 Oct 2025 19:37:51 +0800
Message-Id: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAHHg+Sh+9oXyELAQ--.26792S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary3XF4xur17AFyxJF4fXwb_yoW7Ar1rpF
	WkCry5W3Z0yryxX3yIy3W0kFyfJan3XF1akr1Iqw13Xa1qvas0vrWSk3W5CasrAr4DZ3s0
	9ay3Zay7Aa4Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Updates:

  Changes in v8:
  - Removed config option patch dependency from cover letter, because the patch
    was applied.
  - Modify the theme style of patch 2.
  - Remove unnecessary dependencies, such as CRC32 and MII
  - Add "Reviewed-by" tag of "Andrew Lunn" for Patch 2.
  - Update eswin,eic7700-eth.yaml
    - Add new line character at the end of file
  - Update dwmac-eic7700.c
    - Provide callbacks for plat_dat->init/exit and plat_dat->suspend/resume
      to optimize clock processing
    - Use devm_stmmac_pltfr_probe() instead of stmmac_dvr_probe() in probe
    - Remove eic7700_dwmac_remove()
  - Link to v7: https://lore.kernel.org/all/20250918085612.3176-1-weishangjuan@eswincomputing.com/

  Changes in v7:
  - Add "Reviewed-by" tag of "Krzysztof Kozlowski" for Patch 1.
  - Update dwmac-eic7700.c
    - Align the processing logic of required attributes in binding
  - Link to v6: https://lore.kernel.org/all/20250912055352.2832-1-weishangjuan@eswincomputing.com/

  Changes in v6:
  - Update driver patch's commit message
  - Update eswin,eic7700-eth.yaml
    - Modify the description content
  - Update dwmac-eic7700.c
    - Move three variables from priv to local scope
    - Inline eic7700_apply_delay logic directly into the probe function
  - Link to v5: https://lore.kernel.org/all/20250904085913.2494-1-weishangjuan@eswincomputing.com/

  Changes in v5:
  - Updated eswin,eic7700-eth.yaml
    - Use "items" instead "enum" for clock-names
    - Arrange clocks description in correct order
    - Delete redundant descriptions for eswin,hsp-sp-csr property
  - Updated dwmac-eic7700.c
    - Optimize the implementation of eic7700_ appy_delay
    - Update comments and remove reg checking
    - Use FIELD_PREP in eic7700_apply_delay function
    - Use clk_bulk related APIs to manage clks
  - Link to v4: https://lore.kernel.org/all/20250827081135.2243-1-weishangjuan@eswincomputing.com/

  Changes in v4:
  - Updated eswin,eic7700-eth.yaml
    - Modify reg:minItems:1 to reg:maxItems: 1
    - Delete minItems and maxItems of clock and clock-names
    - Delete phy-mode and phy-handle properties
    - Add description for clock
    - Add types of clock-names
    - Delete descriptions for rx-internal-delay-ps and tx-internal-delay-ps
    - Add enum value for rx-internal-delay-ps and tx-internal-delay-ps
    - Modify description for eswin,hsp-sp-csr property
    - Delete eswin,syscrg-csr and eswin,dly-hsp-reg properties
    - Modify phy-mode="rgmii" to phy-mode="rgmii-id"
  - Updated dwmac-eic7700.c
    - Remove fix_mac_speed and configure different delays for different rates
    - Merge the offset of the dly register into the eswin, hsp sp csr attributes
      for unified management
    - Add missing Author and optimize the number of characters per
      line to within 80
    - Support default delay configuration and add the handling of vendor delay
      configuration
    - Add clks_config for pm_runtime
    - Modify the attribute format, such as eswin,hsp_sp_csr to eswin,hsp-sp-csr
  - Link to v3: https://lore.kernel.org/all/20250703091808.1092-1-weishangjuan@eswincomputing.com/

  Changes in v3:
  - Updated eswin,eic7700-eth.yaml
    - Modify snps,dwmac to snps,dwmac-5.20
    - Remove the description of reg
    - Modify the value of clock minItems and maxItems
    - Modify the value of clock-names minItems and maxItems
    - Add descriptions of snps,write-questions, snps,read-questions
    - Add rx-internal-delay-ps and tx-internal-delay-ps properties
    - Modify descriptions for custom properties, such as eswin,hsp-sp-csr
    - Delete snps,axi-config property
    - Add snps,fixed-burst snps,aal snps,tso properties
    - Delete snps,lpi_en property
    - Modify format of custom properties
  - Updated dwmac-eic7700.c
    - Simplify drivers and remove unnecessary API and DTS attribute configurations
    - Increase the mapping from tx/rx_delay_ps to private dly
  - Link to v2: https://lore.kernel.org/all/aDad+8YHEFdOIs38@mev-dev.igk.intel.com/

  Changes in v2:
  - Updated eswin,eic7700-eth.yaml
    - Add snps,dwmac in binding file
    - Modify the description of reg
    - Modify the number of clock-names
    - Changed the names of reset-names and phy-mode
    - Add description for custom properties, such as eswin,hsp_sp_csr
    - Delete snps,blen snps,rd_osr_lmt snps,wr_osr_lmt properties
  - Updated dwmac-eic7700.c
    - Remove the code related to PHY LED configuration from the MAC driver
    - Adjust the code format and driver interfaces, such as replacing kzalloc
      with devm_kzalloc, etc.
    - Use phylib instead of the GPIO API in the driver to implement the PHY
      reset function
  - Link to v1: https://lore.kernel.org/all/20250516010849.784-1-weishangjuan@eswincomputing.com/

Shangjuan Wei (2):
  dt-bindings: ethernet: eswin: Document for EIC7700 SoC
  net: stmmac: add Eswin EIC7700 glue driver

 .../bindings/net/eswin,eic7700-eth.yaml       | 127 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 235 ++++++++++++++++++
 4 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

--
2.17.1


