Return-Path: <netdev+bounces-28738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99370780723
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDB28230E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F21774A;
	Fri, 18 Aug 2023 08:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BAEAD3
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:29:14 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BB3A96
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso4906505ad.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347353; x=1692952153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggYbNw0RaH6UOe9CO/dwkagjlEQLCdgNfmYAuc/2Q/M=;
        b=JGOCM5r++iDaw0erpwf+xIOQSgKXtK2jCAnFmamPGmo9gdUgPNuArbKCAYWMytzSWt
         5VzqIB1KDJPRGIRgeYm5qh4TbHEpdUznkyLrXSpDeSAwM0o40DyAXVsgvgfClkWz7PFc
         eyWPMmsPTtXI3IbJvBlGnCC3Q8yPnMxWDdb15uWuqZqgN2r4nmWJ/P1Ged+h2jFbDoM+
         2rZeNE5yry5gbglgY1ygg5gR0KhvQSM2t9/UFyiRl1diVZhPjCT6MxJfHtQmLvKK/mt2
         j+tY0FhqMl0oZfGbRbxxhoJ8F0Oaxi+87rY7mWLaYTzKkLf3sZO+vxavGcZcfSHrcm+x
         yQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347353; x=1692952153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggYbNw0RaH6UOe9CO/dwkagjlEQLCdgNfmYAuc/2Q/M=;
        b=LpW84rJBF4i2qWBgHA70yb8yrXFN33ijwic6ZdFizXOA1FT4yIL9h8ukVS6pC40dF1
         KiXE7+OrNGZy1dQB9XclvOLGie2FzjxvfGsGJvsgLBbTiomruArV9ww/5Iq6vAN+VN+9
         5S+JMfIedsbmFbLKnvSq+UQRYJRJfR57rn5D4PGUVLD+sGAL8Pd/jF+dymROJKtiGIbD
         3qE0TnuKSXgsQaIVvNLjur3yBgcnHqJGCchEI507WJgo6XTOMcmhOoQ5Unmi6ZjHExHx
         nHHHdCZgc+dVX3G/JtUXMM4PTQxc0AG+ia4Gxgsv4X+vRY3Mnm96lkq1TOcXHfJlE2TB
         +2Rw==
X-Gm-Message-State: AOJu0YzUbVomd78Pukqtx54+Tfjob+xiJe6PHttvpx7Yq+SU6B4CMIt9
	5hgammPp8VhYBGXziCtKRtJH4LSDOz8G7h2G
X-Google-Smtp-Source: AGHT+IGVQpR0KSZpEzAPft8estxw8VPVHtNeVtcp8/LNqleQpPklWXrvM1vWttV6XqljXX2CYbM0Kw==
X-Received: by 2002:a17:902:e88b:b0:1b6:b445:36d4 with SMTP id w11-20020a170902e88b00b001b6b44536d4mr2068208plg.43.1692347352702;
        Fri, 18 Aug 2023 01:29:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001b8a3e2c241sm1148781plo.14.2023.08.18.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:29:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv7 net-next 0/2] ipv6: update route when delete source address
Date: Fri, 18 Aug 2023 16:29:00 +0800
Message-Id: <20230818082902.1972738-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Currently, when remove an address, the IPv6 route will not remove the
prefer source address when the address is bond to other device. Fix this
issue and add related tests as Ido and David suggested.

Hangbin Liu (2):
  ipv6: do not match device when remove source route
  selftests: fib_test: add a test case for IPv6 source address delete

 net/ipv6/route.c                         |   7 +-
 tools/testing/selftests/net/fib_tests.sh | 152 ++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 6 deletions(-)

-- 
2.38.1


