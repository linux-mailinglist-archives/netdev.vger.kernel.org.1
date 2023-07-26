Return-Path: <netdev+bounces-21423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E976392D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C1281F24
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF0253AF;
	Wed, 26 Jul 2023 14:32:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F621D36
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:32:48 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CD196;
	Wed, 26 Jul 2023 07:32:45 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9xDQ22npz1GDHV;
	Wed, 26 Jul 2023 22:31:50 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:32:43 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <dccp@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] dccp: Remove unused declaration dccp_feat_initialise_sysctls()
Date: Wed, 26 Jul 2023 22:32:39 +0800
Message-ID: <20230726143239.9904-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/dccp/feat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/dccp/feat.h b/net/dccp/feat.h
index d76c9be5bfca..57d9c026aa3f 100644
--- a/net/dccp/feat.h
+++ b/net/dccp/feat.h
@@ -105,7 +105,6 @@ extern int	     sysctl_dccp_rx_ccid;
 extern int	     sysctl_dccp_tx_ccid;
 
 int dccp_feat_init(struct sock *sk);
-void dccp_feat_initialise_sysctls(void);
 int dccp_feat_register_sp(struct sock *sk, u8 feat, u8 is_local,
 			  u8 const *list, u8 len);
 int dccp_feat_parse_options(struct sock *, struct dccp_request_sock *,
-- 
2.34.1


