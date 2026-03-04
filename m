Return-Path: <netdev+bounces-263495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDotDpF5p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:15:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6581F8C74
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FF2330086A1
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6BE1DE3AD;
	Wed,  4 Mar 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="R1ibepvM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90D17BEBF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583308; cv=none; b=mD8/bMT9kc8JVAsxI9iwtUsATErgy3F1h39ziHh10ZnBqO3AqsxCm1Qmyx+qHIJ7NS+3sdOTKdRpYGmJVOZZcwvEOTlgefhni/NXP8fXB0bOjlOv0Bp7SritVYIVk4E/4jgrx6YpzamRuxU9lHJulhEuPqBQw7zSXUFsM99h8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583308; c=relaxed/simple;
	bh=iBejlXzcipJhesio/XurCPlhFKqBJQQ3Der1Ltg7gR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRojRcgw2sPfXavbA86G+2P93AMJTieItT1cxEnr6DTs2xeqYjUmPxMfsv1+i2bqCNnMDfMmy0tEuFowTh9ZfD3VkD+aZNfwXxizftveWMLJHdc+48SioS0w0koC07/nizIubH7cPFAq+TJ22V6bJpNm30en46pHOnG2JW97vjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=R1ibepvM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623KLrdN2734742
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:15:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MGVROf4CJgCX4wH39iZVLCz4NBn29uOWIzSHf+AAP64=; b=R1ibepvMMDZq
	B0mBcxAfNgzijGHlyMuPRE5ET+NYN4lbKrDuJc5baMlcmVlZnoPaDppTA+VI1SU1
	7H+Fne1EU83LLMW6SykhvdY7c9bVnQVH61hM5ngANLYTG+ywDbzX0dsJdX2ZGvqP
	3205T06l0PXDIiPTNdB8vuuk+1NjMS7g+CkuiEu/+jGPkvOKf0m3Uv+uVZSAUcHy
	TaNUwI0k154ybV64XZ4PKXhMfOVu8AKme/GJamEyPFDRZPMVluoRdwT8f9pBU4vE
	PuKTNJKRyLZRzGYHV8nBKCkyAv/FDGQ3lOX8lkK7hVqJhY3/xxQKjB5+S0BeBKQT
	ctTNrLwWbg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cnmun6d3a-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:15:05 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:15:02 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 7D7E075995D0; Tue,  3 Mar 2026 16:15:00 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH v2 net-next 9/9] selftest/net: psp: Add test for dev-assoc/disassoc
Date: Tue, 3 Mar 2026 16:00:49 -0800
Message-ID: <20260304000050.3366381-10-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304000050.3366381-1-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfX8IJRIH3SoVeV
 8EVYV5CjeKRhKGM+7T+eKEu3n7PzRGHrL/HBK/HeAW8NG70j+PxpY6nP3t+RA/2mCdrsOmDOGiX
 924XXBpHHnb67qbHEbhpclqu1/GyfVRl76wlEAGz8lQpOHAegYxqgvJFg5OsIujuUN6uKNLlXtl
 VTBWYPbv2XWfthmNplB6CuwMkigC2t+AEvGHZu0MF7XOQB/FvuhbW+X4CaBzaElw6tF+NBBgcHL
 0C1fBMRDMtYQ2DNIya9onSS3gRmt0gE3liBl76jtOrMCTiBz23nfdyhUBhJPhg6L2EkByZdz0Yz
 46PXN5V3V4ltm07Pgo3K8Olnqhe06IWZZ1n2LcvRf+s8ezFIeomTsvqQUmYyvDdJcn/aCVbde/6
 Rvn4sYFfsHTrm96khis2LNs8GKaZ3tc0bMMjD+L8iWX399D7eBliYPLP0gkBAjClXfWCiEYY3MQ
 uc2n5I61fmY21vqpiHw==
X-Proofpoint-ORIG-GUID: 5Pvsjn0aQaq2kKfxz_ETA3Oohn7A8K6_
X-Proofpoint-GUID: 5Pvsjn0aQaq2kKfxz_ETA3Oohn7A8K6_
X-Authority-Analysis: v=2.4 cv=BrGQAIX5 c=1 sm=1 tr=0 ts=69a77989 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=FOH2dFAWAAAA:8 a=WqdYS7T8vzUZhMeLpT8A:9
 a=I39a0V8poo5OQRip:21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 3E6581F8C74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263495-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fb.com:dkim,fb.com:email,fb.com:mid,lib.py:url,netns.name:url,cfg.dev:url];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a new param to NetDrvContEnv to add an additional bpf redirect
