Return-Path: <netdev+bounces-18589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CC757CBD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FD7281389
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40322D2FB;
	Tue, 18 Jul 2023 13:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C2154A5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB034C433D9;
	Tue, 18 Jul 2023 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685249;
	bh=WuS8tfuWkadsvD2O2V7rKFd8MWT1OV3T8mJ+98LYJNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOZE5JKHBMLH4xqPAmknZzizKFbAuar0MPatAbTbxfzMgM5F5T2bWDuqhBqimvbvz
	 lL8hhy704b+vsQ7ELuSTbnm0o+LG6XhaXxD2+jg3ZW5eKrVf8KmyHroHTD/A0WJi1T
	 IO9OZ5y5F6F8zaIlybvZh8jj/PSBfYkamLIW9WAM9UbsrwUOh2UVDvpvxgoeo3FiO2
	 PNREjtTL8co/91NVDg2fCgO9x/ldAFrNNClD995an4PNN8CKiRbviBGXGxB0yoMOdu
	 eg/X244yURv0/5iP21yB3b2VC8M1/IQLwA0dUHEC3KFSc5FY/P23Iwzf+7Zv44j0vw
	 +UtrZYwAMxGfw==
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
Subject: [RFC PATCH 17/21] crypto: cavium/zip - drop obsolete 'comp' implementation
Date: Tue, 18 Jul 2023 14:58:43 +0200
Message-Id: <20230718125847.3869700-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5435; i=ardb@kernel.org; h=from:subject; bh=WuS8tfuWkadsvD2O2V7rKFd8MWT1OV3T8mJ+98LYJNo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT1PjcQb7M0e4sxP2uX86f9CqYGqijYXnfN2/hx5Zb lTb9qino5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEz5+R4U3W3HV3XrUuW1jP e89tUQxfqvjH+U5PWp5/XLB8+ZnPE7sY/nDf+Zybn1Z3+YrA3H0LbsTY3ZHcZ/ntd+PM41/jvux jWMUJAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The 'comp' API is obsolete and will be removed, so remove this comp
implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/cavium/zip/zip_crypto.c | 40 ----------------
 drivers/crypto/cavium/zip/zip_crypto.h | 10 ----
 drivers/crypto/cavium/zip/zip_main.c   | 50 +-------------------
 3 files changed, 1 insertion(+), 99 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_crypto.c b/drivers/crypto/cavium/zip/zip_crypto.c
index 1046a746d36f551c..5edad3b1d1dc8398 100644
--- a/drivers/crypto/cavium/zip/zip_crypto.c
+++ b/drivers/crypto/cavium/zip/zip_crypto.c
@@ -195,46 +195,6 @@ static int zip_decompress(const u8 *src, unsigned int slen,
 	return ret;
 }
 
