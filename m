Return-Path: <netdev+bounces-17044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE874FE5D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED92818BB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626D635;
	Wed, 12 Jul 2023 04:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAA190
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:40:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4961992
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yWzS53bbi1Xzkgj8Cj77sfUoOu/WSZaDMZ8dQTkEAd4=; b=CZb1PD3ZAvHwXJAGvnVXh5M4FY
	CDxUAVmosMpkEGFaRhEB/r7T+z8mMK99JKDZ4+cvsLhDGjsFmpJemvCcWp1v3xSb4prU7Ohgfs09b
	g1DzdVKpMS5sFYtOeQz11wVjqbvx2nTPIkFPu9o0DbdNkrSxF517Q0sdS5EOmHq2WL/GksFJ8cxu1
	+3BvO/Z6LfepQNB9Ppv8kwx43B0ZhQg8q5s1oufmp46NO3OwEJPjgxj65FcWqaTsp+tDp90xS0Rl/
	+2WKchpZhxehxfod+Y1N1ycP4buAMs9ttqbPu4sefd/6b5xPBPCVANRKZX2Le7yjgEmEVoJWcNwPh
	fEqfrbAw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJReb-00GW53-2O;
	Wed, 12 Jul 2023 04:40:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v2 net 07/12] inet: frags: eliminate kernel-doc warning
Date: Tue, 11 Jul 2023 21:40:40 -0700
Message-ID: <20230712044040.10723-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change the anonymous enum kernel-doc content so that it doesn't cause
a kernel-doc warning.

inet_frag.h:33: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Fixes: 1ab1934ed80a ("inet: frags: enum the flag definitions and add descriptions")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/inet_frag.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/net/inet_frag.h b/include/net/inet_frag.h
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -29,7 +29,7 @@ struct fqdir {
 };
 
 /**
- * fragment queue flags
+ * enum: fragment queue flags
  *
  * @INET_FRAG_FIRST_IN: first fragment has arrived
  * @INET_FRAG_LAST_IN: final fragment has arrived

