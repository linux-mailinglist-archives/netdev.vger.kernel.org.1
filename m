Return-Path: <netdev+bounces-242876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36998C9596D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5097A4E1A9A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768681C6FE1;
	Mon,  1 Dec 2025 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A2r8oEB/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266B19C54F
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556155; cv=none; b=aW6GeKDGc7l77W6jY9YjK38+zszrTJizcp2FrZBNHUM3OHN0lVD8QCPXgiRnje1v7qL1lDxgZFvFFB1OjtiykX/C2YIabnwvtFzs/9BouNEFhbbkD7P1DZortiS6CiTQuzmlETt1QJ5WsZtjxCLUPRbil+PxSQ6UJ2WOPjtrpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556155; c=relaxed/simple;
	bh=bKAxIOKgFegMrX5DTWB1U7Vt6NN7bnNfSovwGC1imxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tusoAWBBhNfRBK8PI0rdanJMmTq6h8u03+RijxSqSqQ41N7vKT/uHT8gS/makNGH1xSU4ABjGPXCpGE9M5iIizrsGNLNhprO8jL8kN5KqPNZu7lm6IRP8KKhAAvJPfEKNFHd5V4+FbQiM0J1vPj638+AFVND9uF0RBW3cGurAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=A2r8oEB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F847C4CEFB;
	Mon,  1 Dec 2025 02:29:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A2r8oEB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TniAGm+XF14dsZO1jygnW/OErDHaNqxz/pIxc97n/II=;
	b=A2r8oEB/2R/GxOj2OaDcaIaGXNcoSyJImB9aYdry9rKygnnQg7XUSOqiLNr6av3CMO1NG2
	5/0WvzOvp7ZVEbR7OgBg4M7BRt3Gv41Z1P51XPGXUO9cmvrQEaslXxtyvyHtKscf6uD9nU
	+/g2ftJXbbJrBsuwNg93+EJU0mCtY7U=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 580a373e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:13 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 10/11] tools: ynl: add sample for wireguard
Date: Mon,  1 Dec 2025 03:28:48 +0100
Message-ID: <20251201022849.418666-11-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Add a sample application for WireGuard, using the generated C library.

The main benefit of this is to exercise the generated library,
which might be useful for future selftests.

In order to support usage with a pre-YNL wireguard.h in /usr/include,
the former header guard is added to Makefile.deps as well.

Example:
  $ make -C tools/net/ynl/lib
  $ make -C tools/net/ynl/generated
  $ make -C tools/net/ynl/samples wireguard
  $ ./tools/net/ynl/samples/wireguard
  usage: ./tools/net/ynl/samples/wireguard <ifindex|ifname>
  $ sudo ./tools/net/ynl/samples/wireguard wg-test
  Interface 3: wg-test
      Peer 6adfb183a4a2c94a2f92dab5ade762a4788[...]:
          Data: rx: 42 / tx: 42 bytes
          Allowed IPs:
              0.0.0.0/0
              ::/0

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                       |   1 +
 tools/net/ynl/Makefile.deps       |   2 +
 tools/net/ynl/samples/.gitignore  |   1 +
 tools/net/ynl/samples/wireguard.c | 104 ++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 tools/net/ynl/samples/wireguard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b44a380642c..660ff0306bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27675,6 +27675,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
+F:	tools/net/ynl/samples/wireguard.c
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 865fd2e8519e..a9a5348b31a3 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -48,3 +48,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_wireguard:=$(call get_hdr_inc,_LINUX_WIREGUARD_H,wireguard.h) \
+	-D _WG_UAPI_WIREGUARD_H # alternate pre-YNL guard
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 05087ee323ba..6fbed294feac 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -8,3 +8,4 @@ rt-link
 rt-route
 tc
 tc-filter-add
+wireguard
diff --git a/tools/net/ynl/samples/wireguard.c b/tools/net/ynl/samples/wireguard.c
new file mode 100644
index 000000000000..43f3551eb101
--- /dev/null
+++ b/tools/net/ynl/samples/wireguard.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <ynl.h>
+
+#include "wireguard-user.h"
+
+static void print_allowed_ip(const struct wireguard_wgallowedip *aip)
+{
+	char addr_out[INET6_ADDRSTRLEN];
+
+	if (!inet_ntop(aip->family, aip->ipaddr, addr_out, sizeof(addr_out))) {
+		addr_out[0] = '?';
+		addr_out[1] = '\0';
+	}
+	printf("\t\t\t%s/%u\n", addr_out, aip->cidr_mask);
+}
+
+/* Only printing public key in this demo. For better key formatting,
+ * use the constant-time implementation as found in wireguard-tools.
+ */
+static void print_peer_header(const struct wireguard_wgpeer *peer)
+{
+	unsigned int i;
+	uint8_t *key = peer->public_key;
+	unsigned int len = peer->_len.public_key;
+
+	if (len != 32)
+		return;
+	printf("\tPeer ");
+	for (i = 0; i < len; i++)
+		printf("%02x", key[i]);
+	printf(":\n");
+}
+
+static void print_peer(const struct wireguard_wgpeer *peer)
+{
+	unsigned int i;
+
+	print_peer_header(peer);
+	printf("\t\tData: rx: %llu / tx: %llu bytes\n",
+	       peer->rx_bytes, peer->tx_bytes);
+	printf("\t\tAllowed IPs:\n");
+	for (i = 0; i < peer->_count.allowedips; i++)
+		print_allowed_ip(&peer->allowedips[i]);
+}
+
+static void build_request(struct wireguard_get_device_req *req, char *arg)
+{
+	char *endptr;
+	int ifindex;
+
+	ifindex = strtol(arg, &endptr, 0);
+	if (endptr != arg + strlen(arg) || errno != 0)
+		ifindex = 0;
+	if (ifindex > 0)
+		wireguard_get_device_req_set_ifindex(req, ifindex);
+	else
+		wireguard_get_device_req_set_ifname(req, arg);
+}
+
+int main(int argc, char **argv)
+{
+	struct wireguard_get_device_list *devs;
+	struct wireguard_get_device_req *req;
+	struct ynl_sock *ys;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <ifindex|ifname>\n", argv[0]);
+		return 1;
+	}
+
+	req = wireguard_get_device_req_alloc();
+	build_request(req, argv[1]);
+
+	ys = ynl_sock_create(&ynl_wireguard_family, NULL);
+	if (!ys)
+		return 2;
+
+	devs = wireguard_get_device_dump(ys, req);
+	if (!devs)
+		goto err_close;
+
+	ynl_dump_foreach(devs, d) {
+		unsigned int i;
+
+		printf("Interface %d: %s\n", d->ifindex, d->ifname);
+		for (i = 0; i < d->_count.peers; i++)
+			print_peer(&d->peers[i]);
+	}
+	wireguard_get_device_list_free(devs);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+	return 3;
+}
-- 
2.52.0


