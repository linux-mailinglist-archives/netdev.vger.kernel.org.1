Return-Path: <netdev+bounces-283015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AdYDSXo82mE8gEAu9opvQ
	(envelope-from <netdev+bounces-283015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5F4A8E57
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 074D530090A1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93D3D3D18;
	Thu, 30 Apr 2026 23:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151A3D1710
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592354; cv=none; b=BRbTmZjDA8FBGOcnfMvNMFhLgLg1FSh202NQBTxvwAnXTurUrNVHpgcmHdr++GxQTKs0uUBV0snpRvRML4gLFAQub4EsgdY5Ki1SJ3fK+hawwFz9QpD/5UDjZw5yib2tUoRLPSDdQnIu5fofKK36Ic+VkYXEz6+lRPuZtC2+fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592354; c=relaxed/simple;
	bh=xa+90cajr5mMWrTYdZcEISHBJqeKrEmHV2IcV7+g/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFTGGaU/Ruq/6VmUeKomHzqJRKBJhOORIoPzeo80SM8a1jv+xuYUGfNc1o9WISoRbyX0LItfWKTUudhuNje/10617vrZrv14ZmTHgGnx9vZIZyGXbD3K/5xZlYo/S/EILvH4Cromx6euBYnoeL8WfpH50FGEai/1THjmIqaCcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50e5eb0fabaso14516161cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777592352; x=1778197152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9p6ZBs3o3Fa+hheEbjqBW5O3NwkqJypwl5eyCvle18=;
        b=q5ceuENVyGLhMJkkJ8tKK5W1sAZQtHn9Lt2fWr3nUwJcsTrG5ufui2d3tt2pyvbmXj
         XIWU3LDtibM4jiCO7iJ+fQ6gdxlz+2S0DhpUpYpeeymXyuJ5IlXf70RnBAcrjwEuaZpl
         kVx+TdB/0x0jg851+ITMHkQ5NCoFwc/qUYR3xFg5icSYgtdbFOtKy+PJBKonBhI/WG3R
         RufKOqhqKSmp9+aB/+8Y4N0FoOuV7GRSGYZRQjOUlPWrvGf06DGE8TDByDw0J37/wm5n
         SVsutTiV0j19SyYvvDICMkGOZe+ewWZtTlOGsNmEdV2Ta5YUJUdVDByQ9p6TOp6vfYG9
         fUXg==
X-Gm-Message-State: AOJu0Yzhr3uHCmApWffP5Gn2hlXkR66uS/JSsLbnN4hQTIDy5H/ILx+x
	dflqhpPY+N2d72KV4oteoASPgZ8jeEZJtjadThtGGjgIT/aEkTFxdj1LuyXAqlJwseE=
X-Gm-Gg: AeBDietYMYjfH0mZbHX68FkjI27xl9aXvnx/mr18RVsV/SI3gz9jRVvhF61nQyNzpy3
	W4gLFpntqhs7CtdV2HIWe3Pnyk3N6mJYhYUPTdpp1GdL/0Rmc9MpZeGSm57VLdqS4jC7O14v5tg
	X12LbcJtMsRSyLAhzxFWXYFpvbjC8TbsFd8rvQ2lOsum67MjhPZ8prjqVbMbclTqehroVSk2XKF
	IDe5Z9FDgtQtQjM9aLsgRFOdypcxDJadfwD7B/soyQ7ACPUD2uuxIWlNCgHXQov+e9gajsgAvYz
	FzUcsLWu3kbMq/jnmwC+Bfx7kzFgBec2qFspoMaLNqFPHz7MjbGzq5o0xbX5rUsQecxt/f41wTe
	f0hXTEyjS4h6VzC6g/O+AQAZG+I8mbA6CHSeJmt1YJxONL4VMUahTL32AXi7BvJ8PILyYlmeeWv
	u1Xgg+0CScvSlLqxoy4R6bQONyMUoELcFL9wXswiK4bw09ED7CIziRHl+D897kKrzwvjGjfQ==
X-Received: by 2002:a05:622a:1b19:b0:50d:b33d:bc6b with SMTP id d75a77b69052e-5102ab1f495mr75917351cf.20.1777592351818;
        Thu, 30 Apr 2026 16:39:11 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040934199sm221cf.13.2026.04.30.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:39:11 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 2/2] selftests: openvswitch: add tests for tunnel vport refcounting
Date: Fri,  1 May 2026 01:38:38 +0200
Message-ID: <20260430233848.440994-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430233848.440994-1-i.maximets@ovn.org>
References: <20260430233848.440994-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAB5F4A8E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283015-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

There were a few issues found with the tunnel vport types around the
vport destruction code.  Add some basic tests, so at least we know that
they can be properly added and removed without obvious issues.

The test creates OVS datapath, adds a non-LWT tunnel port, makes sure
they are created, and then removes the datapath and waits for all the
ports to be gone.

The dpctl script had a few bugs in the none-lwt tunnel creation code,
so fixing them as well to make the testing possible:
- The type of the --lwt option changed in order to properly disable it.
- Removed byte order conversion for the port numbers, as the value
  supposed to be in the host order.
