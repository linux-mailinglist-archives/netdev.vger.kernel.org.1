Return-Path: <netdev+bounces-284137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEDlETo6+Wm46wIAu9opvQ
	(envelope-from <netdev+bounces-284137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B702C4C56BA
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B16FB305C159
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0D30FF27;
	Tue,  5 May 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIZkiPnu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FB315D46
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940892; cv=none; b=SDLVitSi2XD6621Bx7lrL7+EjBKVOkrQJpr29ppCN0sUSjUMt9pvnzgZy11t951+ktJJ2leL0c3DAuT9DQ/h9fpWjOTKeTXcSoT43Mcr1n8xLq3iF2LY+q0xjiOzvBePn9Iu8YcHvqbLcVy2NUz34kpvUnPEPEl0lD8a0LzG7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940892; c=relaxed/simple;
	bh=pZx1YkARmGowE47Fjinw6aGk/1Z/1eqLPS3aBUwU4zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdBepzPMSC0xNKR8Yzxd2j2SuZe2BR5bhZqXQ7HeFsicGo3UOIFh2aHyUWFg240x2xqgVr11XQeyU+c7W5elqx3Y1lHp20XNHCifQEGu9jQ0aLNvHay4r5aP7OwQ+nw8uO5rD8zO7qdt+gii551gO+G5yXil9UpFLilNAEcatoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIZkiPnu; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5102582e23eso35737961cf.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940887; x=1778545687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WIazItlhuwSwfo6on4yEwmRZQUGTlMWmE/koiDnhNI=;
        b=lIZkiPnupTpPzOuzkDC4Yw1Cu1BgO3sOdLFuMCHCBhJA9cLhjmz1Bc/scN5fYqaFQ0
         GFp1cMHeEotCuoGPs+fzIkih7NtQvdM+iZxVoJ22X/RrjN3QT5/6wekz3JcYQ+rv6GYO
         /A4iFcfXDCpOKdtjwVXjiHzg+BKYZ3Qzpn/fJCY9YoF95NCCJvO2OO+Nni2MxNBea7H1
         zkewXblbuO3Zo++1gUKEAaqGE9l7KGzIqrypEo5QkcJ24Bepd/hmJ0nlK2mhMSjyeU2I
         wCt3FOM+UssBy6AzGxlBmLYUvrzyRspkzoTm2h8Uf8q0uCVowKqoSnihQZ/vifxhDsPL
         CCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940887; x=1778545687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WIazItlhuwSwfo6on4yEwmRZQUGTlMWmE/koiDnhNI=;
        b=RqFQVhOIDcOCM1CEQ3CQiNq9bPrHXU0mHMbVRt88XjaLP2L/CG98LnajHdYsObLtN7
         GRbUdY4trVPI0Bf8wae/tWiu9uRHqd7aJ/Mf2sZGh5/Rdp7j+7D1affeJeCMZo/tiF9x
         mRcNAUBmLO+NF0156M/+XwM7KNomYiT+ss6iZYyxaRYy46Mr0tHUzK80z5MiPzT0OyQ/
         emxa83sNS3tufHxvdxKI0Gw/d3Hqf75N49+qyLE4Kcah+XqAWwNlJaJRab0/hek83GYR
         l9CG52z+Sa8Dmf2u2tPfa5v3we653Ew1C1AhgZhemBMcmTlNKf0w4kLJSY5bel7jqZkl
         +twQ==
X-Gm-Message-State: AOJu0Yyj8bE/lcskI8F2zvd2Nf148ZaoDy4CpjkmX8p64SmEv8kS41Eq
	USqWx1VGg0hjk3oNZpPFLkbpONvX/1pQgf5kHbJATVmkTrkS/JrScOXa
X-Gm-Gg: AeBDiesOnK4J5IXPM0piOURc2oxHdbFAl+iCXQ0nd4WPQI7jbABiSWLjW1BnvgFy2B3
	lDd/7eVtufr0/tJ1KceTMRfK0fQ/4AIDRQ4A8NWhcgw87lrTbWmZ0PW/cXEbSlrwLcwzcmrxPtQ
	K0e5+Znxgz+sD+jOZXmrqQ9vGfv3DMofnIr6op9CsmtTA6WHmx67M5BFVGI53/1UNeBke6GINyM
	aMxzgnNk/veQfuE710fkWl2mp8p5f/h2X8WivyvY6oncjHTKmIJIVtAF/33P2zwDul00M3Y7QM3
	uzMMvMb+u/MscB62O/LvkwOP0nNR3J1hU5T/M+PzHgSLAAWoLzWPFq00/QdbTl0CDVn1s8mqoXV
	EL47lflF3KKdIjFIKSSYPmhiQbY/54xSwhHyDfd5TWCjByyGLNlQL8XPoeZ/wtD/IjE4hfYk7Pg
	zL1gxfd8BARLz/e0Y8rjouAmQlIOIVjSFRZ0JOd8SszDU=
X-Received: by 2002:a05:622a:509:b0:50f:9c33:af18 with SMTP id d75a77b69052e-5104bf964f0mr168578611cf.51.1777940886765;
        Mon, 04 May 2026 17:28:06 -0700 (PDT)
Received: from localhost ([2a03:2880:f804:2e::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8967sm107239171cf.29.2026.05.04.17.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:28:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:52 -0700
Subject: [PATCH net-next v2 5/6] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-tcp-dm-netkit-v2-5-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B702C4C56BA
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284137-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
interface.  The program redirects non-ICMPv6 IPv6 packets to the
physical NIC via bpf_redirect_neigh(), with the physical ifindex
configured via the .bss map.

Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
other BPF attachment methods can use it.

Also add an IPv6 host route on the remote endpoint for the netkit guest
IP via the physical NIC address, so the remote can send packets that
traverse the redirect path to the guest.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 41 +++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 67 ++++++++++++++++++----
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
new file mode 100644
index 000000000000..fe3c127a4fd0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+#define IPPROTO_ICMPV6 58
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+volatile __u32 phys_ifindex;
+
+SEC("tc/ingress")
+int nk_primary_rx_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ethhdr *eth;
+	struct ipv6hdr *ip6h;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (ip6h->nexthdr == IPPROTO_ICMPV6)
+		return TC_ACT_OK;
+
+	return bpf_redirect_neigh(phys_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 24ce122abd9c..d569d01ef791 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -336,15 +336,17 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self._nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
+        self._primary_rx_redirect_attached = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
         self._init_ns_attached = False
+        self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
 
@@ -396,8 +398,14 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         self._setup_ns()
         self._attach_bpf()
+        if primary_rx_redirect:
+            self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
+        if self._primary_rx_redirect_attached:
+            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            self._primary_rx_redirect_attached = False
+
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -406,6 +414,11 @@ class NetDrvContEnv(NetDrvEpEnv):
             cmd(f"tc qdisc del dev {self.ifname} clsact")
             self._tc_clsact_added = False
 
+        if self._remote_route_added:
+            cmd(f"ip -6 route del {self.nk_guest_ipv6}/128",
+                host=self.remote, fail=False)
+            self._remote_route_added = False
+
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
@@ -459,6 +472,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
 
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}", host=self.remote)
+        self._remote_route_added = True
+
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
         for q in qdisc:
@@ -476,6 +492,15 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
@@ -487,17 +512,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed
@@ -505,3 +520,31 @@ class NetDrvContEnv(NetDrvEpEnv):
         value = ipv6_bytes + ifindex_bytes
         value_hex = ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def _attach_primary_rx_redirect_bpf(self):
+        """Attach BPF redirect program on the primary netkit ingress."""
+        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+            f" bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._primary_rx_redirect_attached = True
+
+        filters = json.loads(
+            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+        redirect_prog_id = None
+        for bpf in filters:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_primary_rx_redirect'):
+                redirect_prog_id = bpf['options']['prog']['id']
+                break
+        if redirect_prog_id is None:
+            raise Exception("Failed to get primary RX redirect BPF prog ID")
+
+        bss_map_id = self._find_bss_map_id(redirect_prog_id)
+        phys_ifindex_bytes = self.ifindex.to_bytes(4, byteorder='little')
+        value_hex = ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")

-- 
2.52.0


