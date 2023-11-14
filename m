Return-Path: <netdev+bounces-47683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121717EAF6A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEBA281168
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B72E626;
	Tue, 14 Nov 2023 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD023FB00
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:43:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8BA7;
	Tue, 14 Nov 2023 03:43:38 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SV4Dn11HMzvPyP;
	Tue, 14 Nov 2023 19:43:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 19:43:36 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH net-next v3] page_pool: Add myself as page pool reviewer in MAINTAINERS
Date: Tue, 14 Nov 2023 19:43:21 +0800
Message-ID: <20231114114322.27452-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

I have added frag support for page pool, made some improvement
for it recently, and reviewed some related patches too.

So add myself as reviewer so that future patch will be cc'ed
to my email.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: David S. Miller <davem@davemloft.net>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Netdev <netdev@vger.kernel.org>
---
V3: rebased on latest net-next and repost targetting net-next
V2: add missing ":" as pointed out by Jesper
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 350d00657f6b..605fe1f9e5ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16342,6 +16342,7 @@ F:	mm/truncate.c
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
+R:	Yunsheng Lin <linyunsheng@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/page_pool.rst
-- 
2.33.0


