Return-Path: <netdev+bounces-44008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031807D5D1E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EE41C20C14
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56C3F4B5;
	Tue, 24 Oct 2023 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mre7rMk4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4C3E49F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:25:14 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99B9D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a67b9cd230so190765639f.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182712; x=1698787512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vQ+QjPwiKbsv6AdYqy3e3uE4inDpXcgKu4yLJ2WWYg=;
        b=mre7rMk4DAGXGIRAhNidGrigmHusQEy7r5igup+h8gSrCtbZiPdBbRpjKfRJxcKJb8
         HB+BwVaI0gtLyaaT0XU/snpzM3MeKHD1FxggL4sp470aUzdFhMUjt2eoW9TBNCZezLTZ
         XmJZXMN1XTbUC6a1Bz/fCysjgIJh8Oxtqg6c8HR8kCfxfiyu8mk6csdajHZQ4YGqCP+K
         +Uqx11yDgv6jIyMzKnEM34Bx3rXIikpRjjPS8rTw76+8LEdNDPvZBsHPRut5RXr0z8DO
         O6ZMj8c0AGEzu0I9hTddeqrMdLksk/lh5jZGfrOgywhKN+ntZIQYl0OJCRT80LVAROb4
         +RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182712; x=1698787512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vQ+QjPwiKbsv6AdYqy3e3uE4inDpXcgKu4yLJ2WWYg=;
        b=agb/LmhnX6apJqFjHiQkg7FopBhpHXTsmU2P7XnzMr5bq8HKlfG+agNCrgt6863KsJ
         EAueSMzkucpbr8wK0Y+LhOxM7WTI8PpcJcGeYHablS/bN+1cDmgVFeyIlzUYc1mm3urG
         Zpb8wBMOIwhapRBiuVR6ZYqfpLEzSwCsaOZhBy8f5aW194zgcyrIra1t12wCYhdK1HTv
         VtSrjbiBw7wCTqy2Xd5NBEnPkHItTTQcN5/1BwCKGS3od0AWihgKxH0VjijZB++cD56Y
         eeEUVYwfT++jEeBDoyAmyfEF7wp8sfseFpybxs7Zj7NQJOjFmK5mcnGeXKIbNYrYDVQX
         ovvQ==
X-Gm-Message-State: AOJu0YwJqX+t4tHssiPYO36TAGlhkCF5a3I/lAfd8HXU5ETBBrTgRsM/
	a1Zagc2RBIWum0a869xwPDg6mJOGn10=
X-Google-Smtp-Source: AGHT+IEeh4DYsRSkA0ET7Ad6MHFWF8UugH8hwvkPRC8Et9QlGg0f+ZXdrYYbQsJ89/KMMt6y3ulHSg==
X-Received: by 2002:a6b:c84d:0:b0:79f:cdb4:3f87 with SMTP id y74-20020a6bc84d000000b0079fcdb43f87mr16528078iof.4.1698182711764;
        Tue, 24 Oct 2023 14:25:11 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id ei3-20020a05663829a300b004332f6537e2sm3070830jab.83.2023.10.24.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:25:11 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next v2 1/4] net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
Date: Tue, 24 Oct 2023 15:23:07 -0600
Message-ID: <20231024212312.299370-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024212312.299370-1-alexhenrie24@gmail.com>
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this patch, there is nothing to stop the preferred lifetime of a
temporary address from being greater than its valid lifetime. If that
was the case, the valid lifetime was effectively ignored.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c2d471ad7922..26aedaab3647 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1399,6 +1399,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
 	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
 	tmp_tstamp = ifp->tstamp;
-- 
2.42.0


