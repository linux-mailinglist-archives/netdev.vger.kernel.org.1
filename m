Return-Path: <netdev+bounces-25400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DB773DC7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78AB1C203B8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D814262;
	Tue,  8 Aug 2023 16:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691E13ADC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:22:43 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863527561;
	Tue,  8 Aug 2023 09:22:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qTM2S-0000Kx-Rm; Tue, 08 Aug 2023 14:42:16 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH next-next 3/5] netfilter: conntrack: Remove unused function declarations
Date: Tue,  8 Aug 2023 14:41:46 +0200
Message-ID: <20230808124159.19046-4-fw@strlen.de>
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

Commit 1015c3de23ee ("netfilter: conntrack: remove extension register api")
leave nf_conntrack_acct_fini() and nf_conntrack_labels_init() unused, remove it.
And commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
leave behind nf_ct_l3proto_try_module_get() and nf_ct_l3proto_module_put().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack.h        | 4 ----
 include/net/netfilter/nf_conntrack_acct.h   | 2 --
 include/net/netfilter/nf_conntrack_labels.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index a72028dbef0c..4085765c3370 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -190,10 +190,6 @@ static inline void nf_ct_put(struct nf_conn *ct)
 		nf_ct_destroy(&ct->ct_general);
 }
 
-/* Protocol module loading */
-int nf_ct_l3proto_try_module_get(unsigned short l3proto);
-void nf_ct_l3proto_module_put(unsigned short l3proto);
-
 /* load module; enable/disable conntrack in this namespace */
 int nf_ct_netns_get(struct net *net, u8 nfproto);
 void nf_ct_netns_put(struct net *net, u8 nfproto);
diff --git a/include/net/netfilter/nf_conntrack_acct.h b/include/net/netfilter/nf_conntrack_acct.h
index 4b2b7f8914ea..a120685cac93 100644
--- a/include/net/netfilter/nf_conntrack_acct.h
+++ b/include/net/netfilter/nf_conntrack_acct.h
@@ -78,6 +78,4 @@ static inline void nf_ct_acct_update(struct nf_conn *ct, u32 dir,
 
 void nf_conntrack_acct_pernet_init(struct net *net);
 
-void nf_conntrack_acct_fini(void);
-
 #endif /* _NF_CONNTRACK_ACCT_H */
diff --git a/include/net/netfilter/nf_conntrack_labels.h b/include/net/netfilter/nf_conntrack_labels.h
index 66bab6c60d12..fcb19a4e8f2b 100644
--- a/include/net/netfilter/nf_conntrack_labels.h
+++ b/include/net/netfilter/nf_conntrack_labels.h
@@ -52,7 +52,6 @@ int nf_connlabels_replace(struct nf_conn *ct,
 			  const u32 *data, const u32 *mask, unsigned int words);
 
 #ifdef CONFIG_NF_CONNTRACK_LABELS
-int nf_conntrack_labels_init(void);
 int nf_connlabels_get(struct net *net, unsigned int bit);
 void nf_connlabels_put(struct net *net);
 #else
-- 
2.41.0


