Return-Path: <netdev+bounces-60299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515581E785
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B81C281231
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59364EB2B;
	Tue, 26 Dec 2023 13:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 5.mo547.mail-out.ovh.net (5.mo547.mail-out.ovh.net [46.105.43.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9304EB24
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from ex4.mail.ovh.net (unknown [10.108.17.2])
	by mo547.mail-out.ovh.net (Postfix) with ESMTPS id 234E8204D4;
	Tue, 26 Dec 2023 13:08:08 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (93.21.160.242) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 14:08:06 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: Quentin Deslandes <qde@naccy.de>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
	<shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: [PATCH] bpfilter: remove bpfilter
Date: Tue, 26 Dec 2023 14:07:42 +0100
Message-ID: <20231226130745.465988-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 15004023637230939741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -83
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvjedgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdludejmdenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeejvdekfedtfeeiveekgfeggfethedvvdfhhfevvdfhueelkedufeeiheekueekueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgugihuuhhurdighiiipdhgihhthhhusgdrtghomhdpsghpfhhilhhtvghrpghumhhhpggslhhosgdrshgsnecukfhppeduvdejrddtrddtrddupdelfedrvddurdduiedtrddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoqhguvgesnhgrtggthidruggvqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpjhhikhhosheskhgvrhhnvghlrdhorhhgpdhshhhurghhsehkvghrnhgvlhdrohhrghdpmhihkhholhgrlhesfhgsrdgtohhmpdhquhgvnhhtihhnsehishhovhgrlhgvnhhtrdgtohhmpdgushgrhhgvrhhnsehkvghrnhgvlh
 drohhrghdpphgrsggvnhhisehrvgguhhgrthdrtghomhdpkhhusggrsehkvghrnhgvlhdrohhrghdpvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdpuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdpjhholhhsrgeskhgvrhhnvghlrdhorhhgpdgsvghnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhhrgholhhuohesghhoohhglhgvrdgtohhmpdhkphhsihhnghhhsehkvghrnhgvlhdrohhrghdpjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhsohhngheskhgvrhhnvghlrdhorhhgpdhmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprghnughrihhisehkvghrnhgvlhdrohhrghdpuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdgrshhtsehkvghrnhgvlhdrohhrghdpkhgvrhhnvghlseigvghntdhnrdhnrghmvgdptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdpshgufhesghhoohhglhgvrdgtohhmpdgsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheegjedpmhhouggvpehsmhhtphhouhht

bpfilter was supposed to convert iptables filtering rules into
BPF programs on the fly, from the kernel, through a usermode
helper. The base code for the UMH was introduced in 2018, and
couple of attempts (2, 3) tried to introduce the BPF program
generate features but were abandoned.

bpfilter now sits in a kernel tree unused and unusable, occasionally
causing confusion amongst Linux users (4, 5).

As bpfilter is now developed in a dedicated repository on GitHub (6),
it was suggested a couple of times this year (LSFMM/BPF 2023,
LPC 2023) to remove the deprecated kernel part of the project. This
is the purpose of this patch.

[1]: https://lore.kernel.org/lkml/20180522022230.2492505-1-ast@kernel.org/
[2]: https://lore.kernel.org/bpf/20210829183608.2297877-1-me@ubique.spb.ru/#t
[3]: https://lore.kernel.org/lkml/20221224000402.476079-1-qde@naccy.de/
[4]: https://dxuuu.xyz/bpfilter.html
[5]: https://github.com/linuxkit/linuxkit/pull/3904
[6]: https://github.com/facebook/bpfilter

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 arch/loongarch/configs/loongson3_defconfig |   1 -
 include/linux/bpfilter.h                   |  24 ----
 include/uapi/linux/bpfilter.h              |  21 ----
 net/Kconfig                                |   2 -
 net/Makefile                               |   1 -
 net/bpfilter/.gitignore                    |   2 -
 net/bpfilter/Kconfig                       |  23 ----
 net/bpfilter/Makefile                      |  20 ---
 net/bpfilter/bpfilter_kern.c               | 136 ---------------------
 net/bpfilter/bpfilter_umh_blob.S           |   7 --
 net/bpfilter/main.c                        |  64 ----------
 net/bpfilter/msgfmt.h                      |  17 ---
 net/ipv4/Makefile                          |   2 -
 net/ipv4/bpfilter/Makefile                 |   2 -
 net/ipv4/bpfilter/sockopt.c                |  71 -----------
 net/ipv4/ip_sockglue.c                     |  12 --
 tools/bpf/bpftool/feature.c                |   4 -
 tools/testing/selftests/bpf/config.aarch64 |   1 -
 tools/testing/selftests/bpf/config.s390x   |   1 -
 tools/testing/selftests/bpf/config.x86_64  |   1 -
 tools/testing/selftests/hid/config         |   1 -
 21 files changed, 413 deletions(-)
 delete mode 100644 include/linux/bpfilter.h
 delete mode 100644 include/uapi/linux/bpfilter.h
 delete mode 100644 net/bpfilter/.gitignore
 delete mode 100644 net/bpfilter/Kconfig
 delete mode 100644 net/bpfilter/Makefile
 delete mode 100644 net/bpfilter/bpfilter_kern.c
 delete mode 100644 net/bpfilter/bpfilter_umh_blob.S
 delete mode 100644 net/bpfilter/main.c
 delete mode 100644 net/bpfilter/msgfmt.h
 delete mode 100644 net/ipv4/bpfilter/Makefile
 delete mode 100644 net/ipv4/bpfilter/sockopt.c

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 33795e4a5bd6..64ca46ec6e39 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -276,7 +276,6 @@ CONFIG_BRIDGE_EBT_T_NAT=m
 CONFIG_BRIDGE_EBT_ARP=m
 CONFIG_BRIDGE_EBT_IP=m
 CONFIG_BRIDGE_EBT_IP6=m
-CONFIG_BPFILTER=y
 CONFIG_IP_SCTP=m
 CONFIG_RDS=y
 CONFIG_L2TP=m
diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
deleted file mode 100644
index 736ded4905e0..000000000000
--- a/include/linux/bpfilter.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BPFILTER_H
-#define _LINUX_BPFILTER_H
-
-#include <uapi/linux/bpfilter.h>
-#include <linux/usermode_driver.h>
-#include <linux/sockptr.h>
-
-struct sock;
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, sockptr_t optval,
-			    unsigned int optlen);
-int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
-			    int __user *optlen);
-
-struct bpfilter_umh_ops {
-	struct umd_info info;
-	/* since ip_getsockopt() can run in parallel, serialize access to umh */
-	struct mutex lock;
-	int (*sockopt)(struct sock *sk, int optname, sockptr_t optval,
-		       unsigned int optlen, bool is_set);
-	int (*start)(void);
-};
-extern struct bpfilter_umh_ops bpfilter_ops;
-#endif
diff --git a/include/uapi/linux/bpfilter.h b/include/uapi/linux/bpfilter.h
deleted file mode 100644
index cbc1f5813f50..000000000000
--- a/include/uapi/linux/bpfilter.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_BPFILTER_H
-#define _UAPI_LINUX_BPFILTER_H
-
-#include <linux/if.h>
-
-enum {
-	BPFILTER_IPT_SO_SET_REPLACE = 64,
-	BPFILTER_IPT_SO_SET_ADD_COUNTERS = 65,
-	BPFILTER_IPT_SET_MAX,
-};
-
-enum {
-	BPFILTER_IPT_SO_GET_INFO = 64,
-	BPFILTER_IPT_SO_GET_ENTRIES = 65,
-	BPFILTER_IPT_SO_GET_REVISION_MATCH = 66,
-	BPFILTER_IPT_SO_GET_REVISION_TARGET = 67,
-	BPFILTER_IPT_GET_MAX,
-};
-
-#endif /* _UAPI_LINUX_BPFILTER_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3ec6bc98fa05..4adc47d0c9c2 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -233,8 +233,6 @@ source "net/bridge/netfilter/Kconfig"
 
 endif
 
