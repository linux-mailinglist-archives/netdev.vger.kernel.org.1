Return-Path: <netdev+bounces-39312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E27BEBF3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3478A1C20C68
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB3D3AD;
	Mon,  9 Oct 2023 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774283E47D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:22 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF763A3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-ng88COzfNSW0GwOjyYvlkg-1; Mon, 09 Oct 2023 16:51:03 -0400
X-MC-Unique: ng88COzfNSW0GwOjyYvlkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7C73185A78E;
	Mon,  9 Oct 2023 20:51:02 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E62AB36E1;
	Mon,  9 Oct 2023 20:51:01 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 04/14] tls: rename MAX_IV_SIZE to TLS_MAX_IV_SIZE
Date: Mon,  9 Oct 2023 22:50:44 +0200
Message-ID: <a5edcf9531b5c61b58cd4ab8cf685a9bb7693cb5.1696596130.git.sd@queasysnail.net>
In-Reply-To: <cover.1696596130.git.sd@queasysnail.net>
References: <cover.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It's defined in include/net/tls.h, avoid using an overly generic name.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h             | 2 +-
 net/tls/tls.h                 | 2 +-
 net/tls/tls_device_fallback.c | 2 +-
 net/tls/tls_main.c            | 2 +-
 net/tls/tls_sw.c              | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index f3f22b08af26..5200ce27db91 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -61,7 +61,7 @@ struct tls_rec;
=20
 #define TLS_AAD_SPACE_SIZE=09=0913
=20
-#define MAX_IV_SIZE=09=09=0916
+#define TLS_MAX_IV_SIZE=09=09=0916
 #define TLS_TAG_SIZE=09=09=0916
 #define TLS_MAX_REC_SEQ_SIZE=09=098
 #define TLS_MAX_AAD_SIZE=09=09TLS_AAD_SPACE_SIZE
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 28a8c0e80e3c..16830aa2d6ec 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -127,7 +127,7 @@ struct tls_rec {
 =09struct sock *sk;
=20
 =09char aad_space[TLS_AAD_SPACE_SIZE];
-=09u8 iv_data[MAX_IV_SIZE];
+=09u8 iv_data[TLS_MAX_IV_SIZE];
 =09struct aead_request aead_req;
 =09u8 aead_req_ctx[];
 };
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 1d2b4d83ccab..4e7228f275fa 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -54,7 +54,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 =09=09=09  struct scatter_walk *out, int *in_len,
 =09=09=09  struct tls_prot_info *prot)
 {
-=09unsigned char buf[TLS_HEADER_SIZE + MAX_IV_SIZE];
+=09unsigned char buf[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
 =09const struct tls_cipher_desc *cipher_desc;
 =09struct scatterlist sg_in[3];
 =09struct scatterlist sg_out[3];
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f705d812fc36..58f13660fe6b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -59,7 +59,7 @@ enum {
 };
=20
 #define CHECK_CIPHER_DESC(cipher,ci)=09=09=09=09\
-=09static_assert(cipher ## _IV_SIZE <=3D MAX_IV_SIZE);=09=09\
+=09static_assert(cipher ## _IV_SIZE <=3D TLS_MAX_IV_SIZE);=09=09\
 =09static_assert(cipher ## _REC_SEQ_SIZE <=3D TLS_MAX_REC_SEQ_SIZE);=09\
 =09static_assert(cipher ## _TAG_SIZE =3D=3D TLS_TAG_SIZE);=09=09\
 =09static_assert(sizeof_field(struct ci, iv) =3D=3D cipher ## _IV_SIZE);=
=09\
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 93d40c9a6823..5b6175f9b9a6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -60,7 +60,7 @@ struct tls_decrypt_arg {
=20
 struct tls_decrypt_ctx {
 =09struct sock *sk;
-=09u8 iv[MAX_IV_SIZE];
+=09u8 iv[TLS_MAX_IV_SIZE];
 =09u8 aad[TLS_MAX_AAD_SIZE];
 =09u8 tail;
 =09struct scatterlist sg[];
@@ -2319,7 +2319,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struc=
t sk_buff *skb)
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(strp->sk);
 =09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
-=09char header[TLS_HEADER_SIZE + MAX_IV_SIZE];
+=09char header[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
 =09size_t cipher_overhead;
 =09size_t data_len =3D 0;
 =09int ret;
@@ -2669,7 +2669,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09}
=20
 =09/* Sanity-check the sizes for stack allocations. */
-=09if (nonce_size > MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE) {
+=09if (nonce_size > TLS_MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE) =
{
 =09=09rc =3D -EINVAL;
 =09=09goto free_priv;
 =09}
--=20
2.42.0


