Return-Path: <netdev+bounces-32965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89F79B159
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D85A1C20A67
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3837946F;
	Mon, 11 Sep 2023 23:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF69469
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 23:51:45 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9977739AF
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:16:42 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so3729347241.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694474096; x=1695078896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn+MK6bnJJjEn2d3sIhn20vw48SeDWPoiesSp2Jp2eM=;
        b=SbdxGbJv+RzWRx1RnuGM2UT1uLlBtwFzQXdU5KGI0vAiz/SB7XOfiz0qG00DG/EAmW
         ywOIgIk1GkN9gjCJZUEX1HLDuFMAW4mb70KdS4mLsokqSDNibPDKKNSr/HZgMQI6lYbA
         NMUAFZt5rO/zgE7nSq8+rYJ37aonJkrPDubJkRG+829vGfaTggorKkkEUlTU2qXGqYh4
         zH+7GGiJd6k6gLti4clF2UdTt4Azq+XDpt0SSFPFg1Ii9BnYaKEtz/L9pvpss/kFpxw2
         /sGhFSuTe/QBfKaxMuazzBiHfiLyPGgoggjNH9RPmb7zFXWbtf9d2AzoRtvmfJDtMe+5
         Rqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474096; x=1695078896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn+MK6bnJJjEn2d3sIhn20vw48SeDWPoiesSp2Jp2eM=;
        b=Akn3Art+dWOIpphpAK0SSphmsE+gtVAkTnsEtX1rhUSdJWdd4JdYuZuEQz/tSECq4u
         EwLA+qBQVr90sdeixnqi/osxbciAxnhqQOoz2lAJIzERz/u5fA+l+W/buGoguqUiD2K2
         9XxlX0CvlB2OeWU0DcwaxpV4ifC/U11fxgceCf5hHdLC03YHywEJr/iVfLovU9ocHKao
         NAAzu6yJfb3EtX6nkqLcxZ3tak+Wg2+bWxaz6HJKyIKroa9dgghJI4f/3Cz2TMZeYX53
         bbUs0SX0CJbKuUXBdusL38nRYY4Fd0ea857cSmEqm0nRLoIMo5TU4EvcoC8On5EIGH4S
         ujvQ==
X-Gm-Message-State: AOJu0Yx9DYpTA2gXcoggjKZDU3ngJ1slhLtpVe7ImYWyVlwEBweyQb3t
	2d5RjHPIYzkQ/hIqKrSZtOZE5xdnluB44aqOLAE=
X-Google-Smtp-Source: AGHT+IEnISmIa3nNQWL4buCUu26qmIsb/k4KRDNMzUbo/UV2U0dUDTBmx1Aef46LET7+sjTfrdoOVA==
X-Received: by 2002:a05:6808:7c7:b0:3a1:e792:a3fa with SMTP id f7-20020a05680807c700b003a1e792a3famr365141oij.27.1694469047670;
        Mon, 11 Sep 2023 14:50:47 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:accd:6e1c:69ae:3f11])
        by smtp.gmail.com with ESMTPSA id 3-20020a4a0603000000b0057635c1a4f2sm3776869ooj.25.2023.09.11.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:50:47 -0700 (PDT)
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
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 0/4] selftests/tc-testing: add tests covering classid
Date: Mon, 11 Sep 2023 18:50:12 -0300
Message-Id: <20230911215016.1096644-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patches 1-3 add missing tests covering classid behaviour on tdc for cls_fw,
cls_route and cls_fw. This behaviour was recently fixed by valis[0].

Patch 4 comes from the development done in the previous patches as it turns out
cls_route never returns meaningful errors.

[0] https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com/

v2->v3: https://lore.kernel.org/all/20230825155148.659895-1-pctammela@mojatatu.com/
   - Added changes that were left in the working tree (Jakub)
   - Fixed two typos in commit message titles
   - Added Victor tags

v1->v2: https://lore.kernel.org/all/20230818163544.351104-1-pctammela@mojatatu.com/
   - Drop u32 updates

Pedro Tammela (4):
  selftests/tc-testing: cls_fw: add tests for classid
  selftests/tc-testing: cls_route: add tests for classid
  selftests/tc-testing: cls_u32: add tests for classid
  net/sched: cls_route: make netlink errors meaningful

 net/sched/cls_route.c                         | 37 ++++++++------
 .../tc-testing/tc-tests/filters/fw.json       | 49 +++++++++++++++++++
 .../tc-testing/tc-tests/filters/route.json    | 25 ++++++++++
 .../tc-testing/tc-tests/filters/u32.json      | 25 ++++++++++
 4 files changed, 120 insertions(+), 16 deletions(-)

-- 
2.39.2


