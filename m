Return-Path: <netdev+bounces-13266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F98173B08B
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 08:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7716B1C20EC8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 06:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35553A53;
	Fri, 23 Jun 2023 06:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EEA3B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:11:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE710DB;
	Thu, 22 Jun 2023 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5UQOnj+EL/9oIsTofJlpcZai9GCdVN+roMEwh7clpOc=; b=2AChkdxEO1FmOtqF0sWRc4j9MO
	8GT74VDCFNlhXzXQCK1frQWvEAOFCjJGUXMc5qGBkgWTM99B6qHQ9W+AFUnCpexGesAjycvyfdDFw
	izi0sgqfE7VxNPwFAZWn0fW9H4dVpM5L+zLNjjQRlxL2B/2rWO41iKW82SXxZ5Bkm2sIbrFgHAotO
	jUxPARZ2NyrruHpit44KZmKGH0n0wfL28Q3IcDpQ+Ll9GQw/LLry4dorttsRRfUg6zkzX7Y0QKksd
	NsjIOraeG4y5w+aYV1aPrnXlBG6ZSFCONBJfVIGbbEAX0HJ6hq/8mXjTj/Ez4BWePuuVfGAhssz7n
	nCmDNd9Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qCa0c-002fRx-1u;
	Fri, 23 Jun 2023 06:11:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] linux/netfilter.h: fix kernel-doc warnings
Date: Thu, 22 Jun 2023 23:11:01 -0700
Message-ID: <20230623061101.32513-1-rdunlap@infradead.org>
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

kernel-doc does not support DECLARE_PER_CPU(), so don't mark it with
kernel-doc notation.

One comment block is not kernel-doc notation, so just use
"/*" to begin the comment.

Quietens these warnings:

netfilter.h:493: warning: Function parameter or member 'bool' not described in 'DECLARE_PER_CPU'
netfilter.h:493: warning: Function parameter or member 'nf_skb_duplicated' not described in 'DECLARE_PER_CPU'
netfilter.h:493: warning: expecting prototype for nf_skb_duplicated(). Prototype was for DECLARE_PER_CPU() instead
netfilter.h:496: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Contains bitmask of ctnetlink event subscribers, if any.

Fixes: e7c8899f3e6f ("netfilter: move tee_active to core")
Fixes: fdf6491193e4 ("netfilter: ctnetlink: make event listener tracking global")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netfilter.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/netfilter.h b/include/linux/netfilter.h
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -481,7 +481,7 @@ struct nfnl_ct_hook {
 };
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
-/**
+/*
  * nf_skb_duplicated - TEE target has sent a packet
  *
  * When a xtables target sends a packet, the OUTPUT and POSTROUTING
@@ -492,7 +492,7 @@ extern const struct nfnl_ct_hook __rcu *
  */
 DECLARE_PER_CPU(bool, nf_skb_duplicated);
 
-/**
+/*
  * Contains bitmask of ctnetlink event subscribers, if any.
  * Can't be pernet due to NETLINK_LISTEN_ALL_NSID setsockopt flag.
  */

