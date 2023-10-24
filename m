Return-Path: <netdev+bounces-43899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530797D53F6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB161B20F0D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251F2C873;
	Tue, 24 Oct 2023 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FonKB+pa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E772C85D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:26:35 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FA111
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:26:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7788fb06997so313718885a.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157593; x=1698762393; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSkD7qLJMOj3J00NGcykYcTjPHnf3wlBQzh0/FoSFS4=;
        b=FonKB+paqvcJd3aVuqUZ+DevZ/ju7KgsAyiFti5qWAKKk+pIspKJHAt+VmB9+TR+e3
         b3PpYYT+SeXQzIkU81+kDj62AQt3o320/Y2tYt8AsChGLQ8gMBB3U2Q4Rx2zY9HY0vM7
         qSupfNWy5VBNU0ydV9brylYzcOL/rULFNdIXs/1Eda4n/asAKTypg4cA0J96uw1A89Kd
         1mycTcY/dX5c+xNytOcYy/OmZ42s5vi5HYt0SnWGnx2guiTFCmgqG4tQVnx7ri508m+7
         Dzkv0imnofKK1jCFF2KEIdx1X/vgKy+PV96B1zZYeZXoQObuNiz6UcI33NBaevNUG7yP
         vZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157593; x=1698762393;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSkD7qLJMOj3J00NGcykYcTjPHnf3wlBQzh0/FoSFS4=;
        b=NrrFzq9RhtKT/fFvflHfXGqpEhLQhhLPtFJyGfwBXjncU0ctk5zLrQeOX2Wahwdf3o
         icWB3qEVdFZ2OcPYRlVCryNBI2BOVI3V4h8mmYv9hsNTwA8FCSmFvlKuKpLB2WEO7+qv
         lJJkO4JWIiPsOXFeUDRs0LP5nN0zy2evNKZ4+KAfnr6Mk0itLetwa7sTjQ56AhaVQEoE
         /a4exCgoKXtHB3LrPyHAgy7xsj3GY86keL2N/H7h0bWoM7sn64K385XBfOP3SsRULHM+
         Ex/PIrQcIWcEuXuUFNMYrEAFt2oq9xFyjgkDRhb24z8yMsLjIno+cKaS38vi2JjzWWu2
         hkRQ==
X-Gm-Message-State: AOJu0YzlSxlDnNFJWnVABhDPkMnanoSefk6uQmTQ0vPZxscvyfOiCFT+
	suWqr7qnElfVnXNkJfsvUVO3nG3QeoOjBErCMwIXkw==
X-Google-Smtp-Source: AGHT+IEe+TEGePA52UECB7U2kmO8POiVcE6AKJVynAW93jmiSs63kLXqKS6YPGva2vriS+ablYsZ3A==
X-Received: by 2002:a05:6214:230f:b0:66d:62b7:53f4 with SMTP id gc15-20020a056214230f00b0066d62b753f4mr14290057qvb.45.1698157592853;
        Tue, 24 Oct 2023 07:26:32 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0065d1380dd17sm3598217qvr.61.2023.10.24.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:26:32 -0700 (PDT)
Date: Tue, 24 Oct 2023 07:26:28 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v5 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1698156966.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

The series contains following changes:
* drop feature RTAX_FEATURE_ALLFRAG, which has been broken. This helps
  simplifying other changes in this set.
* refactor __ip6_finish_output code to separate GSO and non-GSO packet
  processing, mirroring IPv4 side logic.
* avoid generating atomic fragment on GSO packets.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]

change log:
V4 -> V5: minor fixup
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V4: https://lore.kernel.org/netdev/cover.1698114636.git.yan@cloudflare.com/
V3: https://lore.kernel.org/netdev/cover.1697779681.git.yan@cloudflare.com/
V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: drop feature RTAX_FEATURE_ALLFRAG
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 include/net/dst.h                  |  7 -----
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  1 -
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +------------
 net/ipv6/ip6_output.c              | 45 ++++++++++++++++--------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 27 insertions(+), 53 deletions(-)

-- 
2.30.2



