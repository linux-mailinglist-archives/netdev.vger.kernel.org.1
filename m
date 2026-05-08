Return-Path: <netdev+bounces-285579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ck2In5K/WmUaAAAu9opvQ
	(envelope-from <netdev+bounces-285579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:29:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AD4F0C39
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E02230485C3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8326F29B;
	Fri,  8 May 2026 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc7yoTmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E286283C83
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207309; cv=none; b=bCalmcwOKB4/HO4nLlkPsKCknLZkHHQ6fUg6zG4jpmIFs3XEumJCIgNm3ioGUIHXJrBhpfwFuTU4Z5NKArjngu0VyaT2E34FIXK9joKBVH+rdQm9JDpytZaUbpfrIFW/gmLsEeZzhClpLBuId73UvIs0Xzn/rNNQGS4BgqevEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207309; c=relaxed/simple;
	bh=d6eZsFBeT6SRd4hLrPMqK9XIMSn8RsdbgB33+GNTMVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dmfc4w2xZkgDJ0mVaF5H3RXmJQzBfFb3MAr19Gz9tDaM1z/6P3+7s6y4NU+33JcgtaFXe8P0DxcKTNws5zjWTJBsGLfKM0cAQfkgpMtp9M38COCMcYR5GJ3wpTo4eWYLaioGUwck74XR2RDi2rco6RsK8Q7fXbwzaoACr+FMMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc7yoTmR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d75bfb259so9657811cf.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 19:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207303; x=1778812103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Q5v9gHszU1RWAN1/wyAj48v0l++/KCLjJw6Cixcm4g=;
        b=Yc7yoTmR/uSvu0ocqttJ4Qdiu40Pymwy5k/5F1D/Wul6qx5U3QRCL3ybqoaHUKaDau
         DlK0AL84/u7B/BhuZzTXihK/Rz9g2IML8IPSHtAqitbrmi27IQDI2bfberOK1XaXa5VB
         luFH5o0PfzTnydJngDPe6YJxt5j/BBYvWGYw3kMNR94b1VKCGG295zpjuSJ1DpHrJLDa
         UqgvAaFOWJ1ACkklGOuIzMm+rsad8bC8hF1JoucMkAdZTuKWzgiPTmI0AJx9KRvIb4Uj
         CEKw4saP1Of0Nr+Cgh/Ix0lsbBogCvMmqPBd8bvHDsz29Ys01pKlJG9vwl/aazFkWSbC
         ykyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207303; x=1778812103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Q5v9gHszU1RWAN1/wyAj48v0l++/KCLjJw6Cixcm4g=;
        b=hbAPe6m9PbgOQttlfztl29bbZr/MjxyWnMr57Shm1qgqNJ6ufVc+5P2jXG+ANzk29f
         FnOFJuh5M4HhQ6/s3CjjNKkVe8LQ5BQYce0UpoWzhhTMMBaYVH2TSmSdbCx2QVM49ZEP
         w1bd6IRff4lU556i8dIVQcg9Nb4+ZT59dd+otbUbT5xhLcXzEV3FDosY5GLtZFzSo0oi
         uXrCi0n/dZKOoWeCjmNy69QDlob7bKSzE2/a+Pm7sowOvrISMYntYJfpj+zpYjDTKgXG
         a+jopuYK/DZDrSiJHju/Wt0i0MRZpHOkMIZaPednLXbdw5pnjvMyCKUyAg9L7u5II/N2
         2LEg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ug4Cz+d/6/A0nPNRm7cF5ABwEkR+XTgbM4DT2c85lc/CCKFSe601nwGu8LKAJzSbYqBcbmN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQAnFq0ByDzv21ZonWfxuRq1wbYhr26maVcqtnokrlHXKp5Fi
	ODluqWnDYrGO3vmDZ+Eld0jVNIaPTsypzLjQuqnV0a0IL/GX9ZPyb0wA
X-Gm-Gg: AeBDieu7yt1/8CmesGtdUmm/Ur5wjYvmmF7Ptvti3nvLTUhFIWqik51neik2P8wzduk
	rw912QLy9I2qO/9XUPRPAaIq3arlwXYxjIoqe8/emVvOQISQRYUvCP+IE+Bkm7xcSBF/7kSRzF9
	BPYsxmfdylp5phFwd9ON9Sr0Pr6qLKH4Y1sK5JTldFBYzP5AVcfjjdJmMUQM2xmSXvWMLJYXjXI
	uJTyFLN4PhqIf+GIuxwbW/gZ0ehKPY/omhI7H1UnA2pPwdr2wz+Gl0RQcfegPQdd2NBApu23Q7R
	kSYu8oXVxoxMMSKETHB79xvbCgL9ecQlwTYx4y0g/AuckThVOUC+v4ZAxwc74LvgTwsZAKfXLti
	SHkv01HlGsQG+VeWOIOVzXbS6Lq/9IMgqvwqOjvfUtVEqdXwxiCOroVB6hOkUQRac3a+7R9my6s
	CM6XDGLe9oIN9Fu7fZX8lSGwdFmbMMTRkM
X-Received: by 2002:a05:622a:2d5:b0:50d:9f02:86c7 with SMTP id d75a77b69052e-51461c11682mr155811861cf.13.1778207303232;
        Thu, 07 May 2026 19:28:23 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:32::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3d90sm4711201cf.20.2026.05.07.19.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:50 -0700
Subject: [PATCH net-next v3 5/8] selftests: drv-net: make attr
 _nk_guest_ifname public
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tcp-dm-netkit-v3-5-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
In-Reply-To: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 035AD4F0C39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-285579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netns.name:url]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Subsequent patches will use the _nk_guest_ifname as a public attr for
setting up devmem. Rename to nk_guest_ifname to avoid angering the
linter about the '_' prefix being used for a non-private attr.

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


