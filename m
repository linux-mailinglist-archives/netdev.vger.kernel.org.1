Return-Path: <netdev+bounces-63548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D627C82DDD7
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F01F223D4
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851417C65;
	Mon, 15 Jan 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="j5XRASQO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcFJ8OGA"
X-Original-To: netdev@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F717BC5
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 94DF758093B;
	Mon, 15 Jan 2024 11:46:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Jan 2024 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705337175; x=
	1705340775; bh=ULTErvp/1WUWwBnw7lMLl+d5K9ZOcIhhxM8kJtbKd8Y=; b=j
	5XRASQOEN3g8p/cE9L5fUcBzyGGkF3tBkG8RAGOAXMLT9nA+Q6iYekrqLwUoxYPp
	4EEl1wrzHH4UkrdYs1elMglvKubU6JDogBRJIQYe0ztkmagRAb6YgVvJcj1UNmCk
	nV93axuQPX8ee8JPpG1qYCYApn6XWWvfPtbPWe7d93pNN763O6lXNeCbThAZMOQw
	xmqdep2GNjtBrZUr++Y39rma0QR7Jr3duvPodEib39cCHIb4qJa/sbqyLbM3d51X
	536cQG8A/YcLlS1pSiuJKczK8Hr+Hs5fzIBwvS2pqQYtgDAslh+S12gk8STdWs0d
	mz3xbfRXSH7ee+m+n753A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i14194934.fm3; t=
	1705337175; x=1705340775; bh=ULTErvp/1WUWwBnw7lMLl+d5K9ZOcIhhxM8
	kJtbKd8Y=; b=JcFJ8OGALFdyVC5sMLhAJqGMtwRrpEIgaorod9ZSTfXLFb5la0i
	DhI90Z7VE6HV1+uCP7EU7XSvZ0d65JllggDTP00NEdA3DOXRnvhDcBbWSyjKWgIj
	BR02QYf8ZKtKS9ZEecNLBNYBNOwc5FRiwTwDbxXq2sGpMIGbcpoynrtIi79U7Wqy
	haIVOwBIq/24EcUk6BVVTRPb/Kej4n4lebkdLGKzKrmx0EwJ2t4JBv2b/tSov/bj
	YynkQ6iA+ptH3Hi0VeQ8cbhL+uwZiuz2RYsPj70HtFhK0W5cLfmQ6aFoqtOFqhtk
	LxmNj5BdsendkAfAOaaUIn5glBMaILPx9/Q==
X-ME-Sender: <xms:V2GlZbTCyCVSA1DaUyz3fNdomKicR2wTm6qfX4q6qIl1hMKQD-ga_w>
    <xme:V2GlZcy6TlOM4wPS2MdZB08uE7s35GkhSOBbR5dFkb0NTguaBRMFDiEGa0uRP2XyH
    8f0A3ESFeRKIF4q0mQ>
X-ME-Received: <xmr:V2GlZQ0pyUc1TcJqIk91rXrFvR8ibQBm-Ly5iFxEgAz06gQ0eSWgfoimT00iPaQaNABM0j2aHpt4cX927LT0ZRptnJQgkX0P9u057dok3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepgfejvdehgfdtudfghffghefhffeileffheejfeeuteeffeeiffdvjeekgedt
    feffnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugdpnhhrpghmrghpshdrihhnfhhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvges
    nhgrtggthidruggv
X-ME-Proxy: <xmx:V2GlZbCUZ642dFjqwZPkFoid48Q2E-zCSmxQrwWeSc1rN8vyqnvITA>
    <xmx:V2GlZUgzNEBJ7tq7EpD__4yrlLK54RQ8VpXoCumicS-sQfhwLHA3sQ>
    <xmx:V2GlZfohk3PeePoG0q7q8RIPx3gMkY-FAAV-IS0YGDpMwlgpoIUqiw>
    <xmx:V2GlZdsM3FzBHrZgDOi3VPSmrwDlTHnZ0qzDQuV79vHpA6ty-zdY1A>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 11:46:14 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v5 2/3] ss: pretty-print BPF socket-local storage
Date: Mon, 15 Jan 2024 17:46:04 +0100
Message-ID: <20240115164605.377690-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115164605.377690-1-qde@naccy.de>
References: <20240115164605.377690-1-qde@naccy.de>
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

COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
be printed anymore; it's used as a "virtual" column to refer to the
socket-local storage dump, which will be printed under the socket information.
The column's width is fixed to 1, so it doesn't mess up ss' output.

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 misc/ss.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index e97dd4b8..9348db8b 100644
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
@@ -136,7 +138,7 @@ static struct column columns[] = {
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
+	{ ALIGN_LEFT,	"",			"",	1, 0, 0 },
 	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
 };
 
@@ -1041,11 +1043,10 @@ static int buf_update(int len)
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
 
@@ -1056,18 +1057,27 @@ static void out(const char *fmt, ...)
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
@@ -1215,6 +1225,9 @@ static void render_calc_width(void)
 		 */
 		c->width = min(c->width, screen_width);
 
+		if (c == &columns[COL_SKSTOR])
+			c->width = 1;
+
 		if (c->width)
 			first = 0;
 	}
@@ -3396,6 +3409,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3406,10 +3422,36 @@ static void bpf_map_opts_mixed_error(void)
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
 
@@ -3445,8 +3487,25 @@ static int bpf_map_opts_load_info(unsigned int map_id)
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
@@ -3498,8 +3557,11 @@ static void bpf_map_opts_destroy(void)
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
@@ -3550,10 +3612,49 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
 	return stgs_rta;
 }
 
+#define SK_STORAGE_INDENT_STR "    "
+
+static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
+{
+	uint32_t type_id;
+	struct bpf_sk_storage_map_info *map_info;
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.indent_str = SK_STORAGE_INDENT_STR,
+		.indent_level = 2,
+		.emit_zeroes = 1
+	};
+	int r;
+
+	map_info = bpf_map_opts_get_info(map_id);
+	if (!map_info) {
+		/* The kernel might return a map we can't get info for, skip
+		 * it but print the other ones. */
+		out(SK_STORAGE_INDENT_STR "map_id: %d failed to fetch info, skipping\n",
+		    map_id);
+		return;
+	}
+
+	if (map_info->info.value_size != len) {
+		fprintf(stderr, "map_id: %d: invalid value size, expecting %u, got %lu\n",
+			map_id, map_info->info.value_size, len);
+		return;
+	}
+
+	type_id = map_info->info.btf_value_type_id;
+
+	out(SK_STORAGE_INDENT_STR "map_id: %d [\n", map_id);
+	r = btf_dump__dump_type_data(map_info->dump, type_id, data, len, &opts);
+	if (r < 0)
+		out(SK_STORAGE_INDENT_STR SK_STORAGE_INDENT_STR "failed to dump data: %d", r);
+	out("\n" SK_STORAGE_INDENT_STR "]");
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
@@ -3565,8 +3666,13 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 			(struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out("map_id:%u ",
-				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			out("\n");
+
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+				RTA_PAYLOAD(value));
 		}
 	}
 }
@@ -5994,6 +6100,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (oneline && bpf_map_opts_is_enabled()) {
+		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
+		exit(-1);
+	}
+
 	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
 		user_ent_hash_build();
 
-- 
2.43.0


