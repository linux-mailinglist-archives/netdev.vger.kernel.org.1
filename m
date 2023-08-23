Return-Path: <netdev+bounces-29952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5016C785570
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077F0281305
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B779CF;
	Wed, 23 Aug 2023 10:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB69AD4F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:32:59 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84368CC;
	Wed, 23 Aug 2023 03:32:57 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qYl9u-006vE6-L2; Wed, 23 Aug 2023 18:32:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Aug 2023 18:32:19 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 23 Aug 2023 18:32:19 +0800
Subject: [PATCH 3/12] Bluetooth: Do not include crypto/algapi.h
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
Message-Id: <E1qYl9u-006vE6-L2@formenos.hmeau.com>
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

 net/bluetooth/smp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f1a9fc0012f0..5f2f97de295e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -22,11 +22,10 @@
 
 #include <linux/debugfs.h>
 #include <linux/scatterlist.h>
-#include <linux/crypto.h>
 #include <crypto/aes.h>
-#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <crypto/utils.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>

