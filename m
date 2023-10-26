Return-Path: <netdev+bounces-44440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EF7D7FD8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB12F281FB9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547E28E02;
	Thu, 26 Oct 2023 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Tk/kBd/Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C128694
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:42:31 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C91193
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:42:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f61312eso5545925e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698313348; x=1698918148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HArSpqZPnriBVqM6a+6khhT78r6G789Qs/4LaODD6I=;
        b=Tk/kBd/QIT3j6eXkXjxi6EvBo6Vnt4/YzXIAoSBkUT1n7eG9Kq6ditkvnQ03wce9S8
         QYhKVuQWJlM8Cu6PqVXq9JBk9XkyvHZU6WvqpSez5XJ3ZfXxxAfzordGk6sFQWMwcsEx
         fgYkvgImC9WEZQN5RUZd9NTmCHUQxSYYPm3162CR8SweMuqEhy25qGNDf4N4Lr+uPenW
         6yVUO98P6QELu74QwVdJJnSlEk/jYFL5lSUiFbEux9TNP3tn5TIwrguaAUl7K5NPRUv5
         3ofj/lR49F7cYP+Sm70cMMyXZESrqnY5TK3FTVPXJZYvliCNpANxCO7x9hERBxGEGy4t
         MYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313348; x=1698918148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HArSpqZPnriBVqM6a+6khhT78r6G789Qs/4LaODD6I=;
        b=aQvUyPeWtJccZDYVWnZO9iAsxT4F04bTpROWcipNCSQ35IV56FXJhlmFB3heCaMOm0
         xcRxuqlaf+DR8cGUex7XUxikRA1jxMYbLC/PbrGfD7vmYUqSldEt3pBdQ9HesKM+4Kch
         RRjSlPj5xOf1qX7aGooqmqhx4X8b9hlhuj+O5ic5kARnl3ciHMokykbQzPzxYvezgnvs
         z/Q6i8Mv+oCi9DsajXaqOwjuEc1VfBMO0ensZkws+Je1uhxw0zjepmjB9yFGKVyxVa3g
         gvjc1Vra6FActkubBjZ3UhdRDpYGg56jb1e8/1gSR+qGHdANcCQFh260Ptxiwx/6H/Hp
         r73g==
X-Gm-Message-State: AOJu0YxfTekIrD5MIJsqT0oAsqgZdP22fC85N77h9LaEohyl71ArgxzG
	91EYhYGNvQe+ek/waNiqC/y+/w==
X-Google-Smtp-Source: AGHT+IHA81hBBfFfihm+XPx+M9w6XCIHfa7NHg4Dr8s3r5hCxN2yfIsGFDpSflbONcfMlJ0pNOzekA==
X-Received: by 2002:a05:600c:5252:b0:407:8e68:4a5b with SMTP id fc18-20020a05600c525200b004078e684a5bmr15058391wmb.38.1698313347694;
        Thu, 26 Oct 2023 02:42:27 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c470d00b00407460234f9sm2082121wmo.21.2023.10.26.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:42:26 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	toke@kernel.org,
	toke@redhat.com,
	sdf@google.com,
	daniel@iogearbox.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next 1/2] netkit: remove explicit active/peer ptr initialization
Date: Thu, 26 Oct 2023 12:41:05 +0300
Message-Id: <20231026094106.1505892-2-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231026094106.1505892-1-razor@blackwall.org>
References: <20231026094106.1505892-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the explicit NULLing of active/peer pointers and rely on the
implicit one done at net device allocation.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 7e484f9fd3ae..5a0f86f38f09 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -371,8 +371,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->policy = default_peer;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
-	RCU_INIT_POINTER(nk->active, NULL);
-	RCU_INIT_POINTER(nk->peer, NULL);
 
 	err = register_netdevice(peer);
 	put_net(net);
@@ -398,8 +396,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->policy = default_prim;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
-	RCU_INIT_POINTER(nk->active, NULL);
-	RCU_INIT_POINTER(nk->peer, NULL);
 
 	err = register_netdevice(dev);
 	if (err < 0)
-- 
2.38.1