program on nk_host to redirect traffic to the psp_dev_local.
The topology looks like this:
  Host NS:  psp_dev_local <---> nk_host
                |                |
                |                | (netkit pair)
                |                |
  Remote NS: psp_dev_peer      Guest NS: nk_guest
             (responder)             (PSP tests)

Add following tests for dev-assoc/dev-disassoc functionality:
1. Test the output of `./tools/net/ynl/pyynl/cli.py --spec
Documentation/netlink/specs/psp.yaml --dump dev-get` in both default and
the guest netns.
2. Test the case where we associate netkit with psp_dev_local, and
send PSP traffic from nk_guest to psp_dev_peer in 2 different netns.
3. Test to make sure the key rotation notification is sent to the netns
for associated dev as well
4. Test to make sure the dev change notification is sent to the netns
for associated dev as well
5. Test the deletion of nk_guest in client netns, and proper cleanup in
the assoc-list for psp dev.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |  54 +-
 tools/testing/selftests/drivers/net/psp.py    | 525 +++++++++++++++++-
 3 files changed, 574 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/too=
ls/testing/selftests/drivers/net/lib/py/__init__.py
index 374d4f08dd05..552f36db95ce 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -48,8 +48,8 @@ try:
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
=20
-    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "Generate=
Traffic",
-                "Remote", "Iperf3Runner"]
+    __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv",
+                "GenerateTraffic", "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
index 36d98e1df15b..299fb4b0b8dd 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -2,6 +2,7 @@
=20
 import ipaddress
 import os
+import re
 import time
 import json
 from pathlib import Path
@@ -327,7 +328,7 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
=20
-    def __init__(self, src_path, rxqueues=3D1, **kwargs):
+    def __init__(self, src_path, rxqueues=3D1, install_tx_redirect_bpf=3D=
False, **kwargs):
         self.netns =3D None
         self._nk_host_ifname =3D None
         self._nk_guest_ifname =3D None
@@ -338,6 +339,8 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached =3D False
         self._old_fwd =3D None
         self._old_accept_ra =3D None
+        self._nk_host_tc_attached =3D False
+        self._nk_host_bpf_prog_pref =3D None
=20
         super().__init__(src_path, **kwargs)
=20
@@ -391,7 +394,13 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._setup_ns()
         self._attach_bpf()
=20
+        if install_tx_redirect_bpf:
+            self._attach_tx_redirect_bpf()
+
     def __del__(self):
+        if self._nk_host_tc_attached:
+            cmd(f"tc filter del dev {self._nk_host_ifname} ingress pref =
{self._nk_host_bpf_prog_pref}", fail=3DFalse)
+            self._nk_host_tc_attached =3D False
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bp=
f_prog_pref}")
             self._tc_attached =3D False
@@ -497,3 +506,46 @@ class NetDrvContEnv(NetDrvEpEnv):
         value =3D ipv6_bytes + ifindex_bytes
         value_hex =3D ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
+
+    def _attach_tx_redirect_bpf(self):
+        """
+        Attach BPF program on nk_host ingress to redirect TX traffic.
+
+        Packets from nk_guest destined for the nsim network arrive at nk=
_host
+        via the netkit pair. This BPF program redirects them to the phys=
ical
+        interface so they can reach the remote peer.
+        """
+        bpf_obj =3D self.test_dir / "nk_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog nk_redirect.bpf.o not found")
+
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress bpf obj {=
bpf_obj} sec tc/ingress direct-action")
+        self._nk_host_tc_attached =3D True
+
+        tc_info =3D cmd(f"tc filter show dev {self._nk_host_ifname} ingr=
ess").stdout
+        match =3D re.search(r'pref (\d+).*nk_redirect\.bpf.*id (\d+)', t=
c_info)
+        if not match:
+            raise Exception("Failed to get TX redirect BPF prog ID")
+        self._nk_host_bpf_prog_pref =3D int(match.group(1))
+        nk_host_bpf_prog_id =3D int(match.group(2))
+
+        prog_info =3D bpftool(f"prog show id {nk_host_bpf_prog_id}", jso=
n=3DTrue)
+        map_ids =3D prog_info.get("map_ids", [])
+
+        bss_map_id =3D None
+        for map_id in map_ids:
+            map_info =3D bpftool(f"map show id {map_id}", json=3DTrue)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id =3D map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find TX redirect BPF .bss map")
+
+        ipv6_addr =3D ipaddress.IPv6Address(self.nsim_v6_pfx)
+        ipv6_bytes =3D ipv6_addr.packed
+        ifindex_bytes =3D self.ifindex.to_bytes(4, byteorder=3D'little')
+        value =3D ipv6_bytes + ifindex_bytes
+        value_hex =3D ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/s=
elftests/drivers/net/psp.py
index 864d9fce1094..7c47a55c7aea 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -5,6 +5,7 @@
=20
 import errno
 import fcntl
+import os
 import socket
 import struct
 import termios
@@ -15,8 +16,10 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
 from lib.py import KsftSkipEx
-from lib.py import NetDrvEpEnv, PSPFamily, NlError
-from lib.py import bkg, rand_port, wait_port_listen
+from lib.py import NetDrvContEnv, PSPFamily, NlError
+from lib.py import NetNSEnter
+from lib.py import bkg, cmd, rand_port, wait_port_listen
+from lib.py import ip
=20
=20
 def _get_outq(s):
@@ -117,11 +120,13 @@ def _get_stat(cfg, key):
 # Test case boiler plate
 #
=20
-def _init_psp_dev(cfg):
+def _init_psp_dev(cfg, use_psp_ifindex=3DFalse):
     if not hasattr(cfg, 'psp_dev_id'):
         # Figure out which local device we are testing against
+        # For NetDrvContEnv: use psp_ifindex (nsim_local) instead of ifi=
ndex
+        target_ifindex =3D cfg.psp_ifindex if use_psp_ifindex else cfg.i=
findex
         for dev in cfg.pspnl.dev_get({}, dump=3DTrue):
-            if dev['ifindex'] =3D=3D cfg.ifindex:
+            if dev['ifindex'] =3D=3D target_ifindex:
                 cfg.psp_info =3D dev
                 cfg.psp_dev_id =3D cfg.psp_info['id']
                 break
@@ -394,6 +399,387 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
=20
=20
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Test connectivity in both directions before PSP operations
+    remote_addr =3D cfg.remote_addr_v["6"]  # nsim_peer address (2001:db=
8::2)
+    nk_guest_addr =3D cfg.nk_guest_ipv6     # nk_guest address (2001:db9=
::2:2)
+
+    # Check if assoc-list contains nk_guest
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    if 'assoc-list' in dev_info:
+        found =3D False
+        for assoc in dev_info['assoc-list']:
+            if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'=
] =3D=3D cfg.psp_dev_peer_nsid:
+                found =3D True
+                break
+        ksft_true(found, "Associated device not found in dev_get() respo=
nse")
+    else:
+        raise RuntimeError("No assoc-list in dev_get() response after as=
sociation")
+
+    # Enter guest namespace (netns) to run PSP test
+    with NetNSEnter(cfg.netns.name):
+        cfg.pspnl =3D PSPFamily()
+
+        s =3D _make_psp_conn(cfg, version, ipver)
+
+        rx_assoc =3D cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        rx =3D rx_assoc['rx-key']
+        tx =3D _spi_xchg(s, rx)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx,
+                            "sock-fd": s.fileno()})
+
+        data_len =3D _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _close_psp_conn(cfg, s)
+
+    # Clean up - back in host namespace
+    cfg.pspnl =3D PSPFamily()
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _key_rotation_notify_multi_ns_netkit(cfg, version, ipver):
+    """ Test key rotation notifications across multiple namespaces using=
 netkit """
+    import threading
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    results =3D {'main_ns': None, 'peer_ns': None}
+
+    def listen_in_namespace(ns_name, result_key):
+        """Listen for key rotation notifications in a namespace"""
+        try:
+            if ns_name:
+                ctx =3D NetNSEnter(ns_name)
+            else:
+                from contextlib import nullcontext
+                ctx =3D nullcontext()
+
+            with ctx:
+                pspnl =3D PSPFamily()
+                pspnl.ntf_subscribe('use')
+
+                collected_notifications =3D []
+                for i in range(100):
+                    pspnl.check_ntf()
+
+                    try:
+                        while True:
+                            msg =3D pspnl.async_msg_queue.get_nowait()
+                            collected_notifications.append(msg['msg'])
+                    except:
+                        pass
+
+                    if collected_notifications:
+                        results[result_key] =3D collected_notifications
+                        break
+
+                    time.sleep(0.1)
+                else:
+                    # Timeout - no notification received
+                    results[result_key] =3D []
+        except Exception as e:
+            results[result_key] =3D {'error': str(e)}
+
+    # Create listener threads
+    # Main namespace listener
+    main_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(None, 'main_ns'),
+        name=3D'main_ns_listener'
+    )
+    # Guest namespace listener (netkit peer)
+    guest_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(cfg.netns.name, 'peer_ns'),
+        name=3D'guest_ns_listener'
+    )
+
+    main_ns_thread.start()
+    guest_ns_thread.start()
+
+    time.sleep(0.5)
+
+    # Trigger key rotation on the PSP device
+    cfg.pspnl.key_rotate({"id": psp_dev_id_for_assoc})
+
+    main_ns_thread.join(timeout=3D15)
+    guest_ns_thread.join(timeout=3D15)
+
+    # Verify notifications were received in both namespaces
+    ksft_not_none(results['main_ns'], "No result from main namespace lis=
tener")
+    ksft_not_none(results['peer_ns'], "No result from guest namespace li=
stener")
+
+    # Check for errors in listeners
+    if isinstance(results['main_ns'], dict) and 'error' in results['main=
_ns']:
+        raise RuntimeError(f"Main NS listener error: {results['main_ns']=
['error']}")
+    if isinstance(results['peer_ns'], dict) and 'error' in results['peer=
_ns']:
+        raise RuntimeError(f"Guest NS listener error: {results['peer_ns'=
]['error']}")
+
+    # Verify that both namespaces received at least one notification
+    ksft_gt(len(results['main_ns']), 0, "No key rotation notification re=
ceived in main namespace")
+    ksft_gt(len(results['peer_ns']), 0, "No key rotation notification re=
ceived in guest namespace")
+
+    # Verify the notification contains the expected dev_id
+    main_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['main_ns']
+    )
+    guest_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['peer_ns']
+    )
+
+    ksft_true(main_ns_has_dev, "Key rotation notification for correct de=
vice not found in main namespace")
+    ksft_true(guest_ns_has_dev, "Key rotation notification for correct d=
evice not found in guest namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _dev_change_notify_multi_ns_netkit(cfg, version, ipver):
+    """ Test dev_change notifications across multiple namespaces using n=
etkit """
+    import threading
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    results =3D {'main_ns': None, 'peer_ns': None}
+
+    def listen_in_namespace(ns_name, result_key):
+        """Listen for dev_change notifications in a namespace"""
+        try:
+            if ns_name:
+                ctx =3D NetNSEnter(ns_name)
+            else:
+                from contextlib import nullcontext
+                ctx =3D nullcontext()
+
+            with ctx:
+                pspnl =3D PSPFamily()
+                pspnl.ntf_subscribe('mgmt')
+
+                collected_notifications =3D []
+                for i in range(100):
+                    pspnl.check_ntf()
+
+                    try:
+                        while True:
+                            msg =3D pspnl.async_msg_queue.get_nowait()
+                            collected_notifications.append(msg['msg'])
+                    except:
+                        pass
+
+                    if collected_notifications:
+                        results[result_key] =3D collected_notifications
+                        break
+
+                    time.sleep(0.1)
+                else:
+                    # Timeout - no notification received
+                    results[result_key] =3D []
+        except Exception as e:
+            results[result_key] =3D {'error': str(e)}
+
+    # Create listener threads
+    # Main namespace listener
+    main_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(None, 'main_ns'),
+        name=3D'main_ns_listener'
+    )
+    # Guest namespace listener (netkit peer)
+    guest_ns_thread =3D threading.Thread(
+        target=3Dlisten_in_namespace,
+        args=3D(cfg.netns.name, 'peer_ns'),
+        name=3D'guest_ns_listener'
+    )
+
+    main_ns_thread.start()
+    guest_ns_thread.start()
+
+    time.sleep(1.0)  # Give threads time to subscribe
+
+    # Trigger dev_change by calling dev_set (notification is always sent=
)
+    cfg.pspnl.dev_set({'id': psp_dev_id_for_assoc, 'psp-versions-ena': c=
fg.psp_info['psp-versions-cap']})
+
+    main_ns_thread.join(timeout=3D15)
+    guest_ns_thread.join(timeout=3D15)
+
+    # Verify notifications were received in both namespaces
+    ksft_not_none(results['main_ns'], "No result from main namespace lis=
tener")
+    ksft_not_none(results['peer_ns'], "No result from guest namespace li=
stener")
+
+    # Check for errors in listeners
+    if isinstance(results['main_ns'], dict) and 'error' in results['main=
_ns']:
+        raise RuntimeError(f"Main NS listener error: {results['main_ns']=
['error']}")
+    if isinstance(results['peer_ns'], dict) and 'error' in results['peer=
_ns']:
+        raise RuntimeError(f"Guest NS listener error: {results['peer_ns'=
]['error']}")
+
+    # Verify that both namespaces received at least one notification
+    ksft_gt(len(results['main_ns']), 0, "No dev_change notification rece=
ived in main namespace")
+    ksft_gt(len(results['peer_ns']), 0, "No dev_change notification rece=
ived in guest namespace")
+
+    # Verify the notification contains the expected dev_id
+    main_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['main_ns']
+    )
+    guest_ns_has_dev =3D any(
+        ntf.get('id') =3D=3D psp_dev_id_for_assoc
+        for ntf in results['peer_ns']
+    )
+
+    ksft_true(main_ns_has_dev, "Dev_change notification for correct devi=
ce not found in main namespace")
+    ksft_true(guest_ns_has_dev, "Dev_change notification for correct dev=
ice not found in guest namespace")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_get_check_netkit_psp_assoc(cfg, version, ipver):
+    """ Check psp dev-get output with netkit interface associated with P=
SP dev """
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Check 1: In default netns, verify dev-get has correct ifindex and =
assoc-list
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+
+    # Verify the PSP device has the correct ifindex
+    ksft_eq(dev_info['ifindex'], cfg.psp_ifindex)
+
+    # Verify assoc-list exists and contains the associated nk_guest with=
 correct ifindex and nsid
+    ksft_true('assoc-list' in dev_info, "No assoc-list in dev_get() resp=
onse after association")
+    found =3D False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'] =3D=
=3D cfg.psp_dev_peer_nsid:
+            found =3D True
+            break
+    ksft_true(found, "Associated device not found in assoc-list with cor=
rect ifindex and nsid")
+
+    # Check 2: In guest netns, verify dev-get has assoc-list with nk_gue=
st device
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl =3D PSPFamily()
+
+        # Dump all devices in the guest namespace
+        peer_devices =3D peer_pspnl.dev_get({}, dump=3DTrue)
+
+        # Find the device with by-association flag
+        peer_dev =3D None
+        for dev in peer_devices:
+            if dev.get('by-association'):
+                peer_dev =3D dev
+                break
+
+        ksft_not_none(peer_dev, "No PSP device found with by-association=
 flag in guest netns")
+
+        # Verify assoc-list contains the nk_guest device
+        ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list'=
]) > 0,
+                  "Guest device should have assoc-list with local device=
s")
+
+        # Verify the assoc-list contains nk_guest ifindex with nsid=3D-1=
 (same namespace)
+        found =3D False
+        for assoc in peer_dev['assoc-list']:
+            if assoc['ifindex'] =3D=3D nk_guest_ifindex:
+                ksft_eq(assoc['nsid'], -1,
+                        "nsid should be -1 (NETNSA_NSID_NOT_ASSIGNED) fo=
r same-namespace device")
+                found =3D True
+                break
+        ksft_true(found, "nk_guest ifindex not found in assoc-list")
+
+    # Clean up
+    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_gu=
est_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
+    """ Test that assoc-list is cleared when associated netkit interface=
 is deleted """
+    import subprocess
+
+    _init_psp_dev(cfg, True)
+    psp_dev_id_for_assoc =3D cfg.psp_dev_id
+
+    # Associate PSP device with nk_guest interface (in guest namespace)
+    nk_guest_dev =3D ip(f"link show dev {cfg._nk_guest_ifname}", json=3D=
True, ns=3Dcfg.netns)[0]
+    nk_guest_ifindex =3D nk_guest_dev['ifindex']
+
+    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest=
_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
+
+    # Verify assoc-list exists in default netns
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' in dev_info, "No assoc-list after association=
")
+    found =3D False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] =3D=3D nk_guest_ifindex and assoc['nsid'] =3D=
=3D cfg.psp_dev_peer_nsid:
+            found =3D True
+            break
+    ksft_true(found, "Associated device not found in assoc-list")
+
+    # Delete the netkit interface in the guest namespace
+    ns_name =3D cfg.netns.name
+    subprocess.run(f"ip netns exec {ns_name} ip link del {cfg._nk_guest_=
ifname}", shell=3DTrue, check=3DTrue)
+
+    # Mark netkit as already deleted so cleanup won't try to delete it a=
gain
+    # (deleting nk_guest also removes nk_host since they're a pair)
+    cfg._nk_host_ifname =3D None
+    cfg._nk_guest_ifname =3D None
+
+    # Verify assoc-list is gone in default netns after netkit deletion
+    dev_info =3D cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
+    ksft_true('assoc-list' not in dev_info or len(dev_info['assoc-list']=
) =3D=3D 0,
+              "assoc-list should be empty after netkit deletion")
+
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
 def __bad_xfer_do(cfg, s, tx, version=3D'hdr0-aes-gcm-128'):
     # Make sure we accept the ACK for the SPI before we seal with the ba=
d assoc
     _check_data_outq(s, 0)
@@ -591,13 +977,107 @@ def ipver_test_builder(name, test_func, ipver):
     return test_case
=20
=20
+def _get_nsid(ns_name):
+    """Get the nsid for a namespace."""
+    nsid =3D 0
+    try:
+        list_result =3D cmd("ip netns list-id", shell=3DTrue)
+        list_output =3D list_result.stdout if hasattr(list_result, 'stdo=
ut') else str(list_result)
+
+        for line in list_output.split('\n'):
+            if ns_name in line and 'nsid' in line:
+                parts =3D line.split()
+                if 'nsid' in parts:
+                    nsid_idx =3D parts.index('nsid')
+                    if nsid_idx + 1 < len(parts):
+                        try:
+                            nsid =3D int(parts[nsid_idx + 1])
+                            break
+                        except ValueError:
+                            pass
+    except Exception as e:
+        raise KsftSkipEx(f"Failed to query nsid: {e}")
+    return nsid
+
+
+def _setup_psp_attributes(cfg):
+    """
+    Set up PSP-specific attributes on the environment.
+
+    This sets attributes needed for PSP tests based on whether we're usi=
ng
+    netdevsim or a real NIC.
+    """
+    if cfg._ns is not None:
+        # nsim case: PSP device is nsim_local (in host namespace)
+        cfg.psp_dev =3D cfg._ns.nsims[0].dev
+        cfg.psp_ifname =3D cfg.psp_dev['ifname']
+        cfg.psp_ifindex =3D cfg.psp_dev['ifindex']
+
+        # PSP peer device is nsim_peer (in _netns, where psp_responder r=
uns)
+        cfg.psp_dev_peer =3D cfg._ns_peer.nsims[0].dev
+        cfg.psp_dev_peer_ifname =3D cfg.psp_dev_peer['ifname']
+        cfg.psp_dev_peer_ifindex =3D cfg.psp_dev_peer['ifindex']
+    else:
+        # Real NIC case: PSP device is the local interface
+        cfg.psp_dev =3D cfg.dev
+        cfg.psp_ifname =3D cfg.ifname
+        cfg.psp_ifindex =3D cfg.ifindex
+
+        # PSP peer device is the remote interface
+        cfg.psp_dev_peer =3D cfg.remote_dev
+        cfg.psp_dev_peer_ifname =3D cfg.remote_ifname
+        cfg.psp_dev_peer_ifindex =3D cfg.remote_ifindex
+
+    # Get nsid for the guest namespace (netns) where nk_guest is
+    cfg.psp_dev_peer_nsid =3D _get_nsid(cfg.netns.name)
+
+
+def _setup_psp_routes(cfg):
+    """
+    Set up routes for cross-namespace connectivity.
+
+    Traffic flows:
+    1. remote (_netns) -> nk_guest (netns):
+       nsim_peer -> nsim_local -> BPF redirect -> nk_host -> nk_guest
+       Needs: route in _netns to nk_v6_pfx/64 via nsim_local
+
+    2. nk_guest (netns) -> remote (_netns):
+       nk_guest -> nk_host -> nsim_local -> nsim_peer
+       Needs: route in netns to nsim_v6_pfx/64 via nk_host
+    """
+    # In _netns (remote namespace): add route to nk_guest prefix via nsi=
m_local
+    # nsim_peer can reach nsim_local via the link, then traffic goes thr=
ough BPF
+    ip(f"-6 route add {cfg.nk_v6_pfx}/64 via {cfg.nsim_v6_pfx}1 dev {cfg=
.psp_dev_peer_ifname}",
+       ns=3Dcfg._netns)
+
+    # In netns (guest namespace): add route to nsim_peer prefix
+    # nk_guest default route goes to nk_host, but we need explicit route=
 to nsim_v6_pfx/64
+    ip(f"-6 route add {cfg.nsim_v6_pfx}/64 via fe80::1 dev {cfg._nk_gues=
t_ifname}",
+       ns=3Dcfg.netns)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
=20
-    with NetDrvEpEnv(__file__) as cfg:
+    # Use a different prefix for netkit guest to avoid conflict with nsi=
m prefix
+    nk_v6_pfx =3D "2001:db9::"
+
+    # Set LOCAL_PREFIX_V6 to a DIFFERENT prefix than nsim to avoid BPF
+    # redirecting psp_responder traffic. The BPF only redirects traffic
+    # matching LOCAL_PREFIX_V6, so nsim traffic (2001:db8::) won't be af=
fected.
+    if "LOCAL_PREFIX_V6" not in os.environ:
+        os.environ["LOCAL_PREFIX_V6"] =3D nk_v6_pfx
+
+    with NetDrvContEnv(__file__, install_tx_redirect_bpf=3DTrue) as cfg:
         cfg.pspnl =3D PSPFamily()
+        cfg.nk_v6_pfx =3D nk_v6_pfx
+
+        # Set up PSP-specific attributes and routes
+        _setup_psp_attributes(cfg)
+        _setup_psp_routes(cfg)
=20
         # Set up responder and communication sock
+        # psp_responder runs in _netns (remote namespace with nsim_peer)
         responder =3D cfg.remote.deploy("psp_responder")
=20
         cfg.comm_port =3D rand_port()
@@ -622,9 +1102,42 @@ def main() -> None:
                     ipver_test_builder("data_mss_adjust", _data_mss_adju=
st, ipver)
                     for ipver in ("4", "6")
                 ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "data_basic_send_netkit_psp_assoc",
+                        _data_basic_send_netkit_psp_assoc, version, "6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "key_rotation_notify_multi_ns_netkit",
+                        _key_rotation_notify_multi_ns_netkit, version, "=
6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "dev_change_notify_multi_ns_netkit",
+                        _dev_change_notify_multi_ns_netkit, version, "6"
+                    )
+                    for version in range(0, 4)
+                ]
+                cases +=3D [
+                    psp_ip_ver_test_builder(
+                        "psp_dev_get_check_netkit_psp_assoc",
+                        _psp_dev_get_check_netkit_psp_assoc, version, "6=
"
+                    )
+                    for version in range(0, 4)
+                ]
+                # Run netkit deletion test only once at the end since it=
 destroys the netkit
+                def psp_dev_assoc_cleanup_on_netkit_del_test(cfg):
+                    _psp_dev_assoc_cleanup_on_netkit_del(cfg)
+                psp_dev_assoc_cleanup_on_netkit_del_test.__name__ =3D "p=
sp_dev_assoc_cleanup_on_netkit_del"
+                cases.append(psp_dev_assoc_cleanup_on_netkit_del_test)
=20
                 ksft_run(cases=3Dcases, globs=3Dglobals(),
-                         case_pfx=3D{"dev_", "data_", "assoc_", "removal=
_"},
+                         case_pfx=3D{"dev_", "data_", "assoc_", "removal=
_", "key_", "psp_dev_"},
                          args=3D(cfg, ))
=20
                 cfg.comm_sock.send(b"exit\0")
--=20
2.47.3


