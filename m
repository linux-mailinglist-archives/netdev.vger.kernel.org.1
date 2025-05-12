Return-Path: <netdev+bounces-189861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C6AB42B1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F44188FD95
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C814298C09;
	Mon, 12 May 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1Psz0HD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F5298C03;
	Mon, 12 May 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073290; cv=none; b=akJO+2xf6HxzKIZJpatY9X+ME7BHMp/j3xRtEoIBMm4Oak6wruZLo6psYei5iCyd9w+Hw5RcB5dr7H4KvpK8cBwftqg8wV3fwps/wsQcLUyT88Dq/kr4tLwae9EuTrhklyWqiFd6ZxDU0YzdD13IZwAV/UUL4hm7GlI4raiYTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073290; c=relaxed/simple;
	bh=EBuFtzc4+LkxaOaGKJQWrJl67yI5271r9jaMYXlRdRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sll/NemUq+JROACR7zD2JZKzq7rtQIXacA1Ujqo9yqwxHy1ndgAwzyFhPN0KZ0bT2eukRBfTH/qISI/EyPZC1oOkepS7krK7+4FQmtgFE5bvXkAU6IwkQXwqGRLGXcsdVuzLCSrnRyiwMZYqYZp3NWcLey/2yfwT78GM488/hUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1Psz0HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8748AC4CEE7;
	Mon, 12 May 2025 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073290;
	bh=EBuFtzc4+LkxaOaGKJQWrJl67yI5271r9jaMYXlRdRI=;
	h=From:Date:Subject:To:Cc:From;
	b=N1Psz0HDjUxynNORYyoaF/2o5TNrZD7WO6nv/3heUl+fblFFkdd9aR1y23GXcBqyr
	 rgQ2IJu6ytV1/T93Ethxo0XUC3In+0wE2lgEtviWmG7xUA6J5zpgOSYt+vk5XHAX2X
	 DPFeosIG9/OW27PqUXBXIhoAdjDPTEvQjkFTJu9CSXv0vozPI5JjBlHiAbo5lninlH
	 sNvXNiXhniMje288t1jcoHfaFx/TTSO8qjM+lhHR+hVbTHgFOOf9pB29vKwl8CxOVR
	 52juQP3O2OotOLn8f0k7w2/d/2MOH9HbStD6aBbTyh09ArOIggP7mHuCbWRlJvxs0A
	 EU3WelX1ymfjQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 12 May 2025 20:07:39 +0200
Subject: [PATCH] net: ipa: Make the SMEM item ID constant
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-topic-ipa_smem-v1-1-302679514a0d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOo4ImgC/x3MTQqAIBBA4avErBPUclFXiQjTqWbhDxoRiHdPW
 n6L9wpkTIQZ5q5AwocyBd8g+g7Mpf2JjGwzSC4VV0KyO0QyjKLeskPHDOJo1K7txAdoUUx40Ps
 Pl7XWD2l5rfRgAAAA
X-Change-ID: 20250512-topic-ipa_smem-cee4c5bad903
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Luca Weiss <luca@lucaweiss.eu>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747073287; l=8755;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Ea9Prymf3tSB8nxmMBXH/DHgJJgBh9Rgazi9/ijYdSQ=;
 b=3C9MlMdhZyPi0e/WtwQEV5XPn69MdRBXh4BBIduaQR1HjvXMc2lavB6gH8wyMpqUi+hFOhlA+
 zkyk+0O/KGBD+dDN+s7qu3JDhT3OrRkJyEk7vw1dr5bDFmSJP2bGckh
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

It can't vary, stop storing the same magic number everywhere.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/net/ipa/data/ipa_data-v3.1.c   |  1 -
 drivers/net/ipa/data/ipa_data-v3.5.1.c |  1 -
 drivers/net/ipa/data/ipa_data-v4.11.c  |  1 -
 drivers/net/ipa/data/ipa_data-v4.2.c   |  1 -
 drivers/net/ipa/data/ipa_data-v4.5.c   |  1 -
 drivers/net/ipa/data/ipa_data-v4.7.c   |  1 -
 drivers/net/ipa/data/ipa_data-v4.9.c   |  1 -
 drivers/net/ipa/data/ipa_data-v5.0.c   |  1 -
 drivers/net/ipa/data/ipa_data-v5.5.c   |  1 -
 drivers/net/ipa/ipa_data.h             |  2 --
 drivers/net/ipa/ipa_mem.c              | 21 +++++++++++----------
 11 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c b/drivers/net/ipa/data/ipa_data-v3.1.c
