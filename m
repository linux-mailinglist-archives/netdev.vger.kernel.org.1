Return-Path: <netdev+bounces-43983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24B7D5BAB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364D31C20D09
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6F3D386;
	Tue, 24 Oct 2023 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJuMqZWA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABB3D385
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:40:21 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4310DE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a94a3b0a49so91295939f.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698176415; x=1698781215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjMlbDMYFj4B42KI8Ei4iIUEFFGe3IN3vvrI8NnMDjE=;
        b=EJuMqZWAMtDz8u8/MokJTUsF4tHZBk/Jv5YlDUQXYQnN3W+uSUpvjshKzmey7UlGHi
         MguyukPt6gCG9y7U10q3cegyC4kVkNklIJ9kJvb9zpz5cf1xWMO1CXn9WktyNSXcUiNa
         TdOU3OH8BBvck5VonkppgtDq7ItiRzEw/kLEt8Q3zIW0MBa+icUmdT3kLW67cRx+QomT
         d5y7B3K8CMAOA30m/u3bwOYhzYXaF42Y1QUw/mJQlxYc4zyDPttpThe903HRtcaZ8ayO
         ER6ITkUtE7/S8YPSYBGslcDLMbUtpZ3Bb/F4D/KC0wh8TnSwom0Lqt6WtZV0eZEwdQJm
         TC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176415; x=1698781215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjMlbDMYFj4B42KI8Ei4iIUEFFGe3IN3vvrI8NnMDjE=;
        b=cv+OuJbuEDQgkT5uNvcgOl3u2lBhxjnKSFBpGxdPoW2l3VIHwZDROTih1U273C1Lz7
         tthnRtHCSqzteP8j2jC4sSc+vYhxerxC2NBvFGZBIpdBeLqU79PYhqaU/UMY4vzXKe9q
         AHWszDwUqKvFzHHWiWuS91uV52UOAcOiZIaOK2gd3qMc5JaN962eOYckuXD8CWuZnMRO
         xNQUcjtgHivf1v6Fwfy2/enZceVXMBliVTnjZTYgpP6nl/IfSeXLLj2CcYhcfSCX5v1u
         mmwl3w3CE5CPxctJ49I23KLwrX8BjM9I9cEI6on13q4PJ5kPF/SzK4pNFByR+qyafDJE
         zODQ==
X-Gm-Message-State: AOJu0YxpbkGCMLYOiNRfuZy6GF0dgCRKPY65ozvD51vKfSSKugatu1R3
	kAELWtFvmBDhuuN13WD+oLbO7Xp9ROE=
X-Google-Smtp-Source: AGHT+IHqhF2xtHWeVrBAXsFWHl85kJut3zUDOfHxDrqtL0fN5xLI2MYKcRmhxN7+FRVFql425+9Tyw==
X-Received: by 2002:a92:d691:0:b0:357:71f2:bbb7 with SMTP id p17-20020a92d691000000b0035771f2bbb7mr13363957iln.21.1698176415337;
        Tue, 24 Oct 2023 12:40:15 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id s7-20020a056e02216700b00357ca1ed25esm2294486ilv.80.2023.10.24.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:40:14 -0700 (PDT)
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
Subject: [PATCH resend 2/4] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Tue, 24 Oct 2023 13:40:02 -0600
Message-ID: <20231024194010.99995-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024194010.99995-1-alexhenrie24@gmail.com>
References: <20230829054623.104293-1-alexhenrie24@gmail.com>
 <20231024194010.99995-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the preferred lifetime was less than the minimum required lifetime,
ipv6_create_tempaddr would error out without creating any new address.
On my machine and network, this error happened immediately with the
preferred lifetime set to 1 second, after a few minutes with the
preferred lifetime set to 4 seconds, and not at all with the preferred
lifetime set to 5 seconds. During my investigation, I found a Stack
Exchange post from another person who seems to have had the same
problem: They stopped getting new addresses if they lowered the
preferred lifetime below 3 seconds, and they didn't really know why.

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
 net/ipv6/addrconf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e51c30d1daff..a1eec8f09594 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1405,15 +1405,23 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	write_unlock_bh(&idev->lock);
 
-	/* A temporary address is created only if this calculated Preferred
-	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
-	 * an implementation must not create a temporary address with a zero
-	 * Preferred Lifetime.
+	/* From RFC 4941:
+	 *
+	 *     A temporary address is created only if this calculated Preferred
+	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
+	 *     particular, an implementation must not create a temporary address
+	 *     with a zero Preferred Lifetime.
+	 *
+	 * Clamp the preferred lifetime to a minimum of regen_advance, unless
+	 * that would exceed valid_lft.
+	 *
 	 * Use age calculation as in addrconf_verify to avoid unnecessary
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
-	if (cfg.preferred_lft <= regen_advance + age) {
+	if (cfg.preferred_lft <= regen_advance + age)
+		cfg.preferred_lft = regen_advance + age + 1;
+	if (cfg.preferred_lft > cfg.valid_lft) {
 		in6_ifa_put(ifp);
 		in6_dev_put(idev);
 		ret = -1;
-- 
2.42.0


