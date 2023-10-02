Return-Path: <netdev+bounces-37348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66FC7B4E21
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B37EF28380E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA386AAB;
	Mon,  2 Oct 2023 08:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8910A03;
	Mon,  2 Oct 2023 08:53:26 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602CC4;
	Mon,  2 Oct 2023 01:53:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27755cfa666so2524719a91.0;
        Mon, 02 Oct 2023 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696236802; x=1696841602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghi16J3BrlW4TPN3K2aA+Kf8CE+MxHSqfJ06TEv+IsM=;
        b=QS1kSdHZR0Q3uUUGQZ/dSCrG/BKNXhXYaoG4yKDhrpfXTSU+/5/lN5KyoY9IhH4mEO
         db5U0WAeMQLZEQ+8L+I1LTX0h/R0cvAgr5n1ijrsX/1JAY6yoO6D5mJoQWs43aIqpUXC
         Xwcd5XQlV68Z0DlKH2TBUxjHwaXC3Fd8o+i9Ht9qkSmBxiiYViROK81nEoh/plbGSDhg
         VUn8uKw/e4wNChaiD0wYDh0jLSe74KPrjEAJDQpRRTLNA09xr+9f2RQ5iWBjwZJ3YL9Z
         kSGVlzG8hiPTI56fgS31BBgD5vqghLXqR6LjPXmSnRhIrh4zs+erdTsGLcbDRwDaemIM
         18Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696236802; x=1696841602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghi16J3BrlW4TPN3K2aA+Kf8CE+MxHSqfJ06TEv+IsM=;
        b=aCqqpeIGl3/ObxH15kkygELdkMJWO8hTFtycsANb2iZFTULVl/2GF+Mm3TWQWvsQRD
         FcQ3spFtl5YCiWCx7iZUO7C0RUjOqKbacs5fjZAsP+xuTCWJCCM9CTbwlq0jD6sxWd0V
         ta5rKDQDdA3dgiF1OHwIbPJG8PHZVcoTQn0sTgJ1xZ/llt2PWm1RERe47tTFMBwQoL66
         oiMH09Q9xm1du9zISBjuT/e/wfHnZIPNrGLMC/VTC7y+00fvpYURVxKVNMA9h4LZCvGq
         vawmrExbU6wARuThinhKvKdDixbPZa60NNHOoVOntYqXFHMUevOJrZmPph5sShnu2npO
         yyWw==
X-Gm-Message-State: AOJu0Yzg4NLR75jZa5hmQc+TGHb+6yCYC3tnrtLad2Ti1FY631C8jK4o
	Mmm61fpPr7D+EMyyJJAeeyvZnEXHcHa+pL0b
X-Google-Smtp-Source: AGHT+IFWhAEUbi33oY1R/nR+YTwZPNXxfja/QRsuuFctXQ1O5+C6gEl0f0EqsedyO+3brGLywe6hhw==
X-Received: by 2002:a17:90a:3d0a:b0:26b:5fad:e71c with SMTP id h10-20020a17090a3d0a00b0026b5fade71cmr9567135pjc.2.1696236801879;
        Mon, 02 Oct 2023 01:53:21 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00274c541ac9esm5656270pju.48.2023.10.02.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:53:21 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: [PATCH v1 2/3] MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
Date: Mon,  2 Oct 2023 17:53:01 +0900
Message-Id: <20231002085302.2274260-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adds me as a maintainer for these Rust bindings too.

The files are placed at rust/kernel/ directory for now but the files
are likely to be moved to net/ directory once a new Rust build system
is implemented.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..20e0ccd4fcaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7768,6 +7768,7 @@ F:	net/bridge/
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Russell King <linux@armlinux.org.uk>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -7797,6 +7798,7 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
+F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
-- 
2.34.1


