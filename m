Return-Path: <netdev+bounces-23238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E776B663
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42FD1C20ED2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CE22EF7;
	Tue,  1 Aug 2023 13:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370B111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:54:59 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E85C3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:54:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so68561147b3.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690898097; x=1691502897;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dl4gLSKfTBoUncetMpgn1ftj8CyCSwpR7e8El8rhIjE=;
        b=Lg04hkNZZkznNqLi2aJHa37D1td+MaldiSlX7ynps6qU7oZ/MyDdRGyfTfsNBKwtRv
         oMPiKvJXiEI+z4vIlgPHn5bd0qnEgCKV4EL+gcVE+e6JFMx4m25NuYW93PHWIHYxnzk3
         QjuhARtDAAoKturiFRM4u6E94awpYOeH9CJTZHhGtQbnUu9wd/ji4QvK+idTcQvQ1G6p
         57mUyRobL0leCpm8JoHZQx7ZkmRJAZrYY5BrKvePPiZqflUE5CBAneoE2HkbcaH7OyiY
         FH/eAEm/RVyP/96qcnkApJtPBxe86pE2uTttIB6U8zEg116AnBRPyiyqoLXUrigWj2Er
         qi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898097; x=1691502897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dl4gLSKfTBoUncetMpgn1ftj8CyCSwpR7e8El8rhIjE=;
        b=Li9xhSw5pifOSLYcNrpuqlCBwKJebMePNRpbdAdLVpISmd1LR7YsItlo1ttwQK6ExR
         +N9sUV/HIARv9jXIlypBOaegeb1l59ULe6JJkjuaj3zvt1BSGNcwNOiSBCx9WHL1fQ3q
         QmpRJE+jEijDqEC+wGJdqsWvBlUfQmrMplLZCtOzZQ6E2UYKaEh0iWQdvQFk0bEmfx5G
         DrRUEMHLgLLxL5/gQDgxXOP+jtJT4f7Wqnymbs0HrPhKGOxGlESEXSCZiJv6pIEzKj/H
         eJcP/Ow68xlOQ3on7RRrSBmru/w9OTNWMnnROCv2S9y8ljV+ROq7wRM9m/mFaVzfg5a/
         pPZA==
X-Gm-Message-State: ABy/qLbkxfTBPXGQxffpHM7xa32l/lPnp8EpqCy0X8Gr0L/0P9JC/MKj
	qp0Pw2Z/bhHWwGurrARhRxip6jSQBOdY7w==
X-Google-Smtp-Source: APBJJlHody4P2agcihWgEukkTlYnG51beDiUV23OZ8LegPEuYc4pCbgA8/AVd/9ePFzqgbNUDLsd0vxRx5CDkg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4304:0:b0:584:43af:7b0d with SMTP id
 q4-20020a814304000000b0058443af7b0dmr101346ywa.2.1690898097421; Tue, 01 Aug
 2023 06:54:57 -0700 (PDT)
Date: Tue,  1 Aug 2023 13:54:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801135455.268935-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: relax alloc_skb_with_frags() max size
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

alloc_skb_with_frags(), while being able to use high order allocations,
limits the payload size to PAGE_SIZE * MAX_SKB_FRAGS

Reviewing Tahsin Erdogan patch [1], it was clear to me we need
to remove this limitation.

[1] https://lore.kernel.org/netdev/20230731230736.109216-1-trdgn@amazon.com/

Eric Dumazet (4):
  net: allow alloc_skb_with_frags() to allocate bigger packets
  net: tun: change tun_alloc_skb() to allow bigger paged allocations
  net/packet: change packet_alloc_skb() to allow bigger paged
    allocations
  net: tap: change tap_alloc_skb() to allow bigger paged allocations

 drivers/net/tap.c      |  4 ++-
 drivers/net/tun.c      |  4 ++-
 net/core/skbuff.c      | 56 +++++++++++++++++++-----------------------
 net/packet/af_packet.c |  4 ++-
 4 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog


