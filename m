Return-Path: <netdev+bounces-18586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A7757CB9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB802815CD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A8D2EF;
	Tue, 18 Jul 2023 13:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFB134B1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE9C433D9;
	Tue, 18 Jul 2023 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685234;
	bh=LMbtrrL41VdEZgul85mdHBoLsIRux4jBa3a/x61Ycxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT+7oEuP4bPgj+UiAqrCeUG8s2JirqYarClLaYQ/v7t474QklYXyL0XeFjZeHBVdh
	 gv6D22UjPMjlm71YbZ/F30zxtNnROq9jkGmaU6AnNvB2MtBuIPcvxAraaZNd0iDh0B
	 IMs+GSjziPHc22fbdXvDp3XCm0G+Lnmz9NSwGiWDdh+mPtQmwyjVrzILqas8OPkNnT
	 gWzoDk9n4OHoV1ckft0Jl7jge4Y/jOjIALGlr5nfTnwDwLWGcpc0OM7unB6x/JmeDq
	 qMI9+93zX3UyQsoHYBpXuJ6Jahesute96sx0/ZWb5cr42+NaO3NjuNrMS4ULnd2uuh
	 T9dfxF8HRZITw==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Haren Myneni <haren@us.ibm.com>,
	Nick Terrell <terrelln@fb.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Richard Weinberger <richard@nod.at>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	qat-linux@intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 14/21] crypto: lzo-rle - drop obsolete 'comp' implementation
Date: Tue, 18 Jul 2023 14:58:40 +0200
Message-Id: <20230718125847.3869700-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=ardb@kernel.org; h=from:subject; bh=LMbtrrL41VdEZgul85mdHBoLsIRux4jBa3a/x61Ycxo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT92iOmFL6eW+FVzXLW0ihXLXO0i9eJVdGxorWFrc+ eDR0dsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJnXzP8U5K5NrOp8HTz3nm9 vE+Wqa1J2lLH4G911il0qi/fkmslLYwMe1lrDvNXerk8WPLgpeMdRTOuz4Gm+2dp7xJ/J76NUaC FGQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The 'comp' API is obsolete and will be removed, so remove this comp
implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/lzo-rle.c | 60 +-------------------
 1 file changed, 1 insertion(+), 59 deletions(-)

diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
index 0631d975bfac1129..658d6aa46fe21e19 100644
--- a/crypto/lzo-rle.c
+++ b/crypto/lzo-rle.c
@@ -26,29 +26,11 @@ static void *lzorle_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int lzorle_init(struct crypto_tfm *tfm)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->lzorle_comp_mem = lzorle_alloc_ctx(NULL);
-	if (IS_ERR(ctx->lzorle_comp_mem))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void lzorle_free_ctx(struct crypto_scomp *tfm, void *ctx)
 {
 	kvfree(ctx);
 }
 
-static void lzorle_exit(struct crypto_tfm *tfm)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	lzorle_free_ctx(NULL, ctx->lzorle_comp_mem);
-}
-
 static int __lzorle_compress(const u8 *src, unsigned int slen,
 			  u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -64,14 +46,6 @@ static int __lzorle_compress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzorle_compress(struct crypto_tfm *tfm, const u8 *src,
-			unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __lzorle_compress(src, slen, dst, dlen, ctx->lzorle_comp_mem);
-}
-
 static int lzorle_scompress(struct crypto_scomp *tfm, const u8 *src,
 			 unsigned int slen, u8 *dst, unsigned int *dlen,
 			 void *ctx)
@@ -94,12 +68,6 @@ static int __lzorle_decompress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzorle_decompress(struct crypto_tfm *tfm, const u8 *src,
-			  unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	return __lzorle_decompress(src, slen, dst, dlen);
-}
-
 static int lzorle_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 			   unsigned int slen, u8 *dst, unsigned int *dlen,
 			   void *ctx)
@@ -107,19 +75,6 @@ static int lzorle_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lzorle_decompress(src, slen, dst, dlen);
 }
 
-static struct crypto_alg alg = {
-	.cra_name		= "lzo-rle",
-	.cra_driver_name	= "lzo-rle-generic",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct lzorle_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= lzorle_init,
-	.cra_exit		= lzorle_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= lzorle_compress,
-	.coa_decompress		= lzorle_decompress } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= lzorle_alloc_ctx,
 	.free_ctx		= lzorle_free_ctx,
@@ -134,24 +89,11 @@ static struct scomp_alg scomp = {
 
 static int __init lzorle_mod_init(void)
 {
-	int ret;
-
-	ret = crypto_register_alg(&alg);
-	if (ret)
-		return ret;
-
-	ret = crypto_register_scomp(&scomp);
-	if (ret) {
-		crypto_unregister_alg(&alg);
-		return ret;
-	}
-
-	return ret;
+	return crypto_register_scomp(&scomp);
 }
 
 static void __exit lzorle_mod_fini(void)
 {
-	crypto_unregister_alg(&alg);
 	crypto_unregister_scomp(&scomp);
 }
 
-- 
2.39.2