-source "net/bpfilter/Kconfig"
-
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
 source "net/rds/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 4c4dc535453d..b06b5539e7a6 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX_SCM)		+= unix/
 obj-y				+= ipv6/
-obj-$(CONFIG_BPFILTER)		+= bpfilter/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
 obj-$(CONFIG_BRIDGE)		+= bridge/
diff --git a/net/bpfilter/.gitignore b/net/bpfilter/.gitignore
deleted file mode 100644
index f34e85ee8204..000000000000
--- a/net/bpfilter/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-bpfilter_umh
diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
deleted file mode 100644
index 3d4a21462458..000000000000
--- a/net/bpfilter/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig BPFILTER
-	bool "BPF based packet filtering framework (BPFILTER)"
-	depends on BPF && INET
-	select USERMODE_DRIVER
-	help
-	  This builds experimental bpfilter framework that is aiming to
-	  provide netfilter compatible functionality via BPF
-
-if BPFILTER
-config BPFILTER_UMH
-	tristate "bpfilter kernel module with user mode helper"
-	depends on CC_CAN_LINK
-	depends on m || CC_CAN_LINK_STATIC
-	default m
-	help
-	  This builds bpfilter kernel module with embedded user mode helper
-
-	  Note: To compile this as built-in, your toolchain must support
-	  building static binaries, since rootfs isn't mounted at the time
-	  when __init functions are called and do_execv won't be able to find
-	  the elf interpreter.
-endif
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
deleted file mode 100644
index cdac82b8c53a..000000000000
--- a/net/bpfilter/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the Linux BPFILTER layer.
-#
-
-userprogs := bpfilter_umh
-bpfilter_umh-objs := main.o
-userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
-
-ifeq ($(CONFIG_BPFILTER_UMH), y)
-# builtin bpfilter_umh should be linked with -static
-# since rootfs isn't mounted at the time of __init
-# function is called and do_execv won't find elf interpreter
-userldflags += -static
-endif
-
-$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
-
-obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
-bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
deleted file mode 100644
index 97e129e3f31c..000000000000
--- a/net/bpfilter/bpfilter_kern.c
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/umh.h>
-#include <linux/bpfilter.h>
-#include <linux/sched.h>
-#include <linux/sched/signal.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include "msgfmt.h"
-
-extern char bpfilter_umh_start;
-extern char bpfilter_umh_end;
-
-static void shutdown_umh(void)
-{
-	struct umd_info *info = &bpfilter_ops.info;
-	struct pid *tgid = info->tgid;
-
-	if (tgid) {
-		kill_pid(tgid, SIGKILL, 1);
-		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-		umd_cleanup_helper(info);
-	}
-}
-
-static void __stop_umh(void)
-{
-	if (IS_ENABLED(CONFIG_INET))
-		shutdown_umh();
-}
-
-static int bpfilter_send_req(struct mbox_request *req)
-{
-	struct mbox_reply reply;
-	loff_t pos = 0;
-	ssize_t n;
-
-	if (!bpfilter_ops.info.tgid)
-		return -EFAULT;
-	pos = 0;
-	n = kernel_write(bpfilter_ops.info.pipe_to_umh, req, sizeof(*req),
-			   &pos);
-	if (n != sizeof(*req)) {
-		pr_err("write fail %zd\n", n);
-		goto stop;
-	}
-	pos = 0;
-	n = kernel_read(bpfilter_ops.info.pipe_from_umh, &reply, sizeof(reply),
-			&pos);
-	if (n != sizeof(reply)) {
-		pr_err("read fail %zd\n", n);
-		goto stop;
-	}
-	return reply.status;
-stop:
-	__stop_umh();
-	return -EFAULT;
-}
-
-static int bpfilter_process_sockopt(struct sock *sk, int optname,
-				    sockptr_t optval, unsigned int optlen,
-				    bool is_set)
-{
-	struct mbox_request req = {
-		.is_set		= is_set,
-		.pid		= current->pid,
-		.cmd		= optname,
-		.addr		= (uintptr_t)optval.user,
-		.len		= optlen,
-	};
-	if (sockptr_is_kernel(optval)) {
-		pr_err("kernel access not supported\n");
-		return -EFAULT;
-	}
-	return bpfilter_send_req(&req);
-}
-
-static int start_umh(void)
-{
-	struct mbox_request req = { .pid = current->pid };
-	int err;
-
-	/* fork usermode process */
-	err = fork_usermode_driver(&bpfilter_ops.info);
-	if (err)
-		return err;
-	pr_info("Loaded bpfilter_umh pid %d\n", pid_nr(bpfilter_ops.info.tgid));
-
-	/* health check that usermode process started correctly */
-	if (bpfilter_send_req(&req) != 0) {
-		shutdown_umh();
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int __init load_umh(void)
-{
-	int err;
-
-	err = umd_load_blob(&bpfilter_ops.info,
-			    &bpfilter_umh_start,
-			    &bpfilter_umh_end - &bpfilter_umh_start);
-	if (err)
-		return err;
-
-	mutex_lock(&bpfilter_ops.lock);
-	err = start_umh();
-	if (!err && IS_ENABLED(CONFIG_INET)) {
-		bpfilter_ops.sockopt = &bpfilter_process_sockopt;
-		bpfilter_ops.start = &start_umh;
-	}
-	mutex_unlock(&bpfilter_ops.lock);
-	if (err)
-		umd_unload_blob(&bpfilter_ops.info);
-	return err;
-}
-
-static void __exit fini_umh(void)
-{
-	mutex_lock(&bpfilter_ops.lock);
-	if (IS_ENABLED(CONFIG_INET)) {
-		shutdown_umh();
-		bpfilter_ops.start = NULL;
-		bpfilter_ops.sockopt = NULL;
-	}
-	mutex_unlock(&bpfilter_ops.lock);
-
-	umd_unload_blob(&bpfilter_ops.info);
-}
-module_init(load_umh);
-module_exit(fini_umh);
-MODULE_LICENSE("GPL");
diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
deleted file mode 100644
index 40311d10d2f2..000000000000
--- a/net/bpfilter/bpfilter_umh_blob.S
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-	.section .init.rodata, "a"
-	.global bpfilter_umh_start
-bpfilter_umh_start:
-	.incbin "net/bpfilter/bpfilter_umh"
-	.global bpfilter_umh_end
-bpfilter_umh_end:
diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
deleted file mode 100644
index 291a92546246..000000000000
--- a/net/bpfilter/main.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <sys/uio.h>
-#include <errno.h>
-#include <stdio.h>
-#include <sys/socket.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "../../include/uapi/linux/bpf.h"
-#include <asm/unistd.h>
-#include "msgfmt.h"
-
-FILE *debug_f;
-
-static int handle_get_cmd(struct mbox_request *cmd)
-{
-	switch (cmd->cmd) {
-	case 0:
-		return 0;
-	default:
-		break;
-	}
-	return -ENOPROTOOPT;
-}
-
-static int handle_set_cmd(struct mbox_request *cmd)
-{
-	return -ENOPROTOOPT;
-}
-
-static void loop(void)
-{
-	while (1) {
-		struct mbox_request req;
-		struct mbox_reply reply;
-		int n;
-
-		n = read(0, &req, sizeof(req));
-		if (n != sizeof(req)) {
-			fprintf(debug_f, "invalid request %d\n", n);
-			return;
-		}
-
-		reply.status = req.is_set ?
-			handle_set_cmd(&req) :
-			handle_get_cmd(&req);
-
-		n = write(1, &reply, sizeof(reply));
-		if (n != sizeof(reply)) {
-			fprintf(debug_f, "reply failed %d\n", n);
-			return;
-		}
-	}
-}
-
-int main(void)
-{
-	debug_f = fopen("/dev/kmsg", "w");
-	setvbuf(debug_f, 0, _IOLBF, 0);
-	fprintf(debug_f, "<5>Started bpfilter\n");
-	loop();
-	fclose(debug_f);
-	return 0;
-}
diff --git a/net/bpfilter/msgfmt.h b/net/bpfilter/msgfmt.h
deleted file mode 100644
index 98d121c62945..000000000000
--- a/net/bpfilter/msgfmt.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_BPFILTER_MSGFMT_H
-#define _NET_BPFILTER_MSGFMT_H
-
-struct mbox_request {
-	__u64 addr;
-	__u32 len;
-	__u32 is_set;
-	__u32 cmd;
-	__u32 pid;
-};
-
-struct mbox_reply {
-	__u32 status;
-};
-
-#endif
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index e144a02a6a61..ec36d2ec059e 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -16,8 +16,6 @@ obj-y     := route.o inetpeer.o protocol.o \
 	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
 	     metrics.o netlink.o nexthop.o udp_tunnel_stub.o
 
-obj-$(CONFIG_BPFILTER) += bpfilter/
-
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
 obj-$(CONFIG_PROC_FS) += proc.o
diff --git a/net/ipv4/bpfilter/Makefile b/net/ipv4/bpfilter/Makefile
deleted file mode 100644
index 00af5305e05a..000000000000
--- a/net/ipv4/bpfilter/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_BPFILTER) += sockopt.o
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
deleted file mode 100644
index 193bcc2acccc..000000000000
--- a/net/ipv4/bpfilter/sockopt.c
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/uaccess.h>
-#include <linux/bpfilter.h>
-#include <uapi/linux/bpf.h>
-#include <linux/wait.h>
-#include <linux/kmod.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-
-struct bpfilter_umh_ops bpfilter_ops;
-EXPORT_SYMBOL_GPL(bpfilter_ops);
-
-static int bpfilter_mbox_request(struct sock *sk, int optname, sockptr_t optval,
-				 unsigned int optlen, bool is_set)
-{
-	int err;
-	mutex_lock(&bpfilter_ops.lock);
-	if (!bpfilter_ops.sockopt) {
-		mutex_unlock(&bpfilter_ops.lock);
-		request_module("bpfilter");
-		mutex_lock(&bpfilter_ops.lock);
-
-		if (!bpfilter_ops.sockopt) {
-			err = -ENOPROTOOPT;
-			goto out;
-		}
-	}
-	if (bpfilter_ops.info.tgid &&
-	    thread_group_exited(bpfilter_ops.info.tgid))
-		umd_cleanup_helper(&bpfilter_ops.info);
-
-	if (!bpfilter_ops.info.tgid) {
-		err = bpfilter_ops.start();
-		if (err)
-			goto out;
-	}
-	err = bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
-out:
-	mutex_unlock(&bpfilter_ops.lock);
-	return err;
-}
-
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, sockptr_t optval,
-			    unsigned int optlen)
-{
-	return bpfilter_mbox_request(sk, optname, optval, optlen, true);
-}
-
-int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
-			    int __user *optlen)
-{
-	int len;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	return bpfilter_mbox_request(sk, optname, USER_SOCKPTR(optval), len,
-				     false);
-}
-
-static int __init bpfilter_sockopt_init(void)
-{
-	mutex_init(&bpfilter_ops.lock);
-	bpfilter_ops.info.tgid = NULL;
-	bpfilter_ops.info.driver_name = "bpfilter_umh";
-
-	return 0;
-}
-device_initcall(bpfilter_sockopt_init);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2efc53526a38..620ffccda853 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -47,8 +47,6 @@
 #include <linux/errqueue.h>
 #include <linux/uaccess.h>
 
