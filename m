Return-Path: <netdev+bounces-24726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376077177D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 02:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F51C208EF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112F19D;
	Mon,  7 Aug 2023 00:32:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817F198
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:32:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85CA11711;
	Sun,  6 Aug 2023 17:32:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,261,1684767600"; 
   d="scan'208";a="172107181"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Aug 2023 09:32:39 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5930E40E3C98;
	Mon,  7 Aug 2023 09:32:39 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 net-next 0/2]  net: renesas: rswitch: Add speed change support
Date: Mon,  7 Aug 2023 09:32:29 +0900
Message-Id: <20230807003231.1552062-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add speed change support at runtime for the latest SoC version.
Also, add ethtool .[gs]et_link_ksettings.

Changes from v1:
https://lore.kernel.org/all/20230803120621.1471440-1-yoshihiro.shimoda.uh@renesas.com/
 - Rename rswitch_soc_match to rswitch_soc_no_speed_change.
 - Add Reviewed-by tag in the patch [12]/2 (Simon-san, thank you!).

Yoshihiro Shimoda (2):
  net: renesas: rswitch: Add runtime speed change support
  net: renesas: rswitch: Add .[gs]et_link_ksettings support

 drivers/net/ethernet/renesas/rswitch.c | 29 +++++++++++++++++++++++---
 drivers/net/ethernet/renesas/rswitch.h |  1 +
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.25.1


