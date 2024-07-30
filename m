Return-Path: <netdev+bounces-114032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B49940B7A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AA41C20CC9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6A419883C;
	Tue, 30 Jul 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZYCPJmJv"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13390194A76;
	Tue, 30 Jul 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327901; cv=none; b=H8Ts/GJewyLEHgphUbc3SEG26i+SS36jAtSKcAfiEmAWmzIEgfrrJCaF2d74h1jvsbwLILx5aiLl4NI1dHIGSKQpa0Kdwmae7bAnwSMKUfPlbTOnTpSSBJJ6Ilav5zfLuHotKGG/Iaw5M7ej2d72DjuIIhLosczjVNhUI3yLBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327901; c=relaxed/simple;
	bh=gZ/UDXforLRw3MST1B7dLtOUAjMmv5MvQZdiWD/ltYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx9cnnsjNsEGd4KUxix49mbHCbgQaqIR6L3Smt06+/WyyEMZVFAtNj87tevMuYeQ5MDvTrGtn5gScE6y6LSpXp1iEjQQecJsYWrjwIDxrKEo9GbNiTyB74ubOnsyGPV3AxEBSRI6V8nNZlCRuy6wOiaSvVHLcn3K7nMleVhUCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZYCPJmJv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c1230aa4e4d11efb5b96b43b535fdb4-20240730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=N44+PEc/8BR27rcrPZroMtepRuhWsSDzL1+dhqzg+yI=;
	b=ZYCPJmJvw6TzPfRG1UCXnBFdQQncHKyOnHzwmue2OPFFXAmjunwWZabl4pGAjvkqfd4IeKg0ziA6X9orIHzdowAqtRrsVS6qDSzhyrMMzV6Q7HUNDLay9Jekp4MSVlFUVOowwLDvnQoaW02ULNGZr+urBdc1GzjqxW12XKGulqU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:686b501b-f58f-48bf-90fb-4de9de478566,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6dc6a47,CLOUDID:f71c11d2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2c1230aa4e4d11efb5b96b43b535fdb4-20240730
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1547835868; Tue, 30 Jul 2024 16:24:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 Jul 2024 16:24:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 Jul 2024 16:24:37 +0800
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
Subject: [PATCH v12 07/24] virt: geniezone: Add vm capability check
Date: Tue, 30 Jul 2024 16:24:19 +0800
Message-ID: <20240730082436.9151-8-liju-clr.chen@mediatek.com>
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
X-TM-AS-Result: No-10--2.104900-8.000000
X-TMASE-MatchedRID: c6n4reyclFZWj3HFS14pKxn0UD4GU5Iq5E5u1OdPWsTgr/zYTDOZCJeq
	sXSeEviPpSHzbpDtJi1Yo3G+rvxrNYJrRWPc34Z+A9lly13c/gGZ2scyRQcerwqiCYa6w8tv0ZI
	Z9x7ls0KIi0Yt2qmJZY3/d0NuPcI1QkfxbJAyTm7J1E39jKDimIZR+1Pw4IhPFJViChKBgZnSnr
	qDj9ZW6BhWFR8drn6J0RugigfesRTBZ0clD27MKJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyHEqm
	8QYBtMOIFBmXJT+J9Ssvgu1EXuCkfrX99/0t16JwNmZ1hngvKKhwB20eC+QD+1hz5IMcNam2fLf
	zgrHsROqf0l/C26AEGcTe8w4eEpkeZUpm6wun3ba/06NhYDa4wyzCDjlUx89djekYOaiKTo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.104900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8635F6EA56455D30E6F0EC954D627C358CC2BB4C30F30BE7294815C50794B6522000:8
X-MTK: N

From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>

Inquire the `capability support` on GenieZone hypervisor.
Example:
`GZVM_CAP_PROTECTED_VM` or `GZVM_CAP_VM_GPA_SIZE`.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Co-developed-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Co-developed-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               | 122 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  26 +++++
 drivers/virt/geniezone/gzvm_vm.c        |  23 ++++-
 include/linux/soc/mediatek/gzvm_drv.h   |   5 +
 include/uapi/linux/gzvm.h               |  31 ++++++
 6 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 4250c0f567e7..e500dbe7f943 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -13,6 +13,7 @@ enum {
 	GZVM_FUNC_DESTROY_VM = 1,
 	GZVM_FUNC_SET_MEMREGION = 4,
 	GZVM_FUNC_PROBE = 12,
+	GZVM_FUNC_ENABLE_CAP = 13,
 	NR_GZVM_FUNC,
 };
 
@@ -26,6 +27,7 @@ enum {
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
 #define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index d4f0aa81d224..0030e57bf77b 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -72,6 +72,40 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 				    buf_size, region, 0, 0, 0, 0, &res);
 }
 
