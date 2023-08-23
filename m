Return-Path: <netdev+bounces-29951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D278556F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E409281303
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361E8F5F;
	Wed, 23 Aug 2023 10:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEA63C8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:32:57 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7EDB;
	Wed, 23 Aug 2023 03:32:55 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qYl9s-006vDm-IW; Wed, 23 Aug 2023 18:32:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Aug 2023 18:32:17 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 23 Aug 2023 18:32:17 +0800
Subject: [PATCH 2/12] ubifs: Do not include crypto/algapi.h
References: <ZOXf3JTIqhRLbn5j@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Theodore Y.Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	linux-nfs@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	linux-inte@web.codeaurora.org, grity@vger.kernel.org,
	Jason A.Donenfeld <Jason@zx2c4.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>
Message-Id: <E1qYl9s-006vDm-IW@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The header file crypto/algapi.h is for internal use only.  Use the
header file crypto/utils.h instead.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 fs/ubifs/auth.c   |    3 +--
 fs/ubifs/replay.c |    1 -
 fs/ubifs/ubifs.h  |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index e564d5ff8781..0d561ecb6869 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -9,10 +9,9 @@
  * This file implements various helper functions for UBIFS authentication support
  */
 
-#include <linux/crypto.h>
 #include <linux/verification.h>
 #include <crypto/hash.h>
-#include <crypto/algapi.h>
+#include <crypto/utils.h>
 #include <keys/user-type.h>
 #include <keys/asymmetric-type.h>
 
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 4211e4456b1e..c59d47fe7939 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -23,7 +23,6 @@
 #include "ubifs.h"
 #include <linux/list_sort.h>
 #include <crypto/hash.h>
-#include <crypto/algapi.h>
 
 /**
  * struct replay_entry - replay list entry.
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4c36044140e7..fd66ed0cd612 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -31,7 +31,7 @@
 #include <linux/completion.h>
 #include <crypto/hash_info.h>
 #include <crypto/hash.h>
-#include <crypto/algapi.h>
+#include <crypto/utils.h>
 
 #include <linux/fscrypt.h>
 

