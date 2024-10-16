Return-Path: <netdev+bounces-136304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679829A1422
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B61F2126B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE285216420;
	Wed, 16 Oct 2024 20:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F6218316
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110879; cv=none; b=LPig7k+0w+EgXFFv7m/XR8Ad+GE6jd+xtQ3Bj8GQ7q+QA0gkUN0ng+tgk8PiLNnb/jSgF36v2g1X2cXyBLwwXEaFLYqSI7aKXkPixhesDMNvulax3BLPfA11KpmTwrOrx6OXfGw2EzYp3hok+oHhMkqvUVoYy/OLtUsbm6TM08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110879; c=relaxed/simple;
	bh=Nvjo4PYyhKY9w7MrKBybkCJPn9QIaLvYGRDq/lpn+T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVMw/Sm+UHwQ/TMLFmdLvt/SSDYnTfwCJ2usHNJv1EmB6BXu2pXEl5WopXdl83KGp1wuvLJ6TIePo4+O7YKZo086qipAtB33n95lAniajxIe8mKe9kQ0Ev3jHgLgMRDfdC720WnVTLU4+I/n1amdq42rJW6iI8qdgPDt+Cv3Xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so2560755ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110878; x=1729715678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJT2InPH4w29lwtuj9iediEJp6ls1PqmzAo8fJkm2C4=;
        b=U4M3HzMgmKqll5/9EgTUL8w1JJY1NiwPQwFG9y8GEmDXywGOpyXEEsRwnHEv4i+Ht4
         yptteK096tspJtOPQK0MC4jfmOcCxt29lwA/bvi4URgPDGu48jOT2zdE7wSVO4ALYNK+
         RqCHu6XDz9+GG3YnidvL/FYV10bgMc8Zg9CoZ7dlHBQWx45HnkVv+Kr05fBZ/FpfZO8e
         s1seK3e9t1caL2YH0KLo0lGH1JewhW0e//VygtSdU3z2zDa9FZW/ROCiqEB+sU0jgjoR
         KQqdkvuQsx41JOk16iibD6pT2IN7Lx+3qWQj7AuDy0KDmfVtunqZVCTIH1qW7hwqJXis
         IPqA==
X-Gm-Message-State: AOJu0YxYVRCMSWoeHkF1rltsqErUB8AvtGy82XiuPYg3yUbRBVCSi7to
	LvL1w0fp/LBOddHEi0lToXYmR/iQaF8bi1Y+JqGdgpA5zOlpLPCqIOR7cNA=
X-Google-Smtp-Source: AGHT+IFTCVbveru/c3tj4k9J0SIhpcGZ1xZNOKAitnLi9372p+R+vneWPRR2uAluIa09LXNDR/2BRg==
X-Received: by 2002:a17:902:d50e:b0:20c:8907:90a with SMTP id d9443c01a7336-20ca13f732amr252355865ad.5.1729110877599;
        Wed, 16 Oct 2024 13:34:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805ca6bsm32703405ad.267.2024.10.16.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:37 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 12/12] selftests: ncdevmem: Add automated test
Date: Wed, 16 Oct 2024 13:34:22 -0700
Message-ID: <20241016203422.1071021-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only RX side for now and small message to test the setup.
In the future, we can extend it to TX side and to testing
both sides with a couple of megs of data.

  make \
  	-C tools/testing/selftests \
  	TARGETS="drivers/hw/net" \
  	install INSTALL_PATH=~/tmp/ksft

  scp ~/tmp/ksft ${HOST}:
  scp ~/tmp/ksft ${PEER}:

  cfg+="NETIF=${DEV}\n"
  cfg+="LOCAL_V6=${HOST_IP}\n"
  cfg+="REMOTE_V6=${PEER_IP}\n"
  cfg+="REMOTE_TYPE=ssh\n"
  cfg+="REMOTE_ARGS=root@${PEER}\n"

  echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
  ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/devmem.py        | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 182348f4bd40..1c6a77480923 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -3,6 +3,7 @@
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devmem.py \
 	ethtool.sh \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
new file mode 100755
index 000000000000..29085591616b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, wait_port_listen
+from lib.py import ksft_disruptive
+
+
+def require_devmem(cfg):
+    if not hasattr(cfg, "_devmem_probed"):
+        port = rand_port()
+        probe_command = f"./ncdevmem -f {cfg.ifname}"
+        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
+        cfg._devmem_probed = True
+
+    if not cfg._devmem_supported:
+        raise KsftSkipEx("Test requires devmem support")
+
+
+@ksft_disruptive
+def check_rx(cfg) -> None:
+    cfg.require_v6()
+    require_devmem(cfg)
+
+    port = rand_port()
+    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
+
+    with bkg(listen_cmd) as nc:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)
+
+    ksft_eq(nc.stdout.strip(), "hello\nworld")
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([check_rx],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.0


