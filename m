Return-Path: <netdev+bounces-23943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8AA76E3AD
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DE7282023
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621C13ADD;
	Thu,  3 Aug 2023 08:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51847E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:55:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4CE48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691052899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
	b=C5y/9PwDERjnx1yOUR9shltuhQ8qnFhUQjIIZUtwBrZ73FwWr65pvZOZ5M4iJn85H0lrqy
	sqb9lWSYZbZPXXaGHtQOLdQDKITOXsS7FLmd1TJpNzlFtAWuJnrBHGS5ega+taAd7YP+4d
	nrtL8Fm3QCsdpoMtP9sJKLHqraywVZU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-agmoaiL4N3WBrEMeaiaGHQ-1; Thu, 03 Aug 2023 04:54:57 -0400
X-MC-Unique: agmoaiL4N3WBrEMeaiaGHQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bca0b9234so47538366b.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052896; x=1691657696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
        b=JD75W8y8O4G9i42H3tOce2Lh9tdrNIHRniYHpFGgBIDsF0jBF5QUkHfqRf02sSHG0z
         Dncxzag/Gy/kAbb4vagNHLiQFsNoPLJaBCFikPeCaFnB832IQ4P7nAluLX/OXCeQKUIh
         vx6D4bO1/nJXw9wbHVwYNi6NvsJ5RWvYPGiFWRe6tUAUz/6m0V7ghXUMqCTSuSuBxg/R
         pBwYxy9x9IyB3nNrHVeBQHABSoRdKCBi0kLWldIieoHqF3mq/XCAeykcXZeBUY7PYJqR
         JNQpJO12FpbyhyWfehhV8ZaFgyqn9sKDN89nCfOSXQ1WFJjrT/+tPZSGzpepsXTGxZXs
         G13w==
X-Gm-Message-State: ABy/qLbRRDv5lAMNpyS8IqHRWb87iD+wVhFUSnp8ell8l1SuSgz+44vk
	v/XUEwEyNG/8eEjKFW2TJnXClYyyxnhmvYxDxXXy6ONR0XRvOA5uQ0ZLWdpwIO1iM4/pbxbTHIF
	p+b/kaX6+PG5O7CsWtQnktpTlGmFKjKGhwYsya7Mm7CKX4UGbsLbzSHoi+ZCrabT3lm65wRCaJQ
	T3
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id y30-20020a170906519e00b00993fb68ed67mr7034893ejk.24.1691052896565;
        Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVe0KJwC7fd5aUom3TJxYmpf5W0xCgiDOUhdnqgr4ZWF5nCbowtI5xFne903dpuVY/rWA+AQ==
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id y30-20020a170906519e00b00993fb68ed67mr7034877ejk.24.1691052896280;
        Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709060b1100b0099bcf563fe6sm10239984ejg.223.2023.08.03.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:54:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH net] test/vsock: remove vsock_perf executable on `make clean`
Date: Thu,  3 Aug 2023 10:54:54 +0200
Message-ID: <20230803085454.30897-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We forgot to add vsock_perf to the rm command in the `clean`
target, so now we have a left over after `make clean` in
tools/testing/vsock.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Cc: AVKrasnov@sberdevices.ru
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 43a254f0e14d..21a98ba565ab 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -8,5 +8,5 @@ vsock_perf: vsock_perf.o
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
-	${RM} *.o *.d vsock_test vsock_diag_test
+	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
 -include *.d
-- 
2.41.0


