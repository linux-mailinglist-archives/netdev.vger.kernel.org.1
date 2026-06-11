Return-Path: <netdev+bounces-298001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tzp+Ni1xKmqbpQMAu9opvQ
	(envelope-from <netdev+bounces-298001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE366FD64
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=EtRwFbbT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298001-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298001-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02570314CB82
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE6379C3C;
	Thu, 11 Jun 2026 08:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D7371065
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166334; cv=none; b=U7WAq+8PxjabPEIh0Ab3Qm5J+UjdMMFAe9gF7AjKpeaNc9EgRZEs0kMZHG6qbip5Kb7puO0y1ycDEcOzgyGce+ScsVjtHMgZvy8mfC955nW72onVBxKxZqXxuMLh7FwEydJY/5QqrFoLQZAq+cEOs0C99/hiDcb0XWuJ4dWudeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166334; c=relaxed/simple;
	bh=qAw5p1q2v/LswChQoDgejpz3lSwHDfl48etqRxtF8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2c9SUH7Xu0LwbWWeL+3Oo6coThCGBZV8WhdlCkC1jaKoqt8Jw3VIbAmsmLMqsMOSW62Oryh7MGGyjjjrN0I5vwbeuLOsmlUyLoNjz1YuNO+M42069inUAD/1woiQ/mbuGhkeYAoGUs1QEnRQlqI4gcaff7+BM/DDxFcvv9tkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=EtRwFbbT; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ps3koCioJLbvgKi6/iKDPXETD088KRJ+1cCtWHzAJ6I=; b=EtRwFbbThsY2iE/FP+TsHdFwVN
	fX4uMzHf3ZdTBLarqzjEvndrhfUoNbDNI1MNUS5FFWChwE07ML6bD5q97qElxq5Ut2rOlYf4VvNr0
	KdbaPadA+6rhQesozVtHHFkWFpV4zq1YbaQEmWsalH4SfbstbVD0u4JB3uaXpgsd1BqzWCwNtBsQZ
	EKF+5ojPKnPYPUddsexgOtxs1Dm95rrJGu5MA3cE06HTGIRdKn4dNQpxcuc9b99/MwHpLEObpa8oe
	icFFyqaZEVEtIvrzjndoRP3HIRVhpAYcZDcuY8siLEt51l3ngDkTZ9UaeGl2oUfGFDfu4TAxHawe+
	/3Nqqk7w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXajC-0009s2-09;
	Thu, 11 Jun 2026 10:25:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/4] selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
Date: Thu, 11 Jun 2026 10:25:25 +0200
Message-ID: <20260611082527.741674-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611082527.741674-1-daniel@iogearbox.net>
References: <20260611082527.741674-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28028/Thu Jun 11 08:27:22 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298001-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,vger.kernel.org:from_smtp,netns.name:url,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51EE366FD64

Expose the netkit host ifname as a public attribute nk_host_ifname
(symmetric with the already-public nk_guest_ifname), rename _attach_bpf
to a public attach_bpf, and add a public detach_bpf helper that
encapsulates the tc-filter teardown bookkeeping. Switch the fixtures
to this public API. No functional change and keeps pylint happy.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../selftests/drivers/net/hw/nk_qlease.py     | 33 ++++++++---------
 .../selftests/drivers/net/lib/py/env.py       | 36 +++++++++++--------
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index c7cb039b8181..b97663820ccf 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -34,16 +34,11 @@ from lib.py import KsftSkipEx, CmdExitFailure
 
 
 def _create_netkit_pair(cfg, rxqueues=2):
-    if cfg._nk_host_ifname:
-        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
-        cfg._nk_host_ifname = None
+    if cfg.nk_host_ifname:
+        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
+        cfg.nk_host_ifname = None
         cfg.nk_guest_ifname = None
-    if getattr(cfg, "_tc_attached", False):
-        cmd(
-            f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}",
-            fail=False,
-        )
-        cfg._tc_attached = False
+    cfg.detach_bpf()
 
     all_links = ip("-d link show", json=True)
     old_idxs = {
@@ -79,17 +74,17 @@ def _create_netkit_pair(cfg, rxqueues=2):
         raise KsftSkipEx("Failed to create netkit pair")
 
     nk_links.sort(key=lambda x: x["ifindex"])
-    cfg._nk_host_ifname = nk_links[1]["ifname"]
+    cfg.nk_host_ifname = nk_links[1]["ifname"]
     cfg.nk_guest_ifname = nk_links[0]["ifname"]
     cfg.nk_host_ifindex = nk_links[1]["ifindex"]
     cfg.nk_guest_ifindex = nk_links[0]["ifindex"]
 
     ip(f"link set dev {cfg.nk_guest_ifname} netns {cfg.netns.name}")
-    ip(f"link set dev {cfg._nk_host_ifname} up")
-    ip(f"-6 addr add fe80::1/64 dev {cfg._nk_host_ifname} nodad")
+    ip(f"link set dev {cfg.nk_host_ifname} up")
+    ip(f"-6 addr add fe80::1/64 dev {cfg.nk_host_ifname} nodad")
     ip(
         f"-6 route add {cfg.nk_guest_ipv6}/128 via fe80::2 "
-        f"dev {cfg._nk_host_ifname}"
+        f"dev {cfg.nk_host_ifname}"
     )
     ip(f"link set dev {cfg.nk_guest_ifname} up", ns=cfg.netns)
     ip(f"-6 addr add fe80::2/64 dev {cfg.nk_guest_ifname}", ns=cfg.netns)
@@ -102,7 +97,7 @@ def _create_netkit_pair(cfg, rxqueues=2):
         ns=cfg.netns,
     )
 
