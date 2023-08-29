Return-Path: <netdev+bounces-31146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC478BE0A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444991C20991
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1625695;
	Tue, 29 Aug 2023 05:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220B1FA3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:33 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D50FEB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56c2e882416so1890796a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288231; x=1693893031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7tFuFUMGVZpxUDvdd9XZsP0fS3JICRuZZvJ0GIaK4s=;
        b=FlJYR26LkveG/2Rv5aJMjEz2VZ7ApVR/I4f+fAIiMoZy0kZf5KP9FJPHRKKOsW0QIL
         8dIKtBRL7pkkgH+/B1SFyQuNTS7kL+7OVatfAYfSdBckr6dbwVAKDi2W6APPgOskKlWm
         6YxshhE2cQzmA+u7LgmwX4AUNcnZFJnTK+2sc3RotEn92wH8Fw5M1rEtVrCPSnZM+nyN
         IkP8osWGLVkHP9Pfu7NKhQsUEsEypETqvDKsEGekeIxzawe/+E1zkIGNjjc7wbUDKVs9
         ZWPWyGzcGlEc+3tBillql7pfB8J4QbGo5KViUXFWNzW/v81sDVv9NuSbYH67nVQINA/E
         ZLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288231; x=1693893031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7tFuFUMGVZpxUDvdd9XZsP0fS3JICRuZZvJ0GIaK4s=;
        b=H53/fi6i47cCJlbugj5e90q6EZa5IXcPy4GdqSTMiIG0NW1xOXEd3jBoyIOTTeSzid
         La930uCxusz1u0ah3k4bK4e2kbY5lbvd+PGrSPf46S5PvDMgFbFJZ6g9OId9Y/tl3M9A
         IdjRAPt4L/Q70bhOZk0AntvH8WbKSoj6jQH6gemwdthjsECCOPvtMyhQ33BAS810d1Vz
         Ih5RYhsMwtfHnW11VACda1Co3DuTsLhfAkpqgKzsPuZisjrAX8vMBxpUJfht+e1NTapb
         bvTHOXNJovQ7gfaGKtpT6SCTxRTPrmq6H9fJ+p9fRkYJmdv5G3MK7OSKbjv2/XuATYFP
         /UNw==
X-Gm-Message-State: AOJu0YyxkqhUIp0cGfaT0QySwDAGuJbW/G9VTT9LzJ8eB0onSJQNjXbN
	y/muZhq6Da5fzH+idHzwFRbDm7HhCqyrEqjA
X-Google-Smtp-Source: AGHT+IFJMnLzO9ohvcNL3nQyQxnswlS0ttz50vcG8uNMIHFKSVbGW7CnyjrO51Duw6YhTN+fNXWebQ==
X-Received: by 2002:a05:6a20:1585:b0:135:8a04:9045 with SMTP id h5-20020a056a20158500b001358a049045mr28659609pzj.1.1693288231405;
        Mon, 28 Aug 2023 22:50:31 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:30 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 3/5] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Mon, 28 Aug 2023 23:44:45 -0600
Message-ID: <20230829054623.104293-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829054623.104293-1-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <20230829054623.104293-1-alexhenrie24@gmail.com>
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
Fixes: eac55bf97094 (IPv6: do not create temporary adresses with too short preferred lifetime, 2008-04-02)
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 561c6266040a..05c22dac32e6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1395,15 +1395,23 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
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


