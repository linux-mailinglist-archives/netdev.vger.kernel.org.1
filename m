Return-Path: <netdev+bounces-133835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96E9972CE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417621F2304A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4A1E1C2A;
	Wed,  9 Oct 2024 17:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFE1E1C06
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493990; cv=none; b=cTAQzoWvyZ7r5+SNOw2fCHYdY9syxsELWhLj0iaQCqtrlX/+V/bHd94PtPk5ooflxkBeu921wGtwfj7iwHYEgFsWl/hKvMepFaqM5AEHVUb8uJKBYi8sAHtNKBNJ6HTkKddW9o9+KN+AJbOUSNmFrJj7SC3oskp8ChFYtsOVD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493990; c=relaxed/simple;
	bh=1zS+u1GiVC18xnG9Aw7f0ISl9pzrHe286vIjgalAdio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay2jKt2pr7CKJVariXLzJ+ojV8EE1jxINGOQeFGmbsPB30RZMBVG8RIgkrilMeVYKpZzqKTHKs5id1jb03sYFKnS4XllvCl7akqaB9gcutyBB4Ix3gXJ4ZLUFCN5UllsmngGiAWapPPjVjnRgtx/k1VGyf8A2UE4Va6TjcTR9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea24595bccso948500a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493988; x=1729098788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFE5W/FSE3W/X2d1D2QPcYtHfiVNlbp2Z4vuTencDjs=;
        b=arVyqDR+EdzIAHAUu1UUtntpIfWgSKsXQ6fnQiZex60cqwHhDVB3eoAoumcAem22OV
         2kWlZ94zSOJWmdyUth3XiTUYSgWT+8DZCHBcuQr5niqvicLMXv8bR1ozqWKIjF1oQ3Ng
         49VGuUkcw3gL2scFw1epwL4KuJu9x5du2RQzYQ0gwozDcZujn5KTZVw1j3p/rZPqOCp7
         VcMWnVs5tBRIgh9fqU9M7LD96fUmPLKYA6yaaTZjHB51isZxE7kHe/dW9x0Jp2Z9HFTd
         SkKRJF4Ak0HrmH0XxfNa3oZ5+w3vRgIpNOR594xMOZckmELZJIsozJL0/Yec/b0AI/Yk
         Ux0g==
X-Gm-Message-State: AOJu0YwkZUJkwvEwMRx+MwCl5EobuzfCoYAuwP+vipSl6NaCG0XFxI+i
	bj4sRt8oZgMuhVUH5dMWcwxqN0t5zPqQbZrQQVTpkwgq8YJfc1en+JAB
X-Google-Smtp-Source: AGHT+IGI5jTRyoA+8mdBCa+UcduYSkdpE6A0U6Gy1K4ltCG1nzRKzZKVTZ/XVjmQAyfli6KKrtDxwA==
X-Received: by 2002:a17:90a:6fc6:b0:2d3:d95a:36dd with SMTP id 98e67ed59e1d1-2e2a21eec83mr3214970a91.8.1728493988084;
        Wed, 09 Oct 2024 10:13:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a57078dfsm1985503a91.16.2024.10.09.10.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 12/12] selftests: ncdevmem: Add automated test
Date: Wed,  9 Oct 2024 10:12:52 -0700
Message-ID: <20241009171252.2328284-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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
2.47.0


