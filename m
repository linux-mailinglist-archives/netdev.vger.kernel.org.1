Return-Path: <netdev+bounces-39492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46247BF782
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905D5281FB7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1817734;
	Tue, 10 Oct 2023 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40417750
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:38:27 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E7B8;
	Tue, 10 Oct 2023 02:38:25 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9b95622c620so992068666b.0;
        Tue, 10 Oct 2023 02:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930704; x=1697535504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1QRKkBNjznWASHX/P+4TGpYOnsgJ03ZF7D0qhU3Ymk=;
        b=plJUJYze8Ih4iB48eMtqqe4my0y81wE5SEl4pF1dkXVJavmbK0ltMypXu0wW9//2Ix
         2/RjxF0QTb7hjaRIcCeILvEBAfV/dAgr9tKEIZgSWuNbaHsn18JbP8lZaJ1K0kw6Tfs6
         9rAFSTbbk2S1T7Lr2PF/6t61yTyBRADKPJDNp6SUsf4eduOgE5ZecBbv2kLjIkmJqBzH
         5y/CtmU9NnLAQ/jhZHXt/zxt9K9qmRNpsMvwV1OCVnxsY29Fw5V8iSMIRtC4rwJOzHzW
         Mr2SVSYEVli6KtRtVJQj3nV4BrqINod4Bz82bLmRz0Kqyt9SiwQMO5AEF2ESdMAYl0hC
         1rSw==
X-Gm-Message-State: AOJu0Yz1MqY//ZZr8WpfZABb1VrEDaMUwzmOWXQPv5v/xM3PJpnuFtQW
	LY80TVumlIBik8zyRuejhrI=
X-Google-Smtp-Source: AGHT+IFxRq/KbS+SGcIHLC7lal1Yfk5k7Q0MeGQRouF0Zb3IAP2QclWw80a3UunY6/3pJJTMrUhwQw==
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id o14-20020a170906768e00b009b2f38dc44bmr15198573ejm.24.1696930704086;
        Tue, 10 Oct 2023 02:38:24 -0700 (PDT)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090640cb00b00977eec7b7e8sm8193626ejk.68.2023.10.10.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:38:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jlbec@evilplan.org,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hch@lst.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH net-next v3 4/4] Documentation: netconsole: add support for cmdline targets
Date: Tue, 10 Oct 2023 02:37:51 -0700
Message-Id: <20231010093751.3878229-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010093751.3878229-1-leitao@debian.org>
References: <20231010093751.3878229-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the previous patches, there is no more limitation at modifying the
targets created at boot time (or module load time).

Document the way on how to create the configfs directories to be able to
modify these netconsole targets.

The design discussion about this topic could be found at:
https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 7a9de0568e84..390730a74332 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -99,9 +99,6 @@ Dynamic reconfiguration:
 Dynamic reconfigurability is a useful addition to netconsole that enables
 remote logging targets to be dynamically added, removed, or have their
 parameters reconfigured at runtime from a configfs-based userspace interface.
-[ Note that the parameters of netconsole targets that were specified/created
-from the boot/module option are not exposed via this interface, and hence
-cannot be modified dynamically. ]
 
 To include this feature, select CONFIG_NETCONSOLE_DYNAMIC when building the
 netconsole module (or kernel, if netconsole is built-in).
@@ -155,6 +152,25 @@ You can also update the local interface dynamically. This is especially
 useful if you want to use interfaces that have newly come up (and may not
 have existed when netconsole was loaded / initialized).
 
+Netconsole targets defined at boot time (or module load time) with the
+`netconsole=` param are assigned the name `cmdline<index>`.  For example, the
+first target in the parameter is named `cmdline0`.  You can control and modify
+these targets by creating configfs directories with the matching name.
+
+Let's suppose you have two netconsole targets defined at boot time::
+
+ netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc;4444@10.0.0.1/eth1,9353@10.0.0.3/12:34:56:78:9a:bc
+
+You can modify these targets in runtime by creating the following targets::
+
+ mkdir cmdline0
+ cat cmdline0/remote_ip
+ 10.0.0.2
+
+ mkdir cmdline1
+ cat cmdline1/remote_ip
+ 10.0.0.3
+
 Extended console:
 =================
 
-- 
2.34.1


