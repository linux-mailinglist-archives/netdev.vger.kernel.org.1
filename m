Return-Path: <netdev+bounces-278513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEBaGCxg3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03C3FC0A3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 622B73025F6D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF13EC2EC;
	Tue, 14 Apr 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bS1ed1fS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123223E959D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181197; cv=none; b=Ym4gn9bgljHKKFNU8nioCEq684Lb5kn+/L+WejWChGQE3b8aASjN17b94G7viNTMwS88BRT/f7tftd5SJqeRFhdRGFHkR7X9rzjTTaiSEE7hK4J/FUsbVF4Tu2wxyylGdHVkZqgz9INaHRdXi4+VmAHBmKpgU8KVhqDU/GXHnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181197; c=relaxed/simple;
	bh=3sya0StqmpCFy7q0tsbDs+eQLpDDAZlpJAl7Ma4VLKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN9oBe2fEKHQ3JsDbhjyGOktyLM4VlVScshGyMNWNn4MksYTQLB7yIz8m18WPXA9zjpkydSY+QeRqshSN8hLRsFTMbzImg1X2DgninZyNWg4H3ZOYCxqVPNtrMEYovUZTGjNHUo8/eTzeXeT4YZlrngMhJTzgXHeh74ZtIhWcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bS1ed1fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37630C2BCB3;
	Tue, 14 Apr 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bS1ed1fS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776181195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNSDq4T09x3KMdCHmjwgUx8Rdc+rlOQcv2r8jOH0zaU=;
	b=bS1ed1fSwU4qP4jPnvbJ27J2vqSizhhFDBTdBYCSau+N9hlpWlFWdVccNwp4grFYXYpD22
	EgEjxTRcSDUoavRe8Q5oVG3jFM2CA9Fcz+J2EontyMPwNc1613KvhHG5Yzt+jHmv0yzkE6
	XMn6Pju76YFk3UH3utmkE+q6PqprIFI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8b79d30b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 15:39:55 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 2/4] tools: ynl: add sample for wireguard
Date: Tue, 14 Apr 2026 17:39:42 +0200
Message-ID: <20260414153944.2742252-3-Jason@zx2c4.com>
In-Reply-To: <20260414153944.2742252-1-Jason@zx2c4.com>
References: <20260414153944.2742252-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278513-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fiberby.net:email,zx2c4.com:email,zx2c4.com:dkim,zx2c4.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A03C3FC0A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Add a sample application for WireGuard, using the generated C library.

The main benefit of this is to exercise the generated library,
which might be useful for future self-tests.

Example:
  $ make -C tools/net/ynl/lib
  $ make -C tools/net/ynl/generated
  $ make -C tools/net/ynl/tests wireguard
  $ ./tools/net/ynl/tests/wireguard
  usage: ./tools/net/ynl/tests/wireguard <ifindex|ifname>
  $ sudo ./tools/net/ynl/tests/wireguard wg-test
  Interface 3: wg-test
      Peer 6adfb183a4a2c94a2f92dab5ade762a4788[...]:
          Data: rx: 42 / tx: 42 bytes
          Allowed IPs:
              0.0.0.0/0
              ::/0

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/net/ynl/tests/.gitignore  |   1 +
 tools/net/ynl/tests/wireguard.c | 106 ++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/net/ynl/tests/wireguard.c

diff --git a/tools/net/ynl/tests/.gitignore b/tools/net/ynl/tests/.gitignore
index 045385df42a45..a7832ebfdbbc3 100644
--- a/tools/net/ynl/tests/.gitignore
+++ b/tools/net/ynl/tests/.gitignore
@@ -7,3 +7,4 @@ rt-link
 rt-route
 tc
 tc-filter-add
+wireguard
diff --git a/tools/net/ynl/tests/wireguard.c b/tools/net/ynl/tests/wireguard.c
new file mode 100644
index 0000000000000..df601e742c287
--- /dev/null
+++ b/tools/net/ynl/tests/wireguard.c
@@ -0,0 +1,106 @@
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
+	unsigned int len = peer->_len.public_key;
+	uint8_t *key = peer->public_key;
+	unsigned int i;
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
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <ifindex|ifname>\n", argv[0]);
+		return 1;
+	}
+
+	ys = ynl_sock_create(&ynl_wireguard_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 2;
+	}
+
+	req = wireguard_get_device_req_alloc();
+	build_request(req, argv[1]);
+
+	devs = wireguard_get_device_dump(ys, req);
+	if (!devs) {
+		fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
+		wireguard_get_device_req_free(req);
+		ynl_sock_destroy(ys);
+		return 3;
+	}
+
+	ynl_dump_foreach(devs, d) {
+		unsigned int i;
+
+		printf("Interface %d: %s\n", d->ifindex, d->ifname);
+		for (i = 0; i < d->_count.peers; i++)
+			print_peer(&d->peers[i]);
+	}
+
+	wireguard_get_device_list_free(devs);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+
+	return 0;
+}
-- 
2.53.0


