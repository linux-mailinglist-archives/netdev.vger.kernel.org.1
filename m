Return-Path: <netdev+bounces-21103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB176276F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD691C21044
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148E27725;
	Tue, 25 Jul 2023 23:35:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47328462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:35:22 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D3119BA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563db371f05so406978a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328121; x=1690932921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8C8WN8g4V3DRA6OM+WF8phKoBb7MuO1zg5ar7S8uBQ=;
        b=IUQhsgm4rInDGHkyVvck0QBNCBc9z3mP4MBkHFFxRdWFV8wyiCDYa/NvrmfscXx9BX
         HiSIxKrEWLPGyRzuTY/1aQt9oSyNYVcoVApSGoffXVWNEKya2qyldNGIPoefLrsX1LoS
         riffsxM4UE7whDxIWjlDfwPWyGjoQkM7ptrsQWqq4EaPtZ0MFRvntYeG6SHvNMNbZfN8
         PRzfgW6O56MmbTjjAydVqjpk5+lZsNuI9eCPpT+wes6M+eYsQNxA/p4eyhox7WwtudeP
         KCTz4ck3pDRJvorEY75WHOGqKHfLIcGsUb1rIz60IwepG90ZmNx1KVuvM9B8aZBR3liX
         B3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328121; x=1690932921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8C8WN8g4V3DRA6OM+WF8phKoBb7MuO1zg5ar7S8uBQ=;
        b=FSnIe8VswnVvKT9L2IjPvL4+yATcwp5zG6WD3FjT3wBDSQj71e/QjdN7rRwQKry4Jj
         mOj9wtxgmWQ/tRdkCpcHuWrdXzOceGqfG55YD3SNEA9NVthfffCsggroRXeTHm90e66A
         qdKJIX7f5tMjE3TqnMLCL9fTjvgv/KKrWPU14yEQUH/YkwocNsNgzF7ZUrVHnyxAKiHS
         c/t+88FL8aD53pTAJ2ZW4ptwfphwhRftYMJ2qEGH68vk5qG74gWvSCldxBUg1u6beWfl
         s9t8koC3Ssluvy6+s9tX5RxbGhX8ol9Y+1EVcW1t+DZX9apL7DIgWhevvA+mmlzCOuU4
         VHoQ==
X-Gm-Message-State: ABy/qLZFDGyCBtLD26uMKy9NYOFD/p7vxZJROFerzTiilfNMaWRp1ufd
	CxxAYZ3hxg2rcAXGp17+Zw9JSgpZnSWvUTfXUBnDB5MHyJRQY3waXPFWwNXU8ii3fVATjn3TNoP
	mnOkfMXMWIc3SQhD9pztD4hXbDHYyfJ3rP5CgSs4VOLRyiGIe/jvanQ==
X-Google-Smtp-Source: APBJJlFM3J9YBZc8dmWZA+ZQ3dv8gl+oE966zbQa1IkwbzASOnjUM+H/dn1QOOd1NHXvOf8ddtgI4wQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7f1c:0:b0:553:3ba2:f36 with SMTP id
 a28-20020a637f1c000000b005533ba20f36mr2622pgd.9.1690328120362; Tue, 25 Jul
 2023 16:35:20 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:35:14 -0700
In-Reply-To: <20230725233517.2614868-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725233517.2614868-2-sdf@google.com>
Subject: [PATCH net-next 1/4] ynl: expose xdp-zc-max-segs
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Also rename it to dashes, to match the rest. And fix unrelated
spelling error while we're at it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e41015310a6e..1c7284fd535b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -14,7 +14,7 @@ name: netdev
       -
         name: basic
         doc:
-          XDP feautues set supported by all drivers
+          XDP features set supported by all drivers
           (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
       -
         name: redirect
@@ -63,7 +63,7 @@ name: netdev
         enum: xdp-act
         enum-as-flags: true
       -
-        name: xdp_zc_max_segs
+        name: xdp-zc-max-segs
         doc: max fragment count supported by ZC driver
         type: u32
         checks:
@@ -83,6 +83,7 @@ name: netdev
           attributes:
             - ifindex
             - xdp-features
+            - xdp-zc-max-segs
       dump:
         reply: *dev-all
     -
-- 
2.41.0.487.g6d72f3e995-goog


