Return-Path: <netdev+bounces-12876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B2973948B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 03:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA24A1C21001
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FB17C8;
	Thu, 22 Jun 2023 01:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D815DA
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:31:00 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3C1BD8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:30:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 72C2A240108
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687397457; bh=09XlL1/vCcPG0ljTp3PwBDMDDpta1CZKydZBQ7XpElA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=lORN+8euUeR65leU70KFB+GzuyC2mG9G1lWZj6VxVqQrqjtPfe7uox1tDXML8/kLm
	 MqYL76DjhUw5q64r9OcfvbYB7u5lKRVuef17z4zdPW+6l3UtNWSKD9N8MX3azYjI7z
	 McsiG5Ho9HLWEUfpkEBTa0qs8L4KHoQ/gTyt7AqiSx4oNiMFIMe6sEn/xsqZItTd7y
	 NUqwLKpvf8dBH8zsB6c3y4Zv3BOfLq3PEX0E7j4UY8HnA7Pn1Wb57nfwLJzKSlZmA4
	 xJz7rYQ9Pa83IwrRuWYg63QKSjaBNU/PZj48dG0g0lTnRpRc/EDN9rtE/pQNHs9/U+
	 sKxIKVftt+uTA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QmjVy0jmWz6tx4;
	Thu, 22 Jun 2023 03:30:49 +0200 (CEST)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@kernel.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH 1/8] RDMA/rxe: fix comment typo
Date: Thu, 22 Jun 2023 01:26:23 +0000
Message-Id: <20230622012627.15050-2-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Spell "retransmitting" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 26a20f088692..aca0f4c7a5cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -237,7 +237,7 @@ struct rxe_qp {
 	atomic_t		skb_out;
 	int			need_req_skb;
 
-	/* Timer for retranmitting packet when ACKs have been lost. RC
+	/* Timer for retransmitting packet when ACKs have been lost. RC
 	 * only. The requester sets it when it is not already
 	 * started. The responder resets it whenever an ack is
 	 * received.
-- 
2.38.1


