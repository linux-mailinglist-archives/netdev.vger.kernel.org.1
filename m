Return-Path: <netdev+bounces-41965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A657CC75B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D0DB20ED1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250C4448F;
	Tue, 17 Oct 2023 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="beCl1Rne"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B742BEB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:23:22 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B2E8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso2436600a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697556201; x=1698161001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQUZ1Oux7yFRdylo+HyTFuYNIiqwwSIaDIIPWqodHmY=;
        b=beCl1RnebSmgUVGjE/5kIVeYdK7iPzFOU62JVU5BIm+bA7YVkK3TAud1Gwq6KcRQFW
         ODHtI2pOkoN5JSzRE/2AGEaF7j5ONZ+u02Y3H3v6BeXv5oJUkmt0cS7mzkaO/DQKUxl9
         PqLT8fOVgErhCFNr9D4/JShBD3LMlcrc6VG0EmW72k0sxqIUGHjClPWnDY2QQ+IxwBkK
         KCkWE639oftZTajLvU+ye1ThxGfCuXRmSRNyVnopH3Rne8n5bUpYkI+AQmuvxOxlSDbz
         LN/3UqmnWBi65foaN1ow18Mb6xJ0FUFLelaNT7DT/DKHM9orhNXsG/PUY3+1fGg26nJk
         kDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556201; x=1698161001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQUZ1Oux7yFRdylo+HyTFuYNIiqwwSIaDIIPWqodHmY=;
        b=miLncpqtX4/7/wgOPUBd+tuPzutbSlddeknvrq2oUgTEBRJQqpTISM3iKFa3aQ4O6g
         x2s8E4To/CpQ9sbi83E8cSJKC39c2m33Rur1wLjJ2YX40udYIjY+LdxLmcrOIGJBL4Ju
         jBRHKym7ucedrS7P1qbvbuOIEbe4tSWq7HMxkxwde1m/Sv8GIsPgu9xiWSiK5vaja5fz
         uv3UZondp4mHbBIEy+tP3/smXrA8ZYTtejYG4xkXioxJ2/UhnhCP1/vOthf7Ejk/U+X0
         ZNKP8zckMx8bkLsot/vt6A/p78lnGbfeYuGFJPuEk2o5y4VuPs4pXbE5RmtnbG9S9S7l
         nmBA==
X-Gm-Message-State: AOJu0YzKxfHDrHfJzJmWxabsYC6lxICd97Dt4P+rSQuU4zQ24+tXHtG3
	REp4CoGwB2D4zcyP8VDLMysCwi+TNbIy1gIWWkCVag==
X-Google-Smtp-Source: AGHT+IEgNADhtFK4rjwdC0EkZ1hXw3y7NFXPgaRWHUkSmsLf14LF46iUmY79wsQbE8qVXv6CTviUbg==
X-Received: by 2002:a17:90a:1a45:b0:268:2658:3b01 with SMTP id 5-20020a17090a1a4500b0026826583b01mr2461432pjl.39.1697556200950;
        Tue, 17 Oct 2023 08:23:20 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:8ef5:7647:6178:de4e])
        by smtp.gmail.com with ESMTPSA id u191-20020a6385c8000000b005b6f075da0dsm8749pgd.25.2023.10.17.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:23:19 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/2] selftests: tc-testing: fixes for kselftest
Date: Tue, 17 Oct 2023 12:23:07 -0300
Message-Id: <20231017152309.3196320-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
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

While playing around with TuxSuite, we noticed a couple of things were
broken for strict CI/automated builds. We had a script that didn't make into
the kselftest tarball and a couple of missing Kconfig knobs in our
minimal config.

Pedro Tammela (2):
  selftests: tc-testing: add missing Kconfig options to 'config'
  selftests: tc-testing: move auxiliary scripts to a dedicated folder

 tools/testing/selftests/tc-testing/Makefile              | 2 +-
 tools/testing/selftests/tc-testing/config                | 9 +++++++++
 .../tc-testing/{ => scripts}/taprio_wait_for_admin.sh    | 0
 .../selftests/tc-testing/tc-tests/qdiscs/taprio.json     | 8 ++++----
 4 files changed, 14 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/tc-testing/{ => scripts}/taprio_wait_for_admin.sh (100%)

-- 
2.39.2