+static int gzvm_cap_vm_gpa_size(void __user *argp)
+{
+	__u64 value = CONFIG_ARM64_PA_BITS;
+
+	if (copy_to_user(argp, &value, sizeof(__u64)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp)
+{
+	int ret;
+
+	switch (cap) {
+	case GZVM_CAP_PROTECTED_VM: {
+		__u64 success = 1;
+
+		if (copy_to_user(argp, &success, sizeof(__u64)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case GZVM_CAP_VM_GPA_SIZE: {
+		ret = gzvm_cap_vm_gpa_size(argp);
+		return ret;
+	}
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * gzvm_arch_create_vm() - create vm
  * @vm_type: VM type. Only supports Linux VM now.
@@ -97,3 +131,91 @@ int gzvm_arch_destroy_vm(u16 vm_id)
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
 				    0, 0, &res);
 }
+
+static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
+				   struct gzvm_enable_cap *cap,
+				   struct arm_smccc_res *res)
+{
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
+				    cap->cap, cap->args[0], cap->args[1],
+				    cap->args[2], cap->args[3], cap->args[4],
+				    res);
+}
+
+/**
+ * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
+ *				    in x1, and return to userspace in args
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Hypervisor return invalid results
+ * * -EFAULT		- Fail to copy back to userspace buffer
+ */
+static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
+					struct gzvm_enable_cap *cap,
+					void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+
+	if (gzvm_vm_arch_enable_cap(gzvm, cap, &res) != 0)
+		return -EINVAL;
+
+	cap->args[1] = res.a1;
+	if (copy_to_user(argp, cap, sizeof(*cap)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_PROTECTED_VM's subcommands
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Invalid subcommand or arguments
+ */
+static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
+				 struct gzvm_enable_cap *cap,
+				 void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	switch (cap->args[0]) {
+	case GZVM_CAP_PVM_SET_PVMFW_GPA:
+		fallthrough;
+	case GZVM_CAP_PVM_SET_PROTECTED_VM:
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
+	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
+		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp)
+{
+	int ret;
+
+	switch (cap->cap) {
+	case GZVM_CAP_PROTECTED_VM:
+		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index ac3c51c1d56b..28be828613e0 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -41,12 +41,38 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+/**
+ * gzvm_dev_ioctl_check_extension() - Check if given capability is support
+ *				      or not
+ *
+ * @gzvm: Pointer to struct gzvm
+ * @args: Pointer in u64 from userspace
+ *
+ * Return:
+ * * 0			- Supported, no error
+ * * -EOPNOTSUPP	- Unsupported
+ * * -EFAULT		- Failed to get data from userspace
+ */
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
+{
+	__u64 cap;
+	void __user *argp = (void __user *)args;
+
+	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
+		return -EFAULT;
+	return gzvm_arch_check_extension(gzvm, cap, argp);
+}
+
 static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long user_args)
 {
 	switch (cmd) {
 	case GZVM_CREATE_VM:
 		return gzvm_dev_ioctl_create_vm(user_args);
+	case GZVM_CHECK_EXTENSION:
+		if (!user_args)
+			return -EINVAL;
+		return gzvm_dev_ioctl_check_extension(NULL, user_args);
 	default:
 		break;
 	}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 052ba236dfec..89cb97985e1d 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -130,6 +130,13 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
+				    struct gzvm_enable_cap *cap,
+				    void __user *argp)
+{
+	return gzvm_vm_ioctl_arch_enable_cap(gzvm, cap, argp);
+}
+
 /* gzvm_vm_ioctl() - Ioctl handler of VM FD */
 static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 			  unsigned long arg)
@@ -139,6 +146,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	struct gzvm *gzvm = filp->private_data;
 
 	switch (ioctl) {
+	case GZVM_CHECK_EXTENSION: {
+		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -148,10 +159,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_ENABLE_CAP: {
+		struct gzvm_enable_cap cap;
+
+		if (copy_from_user(&cap, argp, sizeof(cap))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
+		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
-
+out:
 	return ret;
 }
 
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 3551de8eda1d..0792fefd6114 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -98,6 +98,7 @@ struct gzvm {
 	u16 vm_id;
 };
 
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
 int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
 
 int gzvm_err_to_errno(unsigned long err);
@@ -108,8 +109,12 @@ void gzvm_destroy_all_vms(void);
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp);
 
 int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
 			    u64 *hva_memslot);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 59c0f790b2e6..a79e787c9181 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -16,12 +16,30 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define GZVM_CAP_VM_GPA_SIZE	0xa5
+#define GZVM_CAP_PROTECTED_VM	0xffbadab1
+
+/* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
+#define GZVM_CAP_PVM_SET_PVMFW_GPA		0
+#define GZVM_CAP_PVM_GET_PVMFW_SIZE		1
+/* GZVM_CAP_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
+#define GZVM_CAP_PVM_SET_PROTECTED_VM		2
+
 /* GZVM ioctls */
 #define GZVM_IOC_MAGIC			0x92	/* gz */
 
 /* ioctls for /dev/gzvm fds */
 #define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
 
+/*
+ * Check if the given capability is supported or not.
+ * The argument is capability. Ex. GZVM_CAP_PROTECTED_VM or GZVM_CAP_VM_GPA_SIZE
+ * return is 0 (supported, no error)
+ * return is -EOPNOTSUPP (unsupported)
+ * return is -EFAULT (failed to get the argument from userspace)
+ */
+#define GZVM_CHECK_EXTENSION       _IO(GZVM_IOC_MAGIC,   0x03)
+
 /* ioctls for VM fds */
 /* for GZVM_SET_MEMORY_REGION */
 struct gzvm_memory_region {
@@ -53,4 +71,17 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/**
+ * struct gzvm_enable_cap: The `capability support` on GenieZone hypervisor
+ * @cap: `GZVM_CAP_ARM_PROTECTED_VM` or `GZVM_CAP_ARM_VM_IPA_SIZE`
+ * @args: x3-x7 registers can be used for additional args
+ */
+struct gzvm_enable_cap {
+	__u64 cap;
+	__u64 args[5];
+};
+
+#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
+					struct gzvm_enable_cap)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