-#include <linux/bpfilter.h>
-
 /*
  *	SOL_IP control messages.
  */
@@ -1412,11 +1410,6 @@ int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		return -ENOPROTOOPT;
 
 	err = do_ip_setsockopt(sk, level, optname, optval, optlen);
-#if IS_ENABLED(CONFIG_BPFILTER_UMH)
-	if (optname >= BPFILTER_IPT_SO_SET_REPLACE &&
-	    optname < BPFILTER_IPT_SET_MAX)
-		err = bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
-#endif
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IP_HDRINCL &&
@@ -1764,11 +1757,6 @@ int ip_getsockopt(struct sock *sk, int level,
 	err = do_ip_getsockopt(sk, level, optname,
 			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 
-#if IS_ENABLED(CONFIG_BPFILTER_UMH)
-	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
-	    optname < BPFILTER_IPT_GET_MAX)
-		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
-#endif
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index edda4fc2c4d0..708733b0ea06 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -426,10 +426,6 @@ static void probe_kernel_image_config(const char *define_prefix)
 		{ "CONFIG_BPF_STREAM_PARSER", },
 		/* xt_bpf module for passing BPF programs to netfilter  */
 		{ "CONFIG_NETFILTER_XT_MATCH_BPF", },
-		/* bpfilter back-end for iptables */
-		{ "CONFIG_BPFILTER", },
-		/* bpftilter module with "user mode helper" */
-		{ "CONFIG_BPFILTER_UMH", },
 
 		/* test_bpf module for BPF tests */
 		{ "CONFIG_TEST_BPF", },
diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 253821494884..9c2bc7c59718 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -12,7 +12,6 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BONDING=y
-CONFIG_BPFILTER=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
 CONFIG_BPF_PRELOAD_UMD=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index 2ba92167be35..0ac1e5b36f86 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -10,7 +10,6 @@ CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
 CONFIG_BPF_PRELOAD=y
 CONFIG_BPF_PRELOAD_UMD=y
-CONFIG_BPFILTER=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_FREEZER=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 49a29dbc1910..503f65e5119a 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -22,7 +22,6 @@ CONFIG_BOOTTIME_TRACING=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_PRELOAD=y
 CONFIG_BPF_PRELOAD_UMD=y
-CONFIG_BPFILTER=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_CFS_BANDWIDTH=y
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 4f425178b56f..1758b055f295 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -1,5 +1,4 @@
 CONFIG_BPF_EVENTS=y
-CONFIG_BPFILTER=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
-- 
2.43.0


