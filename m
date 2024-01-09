Return-Path: <netdev+bounces-62700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B7828A0D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97469284541
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2863A8C1;
	Tue,  9 Jan 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKfDS9vY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5D3A29A
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704817978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5oAZb+1c3FRbIFd6A88AMUQU4YHn1rEpXFXdQSnJBU=;
	b=GKfDS9vYz4hPGUWlgtz32HMX7u+VnfWAt71wGAHlCaNWJlZ0fOz5n/gvnOfq+NVDuftCRU
	h5B+rCSbwtO8fonxxYCEYY2SDw45oo0RxWQG9Dpc314zkv/0JrWz7V1RFI+sjjYweHOZ8y
	IRQqHcg3oqTVhSWXxQ6M4HVlBiyWRGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-cqEKcF7PM_Orpd2Fvpt15g-1; Tue, 09 Jan 2024 11:32:56 -0500
X-MC-Unique: cqEKcF7PM_Orpd2Fvpt15g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB4388350E6;
	Tue,  9 Jan 2024 16:32:55 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 985381C060AF;
	Tue,  9 Jan 2024 16:32:53 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jon Maloy <jmaloy@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 2/2] treewide: fix typos in various comments
Date: Tue,  9 Jan 2024 17:32:35 +0100
Message-ID: <f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
In-Reply-To: <cover.1704816744.git.aclaudi@redhat.com>
References: <cover.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Fix various typos and spelling errors in some iproute2 comments.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 devlink/devlink.c         | 2 +-
 include/bpf_api.h         | 2 +-
 include/libiptc/libiptc.h | 2 +-
 include/xt-internal.h     | 2 +-
 lib/json_print.c          | 2 +-
 rdma/rdma.h               | 2 +-
 tc/em_canid.c             | 2 +-
 tc/m_gact.c               | 2 +-
 tc/q_htb.c                | 3 ++-
 tc/q_netem.c              | 2 +-
 10 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3baad355..8c2e3395 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2326,7 +2326,7 @@ static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
 	return err;
 }
 
-/* List of extented handles with two slashes. */
+/* List of extended handles with two slashes. */
 static const uint64_t dl_opt_extended_handle[] = {
 	DL_OPT_HANDLEP,
 	DL_OPT_HANDLE_REGION,
diff --git a/include/bpf_api.h b/include/bpf_api.h
index 5887d3a8..287f96b6 100644
--- a/include/bpf_api.h
+++ b/include/bpf_api.h
@@ -253,7 +253,7 @@ static int BPF_FUNC(skb_set_tunnel_opt, struct __sk_buff *skb,
 # define memmove(d, s, n)	__builtin_memmove((d), (s), (n))
 #endif
 
-/* FIXME: __builtin_memcmp() is not yet fully useable unless llvm bug
+/* FIXME: __builtin_memcmp() is not yet fully usable unless llvm bug
  * https://llvm.org/bugs/show_bug.cgi?id=26218 gets resolved. Also
  * this one would generate a reloc entry (non-map), otherwise.
  */
diff --git a/include/libiptc/libiptc.h b/include/libiptc/libiptc.h
index 1bfe4e18..89dce2f9 100644
--- a/include/libiptc/libiptc.h
+++ b/include/libiptc/libiptc.h
@@ -80,7 +80,7 @@ int iptc_append_entry(const xt_chainlabel chain,
 		      const struct ipt_entry *e,
 		      struct xtc_handle *handle);
 
-/* Check whether a mathching rule exists */
+/* Check whether a matching rule exists */
 int iptc_check_entry(const xt_chainlabel chain,
 		      const struct ipt_entry *origfw,
 		      unsigned char *matchmask,
diff --git a/include/xt-internal.h b/include/xt-internal.h
index 89c73e4f..07216140 100644
--- a/include/xt-internal.h
+++ b/include/xt-internal.h
@@ -6,7 +6,7 @@
 #	define XT_LIB_DIR "/lib/xtables"
 #endif
 
-/* protocol family dependent informations */
+/* protocol family dependent information */
 struct afinfo {
 	/* protocol family */
 	int family;
diff --git a/lib/json_print.c b/lib/json_print.c
index 7b3b6c3f..810d496e 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -217,7 +217,7 @@ int print_color_bool(enum output_type type,
 
 /* In JSON mode, acts like print_color_bool.
  * Otherwise, will print key with prefix of "no" if false.
- * The show flag is used to suppres printing in non-JSON mode
+ * The show flag is used to suppress printing in non-JSON mode
  */
 int print_color_bool_opt(enum output_type type,
 			 enum color_attr color,
diff --git a/rdma/rdma.h b/rdma/rdma.h
index 1f8f8326..df1852db 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -40,7 +40,7 @@ struct filter_entry {
 	char *key;
 	char *value;
 	/*
-	 * This field means that we can try to issue .doit calback
+	 * This field means that we can try to issue .doit callback
 	 * on value above. This value can be converted to integer
 	 * with simple atoi(). Otherwise "is_doit" will be false.
 	 */
diff --git a/tc/em_canid.c b/tc/em_canid.c
index 6d06b66a..22854752 100644
--- a/tc/em_canid.c
+++ b/tc/em_canid.c
@@ -26,7 +26,7 @@
 #include <inttypes.h>
 #include "m_ematch.h"
 
-#define EM_CANID_RULES_MAX 400 /* Main reason for this number is Nelink
+#define EM_CANID_RULES_MAX 400 /* Main reason for this number is Netlink
 	message size limit equal to Single memory page size. When dump()
 	is invoked, there are even some ematch related headers sent from
 	kernel to userspace together with em_canid configuration --
diff --git a/tc/m_gact.c b/tc/m_gact.c
index e294a701..225ffce4 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -18,7 +18,7 @@
 #include "tc_util.h"
 #include <linux/tc_act/tc_gact.h>
 
-/* define to turn on probablity stuff */
+/* define to turn on probability stuff */
 
 #ifdef CONFIG_GACT_PROB
 static const char *prob_n2a(int p)
diff --git a/tc/q_htb.c b/tc/q_htb.c
index 63b9521b..351ef693 100644
--- a/tc/q_htb.c
+++ b/tc/q_htb.c
@@ -224,7 +224,8 @@ static int htb_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
 	opt.ceil.rate = (ceil64 >= (1ULL << 32)) ? ~0U : ceil64;
 
 	/* compute minimal allowed burst from rate; mtu is added here to make
-	   sute that buffer is larger than mtu and to have some safeguard space */
+	   sure that buffer is larger than mtu and to have some safeguard space
+	 */
 	if (!buffer)
 		buffer = rate64 / get_hz() + mtu;
 	if (!cbuffer)
diff --git a/tc/q_netem.c b/tc/q_netem.c
index 5d5aad80..4ce9ab6e 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -117,7 +117,7 @@ static void print_corr(bool present, __u32 value)
 }
 
 /*
- * Simplistic file parser for distrbution data.
+ * Simplistic file parser for distribution data.
  * Format is:
  *	# comment line(s)
  *	data0 data1 ...
-- 
2.43.0


