Return-Path: <netdev+bounces-293898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kILrGszdHWpsfQkAu9opvQ
	(envelope-from <netdev+bounces-293898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:30:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C2624A84
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93BA7308B9BF
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06C37F00E;
	Mon,  1 Jun 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAPixNMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7E37D104
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341881; cv=none; b=XmUXs1pxvq8CKnBEI6HVeerQ8M838sigN1UqoSQpgNVvE1pH+WWMf9eSza/0d1riWbUL1XhC9LgVMFehSgJHgamvBOSKxCes5ZUno9dRKmhEBf63mpZlVPSGlVLyquZYpeHqNmmBJbFRjN6nXaJl5qHKv9zos27EJcClrALFRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341881; c=relaxed/simple;
	bh=jVuw5EjU5tCYizHznvHPTOEU3be/b9VcUMLV9hcnLs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0n0oRxEwtYCz4SQtHHjvY38nU/s8V22FzTS4IZ0opuu58l3IMwpuW5hSISIz+y3rPZN/hAyuGj9gCB/QT5vsfPQcaHDE6d22BkK/Uat7VaHkjWZtHXIbmQ9+3hL8sLUk1js7aHAZn2QebjvGAc7FQH8C8Wekm+H2nj9WNGLlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAPixNMg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so1587230a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341879; x=1780946679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6oyn/opTXc3qNaiYrGm87ZPTedwK1fmyCVPQB5WlRQ=;
        b=IAPixNMgkSUK696qSg1AavZ62Hnqy47hBSiAgSxwDb2C7kJ1pMUPZwKmONmcd2IHOL
         kcXckF2jtafQbJJlpe1hWQ+7ntuW5kRUTRz7oAX3hLAzP1jt7QgXoIQ+VInnLUF5PNG/
         GPhw8UXNzx8lGkoOWXl1V9zEfKL93fa2arLWoy4PAqx2R6Whdl1/Q2xlErJKQJQewk9k
         2y7h10DcTJLVTyGXIS+51/Cd+BgguGF/8Cb4QTMt1LRblytVoC455JEu7d2p/SNLrB9n
         0KIwLSc7FL/RntvOHzu2ZfpOiIKb8RQawMKh0NwK6sGI4NgPfv8yhicUb2KLEjvUT/iy
         G4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341879; x=1780946679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w6oyn/opTXc3qNaiYrGm87ZPTedwK1fmyCVPQB5WlRQ=;
        b=ZF+LBlYskWhcYoEmfObYvIZNMcqgjIL6U5xUEMoZ9USWWj79psDa81V55c41O+7UG5
         hKaF/XE99yOTymOstutIfIWQJtTbRbxccldrTB4BM6VzMxN0QgTkNPF8te8zsJ/iGCxv
         gN7lWfjiGdkzJyhCLp+/FsXo94s9/qkgkAkPsqjGhBTb/uq4BFQhx1V0SKUBYbKjpQv0
         kFeEaJR8SF0PKGXLFvMzDQfBypXd23g/lLYwPG3XZY/r0UrsuBv2dKhZNxET3DFWs5Zw
         IUe5vAhK2AB6sjvQOBu73i90MbiYYZRWoP7nb5Fl4tvJtwJdTmvh5g9eab7v2OfFN52i
         2pIA==
X-Gm-Message-State: AOJu0YyCAHiQFkYJREw0kKgrlVoxjXb4RbigC2g+jMriAadrhabdqfZR
	OBwnCdP7FZgxRZ0MngKCFev4rVhifhA0SZyHQa3Dk8njbUPAWUJvGshL
X-Gm-Gg: Acq92OGmpNmr+dKUC9LHR125JVY5rLtSWQsMQ97dSK4JLHwN/VuhExmvJ0wPBNt3NIl
	BlVISWj2Fsp8JUpKj2/LGU1DH/WnRh23jzkvkC5ILgsydICMysRoH4ETqEjeO/yjPTroCK5yIvX
	jN/dUAHWPUx7QNGfMg3/aYt4isIU6Jl1VtzYUnrATKeDp16H7miYjPFMeGz6udfaFUwNvddL6iN
	2NhJx5zTw6QGMuFTW67rZ3dyp2cWf9YCb3/XomfIsXjKHkRXTuiwwrytKuIP7b8ArCJCcv/0NEb
	jm6ulVlOkkWcrbEvIrGxQ7A9OP9yng62ddpT5cLtar/DxVmWouHqsb2jjqA9vVGFaowZszmulP/
	Hoit1mfsG0+FWRtm8sOohHSzLm6EyhZSHR4z4pP9bzn1JxnyVdt4R/15fvAuRvyw2+KLZHiSlgn
	VZOTbYnRKrHw4/M/0othfUzaWEa09JuQ==
X-Received: by 2002:a05:6a20:4386:b0:398:8870:b58f with SMTP id adf61e73a8af0-3b427fb8528mr13017558637.14.1780341878840;
        Mon, 01 Jun 2026 12:24:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c857fb0b31dsm8997113a12.32.2026.06.01.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:24:38 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 01 Jun 2026 12:24:28 -0700
Subject: [PATCH net-next 2/2] selftests: drv-net: add userns devmem RX test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nl-prov-v1-2-9bc57d6ca3f3@meta.com>
References: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
In-Reply-To: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293898-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nk_devmem.py:url,userns_devmem.py:url,meta.com:mid,meta.com:email,lib.py:url,self.name:url]
X-Rspamd-Queue-Id: A64C2624A84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add userns_devmem.py, which mirrors nk_devmem.py but places the netkit
guest in a netns whose owning user_ns is non-init. ncdevmem is ran there
via nsenter so the bind-rx call is issued with creds that hold
CAP_NET_ADMIN only in the child user_ns.

