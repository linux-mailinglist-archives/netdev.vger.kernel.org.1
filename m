Return-Path: <netdev+bounces-38247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5337B9D8C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4CF04281D74
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF7266C0;
	Thu,  5 Oct 2023 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUzAqhWV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001E26285
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:49:26 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968319AB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:49:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8168d08bebso1066133276.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696513763; x=1697118563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf9xeOok9EGJhHgMlaxE0Y86ea7FsKfAgGBIu7eRuiE=;
        b=JUzAqhWVVGP9oR/UmffHcZJAiavYmY6144oCX2dvCV2RvV9Kt+70GoNcTQQOYrz9N8
         XQU3fwef0jWasVAx36784XaS/Y4UnD7BjtBbrhDX1nygBwDYSMph7rJtNI71YPLwHr5k
         djOyEP0OvouWCArBVOGBhhhL/ZQQhTNSqKxpfToytTrfs7K8ZOvUAs2oofICUE3vjEsV
         +spWEhpjMyxLhszuxbJjbvasgxTeZB1sRXk4r8HbsVEAam/08EJUZT4IPQZ3GAontv/n
         lZqanP9qAFMZ1rX4qdXHQH3jmHlKWWNdsi8FMrKKrmiAnNE/PNaoQgUUYG3lRY5ZEmy1
         GzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513763; x=1697118563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf9xeOok9EGJhHgMlaxE0Y86ea7FsKfAgGBIu7eRuiE=;
        b=co/nttZxf95FgdAlcAjRSyjow1WLqk9eW2UEsMdMWDxEAHFpAy2DBdHPF90hxN8g71
         u6Yg3/m9LgsB488YS2Db0AaCyqCTGjBZ24DB1W3P2TxbB2TLOsYHzxx+NatU4VhG5vzS
         g1+y8ylAvmZnN5dzxaOULxJM8XFeMUbofbHq88PMHgE5UsjN2vEJ1VId1ZV+oVrmF6/Q
         +8mqPc5Snzcv7f0812ns6OfBVgsH9R6pwvzeqpuc5IvK8MOrYWD6F2BAv/rtO+PLzGrY
         eKuAtadCp5kI4wt1GfNP5XSDE96D+fb9dAjaSR4G8dz1dUSRYkPzNL47L3Nl3IFsQ6sn
         aOUw==
X-Gm-Message-State: AOJu0YzgY4xJvC3rzFmS8QBN86UqCszqXcrbKwuk5tv/KSvHfzgYgEF1
	O7x6oGZQRbFghlkJ+vgsK+Gej3TvJJUeXw==
X-Google-Smtp-Source: AGHT+IHq17NuBkOGwIBO1TeMqrmjgKXmcy473SgZrCesgpNcQIB9MGjKwYoQedSFCS/4p3NS/xLRvQ==
X-Received: by 2002:a25:cb8b:0:b0:d47:47c0:d7c1 with SMTP id b133-20020a25cb8b000000b00d4747c0d7c1mr5547605ybg.62.1696513762735;
        Thu, 05 Oct 2023 06:49:22 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id n20-20020a0cdc94000000b0065b1e6c33dfsm512591qvk.18.2023.10.05.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:49:22 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/3] add skb_segment kunit coverage
Date: Thu,  5 Oct 2023 09:48:54 -0400
Message-ID: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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
2.42.0.582.g8ccd20d70d-goog


