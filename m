Return-Path: <netdev+bounces-128145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A2978464
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA81F258CB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F301B12E6;
	Fri, 13 Sep 2024 15:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D21A42B0
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240163; cv=none; b=cXQXVbPR3c/Cpo53EpgfexxOpZwRyFpPcEl/DqtbMKJ+CgU6oyM4Z/ugc6VGboQIbVa2mLyk/s6HstnXpCoVlhIWiWCJEsNB0ajgaXuoJTdW/CFVx95shQ8bfnO1GrYk0b1ByCygb8EmduJAD0dSuBfDByoJnxBhETcW8Hh9kaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240163; c=relaxed/simple;
	bh=ZYWN3n6ucdJozX6O42zMIU/MpyULmYJOm+9L2OcYwz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h55PBG7Poa+6kx0IlPOyKZ2z8LFEisFQopkJsdI2Zl/33ANOWponnnUnCbUb9ftH2a55wfAQUJqyj/K5wTU64EZFIolKZ/h/PrMKRGZjHfogs0aTIEKnZcSERt/8xnhBhUmCscyyfIZqrmJZ7sUXB8OTb0fa/CyBFyR3cW4CS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71788bfe60eso1729127b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240161; x=1726844961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PysEvH6LRHCIcrZrATrymPpEHoDhPZT1iSJ/L62/Yo0=;
        b=UKJXcDMpCCjIW8xJ+xqS/zyR9jkAj36l0HHG9JHzVadWXeCzQ9ZWWAKehu46EJyIM5
         WFkBfVRuddS/qaj6q/dalwsN54Oc9m0QWFZmZWzZSZLG/bLHIqTsN/Un9NcY39zJQim7
         BrT/HWIH0AUpmTNCOvvtKURw+Yp9ke/mkWfo5sccfpQK4lGRqAO7z2SyXanDpDIe1GNu
         2thyUzGH3SJXdpneoDQ25/IJGC7Vp/vwKikoNGO1LTenyQiDMuyEWzFNmPucbWc40q5l
         9D1doqs4xQKXaH8Cemv7j+qGkijAa0wMuz2ReTECS5pp9dyZeBod9LVYuTYX2vI5qIMN
         xAkA==
X-Gm-Message-State: AOJu0YxxUx7+XOmux+tKuxigo9DP7iDJFocRApTnQb/DVF7vXcua+xsy
	SjhXqs7hvQEWbruQjkRaNFNT50+gc2KYSrasFlctVaUlfqmjs6xh3pIx
X-Google-Smtp-Source: AGHT+IFTcjBP5WcsHLzBJ1NW8S/vZ8e083/EYyFLaVZYGCgHcJtKo92vWGSGshPqCUfyYnyL5Ahpfw==
X-Received: by 2002:a05:6a21:78c:b0:1cf:47b3:cbbe with SMTP id adf61e73a8af0-1cf764c29f1mr10466194637.45.1726240161361;
        Fri, 13 Sep 2024 08:09:21 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c6f7asm6226720b3a.192.2024.09.13.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH net-next v1 4/4] selftests: ncdevmem: Add TX side to the test
Date: Fri, 13 Sep 2024 08:09:13 -0700
Message-ID: <20240913150913.1280238-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913150913.1280238-1-sdf@fomichev.me>
References: <20240913150913.1280238-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also add a combined tx/rx test to send bulk data.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/devmem.py | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/devmem.py b/tools/testing/selftests/drivers/net/devmem.py
index bbd32e0b0fe2..2e8903334d51 100755
--- a/tools/testing/selftests/drivers/net/devmem.py
+++ b/tools/testing/selftests/drivers/net/devmem.py
@@ -35,9 +35,44 @@ from lib.py import ksft_disruptive
     ksft_eq(nc.stdout.strip(), "hello\nworld")
 
 
+@ksft_disruptive
+def check_tx(cfg) -> None:
+    cfg.require_v6()
+    require_devmem(cfg)
+
+    port = rand_port()
+    listen_cmd = f"nc -l {cfg.v6} {port}"
+
+    pwd = cmd(f"pwd").stdout.strip()
+    with bkg(listen_cmd) as nc:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| {pwd}/ncdevmem -f {cfg.ifname} -s {cfg.v6} -p {port}", host=cfg.remote, shell=True)
+
+    ksft_eq(nc.stdout.strip(), "hello\nworld")
+
+
+@ksft_disruptive
+def check_txrx(cfg) -> None:
+    cfg.require_v6()
+    require_devmem(cfg)
+
+    cmd(f"cat /dev/urandom | tr -dc '[:print:]' | head -c 1M > random_file.txt", host=cfg.remote, shell=True)
+    want_sha = cmd(f"sha256sum random_file.txt", host=cfg.remote, shell=True).stdout.strip()
+
+    port = rand_port()
+    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port} | tee random_file.txt | sha256sum -"
+
+    pwd = cmd(f"pwd").stdout.strip()
+    with bkg(listen_cmd, exit_wait=True) as nc:
+        wait_port_listen(port)
+        cmd(f"cat random_file.txt | {pwd}/ncdevmem -f {cfg.ifname} -s {cfg.v6} -p {port}", host=cfg.remote, shell=True)
+
+    ksft_eq(nc.stdout.strip().split(" ")[0], want_sha.split(" ")[0])
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([check_rx],
+        ksft_run([check_tx, check_rx, check_txrx],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.46.0


