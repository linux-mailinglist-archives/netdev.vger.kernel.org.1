Return-Path: <netdev+bounces-33083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11E79CB65
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ADA1C20CAF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99916401;
	Tue, 12 Sep 2023 09:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B585688
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:44 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D398E7F
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8cbf0a0dso117856197b3.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510263; x=1695115063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m0VpKnQc4xMR5IDfV+pH850cPzpdI1OIHFOPo22dgUA=;
        b=4qCT3l9O7A6MYYENp1PqEbedAarOR7SLil6a+wmcSe6ehhAeDgyNdqyAmZuTZh8BPk
         znCvrYSTnmTJhP5SU8+Bly5Bu6LZH4j8NipX1pPoGso+9nzyIpXIerEUV/jM7l9ykbOG
         5+U48bw6nmBXkbLGjE5k8mr8uepLzzI9LzFTztVnN/EDNZqfZcjKA1JahRr+cEFzkuKG
         jejAyRQZ97bMyEclf+QfILaqFmjWgWGZrKU0vZi/TR8MRz8duTaNl3au6M/mS8f231Vq
         2cYT+GqVnl1bN5Efjg+Trdr2enzfDGRChqFQvkhWb8xOuGWs2dSPuX0cYsRZNWGIlclz
         ZqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510263; x=1695115063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0VpKnQc4xMR5IDfV+pH850cPzpdI1OIHFOPo22dgUA=;
        b=G5NPlVTXrblCWMlhZaRfJGN6E/UBtWFblzH+Ab4g1F2TL8/a+9w8m0vAuVJVN1HuXq
         yP6xX1Eslz5fr3RXkWdn5mji0hcm7Q6U771ZZnm75u3Kygnyfg5IcFsWNW0XaCz7DnCK
         uEhXo20tcupyOdXhBVziyJQmvpkBuOXdgTSDTjMDx0e6kUvvYeUQM0loJSDUXWpYZCyO
         fqbgvkJUmgdEj1bdfSDJ1Mvf2Io1n1O2cNlfMX6Fcb4avWsQv7GZiNj+fVLYBVLTt8fw
         usa6Zb5z2kn9qMZqpjAw/cUVG0LX7fma+mbG7Jjip/SXv0CiLr9y71ajAe+X6pq1Pzp9
         deRg==
X-Gm-Message-State: AOJu0YzRMRCXqu9U0UMtdgGpeF3amSArY4RXO0q7mzGFoXFL9QR5DW4R
	+jbZIuOCWG5i9f1D3GgSaQJW/poJAFyAcw==
X-Google-Smtp-Source: AGHT+IGsAtxLV6LTBw3oFXiXHOgIlbWmAwi1vcSY9rqimVw5ParXQfmI4TpPYPRrF3T9M73PPumwj0uV2i9DAw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a1a5:0:b0:d7b:89af:b153 with SMTP id
 a34-20020a25a1a5000000b00d7b89afb153mr55795ybi.5.1694510263415; Tue, 12 Sep
 2023 02:17:43 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-1-edumazet@google.com>
Subject: [PATCH net-next 00/10] udp: round of data-races fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by multiple syzbot reports.

Many udp fields reads or writes are racy.

Add a proper udp->udp_flags and move there all
flags needing atomic safety.

Also add missing READ_ONCE()/WRITE_ONCE() when
lockless readers need access to specific fields.

Eric Dumazet (10):
  udp: introduce udp->udp_flags
  udp: move udp->no_check6_tx to udp->udp_flags
  udp: move udp->no_check6_rx to udp->udp_flags
  udp: move udp->gro_enabled to udp->udp_flags
  udp: add missing WRITE_ONCE() around up->encap_rcv
  udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
  udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
  udp: annotate data-races around udp->encap_type
  udplite: remove UDPLITE_BIT
  udplite: fix various data-races

 drivers/net/gtp.c          |  4 +--
 include/linux/udp.h        | 66 ++++++++++++++++++++--------------
 include/net/udp_tunnel.h   |  9 ++---
 include/net/udplite.h      | 14 +++++---
 net/ipv4/udp.c             | 74 +++++++++++++++++++-------------------
 net/ipv4/udp_offload.c     |  4 +--
 net/ipv4/udp_tunnel_core.c |  2 +-
 net/ipv4/udplite.c         |  1 -
 net/ipv4/xfrm4_input.c     |  4 +--
 net/ipv6/udp.c             | 34 +++++++++---------
 net/ipv6/udplite.c         |  1 -
 net/ipv6/xfrm6_input.c     |  4 +--
 net/l2tp/l2tp_core.c       |  6 ++--
 13 files changed, 118 insertions(+), 105 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


