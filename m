Return-Path: <netdev+bounces-47757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC97EB463
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91841F24469
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7300441778;
	Tue, 14 Nov 2023 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IF8O+Xey"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72464174B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:05:34 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD34512C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc1e1e74beso52008425ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699977932; x=1700582732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88i4+bZZ4hNVQr6NaurDRNaG8ftMfwTovzqK47BhxUo=;
        b=IF8O+Xeyk2U0Wz5mTAnV1BKEB5xAbapD1O8UffY+G8k2zCSc9uZnGN4fpde67Bg8tH
         Ub1G1bLgn+4BliolPKO17fBPac1eL1NvwU+SupMZ5JreUOGU9NT0pSkQfNXOdq0/+EPD
         gbBk3e7HWLnpIwG2thUmf8PwyEti6zAdenNYVebmHVFeKxXxKqGMxDUHOs457ZI8ToS1
         Z+5glBLSGZ4j7nct9s/lpGxJyDZPk0fe2d1BDeovVmdVpvBS5TzTHj0i+6YVOUSUD0vg
         l0UEBLqrgZmT764fCbcXkp2E4inmjdDG6Sl78mZ03bLpzpaUvn1Brnpd8ssdUlVpRyFK
         zekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977932; x=1700582732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88i4+bZZ4hNVQr6NaurDRNaG8ftMfwTovzqK47BhxUo=;
        b=Xsq0h+VxSAK1HyfAwt/40RD6EnffflDe4s+olBSd7kIjSg0wKzgC/F+yJXd8bHGkM0
         c+hwHF/CfLP+Be/r49oQ4v455obw19lBSY5KKTYdceBdX2OlWurCozk3MZVO0jEThKP2
         grfqtaVBRV7W02aww8UcUDeEcQOGvSaDsz1GYFWfjSnaA9o+7VqHLSHkK5cMIMrJri4T
         9Azq2F5yIpxmSAl7rPPCwOaFC0EgcErIvmQBLsRP1wU+2yDvoEQmy+7f5oBYK7/GUNP8
         Fl5rclUlD0Jyy/nPx5wVmExEhulR6qMUPDmylsCge+c/ny/dKKTqntNOqxxIMQ5LVma9
         qkwQ==
X-Gm-Message-State: AOJu0Yy/DRIvAPvS0Vi+kgOJ2XsQtBwTXl7MMseBQRnaCg5sGgod9D4x
	FIcZLpLcUdPLRavQ9GkKSBEc6Ukm43RJpEiaS+0=
X-Google-Smtp-Source: AGHT+IFCYGqSKMcTdIOv5Dy1JcOFVjYUa/YG1pIbsllJR4DsuB5nOUNiP7MUdjWR2+NlClF4YjITeg==
X-Received: by 2002:a17:902:d490:b0:1c9:c0fa:dfb7 with SMTP id c16-20020a170902d49000b001c9c0fadfb7mr2855727plg.57.1699977932041;
        Tue, 14 Nov 2023 08:05:32 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:fa3f:3165:385:80b3])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm5833048plg.87.2023.11.14.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:31 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 0/4] selftests: tc-testing: updates to tdc
Date: Tue, 14 Nov 2023 13:04:38 -0300
Message-Id: <20231114160442.1023815-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Patch 1 removes an obscure feature from tdc
- Patch 2 reworks the namespace and devices setup giving a nice speed
boost
- Patch 3 preloads all tc modules when running kselftests
- Patch 4 turns on parallel testing in kselftests

Pedro Tammela (4):
  selftests: tc-testing: drop '-N' argument from nsPlugin
  selftests: tc-testing: rework namespaces and devices setup
  selftests: tc-testing: preload all modules in kselftests
  selftests: tc-testing: use parallel tdc in kselftests

 .../tc-testing/plugin-lib/nsPlugin.py         | 112 +++++++++---------
 tools/testing/selftests/tc-testing/tdc.sh     |  69 ++++++++++-
 2 files changed, 124 insertions(+), 57 deletions(-)

-- 
2.40.1


