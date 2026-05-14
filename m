Return-Path: <netdev+bounces-288062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBkXHeIFBmrTeAIAu9opvQ
	(envelope-from <netdev+bounces-288062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F75454AC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60F6A3044466
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4E3D7D9E;
	Thu, 14 May 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbNE0fqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67A392838
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779385; cv=none; b=Av3qsrbCtb8S5R8s/iPpMzHCHFrykYeqmrhawnR/XSG6FJ8IGPRLlljL9TloNkpJ/0Hys+SmeB7l3PtpumAnYBCboOW7MGVrpjxI4Ps43Qg3a2qSaKAYoPSeE48LCZeCfrKS46soe+erIcB/F+QMYQF2twBr5IWNz27negredG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779385; c=relaxed/simple;
	bh=EDyBqkyN5bDm600u/I66EqsZzueKCojlerqIBUvyphs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uimFGME2V6iI4H5EJn6mX/woiYguBKBWUnAXlGlgbw4P5Kz+mtCvrGw98dfazIaQ0Lv6ztQj3t2FWrRbVixKP3mf0rI2NY0oa+SOry3M9D+rtWJqGOPSk1CaMdNaAienvAPzAZ+Hiy/z6/GQrqzr0bRNYmoqLRhDMUk73YRLrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbNE0fqG; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de7dc85b74so6733612a34.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779379; x=1779384179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=EbNE0fqGgztfEhlDW8IO7XoiGkpsuYndZ6xw/l+/6KOaeGXducdM7IGPNHTwgx9Uyc
         IOnE3akvzeLJ/calq8q0VCT9+GIrxnoigU88AI5AqSKI7DkJOIyRAC0dym5wt8gQkuLn
         vYvkpL8oPwe1alB7ptzJD6B+WPBFT3G0ThHplSa7rZAHgkmGdWx1HWlx5ct6s+a6Pb+f
         pWBeolusN/C7fbIYzE/OrN10SjNljgi6j9FcGmD/zGXOxpDi2n41GKGXD5jrLoaGy6A8
         IDc21bQ3Rlh6YVmQ5Q8ytHLLq3jU2NLB/rFJ645f9dpU9cEpvvVP5lbyj+fPvBiJ9DSb
         NHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779379; x=1779384179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=PSOhfeodYob4mTdYp0lsh8dS/8UjIsiQyQrwuunyeVwUtPjkWle+Pg044eidjrAcCR
         /8UC9TVAC/mZUFumP1pKjjE6raoFZOC/xuz622fFUsMgHQgXuqnmifkdRUlTeRPBWX5V
         UWDqC5he+sXDRAHfYZma1kRX7Xt2u2vbx89cvwcYni7Rx1jBg2CS0v4BXgCvwifOWN2b
         L4p+ao+1MlWJu8OtPRYiTlKvQPXJvLR0SGXWmL+JW4BaOJcV8W3RYWTbYURNPGz6XvGG
         3wowhzxvt4izOCu6hkBzpzK4TUYGC31z5WlLsB0e3J5CSYR1BPw6Ohc842lDYKeXCsKQ
         bAgw==
X-Forwarded-Encrypted: i=1; AFNElJ9tmOINg3a5VrttKHScD17coZUJKIkueE7IBkcKUqmMzG4P3yaEpWr047Tb/TUnwUUVlv4c8HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX5lZmCwD+QpwAeb0CTHh7BOFLos0rqknUqcvSETKYp/ZOq7D
	+Of7+Ai8LN4DJG73oJ2psqWHblo3GyOknv8ECHDbAAdLTzI3oSZ/H0Ic
X-Gm-Gg: Acq92OEY/sFdLFGbKG3our8RR1B3E9O0w0lzfzyum3wlNS9IvKtg2MA/lclplliptl1
	v/xJFvG0sAgc8WC8UsJVcLf1X/Qj2cYMBTSjkvmyXqDPb4HfSrrYmvuwI1mjo73z+zhLAuvlfii
	RGCyT3I+NBOv353o+0w9yQ6Tlq2dudjL6Q9e4UeLHlQkkou9T//1HilCpbKdFYMuwU+asm0CK5P
	X57I+EQY/MNXxqmFeg7mK76YBxYNVyMTnvyp9QcjELklxyI2V/QTDb45hZ3YJw8ou0v2IH9Op+h
	E62mu3+acVgUlDjZRytwmKXmTFGa+qihzuUVybPPVew0p5WnplF+hAt+OFVx7UyEQNn0bDuIjcq
	xAjgeSdtO2R+hoRKqvQTAfZ9YLqvN2nCyUVgXs3/ch/LXjAzQemMMZat/bF0Pg8cobvRG3kabde
	dCQXrNh40qOpwnmTEzVkQ54Q==
X-Received: by 2002:a05:6820:81c7:b0:69b:8c73:e921 with SMTP id 006d021491bc7-69c942ef1femr249405eaf.20.1778779379501;
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:6b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc1e7bc7sm2229037fac.7.2026.05.14.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:35 -0700
Subject: [PATCH net-next v5 8/8] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-8-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 5C4F75454AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288062-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nk_devmem.py:url,devmem.py:url,lib.py:url,fomichev.me:email,meta.com:email,meta.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device.

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface, then calls a
shared run_*() helper which probes for devmem support and configures
the NIC (HDS, RSS, queue lease) before driving the test. NIC state is
restored per-test via defer() callbacks registered inside the helper.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- Move require_devmem() inside test functions so ksft_run() reports it
  as a SKIP (Sashiko).
- Drop the inaccurate "mirroring the nk_qlease.py pattern" claim from
  v4 (Sashiko).

Changes in v4:
- Call configure_nic()/cleanup_nic() once around ksft_run() rather than
  relying on per-test configuration inside the run_* helpers.

Changes in v3:
- Reorder os.path expressions
- Drop @ksft_disruptive from check_nk_rx_hds to mirror the original
  check_rx_hds in devmem.py

Changes in v2:
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
---
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 46 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5e49d7bffced..c7a1206880ea 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_devmem.py \
 	nk_netns.py \
 	nk_qlease.py \
 	ntuple.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..300ed2a70ab4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+import os
+from devmem_lib import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
+
+
+@ksft_disruptive
+def check_nk_rx(cfg) -> None:
+    """Run the devmem RX test through netkit."""
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx(cfg) -> None:
+    """Run the devmem TX test through netkit."""
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx_chunks(cfg) -> None:
+    """Run the devmem TX chunking test through netkit."""
+    run_tx_chunks(cfg)
+
+
+def check_nk_rx_hds(cfg) -> None:
+    """Run the HDS test through netkit."""
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    """Run the netkit devmem test cases."""
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg,
+                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                "ncdevmem"))
+        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
+                  check_nk_rx_hds], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.53.0-Meta


