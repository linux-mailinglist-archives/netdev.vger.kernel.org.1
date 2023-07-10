Return-Path: <netdev+bounces-16645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C074E1CB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F181C20B8D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0E174EA;
	Mon, 10 Jul 2023 23:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C174E6
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044BE41
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f/MtNGpQun39fx6LSI7qRJxRUNBlKML4XkW01NaHDZ8=; b=WUULXNxemv4VjTn+uRbeWtLEkA
	jwQervK+GQRGJ9qyDdt6XiG876aFdic+Ml8RkJ+94P4HaurbAcjU+yHD8l2VhGahrNDhxXrhO5hxG
	iZ2XrRHdwAuVzxX5a5PjZsBNMK4vZZXqG/lUMM4KCDgSIpdJAqVOypKrc8CMkDtiJnXaFFAHtqs+P
	y+r0qnM18UjSKqjUcSfUhOn7UE4DJ81riY9wumTejQgi1wLg0ZpkLlQ+wtGIqB4wSfLnHgsvWN/do
	2lktiuNkXwH6QtOJATPhp4zHz2OasNMuHkNwI6h+1PIAJE7+a4kfdps2JLZvuanVYvneNk6yww2uo
	SGP2uksw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuY-00CuO1-1r;
	Mon, 10 Jul 2023 23:03:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yi Yang <yi.y.yang@intel.com>,
	Jiri Benc <jbenc@redhat.com>
Subject: [PATCH net 10/12] net: NSH: fix kernel-doc notation warning
Date: Mon, 10 Jul 2023 16:03:10 -0700
Message-ID: <20230710230312.31197-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
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
Cc: Yi Yang <yi.y.yang@intel.com>
Cc: Jiri Benc <jbenc@redhat.com>
---
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

