Return-Path: <netdev+bounces-20201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2875E3E4
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E2B2818BE
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790E440C;
	Sun, 23 Jul 2023 16:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84F3FC8
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:43:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DA191
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690130593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdeGeOcVLF93TH3NgCUThdyqzPa68siEzyDXX/sfSA8=;
	b=adAS1mPx6UDi1hv9JcBp3GRaRHBztJfsT0GQ7TdDolnAQLGp8F8OhIaSqavWgBUeTQpYiS
	PXn72v7YrZBEd+Vs8rxgOMqsJ8tQxZ8Hsz73oqB9Bgr7tGvGGwwviPCz6qypBa7ssCO4fp
	++tEaNDmhC+Mr+9lqq4tUKaVtbXHFFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-AojQB1jpNZSqHSw7-C_LdQ-1; Sun, 23 Jul 2023 12:43:11 -0400
X-MC-Unique: AojQB1jpNZSqHSw7-C_LdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9CCF856F66
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:43:10 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21B0A46A3A9;
	Sun, 23 Jul 2023 16:43:09 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: netdev@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 2/2] man: (ss) fix wrong margin
Date: Mon, 24 Jul 2023 01:42:57 +0900
Message-ID: <20230723164257.1262759-2-yamato@redhat.com>
In-Reply-To: <20230723164257.1262759-1-yamato@redhat.com>
References: <20230723164257.1262759-1-yamato@redhat.com>
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
 man/man8/ss.8 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index d413e570..073e9f03 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -301,8 +301,6 @@ Cgroup v2 pathname. This pathname is relative to the mount point of the hierarch
 .TP
 .B \-\-tipcinfo
 Show internal tipc socket information.
-.RS
-.P
 .TP
 .B \-K, \-\-kill
 Attempts to forcibly close sockets. This option displays sockets that are
-- 
2.41.0


