Return-Path: <netdev+bounces-281413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEhdNp6T72ktDAEAu9opvQ
	(envelope-from <netdev+bounces-281413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FE476A9D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1829E300440B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876CC3D8904;
	Mon, 27 Apr 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="r9YYbavC"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8F262FC1
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308536; cv=pass; b=Je/wEXN0m9jJfh4cbzbcH3TmwJUUFcAlWBr1YAjg/ipmxJPuue9mi0h3UBUePt3dodrglxMbwqBIL7WVy44pjEuRuKveM23hV7w/op/KD5EqQrupxDZyw+5OfLkHTJuQXEJ3LoHByJUdSWcRCaq23HRdKbK8EbOph33Z4cLpxEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308536; c=relaxed/simple;
	bh=aqC0a0keFbnZlQgLThSZw8BINDOC1lsP8xAC5K/cHro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy/IkVTHFlmPOrNNlp3xFIm8qw86BGCeOhlQ18PeiGBaFdW2xsIapOYw3Ybzx1VL5Dtjv7qj86fQ535JjuQgAFGmIA2NYp/TDNeN0FlLtez+w0cyFLZ+S01enTwEQ6rC5kTEi6UA2AmKJ4BGJWd4TS3FF6QESux7KUXtApOT3fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=r9YYbavC; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777308460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKfJWcpviikrmU0dfqz1yRz/GNSYjWK6FmqwJGEuOCYQdXJ4MXVK37RN4cnpZqJCfpkyzRf/Gg+4M5HfnTUwUXF2tC3mhVHqDvmpOC7G3e2ShwVr46GIi135ZH18MtiHKvJq4MMvZT6xeArFUz9+zeMP5vOg+r3C8M3DFFvRNS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777308460; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3IxdQOvOhnX6R+oyBfw3xxLh7Rk6W2W1SWSKwxAL4Ck=; 
	b=iY9P6S0zLhFB9H+suPcpDtaj+DhGS3fu/hny/dWrzsExWquDOyVpdK4ssKT8T3LE56sMbxqCROpIIuNlABHqQ1jSGw0iwRlFT0M1lz55bkJQi3iFQg0Ba6F7B6d10TegAqpD5rd/jpAZJx9DvbLjG0pk7lGCpcs6kDEmPX2xAV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777308460;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3IxdQOvOhnX6R+oyBfw3xxLh7Rk6W2W1SWSKwxAL4Ck=;
	b=r9YYbavCbl922NEDlWW9hUqzb38tE5vpdTQVXxL+HP7a6RrLOICq/alanCain0zI
	/NjkhaQ0tgPlYVycBz34X7y8j/q1B1bCx+jUQzM+rwmi+sUW6ssW1mueK8EjxUZjxZH
	PzcvFIsoe8qLPFxLIqsH9A2LlXZB7KWm1euT68gD8xcwPU+guiB+DeGnHm9el1jd+vo
	sbYMHJfNzRcYdUMq1/DAViesDFQfQLblAxAX70ac5ZqablSmKMFFfW1Fe13cXkmcAjy
	TDo1vzVjsX97shDItztYWw8D4I8AnPnhgE8ZqVOqIJeL/Q2/yqWtlUXO6tx5Wig0qlu
	NN4Gettwbg==
Received: by mx.zohomail.com with SMTPS id 1777308457292863.8664036745548;
	Mon, 27 Apr 2026 09:47:37 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v4 net-next 3/3] selftests:net: Implement ptp4l sync test using netdevsim
Date: Mon, 27 Apr 2026 18:47:27 +0200
Message-ID: <20260427164727.15418-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427164727.15418-1-maciek@machnikowski.net>
References: <20260427164727.15418-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: D55FE476A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-281413-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:email,machnikowski.net:dkim,machnikowski.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,follower_log.name:url,leader_log.name:url,ptp.py:url,nssv.name:url,lib.py:url]

Add PTP synchronization test using ptp4l and netdevsim.

The test creates two netdevsim adapters, links them together
and runs the ptp4l leader and ptp4l follower on two ends
of the netdevsim link and waits for the follower to report the
synchronized state (s2) in its output log.

This implementation runs the test runs over IPv4 link.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/ptp.py   | 184 +++++++++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100755 tools/testing/selftests/net/ptp.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 231245a95879..a5fc28183896 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -69,6 +69,7 @@ TEST_PROGS := \
 	nl_nlctrl.py \
 	pmtu.sh \
 	psock_snd.sh \
+	ptp.py \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
 	route_hint.sh \
diff --git a/tools/testing/selftests/net/ptp.py b/tools/testing/selftests/net/ptp.py
new file mode 100755
index 000000000000..dd6f12cf3d91
--- /dev/null
+++ b/tools/testing/selftests/net/ptp.py
@@ -0,0 +1,184 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026,
+#
+# Self-tests for HW timestamping and 1588 synchronization
+#
+# This test runs a ptp4l leader/follower pair and waits for follower sync
+# state (s2), using one common execution path.
+#
+# By default, it:
+# - Creates two netdevsim instances in separate namespaces
+# - Assigns IPv4 addresses and links them together
+# - Uses those interfaces as leader/follower endpoints for ptp4l
+#
+# Optional: --leader and --follower override endpoints with existing
+# interfaces. Each argument can be either "ifname" (initial netns) or
+# "netns:ifname". Both options must be provided together.
+
+import os
+import shutil
+import subprocess
+import sys
+import tempfile
+import time
+
+from lib.py import (
+    NetNS,
+    NetdevSimDev,
+    KsftSkipEx,
+    defer,
+    ip,
+    ksft_exit,
+    ksft_pr,
+    ksft_run,
+    ksft_true,
+)
+
+PTP4L_SYNC_TIMEOUT = 40
+
+
+def _parse_interface_spec(spec):
+    """Return (netns_name_or_None, ifname). 'ns:ifname' uses that netns."""
+    if ":" in spec:
+        ns, ifname = spec.split(":", 1)
+        return ns, ifname
+    return None, spec
+
+
+def _strip_ptp_port_args():
+    """
+    Remove --leader/--follower from sys.argv. Return (leader_spec, follower_spec).
+    """
+    leader = follower = None
+    new_argv = [sys.argv[0]]
+    args = iter(sys.argv[1:])
+    for a in args:
+        if a == "--leader":
+            leader = next(args, None)
+        elif a == "--follower":
+            follower = next(args, None)
+        else:
+            new_argv.append(a)
+    sys.argv[:] = new_argv
+    return leader, follower
+
+
+def _run_ptp4l_wait_sync(leader_ifname, follower_ifname,
+                         leader_ns=None, follower_ns=None):
+    leader_log_path, follower_log_path = _prepare_ptp4l_logs()
+    leader_proc, leader_log = _start_ptp4l(
+        leader_ifname, leader_log_path, leader_ns, ptp4l_params=["-4"]
+    )
+    follower_proc, follower_log = _start_ptp4l(
+        follower_ifname, follower_log_path, follower_ns, ptp4l_params=["-s", "-4"]
+    )
+    defer(lambda: _stop_ptp4l(leader_proc, leader_log))
+    defer(lambda: _stop_ptp4l(follower_proc, follower_log))
+
+    deadline = time.monotonic() + PTP4L_SYNC_TIMEOUT
+    while time.monotonic() < deadline:
+        try:
+            with open(follower_log_path) as f:
+                if " s2 " in f.read():
+                    return
+        except FileNotFoundError:
+            pass
+        time.sleep(1)
+
+    ksft_pr(
+        f"ptp4l follower did not reach locked state (s2) within {PTP4L_SYNC_TIMEOUT}s"
+    )
+    try:
+        with open(follower_log_path) as f:
+            tail = f.read().strip().split("\n")[-10:]
+        ksft_pr("Follower log (last 10 lines): " + " | ".join(tail))
+    except Exception:
+        pass
+    ksft_true(False, "PTP sync timeout")
+
+
+def _start_ptp4l(ifname, log_path, ns_name, ptp4l_params=None):
+    cmd = ["ptp4l", "-i", ifname, "-m", "-P"]
+    if ptp4l_params:
+        cmd.extend(ptp4l_params)
+    if ns_name is not None:
+        cmd = ["ip", "netns", "exec", ns_name] + cmd
+
+    log_file = open(log_path, "w")
+    proc = subprocess.Popen(cmd, stdout=log_file, stderr=subprocess.STDOUT)
+    return proc, log_file
+
+
+def _stop_ptp4l(proc, log_file):
+    try:
+        proc.terminate()
+        proc.wait(timeout=5)
+    except (OSError, subprocess.TimeoutExpired):
+        try:
+            proc.kill()
+            proc.wait(timeout=2)
+        except (OSError, subprocess.TimeoutExpired):
+            pass
+    finally:
+        log_file.close()
+
+
+def _prepare_ptp4l_logs():
+    leader_log = tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".log")
+    follower_log = tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".log")
+    leader_log.close()
+    follower_log.close()
+    defer(os.unlink, leader_log.name)
+    defer(os.unlink, follower_log.name)
+    return leader_log.name, follower_log.name
+
+
+def ptp_sync_test(leader_spec=None, follower_spec=None):
+    if not shutil.which("ptp4l"):
+        raise KsftSkipEx("ptp4l command not found. Skipping PTP sync test")
+
+    use_custom = leader_spec is not None
+    if use_custom ^ (follower_spec is not None):
+        ksft_true(False, "PTP sync: specify both --leader and --follower or neither")
+        return
+
+    if use_custom:
+        leader_ns, if1 = _parse_interface_spec(leader_spec)
+        follower_ns, if2 = _parse_interface_spec(follower_spec)
+
+        _run_ptp4l_wait_sync(if1, if2, leader_ns, follower_ns)
+        return
+
+    with NetNS("nssv") as nssv, NetNS("nscl") as nscl, \
+         NetdevSimDev(port_count=1, queue_count=1, ns=nssv) as nsimdevsv, \
+         NetdevSimDev(port_count=1, queue_count=1, ns=nscl) as nsimdevcl:
+
+        nsimsv = nsimdevsv.nsims[0]
+        nsimcl = nsimdevcl.nsims[0]
+
+        ip(f"addr add 192.168.1.1/24 dev {nsimsv.ifname}", ns=nssv.name)
+        ip(f"link set dev {nsimsv.ifname} up", ns=nssv.name)
+
+        ip(f"addr add 192.168.1.2/24 dev {nsimcl.ifname}", ns=nscl.name)
+        ip(f"link set dev {nsimcl.ifname} up", ns=nscl.name)
+
+        nssv_path = f"/var/run/netns/{nssv.name}"
+        nscl_path = f"/var/run/netns/{nscl.name}"
+
+        with open(nssv_path) as nssv_file, open(nscl_path) as nscl_file:
+            link_val = f"{nssv_file.fileno()}:{nsimsv.ifindex} {nscl_file.fileno()}:{nsimcl.ifindex}"
+            NetdevSimDev.ctrl_write("link_device", link_val)
+            _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
+            NetdevSimDev.ctrl_write("unlink_device", f"{nssv_file.fileno()}:{nsimsv.ifindex}")
+
+
+def main():
+    leader, follower = _strip_ptp_port_args()
+    ksft_run([ptp_sync_test], args=(leader, follower))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


