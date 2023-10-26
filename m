Return-Path: <netdev+bounces-44336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECEC7D7924
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCEF281E51
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2751864;
	Thu, 26 Oct 2023 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BefimYBQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4E19A;
	Thu, 26 Oct 2023 00:16:56 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4A181;
	Wed, 25 Oct 2023 17:16:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so61656b3a.1;
        Wed, 25 Oct 2023 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698279415; x=1698884215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aCApKkAfemYAVRb2Lkx8tiilCEFiJoHvdwsD7vdm8Y=;
        b=BefimYBQ0LP2mBm/KJV0YL9idSO4kmDg4lzlOdbYKwCZ2a1mZjhh2cY5D1QQUHr0Dt
         hEuWWQk4eyhW6VntL2r+0M/81Dh6WEes7VI57hH/zDN3lmlYtBECZ08WYf5HLDRk4bDQ
         vQ6doS+w51UTJrGetQ98gZSG3KBUMfQH42uaOZM6wN/YkInZFqwenVuGn0KsqjTllxHC
         pK3Tw9ui3E7WR2PAdw9wCK01idl3+oU8W0s5gJQX8rSov1iP8lhOwCsA7t3FsEf1j3G1
         IbRGk0RkVC2f+SizFSXoWBkdz5rSpgHdNGMtBH9J/oLTVYbtR9Urgxpg2zuV2TaaspeJ
         bfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698279415; x=1698884215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aCApKkAfemYAVRb2Lkx8tiilCEFiJoHvdwsD7vdm8Y=;
        b=HstASo0Cik55fzesfsNwMZd1iVL75OxK4ZiTi7KhJnCHxKNutLWArq+s3ggFuWNe2B
         BNT8dJc1/b/sBzaTM4w1M0RvrS382/CB/p3eRSplTGBXFzlTcbU4joMCDwwAB46OhpC6
         aLzsa5aJc28bPH/o8iy6miLipMTqbEH4potEm0J8uoxanBUIi7aFLb4/xknD3VrNH6lU
         ts+RR/1gda251eJ2Lwyg7/hvsgRIDcvd9hKgoWi7DNxrDG0vIDBf9skQazCQtL/mERLU
         SaI+V/u1eB7UEpNmTs/gaVmXeeNXz+yGA6NEjL5dWcfzh3SeXKXNc8bcsoIWBwo2hfUF
         ly7w==
X-Gm-Message-State: AOJu0YwZwQ3c0AKjmV/jtnIPYGD7L6P4DOSR+yz9RJuKyAcq6FUblAVV
	YPHKxaC7V2bNjf1wUCTbYOvVax0FrTJOz2xZ
X-Google-Smtp-Source: AGHT+IFS0jWmdaPOB+Q0REfvvuy3IMd2wYutDgciRDRnC74HHGruxvdWp0+MvWul4iHkmb3xvt3OUg==
X-Received: by 2002:a05:6a21:33a4:b0:163:c167:964a with SMTP id yy36-20020a056a2133a400b00163c167964amr20806787pzb.1.1698279415014;
        Wed, 25 Oct 2023 17:16:55 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006b341144ad0sm10407945pfb.102.2023.10.25.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:16:54 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com
Subject: [PATCH net-next v7 4/5] MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
Date: Thu, 26 Oct 2023 09:10:49 +0900
Message-Id: <20231026001050.1720612-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
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
index b2f53d5cae06..f0f0610defd6 100644
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


