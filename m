Return-Path: <netdev+bounces-31834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7377908CE
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21111C20750
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C0A92A;
	Sat,  2 Sep 2023 17:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA88830
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 17:07:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F37E58
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693674451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lrrM2Y/zZF7w803gWmPyZ7A2zLr5CJoErzGeQi8Jcu8=;
	b=CENVSP3gx8gu02pKidLru8Y1Tf2KQzhJGEvw6YdqAr/ZhDNv3QG6Exj3xn8e8rOnubDPRL
	Ef85dppakZgSt26UUzPRX5S81zWuqXv4CATmWfE0hGV6Q/rYqQNyJJJirFX7KW5sRY/qj1
	RUsZYi2Mlt2eDje3baBf2po4OduDgfs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-g_iVRWziO7-baV8TLG8gWg-1; Sat, 02 Sep 2023 13:07:30 -0400
X-MC-Unique: g_iVRWziO7-baV8TLG8gWg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c097e8a175so909265ad.3
        for <netdev@vger.kernel.org>; Sat, 02 Sep 2023 10:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693674449; x=1694279249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrrM2Y/zZF7w803gWmPyZ7A2zLr5CJoErzGeQi8Jcu8=;
        b=j2SG8AdnZeceS2HJmHO1VKo8OqX1gBLaxL3fgg4JZKGPMPWsSd40ET9Hz98ba+5M0W
         wSL1Fe85uOnKmqG2Ba1R0JJmpWt2kQcwn07BdroGzCmJRxYCRlVXuWJEyGwfX6gn2OEj
         UhNz6jW+J5YzKmncjwc1le+yb48W3D3q4jlLGGaxCo/pZ28/lGwI3bOH5YK5qGylT9Bw
         ysc2sw4vfn7RAP7ITmFlPNrg8GkF8fCnFF3sNhcuZHDwU3oHGm6q5MQSpE2zx+/+7v1s
         YGyGbttswxckAATKndSdgWeVMah67cqwOXYixsDN5aAzpa2IJSdO+O70mhzBM4moLmDV
         1ifg==
X-Gm-Message-State: AOJu0Yy5FSDy2/r03USe/vNWMQOPnGsNSJIc+dIUVVZbjvlv/aCxqkiq
	/0rmiQveHR7D7STbBKW7LzWz/Dcc3l+gs1EUo+t7cROibbfWy/xuZYZGIqU3XD8hE/z3bTfAhwE
	5H+aVu2pW3YgiKK5D
X-Received: by 2002:a17:902:c209:b0:1b8:6850:c3c4 with SMTP id 9-20020a170902c20900b001b86850c3c4mr5299031pll.22.1693674449283;
        Sat, 02 Sep 2023 10:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuy1UPUdxrNCdMmJkPvNypnCa/jr3jSd4rwfJxeJe9vwdZGPIw7NzRd5+fBKpBjT71d9P+Ew==
X-Received: by 2002:a17:902:c209:b0:1b8:6850:c3c4 with SMTP id 9-20020a170902c20900b001b86850c3c4mr5299022pll.22.1693674448968;
        Sat, 02 Sep 2023 10:07:28 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001b9dadf8bd2sm4870370plb.190.2023.09.02.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 10:07:28 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] kcm: Destroy mutex in kcm_exit_net()
Date: Sun,  3 Sep 2023 02:07:08 +0900
Message-ID: <20230902170708.1727999-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kcm_exit_net() should call mutex_destroy() on knet->mutex. This is especially
needed if CONFIG_DEBUG_MUTEXES is enabled.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 393f01b2a7e6..4580f61426bb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1859,6 +1859,8 @@ static __net_exit void kcm_exit_net(struct net *net)
 	 * that all multiplexors and psocks have been destroyed.
 	 */
 	WARN_ON(!list_empty(&knet->mux_list));
+
+	mutex_destroy(&knet->mutex);
 }
 
 static struct pernet_operations kcm_net_ops = {
-- 
2.41.0


