Return-Path: <netdev+bounces-14464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83998741C85
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C931C2037D
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0CC2E7;
	Wed, 28 Jun 2023 23:38:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA626FCC
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:18 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAA132
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b801e6ce85so525905ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995496; x=1690587496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTv323NKbjUga4vVrrWj2aEc+VjUeYc3PKh3EJJ28LQ=;
        b=qRRBFWx5J119VW6gzDBckl5WweaoG2qTWGZ4rGgpwF1WENc7vVmz/9ljkfeXw0FGhc
         2f4A9wdGS4uB8zzWqFj5Kf1gDTxPaAo/5wyj3AckRLjjreSHtAZROPCZiQwOBxO5ZEno
         8GVC8x4n5BjWZx7Rwo6rAn7TaxUCsdEoXPYGSiEBNJ1xiQtWruj4dNMrsS+QvvdEeJ5D
         A9Pgo1ha1B8gsb3w204RGQ2I9Xt52pZyEbjikb2AXN2tVb7McVV4mjZnjyyTcUZFr2i/
         EpjsAgmSO76lk9CCqc7G3Vsk5579Y9NJ38RYBns88NS0oZRc44zTwYV/+vaJfct6a4E6
         9HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995496; x=1690587496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTv323NKbjUga4vVrrWj2aEc+VjUeYc3PKh3EJJ28LQ=;
        b=iKEMQp4NBaon5Lvyidvj7BJUnbK+rpwun3lS9Tl//Bk+ffoO1Ie2eokayDwwImCthz
         fqXpZ08bNydc0jtjbKVnaQvsOVrl4WPEzjR2/Kxo8n1wEs1AHPBbmmCj/ktuhxEjDYzp
         oyXL6LtepMSiJJPYVC1x2tGtz8WPrNZbv4GR7EGi+gmpKFXPNCZYVk8lAsxjT09vY/tD
         uSNXYdj3Oui8pBUyZUEd1utOSK/o6efbnsUq9gAF7OhIhUy0CmrimmWNJADuIkwod1lT
         STNA53lryglZJ93tSMbI5lgdYuT/vFIYLA8TWfQAZxRZNEBhIMEUXaxj5wiDB8yPDBSh
         O3TA==
X-Gm-Message-State: AC+VfDzT4UvoyhZqtxVcvvVSno9q7IQhBQ5Ljwym24GCfAYRlI6gxVQp
	Ul42wmscxSZOeXbEaxDe91sEtvnh+UcKKaJ3ghL7vQ==
X-Google-Smtp-Source: ACHHUZ4yoqqwUW/5nPmoRI6tdx812+pcWC436T8OUPUB9BqXhvCJjsL+LfdGhq8+SLy83bg2nwRijg==
X-Received: by 2002:a17:902:db07:b0:1b5:cd6:8246 with SMTP id m7-20020a170902db0700b001b50cd68246mr4078787plx.2.1687995496399;
        Wed, 28 Jun 2023 16:38:16 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/5] Warning fixes
Date: Wed, 28 Jun 2023 16:38:08 -0700
Message-Id: <20230628233813.6564-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Compiling iproute2 with -Wextra finds some possible confusing
things. Easy enough to fix.

Stephen Hemminger (5):
  dcb: fully initialize flag table
  fix fallthrough warnings
  ss: fix warning about empty if()
  ct: check for invalid proto
  ifstat: fix warning about conditional

 dcb/dcb_dcbx.c  | 16 ++++++++--------
 ip/xfrm_state.c |  1 +
 lib/utils.c     |  3 +--
 misc/ifstat.c   |  2 +-
 misc/ss.c       |  3 ++-
 tc/m_ct.c       |  4 +++-
 6 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.39.2