index e902d731776da784cdf312a301daefe54db1ef7f..65dba47291552dc8ef15fbb07e04d0510cb88e44 100644
--- a/drivers/net/ipa/data/ipa_data-v3.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.1.c
@@ -493,7 +493,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146bd000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00002000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c b/drivers/net/ipa/data/ipa_data-v3.5.1.c
index f632aab56f4c346e5cfc406034fce1b4b5cc67b3..315e617a8eebecd3a00d1eeed4b978db2f2ba251 100644
--- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
@@ -374,7 +374,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146bd000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00002000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v4.11.c b/drivers/net/ipa/data/ipa_data-v4.11.c
index c1428483ca34d91ad13e8875ff93ab639ee03ff8..f5d66779c2fb19464caa82bea28bf0a259394dc9 100644
--- a/drivers/net/ipa/data/ipa_data-v4.11.c
+++ b/drivers/net/ipa/data/ipa_data-v4.11.c
@@ -367,7 +367,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146a8000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00009000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v4.2.c b/drivers/net/ipa/data/ipa_data-v4.2.c
index 2c7e8cb429b9c2048498fe8d86df55d490a1235d..f5ed5d745aeb19c770fc9f1955e29d26c26794e0 100644
--- a/drivers/net/ipa/data/ipa_data-v4.2.c
+++ b/drivers/net/ipa/data/ipa_data-v4.2.c
@@ -340,7 +340,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146a8000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00002000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v4.5.c b/drivers/net/ipa/data/ipa_data-v4.5.c
index 57dc78c526b06c96439155f9c4133c575bdeb6ba..730d8c43a45c37250f3641ac2a4d578c6ad6414c 100644
--- a/drivers/net/ipa/data/ipa_data-v4.5.c
+++ b/drivers/net/ipa/data/ipa_data-v4.5.c
@@ -418,7 +418,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x14688000,
 	.imem_size	= 0x00003000,
-	.smem_id	= 497,
 	.smem_size	= 0x00009000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index 41f212209993f10fee338e28027739a7402d5089..5e1d9049c62bd7a451669b1f3941e10661e078eb 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -360,7 +360,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146a8000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00009000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v4.9.c b/drivers/net/ipa/data/ipa_data-v4.9.c
index 4eb9c909d5b3fa813b800e9d16ca7d0d73651f2e..da472a2a2e2914ccb026654ccbaf8ffaf5a6d4f4 100644
--- a/drivers/net/ipa/data/ipa_data-v4.9.c
+++ b/drivers/net/ipa/data/ipa_data-v4.9.c
@@ -416,7 +416,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x146bd000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x00009000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v5.0.c b/drivers/net/ipa/data/ipa_data-v5.0.c
index 050580c99b65cf178bcd5e90ef832d2288a1a803..bc5722e4b053114621c099273782cdc694098934 100644
--- a/drivers/net/ipa/data/ipa_data-v5.0.c
+++ b/drivers/net/ipa/data/ipa_data-v5.0.c
@@ -442,7 +442,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x14688000,
 	.imem_size	= 0x00003000,
-	.smem_id	= 497,
 	.smem_size	= 0x00009000,
 };
 
