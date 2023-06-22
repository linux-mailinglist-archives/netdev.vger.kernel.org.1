Return-Path: <netdev+bounces-12878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069B739496
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 03:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF72C28164F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6017C8;
	Thu, 22 Jun 2023 01:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAE15DA
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:32:24 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622B1BD7
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:32:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B1508240027
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687397540; bh=V9k96scDZkwEItaNXbCiChE4dAzMQL5AXCtzZjXTyjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=lBIvaDU2cgL+XJ78CbU1QOzvjxWxUEOE/UCb//cMF2huKX9dQgHMQFNlxekRPoZkV
	 HUZK1HXRcoro3PqE35yhfMPdXSvAdfwuNI7/yO9gNcCHxSYvmjthu/N9D2SXh1a91i
	 KTmjgch7Tkc+QqkXq1LScMr0WMyUtfPMWNd+plKwqUFwjrXQSq49zBDzI3t9ijrQ8L
	 tk4CxBLMM+DiQs2x4IkwLs+l/x89XBq4AM+QOoMh7UJXuAxjx+1FEVi4bVYwYZoyNx
	 QDArqUW9I3Xh7gF3VFK2/EMDI2k26T+GVwMe09zHKLx2GMUb7QnHUtLAIJ53wHn/78
	 TF2ptWQ6CmU7g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QmjXY1hkqz6txl;
	Thu, 22 Jun 2023 03:32:12 +0200 (CEST)
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
Subject: [PATCH 3/8] zd1211rw: fix comment typo
Date: Thu, 22 Jun 2023 01:26:27 +0000
Message-Id: <20230622012627.15050-4-shamrocklee@posteo.net>
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

Spell "transmits" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 850c26bc9524..8505d84eeed6 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1006,7 +1006,7 @@ static void tx_urb_complete(struct urb *urb)
  * @usb: the zd1211rw-private USB structure
  * @skb: a &struct sk_buff pointer
  *
- * This function tranmits a frame to the device. It doesn't wait for
+ * This function transmits a frame to the device. It doesn't wait for
  * completion. The frame must contain the control set and have all the
  * control set information available.
  *
-- 
2.38.1


