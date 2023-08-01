Return-Path: <netdev+bounces-23417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90C76BECA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F18D1C20996
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B2253DA;
	Tue,  1 Aug 2023 20:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01B4DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:52:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C211D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:52:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5844e92ee6bso55712717b3.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923176; x=1691527976;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qJO6cij0dxvgWFidqwJT9t2sbAzhrJrlvaWZFsdBjK0=;
        b=INoXp314rnGp/lkv5FTMGv+93E1HNh1+Mj7vgmxJrn16jL4nqoEmBxsr2toBFaWSfQ
         McynmJhTAko+LA+k4L0/toWHzs982cEzOU4m/2i9IyEgvI12MnFNKMuXQkqM7Sc85YbE
         uApyxnPSs4hEJxlmbRX7r7SN2HceDiWEobcpLRme+bIdKDtSUGe2WjUyjfKVJwkYkazN
         0tE7USF1Z4RhRaTyoq8kdCrKBCqPnTkNb3azV4lM34veIUU/upuRCZKRAf+K7RwKCAIh
         b1+jae3gxoQ/0+5ovi8OkbmwEokUSLkmNJAnfbsYPmzn20089ZGcLXs0vgTHR4M0yCEb
         lIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923176; x=1691527976;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJO6cij0dxvgWFidqwJT9t2sbAzhrJrlvaWZFsdBjK0=;
        b=hiatSTpZOIhiABLgP24oqNPQwCZX1SHEadk+OkiKYYlP/RFsk61RkgwFnr6ZmF4Pw1
         FlsAHMI4wwovCHQh3V38CxbgHkJlCJQ5SqP/b8mfNFJWw+3X17w898GftoW7PZOyEq+F
         KxUw9xFCBcHplwQNG4i/5gOsjZd3t/ue/xgCOtcLXYtC3iTN5eZAUeNtIQDjmOGJWQhm
         katNGPZ0NDynVQzeabCuuKbOUFgDFdu/+FPJ97+9p0b3hN6dV3mi2Hp5qgrK6T4BgadZ
         YlgJOSHpwzAxbL8Z5n0YTK1WPpZ04T6WruwrZG0n/PjygVAiG/TS0hDpfEVjZvsV+Z2C
         i9ew==
X-Gm-Message-State: ABy/qLZYjEnq/mIaxlS/vd0AQeLQzsKOkg2vDWugtCAou3Rpnj9hT31f
	NSt7LhohRSuXNmb+hGl4qY1idPBn2HR95Q==
X-Google-Smtp-Source: APBJJlGwwoJSapkeoFOiMJ8zYf2c60q9KZ5kPu0v3gvlxFqfsionrGg5YrCC8Desxb9yNFPkTTsUHhVLEN7dDQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2083:0:b0:d0d:4910:cf0b with SMTP id
 g125-20020a252083000000b00d0d4910cf0bmr98957ybg.10.1690923176532; Tue, 01 Aug
 2023 13:52:56 -0700 (PDT)
Date: Tue,  1 Aug 2023 20:52:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801205254.400094-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net: extend alloc_skb_with_frags() max size
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

v2: Addressed Willem feedback on 1st patch.

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