diff --git a/drivers/net/ipa/data/ipa_data-v5.5.c b/drivers/net/ipa/data/ipa_data-v5.5.c
index 0e6663e225333c1ffa67fa324bf430172789fd0c..741ae21d9d78520466f4994b68109e0c07409c1d 100644
--- a/drivers/net/ipa/data/ipa_data-v5.5.c
+++ b/drivers/net/ipa/data/ipa_data-v5.5.c
@@ -448,7 +448,6 @@ static const struct ipa_mem_data ipa_mem_data = {
 	.local		= ipa_mem_local_data,
 	.imem_addr	= 0x14688000,
 	.imem_size	= 0x00002000,
-	.smem_id	= 497,
 	.smem_size	= 0x0000b000,
 };
 
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index d88cbbbf18b749e22bb09b472dcfa59d44a9dca4..2fd03f0799b207833f9f2b421ce043534720d718 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -180,7 +180,6 @@ struct ipa_resource_data {
  * @local:		array of IPA-local memory region descriptors
  * @imem_addr:		physical address of IPA region within IMEM
  * @imem_size:		size in bytes of IPA IMEM region
- * @smem_id:		item identifier for IPA region within SMEM memory
  * @smem_size:		size in bytes of the IPA SMEM region
  */
 struct ipa_mem_data {
@@ -188,7 +187,6 @@ struct ipa_mem_data {
 	const struct ipa_mem *local;
 	u32 imem_addr;
 	u32 imem_size;
-	u32 smem_id;
 	u32 smem_size;
 };
 
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index dee985eb08cba29d5d7d6418ed6c187ce3d2fb5d..835a3c9c1fd47167da3396424a1653ebcae81d40 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -26,6 +26,8 @@
 /* SMEM host id representing the modem. */
 #define QCOM_SMEM_HOST_MODEM	1
 
+#define SMEM_IPA_FILTER_TABLE	497
+
 const struct ipa_mem *ipa_mem_find(struct ipa *ipa, enum ipa_mem_id mem_id)
 {
 	u32 i;
@@ -509,7 +511,6 @@ static void ipa_imem_exit(struct ipa *ipa)
 /**
  * ipa_smem_init() - Initialize SMEM memory used by the IPA
  * @ipa:	IPA pointer
- * @item:	Item ID of SMEM memory
  * @size:	Size (bytes) of SMEM memory region
  *
  * SMEM is a managed block of shared DRAM, from which numbered "items"
@@ -523,7 +524,7 @@ static void ipa_imem_exit(struct ipa *ipa)
  *
  * Note: @size and the item address are is not guaranteed to be page-aligned.
  */
-static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
+static int ipa_smem_init(struct ipa *ipa, size_t size)
 {
 	struct device *dev = ipa->dev;
 	struct iommu_domain *domain;
@@ -545,25 +546,25 @@ static int ipa_smem_init(struct ipa *ipa, u32 item, size_t size)
 	 * The item might have already been allocated, in which case we
 	 * use it unless the size isn't what we expect.
 	 */
-	ret = qcom_smem_alloc(QCOM_SMEM_HOST_MODEM, item, size);
+	ret = qcom_smem_alloc(QCOM_SMEM_HOST_MODEM, SMEM_IPA_FILTER_TABLE, size);
 	if (ret && ret != -EEXIST) {
-		dev_err(dev, "error %d allocating size %zu SMEM item %u\n",
-			ret, size, item);
+		dev_err(dev, "error %d allocating size %zu SMEM item\n",
+			ret, size);
 		return ret;
 	}
 
 	/* Now get the address of the SMEM memory region */
-	virt = qcom_smem_get(QCOM_SMEM_HOST_MODEM, item, &actual);
+	virt = qcom_smem_get(QCOM_SMEM_HOST_MODEM, SMEM_IPA_FILTER_TABLE, &actual);
 	if (IS_ERR(virt)) {
 		ret = PTR_ERR(virt);
-		dev_err(dev, "error %d getting SMEM item %u\n", ret, item);
+		dev_err(dev, "error %d getting SMEM item\n", ret);
 		return ret;
 	}
 
 	/* In case the region was already allocated, verify the size */
 	if (ret && actual != size) {
-		dev_err(dev, "SMEM item %u has size %zu, expected %zu\n",
-			item, actual, size);
+		dev_err(dev, "SMEM item has size %zu, expected %zu\n",
+			actual, size);
 		return -EINVAL;
 	}
 
@@ -659,7 +660,7 @@ int ipa_mem_init(struct ipa *ipa, struct platform_device *pdev,
 	if (ret)
 		goto err_unmap;
 
-	ret = ipa_smem_init(ipa, mem_data->smem_id, mem_data->smem_size);
+	ret = ipa_smem_init(ipa, mem_data->smem_size);
 	if (ret)
 		goto err_imem_exit;
 

---
base-commit: edef457004774e598fc4c1b7d1d4f0bcd9d0bb30
change-id: 20250512-topic-ipa_smem-cee4c5bad903

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


