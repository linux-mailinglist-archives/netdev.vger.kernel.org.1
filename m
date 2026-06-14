Return-Path: <netdev+bounces-299123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A9aBBeEGLmqHogQAu9opvQ
	(envelope-from <netdev+bounces-299123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA848680315
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CHVZ2fM8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299123-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B221C300827E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726542F3C0E;
	Sun, 14 Jun 2026 01:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDE2DC792;
	Sun, 14 Jun 2026 01:41:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401276; cv=none; b=SGyGSsOCI8tgHetLdghd0ym6ZyYm6ku5fUm8KKcGnIZX+pjRmcAfIkCH8WfkyThzp+nH4RgQyIa12nlDo3WOQoHpfWi9kDXtiZsfSM6HV9OMfAuE+JCZ8TQ2zXo+6hgyflq/SItg/jRyivYehFc+JX6KoOs0qt4bMBENjTYpmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401276; c=relaxed/simple;
	bh=Dfq4rqHWCwT3nPKj71n9zKUiELt4N2MN2Kq2IUB8e/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGJKMgIvuR7M7iGseclx8+KHkg4tPLPJ8LR6Tnrf4q0ECOZX2K107qy7EvtNw/14FPfBTfxRfMlBL7nqeFxm9IokfCBJAxd8dSrPSVxnG6OkDSiDp8b5tWdh9mlzxGIpzTX4eG+7ff/99ffpooAGup1a1Y2iC22DWhQ2yonXsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHVZ2fM8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226521F00A3A;
	Sun, 14 Jun 2026 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401273;
	bh=/6EDfIZXeHHODbKy06fZZgFvI36Mh7h4earTSixEw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHVZ2fM8ybyBfBu13yBRlI+LagVafzzz0P7wwFG/8lCtXi0QNyEGHF6jDnOtUk6dJ
	 SS1xD6oA0bZ82sF+bgLnEq6kdn5wZIodvc9eaNm0QBY+EHuBpm8h9xRHOlhpCP8zrL
	 iUUzwqhD/NoOCTqxdP0ot+NlRK9hoXIG4vfh+EhBDcStQpkUr2JWmrIOlVdLQMqRd3
	 RNlP1PbNP8ZCPFrM0fT/mCAi6/B6A1pp5bCWPrG+57LFFpD8197aRYAry4BqL+QAdE
	 Y+VAPtpLcLKn3GUsEnyF3ebzAO+sou7sabIm3TyTvKrQ2qzzB31kxs6rJJWuyWgihP
	 8dWxLl6pQOomw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] selftests/bpf: drop the unused kTLS program from test_sockmap
Date: Sat, 13 Jun 2026 18:40:59 -0700
Message-ID: <20260614014102.461064-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
References: <20260614014102.461064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299123-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA848680315

With the sockmap + kTLS tests gone, the BPF-side support in test_sockmap
is dead: the tls_sock_map map and bpf_prog3 (which redirected skbs into
it) are no longer referenced. Remove them, along with the now-unused
bpf_write_pass() helper.

bpf_prog3 was progs[2], so renumber the progs[] users in test_sockmap.c:
the sockops program drops to progs[2] and the sk_msg tx programs to
progs[3..7]. Shrink the map/prog arrays from 9 to 8 and drop the
tls_sock_map entry (the last one) from map_names[] to match.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/bpf/progs/test_sockmap_kern.h   | 56 -------------------
 tools/testing/selftests/bpf/test_sockmap.c    | 23 ++++----
 2 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index f48f85f1bd70..284a2f2e50cf 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -85,13 +85,6 @@ struct {
 	__type(value, int);
 } sock_skb_opts SEC(".maps");
 
-struct {
-	__uint(type, TEST_MAP_TYPE);
-	__uint(max_entries, 20);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
-} tls_sock_map SEC(".maps");
-
 SEC("sk_skb/stream_parser")
 int bpf_prog1(struct __sk_buff *skb)
 {
@@ -135,55 +128,6 @@ int bpf_prog2(struct __sk_buff *skb)
 
 }
 
