Return-Path: <netdev+bounces-40689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2D7C8569
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD71C20FED
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D214295;
	Fri, 13 Oct 2023 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VPIi5OzO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0915E94
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:44 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD63A9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so1812934f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199042; x=1697803842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKelGZo5ZvUTtY9mTp2kwHMa1UEMD5quN0mc49nRyJ8=;
        b=VPIi5OzOHCuePJmyE4ogusuXmomRecn3UQHEyWBU8h+3MzvxujjrjnPhpSmaFuaKJh
         rRY0xtmJj+yU49h2Jtt/DLZfcOZ0Q5aJcFDbsy0Kwy6+hRLoZBEsO0kzmhLjDv8CPa02
         IGRe1x21KP8W24SV/5PzyuD1CZ5czoaYKGztsdqQb+GP9XKeoyteW++qYAJjvfUDqL3B
         FpjSB4HYdSBYfRvaBBUDdn+X51DaZuN9JbWrXZsBMoBv4tjG0d2P1Q/8R/lxXJHVIoVQ
         GbCZG7lmU1L8cVP+o/e943AXaOaD84RlQyE7yR2fTypXBUkx6rEqYn+ISNMhwvNLUti9
         DTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199042; x=1697803842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKelGZo5ZvUTtY9mTp2kwHMa1UEMD5quN0mc49nRyJ8=;
        b=afGzt+HeRl+nuEN4YPIT2uFYbZke06I0l7/lbD2xZ4p0ZurTDi43DV2qgYDOjL9POZ
         O+3pqG/GLTwP3wUz1LIW1ImabaK7w13laeqxd/TuGSc1fBoeFMzxq5T+dEOXRJnlBN2J
         jMoa4WMc9f50MVLEqmYzx2eeC6CKjsS1lwq7xAa34m8Lz+jI5er5UKtF7IwwMUy58C6S
         4doTY3R5fePeGvSo7cGxGfUpbrkRqUaOmRXbxIcrC1dO/P0zIZ1ipyP79ESCNQKVQexy
         JUMGcogGTqp053QJZD/LjzX/ItmSpkzr7e+jIKaSd24pxCnjAT82bk24XDb+T7PURNZB
         OqWQ==
X-Gm-Message-State: AOJu0Yx2L1RkWtO6m4B858e9zUakOQ0Shv7h7V7LRVh04cq1uHF7wTWp
	k+exax8usWWenOcsdCJP3+dTY0cBubFeH25Mtq4=
X-Google-Smtp-Source: AGHT+IEYDfCljcpgNJME/JRd4YepC03f2PxHM2OtlvjE1kPACgmdOerU8S84GFsUUK1ZASJZv+8eZA==
X-Received: by 2002:a5d:4fd1:0:b0:32d:9a2b:4f83 with SMTP id h17-20020a5d4fd1000000b0032d9a2b4f83mr1471651wrw.33.1697199041838;
        Fri, 13 Oct 2023 05:10:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm20863076wrm.66.2023.10.13.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 6/7] Documentation: devlink: add a note about RTNL lock into locking section
Date: Fri, 13 Oct 2023 14:10:28 +0200
Message-ID: <20231013121029.353351-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Add a note describing the locking order of taking RTNL lock with devlink
instance lock.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 Documentation/networking/devlink/index.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 52e52a1b603d..2884ad243b54 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -18,6 +18,10 @@ netlink commands.
 
 Drivers are encouraged to use the devlink instance lock for their own needs.
 
+Drivers need to be cautious when taking devlink instance lock and
+taking RTNL lock at the same time. Devlink instance lock needs to be taken
+first, only after that RTNL lock could be taken.
+
 Nested instances
 ----------------
 
-- 
2.41.0


