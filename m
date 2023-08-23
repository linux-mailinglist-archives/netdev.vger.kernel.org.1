Return-Path: <netdev+bounces-29955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C2785573
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D51C20384
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6F1FDE;
	Wed, 23 Aug 2023 10:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE981BA4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:33:05 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFEFB;
	Wed, 23 Aug 2023 03:33:04 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qYlA0-006vFr-Ts; Wed, 23 Aug 2023 18:32:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Aug 2023 18:32:25 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 23 Aug 2023 18:32:25 +0800
Subject: [PATCH 6/12] wifi: mac80211: Do not include crypto/algapi.h
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
Message-Id: <E1qYlA0-006vFr-Ts@formenos.hmeau.com>
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

 net/mac80211/fils_aead.c |    2 +-
 net/mac80211/key.c       |    2 +-
 net/mac80211/wpa.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index e1d4cfd99128..912c46f74d24 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -5,9 +5,9 @@
  */
 
 #include <crypto/aes.h>
-#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
+#include <crypto/utils.h>
 
 #include "ieee80211_i.h"
 #include "aes_cmac.h"
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 21cf5a208910..13050dc9321f 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -9,6 +9,7 @@
  * Copyright 2018-2020, 2022-2023  Intel Corporation
  */
 
+#include <crypto/utils.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/list.h>
@@ -17,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <net/mac80211.h>
-#include <crypto/algapi.h>
 #include <asm/unaligned.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 4133496da378..2d8e38b3bcb5 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -15,7 +15,7 @@
 #include <asm/unaligned.h>
 #include <net/mac80211.h>
 #include <crypto/aes.h>
-#include <crypto/algapi.h>
+#include <crypto/utils.h>
 
 #include "ieee80211_i.h"
 #include "michael.h"

