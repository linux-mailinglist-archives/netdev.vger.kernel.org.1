Return-Path: <netdev+bounces-127896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F47976F66
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B401F22EF1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A51C0DCB;
	Thu, 12 Sep 2024 17:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE191C172D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161191; cv=none; b=QLjwnVu0H+N8Qd7Cd0YDV9WmaJT5SYnWHqQfheUUUnskuLfrnQfljawZQ0PdlLRIqGg22i7I0PZo6xMFfCjI9BZyoHMpguNl8y9oKjtcuj/GijAmDim15FP9JYZqTpM4pifHZB6uyny6JvoFPMdv858pElvV3K2rNNipPo5brSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161191; c=relaxed/simple;
	bh=7oLxcbQRmn+3arYJxRSLC70a1Lo0hbIRKyGSPf/VgUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fro2dEotCueC4B2ZaENV7mTBI5bor9jIzuw4Y4uBiUI5afCkYu3SmVFIkwzEtXHwyXpY0y62N5xBxMJXmS+BLiYCaEPtUFKx1IfDnFfwYJVPSYgZJZVkLqF+SdANT+R9MWfaLCU9pkXhgTaDhDg3ABtncxnAKH8Ps0DqLLmAFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2055136b612so16841915ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161188; x=1726765988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANPrqn/poK0SEPZlBGuiyz+Mam0cf6wHjUBvoH8Fniw=;
        b=KHrGKncq6hOSXRw/9c7fQW6Ax0Y/i1JYvInkRXTcj8v5HZ0KeNB5ZX0JGJEHtG2Cfb
         61uBIh+lsbpSNEbnscpA/uXNEOFxdQBSbevywxtnshGsbUa6umZpKK2Q8jSJQdiOlf0g
         tsEVXqLXD/E+0TmqC0dqME/ZxZBsQoyzyfP3IkpALJ31Nvu99OrBLCdZGVtdr8cFSZG6
         oit8W/YgfGmP0PQXkpBDIjgoR2Z4BKIOxFBsS5BfdPt4Tf/WjxPBD6mejH3AbfA+PhKs
         mz5mO9qpv3+P5Lg1FaQc2q/IoD5wEUlXNdZzi7+mP9fjnnNjUyEfSkSAl6MGCVOrLv7W
         2Qcw==
X-Gm-Message-State: AOJu0YwuAS9lh5dTdKadKLHvDFRI3VWu5puBYI9iuh942Ar4PlKtB5Oq
	XthNBF//UWNK9xnBd9cdRAdfRQBkOEHMzw3uFqkzYqAjT5pzx61ale7Y
X-Google-Smtp-Source: AGHT+IH8RmYpXkdTtqJxRAZ2QgEN1Sn3I0/njDd8I2S03Zh+KiuVzsO0UckfBl3IBbVUFsxjOaUjEQ==
X-Received: by 2002:a17:902:db05:b0:206:c12d:abad with SMTP id d9443c01a7336-2076e393e31mr67584275ad.34.1726161188715;
        Thu, 12 Sep 2024 10:13:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47935sm16550585ad.106.2024.09.12.10.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 13/13] selftests: ncdevmem: Add automated test
Date: Thu, 12 Sep 2024 10:12:51 -0700
Message-ID: <20240912171251.937743-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
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
  	TARGETS="drivers/net" \
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

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 tools/testing/selftests/drivers/net/devmem.py | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/devmem.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bb8f7374942e..00da59970a76 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -5,6 +5,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/lib.sh \
 
 TEST_PROGS := \
+	devmem.py \
 	netcons_basic.sh \
 	ping.py \
 	queues.py \
diff --git a/tools/testing/selftests/drivers/net/devmem.py b/tools/testing/selftests/drivers/net/devmem.py
new file mode 100755
index 000000000000..bbd32e0b0fe2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/devmem.py
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
+        probe_command = f"./ncdevmem -P -f {cfg.ifname} -s {cfg.v6} -p {port}"
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
2.46.0


