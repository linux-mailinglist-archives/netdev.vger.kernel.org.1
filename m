Return-Path: <netdev+bounces-41894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F907CC1C5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAAE1C20C39
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140541E37;
	Tue, 17 Oct 2023 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS2ARWOl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042841AB0;
	Tue, 17 Oct 2023 11:30:27 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDFF1;
	Tue, 17 Oct 2023 04:30:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d1433c4ebso1134608a91.0;
        Tue, 17 Oct 2023 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542226; x=1698147026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpFPu0iSHmMUfFdOgy7yC5NRv4NQanN4znwfQNtiQgk=;
        b=JS2ARWOlTzirYnPiX+n8vbC7f3roxV+Z5b0NPdrNDbeV2CeKc2Y1C1ATIuSqlGPr6T
         UY6gLrEee2cYxJwtibD7EPRQk6UJ4/rtjn89c/yttyOPmOCLMY+hYbWFn/h4Tq86pBsg
         zVcCCEzuXEkkPV3xc0S6qSGSzHbY+w5uUDcJUrN9auNbb4MqO9RykLW6KEn7Yf3ourqw
         VnDq6Gl2jxPw5wo7sd++GQovZ7bFPTB56Kx9aOMhlA4hSfT/atIPjHfiu9+i+sXAhaB6
         2vLzOjs1PANN2ETRL1PN5LxYUHJ37YNdQTrrMZV2Xg686vMP9XeoOzKj2+4tS4BxvCo+
         2Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542226; x=1698147026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpFPu0iSHmMUfFdOgy7yC5NRv4NQanN4znwfQNtiQgk=;
        b=RlwIribE+BdpzyArkSZZmvkYSdl6NaMsrhv9kkICttM+noI6LUrc9hRRXt27YwM4rE
         CXBXL6K+aWWtHs9VGNIrNvuIFWqKOA2uIyLyjiU1M1AR9kVD26LWxhLzNUt44OB0p4dh
         ygUUUjk86aQM+hoO8/w3rn66cY5dbA3WTCJKTIuTLgX8J+w70hQ/qvhrJboaDXHNv0mv
         KakxUNqi9HCA09GQDmzUY2RkEWA1KBtpkF8FWBJPQaUPLqNIH7BF4VlV33XGN0T0hpwD
         D4/wGXpLOgekpfBFYxJwvhapvcearR3WDr2BOtrDS8axbdQS8FUbgvK2HVPwDod+YuB6
         0kLA==
X-Gm-Message-State: AOJu0YxYdGUa3NISag4hhiczi/K1kVMvGbyuGFcpVVzvNK2zyyh5Nq+N
	T9m6iMZEYRndifjE4yxkJeut2/waKwdF7dc/
X-Google-Smtp-Source: AGHT+IGPyXFHzdZXrZaVdwdT206TaWRHCpQNSSreIFV+sQWTXAYJZ/+A3q0OZazd/xf2jI+4Ugz7tQ==
X-Received: by 2002:a17:90b:4b04:b0:27c:fd8d:164a with SMTP id lx4-20020a17090b4b0400b0027cfd8d164amr2002904pjb.1.1697542225715;
        Tue, 17 Oct 2023 04:30:25 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b002635db431a0sm1116277pju.45.2023.10.17.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:30:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v5 4/5] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Tue, 17 Oct 2023 20:30:13 +0900
Message-Id: <20231017113014.3492773-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
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

Adds me as a maintainer and Trevor as a reviewer.

The files are placed at rust/kernel/ directory for now but the files
are likely to be moved to net/ directory once a new Rust build system
is implemented.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed33b9df8b3d..e85651c35cb9 100644
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


