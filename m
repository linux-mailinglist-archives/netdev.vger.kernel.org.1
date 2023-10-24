Return-Path: <netdev+bounces-44010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDAC7D5D20
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3867E28218E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5153FB0D;
	Tue, 24 Oct 2023 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGZXvt0O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16993F4AE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:25:15 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F66A6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a93b7fedb8so123326839f.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182713; x=1698787513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UME4268LSpoYDogNItG+ed8HIn9jv+2pUrDkVBKYc0=;
        b=fGZXvt0OpXpe74wg9VgLYyLRh8W48uCA+NPqQ/+GamRCIugArdks0CN8bmxR/7kQcW
         5EfqALwpVBZJOudYSREv1AtrMYvh5AuyxaT64OX9QKgpq2WaHqeedyt8z+MOoz3zRWpM
         funmlwpOr1rFt4pQECyMCxHCLUZQed464RF9J/CH4pM53QAFA7raoyFJ5XNZNJXm6aZt
         H8ROpem/pPoyoBx1PHTEMkklzruGHvwPrGvvKbjCyXXPOS1wWwos3gwS0mmU4VMJWSOy
         G90hRpBkJMqJn55jmQT1LnFR+fyIbHnYC7eCO91tdE10L6AXpLpsUqnbp7bBgJeYgv3j
         xg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182713; x=1698787513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UME4268LSpoYDogNItG+ed8HIn9jv+2pUrDkVBKYc0=;
        b=vXX6o6UIPPtP5nennYZ2GmFSyN/JaFYnY4YK7S10qpNpxi5dhcvVGPxIAJvMqsc0C+
         dO/aK3msRD8Wuk3BmYh6P2QjWocgyje40vM3wrD87lBbT+PoidEkaxS4bkOwoOkFHwOT
         VXHirsT5Dc2XvD4ji8KCaqabyHZPrYuK/qqXU3PV/121tC0eCW3txKDCZRkK5zYipTWt
         3LR1eSNvmLELu5s5P1ql2aiyzxrd3n1dfCoWnrIfFEvhU/E0rdphSH39tPCM8s9pK0qm
         ziUCXLUgwUo5qH77DVHuZ3n5bTDkOIW7YJWagYYgvg6Zm7BC1lXh6Ut8Uz8fluvgs5iz
         oOYg==
X-Gm-Message-State: AOJu0YxTu7DsZqets42wfoeBE9dSBDhS+yrRLbhUUmEUC/kp02jo9oVE
	2BUHLWr9565E94TLvQ6dgh7rhue8DkA=
X-Google-Smtp-Source: AGHT+IFsES+8FgLdN0gtDFuZZ9fwv8aQs3fUUCnTVIqvMCwt71C8NDxoN9WLpwIEgNXTEJKFUGQS7Q==
X-Received: by 2002:a05:6602:398b:b0:7a9:90db:32d0 with SMTP id bw11-20020a056602398b00b007a990db32d0mr1758443iob.19.1698182712795;
        Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id ei3-20020a05663829a300b004332f6537e2sm3070830jab.83.2023.10.24.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Tue, 24 Oct 2023 15:23:08 -0600
Message-ID: <20231024212312.299370-3-alexhenrie24@gmail.com>
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
index 26aedaab3647..3aaea56b5166 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1407,15 +1407,23 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
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


