Return-Path: <netdev+bounces-130497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A518098AAF8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E8328A8F0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831D198850;
	Mon, 30 Sep 2024 17:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584C198853
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716696; cv=none; b=jmjqUf0XD+tSHGbk2GoV9G/7jhY80cf+PtmZVPwnRmNZdqBGws4+FdFWWQbqtneFhcQVC6r5AJQqK4kVWK2Sf/G68Vo76Iu3dy2wlmtoMywBHW6lNtSEeXAFxF/v3mitl5bygx4vUtzOjIWNjeV/4rx15qFnEd3RQWDCQ8VaExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716696; c=relaxed/simple;
	bh=sDP/mdVU0pmVlXrVoHaR9PIgvC/ZdssS9P6tKGZjrLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdemzFwYHrGIMz1Zv982qMV37pT0I0C/m5gPeHvjU2bRv0zttdfJqvSMthf3v48DGEveHIn/2L7aYrjtPN4ORGyztVqiBPwnJ2EGMIjQWHInj+kY0zUzX2mD08dr7lM3pAY6IyyllM+/j32GU/LMpzS+poH6g4psG/E3IrKeOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ba6b39a78so3427805ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716693; x=1728321493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJyN3pBvoyo39KdM1J+u0iy78SMZF3WVQmI1dSkIgrw=;
        b=wIs/tpRXUTnwCu4G9wYiSYLWNEA/M/HbnYAVlEPmmocUenzWdlJekV2VVIE8ebgNXZ
         Ygy+p8+K7YiIlB7BAz+d6GjCD39mKqQot0FINsIgv7WTmgNa/Q+5cI0zd9cmlx13MaCm
         sE9ICIkLfOmHD1rqt3/mAQnqt/HF/XodiyY8zGByiqA7Kj1vj2jszHThsstX1zlVW8/D
         QH4rn+0ViG3JPG8etm9zKSLDbhLBgfdmFIy0balXjSIzsN+QRBMPDa7lM40EHp35CI1k
         zYd7X3qwBL/5rKwEfdAHWIFWhnTDw4fWmZQqN3i4ZwidLL86jUJHRObHxL+v6Cs3IBfE
         Bsxw==
X-Gm-Message-State: AOJu0Yw5zof/5Qw9pQlIrrGD7+b9eICn097y1JoUBp9+Hp4hCb/fkKF/
	zfDW1U3QMCM0p05rVPypuQlWNWsfzkkqn3Z5W1Z4L61GAFED+lAV9GQ/
X-Google-Smtp-Source: AGHT+IFvjy37vN5TVj7vBAB41A+9dNgkSGepzm1ZccHXJukK2ZH+VpLfDt43QFlCSMg8fPXqtr91HA==
X-Received: by 2002:a17:902:dacf:b0:20b:8109:2c87 with SMTP id d9443c01a7336-20b81096217mr60926095ad.6.1727716693530;
        Mon, 30 Sep 2024 10:18:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60de3sm56853205ad.41.2024.09.30.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 12/12] selftests: ncdevmem: Add automated test
Date: Mon, 30 Sep 2024 10:17:53 -0700
Message-ID: <20240930171753.2572922-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
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

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/devmem.py        | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 7bce46817953..a582b1bb3ae1 100644
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
2.46.0


