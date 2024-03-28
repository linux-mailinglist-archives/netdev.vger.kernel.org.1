Return-Path: <netdev+bounces-82855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07AA88FF73
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E27B215A3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217F7F7F6;
	Thu, 28 Mar 2024 12:48:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE877D3F1;
	Thu, 28 Mar 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630087; cv=none; b=D40cuPiWNUA4EjKxqSZRuIQ+vGa5cBBWv12htc0OHa7x7GPEYcHk6NHVgaLj2TLAjrCfJcjKebSA5JZk4ZY7envzLP8hQrVHfMtMhmbCTquo9pCO5QhrBMtVRZXMCzIKSBFfwpjEu9rYggFg5cQgg5Hs9Tf6aC0t8fNmtiXLoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630087; c=relaxed/simple;
	bh=jz70t3MBRfEXEnr3Se9+xKohC6GjZU6ETNlm/Wj0NI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZUS3q28/4mvpocJSgRzFPKu9cmHRFyHLIIQcGFYBVu6rg5d4zhv9/BKE8tn0HzUqbkkm8IgAlh4DPbDgbZHqd898C4xOIFYy3XackQk2PxlBkACFId3DXRRjMhepYMW/r1+qjS51sxPcLbJuEHKPkxtjhvFhNKganAgZgYI2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V53Gx4RrSz4f3mHp;
	Thu, 28 Mar 2024 20:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C53841A0D21;
	Thu, 28 Mar 2024 20:48:01 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgAnlQj+ZgVmTvYNIg--.31354S5;
	Thu, 28 Mar 2024 20:48:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Add config.riscv64
Date: Thu, 28 Mar 2024 12:49:14 +0000
Message-Id: <20240328124916.293173-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328124916.293173-1-pulehui@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnlQj+ZgVmTvYNIg--.31354S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43tF4fAw17ur18Cr47XFb_yoW5WrWxpr
	n7JrW8Jr48Jr17KrW7AryDGrZ8tr1DJFWUJr17Xr1UJw1ktw4fJr1Fyr4UGr1UXa18Xr4r
	AF97Gr13Zr1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
	U
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add config.riscv64 for both BPF CI and local vmtest.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/config.riscv64 | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/config.riscv64

diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
new file mode 100644
index 000000000000..2f520cfdcb18
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -0,0 +1,85 @@
+CONFIG_AUDIT=y
+CONFIG_BLK_CGROUP=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BONDING=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_PRELOAD=y
+CONFIG_BPF_PRELOAD_UMD=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CGROUP_NET_CLASSID=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CPUSETS=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EXPERT=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_FRAME_POINTER=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HUGETLBFS=y
+CONFIG_INET=y
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_JUMP_LABEL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KPROBES=y
+CONFIG_MEMCG=y
+CONFIG_NAMESPACES=y
+CONFIG_NET=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER_XT_MATCH_BPF=y
+CONFIG_NET_ACT_BPF=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
+CONFIG_NONPORTABLE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NR_CPUS=256
+CONFIG_PACKET=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_PCI=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROFILING=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_RISCV_ISA_C=y
+CONFIG_RISCV_PMU=y
+CONFIG_RISCV_PMU_SBI=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SMP=y
+CONFIG_SOC_VIRT=y
+CONFIG_SYSVIPC=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TLS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TUN=y
+CONFIG_UNIX=y
+CONFIG_UPROBES=y
+CONFIG_USER_NS=y
+CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_XFRM_USER=y
-- 
2.34.1


