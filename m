Return-Path: <netdev+bounces-174868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4FA610EF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849287AF0D7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6F1FECBA;
	Fri, 14 Mar 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="hnPiE8W6"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D62200126;
	Fri, 14 Mar 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954985; cv=none; b=IhVgu9NQnRUEPwknbI0Sbu3Xl9h1gQktuoDyAm5r1dGkI2ewTm0yRGdvI8A/q9z+CWXcKxpJaBMd4HwlxfuS7LmGjc2tXImj5PAJB+pS8NYFwr+/TzNHs2Ja4g/hpjWj8AnEJbYdXxZeIhy9qu7aK+jCtHsHvIw7XpcSrAiDj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954985; c=relaxed/simple;
	bh=zMQ6DWz0g0KAvGYI4DW8GcUzfPgojjs6uodWTqFq2AE=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=si7bM6SWvCijM4Hb08z8W9EI3esbWtHSx851utUnkfffrh3W+n9vxx3dohzAbFyOOW0Ws0F3hRf3ZxvhM8zmASy3Gbpi/HFusSlAJvTY8A8C89NAbrMrd7PK8NvJ0pFLqC5m7RJqSqq7csq0BLXq9+qDG8sWkDBAqhcWt8PsQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=hnPiE8W6; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0Jo7R6apMb4O1fxPw9F7Z1rogwbXAzuvQtabTiWE71s=; b=hnPiE8W6Tes//8pNJZaYjIu4vp
	y2SK8JW/ZXJ/TREDuRRT9Qd3HxEVPNiJLAg5b2MHDtUUb93K31AMstn8MawkXq8pEgig5kpWLmvxy
	qrDgJMVVzHDsdvbn89sdajCTS6muhopMMzFQyAFZQHvYAaNoSSSXurVwWntM43Gx14TvNa7rcO+q6
	Q57JMNxceIl84AFbP4uScMWOClsEK4Z66u5Mpusa0WNoa35GOrnd4qoVYuluL4YWrfcIvlmlvvlJL
	nUEFsbkOw0Bli//I9omJMAzuPM6Wz5/SsKNYrkTZVfH0HmIjqRaHT5t6YtFfAx0075fYA5cYv9JWQ
	+IFjs98g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43o-006Zns-2Q;
	Fri, 14 Mar 2025 20:22:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:44 +0800
Date: Fri, 14 Mar 2025 20:22:44 +0800
Message-Id: <46d2b6d1f06dc00e89f6c527d69c0bed60dca8a1.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1741954523.git.herbert@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 09/13] crypto: acomp - Add support for folios
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

For many users, it's easier to supply a folio rather than an SG
list since they already have them.  Add support for folios to the
acomp interface.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/acompress.c                  | 40 +++++++++++--
 crypto/scompress.c                  | 68 ++++++++++++++--------
 include/crypto/acompress.h          | 89 +++++++++++++++++++++++++++--
 include/crypto/internal/acompress.h | 18 ++++++
 4 files changed, 182 insertions(+), 33 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index d54abc27330f..6ef335f5bf27 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/page-flags.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -189,18 +190,25 @@ static void acomp_reqchain_virt(struct acomp_req_chain *state, int err)
 	req->base.err = err;
 	state = &req->chain;
 
-	if (state->src)
+	if (state->flags & CRYPTO_ACOMP_REQ_SRC_VIRT)
 		acomp_request_set_src_dma(req, state->src, slen);
-	if (state->dst)
+	else if (state->flags & CRYPTO_ACOMP_REQ_SRC_FOLIO)
+		acomp_request_set_src_folio(req, state->sfolio, state->soff, slen);
+	if (state->flags & CRYPTO_ACOMP_REQ_DST_VIRT)
 		acomp_request_set_dst_dma(req, state->dst, dlen);
