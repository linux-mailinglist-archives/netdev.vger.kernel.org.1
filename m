Return-Path: <netdev+bounces-258397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ke1JQ4njWlOzgAAu9opvQ
	(envelope-from <netdev+bounces-258397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:04:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9AE128C3E
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C483106F44
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585831E0DE8;
	Thu, 12 Feb 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPwvH9bh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A51A2392
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858114; cv=none; b=rrO1AZj1YFsLzjbM6r8VuWsIeOUclx2IVQFsDS2tjKhRTaQAEEgn7Qaml5X5DTPZ1UbdfRq+K6LazRsCMFo06XD4DBS/bE/ZEL926Q1ZvF+4QSN7qDc7/cRbyraj/s1rvqGvnLlqgkI3jWlUOEP/5RIQHhGjvoBs3Ud9QoS7e2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858114; c=relaxed/simple;
	bh=5sBl97i+inRS8PFAXGy2J3iA+JTLwGT6khnA0yINGz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEnlwu6MLw1v2PX6FgzUOUNhiWLbWbBXFz86VHm3FtScceDFXecQXm8vSs69ves90ZIeIwhxaYmRJ2pwXQBWyNecSSRrSpBdb/vgwyP+ToajiF4Zg33ptYAKOh4JnWlVV7dY0qrxhNKyBnJ6/wnPzQwC0yRhWF0VNTH+6un9d8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPwvH9bh; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64adabaafd6so2720104d50.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858112; x=1771462912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H7SmwrPwDgMoAqOWKw9ZmCtrgHBYE/GNb30EsZTC2I=;
        b=WPwvH9bh3wW+CzErInz2IZrqECwVTK6EopC/48V1Vhgv1CldpbgqZsiD+Vgrlouvuv
         tEFFGjbkz1uEsXvUrqa6acbZanU/vA9l0cFs8sYtWziF6qtxXHrGOEKZOKOjzf4omqcI
         CgMfq9NC0Y1xozlPdtkfAxhs8OxIuWbISwZQmRFIJblajO1UrLiD7GIw4o40B73ZGeOL
         ZD//45MKleAKrMhk401zPE9buJZySS6n+FAK3U5rFe6uyx7L1TleklXa5khhRUY1iP18
         FouyMzDQZA/u4CkqdexRF1aom9rXo6A98gKmakON19mmEVjqgLevSXH6XyZKcuFwVdqJ
         +UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858112; x=1771462912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7H7SmwrPwDgMoAqOWKw9ZmCtrgHBYE/GNb30EsZTC2I=;
        b=HR36IrLwIMf2qzwQmz8MBiOj8Z68KYDYnqYMGxeFMaIrh+wkb1fPKZZ/QvCP+UOoCn
         7tEDPQOyIlJey0I9RAvUr6gxu0ttNY/txtQWzrfLaUTzmEcF4vJE/6Qa60B/wSYBEDZr
         /elEuNJ+9INI3SCstISWz2m3sgcP76a9ZFvzD9XKtj5oeREa5LdBwPETXvMd75B4CZnV
         i709NN1FFVZqSdXYnAiczuYsLm2tMaJDlbZ4+UJ4mxTioY3+l+b7j71+2yuz05AelW9d
         MjyuqJwujuHTwPDptu1LzA0nCOEt6HRqskAQb9N6mcPywZ4s4CjiVl8YTOAGYKgQyzN8
         /dpA==
X-Gm-Message-State: AOJu0YxpLpv7/3kDr3yv+tMoVbM7a2ozo3gf22v1vKK3nhdJKwShkbMy
	cCx6K82B8sfyylGfNp7ak5aenfS3MAsNpkiwLPlkZ+HgKhXOvGWj1iCY
X-Gm-Gg: AZuq6aIdHuKwrky/3VTXzKh4Ej7TNJMH3C2H1b77Qx0Rc+Kzpk3v8Ns8Gq+v4hhGvAu
	QobTtGsVY96apn5q4zjDUw9cQW/huXHzOZB5s6zrCxKjBcGnrb50HPdlRhRaycZq1SXke2IE+LF
	0mPTuSNcgyXXWtmDWzWntND/uoAmHLV6s683/ZSYhsNg9sbxrNi8jHBnvKDLrC2mbD/zi3bmKQ4
	2VFhgxkn3B46+fUqMG3qZWsebgixitUpf2layTUAcGZNA+sqpf9dfjU5oY/5BW/hhM3ggBuqI4z
	ZyK9JA8h7Yxd/oHLwMFwL2Guhg2SVEOjKxwl54u5oYVolmezPW7jKpfxg++rL6ClvRNOSXA1f8u
	bxvH1zRHZEhln6LamQoSlSK5DYqd2rl0i6hb0diQNVvtCBdmghnBfKUUs9qy6/I3yzzkAENaPi+
	5kLHwZTIa+azrK3DdLUmljkQ==
X-Received: by 2002:a05:690e:14c7:b0:64a:db39:f002 with SMTP id 956f58d0204a3-64c080bf02fmr436658d50.0.1770858111903;
        Wed, 11 Feb 2026 17:01:51 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc98833bsm3543989d50.17.2026.02.11.17.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:01:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 11 Feb 2026 17:00:44 -0800
Subject: [PATCH net 4/4] selftests: drv-net: add HDS payload sweep test for
 devmem TCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-fbnic-tcp-hds-fixes-v1-4-55d050e6f606@meta.com>
References: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
In-Reply-To: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258397-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 1B9AE128C3E
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_rx_hds test that verifies header/data split works across
payload sizes. The test sweeps payload sizes from 1 byte to 8KB, if any
data propagates up to userspace as SCM_DEVMEM_LINEAR, then the test
fails. This shows that regardless of payload size, ncdevmem's
configuration of hds-thresh to 0 is respected.

Add -L (--fail-on-linear) flag to ncdevmem that causes the receiver to
fail if any SCM_DEVMEM_LINEAR cmsg is received.

Use socat option for fixed block sizing and tcp nodelay to disable
nagle's algo to avoid buffering.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 19 ++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 ++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..ee863e90d1e0 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -63,12 +63,29 @@ def check_tx_chunks(cfg) -> None:
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+def check_rx_hds(cfg) -> None:
+    """Test HDS splitting across payload sizes."""
+    require_devmem(cfg)
+
+    for size in [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]:
+        port = rand_port()
+        listen_cmd = f"{cfg.bin_local} -L -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
+
+        with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+            wait_port_listen(port)
+            cmd(f"dd if=/dev/zero bs={size} count=1 2>/dev/null | " +
+                f"socat -b {size} -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},nodelay",
+                host=cfg.remote, shell=True)
+
+        ksft_eq(ncdevmem.ret, 0, f"HDS failed for payload size {size}")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..adc89591c834 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -97,6 +97,7 @@ static unsigned int ifindex;
 static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
+static bool fail_on_linear;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -974,6 +975,11 @@ static int do_server(struct memory_buffer *mem)
 					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
 					dmabuf_cmsg->frag_size);
 
+				if (fail_on_linear) {
+					pr_err("received SCM_DEVMEM_LINEAR but --fail-on-linear (-L) set");
+					goto err_close_client;
+				}
+
 				continue;
 			}
 
@@ -1397,8 +1403,11 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:")) != -1) {
 		switch (opt) {
+		case 'L':
+			fail_on_linear = true;
+			break;
 		case 'l':
 			is_server = 1;
 			break;

-- 
2.47.3


