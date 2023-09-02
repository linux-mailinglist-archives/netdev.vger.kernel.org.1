Return-Path: <netdev+bounces-31816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31577905B0
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 09:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913981C2088A
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490C23AA;
	Sat,  2 Sep 2023 07:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F817D2
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 07:16:41 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A510F4;
	Sat,  2 Sep 2023 00:16:40 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rd5hy36jNzQjM3;
	Sat,  2 Sep 2023 15:13:22 +0800 (CST)
Received: from localhost.localdomain (10.175.104.170) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 2 Sep 2023 15:16:37 +0800
From: r30009329 <renmingshuai@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <davem@davemloft.net>,
	<jiri@resnulli.us>, <edumazet@google.com>
CC: <yanan@huawei.com>, <liaichun@huawei.com>, <chenzhen126@huawei.com>
Subject: net/sched: Discuss about adding a new kernel parameter to set the default value of flow_limit 
Date: Sat, 2 Sep 2023 15:16:31 +0800
Message-ID: <20230902071631.204529-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

How about adding a new kernel parameter to set the default value of flow_limit
 when the default qidsc is set to fq? Although We can use the tc to modify the
 default value of flow_limit, it is more convenient to use a kernel parameter to
 set the default value, especially in scenarios where the tc command is
 inconvenient or cannot be used.

