Return-Path: <netdev+bounces-38512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9807BB481
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEB1C20AF5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30414AA2;
	Fri,  6 Oct 2023 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgdYjpOs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77813AF5;
	Fri,  6 Oct 2023 09:49:24 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D5BE;
	Fri,  6 Oct 2023 02:49:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c4456d595cso2193005ad.1;
        Fri, 06 Oct 2023 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696585761; x=1697190561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcVuk1f8Rs5HZdV+HtTaGfFlx6/6/V1qzP29WMfXLYU=;
        b=EgdYjpOs8lI2dRVccKFwy5oILOBE7vFnEJNHtDVYSu4yWuVqWIZb6BDdkJ5TZ+m1rT
         9qDDVZaBdYC95RezdsO/zCuqz46XpNzy7HD/C9prn/pEBNYCYzmBKN/tkSz4V5xJp00T
         hDKurYtJxPxcL3Isszc9RsgaqgKtZyn6WH+wCNQSTMbArmCKzYmJ4y6xWFr4+eS8+smA
         rWILJrA6SpaexVvzIubA+NxuaK1G2g1GRd9QjMQAL4JBaPIBNWpYx56haxZGb5iz6FEy
         8ldUfOjZskTS0SUWDaJTg9HPFuLkXcG3BPclsLo3sckc9qbbhcESkzcNe31ibVxwyeny
         bddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585761; x=1697190561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcVuk1f8Rs5HZdV+HtTaGfFlx6/6/V1qzP29WMfXLYU=;
        b=AK5MX/hOl7tC8ltT9jAu5yJIHJN45xefR/TnWFFXx7QDzvLxcdEZ5Xlq/CiHS5XU5I
         c/pnZPP8wOe0+2mggMVgf+zYvtxJcVFdqkXrtS7aks2fJweMzjoXL9aTv1hhVlRJTQgW
         +Scy8Uf6ia7GB/e0YXNLqjCgDw/8JEaODbTsxSeJPk3E4h8hFVucNfUCTUXz017LarCs
         1s98aQX5LLCGgrlVHOCFAX2ZXh28kiNweb3VnHV6H+vSXGxZAEm4WMa7uuPaKaNXEFec
         fvMbamAkc8L1Xu3+s3x/YoarttYudVN5qqrGyW+QK95e0J7aiKwAiGGoyynPdEbz6cTw
         SpEg==
X-Gm-Message-State: AOJu0Yxm20gUFMEqDBFZIYExaVTVGUXwNtzJZTf0zy0eZHVjB4Y61SQc
	KOSXFQiXlvLIHHs7IrpJ0yVB1Ler1AtVWAyH
X-Google-Smtp-Source: AGHT+IGdPm8G+cPXhplqRY6DFuMaLXhQYbjQ3kYMWpzEiqji8EfRiQkQ5VbHlhJD3DX24k60ND2BEw==
X-Received: by 2002:a17:902:f54e:b0:1bb:d7d4:e2b with SMTP id h14-20020a170902f54e00b001bbd7d40e2bmr8152503plf.0.1696585760918;
        Fri, 06 Oct 2023 02:49:20 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001c446f12973sm3362144plb.203.2023.10.06.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:49:20 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: [PATCH v2 2/3] MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
Date: Fri,  6 Oct 2023 18:49:10 +0900
Message-Id: <20231006094911.3305152-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 1a5b0bda2b05..006e601f9862 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7767,6 +7767,7 @@ F:	net/bridge/
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Russell King <linux@armlinux.org.uk>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -7796,6 +7797,7 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
+F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
-- 
2.34.1


