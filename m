Return-Path: <netdev+bounces-38933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F47BD1D2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A301C20B00
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E017FA;
	Mon,  9 Oct 2023 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRbCdFvR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669ED1115;
	Mon,  9 Oct 2023 01:41:31 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B5AB;
	Sun,  8 Oct 2023 18:41:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6a4ff9d7e86so78078b3a.0;
        Sun, 08 Oct 2023 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696815689; x=1697420489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssN3DBbtFHbHJgP+Y9gvklyTIvoLYgAPD44iIoi2tPo=;
        b=TRbCdFvRLVq8nz4a1+Zm8jsQCKd3bUkcWaDH0nWjl2suC/j7TNTFcHXscoSsq92nQC
         q0Bie/qHZA9q7PDO0ujcIM1Hq9Gr0g24MSLpYWe2rxpufK9f4JhkLuIeXfKiW87yVjgE
         6/u1+9VE8zU+C6irjC4BxS6UydTWCBQqPIg5PdG9jWzpcaTnNj4gzHK4pj+89TngI44Z
         uA2cO330Iyw+0csQXQnin5mTkugfmq49vg3AkxL8cWkZZlXN/hBrVFOIeawA+dpJmItv
         KWN45Vj6wq/YA3QdWwBGWPkf1JPcNCjBZeHBCYkG+7D53Fhkq+mLv4N6AD0Jo8rIbEHp
         s4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696815689; x=1697420489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssN3DBbtFHbHJgP+Y9gvklyTIvoLYgAPD44iIoi2tPo=;
        b=eUQA/vDNxJkHa5rMFP3BZKLInFtD/Aa/dLxq3YHf/QmMBoJNUHnXTlXcWEUEuyodCi
         86kRjQmd5KVLkwiNeXscmGiSA0zsGnFrlr6iYiu233spa3j3lcbswuSPMEH+AK1+cvOH
         +c0cd2YTQF69hU5qPf4/8bVSrlmAZPxDy/e5AHvPkfcNwFm4vr+QDIUrhfu7qZ5Q3zkQ
         Hn3QUgJ8zcIQL3iOY3TDlYIzwv+6u+DA9XtoiWoT8COQbq2IBvSYDwaSexfG0DWI9+zS
         qDyY8e3J0Ccjh8TC4suetH48UfS0s8VASB65IoCppe6sXDeIi7ivjpZnIrxM8SAg+3nu
         gJnA==
X-Gm-Message-State: AOJu0YwPQdIirhkMSsYuD7HbP3uz2Ti/EhhT25ItPsT1bakDrt1q3ZD/
	w/C38CCk1Yx/jJ9YzBvRwM6kCtZtjClRBlrm
X-Google-Smtp-Source: AGHT+IHHc0zVU6u2wxk5LgbH9YSmZ0EzanO3Pm31t/SL4NLqVKDWwC6lW8AnH5Phz08u//NSNKumjA==
X-Received: by 2002:a05:6a20:c18f:b0:16e:26fd:7c02 with SMTP id bg15-20020a056a20c18f00b0016e26fd7c02mr5029006pzb.2.1696815689033;
        Sun, 08 Oct 2023 18:41:29 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b0068fb8e18971sm5132917pfh.130.2023.10.08.18.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:41:28 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com,
	tmgross@umich.edu
Subject: [PATCH net-next v3 2/3] MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
Date: Mon,  9 Oct 2023 10:39:11 +0900
Message-Id: <20231009013912.4048593-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
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
index 1bd96045beb8..b6d7e4de6438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7771,6 +7771,7 @@ F:	net/bridge/
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Russell King <linux@armlinux.org.uk>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -7800,6 +7801,7 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
+F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
-- 
2.34.1


