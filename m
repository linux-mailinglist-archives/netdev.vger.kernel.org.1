Return-Path: <netdev+bounces-288059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFecAFkFBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:24:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915C5453A3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB03F3079D76
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622A39935E;
	Thu, 14 May 2026 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enzGIqOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB163932DF
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779374; cv=none; b=dZRrgzHl0141COQ7QBEQkHQ/tgd4CKzPvqEkwngzr7gYfYKuP36I7Eo0CM4RjrqlW5fnEvinc1YLYTPeyxznElBtcIDeE7yR6mdPzKCmCjWA0oYdc+RA+mjxfm6moij5nyno8MOnYk3+Izd5p0WtmF/JWf50b3BsIm8MputxVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779374; c=relaxed/simple;
	bh=wptIkvH9L489Qlo2T7M1mLc4bl4xRw6+9h17Bso5o/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ftmA5ljfuZJCVnLSapFzmlNfidX0ilxBT2SJ/LEO5eGxkNbQGd7el3dyJJc6WyLKjJoI9/W4aT7tskvNRRgAJC42JmzcRccNBsK/r5goZxqNh5fa7lY37XvPMNKabiHjvvSzvKSQQ/wJsZlO/ZLbP5yTwcQ/lE4RUOINAtQpVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enzGIqOg; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c364b893aso9647361d50.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779371; x=1779384171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HA/ybwawhpYacQbiJl7tU2w4tisbAXIL92cuydme34=;
        b=enzGIqOgEYzB+6SyUyh1GN7EtLmoHeyU4CvqLV7imOsRX80EPJUvnhA3ePoLFNuydj
         B/G+6ZsDp+kP8XH3g1xVSDF0/cKMIrDRO6g55ZG+iTN2soA8hVtsjj2QTIJrpEYZgywK
         FSiblWES/YabS2q+5MgwDRaWlH+Ly+DiesfBjdZH15V8vVw3pvLaq8jxGJyTTBXBWhW/
         Lm/TAjVgvgRfotf85PY/QPe5Kqg4w/qMGPqP7q1VUhIVSiiEiFf+JRQCbubeSgDTSvuE
         FAwHqUaD4TTxoMKrqt0a5tD/aaVaq5/S46IDFcC8LjQME9um8PmvbTgj+p0+widX/d3z
         fr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779371; x=1779384171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HA/ybwawhpYacQbiJl7tU2w4tisbAXIL92cuydme34=;
        b=dPyGnzq21pnd78PXOI2w7mh36ykkM23CtJMSFj8nSyWq/GZ7/FEem2CxlGTEJ3X+lB
         UKGGFA8KNXHZSQlHPvqn7DgpU4cQd6HzlbNebr4WGMU010kE8z1uVXA6dPv9fspSXlXR
         dJWPhYmM7vFJYdT+/3+YeYxXdj+3a12/aE2lNoYsvoCD9hapH45KxwTqQ6jL67TllfHx
         nuKcW2g+lHHgn6UBRaPDdLWNt4BEmZj+pOhu+go49vjn6V086UaJrpl+/lo70p+ybl+9
         D1jvuWFbRzivSbafNpfggWn+AFaVp42eXZ/wt5MEwmrGx6VyNLaLVQJk8WA/pJRQ7nFT
         lgzg==
X-Forwarded-Encrypted: i=1; AFNElJ+WCldscuD8+iSNkqnFKsaHOl+bcP/YkWEpKKbSjJ7fJv+O3YI+xv81s36uTXZVPZSMUfmv8k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTiL+M2lBATDeVSoKG5pHwPbYkCjLcXNT/7bymdntAwIkGEq7
	HnMahPEfd7ejtfuzPz5JAs6gZ4zVcMwTE+HEYlB0rc+ARTqAhzGe/q3c
