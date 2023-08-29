Return-Path: <netdev+bounces-31144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6078BE08
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1927E1C2084F
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B144137C;
	Tue, 29 Aug 2023 05:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B410EC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:31 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D319EB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a88e1a5286so3044187b6e.3
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288229; x=1693893029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTpAF+KNGLVMSSsFOIIcuQ1B4sdkh8B+7dPPotbY/Ms=;
        b=MvJx3/2fUl9umWOf59eWwo47eqOYXln9ls5hflWe2yE1uJQ5phmLPMUyP5EGHHTuZ6
         THJI6EQvg1wCpgnZ64T/oHMr/14VBSWQYBcAB+vMijKaGsOPbS+icCKurz++kn7iwR2O
         u5IK0nUAwp+BLCR4m6qP32SG9b5y/UZmtpdvQhU+scDrMrAkF2PcXXWf/B8BRWBUGDJ7
         jmNMii+k6aZ63CUg941fNs2HNd0hz2t2Y7tSyK2PGDawGF/z1booKXAbdnEBqB+LVKEk
         eOaXq/BAA9jCXrZJ+E5iSCrVxTZFy0ancwB/TMe2cWpxalm8nR59UHh3OEd8vpEITnij
         qwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288229; x=1693893029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTpAF+KNGLVMSSsFOIIcuQ1B4sdkh8B+7dPPotbY/Ms=;
        b=WFscy+R1dQB+9Igxx8Ocu6xrvZdCXS2tDK/r0XNDA5qvsNSQKFvWt+CG8dDVZO8O98
         3sAmMqSm9ae/kGJhqmIeCzcCpgPaWBjjp2BiRqhEbgwdJ8NX/PJjkOQlhgTLb1GEfzj0
         vJoJ6iVAxLwKzeamT/naGpf2JX5TMXiWQvU1EfEWg1PL/pWiSnQuUTy8e72jsMYAwzvq
         9L2saJbw03FTEBeBYoToQCTm1ipmTPsHLVxX176BF6dvXZppSiegQVEuRLI0vhHYbKmQ
         xMwG+ohA5IONoqg7yFx69qQMIkCRUDJfGHf9NNAGaI4C9laHgbdFTEw+Lp/eVzjFPq8h
         Uc+g==
X-Gm-Message-State: AOJu0YzFmK/bHoToPKjCzd77y1niuoi7z50rjS5AFYYLHuXYQplUTDN8
	KUzptTCvnBZS391tdRT/ODlUUHlFBo8g8BG7
X-Google-Smtp-Source: AGHT+IHgWoNtXLKXXv91gR4aaQ34YLTT0QnSAvXVVVMt2QMnFjt1jFg1agmklLw0qbF+2gUCftbqGQ==
X-Received: by 2002:a05:6808:2a7a:b0:3a8:5fd6:f4cf with SMTP id fu26-20020a0568082a7a00b003a85fd6f4cfmr12398522oib.22.1693288229297;
        Mon, 28 Aug 2023 22:50:29 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:28 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/5] net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
Date: Mon, 28 Aug 2023 23:44:43 -0600
Message-ID: <20230829054623.104293-2-alexhenrie24@gmail.com>
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

The existing code incorrectly casted a negative value (the result of a
subtraction) to an unsigned value without checking. For example, if
/proc/sys/net/ipv6/conf/*/temp_prefered_lft was set to 1, the preferred
lifetime would jump to 4 billion seconds. On my machine and network the
shortest lifetime that avoided underflow was 3 seconds.

Fixes: 76506a986dc3 (IPv6: fix DESYNC_FACTOR, 2016-10-13)
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94cec2075eee..c93a2b9a9172 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
-- 
2.42.0