- Added missing 'gre' choice for the tunnel type.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 37 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 19 +++++++---
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed53..3cdd953f68132 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -26,6 +26,7 @@ tests="
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
+	tunnel_refcount				ovs: test tunnel vport reference cleanup
 	drop_reason				drop: test drop reasons are emitted
 	psample					psample: Sampling packets with psample"
 
@@ -830,6 +831,42 @@ test_tunnel_metadata() {
 	return 0
 }
 
+test_tunnel_refcount() {
+	sbxname="test_tunnel_refcount"
+	sbx_add "${sbxname}" || return 1
+
+	ovs_sbx "${sbxname}" ip netns add trefns || return 1
+	on_exit "ovs_sbx ${sbxname} ip netns del trefns"
+
+	for tun_type in gre vxlan geneve; do
+		info "testing ${tun_type} tunnel vport refcount"
+
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			add-dp dp-${tun_type} || return 1
+
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			add-if --no-lwt -t ${tun_type} \
+			dp-${tun_type} ovs-${tun_type}0 || return 1
+
+		ovs_wait ip -netns trefns link show \
+			ovs-${tun_type}0 >/dev/null 2>&1 || return 1
+
+		info "deleting dp - may hang if reference counting is broken"
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			del-dp dp-${tun_type} &
+
+		dev_removed() {
+			! ip -netns trefns link show "$1" >/dev/null 2>&1
+		}
+		ovs_wait dev_removed dp-${tun_type} || return 1
+		ovs_wait dev_removed ovs-${tun_type}0 || return 1
+	done
+	return 0
+}
+
 run_test() {
 	(
 	tname="$1"
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 848f61fdcee09..bbe35e2718d26 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -11,7 +11,6 @@ import logging
 import math
 import multiprocessing
 import re
-import socket
 import struct
 import sys
 import time
@@ -2069,7 +2068,7 @@ class OvsVport(GenericNetlinkSocket):
         elif vport_type == "internal":
             return OvsVport.OVS_VPORT_TYPE_INTERNAL
         elif vport_type == "gre":
-            return OvsVport.OVS_VPORT_TYPE_INTERNAL
+            return OvsVport.OVS_VPORT_TYPE_GRE
         elif vport_type == "vxlan":
             return OvsVport.OVS_VPORT_TYPE_VXLAN
         elif vport_type == "geneve":
@@ -2121,6 +2120,7 @@ class OvsVport(GenericNetlinkSocket):
         )
 
         TUNNEL_DEFAULTS = [("geneve", 6081),
+                           ("gre", 0),
                            ("vxlan", 4789)]
 
         for tnl in TUNNEL_DEFAULTS:
@@ -2129,9 +2129,13 @@ class OvsVport(GenericNetlinkSocket):
                     dport = tnl[1]
 
                 if not lwt:
+                    if tnl[0] == "gre":
+                        # GRE tunnels have no options.
+                        break
+
                     vportopt = OvsVport.ovs_vport_msg.vportopts()
                     vportopt["attrs"].append(
-                        ["OVS_TUNNEL_ATTR_DST_PORT", socket.htons(dport)]
+                        ["OVS_TUNNEL_ATTR_DST_PORT", dport]
                     )
                     msg["attrs"].append(
                         ["OVS_VPORT_ATTR_OPTIONS", vportopt]
@@ -2145,6 +2149,9 @@ class OvsVport(GenericNetlinkSocket):
                                  geneve_port=dport,
                                  geneve_collect_metadata=True,
                                  geneve_udp_zero_csum6_rx=1)
+                    elif tnl[0] == "gre":
+                        ipr.link("add", ifname=vport_ifname, kind="gretap",
+                                 gre_collect_metadata=True)
                     elif tnl[0] == "vxlan":
                         ipr.link("add", ifname=vport_ifname, kind=tnl[0],
                                  vxlan_learning=0, vxlan_collect_metadata=1,
@@ -2563,7 +2570,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
             if vpo:
                 dpo = vpo.get_attr("OVS_TUNNEL_ATTR_DST_PORT")
                 if dpo:
-                    opts += " tnl-dport:%s" % socket.ntohs(dpo)
+                    opts += " tnl-dport:%s" % dpo
             print(
                 "  port %d: %s (%s%s)"
                 % (
@@ -2632,7 +2639,7 @@ def main(argv):
         "--ptype",
         type=str,
         default="netdev",
-        choices=["netdev", "internal", "geneve", "vxlan"],
+        choices=["netdev", "internal", "gre", "geneve", "vxlan"],
         help="Interface type (default netdev)",
     )
     addifcmd.add_argument(
@@ -2645,7 +2652,7 @@ def main(argv):
     addifcmd.add_argument(
         "-l",
         "--lwt",
-        type=bool,
+        action=argparse.BooleanOptionalAction,
         default=True,
         help="Use LWT infrastructure instead of vport (default true)."
     )
-- 
2.53.0


