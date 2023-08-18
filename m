Return-Path: <netdev+bounces-28709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B578054B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151812821E1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC412B85;
	Fri, 18 Aug 2023 05:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2E624
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:05:45 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BDB3AAB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 22:05:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRqVR4MKZzNmnJ;
	Fri, 18 Aug 2023 13:02:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 13:05:39 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <horatiu.vultur@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 0/3] net: Update and fix return value check for vcap_get_rule()
Date: Fri, 18 Aug 2023 13:05:02 +0800
Message-ID: <20230818050505.3634668-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As Simon Horman suggests, update vcap_get_rule() to always
return an ERR_PTR() and update the error detection conditions to
use IS_ERR(), which would be more cleaner.

So se IS_ERR() to update the return value and fix the issue
in lan966x_ptp_add_trap().

Changes in v2:
- Update vcap_get_rule() to always return an ERR_PTR().
- Update the return value fix in lan966x_ptp_add_trap().
- Update the return value check in sparx5_tc_free_rule_resources().

Ruan Jinjie (3):
  net: microchip: vcap api: Always return ERR_PTR for vcap_get_rule()
  net: lan966x: Fix return value check for vcap_get_rule()
  net: microchip: sparx5: Update return value check for vcap_get_rule()

 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c     | 4 ++--
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