-    cfg._attach_bpf()
+    cfg.attach_bpf()
 
 
 def _setup_lease(cfg, rxqueues=2):
@@ -135,9 +130,9 @@ def _setup_lease(cfg, rxqueues=2):
 
 
 def _teardown_netkit(cfg):
-    if cfg._nk_host_ifname:
-        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
-        cfg._nk_host_ifname = None
+    if cfg.nk_host_ifname:
+        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
+        cfg.nk_host_ifname = None
         cfg.nk_guest_ifname = None
 
 
@@ -320,9 +315,9 @@ def test_destroy(cfg) -> None:
     kill_timer = threading.Timer(1, rx_proc.proc.terminate)
     kill_timer.start()
 
-    ip(f"link del dev {cfg._nk_host_ifname}")
+    ip(f"link del dev {cfg.nk_host_ifname}")
     kill_timer.join()
-    cfg._nk_host_ifname = None
+    cfg.nk_host_ifname = None
     cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 2cc78b8a2152..e1038a02760e 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -341,7 +341,7 @@ class NetDrvContEnv(NetDrvEpEnv):
                  userns=False, **kwargs):
         self.netns = None
         self._userns = userns
-        self._nk_host_ifname = None
+        self.nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
@@ -395,23 +395,23 @@ class NetDrvContEnv(NetDrvEpEnv):
             raise KsftSkipEx("Failed to create netkit pair")
 
         netkit_links.sort(key=lambda x: x['ifindex'])
-        self._nk_host_ifname = netkit_links[1]['ifname']
+        self.nk_host_ifname = netkit_links[1]['ifname']
         self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
         self._setup_ns()
-        self._attach_bpf()
+        self.attach_bpf()
         if primary_rx_redirect:
             self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
         if self._primary_rx_redirect_attached:
-            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
+            cmd(f"tc filter del dev {self.nk_host_ifname} ingress", fail=False)
             self._primary_rx_redirect_attached = False
 
         if self._primary_rx_redirect_clsact_added:
-            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            cmd(f"tc qdisc del dev {self.nk_host_ifname} clsact", fail=False)
             self._primary_rx_redirect_clsact_added = False
 
         if self._tc_attached:
@@ -427,9 +427,9 @@ class NetDrvContEnv(NetDrvEpEnv):
                 host=self.remote, fail=False)
             self._remote_route_added = False
 
-        if self._nk_host_ifname:
-            cmd(f"ip link del dev {self._nk_host_ifname}")
-            self._nk_host_ifname = None
+        if self.nk_host_ifname:
+            cmd(f"ip link del dev {self.nk_host_ifname}")
+            self.nk_host_ifname = None
             self.nk_guest_ifname = None
 
         if self._init_ns_attached:
@@ -470,9 +470,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
-        ip(f"link set dev {self._nk_host_ifname} up")
-        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
-        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+        ip(f"link set dev {self.nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
 
         ip("link set lo up", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
@@ -512,7 +512,13 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return map_id
         raise Exception(f"Failed to find .bss map for prog {prog_id}")
 
-    def _attach_bpf(self):
+    def detach_bpf(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref "
+                f"{self._bpf_prog_pref}", fail=False)
+            self._tc_attached = False
+
+    def attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
             raise KsftSkipEx("BPF prog not found")
@@ -539,9 +545,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not bpf_obj.exists():
             raise KsftSkipEx("Primary RX redirect BPF prog not found")
 
-        if self._tc_ensure_clsact(self._nk_host_ifname):
+        if self._tc_ensure_clsact(self.nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+        cmd(f"tc filter add dev {self.nk_host_ifname} ingress"
             f" bpf obj {bpf_obj} sec tc/ingress direct-action")
         self._primary_rx_redirect_attached = True
 
@@ -550,7 +556,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._remote_route_added = True
 
         filters = json.loads(
-            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+            cmd(f"tc -j filter show dev {self.nk_host_ifname} ingress").stdout)
         redirect_prog_id = None
         for bpf in filters:
             if 'options' not in bpf:
-- 
2.43.0


