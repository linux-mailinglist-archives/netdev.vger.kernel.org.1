Return-Path: <netdev+bounces-25406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89081773DF2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4387B28107C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E781426F;
	Tue,  8 Aug 2023 16:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A614269
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:23:34 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3B28E80;
	Tue,  8 Aug 2023 09:23:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qTM2K-0000KB-9g; Tue, 08 Aug 2023 14:42:08 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH next-next 1/5] netfilter: gre: Remove unused function declaration nf_ct_gre_keymap_flush()
Date: Tue,  8 Aug 2023 14:41:44 +0200
Message-ID: <20230808124159.19046-2-fw@strlen.de>
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

Commit a23f89a99906 ("netfilter: conntrack: nf_ct_gre_keymap_flush() removal")
leave this unused, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/nf_conntrack_proto_gre.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netfilter/nf_conntrack_proto_gre.h b/include/linux/netfilter/nf_conntrack_proto_gre.h
index f33aa6021364..34ce5d2f37a2 100644
--- a/include/linux/netfilter/nf_conntrack_proto_gre.h
+++ b/include/linux/netfilter/nf_conntrack_proto_gre.h
@@ -25,7 +25,6 @@ struct nf_ct_gre_keymap {
 int nf_ct_gre_keymap_add(struct nf_conn *ct, enum ip_conntrack_dir dir,
 			 struct nf_conntrack_tuple *t);
 
-void nf_ct_gre_keymap_flush(struct net *net);
 /* delete keymap entries */
 void nf_ct_gre_keymap_destroy(struct nf_conn *ct);
 
-- 
2.41.0


