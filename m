Return-Path: <netdev+bounces-39140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3947BE333
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C5281870
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0A171AE;
	Mon,  9 Oct 2023 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7bSOIKV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F35887
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:42:11 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A836AF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:42:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-774105e8c37so305358085a.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696862529; x=1697467329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xambh7S2B/rl7W6iyHIsTt23Asj215A7j/Lf1TFs3SE=;
        b=F7bSOIKV9i+mS/LwaZH4jTrb5AexGFIC3sZa08A9kK9/O5rzuYi0MzeSwGwF5sqo5P
         vNyf3geTmz0L2LUg+CPtFbWgXRy18h2r/+XSoY28amKeKj9p6XqWviPTIchYsx8dWgT+
         3O3vAv6kFBojY1u0XsOGSUwYaWezBRHcm91e8R8g13LnwAmBArvSB8HA5fJLQHW3VcZx
         XFz/FKr65hZWz88myz7mXf3nlSXSpQwTFRPCek9fKzhZQ+QayqY0Iy8yF7Zp6tX6GD6/
         HQEuv9LNi0oKgHCr4RHP2YDkJmHy3Az6XdGTLN1uKcH/0z50QiVqqop8puKZ7PMUejX4
         vWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862529; x=1697467329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xambh7S2B/rl7W6iyHIsTt23Asj215A7j/Lf1TFs3SE=;
        b=W2LBrk7BriSVH8rhRrp+BpAuUyke8snWCjDBPBL/PzlYY5eWWRZ7xAlI6u0Mo9JvOt
         PArgAb1Zx1dXyU1ggYXHy74YPihu0yLnIYZx6kanyh3UUP/rGBPP1szm+LMW8N6IsIO9
         +a40XbtK/ow0yiJ2fEpOQOJLJQy6N6YoxdM1pTrB6fj/tcC2GaY2JlZZpTiTklef2yNV
         nVbazoYO+ox++OOcAsKfn8nutIAgJEoiHQHwwPRH5A8EAtvTmOIO/riTOrVV62GnU7t2
         dtYU+PD62LM2qxNbfUr1T8jPdKtHwKi2fyjtlOWu1PcWewdBNWgSXsC8i+6jjx3xs4+a
         kifw==
X-Gm-Message-State: AOJu0YxjBNoS4Z2BUwD9bos3VYvKgwjKzpQbNk+6hnFhQm+P1Q3wUViQ
	d2hXoX+XzClFDf/o+SyiZC8+dgWzc4vISQ==
X-Google-Smtp-Source: AGHT+IGQEIxIz6pVqJDb4fwNvSi42f5kJW60iM5V2ST9EAb75at+kCuU8W7xIId5bo51lOx2P5ZZBQ==
X-Received: by 2002:a05:6214:3106:b0:658:9168:e6b6 with SMTP id ks6-20020a056214310600b006589168e6b6mr15338368qvb.52.1696862529307;
        Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id i1-20020a0cf381000000b0064f43efc844sm3873592qvk.32.2023.10.09.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 0/3] add skb_segment kunit coverage
Date: Mon,  9 Oct 2023 10:41:50 -0400
Message-ID: <20231009144205.269931-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

From: Willem de Bruijn <willemb@google.com>

As discussed at netconf last week. Some kernel code is exercised in
many different ways. skb_segment is a prime example. This ~350 line
function has 49 different patches in git blame with 28 different
authors.

When making a change, e.g., to fix a bug in one specific use case,
it is hard to establish through analysis alone that the change does
not break the many other paths through the code. It is impractical to
exercise all code paths through regression testing from userspace.

Add the minimal infrastructure needed to add KUnit tests to networking,
and add code coverage for this function.

Patch 1 adds the infra and the first simple test case: a linear skb
Patch 2 adds variants with frags[]
Patch 3 adds variants with frag_list skbs

Changelog in the individual patches.

Willem de Bruijn (3):
  net: add skb_segment kunit test
  net: parametrize skb_segment unit test to expand coverage
  net: expand skb_segment unit test with frag_list coverage

 net/Kconfig         |   9 ++
 net/core/Makefile   |   1 +
 net/core/gso_test.c | 274 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 net/core/gso_test.c

-- 
2.42.0.609.gbb76f46606-goog


