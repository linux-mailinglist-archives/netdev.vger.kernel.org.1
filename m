Return-Path: <netdev+bounces-71779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057078550D4
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEA1F2202A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928512838B;
	Wed, 14 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="AnEltXfB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPZTZRrK"
X-Original-To: netdev@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD5128389
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933134; cv=none; b=VFEzimPeFbgwbYBTjZJrvuDUu7xxBzaUnGTewfi/6qL4AzrVyXhcxipN3Go7GW5r6kZYkHVq8YZX+FDiWHen7OX0XoGIr6Ut1JXQZ9XBKa+vWJMqUkN3WdxFlbWkZ4JiTTPhbvTDkRLv07QTL7rJr+YLPKDpFIJb9xKJhuhbaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933134; c=relaxed/simple;
	bh=mZuwkJ2wDg80E6GY17ot/xWJ7dFRe+gBEhXuIy9YJY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deI+1IlsgTsxsXY3UvAg8KC81CktbxyILHfUVEWOlhzl5nbbNSWyz6VzsXcEeIRbRJ9T2SfxjlhkXX+JwEhqAmpm3gzJ8xUHnHO/PRwS98ROar3Kmiy3Qcn/6m7IettcU3Fn6c1Fy6V74RmskuVEsG4CS8NJNpOzRN28F7XefxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=AnEltXfB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPZTZRrK; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 36F622CC02BE;
	Wed, 14 Feb 2024 12:52:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 12:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707933130; x=
	1707936730; bh=QgtfVZmFkLYS41UETD0tGPlHMHd6Jkd9kAWcVtdywJs=; b=A
	nEltXfBcdmFc6l/Bl8nOBpZI+XB5NBtSEl6Bp4uchOpPUFzdSo8qVJzXBipIvhAQ
	tYK7SPlZffPzNhcYBuKYwMtbCtjhoAF6gqlFI2AOVS7DTOQEE4k+OeEzKZL/jZh1
	TW+2ZRdwd8wlUcFnj3xHJtStCWzhoJG4LmjKBPsSlK0SmMMEJlJiG3Q2ZQqr/Uyy
	teFwSHlbEaZrAJwYM5zdoccPkeRTlEx2vtHJiEtGXjngUor+q7n50gXKoBKjvarv
	O/dJvswDp9H1AQO7Wvt1Jvl61Yb6lssblUmF5L/v+no0zPjng7mH5aJTl1kTGDY4
	3I863VUgh2V1EkhxwaJmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707933130; x=
	1707936730; bh=QgtfVZmFkLYS41UETD0tGPlHMHd6Jkd9kAWcVtdywJs=; b=L
	PZTZRrKP+zQJ6kszdGkUPxyFQK6K1Q5yaAwk5mXMddNc55+isQ/GuMiKvz8xXYlr
	zffVrOVWfUU5sgonDgAsAYdLnjamWpYme5T6hpSZZeqd9tODOzh+spXbp2o5yNyn
	+2rDBr4IwD+wGMjfWXO8RIPdVwIyk0Riw7733F7Spu2186s7KEDNWs/6g/mOqod5
	HXtCrBdEKer/QFja5CbY7QLjbFwUi611GzMaanpB6QgbGLjNLGquIiElnmc4gYKZ
	RNjC9BGCq1uiR8kpsqQTy8SRtSlWM47pQfyEw9k2z3AVZ4SB8cCwizLpEh5mekfx
	StKBKcSuQPFK1lztJt7CA==
X-ME-Sender: <xms:yv3MZSZHgmeMiFss3wv0MpEMPutfT8abEuJL2Xg8bDhmULBMX3B0Dg>
    <xme:yv3MZVaLYvGNwz9KCXnMj56AjX8QVRSXo2d5h8VIEn6kS_BSXpU3rTLeRq5cCbdaf
    vE2luXXDL-CZrklIyc>
X-ME-Received: <xmr:yv3MZc_vzE6pB5CqF3yBXO0fV8j6HGNR3vUs3cSs2P3sjCx0uXMalguhwek2WUZrVBeEV2Z5OzvgHlwzQ_ZhSghOg4j9jzjSmkmtyTk_gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepgfejvdehgfdtudfghffghefhffeileffheejfeeuteeffeeiffdvjeekgedt
    feffnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugdpnhhrpghmrghpshdrihhnfhhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvges
    nhgrtggthidruggv
X-ME-Proxy: <xmx:yv3MZUqBbYZinRB98-d0e4VwulcvUyMxKMRTGgPCjjkdFV8Szuc9ig>
    <xmx:yv3MZdpMRDdo7NOhfJH2ZQA4kyoLOKhHsk6vFUVvm-pXk5EupVCL2A>
    <xmx:yv3MZSQx_0qsrFComlWXYRnF_pV7GQ04HxoW1T0JBoKhLaNQVQjTzA>
    <xmx:yv3MZefBR3WDZP_2L10xbxMWBEMMs06-mVjU0XOSg5nGFW44z0jpVktbhDfH3-Yw>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 12:52:09 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v8 2/3] ss: pretty-print BPF socket-local storage
Date: Wed, 14 Feb 2024 09:42:34 +0100
Message-ID: <20240214084235.25618-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214084235.25618-1-qde@naccy.de>
References: <20240214084235.25618-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ss is able to print the map ID(s) for which a given socket has BPF
socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
the actual content of the map remains hidden.

