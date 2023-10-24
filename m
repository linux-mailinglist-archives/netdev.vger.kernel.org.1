Return-Path: <netdev+bounces-43980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0027D5BA6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876242818A1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A453D38C;
	Tue, 24 Oct 2023 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6SyJxB9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CE3CD07
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:40:20 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B710D7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:15 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a69a71cc1dso188280339f.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698176414; x=1698781214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQPpgnc6iH7M54KsEpKq47ofo2VjroMenjJs2kprUFI=;
        b=C6SyJxB9rQ7H8B92KH9fXeig100UYCfQozT2elpD3t2tehfVDTMlW6YSOLoT5ksa0B
         xmNa5/zK3yz21u0yroYdaNaEU6lx0PBIwEc1u39dhNbjbKI6Z/YmR9sMEdsyxhSfLMdA
         3rqM7lOSDvZMpSJxEzDZByvSsHfvQ7S0Ff/YSfQ/wI9zrKOKx605ZTnO+RitLIT9dJu9
         EMGPBGpRp0UBlLuQ1eDgkbb7SIK8uJXIl3SrGOny8YMT1sp3J2ZFQEon64RFL0E+JY9u
         UH+eqC78H3COuHTAEhtATL6xD+d1Hc5v5CZ41SBrXjwHTivyDYSfP9PK1lGBkct5/3t6
         YtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176414; x=1698781214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQPpgnc6iH7M54KsEpKq47ofo2VjroMenjJs2kprUFI=;
        b=Lh+AlN4jx/tLMyM/oJeDHSOoPBl4PctQ8IDTfHBPgKdgX/koEiVoAMpAvx3xUFuEb7
         1Y4IzOYjWYIP9Ma9SRUXHBjQogzSZQ7KJOHOUyDvUJdwZODbLxpdX2xtvu+ZXEc1ueDo
         eObJXwL41lVhsy7OWYY+iRa7mQm7pUIL8ZaZYPqGXOepdozKl1arkccJTUeW5Lb3B3Zd
         J1WcQkoOlqtloOK1A/Z22RdXC4Q5bQCkxbIHG0o2QKgCM3qGrLK3rGeWvxkF+x3Xklm5
         c65g9GMdsaA2WMFydovhlb3shWdnJWqgdSQ3erlbhuKw3uAg/g1Fg7sYRsOI4bIZmeTN
         asow==
X-Gm-Message-State: AOJu0YzenZsDHtofMrJ4S+BHlgUgEk4nVneBRsFl6MR2wenB7+02K+MD
	ZV9OOjVlR+8XPz7F0QWorJvaG5HTlTE=
X-Google-Smtp-Source: AGHT+IE7k+UORsR+zD8bEbwvuibrW3HGR6l9vrRioMECsByYL+6znIy809AaqxJ4XMQAiSpMSm+9Og==
X-Received: by 2002:a05:6e02:b2e:b0:34f:9f86:dd45 with SMTP id e14-20020a056e020b2e00b0034f9f86dd45mr17457015ilu.3.1698176414485;
        Tue, 24 Oct 2023 12:40:14 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id s7-20020a056e02216700b00357ca1ed25esm2294486ilv.80.2023.10.24.12.40.13
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
Subject: [PATCH resend 1/4] net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
Date: Tue, 24 Oct 2023 13:40:01 -0600
Message-ID: <20231024194010.99995-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829054623.104293-1-alexhenrie24@gmail.com>
References: <20230829054623.104293-1-alexhenrie24@gmail.com>
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
index 0b6ee962c84e..e51c30d1daff 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1397,6 +1397,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
 	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
 	tmp_tstamp = ifp->tstamp;
-- 
2.42.0


