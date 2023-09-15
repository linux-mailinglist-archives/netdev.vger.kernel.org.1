Return-Path: <netdev+bounces-34057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069CC7A1E61
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9828249A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2C107B1;
	Fri, 15 Sep 2023 12:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C071078B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:15:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A92DA2708
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694780127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
	b=NuNY3WG1WnX4m0MxIHJzurF+eZ0XicILWQUxYh92xYOaJ8S50QOA8NVMwkyznnAQ5N5O+6
	ORNnHX+vMVdrhxaHPoEWdF735SLcZ1nUUH6vJpFaL55/HlIeXy0duGFYf//7Uap1jLQP6M
	j3QuukfkLhdXJUrsP5fxJl3ypQEzhUc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ckf4-NPBNmy6066eMRlmkA-1; Fri, 15 Sep 2023 08:15:26 -0400
X-MC-Unique: ckf4-NPBNmy6066eMRlmkA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401db25510fso15593425e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780125; x=1695384925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
        b=hu5bTG1+Y4H/LCO86y+zLGMfIjZXQVUCu4iyUHi8eOTrgW2JcP77HWct4n67eubhBU
         3P0UIOxsjFh+MVmYaurR/Wjujp093P1x9MOzFlFXNvD2thkMCybkLvrGDDZncH3ioVYX
         fWHfawXKuATv0+X7XSDBQ8KnRMugRXIjKvDgQeV1GMX8IcB8LmsIIAmboni6ebjVu4pE
         wUCaCPwXjLtY+zJVQT0KznzmUKyRRBfRydDxbDEAFUgJtxHmhZFL7w+U5JLhAYgKzp90
         VO7VGYWyUHxVFndUXOo6jaLIZUTeRIAhoIxs1cEcQKtzhH9bDJCXpJgQxRMFQDnuiwiM
         qq7w==
X-Gm-Message-State: AOJu0YwjxY90DsihYwWS3QVyUptRi5RY7TjqxiB7IH/TelntAWOg3Jpm
	EmJoN6pfYNg4EiJF7IHsOCIZZd3Rdeg/GsXMzz/PZvqQyP/H/zxQeXvDOCImiga8VawLtnaYOre
	uRf87Eyq9jA1mHstcSIB2idbjXZR3PyN2z1hlxqtWq3TioFsqYwgSOk7NXEesHER91X7y8smfAu
	paa3Y=
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id w8-20020adfcd08000000b0031fafeb4e71mr1327912wrm.48.1694780124928;
        Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAM+qT8oGEefSDmkyANZPTMrHB/rc6Va9KYPc9DtRjeZCpejNAvp5rpxARReDs63NX0XPsvQ==
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id w8-20020adfcd08000000b0031fafeb4e71mr1327892wrm.48.1694780124604;
        Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b0031fbbe347e1sm4287767wrv.65.2023.09.15.05.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:23 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux-foundation.org,
	oxffffaa@gmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 5/5] vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET
Date: Fri, 15 Sep 2023 14:14:52 +0200
Message-ID: <20230915121452.87192-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test was a bit complicated to read.
Added variables to keep track of the bytes read and to be read
in each step. Also some comments.

The test is unchanged.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b18acbaf92e2..5743dcae2350 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1002,6 +1002,7 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
+	size_t read = 0, to_read;
 	unsigned char buf[64];
 	int fd;
 
@@ -1014,14 +1015,21 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	recv_buf(fd, buf, 2, 0, 2);
+	to_read = 2;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	recv_buf(fd, buf + 2, 8, 0, 8);
+	/* Read the rest of both buffers */
+	to_read = strlen(HELLO_STR WORLD_STR) - read;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
-	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
+	/* No more bytes should be there */
+	to_read = sizeof(buf) - read;
+	recv_buf(fd, buf + read, to_read, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0


