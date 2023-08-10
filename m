Return-Path: <netdev+bounces-26228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9D777385
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DA428199A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA0E1EA65;
	Thu, 10 Aug 2023 08:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036E1E525
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:57:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD2010E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:57:09 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM13q6KvtzkX8p;
	Thu, 10 Aug 2023 16:55:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:57:04 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <razor@blackwall.org>,
	<jbenc@redhat.com>, <gavinl@nvidia.com>, <wsa+renesas@sang-engineering.com>,
	<vladimir@nikishkin.pw>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/2] Use helper functions to update stats
Date: Thu, 10 Aug 2023 16:56:40 +0800
Message-ID: <20230810085642.3781460-1-lizetao1@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch set uses the helper functions dev_sw_netstats_rx_add() and
dev_sw_netstats_tx_add() to update stats, which is the same as 
implementing the function separately.

Li Zetao (2):
  net: macsec: Use helper functions to update stats
  vxlan: Use helper functions to update stats

 drivers/net/macsec.c           | 17 +++--------------
 drivers/net/vxlan/vxlan_core.c | 13 ++-----------
 2 files changed, 5 insertions(+), 25 deletions(-)

-- 
2.34.1


