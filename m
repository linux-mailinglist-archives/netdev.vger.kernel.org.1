Return-Path: <netdev+bounces-256742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lb0GdRmg2nQmQMAu9opvQ
	(envelope-from <netdev+bounces-256742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:33:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF4E8DE5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA1830AFF3D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32014266A5;
	Wed,  4 Feb 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwIOrDXX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A24266B2
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218421; cv=none; b=NyK1lKWJNsSKFpXZmmW41rt62qtJ0sySlQeEEPv/nNJgpapEMaFb1JV9zgmahB9bkT4E/zv8OUwDM6yb45Ya40Rkcs+WniuAwtkJA+0RH2PZ8+3fhi+re2tI+QnwvC2mjVWbb0IxE7+Hna0nn5L8YvIwNJ3yn9LCihMZZJ/o9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218421; c=relaxed/simple;
	bh=kNPqWXVV8l7/JeEqmo0EqQRHVr8HsrtNNN0PIjCDxG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8pwEw94zWXbifQ6k1c8+gzt/ZVFgRxwCnYBgdT9EdqQ2mtsX8jKpaDvUdFjcHi8AYRFpcIbNeR9/B3diKHtlgx5cPrgtRvdTDUUtDHu0zVGzEPR8NWnWzc0y/PYvLCrCs6vjkrWgKeHZc/9jyri9Im9sy+GhrGbFYgwobYdC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwIOrDXX; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649d4690174so2110908d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218420; x=1770823220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBXQkL/Zo/E7PWsc0tzaDu5+9rnsudHSZhcePg4W0L4=;
        b=CwIOrDXXY9f16nUEFdyCNWIfISVIff9AabX0/V68uGixbRPYWmTwCEtavMDx7Ll8im
         8E3FsnKc+8khE8IWz0oNUV4TBbnDmjKboUIKKvOzW5zKD8LD+ZvlgpbWIgiQxoSpzKPo
         hIT4N/tK/n0BnhcSGFAqqY4bXkbZF7q33odfADR2tgZP06kHCpE4KsDr1rZSKagd7gOJ
         aC3DTLnOFzV5lMVGokr4gDLqcG+XEkas/mUzcuQllp3em4Wd4kj1yj9wcP0jxAgDm7B2
         o5ZuK/NNZbA7vB39Ubk1V+wOJZMthklS1HfaYp7EWl8tAqVUB9bVlNdpRTpX7kqPCQC9
         Qpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218420; x=1770823220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xBXQkL/Zo/E7PWsc0tzaDu5+9rnsudHSZhcePg4W0L4=;
        b=aIEYurPyKL7SWy2YlKWhBNxDzToc4d+p4BbWEf/vhxV7WPSpmHC9s/Ld7EWzYz4Mm1
         i6JRByHNaQ833SMlf2yP392G/Eyg+dxL/Z+lTrsuyeuFVohB+BaRXt/OR8Jff3oWiqBA
         NVet7hC1WNDXef9w6eIGVH6X7/76/eVNmE34Q9LyF2oLbVfiqxQB4sZglZdga2ATeg/q
         Xc+sOaJkt0kFSidtScQocPW+QUpX58nAzHe3yaS8RPU54D5zyKBluJHs1VvD/oQIY6Kx
         WsyPGyGjro/aQS6FRCsDkbhw4geCutGx6KLh7zsCa/Q7kg6MBrfw9qZ2N9BknlciPCNQ
         jQFg==
X-Gm-Message-State: AOJu0YxlaPhj2hmDGrdUDz08V7FTaSn8ohkU1h/X+A5wv2+lF6TwufhD
	B/aiVPVZgM5Mm1CvjV9LSVnpuPcplHCvowOSGNkXIomxg43FaPyb9ju1
X-Gm-Gg: AZuq6aI3UnNTvmkDBt068Y/H17IbrVapxmAW65VR5++hw5FlhQ6+7p/sX8VUwWpfZTM
	47wKeckn3EWddHuwaXC4Sp3xybfo0f6fTGYCCT8nnvKW/izE0T4kTdgeHY0+LW7t4AkVzdnswy5
	K0kT8BBbt/3k1Li76QyYKgoor247ZogufrWYirAxemXw301tAz0Uu5MNs2RMSgfSAoTc87KUw0o
	gq+KZ87Gp/7d43NWEo7ye51GbuBCR1tyT+79X8D1hbdlTDmvg+L7DLR0ZPmzppU+AQ7ESNIQOQz
	MqVG8NyNhaD5oIUCD4NizzZm1vLRdniv/q7eBNA4rttSQsOXzD/tXsabovG74biuIOj1KZFn1+g
	3LRny1HQWqryc91+nFC4Hzy+6yN0s4ZIQ1RxOXnaoHht5UvgC/zHYO5hgUisCrDiDEJdbF3EkSs
	mJeFUNfz2W
X-Received: by 2002:a53:c0d0:0:b0:649:d4ce:243f with SMTP id 956f58d0204a3-649db33fb9cmr2286088d50.3.1770218420129;
        Wed, 04 Feb 2026 07:20:20 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5ea03bsm2604607d50.24.2026.02.04.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:19 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:13 -0800
Subject: [PATCH net-next 9/9] selftests: drv-net: psp: add tests for
 rekeying connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-9-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256742-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABEF4E8DE5
X-Rspamd-Action: no action

Add testcases for rekeying psp connections. Some simple tx or rx only
scenarios, and also a more complicated mix of tx/rx rekeys and device
key rotations.

Note: the data echo handler does not appear here because it was added
in commit 2aeb71b2f9e8 ("selftests: drv-net: add PSP responder")

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py         | 120 +++++++++++++++++++
 .../testing/selftests/drivers/net/psp_responder.c  | 131 +++++++++++++++++++++
 2 files changed, 251 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 63dc8757ba37..f6bce462f28a 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -19,6 +19,19 @@ from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
 
+class PSPExceptShortIO(Exception):
+    pass
+
+
+def psp_ver_keylen(version):
+    """Key length for given PSP version"""
+    if version == 0 or version == 2:
+        return 16
+    elif version == 1 or version == 3:
+        return 32
+    raise Exception(f"psp_ver_keylen(): bad version: {version}")
+
+
 def _get_outq(s):
     one = b'\0' * 4
     outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
@@ -60,6 +73,19 @@ def _close_psp_conn(cfg, s):
     _close_conn(cfg, s)
 
 
+def _provide_spi(cfg, version):
+    _send_with_ack(cfg, b'provide spi\0')
+    tx = cfg.comm_sock.recv(4 + psp_ver_keylen(version))
+    return {
+        'spi': struct.unpack('I', tx[:4])[0],
+        'key': tx[4:]
+    }
+
+
+def _use_spi(cfg, rx):
+    _send_with_ack(cfg, b'use spi\0' + struct.pack('I', rx['spi']) + rx['key'])
+
+
 def _spi_xchg(s, rx):
     s.send(struct.pack('I', rx['spi']) + rx['key'])
     tx = s.recv(4 + len(rx['key']))
@@ -110,6 +136,29 @@ def _check_data_outq(s, exp_len, force_wait=False):
     ksft_eq(outq, exp_len)
 
 
+def _recv_careful(s, target, rounds=100):
+    data = b''
+    for _ in range(rounds):
+        try:
+            data += s.recv(target - len(data), socket.MSG_DONTWAIT)
+            if len(data) == target:
+                return data
+        except BlockingIOError:
+            time.sleep(0.001)
+    raise PSPExceptShortIO(target, len(data), data)
+
+
+def _req_echo(cfg, s, expect_fail=False):
+    _send_with_ack(cfg, b'data echo\0')
+    try:
+        _recv_careful(s, 5)
+        if expect_fail:
+            raise Exception("Received unexpected echo reply")
+    except PSPExceptShortIO:
+        if not expect_fail:
+            raise
+
+
 def _get_stat(cfg, key):
     return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
 
@@ -399,6 +448,77 @@ def _data_basic_send(cfg, version, ipver):
     _close_psp_conn(cfg, s)
 
 
+def data_basic_rx_rekey(cfg, version=0):
+    """ Test basic rx rekey """
+    _init_psp_dev(cfg)
+
+    s = _establish_psp_conn(cfg, version, None)
+    data_len = _send_careful(cfg, s, 10)
+    _check_data_rx(cfg, data_len)
+
+    for _ in range(10):
+        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        _use_spi(cfg, rx)
+        _req_echo(cfg, s)
+
+
+def data_basic_tx_rekey(cfg, version=0):
+    """Test basic tx rekey"""
+    _init_psp_dev(cfg)
+
+    s = _establish_psp_conn(cfg, version)
+    data_len = _send_careful(cfg, s, 10)
+    _check_data_rx(cfg, data_len)
+
+    for _ in range(10):
+        tx = _provide_spi(cfg, version)
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx,
+                            "sock-fd": s.fileno()})
+        data_len += _send_careful(cfg, s, 10)
+        _check_data_rx(cfg, data_len)
+
+
+def data_rekey_and_rotate(cfg, version=0):
+    """Test a mix of key rotations and rekey operations"""
+    _init_psp_dev(cfg)
+
+    s = _establish_psp_conn(cfg, version)
+    data_len = _send_careful(cfg, s, 10)
+    _check_data_rx(cfg, data_len)
+
+    rounds = 3
+    tx_rekeys_per_round = 2
+
+    for _ in range(rounds):
+        cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+
+        # receive data on rotated key
+        _req_echo(cfg, s)
+
+        # rekey and receive data on active key
+        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        _use_spi(cfg, rx)
+        _req_echo(cfg, s)
+
+        # perform an arbitrary number of tx rekeys
+        for _ in range(tx_rekeys_per_round):
+            tx = _provide_spi(cfg, version)
+            cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                                "version": version,
+                                "tx-key": tx,
+                                "sock-fd": s.fileno()})
+            data_len += _send_careful(cfg, s, 1)
+            _check_data_rx(cfg, data_len)
+
+
 def __bad_xfer_do(cfg, s, tx, version='hdr0-aes-gcm-128'):
     # Make sure we accept the ACK for the SPI before we seal with the bad assoc
     _check_data_outq(s, 0)
diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
index a26e7628bbb1..d62982e3bc68 100644
--- a/tools/testing/selftests/drivers/net/psp_responder.c
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -37,6 +37,77 @@ static struct {
 	unsigned char rx;
 } psp_vers;
 
+static int psp_ver_key_len(unsigned char version)
+{
+	switch (version) {
+	case PSP_VERSION_HDR0_AES_GCM_128:
+	case PSP_VERSION_HDR0_AES_GMAC_128:
+		return 16;
+	case PSP_VERSION_HDR0_AES_GCM_256:
+	case PSP_VERSION_HDR0_AES_GMAC_256:
+		return 32;
+	default:
+		fprintf(stderr, "ERROR: %s: bad version %d\n",
+			__func__, version);
+	}
+
+	return 0;
+}
+
+static int
+set_tx_spi(struct ynl_sock *ys, struct opts *opts, __u32 spi, char *key,
+	   int data_sock)
+{
+	struct psp_tx_assoc_rsp *tsp;
+	struct psp_tx_assoc_req *teq;
+	ssize_t sz;
+
+	teq = psp_tx_assoc_req_alloc();
+
+	psp_tx_assoc_req_set_sock_fd(teq, data_sock);
+	psp_tx_assoc_req_set_version(teq, psp_vers.tx);
+	psp_tx_assoc_req_set_tx_key_spi(teq, spi);
+	psp_tx_assoc_req_set_tx_key_key(teq, key, psp_ver_key_len(psp_vers.tx));
+
+	tsp = psp_tx_assoc(ys, teq);
+	psp_tx_assoc_req_free(teq);
+	if (!tsp) {
+		perror("ERROR: failed to Tx assoc");
+		return -1;
+	}
+	psp_tx_assoc_rsp_free(tsp);
+
+	return 0;
+}
+
+static int
+get_rx_spi(struct ynl_sock *ys, struct opts *opts, __u32 *spi, char *key,
+	   int data_sock)
+{
+	struct psp_rx_assoc_rsp *rsp;
+	struct psp_rx_assoc_req *req;
+
+	req = psp_rx_assoc_req_alloc();
+
+	psp_rx_assoc_req_set_sock_fd(req, data_sock);
+	psp_rx_assoc_req_set_version(req, psp_vers.rx);
+
+	rsp = psp_rx_assoc(ys, req);
+	psp_rx_assoc_req_free(req);
+
+	if (!rsp) {
+		perror("ERROR: failed to Rx assoc");
+		return -1;
+	}
+
+	memcpy(spi, &rsp->rx_key.spi, sizeof(*spi));
+	memcpy(key, rsp->rx_key.key, rsp->rx_key._len.key);
+
+	psp_rx_assoc_rsp_free(rsp);
+
+	return 0;
+}
+
 static int conn_setup_psp(struct ynl_sock *ys, struct opts *opts, int data_sock)
 {
 	struct psp_rx_assoc_rsp *rsp;
@@ -118,6 +189,52 @@ static void send_str(int sock, int value)
 	send(sock, buf, ret + 1, MSG_WAITALL);
 }
 