-/* Legacy Compress framework start */
-int zip_alloc_comp_ctx_deflate(struct crypto_tfm *tfm)
-{
-	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
-
-	return zip_ctx_init(zip_ctx, 0);
-}
-
-int zip_alloc_comp_ctx_lzs(struct crypto_tfm *tfm)
-{
-	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
-
-	return zip_ctx_init(zip_ctx, 1);
-}
-
-void zip_free_comp_ctx(struct crypto_tfm *tfm)
-{
-	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
-
-	zip_ctx_exit(zip_ctx);
-}
-
-int  zip_comp_compress(struct crypto_tfm *tfm,
-		       const u8 *src, unsigned int slen,
-		       u8 *dst, unsigned int *dlen)
-{
-	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
-
-	return zip_compress(src, slen, dst, dlen, zip_ctx);
-}
-
-int  zip_comp_decompress(struct crypto_tfm *tfm,
-			 const u8 *src, unsigned int slen,
-			 u8 *dst, unsigned int *dlen)
-{
-	struct zip_kernel_ctx *zip_ctx = crypto_tfm_ctx(tfm);
-
-	return zip_decompress(src, slen, dst, dlen, zip_ctx);
-} /* Legacy compress framework end */
-
 /* SCOMP framework start */
 void *zip_alloc_scomp_ctx_deflate(struct crypto_scomp *tfm)
 {
diff --git a/drivers/crypto/cavium/zip/zip_crypto.h b/drivers/crypto/cavium/zip/zip_crypto.h
index b59ddfcacd34447e..a1ae3825fb65c3b6 100644
--- a/drivers/crypto/cavium/zip/zip_crypto.h
+++ b/drivers/crypto/cavium/zip/zip_crypto.h
@@ -57,16 +57,6 @@ struct zip_kernel_ctx {
 	struct zip_operation zip_decomp;
 };
 
-int  zip_alloc_comp_ctx_deflate(struct crypto_tfm *tfm);
-int  zip_alloc_comp_ctx_lzs(struct crypto_tfm *tfm);
-void zip_free_comp_ctx(struct crypto_tfm *tfm);
-int  zip_comp_compress(struct crypto_tfm *tfm,
-		       const u8 *src, unsigned int slen,
-		       u8 *dst, unsigned int *dlen);
-int  zip_comp_decompress(struct crypto_tfm *tfm,
-			 const u8 *src, unsigned int slen,
-			 u8 *dst, unsigned int *dlen);
-
 void *zip_alloc_scomp_ctx_deflate(struct crypto_scomp *tfm);
 void *zip_alloc_scomp_ctx_lzs(struct crypto_scomp *tfm);
 void  zip_free_scomp_ctx(struct crypto_scomp *tfm, void *zip_ctx);
diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index dc5b7bf7e1fd9867..abd58de4343ddd8e 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -371,36 +371,6 @@ static struct pci_driver zip_driver = {
 
 /* Kernel Crypto Subsystem Interface */
 
-static struct crypto_alg zip_comp_deflate = {
-	.cra_name		= "deflate",
-	.cra_driver_name	= "deflate-cavium",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct zip_kernel_ctx),
-	.cra_priority           = 300,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= zip_alloc_comp_ctx_deflate,
-	.cra_exit		= zip_free_comp_ctx,
-	.cra_u			= { .compress = {
-		.coa_compress	= zip_comp_compress,
-		.coa_decompress	= zip_comp_decompress
-		 } }
-};
-
-static struct crypto_alg zip_comp_lzs = {
-	.cra_name		= "lzs",
-	.cra_driver_name	= "lzs-cavium",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct zip_kernel_ctx),
-	.cra_priority           = 300,
-	.cra_module		= THIS_MODULE,
-	.cra_init		= zip_alloc_comp_ctx_lzs,
-	.cra_exit		= zip_free_comp_ctx,
-	.cra_u			= { .compress = {
-		.coa_compress	= zip_comp_compress,
-		.coa_decompress	= zip_comp_decompress
-		 } }
-};
-
 static struct scomp_alg zip_scomp_deflate = {
 	.alloc_ctx		= zip_alloc_scomp_ctx_deflate,
 	.free_ctx		= zip_free_scomp_ctx,
@@ -431,22 +401,10 @@ static int zip_register_compression_device(void)
 {
 	int ret;
 
-	ret = crypto_register_alg(&zip_comp_deflate);
-	if (ret < 0) {
-		zip_err("Deflate algorithm registration failed\n");
-		return ret;
-	}
-
-	ret = crypto_register_alg(&zip_comp_lzs);
-	if (ret < 0) {
-		zip_err("LZS algorithm registration failed\n");
-		goto err_unregister_alg_deflate;
-	}
-
 	ret = crypto_register_scomp(&zip_scomp_deflate);
 	if (ret < 0) {
 		zip_err("Deflate scomp algorithm registration failed\n");
-		goto err_unregister_alg_lzs;
+		return ret;
 	}
 
 	ret = crypto_register_scomp(&zip_scomp_lzs);
@@ -459,18 +417,12 @@ static int zip_register_compression_device(void)
 
 err_unregister_scomp_deflate:
 	crypto_unregister_scomp(&zip_scomp_deflate);
-err_unregister_alg_lzs:
-	crypto_unregister_alg(&zip_comp_lzs);
-err_unregister_alg_deflate:
-	crypto_unregister_alg(&zip_comp_deflate);
 
 	return ret;
 }
 
 static void zip_unregister_compression_device(void)
 {
-	crypto_unregister_alg(&zip_comp_deflate);
-	crypto_unregister_alg(&zip_comp_lzs);
 	crypto_unregister_scomp(&zip_scomp_deflate);
 	crypto_unregister_scomp(&zip_scomp_lzs);
 }
-- 
2.39.2


