Return-Path: <netdev+bounces-25483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE637743B0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC41C20E97
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAE1C9F1;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832E18034
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE62337F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:41:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKrrS4y5mzNmyw;
	Tue,  8 Aug 2023 19:42:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:45:28 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/3] Remove redundant functions and use generic functions
Date: Tue, 8 Aug 2023 19:45:01 +0800
Message-ID: <20230808114504.4036008-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set removes some redundant functions. In the network module,
two generic functions are provided to convert u64 value and Ethernet
MAC address. Using generic functions helps reduce redundant code and
improve code readability.

Li Zetao (3):
  octeontx2-af: Remove redundant functions mac2u64() and cfg2mac()
  octeontx2-af: Use u64_to_ether_addr() to convert ethernet address
  octeontx2-af: Remove redundant functions rvu_npc_exact_mac2u64()

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 26 +++----------------
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  5 ++--
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 20 ++------------
 3 files changed, 8 insertions(+), 43 deletions(-)

-- 
2.34.1


