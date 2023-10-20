Return-Path: <netdev+bounces-42985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBE7D0F33
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB38B2142B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD5199C8;
	Fri, 20 Oct 2023 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdYWmbdR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB70199C0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:55:50 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62044D41;
	Fri, 20 Oct 2023 04:55:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a6190af24aso121609666b.0;
        Fri, 20 Oct 2023 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802948; x=1698407748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qDRJPeHn/xwLqKtWzj5rQCzzogUl5KrtJYZiSSaRt0=;
        b=OdYWmbdRXsVWFLzZ6XRY3O1ZqsM97EBKiXuGd8bD5k6B+B6ema+6WqP2ihWHWGGq9X
         XXF5zX7KVJh7mF4orI1FELsoz5ZfNd6OADuUshwGEgSLpbKHZx+AvrwLckGsNkzNXbI1
         n59j8rr4vwEQ6+L4IRRiPM8v5QnTDrcymwAi+5uYD0bqHG8FrqyXrWAYNW3ZshECFsTT
         1GsXkEty1whwgWVnp+EajDnGE2oFMVLoY6wJDf2+JplMQ/dkTaVAqAboRQPEBr6Tu+vO
         KKozDLF9FhYEmE6arCGFd0IabtMfCsf8YH7LOgOdz8XyPhcqYDJhbaIIPlHYixm9X6Df
         7Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802948; x=1698407748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qDRJPeHn/xwLqKtWzj5rQCzzogUl5KrtJYZiSSaRt0=;
        b=T0HCPLflodB5sIFkx759OcSiy3g7pv3N12kwccsEW49c41Hvt9ckb79g7f2s71I1b7
         pvEVylUaZXSB2xFL9+6b6bN5rM5MgLUDlMQkExlcBZHHO1V8Yst0JOi0N1GHIIEieXt4
         Dj1c+NH1Mi9/7QWSqRE9zLBfTLX3//2nJgNRFnGQMAriy0MjYGfq1R84MIQSexsDMmpZ
         QSizzxEWajadPajM4PgHggsfvzYDlG4F/Y0j7eLwQxI2UH+70dViqwO88ZY2rF4+1025
         L1kojFmC9abE6dPO9W1P7hs2CbmUlu6FhedGp8KUGuKoAVyAmDDanD6OthiiWbIL7RMC
         +TTg==
X-Gm-Message-State: AOJu0Yy2Dk6s/64bCOi5+kx99ZjSS7QjUBC1eJZC/4kozkGf9sfk5S0n
	rI50eYVpOVG3tNw9u6TdlQA2Ebxi+k4ZMg==
X-Google-Smtp-Source: AGHT+IEv/ASpI1kieRxra9H9hOoln2QWf987PQohhFrTHwqLKutMxyN1wI8/JusJuLn1c5k0s7f7GQ==
X-Received: by 2002:a17:907:a0c9:b0:9c5:cfa3:d030 with SMTP id hw9-20020a170907a0c900b009c5cfa3d030mr1293450ejc.54.1697802947678;
        Fri, 20 Oct 2023 04:55:47 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:55:47 -0700 (PDT)
From: Beniamino Galvani <b.galvani@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: consolidate IPv6 route lookup for UDP tunnels
Date: Fri, 20 Oct 2023 13:55:24 +0200
Message-Id: <20231020115529.3344878-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment different UDP tunnels rely on different functions for
IPv6 route lookup, and those functions all implement the same
logic.

Extend the generic lookup function so that it is suitable for all UDP
tunnel implementations, and then adapt bareudp, geneve and vxlan to
use it.

This is similar to what already done for IPv4.

Beniamino Galvani (5):
  ipv6: rename and move ip6_dst_lookup_tunnel()
  ipv6: remove "proto" argument from udp_tunnel6_dst_lookup()
  ipv6: add new arguments to udp_tunnel6_dst_lookup()
  geneve: use generic function for tunnel IPv6 route lookup
  vxlan: use generic function for tunnel IPv6 route lookup

 drivers/net/bareudp.c          |  13 ++--
 drivers/net/geneve.c           |  96 ++++++++---------------
 drivers/net/vxlan/vxlan_core.c | 136 ++++++++-------------------------
 include/net/ipv6.h             |   6 --
 include/net/udp_tunnel.h       |   8 ++
 net/ipv6/ip6_output.c          |  68 -----------------
 net/ipv6/ip6_udp_tunnel.c      |  70 +++++++++++++++++
 7 files changed, 147 insertions(+), 250 deletions(-)

-- 
2.40.1