+static void
+handle_provide_spi(struct ynl_sock *ys, struct opts *opts, int data_sock,
+		   int comm_sock)
+{
+	char msg[sizeof(__u32) + psp_ver_key_len(psp_vers.tx)];
+	__u32 spi;
+
+	if (data_sock < 0) {
+		fprintf(stderr, "WARN: provide tx spi but no data sock\n");
+		send_err(comm_sock);
+		return;
+	}
+
+	if (get_rx_spi(ys, opts, &spi, &msg[sizeof(spi)], data_sock)) {
+		fprintf(stderr, "ERROR: get_rx_spi() failed\n");
+		send_err(comm_sock);
+		return;
+	}
+
+	send_ack(comm_sock);
+	memcpy(msg, &spi, sizeof(spi));
+	send(comm_sock, msg, sizeof(msg), MSG_WAITALL);
+}
+
+static void
+handle_use_spi(struct ynl_sock *ys, struct opts *opts, char *msg, int data_sock,
+	       int comm_sock)
+{
+	__u32 spi;
+
+	if (data_sock < 0) {
+		fprintf(stderr, "WARN: use tx spi but no data sock\n");
+		send_err(comm_sock);
+		return;
+	}
+
+	memcpy(&spi, msg, sizeof(spi));
+	if (set_tx_spi(ys, opts, spi, &msg[sizeof(spi)], data_sock)) {
+		fprintf(stderr, "ERROR: set_tx_spi() failed!\n");
+		send_err(comm_sock);
+		return;
+	}
+
+	send_ack(comm_sock);
+}
+
 static void
 run_session(struct ynl_sock *ys, struct opts *opts,
 	    int server_sock, int comm_sock)
@@ -224,6 +341,20 @@ run_session(struct ynl_sock *ys, struct opts *opts,
 						fprintf(stderr, "WARN: echo but no data sock\n");
 					send_ack(comm_sock);
 				}
+				if (cmd("provide spi"))
+					handle_provide_spi(ys, opts, data_sock, comm_sock);
+				if (cmd("use spi")) {
+					char msg[sizeof(__u32) + psp_ver_key_len(psp_vers.tx)];
+
+					if (off >= sizeof(msg)) {
+						memcpy(msg, buf, sizeof(msg));
+						__consume(sizeof(msg));
+						handle_use_spi(ys, opts, msg, data_sock, comm_sock);
+					} else {
+						fprintf(stderr, "WARN: short use spi command!\n");
+						send_err(comm_sock);
+					}
+				}
 				if (cmd("data close")) {
 					if (data_sock >= 0) {
 						close(data_sock);

-- 
2.47.3


