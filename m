Return-Path: <netdev+bounces-29194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD5782109
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 03:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9421C20862
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 01:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD0627;
	Mon, 21 Aug 2023 01:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342FEDD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:14:25 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA3A0
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:14:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f3975ddd4so641311a91.1
        for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692580464; x=1693185264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIdcXst4dP0ae8ailLLCzXQx1YRtfwG+2BPuUzC731U=;
        b=TzMy0fz2rdA8BG68ENB373VKmNz4ow6EH6FkvfU/gWibAgrip8K6IGzOL/gwVqQeDN
         a9TeWYbQkpag9OWQks7Et2iQcsKGFWWeCxKzRY3hB62N9gC/DWbHVSHzPf/SSbJGzFtv
         APM7ehn4HVgzSsWP4qNlkpxJDhk7rYETXH/ikd37U32OABktQxvhXXTq7Gc6b6KKo39b
         VmaRMsY01vqj/4A58O6BCjO7/Q749rul3ABEr/1euzRRXipFVLKR7iX/TPk+oo6xELJu
         pPd4oO59nAEhY52MahxuO9XOrNoS44FAFup4FvmzmImwHFlYsOWxdQo/SiAIJpH7pxHK
         TDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692580464; x=1693185264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIdcXst4dP0ae8ailLLCzXQx1YRtfwG+2BPuUzC731U=;
        b=ULPGiwO5xlWmdYlfpWF3jeWEUSBUv8fK+Mf2l1b6U81HnpSwUSrxaAnAhbKRvafk3Y
         yOJEOtG6+ghmzV/MnCS8F89xdbjI/48tK2adBN/a+8Qp3x9N0H5kGjiTuYsX2X8pS71T
         5NwPS+/SpHb/827geDgN2mvtFDxSdSW0GBu6IQTu3e3/K/Hy3feF2nCG5DY57U6bblMB
         sCEFjupOGs+oTZ8SXvRgID/sKp5NnOKk0so9OsEFE8pYybIRqI/crLJ/CnY2tVVW8CCL
         Ja/daW8XosqpWet9chspYRpZyiN7heTgbc0UkuXbismlRVg6Gi7fbyqpwiwbz5gVlmy2
         11TA==
X-Gm-Message-State: AOJu0Ywk+cJa0crbw5ZSX92H4ycH356KtporzehZs4K9Vj1+IJ+HwGBl
	0+JZxqigEwYsQOYhFbcruVc38iLFtYOuIw==
X-Google-Smtp-Source: AGHT+IFW+3g+ah3vzXEc+cpOCSStVrUxv7XQqTA9UDWXKoC+UjBhh08j3SFF99217n76B1GfDEpdRw==
X-Received: by 2002:a17:90a:318c:b0:262:fc8a:ed1 with SMTP id j12-20020a17090a318c00b00262fc8a0ed1mr4440810pjb.44.1692580463760;
        Sun, 20 Aug 2023 18:14:23 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ac29600b00263f41a655esm4936310pjt.43.2023.08.20.18.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 18:14:23 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum instead of erroring
Date: Sun, 20 Aug 2023 19:11:12 -0600
Message-ID: <20230821011116.21931-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I tried setting /proc/sys/net/ipv6/conf/*/temp_prefered_lft to 1 so that
the address would roll over as frequently as possible, then spent hours
trying to understand why the preferred lifetime jumped to 4 billion
seconds. On my machine and network the shortest lifetime that avoids
underflow is 3 seconds.

After fixing the underflow, I ran into a second problem: The preferred
lifetime was less than the minimum required lifetime, so
ipv6_create_tempaddr would error out without creating any new address.
This error happened immediately with the preferred lifetime set to
1 second, after a few minutes with the preferred lifetime set to
4 seconds, and not at all with the preferred lifetime set to 5 seconds.
During my investigation, I found a Stack Exchange post from another
person who seems to have had the same problem: They stopped getting new
addresses if they lowered the preferred lifetime below 3 seconds, and
they didn't really know why.

The preferred lifetime is a preference, not a hard requirement. The
kernel does not strictly forbid new connections on a deprecated address,
nor does it guarantee that the address will be disposed of the instant
its total valid lifetime expires. So rather than disable IPv6 privacy
extensions altogether if the minimum required lifetime swells above the
preferred lifetime, it is more in keeping with the user's intent to
increase the temporary address's lifetime to the minimum necessary for
the current network conditions.

With these fixes, setting the preferred lifetime to 3 or 4 seconds "just
works" because the extra fraction of a second is practically
unnoticeable. It's even possible to reduce the time before deprecation
to 1 or 2 seconds by also disabling duplicate address detection (setting
/proc/sys/net/ipv6/conf/*/dad_transmits to 0). I realize that that is a
pretty niche use case, but I know at least one person who would gladly
sacrifice performance and convenience to be sure that they are getting
the maximum possible level of privacy.

Link: https://serverfault.com/a/1031168/310447
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94cec2075eee..4008d4a5e58d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(__s64,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
@@ -1402,12 +1402,8 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
-	if (cfg.preferred_lft <= regen_advance + age) {
-		in6_ifa_put(ifp);
-		in6_dev_put(idev);
-		ret = -1;
-		goto out;
-	}
+	if (cfg.preferred_lft <= regen_advance + age)
+		cfg.preferred_lft = regen_advance + age + 1;
 
 	cfg.ifa_flags = IFA_F_TEMPORARY;
 	/* set in addrconf_prefix_rcv() */
-- 
2.41.0


