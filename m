Return-Path: <netdev+bounces-29960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF4785583
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321611C20381
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1CABE7A;
	Wed, 23 Aug 2023 10:33:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95FBE50
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:33:16 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8BE54;
	Wed, 23 Aug 2023 03:33:14 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qYlAB-006vJI-Cv; Wed, 23 Aug 2023 18:32:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Aug 2023 18:32:36 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 23 Aug 2023 18:32:36 +0800
Subject: [PATCH 11/12] wireguard: Do not include crypto/algapi.h
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
Message-Id: <E1qYlAB-006vJI-Cv@formenos.hmeau.com>
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

 drivers/net/wireguard/cookie.c  |    2 +-
 drivers/net/wireguard/netlink.c |    2 +-
 drivers/net/wireguard/noise.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/cookie.c b/drivers/net/wireguard/cookie.c
index 4956f0499c19..f89581b5e8cb 100644
--- a/drivers/net/wireguard/cookie.c
+++ b/drivers/net/wireguard/cookie.c
@@ -12,9 +12,9 @@
 
 #include <crypto/blake2s.h>
 #include <crypto/chacha20poly1305.h>
+#include <crypto/utils.h>
 
 #include <net/ipv6.h>
-#include <crypto/algapi.h>
 
 void wg_cookie_checker_init(struct cookie_checker *checker,
 			    struct wg_device *wg)
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 6d1bd9f52d02..0a1502100e8b 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -12,10 +12,10 @@
 
 #include <uapi/linux/wireguard.h>
 
+#include <crypto/utils.h>
 #include <linux/if.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
-#include <crypto/algapi.h>
 
 static struct genl_family genl_family;
 
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 720952b92e78..e7ad81ca4a36 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -10,12 +10,12 @@
 #include "queueing.h"
 #include "peerlookup.h"
 
+#include <crypto/utils.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
-#include <crypto/algapi.h>
 
 /* This implements Noise_IKpsk2:
  *

