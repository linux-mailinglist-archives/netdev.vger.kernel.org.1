Return-Path: <netdev+bounces-17790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD57530BC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6387F281D58
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47E613C;
	Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72F5663
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA32D63
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dXvHYWhOkpG23/NfzIy02IMbTpWfYszNtgtMnivGS1w=; b=dYnqKDlf6V8RLMgXpn0gsHasGR
	UIVrHG9acZHgztITYlcbvZZqEuxRbuuy70iGk87CtRgyhSPwp8Y7VBIbfzWwIrPReNjsntGZwqc2Z
	xIab6WzKwUoR/9Rj95BtZYynT/8j1VtXXAw8YGYHg1feRQ5UOMeLq8HGY4mHQZM9L1OVtWPIGE5O3
	hqjFnkDH7RPUwyYVYba3oaW974/TPF67G02FLLUzef+DQZUSaxBjyIshAO0I627dDWUUnXjwymp4z
	u60wwAdVS2ulm3ThwgGFbayBguNaKoeM+gn4TZCn99JOYoevUx/7ow8AMh2l05sfOCvxvHq6I8UFA
	vNm2xjHg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAmB-0050ZV-0e;
	Fri, 14 Jul 2023 04:51:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v2 net 5/9] inet: frags: eliminate kernel-doc warning
Date: Thu, 13 Jul 2023 21:51:23 -0700
Message-ID: <20230714045127.18752-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714045127.18752-1-rdunlap@infradead.org>
References: <20230714045127.18752-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Modify the anonymous enum kernel-doc content so that it doesn't cause
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
v2: keep the kernel-doc comment since scripts/kernel-doc doesn't
    complain about it (Jakub);

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

