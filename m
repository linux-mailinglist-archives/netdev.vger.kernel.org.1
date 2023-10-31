Return-Path: <netdev+bounces-45358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5F7DC40A
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 02:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D621C20AA7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2F36D;
	Tue, 31 Oct 2023 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsV9O/57"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39423A54
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 01:58:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FDD91
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:58:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ae5b12227fso54474977b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698717487; x=1699322287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OuL2DgONZ+/GTTWFjqJrvRoTG/+6/YUSF0QOog084CA=;
        b=ZsV9O/57dc9zQdtpzDjVsE8AEH52oiGXbVg/W4vZ+MlFaV5oFej5yogvYat4PLpzjj
         JPqxizCIEgz0UjKVplVYwxASpX7AtCqOuPVUFR9KdE03oeghxWMmYEmQbCI808joPgLA
         U1+zTXkdPJhxS1aKavU2AID97SY+QamWSHekL7Hpdt2urL0m7GVSCrr45yvRPbvuOVgw
         lYU9Ao32Smiz50hLsoKwXsRc0nx68qHlzgHuEQQnvOSE9t2ltEEIviy2/3KidzDpMWS6
         DM6EGqO+HT3wikxiLmiRtf+uuXCIvwwAMzTzUaXK6pMPpEm9c/HhXvM1X8BsM/IGSDiV
         fiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717487; x=1699322287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuL2DgONZ+/GTTWFjqJrvRoTG/+6/YUSF0QOog084CA=;
        b=tweMF6R+8jjetHQKKydG2jPd5yUG0br6ms1FyiB5YW4FFRGRAVP3+UM8P3KiVS/TX5
         PPFCec8SkTVHkfZD7pETOJNh2xU0+lCkcZCGe4YwvaBJEC0QynfKogw35R4bDTbkST+J
         e4vej5sVQyzY+75KuUsO8TviLQT6PbYdVNFD5ah1klFxcQDcOUYGDFWwd0XHlPsSaAaK
         Dc87dtT2hVVxnslntPEByTx6N0MgiU0TqVeHlaQB0cloKOZSnp1WLgMXvVsFIQ5l/7uB
         0VI6EO/a9VR6SKkAGpdKUI8oA/oOj4y2lTFcXJiQRG43gPzUmu0sHZm48FVfcWakh0WZ
         SFNA==
X-Gm-Message-State: AOJu0YyfJETl9g4aLhQeMGnsgDCUkoUHY/Vi/WhkBm1KsFOLTyHtwl7x
	RGsecqHNm8DNWtCJRXYVP3gQZIRR3+A=
X-Google-Smtp-Source: AGHT+IF0HoYi5m2F8pqwrpmh247WsFHNDHPLHFDuPSi1V5WCdt1hOgPlLMKWe1xi+/ZV5pnNdCHzGEswzQ8=
X-Received: from sunytt.sha.corp.google.com ([2401:fa00:41:23:d53:1514:ff53:dcb8])
 (user=sunytt job=sendgmr) by 2002:a25:db93:0:b0:da0:5452:29e4 with SMTP id
 g141-20020a25db93000000b00da0545229e4mr210911ybf.0.1698717487246; Mon, 30 Oct
 2023 18:58:07 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:57:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031015756.1843599-1-sunytt@google.com>
Subject: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
From: Yang Sun <sunytt@google.com>
To: davem@davemloft.net, dsahern@kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Yang Sun <sunytt@google.com>
Content-Type: text/plain; charset="UTF-8"

Looking for a (*, G) MFC returns the first match without checking
the iif. This can return a MFC not intended for a packet's iif and
forwarding the packet with this MFC will not work correctly.

When looking up for a (*, G) MFC, check that the MFC's iif is
the same as the packet's iif.

Signed-off-by: Yang Sun <sunytt@google.com>
---
 net/ipv4/ipmr_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 271dc03fc6db..5cf7c7088dfe 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -97,7 +97,7 @@ void *mr_mfc_find_any(struct mr_table *mrt, int vifi, void *hasharg)
 
 	list = rhltable_lookup(&mrt->mfc_hash, hasharg, *mrt->ops.rht_params);
 	rhl_for_each_entry_rcu(c, tmp, list, mnode) {
-		if (c->mfc_un.res.ttls[vifi] < 255)
+		if (c->mfc_parent == vifi && c->mfc_un.res.ttls[vifi] < 255)
 			return c;
 
 		/* It's ok if the vifi is part of the static tree */
-- 
2.42.0.820.g83a721a137-goog