This change aims to pretty-print the socket-local storage content following
the socket details, similar to what `bpftool map dump` would do. The exact
output format is inspired by drgn, while the BTF data processing is similar
to bpftool's.

ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
of binary data. This requires out_bpf_sk_storage_print_fn() as a print
callback function used by btf_dump__dump_type_data(). vout() is also
introduced, which is similar to out() but accepts a va_list as
parameter.

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 misc/ss.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 137 insertions(+), 11 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 7f47b489..73be95a5 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -53,7 +53,9 @@
 
 #ifdef HAVE_LIBBPF
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <linux/btf.h>
 #endif
 
 #if HAVE_RPC
@@ -1039,11 +1041,10 @@ static int buf_update(int len)
 }
 
 /* Append content to buffer as part of the current field */
-__attribute__((format(printf, 1, 2)))
-static void out(const char *fmt, ...)
+static void vout(const char *fmt, va_list args)
 {
 	struct column *f = current_field;
-	va_list args;
+	va_list _args;
 	char *pos;
 	int len;
 
@@ -1054,18 +1055,27 @@ static void out(const char *fmt, ...)
 		buffer.head = buf_chunk_new();
 
 again:	/* Append to buffer: if we have a new chunk, print again */
+	va_copy(_args, args);
 
 	pos = buffer.cur->data + buffer.cur->len;
-	va_start(args, fmt);
 
 	/* Limit to tail room. If we hit the limit, buf_update() will tell us */
-	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, args);
-	va_end(args);
+	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
 
 	if (buf_update(len))
 		goto again;
 }
 
+__attribute__((format(printf, 1, 2)))
+static void out(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vout(fmt, args);
+	va_end(args);
+}
+
 static int print_left_spacing(struct column *f, int stored, int printed)
 {
 	int s;
@@ -3396,6 +3406,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3406,10 +3419,36 @@ static void bpf_map_opts_mixed_error(void)
 		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
 }
 
+static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
+{
+	if (info->btf_value_type_id) {
+		*btf = btf__load_from_kernel_by_id(info->btf_id);
+		if (!*btf) {
+			fprintf(stderr, "ss: failed to load BTF for map ID %u\n",
+				info->id);
+			return -1;
+		}
+	} else {
+		*btf = NULL;
+	}
+
+	return 0;
+}
+
+static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
+{
+	vout(fmt, args);
+}
+
 static int bpf_map_opts_load_info(unsigned int map_id)
 {
+	struct btf_dump_opts dopts = {
+		.sz = sizeof(struct btf_dump_opts)
+	};
 	struct bpf_map_info info = {};
 	uint32_t len = sizeof(info);
+	struct btf_dump *dump;
+	struct btf *btf;
 	int fd;
 	int r;
 
@@ -3446,8 +3485,25 @@ static int bpf_map_opts_load_info(unsigned int map_id)
 		return -1;
 	}
 
+	r = bpf_maps_opts_load_btf(&info, &btf);
+	if (r) {
+		close(fd);
+		return -1;
+	}
+
+	dump = btf_dump__new(btf, out_bpf_sk_storage_print_fn, NULL, &dopts);
+	if (!dump) {
+		btf__free(btf);
+		close(fd);
+		fprintf(stderr, "Failed to create btf_dump object\n");
+		return -1;
+	}
+
 	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
-	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].btf = btf;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].dump = dump;
 
 	return 0;
 }
@@ -3499,8 +3555,11 @@ static void bpf_map_opts_destroy(void)
 {
 	int i;
 
-	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
+		btf_dump__free(bpf_map_opts.maps[i].dump);
+		btf__free(bpf_map_opts.maps[i].btf);
 		close(bpf_map_opts.maps[i].fd);
+	}
 }
 
 static struct rtattr *bpf_map_opts_alloc_rta(void)
@@ -3553,10 +3612,74 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
 	return stgs_rta;
 }
 
+static void out_bpf_sk_storage_oneline(struct bpf_sk_storage_map_info *info,
+	const void *data, size_t len)
+{
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.emit_zeroes = 1,
+		.compact = 1
+	};
+	int r;
+
+	out(" map_id:%d", info->id);
+	r = btf_dump__dump_type_data(info->dump, info->info.btf_value_type_id,
+				     data, len, &opts);
+	if (r < 0)
+		out("failed to dump data: %d", r);
+}
+
+static void out_bpf_sk_storage_multiline(struct bpf_sk_storage_map_info *info,
+	const void *data, size_t len)
+{
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.indent_level = 2,
+		.emit_zeroes = 1
+	};
+	int r;
+
+	out("\n\tmap_id:%d [\n", info->id);
+
+	r = btf_dump__dump_type_data(info->dump, info->info.btf_value_type_id,
+				     data, len, &opts);
+	if (r < 0)
+		out("\t\tfailed to dump data: %d", r);
+
+	out("\n\t]");
+}
+
+static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
+{
+	struct bpf_sk_storage_map_info *map_info;
+
+	map_info = bpf_map_opts_get_info(map_id);
+	if (!map_info) {
+		/* The kernel might return a map we can't get info for, skip
+		 * it but print the other ones.
+		 */
+		out("\n\tmap_id: %d failed to fetch info, skipping\n", map_id);
+		return;
+	}
+
+	if (map_info->info.value_size != len) {
+		fprintf(stderr,
+			"map_id: %d: invalid value size, expecting %u, got %lu\n",
+			map_id, map_info->info.value_size, len);
+		return;
+	}
+
+	if (oneline)
+		out_bpf_sk_storage_oneline(map_info, data, len);
+	else
+		out_bpf_sk_storage_multiline(map_info, data, len);
+}
+
 static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 {
 	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
-	unsigned int rem;
+	unsigned int rem, map_id;
+	struct rtattr *value;
 
 	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
 		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
@@ -3568,8 +3691,11 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 				    (struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out(" map_id:%u",
-			    rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+					   RTA_PAYLOAD(value));
 		}
 	}
 }
-- 
2.43.0


