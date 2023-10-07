Return-Path: <netdev+bounces-38774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D77BC6C2
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCD1C2094B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0293182D5;
	Sat,  7 Oct 2023 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQwpQ/o3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C4168DE
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:24:08 +0000 (UTC)
X-Greylist: delayed 3710 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 03:24:06 PDT
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0A9E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:24:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696674243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rPXmlx1ESs+dS6YD/9BfFLmuB90hUrMhRVQrlDgcFxo=;
	b=rQwpQ/o3/wo43UAIV2jM2gbs6AiRkfgePBhdei1ZexKfWs5D7Pg4t9JODHoKsFfPi9zz52
	Ibd7lVPXrP8NXymUpg0BXxha1Wht/HtwirHfkbagcpHbVKiuenJw+yjLQEQAtzj6TtnXKm
	2G9cQ+AOKikkHu2GpX6dcmI27D03NBY=
From: George Guo <dongtai.guo@linux.dev>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH] netfilter: remove inaccurate code comments from struct nft_table
Date: Sat,  7 Oct 2023 18:25:28 +0800
Message-Id: <20231007102528.1544295-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: George Guo <guodongtai@kylinos.cn>

afinfo is no longer a member of struct nft_table, so remove the comment
for it.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index dd40c75011d2..acbb18c212e9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1200,7 +1200,6 @@ static inline void nft_use_inc_restore(u32 *use)
  *	@use: number of chain references to this table
  *	@flags: table flag (see enum nft_table_flags)
  *	@genmask: generation mask
- *	@afinfo: address family info
  *	@name: name of the table
  *	@validate_state: internal, set when transaction adds jumps
  */
-- 
2.34.1


