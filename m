Return-Path: <netdev+bounces-287510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJyvNDFKBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:53:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D985530FA1
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4E93108DC0
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962638E12D;
	Wed, 13 May 2026 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="RDgys6LD"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5C391517
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665615; cv=pass; b=MCoAP2MVeeDv52ZaRfte/eXDyBXVrDxJuQ0Zu+E4B0n3cl23CHWwlmxCtcAXbjejglQhfqLZEIUgQvqw+NInb8Ukrv4wdVnYeFh3rMqa5zhq7lQtqpeRsB1jYQtHAoPPBkJ4hFbMPt0hr8WJOKQcbPbhBQuZUBUjgxRpHysYBvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665615; c=relaxed/simple;
	bh=EZfPrF10jUmaLT40C/rVjIvTmth59Dthg5miatjGPxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhGueSDedN7UNRA+sIx3Vl/D2bOgSeBHocCCjKWjlsxa7gdKkaGN0soR/Vb7DkLtoHU7QaVRFsuw+PXyQYxhgWzqXGTJe3feu6UHl0TYZCy+DT0xQ1ovK+EXIC544D6kbbt5L+N4isblTOJubWOqMGE8uTQDkc9knzzV5BTobBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=RDgys6LD; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1778665534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AVvWwqXCEQz10CnBiplQmDkUU9imdknUELcMrze16KsiGG0ty1wPAWsnefESUWNAvqxh+Kg3PrPtCaYJTWmpBtyDpeHm06xSaFsye9QuCkWpg+Jd/QbQ12YKDmHhwWCop+UC08kQ7CPftu/YM3FImfADas8DpbZsX2egPpcrisM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778665534; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QMy3ZYIl/v9GathV4sHM17Hg10iUz+FHrkNQtzwhLk8=; 
	b=Hkb2AL4BkF652F+yah+yNh2vMS6gS6okrNEsQwdoP++xwNvns+8JG3HUlr+XvKo5jdrYwJMLiC0k4gFPJJ0yUdtCZKNxzVfgb4g6G+EM4s+A0MvgT87WEuNFCkDcmslxzPPtYW5RbCwt1AnFTWJ79FEAUc1h+20ScC99raD16ZQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778665534;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QMy3ZYIl/v9GathV4sHM17Hg10iUz+FHrkNQtzwhLk8=;
	b=RDgys6LDVNBjntVqveHgxEV1X15A1Lho7HDyhoaM/6xHr+f1VboJtMrhUo64V1a7
	sAIf+fEjotFNQTed0Rw0ZM+v0O+YWZcbtQ50ePN81y/Wry3s6FnWB1zC1VmH+IL1z1V
	cu9kkb7+HqhinEnCRF4q8Uz+mBTseVUAqISLLeJbUjEBrof6Lz9G834uf/6VuoYkHE/
	XmSRoQZNtd6BphIX6hDm2QUKrCwEaxKPiFXhXMYKeOgAA2rlADpJOwukAS9WQFkwFf8
	hpGnANEBXBibiy2z25W2Ig04SPts8lB9WEVr7/TAMml8MSBxZO+1B4GFts80pMpwH7I
	cljpqdCRSQ==
Received: by mx.zohomail.com with SMTPS id 1778665532954402.40426642659213;
	Wed, 13 May 2026 02:45:32 -0700 (PDT)
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
Subject: [PATCH v6 net-next 3/3] selftests:net: Implement ptp4l sync test using netdevsim
Date: Wed, 13 May 2026 11:45:20 +0200
Message-ID: <20260513094520.325693-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513094520.325693-1-maciek@machnikowski.net>
References: <20260513094520.325693-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 2D985530FA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-287510-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,follower_log.name:url,machnikowski.net:email,machnikowski.net:mid,machnikowski.net:dkim,ptp.py:url,lib.py:url,nscl.name:url,nssv.name:url]
X-Rspamd-Action: no action

Add PTP synchronization test using ptp4l and netdevsim.

The test creates two netdevsim adapters, links them together
and runs the ptp4l leader and ptp4l follower on two ends
of the netdevsim link and waits for the follower to report the
synchronized state (s2) in its output log.

This implementation runs the test runs over IPv4 link.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/config   |   1 +
 tools/testing/selftests/net/ptp.py   | 184 +++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100755 tools/testing/selftests/net/ptp.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5ca6c557fc3f..6ccb28176524 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -71,6 +71,7 @@ TEST_PROGS := \
 	pmtu.sh \
 	protodown.sh \
 	psock_snd.sh \
+	ptp.py \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
 	route_hint.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d07c5ac5cab7..a2a54e1767f4 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -135,3 +135,4 @@ CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
+CONFIG_PTP_1588_CLOCK_MOCK=y
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
2.54.0


