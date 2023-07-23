Return-Path: <netdev+bounces-20200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9275E3E3
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418231C209B7
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01891C2E;
	Sun, 23 Jul 2023 16:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57531841
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:43:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A88EA
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690130591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i/3NqLhtV4YkQ84XyD4TvQ4HMCOm8Xi1er7lAKYELG4=;
	b=Dw3gD6ZATSC4OfY7OYUV4bJIfdNWipPsNqQNZe0GEr4vO4sx0HU46aWil9M63Wbj46dqeh
	CRf5WWm+aUlhAae3FowofxBYIwjAcZmf6FGYmrTRPkJnlgXE2KSsIKWzYEqjq3EE1sa8wo
	3zmMz9y6WmI7GypxHPuB4iqPriaDwUY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-7dWad6MnPPmpiivGJaKudw-1; Sun, 23 Jul 2023 12:43:05 -0400
X-MC-Unique: 7dWad6MnPPmpiivGJaKudw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85CED3801BE0
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:43:05 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC4F546A3A9;
	Sun, 23 Jul 2023 16:43:04 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: netdev@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 1/2] tc: fix a wrong file name in comment
Date: Mon, 24 Jul 2023 01:42:56 +0900
Message-ID: <20230723164257.1262759-1-yamato@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 tc/q_plug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_plug.c b/tc/q_plug.c
index 2c1c1a0b..8adf9b96 100644
--- a/tc/q_plug.c
+++ b/tc/q_plug.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * q_log.c		plug scheduler
+ * q_plug.c		plug scheduler
  *
  * Copyright (C) 2019	Paolo Abeni <pabeni@redhat.com>
  */
-- 
2.41.0