X-Gm-Gg: Acq92OGy9CAgTDCDw2vygeFUlXAWHBg2wGyu3RlrHuCae8CeWCOUkv9codAnW4GjgC5
	LyIkS3iI809nM1dKZio8+TYkfce6O7LrkIEcxcyraPilE1MgZjHHC5eNJ5v+o2R1p0DNrId8vK4
	REpJB34qblcxobWj3QS0CYhtaVpjpHmT/ZAcKE3TuFOQ5S4vRuMGC/tNxyRL7bdbA8WPfiRAl6C
	bPD6SQxVmS8PegQoO7r+MLRvBCNaMOm2r7o0kGyExD/erRiqWofk1dNfaISJyI0Z3TfRZGnP8+a
	G5UdJenn9BXAnM0QQ5HheudrGOJ/0bBxzyxgqdRxuD9LsVfqwzWittLV1+utR3GkGje9eXfpVwE
	/IS/ohZa1VXYa1zRMnxoK7/nSl5bbfyrPHuAiAx1baMF22It3CJ3WYC+0eBhoN0GpSouXfXjzsH
	noorh28xdvehFdygv40XekSQ==
X-Received: by 2002:a53:d051:0:20b0:650:ea3:de9b with SMTP id 956f58d0204a3-65e226de860mr156252d50.21.1778779371526;
        Thu, 14 May 2026 10:22:51 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:23::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbcda4bsm1363004d50.18.2026.05.14.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:32 -0700
Subject: [PATCH net-next v5 5/8] selftests: drv-net: make attr
 _nk_guest_ifname public
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-5-408c59b91e66@meta.com>
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
X-Rspamd-Queue-Id: 6915C5453A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288059-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,meta.com:email,meta.com:mid,netns.name:url]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Subsequent patches will use the _nk_guest_ifname as a public attr for
setting up devmem. Rename to nk_guest_ifname to avoid angering the
linter about the '_' prefix being used for a non-private attr.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/nk_qlease.py |  8 ++++----
 tools/testing/selftests/drivers/net/lib/py/env.py   | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index aa83dc321328..139a91ebd229 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -71,7 +71,7 @@ def test_iou_zcrx(cfg) -> None:
     flow_rule_id = set_flow_rule(cfg)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
@@ -128,7 +128,7 @@ def test_attach_xdp_with_mp(cfg) -> None:
 
     netdevnl = NetdevFamily()
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     with bkg(rx_cmd):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
@@ -178,7 +178,7 @@ def test_destroy(cfg) -> None:
     ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
     rx_proc = cmd(rx_cmd, background=True)
     wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
@@ -196,7 +196,7 @@ def test_destroy(cfg) -> None:
     ip(f"link del dev {cfg._nk_host_ifname}")
     kill_timer.join()
     cfg._nk_host_ifname = None
-    cfg._nk_guest_ifname = None
+    cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
         {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..409b41922245 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -339,7 +339,7 @@ class NetDrvContEnv(NetDrvEpEnv):
     def __init__(self, src_path, rxqueues=1, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
-        self._nk_guest_ifname = None
+        self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
         self._bpf_prog_pref = None
@@ -390,7 +390,7 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         netkit_links.sort(key=lambda x: x['ifindex'])
         self._nk_host_ifname = netkit_links[1]['ifname']
-        self._nk_guest_ifname = netkit_links[0]['ifname']
+        self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
@@ -409,7 +409,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
-            self._nk_guest_ifname = None
+            self.nk_guest_ifname = None
 
         if self._init_ns_attached:
             cmd("ip netns del init", fail=False)
@@ -448,16 +448,16 @@ class NetDrvContEnv(NetDrvEpEnv):
         cmd("ip netns attach init 1")
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
-        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
+        ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
         ip(f"link set dev {self._nk_host_ifname} up")
         ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
         ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
 
         ip("link set lo up", ns=self.netns)
-        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
-        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
-        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
-        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
+        ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self.nk_guest_ifname}", ns=self.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self.nk_guest_ifname} nodad", ns=self.netns)
+        ip(f"-6 route add default via fe80::1 dev {self.nk_guest_ifname}", ns=self.netns)
 
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)

-- 
2.53.0-Meta


