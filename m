Return-Path: <netdev+bounces-39593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6107BFFCC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192061C20BA0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21524C7D;
	Tue, 10 Oct 2023 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DC250F8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45799;
	Tue, 10 Oct 2023 07:54:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7o-0001RC-7N; Tue, 10 Oct 2023 16:54:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH net-next 8/8] netfilter: cleanup struct nft_table
Date: Tue, 10 Oct 2023 16:53:38 +0200
Message-ID: <20231010145343.12551-9-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010145343.12551-1-fw@strlen.de>
References: <20231010145343.12551-1-fw@strlen.de>
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

From: George Guo <guodongtai@kylinos.cn>

Add comments for nlpid, family, udlen and udata in struct nft_table, and
afinfo is no longer a member of struct nft_table, so remove the comment
for it.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7c816359d5a9..9fb16485d08f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1198,10 +1198,13 @@ static inline void nft_use_inc_restore(u32 *use)
  *	@hgenerator: handle generator state
  *	@handle: table handle
  *	@use: number of chain references to this table
+ *	@family:address family
  *	@flags: table flag (see enum nft_table_flags)
  *	@genmask: generation mask
- *	@afinfo: address family info
+ *	@nlpid: netlink port ID
  *	@name: name of the table
+ *	@udlen: length of the user data
+ *	@udata: user data
  *	@validate_state: internal, set when transaction adds jumps
  */
 struct nft_table {
-- 
2.41.0


