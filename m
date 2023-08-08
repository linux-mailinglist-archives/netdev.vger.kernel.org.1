Return-Path: <netdev+bounces-25396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92F773DB5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098D52804A3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73F14014;
	Tue,  8 Aug 2023 16:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFA13FFC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:21:02 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40601AD143;
	Tue,  8 Aug 2023 09:20:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qTM2O-0000KV-Ii; Tue, 08 Aug 2023 14:42:12 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH next-next 2/5] netfilter: helper: Remove unused function declarations
Date: Tue,  8 Aug 2023 14:41:45 +0200
Message-ID: <20230808124159.19046-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808124159.19046-1-fw@strlen.de>
References: <20230808124159.19046-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yue Haibing <yuehaibing@huawei.com>

Commit b118509076b3 ("netfilter: remove nf_conntrack_helper sysctl and modparam toggles")
leave these unused declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack_helper.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index f30b1694b690..de2f956abf34 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -136,8 +136,6 @@ static inline void *nfct_help_data(const struct nf_conn *ct)
 	return (void *)help->data;
 }
 
-void nf_conntrack_helper_pernet_init(struct net *net);
-
 int nf_conntrack_helper_init(void);
 void nf_conntrack_helper_fini(void);
 
@@ -182,5 +180,4 @@ void nf_nat_helper_unregister(struct nf_conntrack_nat_helper *nat);
 int nf_nat_helper_try_module_get(const char *name, u16 l3num,
 				 u8 protonum);
 void nf_nat_helper_put(struct nf_conntrack_helper *helper);
-void nf_ct_set_auto_assign_helper_warned(struct net *net);
 #endif /*_NF_CONNTRACK_HELPER_H*/
-- 
2.41.0