-	state->src = NULL;
-	state->dst = NULL;
+	else if (state->flags & CRYPTO_ACOMP_REQ_DST_FOLIO)
+		acomp_request_set_dst_folio(req, state->dfolio, state->doff, dlen);
 }
 
 static void acomp_virt_to_sg(struct acomp_req *req)
 {
 	struct acomp_req_chain *state = &req->chain;
 
+	state->flags = req->base.flags & (CRYPTO_ACOMP_REQ_SRC_VIRT |
+					  CRYPTO_ACOMP_REQ_DST_VIRT |
+					  CRYPTO_ACOMP_REQ_SRC_FOLIO |
+					  CRYPTO_ACOMP_REQ_DST_FOLIO);
+
 	if (acomp_request_src_isvirt(req)) {
 		unsigned int slen = req->slen;
 		const u8 *svirt = req->svirt;
@@ -208,6 +216,17 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 		state->src = svirt;
 		sg_init_one(&state->ssg, svirt, slen);
 		acomp_request_set_src_sg(req, &state->ssg, slen);
+	} else if (acomp_request_src_isfolio(req)) {
+		struct folio *folio = req->sfolio;
+		unsigned int slen = req->slen;
+		size_t off = req->soff;
+
+		state->sfolio = folio;
+		state->soff = off;
+		sg_init_table(&state->ssg, 1);
+		sg_set_page(&state->ssg, folio_page(folio, off / PAGE_SIZE),
+			    slen, off % PAGE_SIZE);
+		acomp_request_set_src_sg(req, &state->ssg, slen);
 	}
 
 	if (acomp_request_dst_isvirt(req)) {
@@ -217,6 +236,17 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 		state->dst = dvirt;
 		sg_init_one(&state->dsg, dvirt, dlen);
 		acomp_request_set_dst_sg(req, &state->dsg, dlen);
+	} else if (acomp_request_dst_isfolio(req)) {
+		struct folio *folio = req->dfolio;
+		unsigned int dlen = req->dlen;
+		size_t off = req->doff;
+
+		state->dfolio = folio;
+		state->doff = off;
+		sg_init_table(&state->dsg, 1);
+		sg_set_page(&state->dsg, folio_page(folio, off / PAGE_SIZE),
+			    dlen, off % PAGE_SIZE);
+		acomp_request_set_src_sg(req, &state->dsg, dlen);
 	}
 }
 
