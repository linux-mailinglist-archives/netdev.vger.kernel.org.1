Return-Path: <netdev+bounces-43698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A87D4467
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1F1C20B13
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D3524C;
	Tue, 24 Oct 2023 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr0CLVHO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE067E;
	Tue, 24 Oct 2023 01:01:50 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCEADA;
	Mon, 23 Oct 2023 18:01:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso773931b3a.1;
        Mon, 23 Oct 2023 18:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109309; x=1698714109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3NQ3hlx6NeVFLgKv8hcTzHlqiQAXY3sgd4Yxhx378w=;
        b=Mr0CLVHOlEAWPU29Wi7A7DYCizHQUA87C8ZDH6A7Yps8apwKgKLp0apm1/0yUByS44
         O+FSOyoSu7O3LIKHLD3tJf2nrWl3RkPR3/2+lqzCFMmjS0Zq5h56X6Zpjh+KDFTX0PfN
         3LOkWnMX0qdAhYI2m4t7TAxzIlTrekqW8vUv2AHwMTBdscP2kxmrRgA1oYLK1RydIJ/7
         tikwY0Z0g1ZEl6ypBERNsYX3qBrRX3KqS5HxjtnOUlqsNRQpkX0W0I+EhFlpcbfj0H7N
         9Ffoi7n3MNe7AQTLzHatgH5HwBihuTOxgxumriA+1p9QOwjFWK/5/m7AiBekifv2P2A7
         pPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109309; x=1698714109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3NQ3hlx6NeVFLgKv8hcTzHlqiQAXY3sgd4Yxhx378w=;
        b=Q5NV4BNTkjSEfzP56DdUO0S93U1SVC9L3S3EL5laoWK0HkWlOHG6UPpQX98peWJsya
         nbC9PwM3wpn/73UeW+Mo4PE8QPs1JxOh33Q3QPWT9WajGVkUMvYKwzYW1Xd60bBX2+uf
         ghxjzfONiCHVKuYttdxzYHLDWSh1cs2I/63B1CZ7YnOdW67i3aKcmXqg1DcL+ZUSVxif
         CNjb5YPMNwebEqkR4V1xwdLwgSLF4EYozwWvMwBi5J2sP7ZnbYCx2a+YQu5Ny6M2tWp5
         J5l8L2kSIHmW14s2ia5v5OjTcfv2qb/c9hZRupE1aoxzTOK4nR7343lEU3eSSJD2pTH6
         hqwQ==
X-Gm-Message-State: AOJu0YwLWd9D2fT68KZiZFAofV+euKJZw5ZyiMJ+ZJYcm1pTaX9SXM+i
	+zM96F8LWCYZOthwtCk7FTGuCHuKUh2E8w==
X-Google-Smtp-Source: AGHT+IFII9V6QCCPax01FETjnFkFf/cp1gNksKG05HyIBJigkFB9DKQ6tNu8EYbvVxJBvw5GJLaR4Q==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id fj10-20020a056a003a0a00b00690d0d46fb0mr10880519pfb.3.1698109308703;
        Mon, 23 Oct 2023 18:01:48 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006be077531aesm6707888pfi.220.2023.10.23.18.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:01:48 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	greg@kroah.com
Subject: [PATCH net-next v6 4/5] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Tue, 24 Oct 2023 09:58:41 +0900
Message-Id: <20231024005842.1059620-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds me as a maintainer and Trevor as a reviewer.

The files are placed at rust/kernel/ directory for now but the files
are likely to be moved to net/ directory once a new Rust build system
is implemented.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36815d2feb33..568b99d34533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7818,6 +7818,14 @@ F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
 
+ETHERNET PHY LIBRARY [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Trevor Gross <tmgross@umich.edu>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/net/phy.rs
+
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
 R:	Kees Cook <keescook@chromium.org>
-- 
2.34.1


