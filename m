Return-Path: <netdev+bounces-24445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F396770363
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCF41C2175F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8EC15A;
	Fri,  4 Aug 2023 14:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE5AD48
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:20 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A846B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d41bfd5e507so1589911276.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160378; x=1691765178;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbmljhkD+wW9tZCzMffMOORiIJiELyIu2FDcFdICzw0=;
        b=aJt/qG+H2wgDo2l/T6MePGLYUE9QPAQvKRpS8WjCsiJnUI38l3ocDnHwLV7yKlQTvI
         /PE2WSHLBQDhUf5QP4wzUFA+UGaDgH/EkhFKxnYx/WLmMtLUOpyc7VfBDAy+abLBBQ0K
         iqKSuARnhTK1zRoL+qMqMjUH3I56IMzGlEczTowj7MS7yZmayVcu1UM7ti57xnAocADl
         8x2RmGySbPdI31W4z8Z8FPZIeI/LLfOB0720faHt/bLteOulLITYjJXXgPUfPCqOV3yT
         27T6yTYnRR3+/aEU7lMqksCge1h7WuAI+J/cQAu60x9wSY+DY22UuaHWIhsOqGsKhLst
         EaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160378; x=1691765178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbmljhkD+wW9tZCzMffMOORiIJiELyIu2FDcFdICzw0=;
        b=lDoQjATsTu1Z8KhpjIxm9V0pvXs0i+5HXUYfM/Mjzs7QMUtR46YEB91emiFI7IkAs9
         bXWtl2PNr9pjf5wQRUL4gCEEzICVa/3KTAZ/kCac3Xkhc0KhiN0h2oI47uQ0b2jAhil7
         +GmmUllZi4ZOU4/WatdCeQDQy5DHVk0Fb3sLvzixXZFDrS13COh2mADx9gEO9/RA1Nr3
         wpP+IzRt11QS7Y7zd7qhsoY4b3loQ+pE3uzzUlxGTBvsJrvgkiyxpu1PUVTaDkvgyp67
         wnqngCb7JPft5qMAaJ323bQyzH1BiOYHXaxh1y1/ga+Xqo3wS90W3BbJzJBY6XLFoSrp
         Icqw==
X-Gm-Message-State: AOJu0YyXErs07e4mCpRHZRmRdYZYt1pKMaydHV5GfQTXWXCvRyUBai3e
	waYNLaSojPRdCS44ObgDDWa+zBBBojOtHQ==
X-Google-Smtp-Source: AGHT+IHqzw8Mgl5R2ahps8s6asJPzycZaBWj8XTI58W2F3EowTaWjIWQaST8kbWPIJB2jMy603vh2SGXQJqIAw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ac9d:0:b0:c4e:1c21:e642 with SMTP id
 x29-20020a25ac9d000000b00c4e1c21e642mr8869ybi.3.1691160378393; Fri, 04 Aug
 2023 07:46:18 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-1-edumazet@google.com>
Subject: [PATCH net-next 0/6] tcp: set few options locklessly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is avoiding the socket lock for six TCP options.

They are not heavily used, but this exercise can give
ideas for other parts of TCP/IP stack :)

Eric Dumazet (6):
  tcp: set TCP_SYNCNT locklessly
  tcp: set TCP_USER_TIMEOUT locklessly
  tcp: set TCP_KEEPINTVL locklessly
  tcp: set TCP_KEEPCNT locklessly
  tcp: set TCP_LINGER2 locklessly
  tcp: set TCP_DEFER_ACCEPT locklessly

 include/linux/tcp.h      |  2 +-
 net/ipv4/tcp.c           | 90 ++++++++++++++++------------------------
 net/ipv4/tcp_input.c     |  4 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_timer.c     | 48 ++++++++++++---------
 5 files changed, 68 insertions(+), 78 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog


