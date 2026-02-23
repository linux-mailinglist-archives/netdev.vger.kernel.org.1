Return-Path: <netdev+bounces-260171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC5fIXCqnGklJwQAu9opvQ
	(envelope-from <netdev+bounces-260171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:28:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71C317C5F2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36D630F9E56
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2016377554;
	Mon, 23 Feb 2026 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YUwSrjLB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284B36EA87
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873938; cv=none; b=CbWSmk/h3HI5ehQVOuEMceMOkcKPWs1oAOn8NQpcVFgUbvDdxDrAnnBSNxmAW3twYN+8U70Hy486kRiBU08nBx+uyuw6MswtQPKBjSRNwHelMOj1hun+hHf83MrApxIhaizkXnqAZ9PqqzK5IrmUgqkualoqniSkV4QB2H//rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873938; c=relaxed/simple;
	bh=x17WP3Dwga+51H9UAnNm6q/nTgZkKgkWipG2h8Ozs08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFiQT1bXAlyOqMZ+Mj99xOI1b6MLcNEonOEHoyTQf4K3oK4Auqjy8qH8ltAqL/W/TR+kwanP0nV5bLy3F2SgMD3GXrzE1oVEGSGZ/G8hnpiGN7awHW9rYElzYjhTp+G0tkIDop+6FnxV9rQaRzMibrPaIQ01EZ1CclWnUu1MOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YUwSrjLB; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35621aa8c7fso2517104a91.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873933; x=1772478733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuvyQiLmrnh28Gu37E9OPE1T+qFo4OP2EvGponbeEDU=;
        b=nVf1cXf96ZWyFQ1KzzcoLKFMsfy/vVooP7+e7VOwpD+BG1RWAg66ZLbNO4eC5OjeEE
         z0vlBA9Jcq2lc+Zf3Uv1JXhQOYY1vMyoVk5RgEwFYH/Q3nVCyPWObhguBkkxsXOobq3b
         1g23HOs8ybVbLIyhZDv8LkmG8IZp06OnMv8UXFJEt2PmIwMiM18mxqISkL4fwIm2XZKD
         fZCnOxTCw+g7Dj7DoA/OIGZNW4G+QPQSyEpBOp/7/rUtSteampFauomHUwSGOEslhPUq
         twVmZFNlgqPScg5LfcN/fWezN9EW/XPP0SWy+dPXM2HGL8KkGqg37gCiIqzPMe9YP4IC
         biGg==
X-Gm-Message-State: AOJu0YzghTAjyGf9lu/8WkdGxya8go0hejZzT2CKs2JmINFqmGeSct6h
	GXeT4vYfYKq+9IZUZ5+hWCMDUaK8I61o6zp9edeoATWQaSm8TwjqXLDDD4Vw3d6rz+LN8AC8O0N
	DdFFEhDdpfg5Zq4zRBTQ+BwZoqfd0vr1plDR8mOFOMSe98kAZum39Lf8rysUOxyd1K+yBvJXz0s
	tcQkoqfFqDKp5rvwVtnxxIVGW3PdGdsok72IyTCk3SKkDNwZ1YwH9k2vqb4k03EmNmKuFaqUec4
	OJgf/6ZDqFh
X-Gm-Gg: ATEYQzx87dTib1JDPE9OVAh9nahAMNGfmoCLTB6kDqIoR+Be5DyAmRMXij/EZaimn15
	s1Byl54MjHeO6+0d/44DOrwwFAWPq/SD02p20k6J18Q+3cEKKZLl4y6uU5LBLzukcWLoW+xdihA
	gbYV9end6Y59h+dcEgFtWf7DG79NwPUyeu32rGejVrvjSiBxCUzPluDqRgtV1UBqK2zIz7G2GXa
	vxN45WyzpZZwML54uOoLqd7Dot+IsEBb31Y/E4YjPGU+byJHNwVtv6w9dile0ijcumlBM73q+P/
	l27BRJTYwRUgNXPmbJVSAJ9+cI6IXhg1yVA0nQSLvkJFaihEleT6s3109RaoOO69olujk5x28Ut
	xw3IRSSU4p132LUNF0xBuJGFeYn6p5IX8jBnoKgVgP3f+9jzSBGXopt04NSe0mYrYuSLBIyQ3Ze
	8GBYVKyTMt7x/Pm5og2j6kssFzkbahlKr+9GPUXZyKgXk9vtxpyvE7So8=
X-Received: by 2002:a17:90b:4b0f:b0:354:bd08:4802 with SMTP id 98e67ed59e1d1-358aea06fe5mr7343908a91.35.1771873933127;
        Mon, 23 Feb 2026 11:12:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-95.dlp.protect.broadcom.com. [144.49.247.95])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-358af8e35d3sm1084409a91.3.2026.02.23.11.12.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 11:12:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba7e98178fso4214814eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771873931; x=1772478731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuvyQiLmrnh28Gu37E9OPE1T+qFo4OP2EvGponbeEDU=;
        b=YUwSrjLBh8FbD4nhrVrhk3sdpowGDsekStHGd4+8lHRHXgkVtfMz9OOl97ouXhi3qH
         /BJduc+awlx39Gj9paJJfpGIF/6YSBtygqF/91hzELLfqsKXafiahX9cIb1/b0cM62xP
         7Qnq0EFnPNikdR2EwCLg4OH/l7vPOWEEx86WA=
X-Received: by 2002:a05:7300:bb0a:b0:2ba:6a79:f04c with SMTP id 5a478bee46e88-2bd7bd54575mr4359571eec.18.1771873931143;
        Mon, 23 Feb 2026 11:12:11 -0800 (PST)
X-Received: by 2002:a05:7300:bb0a:b0:2ba:6a79:f04c with SMTP id 5a478bee46e88-2bd7bd54575mr4359554eec.18.1771873930474;
        Mon, 23 Feb 2026 11:12:10 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eec5sm5332734eec.4.2026.02.23.11.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:12:10 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v2 2/2] selftests: drv-net: psp: add test for VLAN sub-interface
Date: Mon, 23 Feb 2026 11:11:54 -0800
Message-ID: <20260223191154.2800616-3-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260223191154.2800616-1-kiran.kella@broadcom.com>
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,redhat.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260171-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C71C317C5F2
X-Rspamd-Action: no action

Add test to validate that the psp device information is propagated
properly from the lower device to the upper devices so that
the PSP transmit validation passes.

Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 tools/testing/selftests/drivers/net/psp.py | 86 +++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..c45a04172844 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -18,6 +18,7 @@ from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
+from lib.py import ip
 
 def _get_outq(s):
     one = b'\0' * 4
@@ -570,6 +571,89 @@ def removal_device_bi(cfg):
     finally:
         _close_conn(cfg, s)
 
+def vlan_basic_send(cfg):
+    """
+    Test PSP over VLAN-to-VLAN traffic
+
+    Network topology:
+      Local VLAN (nsim0.100) <---> Remote VLAN (nsim1.100)
+           |                            |
+      Local Physical (nsim0) <---> Remote Physical (nsim1)
+          [PSP configured here]
+    """
+    _init_psp_dev(cfg)
+
+    # VLAN configuration
+    vlan_id = 100
+    local_vlan_ifname = f"{cfg.ifname}.{vlan_id}"
+    remote_vlan_ifname = f"{cfg.remote_ifname}.{vlan_id}"
+
+    local_vlan_addr_v4 = "192.0.2.21"
+    remote_vlan_addr_v4 = "192.0.2.22"
+    local_vlan_addr_v6 = "2001:db8::21"
+    remote_vlan_addr_v6 = "2001:db8::22"
+
+    # Create VLAN interface on LOCAL side
+    ip(f"link add link {cfg.ifname} name {local_vlan_ifname} type vlan id {vlan_id}")
+    defer(ip, f"link del {local_vlan_ifname}")
+    ip(f"addr add {local_vlan_addr_v4}/24 dev {local_vlan_ifname}")
+    ip(f"-6 addr add {local_vlan_addr_v6}/64 dev {local_vlan_ifname} nodad")
+    ip(f"link set {local_vlan_ifname} up")
+
+    # Create VLAN interface on REMOTE side
+    ip(f"link add link {cfg.remote_ifname} name {remote_vlan_ifname} type vlan id {vlan_id}", host=cfg.remote)
+    defer(ip, f"link del {remote_vlan_ifname}", host=cfg.remote)
+    ip(f"addr add {remote_vlan_addr_v4}/24 dev {remote_vlan_ifname}", host=cfg.remote)
+    ip(f"-6 addr add {remote_vlan_addr_v6}/64 dev {remote_vlan_ifname} nodad", host=cfg.remote)
+    ip(f"link set {remote_vlan_ifname} up", host=cfg.remote)
+
+    # Get VLAN interface index
+    local_vlan_info = ip(f"-j link show {local_vlan_ifname}", json=True)[0]
+    local_vlan_ifindex = local_vlan_info['ifindex']
+
+    # Create a cfg-like object for VLAN interfaces
+    # The PSP device is still on the physical interface, but
+    # the socket will be bound to the VLAN interface
+    class VlanCfg:
+        pass
+
+    vlan_cfg = VlanCfg()
+    vlan_cfg.ifname = local_vlan_ifname
+    vlan_cfg.ifindex = local_vlan_ifindex
+    vlan_cfg.remote_ifname = remote_vlan_ifname
+    vlan_cfg.addr_v = {"4": local_vlan_addr_v4, "6": local_vlan_addr_v6}
+    vlan_cfg.remote_addr_v = {"4": remote_vlan_addr_v4, "6": remote_vlan_addr_v6}
+    vlan_cfg.addr = local_vlan_addr_v4
+    vlan_cfg.remote_addr = remote_vlan_addr_v4
+    vlan_cfg.pspnl = cfg.pspnl
+    vlan_cfg.psp_dev_id = cfg.psp_dev_id
+    vlan_cfg.remote = cfg.remote
+    vlan_cfg.comm_port = cfg.comm_port
+    vlan_cfg.comm_sock = cfg.comm_sock
+
+    s = _make_psp_conn(vlan_cfg, version=0)
+    defer(_close_psp_conn, vlan_cfg, s)
+
+    # Create PSP associations
+    # The socket's device is VLAN, but PSP device is on physical NIC
+    rx_assoc = vlan_cfg.pspnl.rx_assoc({
+        "version": 0,
+        "dev-id": vlan_cfg.psp_dev_id,  # PSP device on physical interface
+        "sock-fd": s.fileno()
+    })
+    rx = rx_assoc['rx-key']
+    tx = _spi_xchg(s, rx)
+
+    vlan_cfg.pspnl.tx_assoc({
+        "dev-id": vlan_cfg.psp_dev_id,
+        "version": 0,
+        "tx-key": tx,
+        "sock-fd": s.fileno()
+    })
+
+    # Send data through VLAN interface (VLAN-to-VLAN traffic!)
+    data_len = _send_careful(vlan_cfg, s, 100)
+    _check_data_rx(vlan_cfg, data_len)
 
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
@@ -624,7 +708,7 @@ def main() -> None:
                 ]
 
                 ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "data_", "assoc_", "removal_"},
+                         case_pfx={"dev_", "data_", "assoc_", "removal_", "vlan_"},
                          args=(cfg, ))
 
                 cfg.comm_sock.send(b"exit\0")
-- 
2.45.4


