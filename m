Return-Path: <netdev+bounces-26754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCF778C7B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD201C214DF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BB7462;
	Fri, 11 Aug 2023 10:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D76FD9
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:55:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665BE55
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:55:05 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMgZr1fmYzcdlB;
	Fri, 11 Aug 2023 18:51:32 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:55:02 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mark.einon@gmail.com>, <siva.kallam@broadcom.com>,
	<prashant@broadcom.com>, <mchan@broadcom.com>,
	<steve.glendinning@shawell.net>, <mw@semihalf.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
CC: <netdev@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
	<zhengzengkai@huawei.com>
Subject: [PATCH net-next 0/5] net: Use pci_dev_id() to simplify the code
Date: Fri, 11 Aug 2023 19:06:57 +0800
Message-ID: <20230811110702.31019-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. Use the API to simplify the code.

Zheng Zengkai (5):
  et131x: Use pci_dev_id() to simplify the code
  tg3: Use pci_dev_id() to simplify the code
  net: smsc: Use pci_dev_id() to simplify the code
  net: tc35815: Use pci_dev_id() to simplify the code
  net: ngbe: use pci_dev_id() to simplify the code

 drivers/net/ethernet/agere/et131x.c           | 3 +--
 drivers/net/ethernet/broadcom/tg3.c           | 3 +--
 drivers/net/ethernet/smsc/smsc9420.c          | 3 +--
 drivers/net/ethernet/toshiba/tc35815.c        | 3 +--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.20.1