-static inline void bpf_write_pass(struct __sk_buff *skb, int offset)
-{
-	int err = bpf_skb_pull_data(skb, 6 + offset);
-	void *data_end;
-	char *c;
-
-	if (err)
-		return;
-
-	c = (char *)(long)skb->data;
-	data_end = (void *)(long)skb->data_end;
-
-	if (c + 5 + offset < data_end)
-		memcpy(c + offset, "PASS", 4);
-}
-
-SEC("sk_skb/stream_verdict")
-int bpf_prog3(struct __sk_buff *skb)
-{
-	int err, *f, ret = SK_PASS;
-	const int one = 1;
-
-	f = bpf_map_lookup_elem(&sock_skb_opts, &one);
-	if (f && *f) {
-		__u64 flags = 0;
-
-		ret = 0;
-		flags = *f;
-
-		err = bpf_skb_adjust_room(skb, -13, 0, 0);
-		if (err)
-			return SK_DROP;
-		err = bpf_skb_adjust_room(skb, 4, 0, 0);
-		if (err)
-			return SK_DROP;
-		bpf_write_pass(skb, 0);
-#ifdef SOCKMAP
-		return bpf_sk_redirect_map(skb, &tls_sock_map, ret, flags);
-#else
-		return bpf_sk_redirect_hash(skb, &tls_sock_map, &ret, flags);
-#endif
-	}
-	err = bpf_skb_adjust_room(skb, 4, 0, 0);
-	if (err)
-		return SK_DROP;
-	bpf_write_pass(skb, 13);
-	return ret;
-}
-
 SEC("sockops")
 int bpf_sockmap(struct bpf_sock_ops *skops)
 {
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 32d6068df4b3..ac814eb63edb 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -55,10 +55,10 @@ int s1, s2, c1, c2, p1, p2;
 int test_cnt;
 int passed;
 int failed;
-int map_fd[9];
-struct bpf_map *maps[9];
-struct bpf_program *progs[9];
-struct bpf_link *links[9];
+int map_fd[8];
+struct bpf_map *maps[8];
+struct bpf_program *progs[8];
+struct bpf_link *links[8];
 
 int txmsg_pass;
 int txmsg_redir;
@@ -967,7 +967,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	}
 
 	/* Attach to cgroups */
-	err = bpf_prog_attach(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS, 0);
+	err = bpf_prog_attach(bpf_program__fd(progs[2]), cg_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (err) {
 		fprintf(stderr, "ERROR: bpf_prog_attach (groups): %d (%s)\n",
 			err, strerror(errno));
@@ -983,15 +983,15 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 
 	/* Attach txmsg program to sockmap */
 	if (txmsg_pass)
-		tx_prog = progs[4];
+		tx_prog = progs[3];
 	else if (txmsg_redir)
-		tx_prog = progs[5];
+		tx_prog = progs[4];
 	else if (txmsg_apply)
-		tx_prog = progs[6];
+		tx_prog = progs[5];
 	else if (txmsg_cork)
-		tx_prog = progs[7];
+		tx_prog = progs[6];
 	else if (txmsg_drop)
-		tx_prog = progs[8];
+		tx_prog = progs[7];
 	else
 		tx_prog = NULL;
 
@@ -1218,7 +1218,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		fprintf(stderr, "unknown test\n");
 out:
 	/* Detach and zero all the maps */
-	bpf_prog_detach2(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS);
+	bpf_prog_detach2(bpf_program__fd(progs[2]), cg_fd, BPF_CGROUP_SOCK_OPS);
 
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		if (links[i])
@@ -1724,7 +1724,6 @@ char *map_names[] = {
 	"sock_bytes",
 	"sock_redir_flags",
 	"sock_skb_opts",
-	"tls_sock_map",
 };
 
 static int populate_progs(char *bpf_file)
-- 
2.54.0


