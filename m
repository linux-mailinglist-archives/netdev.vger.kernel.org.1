Return-Path: <netdev+bounces-30774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476C789077
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC2828188F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426E19882;
	Fri, 25 Aug 2023 21:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AC174F7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:10 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A22691
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:09 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-p-JF0kiiMu6RP_rzKV4HXA-1; Fri, 25 Aug 2023 17:36:05 -0400
X-MC-Unique: p-JF0kiiMu6RP_rzKV4HXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8579B3C100A7;
	Fri, 25 Aug 2023 21:36:05 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E95B1678B;
	Fri, 25 Aug 2023 21:36:04 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 04/17] tls: move tls_cipher_size_desc to net/tls/tls.h
Date: Fri, 25 Aug 2023 23:35:09 +0200
Message-Id: <dd9fad80415e5b3575b41f56b331871038362eab.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It's only used in net/tls/*, no need to bloat include/net/tls.h.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h | 10 ----------
 net/tls/tls.h     | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 06fca9160346..a2b44578dcb7 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -51,16 +51,6 @@
=20
 struct tls_rec;
=20
-struct tls_cipher_size_desc {
-=09unsigned int iv;
-=09unsigned int key;
-=09unsigned int salt;
-=09unsigned int tag;
-=09unsigned int rec_seq;
-};
-
-extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
-
 /* Maximum data size carried in a TLS record */
 #define TLS_MAX_PAYLOAD_SIZE=09=09((size_t)1 << 14)
=20
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 164d6a955e26..7aae92972e00 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -51,6 +51,16 @@
 #define TLS_DEC_STATS(net, field)=09=09=09=09\
 =09SNMP_DEC_STATS((net)->mib.tls_statistics, field)
=20
+struct tls_cipher_size_desc {
+=09unsigned int iv;
+=09unsigned int key;
+=09unsigned int salt;
+=09unsigned int tag;
+=09unsigned int rec_seq;
+};
+
+extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
+
 /* TLS records are maintained in 'struct tls_rec'. It stores the memory pa=
ges
  * allocated or mapped for each TLS record. After encryption, the records =
are
  * stores in a linked list.
--=20
2.40.1