Without the preceding GENL_UNS_ADMIN_PERM patch the test fails at
bind-rx with EPERM, but with the patch the transfer completes and tests
pass.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 .../selftests/drivers/net/hw/lib/py/__init__.py    |  4 +-
 .../selftests/drivers/net/hw/userns_devmem.py      | 48 +++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  |  8 ++-
 tools/testing/selftests/net/lib/py/__init__.py     |  4 +-
 tools/testing/selftests/net/lib/py/netns.py        | 79 ++++++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py        |  7 +-
 8 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c7a1206880ea..fd0535a96d84 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -47,6 +47,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	toeplitz.py \
 	tso.py \
+	userns_devmem.py \
 	uso.py \
 	xdp_metadata.py \
 	xsk_reconfig.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 8c132ace2b8d..3da6d3e39960 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -17,5 +17,6 @@ CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_UDMABUF=y
+CONFIG_USER_NS=y
 CONFIG_VXLAN=y
 CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 84a4dab6c649..8a58cb17cc06 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -18,7 +18,7 @@ try:
     sys.path.append(KSFT_DIR.as_posix())
 
     # Import one by one to avoid pylint false positives
-    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev, UserNetNS
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
@@ -34,7 +34,7 @@ try:
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
-    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
diff --git a/tools/testing/selftests/drivers/net/hw/userns_devmem.py b/tools/testing/selftests/drivers/net/hw/userns_devmem.py
new file mode 100755
index 000000000000..f824cc9ed3c6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/userns_devmem.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Devmem tests for non-init userns.
+"""
+
+import os
+
+from devmem_lib import run_rx, run_rx_hds, run_tx, run_tx_chunks, setup_test
+from lib.py import NetDrvContEnv, ksft_disruptive, ksft_exit, ksft_run
+
+
+@ksft_disruptive
+def check_userns_rx(cfg) -> None:
+    """Run the devmem RX test through non-init userns netkit."""
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_userns_tx(cfg) -> None:
+    """Run the devmem TX test through non-init userns netkit."""
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_userns_tx_chunks(cfg) -> None:
+    """Run the devmem TX chunking test through non-init userns netkit."""
+    run_tx_chunks(cfg)
+
+
+def check_userns_rx_hds(cfg) -> None:
+    """Run the HDS test through non-init userns netkit."""
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__, userns=True, rxqueues=2,
+                       primary_rx_redirect=True) as cfg:
+        setup_test(cfg,
+                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                "ncdevmem"))
+        ksft_run([check_userns_rx, check_userns_tx, check_userns_tx_chunks,
+                  check_userns_rx_hds], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ef317aef3a0a..2cc78b8a2152 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -9,7 +9,7 @@ from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
-from lib.py import NetNS, NetdevSimDev
+from lib.py import NetNS, NetdevSimDev, UserNetNS
 from .remote import Remote
 from . import bpftool, RtnlFamily, Netlink
 
@@ -337,8 +337,10 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False,
+                 userns=False, **kwargs):
         self.netns = None
+        self._userns = userns
         self._nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
@@ -463,7 +465,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         with open(ra_path, "w", encoding="utf-8") as f:
             f.write("2")
 
-        self.netns = NetNS()
+        self.netns = UserNetNS() if self._userns else NetNS()
         cmd("ip netns attach init 1")
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 64a8c1ed4950..e58bdbdc58ee 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -10,7 +10,7 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
     ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit, \
     ksft_variants, KsftNamedVariant
-from .netns import NetNS, NetNSEnter
+from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
@@ -26,7 +26,7 @@ __all__ = ["KSRC",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
            "ksft_run", "ksft_exit", "ksft_variants", "KsftNamedVariant",
-           "NetNS", "NetNSEnter",
+           "NetNS", "NetNSEnter", "UserNetNS",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "wait_file", "tool", "tc",
diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index 8e9317044eef..965f5802bef2 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -2,8 +2,12 @@
 
 from .utils import ip
 import ctypes
+import os
 import random
 import string
+import subprocess
+import time
+from pathlib import Path
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 
@@ -34,6 +38,81 @@ class NetNS:
         return f"NetNS({self.name})"
 
 
+class UserNetNS:
+    """Network namespace owned by a non-init user namespace."""
+
+    def __init__(self):
+        self.name = ''.join(
+            random.choice(string.ascii_lowercase) for _ in range(8))
+        self.user_ns_path = f"/run/userns/{self.name}"
+        self.net_ns_path = f"/run/netns/{self.name}"
+        self._user_mounted = False
+        self._net_mounted = False
+        self._unshare = None
+
+        os.makedirs("/run/userns", exist_ok=True)
+        os.makedirs("/run/netns", exist_ok=True)
+
+        Path(self.user_ns_path).touch()
+        Path(self.net_ns_path).touch()
+
+        self._unshare = subprocess.Popen(
+            ["unshare", "--user", "--net", "--map-root-user",
+             "sleep", "infinity"])
+
+        try:
+            pid = self._unshare.pid
+            init_user = os.readlink("/proc/self/ns/user")
+            for _ in range(200):
+                try:
+                    if os.readlink(f"/proc/{pid}/ns/user") != init_user:
+                        break
+                except OSError:
+                    pass
+                time.sleep(0.01)
+            else:
+                raise RuntimeError("unshare child did not create userns")
+
+            subprocess.run(["mount", "--bind", f"/proc/{pid}/ns/user",
+                            self.user_ns_path], check=True)
+            self._user_mounted = True
+            subprocess.run(["mount", "--bind", f"/proc/{pid}/ns/net",
+                            self.net_ns_path], check=True)
+            self._net_mounted = True
+        except (OSError, RuntimeError, subprocess.CalledProcessError):
+            self._unshare.kill()
+            self._unshare.wait()
+            raise
+
+    def __del__(self):
+        if self._net_mounted:
+            subprocess.run(["umount", self.net_ns_path], check=False)
+            self._net_mounted = False
+        if self._user_mounted:
+            subprocess.run(["umount", self.user_ns_path], check=False)
+            self._user_mounted = False
+        if self._unshare and self._unshare.poll() is None:
+            self._unshare.kill()
+            self._unshare.wait()
+        for path in (self.net_ns_path, self.user_ns_path):
+            try:
+                os.unlink(path)
+            except OSError:
+                pass
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        self.__del__()
+
+    def __str__(self):
+        return self.name
+
+    def __repr__(self):
+        return f"UserNetNS({self.name})"
+
+
 class NetNSEnter:
     def __init__(self, ns_name):
         self.ns_path = f"/run/netns/{ns_name}"
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index be9408a77168..87eae79d01c1 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -47,7 +47,12 @@ class cmd:
                  background=False, host=None, timeout=5, ksft_ready=None,
                  ksft_wait=None):
         if ns:
-            comm = f'ip netns exec {ns} ' + comm
+            if hasattr(ns, 'user_ns_path'):
+                comm = (f'nsenter --user={ns.user_ns_path} '
+                        f'--net={ns.net_ns_path} --setuid=0 --setgid=0 -- '
+                        + comm)
+            else:
+                comm = f'ip netns exec {ns} ' + comm
 
         self.stdout = None
         self.stderr = None

-- 
2.53.0-Meta


