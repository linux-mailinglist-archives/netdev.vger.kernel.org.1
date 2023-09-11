Return-Path: <netdev+bounces-32880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F779AA6C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861251C208F6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AEC154B9;
	Mon, 11 Sep 2023 17:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790C3D86
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:05:59 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D14123
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:05:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d799aa369so55566227b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694451958; x=1695056758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yRZQAg6gcr1eC0o0X81WDrP9iXly0xSSsKh3yHFL4mA=;
        b=aTR+GTsUyHaonpQu33EtfV8vY09u3A1zykJg10kv1FLK51FXOjbi+A1CQy+KEUcdW2
         vG24dpP9VSqsViIXhRc9133WHIJ2XPvRBAfJ8iof/pC3yn6VjAn3Nco+IhI1mPVGMSq4
         8DSct+goW8mMLGXGMoY6qTg+qGwSXioGt+EbriwQJkDGAiZEyO7MLc31PjbcJyr64R1S
         FzFzvCwENT7IEl1aEB9jwjgyKnZZEjCE9XOv49SUYL6MPVTFNwAbdgWI8oE8JD8ShRWy
         zIOW2EpC2lt5ei4Kr3EOxhCIsl9ThIcqKBKCUcZ9uCMI8SofJuzlRIGk6YTdndoSvc5c
         Y1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451958; x=1695056758;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRZQAg6gcr1eC0o0X81WDrP9iXly0xSSsKh3yHFL4mA=;
        b=GWz96hrfEy0HYlYMHvnE14W8K6Sei6vEWVYbRZT3VhyswKzZ2OJw546WfN0mcTJET5
         tG71WzfbdsfGIkpxRLbuWOtphy+P84aNL2QATpg9pI0wP6rNxDtiox/19pC9XZhKeL5g
         08+AchNjNALJRt6z26N1Lar7iAQFJrxpvkUUoykI0n7cS+v+pLOkZNfbVanCecHU/q9z
         WH+VOc+EL45R1Pu8n5B2kFaTEUE/USsQJAgRoGzV57ay7FGFOQBRWEbMM+YJWkDTAQIl
         vb6KzPe54db6eeO0smcl/JGbi6Xpa4CoWgjl9ONzGyrMvWLOrdzB7uFsrR3WwiUxQcbL
         9Znw==
X-Gm-Message-State: AOJu0YxBGENblJf+fNEXkin9/WwY3zAaFe3cs8TcWSnXQjlD4xfb4UWo
	XSr6lVS7PZg2AS5WQInaBDUR12pOgwaS4Q==
X-Google-Smtp-Source: AGHT+IE+x9af9c6W1HW4DAfp8+66duch0ArD2Gr8JUeWu8Mn/xG2lB+lMz2/NeJCP4t8tu32ejCbt+dWMQsqHg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:eb12:0:b0:586:b332:8618 with SMTP id
 n18-20020a81eb12000000b00586b3328618mr263734ywm.7.1694451957932; Mon, 11 Sep
 2023 10:05:57 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:05:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170531.828100-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] tcp: backlog processing optims
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

First patches are mostly preparing the ground for the last one.

Last patch of the series implements sort of ACK reduction
only for the cases a TCP receiver is under high stress,
which happens for high throughput flows.

This gives us a ~20% increase of single TCP flow (100Gbit -> 120Gbit)

Eric Dumazet (4):
  tcp: no longer release socket ownership in tcp_release_cb()
  net: sock_release_ownership() cleanup
  net: call prot->release_cb() when processing backlog
  tcp: defer regular ACK while processing socket backlog

 Documentation/networking/ip-sysctl.rst |  7 +++++++
 include/linux/tcp.h                    | 14 ++++++++------
 include/net/netns/ipv4.h               |  1 +
 include/net/sock.h                     |  9 ++++-----
 net/core/sock.c                        |  6 +++---
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 net/ipv4/tcp_input.c                   |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 15 ++++-----------
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


