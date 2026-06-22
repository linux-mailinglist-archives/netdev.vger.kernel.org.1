Return-Path: <netdev+bounces-301190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H+9QL42EOWrLugcAu9opvQ
	(envelope-from <netdev+bounces-301190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158A6B1E7E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="s/Fxb79f";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301190-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301190-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BF3A3008D76
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC2346E5E;
	Mon, 22 Jun 2026 18:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8C346E5D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:52:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154376; cv=none; b=YafBIzJtdI16qDoWd06CujlcMyMRcN2P0TTxDw1TQhEGlrwXKftYtRp0T/obaz1+uD1aA9mxY6X+G7cmJ0f3hZjxkZPhuLACV04qQ2Iu7SzSOif8df/3beMtvh19m+l+FhO6XVsUWdsnOx2Jk9XK0oUQK1myKDAdIm7Luoza4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154376; c=relaxed/simple;
	bh=yPa7NOHrj92YRaj3+nvIHEjTFD+2RQLrQIgmZdskk+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkkoSll35CJ3zsOli6ECYX/KFLDq3zb3q0iZpwbP4xGTaCo5q2HiRu0vhLaA9ejqSCwewbwBkV6aFZRbPvejh3DXyDZtf11U/ZH+kUr2hmqTx/C64SGaYvWoG0RJ+tRVGr+6lcRwLSV3yCTRLoGI8Schj9l95zle6OP5jWnOhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/Fxb79f; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-519fd49d101so3985941cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154374; x=1782759174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUYiga/rA61F6GfSKny16M3WpKqYKTvbN+XI5uTufgM=;
        b=s/Fxb79fTnZYmC9eS8m3jtkLABOv2sgZuJIL172nzMtGAzRiFnuEbc1wFzdsUlDNoy
         d5UEucEOHdFflB60tWMNpuFc4pJ6r2CL5YxYcBEMLzEvaJzDUtRrXjvLc+8P8teVvawd
         cOp95RhHgkGK+1TlWgfX2tD14ECs1blvQoW/N/2vMN+uS5j0ge4cv25Uf/+M7j0G57Yj
         Eitz7nMbafbys4GR+Dggd4LYzyUQZiYCWrlQn47tGeRrEQbFINjiNEWLQGdM30CSNmeU
         p8YAHWj5mWGtqls+Jo/o4Xd1aE4cXcIN/tLuDuiw9+Zn3qJ00L7hY16ft3dq3WGsabys
         IPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154374; x=1782759174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUYiga/rA61F6GfSKny16M3WpKqYKTvbN+XI5uTufgM=;
        b=dhgPzuCRN6TdBAQwhCGdE6rUL1CQ5w6/PuBHQaM7Z1krHIC4oSlODGsFxsoUxz23Lu
         yYTQskwazoc5S3iykDgNkqhfnB5GFHTLgNznqCD0WHsEqMJKECKQIqxGLbaChlAvZnoW
         IxMzl2hD3J8+Ril7mNxWwwsI5UoGjUHe3t94HSaIQ0K/BIdE5dOk8wkIkkEjfQKty9Mh
         nJ3U4tQfvDRgMNMWUkj6C3xMOZuznUWpGvCmmYWxgL8l1FCbs7ARIE0s4HapNJ8mbBHz
         2hKh6tWgtP5PlR06ikbDgnnzJCHSTILQotUFMErcNj6zxlvOsEfm1u8QJnAdPhLM+T+K
         7dYw==
X-Forwarded-Encrypted: i=1; AFNElJ/Jhc0NSy8MpOLLjWLCiCzgudhEkUe3rsGP26aiOvUUFfE6cZi6MfnWuDvALgSuLTZqeqz18LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWAGzPHHsotlchWglEXgeJKYDAt1lTza5vuCW3KYt8gOvBaG74
	PXdJLX9A+9cY8Tn2MJhnUbGsa+dmwjicKzSx+iijKMJX8eEsd9XpBP4k3jZyHpW+NELV2UlKU8D
	GRL6H67+2HBaMkg==
X-Received: from qtbdq1.prod.google.com ([2002:a05:622a:5201:b0:517:d786:16e1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e0b:0:b0:50b:3429:a10b with SMTP id d75a77b69052e-51a51aa74d9mr10172291cf.12.1782154373399;
 Mon, 22 Jun 2026 11:52:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:52:48 +0000
In-Reply-To: <20260622185248.1717846-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622185248.1717846-3-edumazet@google.com>
Subject: [PATCH net 2/2] selftests/net: Add TCP-AO key shadowing test
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301190-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:0x7f454c46@gmail.com,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6158A6B1E7E

Add a new selftest shadowing.c to tools/testing/selftests/net/tcp_ao
to verify that more specific keys are correctly preferred over less
specific ones (shadowing prevention), regardless of their insertion order.

The test configures a server with a specific host key, and a client with
both a specific host key and a wildcard subnet key, inserted in the
"wrong" order (wildcard last, which would shadow the specific one under
the bug). It then verifies that the client can still successfully
connect to the server, which only succeeds if the client correctly
selects the more specific key for the outbound connection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Assisted-by: Gemini:gemini-3.1-pro
---
 tools/testing/selftests/net/tcp_ao/Makefile   |  1 +
 .../testing/selftests/net/tcp_ao/shadowing.c  | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_ao/shadowing.c

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 5b0205c70c3983815315048c0ec1275525b7a29a..0c601d7049320be2310f9ff32988ae229584222e 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -2,6 +2,7 @@
 TEST_BOTH_AF := bench-lookups
 TEST_BOTH_AF += connect
 TEST_BOTH_AF += connect-deny
+TEST_BOTH_AF += shadowing
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += key-management
 TEST_BOTH_AF += restore
diff --git a/tools/testing/selftests/net/tcp_ao/shadowing.c b/tools/testing/selftests/net/tcp_ao/shadowing.c
new file mode 100644
index 0000000000000000000000000000000000000000..da14b13e032d5a0632f398b7eaa72b8045e61ffe
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/shadowing.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include "aolib.h"
+
+static void *server_fn(void *arg)
+{
+	int sk, lsk;
+	ssize_t bytes;
+
+	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
+
+	/* Server only has the specific key for the client.
+	 * It expects KeyID 100, signed with "pass_specific".
+	 */
+	if (test_add_key(lsk, "pass_specific", this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* 1: Server ready and key added */
+
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	synchronize_threads(); /* 2: Connection accepted */
+
+	/* Verify we can receive data from the client */
+	bytes = test_server_run(sk, 0, 0);
+	if (bytes < 0) {
+		test_fail("server: failed to receive data");
+	} else {
+		test_ok("server: connection authenticated successfully");
+	}
+
+	close(sk);
+	close(lsk);
+	return NULL;
+}
+
+static void *client_fn(void *arg)
+{
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	union tcp_addr wildcard_addr = {};
+
+	if (sk < 0)
+		test_error("socket()");
+
+	/* Client adds keys in the "wrong" order (wildcard last) to trigger shadowing.
+	 * 1. Specific key (Key B, ID 100)
+	 * 2. Wildcard key (Key A, ID 101)
+	 *
+	 * Without the fix, the wildcard key will be at the head of the list
+	 * and will shadow the specific key during outbound lookup, causing
+	 * the client to send a SYN with KeyID 101 (which the server doesn't have).
+	 */
+
+	/* 1. Add specific key */
+	if (test_add_key(sk, "pass_specific", this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY) specific");
+
+	/* 2. Add wildcard key (any address, prefix 0) */
+	if (test_add_key(sk, "pass_wildcard", wildcard_addr, 0, 101, 101))
+		test_error("setsockopt(TCP_AO_ADD_KEY) wildcard");
+
+	synchronize_threads(); /* 1: Client ready and keys added => connect() */
+
+	if (test_connect_socket(sk, this_ip_dest, test_server_port) <= 0) {
+		test_fail("client: failed to connect (shadowing bug present?)");
+		close(sk);
+		return NULL;
+	}
+
+	synchronize_threads(); /* 2: Connection established */
+
+	/* Send some data to verify the connection works */
+	if (test_client_verify(sk, 100, 20)) {
+		test_fail("client: verify failed");
+	} else {
+		test_ok("client: connection established and verified (precedence correct)");
+	}
+
+	close(sk);
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	/* We expect 2 test results: 1 from server, 1 from client */
+	test_init(2, server_fn, client_fn);
+	return 0;
+}
-- 
2.55.0.rc0.799.gd6f94ed593-goog


