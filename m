Return-Path: <netdev+bounces-32697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDE7996C5
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E231281A40
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ABA184C;
	Sat,  9 Sep 2023 08:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294517EE
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 08:02:25 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8DC19BC
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:02:24 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RjQMZ2rmPztRjs;
	Sat,  9 Sep 2023 15:58:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 9 Sep
 2023 16:02:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v2 0/5] net: microchip: sparx5: Fix some memory leaks in vcap_api_kunit
Date: Sat, 9 Sep 2023 16:02:02 +0800
Message-ID: <20230909080207.1174597-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some memory leaks in vcap_api_kunit, this patchset
fixes them.

Changes in v2:
- Adhere to the 80 character limit in vcap_free_caf()
- Fix kernel test robot reported warnings in test_vcap_xn_rule_creator()

Jinjie Ruan (5):
  net: microchip: sparx5: Fix memory leak for
    vcap_api_rule_add_keyvalue_test()
  net: microchip: sparx5: Fix memory leak for
    vcap_api_rule_add_actionvalue_test()
  net: microchip: sparx5: Fix possible memory leak in
    vcap_api_encode_rule_test()
  net: microchip: sparx5: Fix possible memory leaks in
    test_vcap_xn_rule_creator()
  net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit

 .../ethernet/microchip/vcap/vcap_api_kunit.c  | 59 +++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

-- 
2.34.1