@@ -328,7 +358,7 @@ static int acomp_do_req_chain(struct acomp_req *req,
 	int err;
 
 	if (crypto_acomp_req_chain(tfm) ||
-	    (!acomp_request_chained(req) && !acomp_request_isvirt(req)))
+	    (!acomp_request_chained(req) && acomp_request_issg(req)))
 		return op(req);
 
 	if (acomp_is_async(tfm)) {
diff --git a/crypto/scompress.c b/crypto/scompress.c
index ba9b22ba53fe..dc239ea8a46c 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -177,9 +177,10 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	unsigned int slen = req->slen;
 	unsigned int dlen = req->dlen;
 	struct page *spage, *dpage;
-	unsigned int soff, doff;
 	unsigned int n;
 	const u8 *src;
+	size_t soff;
+	size_t doff;
 	u8 *dst;
 	int ret;
 
@@ -192,38 +193,57 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	if (acomp_request_src_isvirt(req))
 		src = req->svirt;
 	else {
-		soff = req->src->offset;
-		spage = nth_page(sg_page(req->src), soff / PAGE_SIZE);
-		soff = offset_in_page(soff);
+		src = scratch->src;
+		do {
+			if (acomp_request_src_isfolio(req)) {
+				spage = folio_page(req->sfolio, 0);
+				soff = req->soff;
+			} else if (slen <= req->src->length) {
+				spage = sg_page(req->src);
+				soff = req->src->offset;
+			} else
+				break;
 
-		n = slen / PAGE_SIZE;
-		n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
-		if (slen <= req->src->length &&
-		    (!PageHighMem(nth_page(spage, n)) ||
-		     size_add(soff, slen) <= PAGE_SIZE))
+			spage = nth_page(spage, soff / PAGE_SIZE);
+			soff = offset_in_page(soff);
+
+			n = slen / PAGE_SIZE;
+			n += (offset_in_page(slen) + soff - 1) / PAGE_SIZE;
+			if (PageHighMem(nth_page(spage, n)) &&
+			    size_add(soff, slen) <= PAGE_SIZE)
+				break;
 			src = kmap_local_page(spage) + soff;
-		else
-			src = scratch->src;
+		} while (0);
 	}
 
 	if (acomp_request_dst_isvirt(req))
 		dst = req->dvirt;
 	else {
-		doff = req->dst->offset;
-		dpage = nth_page(sg_page(req->dst), doff / PAGE_SIZE);
-		doff = offset_in_page(doff);
+		unsigned int max = SCOMP_SCRATCH_SIZE;
 
-		n = dlen / PAGE_SIZE;
-		n += (offset_in_page(dlen) + doff - 1) / PAGE_SIZE;
-		if (dlen <= req->dst->length &&
-		    (!PageHighMem(nth_page(dpage, n)) ||
-		     size_add(doff, dlen) <= PAGE_SIZE))
+		dst = scratch->dst;
+		do {
+			if (acomp_request_dst_isfolio(req)) {
+				dpage = folio_page(req->dfolio, 0);
+				doff = req->doff;
+			} else if (dlen <= req->dst->length) {
+				dpage = sg_page(req->dst);
+				doff = req->dst->offset;
+			} else
+				break;
+
+			dpage = nth_page(dpage, doff / PAGE_SIZE);
+			doff = offset_in_page(doff);
+
+			n = dlen / PAGE_SIZE;
+			n += (offset_in_page(dlen) + doff - 1) / PAGE_SIZE;
+			if (PageHighMem(dpage + n) &&
+			    size_add(doff, dlen) <= PAGE_SIZE)
+				break;
 			dst = kmap_local_page(dpage) + doff;
-		else {
-			if (dlen > SCOMP_SCRATCH_SIZE)
-				dlen = SCOMP_SCRATCH_SIZE;
-			dst = scratch->dst;
-		}
+			max = dlen;
+		} while (0);
+		dlen = min(dlen, max);
 	}
 
 	spin_lock_bh(&scratch->lock);
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 03cb381c2c54..c497c73baf13 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -32,6 +32,12 @@
 /* Set this bit for if virtual address destination cannot be used for DMA. */
 #define CRYPTO_ACOMP_REQ_DST_NONDMA	0x00000010
 
+/* Set this bit if source is a folio. */
+#define CRYPTO_ACOMP_REQ_SRC_FOLIO	0x00000020
+
+/* Set this bit if destination is a folio. */
+#define CRYPTO_ACOMP_REQ_DST_FOLIO	0x00000040
+
 #define CRYPTO_ACOMP_DST_MAX		131072
 
 #define	MAX_SYNC_COMP_REQSIZE		0
@@ -43,6 +49,7 @@
                 __##name##_req, (tfm), (gfp), false)
 
 struct acomp_req;
+struct folio;
 
 struct acomp_req_chain {
 	struct list_head head;
@@ -53,16 +60,31 @@ struct acomp_req_chain {
 	void *data;
 	struct scatterlist ssg;
 	struct scatterlist dsg;
-	const u8 *src;
-	u8 *dst;
+	union {
+		const u8 *src;
+		struct folio *sfolio;
+	};
+	union {
+		u8 *dst;
+		struct folio *dfolio;
+	};
+	size_t soff;
+	size_t doff;
+	u32 flags;
 };
 
 /**
  * struct acomp_req - asynchronous (de)compression request
  *
  * @base:	Common attributes for asynchronous crypto requests
- * @src:	Source Data
- * @dst:	Destination data
+ * @src:	Source scatterlist
+ * @dst:	Destination scatterlist
+ * @svirt:	Source virtual address
+ * @dvirt:	Destination virtual address
+ * @sfolio:	Source folio
+ * @soff:	Source folio offset
+ * @dfolio:	Destination folio
+ * @doff:	Destination folio offset
  * @slen:	Size of the input buffer
  * @dlen:	Size of the output buffer and number of bytes produced
  * @chain:	Private API code data, do not use
@@ -73,11 +95,15 @@ struct acomp_req {
 	union {
 		struct scatterlist *src;
 		const u8 *svirt;
+		struct folio *sfolio;
 	};
 	union {
 		struct scatterlist *dst;
 		u8 *dvirt;
+		struct folio *dfolio;
 	};
+	size_t soff;
+	size_t doff;
 	unsigned int slen;
 	unsigned int dlen;
 
@@ -316,6 +342,7 @@ static inline void acomp_request_set_callback(struct acomp_req *req,
 {
 	u32 keep = CRYPTO_ACOMP_REQ_SRC_VIRT | CRYPTO_ACOMP_REQ_SRC_NONDMA |
 		   CRYPTO_ACOMP_REQ_DST_VIRT | CRYPTO_ACOMP_REQ_DST_NONDMA |
+		   CRYPTO_ACOMP_REQ_SRC_FOLIO | CRYPTO_ACOMP_REQ_DST_FOLIO |
 		   CRYPTO_TFM_REQ_ON_STACK;
 
 	req->base.complete = cmpl;
@@ -352,6 +379,8 @@ static inline void acomp_request_set_params(struct acomp_req *req,
 
 	req->base.flags &= ~(CRYPTO_ACOMP_REQ_SRC_VIRT |
 			     CRYPTO_ACOMP_REQ_SRC_NONDMA |
+			     CRYPTO_ACOMP_REQ_SRC_FOLIO |
+			     CRYPTO_ACOMP_REQ_DST_FOLIO |
 			     CRYPTO_ACOMP_REQ_DST_VIRT |
 			     CRYPTO_ACOMP_REQ_DST_NONDMA);
 }
@@ -374,6 +403,7 @@ static inline void acomp_request_set_src_sg(struct acomp_req *req,
 
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_NONDMA;
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_VIRT;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_FOLIO;
 }
 
 /**
@@ -393,6 +423,7 @@ static inline void acomp_request_set_src_dma(struct acomp_req *req,
 	req->slen = slen;
 
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_NONDMA;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_FOLIO;
 	req->base.flags |= CRYPTO_ACOMP_REQ_SRC_VIRT;
 }
 
@@ -413,10 +444,34 @@ static inline void acomp_request_set_src_nondma(struct acomp_req *req,
 	req->svirt = src;
 	req->slen = slen;
 
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_FOLIO;
 	req->base.flags |= CRYPTO_ACOMP_REQ_SRC_NONDMA;
 	req->base.flags |= CRYPTO_ACOMP_REQ_SRC_VIRT;
 }
 
+/**
+ * acomp_request_set_src_folio() -- Sets source folio
+ *
+ * Sets source folio required by an acomp operation.
+ *
+ * @req:	asynchronous compress request
+ * @folio:	pointer to input folio
+ * @off:	input folio offset
+ * @len:	size of the input buffer
+ */
+static inline void acomp_request_set_src_folio(struct acomp_req *req,
+					       struct folio *folio, size_t off,
+					       unsigned int len)
+{
+	req->sfolio = folio;
+	req->soff = off;
+	req->slen = len;
+
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_NONDMA;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_SRC_VIRT;
+	req->base.flags |= CRYPTO_ACOMP_REQ_SRC_FOLIO;
+}
+
 /**
  * acomp_request_set_dst_sg() -- Sets destination scatterlist
  *
@@ -435,6 +490,7 @@ static inline void acomp_request_set_dst_sg(struct acomp_req *req,
 
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_NONDMA;
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_VIRT;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_FOLIO;
 }
 
 /**
@@ -454,6 +510,7 @@ static inline void acomp_request_set_dst_dma(struct acomp_req *req,
 	req->dlen = dlen;
 
 	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_NONDMA;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_FOLIO;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_VIRT;
 }
 
@@ -473,10 +530,34 @@ static inline void acomp_request_set_dst_nondma(struct acomp_req *req,
 	req->dvirt = dst;
 	req->dlen = dlen;
 
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_FOLIO;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_NONDMA;
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_VIRT;
 }
 
+/**
+ * acomp_request_set_dst_folio() -- Sets destination folio
+ *
+ * Sets destination folio required by an acomp operation.
+ *
+ * @req:	asynchronous compress request
+ * @folio:	pointer to input folio
+ * @off:	input folio offset
+ * @len:	size of the input buffer
+ */
+static inline void acomp_request_set_dst_folio(struct acomp_req *req,
+					       struct folio *folio, size_t off,
+					       unsigned int len)
+{
+	req->dfolio = folio;
+	req->doff = off;
+	req->dlen = len;
+
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_NONDMA;
+	req->base.flags &= ~CRYPTO_ACOMP_REQ_DST_VIRT;
+	req->base.flags |= CRYPTO_ACOMP_REQ_DST_FOLIO;
+}
+
 static inline void acomp_request_chain(struct acomp_req *req,
 				       struct acomp_req *head)
 {
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index c1ed55a0e3bf..aaf59f3236fa 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -103,6 +103,14 @@ static inline bool acomp_request_chained(struct acomp_req *req)
 	return crypto_request_chained(&req->base);
 }
 
+static inline bool acomp_request_issg(struct acomp_req *req)
+{
+	return !(req->base.flags & (CRYPTO_ACOMP_REQ_SRC_VIRT |
+				    CRYPTO_ACOMP_REQ_DST_VIRT |
+				    CRYPTO_ACOMP_REQ_SRC_FOLIO |
+				    CRYPTO_ACOMP_REQ_DST_FOLIO));
+}
+
 static inline bool acomp_request_src_isvirt(struct acomp_req *req)
 {
 	return req->base.flags & CRYPTO_ACOMP_REQ_SRC_VIRT;
@@ -135,6 +143,16 @@ static inline bool acomp_request_isnondma(struct acomp_req *req)
 				  CRYPTO_ACOMP_REQ_DST_NONDMA);
 }
 
+static inline bool acomp_request_src_isfolio(struct acomp_req *req)
+{
+	return req->base.flags & CRYPTO_ACOMP_REQ_SRC_FOLIO;
+}
+
+static inline bool acomp_request_dst_isfolio(struct acomp_req *req)
+{
+	return req->base.flags & CRYPTO_ACOMP_REQ_DST_FOLIO;
+}
+
 static inline bool crypto_acomp_req_chain(struct crypto_acomp *tfm)
 {
 	return crypto_tfm_req_chain(&tfm->base);
-- 
2.39.5


