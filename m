Return-Path: <netdev+bounces-290790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAp/NBA/EGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:33:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619D5B30F4
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3431F3017EF7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E43E9C3A;
	Fri, 22 May 2026 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xstujc3T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D43E5EDA;
	Fri, 22 May 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449567; cv=none; b=J7lpTzXVaqLOwkPaywwdZ9ghbeOFWyVDqrV/oE4xMtv+jSZfi/wgfCKqnwtYdFhTdPOhhba56vG665pK4y9nvcPKlsonnb90ZE0Rpu73qZhjxYvNf5JQ8O7sAb5o0Z8Y86xLOUGGcH7kx2B/dhtbNVxXFDnpjS/PDoo4Mqffntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449567; c=relaxed/simple;
	bh=R1KMAI23+7i1Wc6O1oXgl53R9JvNI3FJ8hKBnXBkFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW8RzPOL9TLkYczXM+48GiHYUvlBqUD0LfxnQHott4OPzKjjWlKk1R4Gv5936BSPIKdaKwSKlTuL3rL97ZpE0IlzG/rMzrGtNyYUahGqTzIEgMK+VOKahJ6JO6wEmGlPgHOax6r4LtyidjROb5RbhMHXFat2/YJrg6WRz2Zq5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xstujc3T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74451F000E9;
	Fri, 22 May 2026 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449565;
	bh=FA0JT2MU1cjq+IOgE1QiCa+xKqbwI7TFJcp+fEW0hS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xstujc3TsCHLHgbRC/WvNwHYPcgN/PSk36AA87VL0Rsvsp4wx4sJ55AaVTr29sb4T
	 8KduXT1yFtgS2ysVH+wgWqYzPRPA/1wvpi+eXpMu6oxOPLLvoLJ+gFWEJHDdoK83YE
	 gO4/HHM/L2ZYYhBrPG4qkbEUUCcaUx77UKPKZ1aoY0cr/QvGNesNDS7lXDvUCyb5ah
	 v3SldAS8hyB8M/3IGNbbUtnmPiaBjDjkn5PZR+jMSbjxRQhEBkNBzs/wVMzAUzPxUI
	 a+U3zqpSFFUmv+4h6aXuJ9F9V/zIG9AVGsZ9B/O7yrgHnphGjAcxRKbtwkGh7zH51X
	 vjYHZ2vioPCkQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: drv-net: Add zcrx payload offset check
Date: Fri, 22 May 2026 13:32:22 +0200
Message-ID: <20260522113225.241337-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522113225.241337-1-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9619D5B30F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add an optional iou-zcrx receiver check for payload CQE offsets. With
-F, the receiver fails if no zero-copy receive CQE lands at or beyond
the requested offset within an rx_buf_len-sized buffer.

This is useful for manual driver testing where the driver is expected
to split a larger zcrx buffer into smaller hardware receive fragments.
Do not wire it into the generic large-chunk test, since different
drivers may legitimately return different CQE boundaries.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 240d13dbc54e..0fb0410aaada 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -85,6 +85,8 @@ static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
+static bool cfg_check_payload_offset, cfg_seen_payload_offset;
+static unsigned int cfg_min_payload_offset;
 
 static char *payload;
 static void *area_ptr;
@@ -298,6 +300,13 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
 	data = (char *)area_ptr + (rcqe->off & mask);
 
+	if (cfg_check_payload_offset) {
+		unsigned int rx_buf_len = cfg_rx_buf_len ?: page_size;
+
+		if ((rcqe->off & mask) % rx_buf_len >= cfg_min_payload_offset)
+			cfg_seen_payload_offset = true;
+	}
+
 	for (i = 0; i < n; i++) {
 		if (*(data + i) != payload[(received + i)])
 			error(1, 0, "payload mismatch at %d", i);
@@ -374,6 +383,9 @@ static void run_server(void)
 
 	if (!stop)
 		error(1, 0, "test failed\n");
+	if (cfg_check_payload_offset && !cfg_seen_payload_offset)
+		error(1, 0, "no payload CQE at offset >= %u\n",
+		      cfg_min_payload_offset);
 }
 
 static void run_client(void)
@@ -406,8 +418,11 @@ static void run_client(void)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id>", filepath);
+	error(1, 0,
+	      "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port>\n"
+	      "\t-l<payload_size> -i<ifname> -q<rxq_id>\n"
+	      "\t[-x<rx_buf_pages>] [-F<min_payload_offset>] [-d]\n",
+	      filepath);
 }
 
 static void parse_opts(int argc, char **argv)
@@ -425,7 +440,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:F:d")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -463,6 +478,10 @@ static void parse_opts(int argc, char **argv)
 		case 'x':
 			cfg_rx_buf_len = page_size * strtoul(optarg, NULL, 0);
 			break;
+		case 'F':
+			cfg_check_payload_offset = true;
+			cfg_min_payload_offset = strtoul(optarg, NULL, 0);
+			break;
 		case 'd':
 			cfg_dry_run = true;
 			break;
@@ -484,6 +503,9 @@ static void parse_opts(int argc, char **argv)
 
 	if (cfg_payload_len > max_payload_len)
 		error(1, 0, "-l: payload exceeds max (%d)", max_payload_len);
+	if (cfg_check_payload_offset &&
+	    cfg_min_payload_offset >= (cfg_rx_buf_len ?: page_size))
+		error(1, 0, "-F: offset outside rx_buf_len");
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


