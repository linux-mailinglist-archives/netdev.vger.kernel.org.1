Return-Path: <netdev+bounces-13120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FD73A568
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73292819CA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0371F955;
	Thu, 22 Jun 2023 15:54:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F03AA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FD10F8;
	Thu, 22 Jun 2023 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xyLbNzZ/cBspjKpPk46G3AEQd+aThHsA32OlsyTI2uY=; b=z1nNxx71rlhpqa2DBWP5mZ3LMv
	68WRdxR+w6RcUjAX5uM6xXewmBngVeMOIfBjnQchk42q77qWQDnD3RFrw86YUrgTVIIxU1jqqhuW5
	YUac2edCy4RNDSGoVZL716AJIPzw/+fpCZNuY+7bbDbmjhCV+EZNb2aVy+jzXkVitBez5AdsVmEf+
	dauMnuxi62mi79HjlJ34nS4teh3hLCImCqKNcmANLw1FjqGqW/K3XmPs46peEhQBccNhde1rkqRqj
	epMoVTOEb88FMv2PB0BAWuRkXztaetsGm5471a9TU1Fv205BWS3wRWQazPyhUOmnxcsGZ7mGT1gNi
	a/oNe5kw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qCMdP-001AeD-24;
	Thu, 22 Jun 2023 15:54:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] revert "s390/net: lcs: use IS_ENABLED() for kconfig detection"
Date: Thu, 22 Jun 2023 08:54:09 -0700
Message-ID: <20230622155409.27311-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The referenced patch is causing build errors when ETHERNET=y and
FDDI=m. While we work out the preferred patch(es), revert this patch
to make the pain go away.

Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/s390/net/lcs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -36,7 +36,7 @@
 #include "lcs.h"
 
 
-#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
+#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
 #error Cannot compile lcs.c without some net devices switched on.
 #endif
 
@@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
 	int rc;
 
 	LCS_DBF_TEXT(2, trace, "strtauto");
-#if IS_ENABLED(CONFIG_ETHERNET)
+#ifdef CONFIG_ETHERNET
 	card->lan_type = LCS_FRAME_TYPE_ENET;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
 		return 0;
 
 #endif
-#if IS_ENABLED(CONFIG_FDDI)
+#ifdef CONFIG_FDDI
 	card->lan_type = LCS_FRAME_TYPE_FDDI;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
@@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
 		goto netdev_out;
 	}
 	switch (card->lan_type) {
-#if IS_ENABLED(CONFIG_ETHERNET)
+#ifdef CONFIG_ETHERNET
 	case LCS_FRAME_TYPE_ENET:
 		card->lan_type_trans = eth_type_trans;
 		dev = alloc_etherdev(0);
 		break;
 #endif
-#if IS_ENABLED(CONFIG_FDDI)
+#ifdef CONFIG_FDDI
 	case LCS_FRAME_TYPE_FDDI:
 		card->lan_type_trans = fddi_type_trans;
 		dev = alloc_fddidev(0);

