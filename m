Return-Path: <netdev+bounces-30775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80C789079
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E261C20FA6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCA19885;
	Fri, 25 Aug 2023 21:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622619BBC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:13 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924912691
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:12 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408--HE5B7YkPR-Z4R2XhNERnA-1; Fri, 25 Aug 2023 17:36:08 -0400
X-MC-Unique: -HE5B7YkPR-Z4R2XhNERnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241BA858EED;
	Fri, 25 Aug 2023 21:36:08 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 552371678B;
	Fri, 25 Aug 2023 21:36:07 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 05/17] tls: add TLS_CIPHER_ARIA_GCM_* to tls_cipher_size_desc
Date: Fri, 25 Aug 2023 23:35:10 +0200
Message-Id: <b2e0fb79e6d0a4478be9bf33781dc9c9281c9d56.1692977948.git.sd@queasysnail.net>
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

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f550c84f3408..9843c2af994f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -73,6 +73,8 @@ const struct tls_cipher_size_desc tls_cipher_size_desc[] =
=3D {
 =09CIPHER_SIZE_DESC(TLS_CIPHER_CHACHA20_POLY1305),
 =09CIPHER_SIZE_DESC(TLS_CIPHER_SM4_GCM),
 =09CIPHER_SIZE_DESC(TLS_CIPHER_SM4_CCM),
+=09CIPHER_SIZE_DESC(TLS_CIPHER_ARIA_GCM_128),
+=09CIPHER_SIZE_DESC(TLS_CIPHER_ARIA_GCM_256),
 };
=20
 static const struct proto *saved_tcpv6_prot;
--=20
2.40.1


