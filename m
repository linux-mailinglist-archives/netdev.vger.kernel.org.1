Return-Path: <netdev+bounces-26913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077E77963C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B10C2823C9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D0219DB;
	Fri, 11 Aug 2023 17:37:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DF1172E
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:37:14 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 10:37:11 PDT
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA70A8;
	Fri, 11 Aug 2023 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=676; s=dkim-tub; t=1691775431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w4aamHWJldp6h5Ct58c7qthgK+NVnM3KT47swLL3BsI=;
  b=XNy1ygimnvgONomBYutkwe2yzruPCxXCvnvZX2AAhY6Qr7Bn3fFov2y7
   HmbkMPeCk/E3I4z+P+h7rc4r4StVHFpLrCumopt40eiHwWFH/FG3TVS96
   RQ0vf8GmHeA2OR4iNeWukqPnTGP+ONGK3KbvykAnV1g+nBcCGAosc3s/U
   M=;
X-IronPort-AV: E=Sophos;i="6.01,166,1684792800"; 
   d="scan'208";a="3190198"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 11 Aug 2023 19:36:06 +0200
From: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: Remove leftover include from nftables.h
Date: Fri, 11 Aug 2023 19:33:57 +0200
Message-ID: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit db3685b4046f ("net: remove obsolete members from struct net")
removed the uses of struct list_head from this header, without removing
the corresponding included header.

Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 include/net/netns/nftables.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 8c77832d0240..cc8060c017d5 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -2,8 +2,6 @@
 #ifndef _NETNS_NFTABLES_H_
 #define _NETNS_NFTABLES_H_
 
-#include <linux/list.h>
-
 struct netns_nftables {
 	u8			gencursor;
 };
-- 
2.39.2


