Return-Path: <netdev+bounces-32960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC279AC0B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0021C20503
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828808C1E;
	Mon, 11 Sep 2023 22:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9028F9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:41:27 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984019056
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:31:52 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so3710952241.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694471410; x=1695076210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn+MK6bnJJjEn2d3sIhn20vw48SeDWPoiesSp2Jp2eM=;
        b=3RCiUe6B5I/avEMhiopetMzvVNJexaDjd7vWWeuozz4tere/6WQYhET3oRauOBmc7m
         gU6p3BGKMWRPT1LWh2jmPzvEkbMNpRFmFNTAvdxfLgIz59piBH79LWeOfPux2pVKn7Tn
         BnTUB+bSCkrIRG3sPZmEgQmrZqmch1sDg9gzzYFoD8r8lZItGJhYHTzUOfHiDnyZBZkQ
         j8N8rUzm5CE3SqdmeFE7QYHnuB0xX8QhS0tLDW7pl9ZY+k2GkYU54mlK7dBJg4lYl8/j
         VF2JXrcLPOiLjwgsh2MCuaBHCCiQkfZ0S9pVoclxXY7AGMZsRxidgXIi3Fa4+QR3kUG4
         UVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694471410; x=1695076210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn+MK6bnJJjEn2d3sIhn20vw48SeDWPoiesSp2Jp2eM=;
        b=BOEOpf12l8xNBG1+SwOkb3xn/hykn4FZIKWAZJ1rWcjpt7uK2ygNHQ0UOrpTQVnjak
         hnZH4+b5+loTDccNVqBoVvJeb8AsoSclffUEkbvRmf+Vao/s/i1/VylWt+21S6yDmc+C
         tWV3kTxSW8Rj+rva2lNBvI5KydAXDScwooiiKGIeZ9d7uVJAgnoBeWqHRoPP3dK1h5Hs
         U3Kq4s7kU4W3JPA65OiYJdoULjJrNP05dGHec6tkgsN9iHNY76aKuAITL8SETIxQdPpA
         aXxUdiYhog/x0YBuPuSmCjWOUHRuM1dBjwlg+qZdECKO6PrKOQLqwp3r8zJKP2C0o/cg
         stSg==
X-Gm-Message-State: AOJu0YybnavaDflwjkPR5+cnsexlwb1AgJDt6JjLUP51LO5BrmZTAfAj
	tqxG1msN4Sv0qnW908PdkcOTCZ1Qz3mxEhmVqcA=
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


