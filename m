Return-Path: <netdev+bounces-16642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9574E1C3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF1B1C20C41
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2291174C4;
	Mon, 10 Jul 2023 23:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BA174C0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:03:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31D10D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=u2pYA1XRrYQS8D48dQiK1WJO9vNiX1lIBhn6N2JW9F8=; b=ZJ9SluyNUiBhA2EPF7jKXybAEw
	P+mUgI+rnfNrBS8OvRKLKvOs1YDWdFSsE01WTFhxXb/MVy175pMKJJtSLu/+3f549vvSvDL1Hsu7m
	kZ+3ZkRRa5sh0kVFR/Iy0aBK2IACZK0lpsQHbX9OckfLdhXdgtOE8LJsRlhdNAYGsJecIWc6m++h8
	a7Le84cPRRGiqMdnBXcsk5L75DL+UC3DN5mK+RdftXMT1o9Ce6z07tDAC9rLyEwTEvdabymyKbjKL
	BUAP3rhpMjF6EA9z1PxRKlC8+16x1qX/p0RWppYn5iQNFQxnY+4XY6/rmOHYDZEpxMx+FT/T7psf+
	dmRVTWXA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qIzuX-00CuO1-1B;
	Mon, 10 Jul 2023 23:03:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 07/12] inet: frags: remove kernel-doc comment marker
Date: Mon, 10 Jul 2023 16:03:07 -0700
Message-ID: <20230710230312.31197-8-rdunlap@infradead.org>
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

Change an errant kernel-doc comment marker (/**) to a regular
comment to prevent a kernel-doc warning.

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
@@ -28,7 +28,7 @@ struct fqdir {
 	struct llist_node	free_list;
 };
 
-/**
+/*
  * fragment queue flags
  *
  * @INET_FRAG_FIRST_IN: first fragment has arrived

