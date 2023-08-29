Return-Path: <netdev+bounces-31145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086F78BE09
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630CE1C208CD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68410EC;
	Tue, 29 Aug 2023 05:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE01FA3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:32 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C8EA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed286169so3469803b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288230; x=1693893030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufwWgknEywC8ZcuuiWLpZSNXv9qPrlb9lvv6qRYOzOM=;
        b=Zn0RNX6wTZTrJCi/TnRg9I7Jd6qW/h4mtmVZv5Uakl8gHfaGaSOPc65xVczGQXDWE4
         XhI+4lLnCWZ3PgvwY0PDE2B/sj3Yo4vWEp32eakUk2RByfGucPi8TZ+pSx7V4pRMX4vd
         QWTmBwm84AlY3hWKyIH3P/EgIirXvVzmAg+Zd2KUILQQE5WdgZ4i9ZYRk5ScBNwEwFaz
         4YJ34HGZJ6J7VU0atpAcy0tx1nL8kI6bTZZXHxMKm2L6g7FXMwuRfYjzzaYggp6w3Tbz
         6FJXj9dmEhmRK/m+hXyeNuwuITfM7rBTUjRvjYB+BCKZWRaksnQrEKbWyABDC8A9CtBz
         qiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288230; x=1693893030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufwWgknEywC8ZcuuiWLpZSNXv9qPrlb9lvv6qRYOzOM=;
        b=gcfVYDqCJsALF9N7P4sxPWhlhf01muPGuKkVz00S0moEmNkuNTH4IW4sn9Qi+NYQY3
         h2OTpWoKYmFITpRSREI4zzjZKGn+fOlpymK3x2c+5XUzjGOyfJm2Bb7owyML4Iq6HlDm
         sXyS6gVIdd77umKISeYlCDVVlNkRnyS31An3p4ylxc8mrx07rIXFGw96BJKPisAkcCm/
         E2gxzVDne1pCftolxNSQQEWSNv5nk6NLl22r0Biw//WY+mi2R3q6scXJlPKvuElvN8bG
         o3awqXmLY3dEHJijpzqmCj7X9A/VTOCq277+xQxXCofrQh2E61+b4U3Fbgm+7dulbmMZ
         Qo4g==
X-Gm-Message-State: AOJu0Ywc6XJlk0IeuFiZeJaA6y04n8wpm87IXG7U4n71Vskx1naVm4ab
	wP/vMi49Lr/gkuJXr/vETIYAfbh429edxM4S
X-Google-Smtp-Source: AGHT+IGdxP5mD1XN32O+uo9kODkUfA45/9qm7db2sMJrLXP9DrS9QXo8KG1SwewAHTHNXalumN751Q==
X-Received: by 2002:a05:6a00:2482:b0:68b:eb3d:8030 with SMTP id c2-20020a056a00248200b0068beb3d8030mr16729239pfv.1.1693288230378;
        Mon, 28 Aug 2023 22:50:30 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:29 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 2/5] net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
Date: Mon, 28 Aug 2023 23:44:44 -0600
Message-ID: <20230829054623.104293-3-alexhenrie24@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Without this patch, there is nothing to stop the preferred lifetime of a
temporary address from being greater than its valid lifetime. If that
was the case, the valid lifetime was effectively ignored.

Fixes: 76506a986dc3 (IPv6: fix DESYNC_FACTOR, 2016-10-13)
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c93a2b9a9172..561c6266040a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1387,6 +1387,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
 	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
 	tmp_tstamp = ifp->tstamp;
-- 
2.42.0


