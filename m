Return-Path: <netdev+bounces-17792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C07530BE
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC95B1C2151F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14A6AB1;
	Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BF6AAE
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED92D66
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jTnbCsN1xwibmuRmtqv0PPOLuYJDIy8g+IL+A6MGTcU=; b=2GFGPEN8RNqjoXtJ1e4Cy6bEpz
	5h6aWslAM+Kn1MjDT8gc7vDLQatRHTfms6fXhxLiThOlMxAfeDSfslIzwiptdUkJHVK9nAHzA7/aP
	mrBWfCATCeRbgzAXd6A0xW5ASvp9dTh0OQRRyMIFZdQ6ycb5oR5iNvC3qxbEFbFn1wr0Lm3f0Ne7q
	uYFHKZd3P3H3ZfsqvAqyWsfoFmrYL6ZSH1OBq3A7i8w5/WdoZFLlTmFfdBwCgOqMSzIV4rZrpM1sd
	QHnpN9bmjRK1qI5Phb+5F1LeSTi9x0oLI7ygluuNDrQs2sr41mh+nCtSF51VmnwKuA22tauAwRLxe
	638wpBAw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAmB-0050ZV-2x;
	Fri, 14 Jul 2023 04:51:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Benc <jbenc@redhat.com>
Subject: [PATCH v2 net 7/9] net: NSH: fix kernel-doc notation warning
Date: Thu, 13 Jul 2023 21:51:25 -0700
Message-ID: <20230714045127.18752-8-rdunlap@infradead.org>
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

Use the struct member's name and the correct format to prevent a
kernel-doc warning.

nsh.h:200: warning: Function parameter or member 'context' not described in 'nsh_md1_ctx'

Fixes: 1f0b7744c505 ("net: add NSH header structures and helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Benc <jbenc@redhat.com>
---
v2: drop Cc: Yi Yang <yi.y.yang@intel.com>

 include/net/nsh.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/net/nsh.h b/include/net/nsh.h
--- a/include/net/nsh.h
+++ b/include/net/nsh.h
@@ -192,7 +192,7 @@
 
 /**
  * struct nsh_md1_ctx - Keeps track of NSH context data
- * @nshc<1-4>: NSH Contexts.
+ * @context: NSH Contexts.
  */
 struct nsh_md1_ctx {
 	__be32 context[4];

