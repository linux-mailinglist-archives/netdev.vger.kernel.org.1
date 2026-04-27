Return-Path: <netdev+bounces-281478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOkkF+/E72lsFwEAu9opvQ
	(envelope-from <netdev+bounces-281478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:19:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7008479EBE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C8EC30360AE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852BA34D911;
	Mon, 27 Apr 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfVqdmH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC62D8DCA
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321013; cv=none; b=g+htSsfqCq/7qzN3LsPfkluq7K0NovzE0vVfPqtk7nMP2FPqBEHsSj+urvSJKiFQtOjOPvk3qAf8lj2RlWlbOWcHpEVDDr7oyNtgBvSEtL4PJicUF68sGkCnpU9lcxgxwX+LYw4/SLRc4JcD0o8e1eeiNodp0Ayuf356bYm8BIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321013; c=relaxed/simple;
	bh=gB7P3eJLm7f6gdrmg5tjypKWSxIGKIEJjikDtq+N/PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CssTylTb15n9f5CUzlWniqBiWSkuUH5Tlf4PH8RlBst8uSanaZqjoDvTyF8voPGIwMSvrFtxehbNRmm7cXTMHFWCgcRsi1xC8nGdPQnfl0ZJkS/mhv2FWrWpckneLL6X/MHR0mjxJQVkZ/TmDUmZgpaVdUEtWzJtiP3cinW6HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfVqdmH0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ea87af213so163479417b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321010; x=1777925810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/f7yMoR7muS6QO32XzrM5AFad/LSJYKKcs2Y+rabA8=;
        b=TfVqdmH0RuyTaPLxCv48IA3fJNjPKZaLAS7PYfZltiLaIXx6ZacNtbhBFy1wifISiC
         mihpMRoizGn4iSgeEoI8f/kADnt2bZHobP+Fr6f47eRHPIiCVJmBjvg4VpXy6F8gABEH
         rxxYiU43bNqCjuuLhQBYlz14YfdfUkq0I6EItrC1zqpoZNBmoIUOJu9b/eOzQeuCC8v1
         /TLtOvziTTbdYyVE9eRZx1Kv370ESZD5rD95nQZVwIpJkaFHQZl447QJDZ31DMME8X/4
         kSRLmFwgKpyTFE+I3rKcFzxlZVaXyYa/CvaEw+zGOG6skMxnEwSUJ9LTryoAdn9JHHU6
         stMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321010; x=1777925810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/f7yMoR7muS6QO32XzrM5AFad/LSJYKKcs2Y+rabA8=;
        b=ESfMYuoz2b+cWJrbcEi5F91H+LPJZMz2pGDBwx3aIg82FdGit8WxFLN1sVM4dpdWQ9
         nM+CPwY8z1hRsCXtl4iPgo/J2KJ99sfvtPiutpG5xOFhFTBmeqb+JnFMxsX35ynzws6z
         rMhptE1eq4n/Ord5E+nJFvT9abzQnE2ENhiLg5TfajQPE9G40uesCseAxC3tDtfImj/P
         RwvlZSKENw4wfTkAwZfNXhsgbUpHgPIpIpAwGsa4YT3huGEpKvGCzfyWLPaP4TUjIofN
         MgMcuBcj8JhlG+Bj27M2qIdMpnzUGUwcgM7B3Yz3O7t+J6FRbCN2tOLQTtOeHx+D1wef
         ukuQ==
X-Gm-Message-State: AOJu0YwfvjGUdPgZAQND6ihAn3PDmIX851a6cemHMxSfk9DTbJgqBa3L
	PoSraTomc1sKO35HT//hSkcWDiX1+PIItjkJBbWvExsRkpJ+B3YGBtYIH/k2i/d8
X-Gm-Gg: AeBDieukAJggm4yGOQn34e0zUl5grHjPajY9nc9Lq3NlXCexyHk0v1aCMhxrZ1O8Tib
	yQu8reNXq1KUXheS9o7FUmpycUgkE9ZcorY3qZXSYPBAQWzGy63PbQF2cA7iBRq7kOcm3jYluF9
	tTn7bnUvFZd27OgrHBbv+puT4k/iqXsMpHihrMBzmAU03d14nrEu3iaqVjdd8xPqwMB9n0p7TZI
	lK0VRiRCP3Z9QtxtA2DeNqFJBZ/3TVUK2k+XG5aoXSXCsYb8sHOUwKa+s7cJ4M1I7w9elg3MIRR
	YBzU/WLo/CjBj9Sx8DENEPCVyZxCUWcd0O6LjJ2yEARwoMkyicOInMq2LwViSuO8j8j13FP8YLB
	sRVafpA/z44X1G95c/1PrCcd69iyttrifrIYU4acX1M/UR+WQehig9WT2j+JLXpuA4OIAD9jTu3
	fD2wEnysWVWvSn1u4vIhWLEcx5tu6sh8GGERdo/tEqT0aSYP54vaYULeqTjQupCSn0dCobTOpVE
	AmQRDhnpRy/HZJLkKV5Xw92k3JqXpDgGM4FYQ==
X-Received: by 2002:a05:690c:398:b0:7ba:f2f1:86ef with SMTP id 00721157ae682-7bcf36ec6ddmr1974497b3.35.1777321009793;
        Mon, 27 Apr 2026 13:16:49 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e6149sm1753387b3.11.2026.04.27.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:16:49 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 2/3] selftests: net: py: add tc utility
Date: Mon, 27 Apr 2026 16:14:34 -0400
Message-ID: <20260427201640.294694-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
References: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7008479EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281478-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

Add a wrapper similar to existing ip, ethtool, ... commands.

Tc takes a slightly different syntax. Account for that.

The first user is the next patch in this series, converting so_txtime
to drv-net. Pacing offload is supported by selected qdiscs only.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/lib/py/__init__.py |  5 +++--
 tools/testing/selftests/net/lib/py/__init__.py       |  4 ++--
 tools/testing/selftests/net/lib/py/utils.py          | 12 +++++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 2b5ec0505672..09aac4ce67bc 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -23,7 +23,8 @@ try:
         NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, rand_ports, tc, wait_port_listen, \
+        wait_file
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
@@ -36,7 +37,7 @@ try:
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "rand_ports",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports", "tc",
                "wait_port_listen", "wait_file",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 7c81d86a7e97..64a8c1ed4950 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -14,7 +14,7 @@ from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
-    wait_file, tool
+    wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
@@ -29,7 +29,7 @@ __all__ = ["KSRC",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
-           "wait_port_listen", "wait_file", "tool",
+           "wait_port_listen", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index ef31c0ba47fc..165adf33e1b5 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -224,7 +224,10 @@ class defer:
 def tool(name, args, json=None, ns=None, host=None):
     cmd_str = name + ' '
     if json:
-        cmd_str += '--json '
+        if name == 'tc':
+            cmd_str += '-json '
+        else:
+            cmd_str += '--json '
     cmd_str += args
     cmd_obj = cmd(cmd_str, ns=ns, host=host)
     if json:
@@ -242,6 +245,13 @@ def ip(args, json=None, ns=None, host=None):
     return tool('ip', args, json=json, host=host)
 
 
+def tc(args, json=None, ns=None, host=None):
+    """ Helper to call tc with standard set of optional args. """
+    if ns:
+        args = f'-netns {ns} ' + args
+    return tool('tc', args, json=json, host=host)
+
+
 def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
-- 
2.54.0.545.g6539524ca2-goog


