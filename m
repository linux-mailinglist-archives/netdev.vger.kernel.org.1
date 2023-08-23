Return-Path: <netdev+bounces-30074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D967785E92
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B5D2811FC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75841F192;
	Wed, 23 Aug 2023 17:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946351F18D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:30:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC67E7D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692811855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MvbKMYwnqe69v0yc2E4ycPNeJxScqvzFFwMZHNI0yI=;
	b=LKNDGMyG7mEceOzRrmNy2g5EIDafYzYZxiS2Q46MBPdSwhmvjLKSZuXxQZD9LpLM6VMV8c
	xrc8CWrfvFFxzW44arMBwgL0ixlSdjXCFMx1hWlTh2QHzxxvUwfmjgxrj1kyvA7V0booTZ
	lYAymbpWoRygxzbgS2dtw1k966ZxkWY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-8eq7y_nROCKTWYN4HIXclw-1; Wed, 23 Aug 2023 13:30:50 -0400
X-MC-Unique: 8eq7y_nROCKTWYN4HIXclw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D52C1C0896E;
	Wed, 23 Aug 2023 17:30:50 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24332492C13;
	Wed, 23 Aug 2023 17:30:48 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 1/4] ss: make is_selinux_enabled stub work like in SELinux
Date: Wed, 23 Aug 2023 19:29:59 +0200
Message-ID: <33564ea9f7c5c8d6f536a2c8db526ca1e14737a0.1692804730.git.aclaudi@redhat.com>
In-Reply-To: <cover.1692804730.git.aclaudi@redhat.com>
References: <cover.1692804730.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From the is_selinux_enabled() manpage:

is_selinux_enabled() returns 1 if SELinux is running or 0 if it is not.

This makes the is_selinux_enabled() stub functions works exactly like
the SELinux function it is supposed to replace.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 misc/ss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 6d34ad0e..007cb349 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -77,7 +77,7 @@
 /* Stubs for SELinux functions */
 static int is_selinux_enabled(void)
 {
-	return -1;
+	return 0;
 }
 
 static int getpidcon(pid_t pid, char **context)
@@ -5682,7 +5682,7 @@ int main(int argc, char *argv[])
 			show_sock_ctx++;
 			/* fall through */
 		case 'Z':
-			if (is_selinux_enabled() <= 0) {
+			if (!is_selinux_enabled()) {
 				fprintf(stderr, "ss: SELinux is not enabled.\n");
 				exit(1);
 			}
-- 
2.41.0


