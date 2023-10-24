Return-Path: <netdev+bounces-43737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DD7D458E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 04:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E779B20AFD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E21FB3;
	Tue, 24 Oct 2023 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AptnH0WZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBD11713
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:35:39 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B010CE
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41ccd38eaa5so32884321cf.0
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114934; x=1698719734; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gVTnJsyvkPl/EqbN7quO86+jwMpzGyV8aZcsQmMn3o=;
        b=AptnH0WZ0QYy0jCnG3Thqw16AK5RZ9P9sYgenUhjImzFJoV+yLJF9msUGUWeTMqp8K
         Bqf21YrgqoPWuWNNO/JCE+RhfR4N9Rm+8mC3S11H1o5s1YCMdh2AJNWIt9tVlSr1/uOn
         f6ByLRNTfZ8KwZ8cW4SaucuWhHP8yuiKrTBf1xk7d32iyzU3B0lvToNPrPmR2wS2NCPA
         DUZngWEHAYVpUlP3UkLH+Ms9cpdfKxruFeKpm9odGImG1EWfAaby/JoIF922JlHldSsh
         vZty9D0kZF3041uHLiyQYH62jtNVxZVnX6DRswgq4lBGsT6VLJSSgBRvphZaVkoJ0WEP
         DCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114934; x=1698719734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gVTnJsyvkPl/EqbN7quO86+jwMpzGyV8aZcsQmMn3o=;
        b=L3BC1zwLQbwdYmy+5KklULWZ4WrF2hVelWNEfeQAOApITcAgrjYTDeRXbi7srmrazf
         jGzoF8WyeKkZvPVt8Nd05+cMQXrgb8y2DMNgQ7dT2wFPWV2rQfwusU5sPjbMeVGzboei
         ABUV4JTRhd0pOabWOqIi0Bezu2ul5V0GU0XOZk5DADxKaNyzCvCnsuyW0rAsSanEzWsz
         +Ix0se9AnISNHJZLXRfVUrmPKwYiy6A/WIF8gWpk75kQtLfS3InyNa2vDgxoYBMzPRaD
         qGDLUUs9KiEaCLE5+LBUu0zgPJsUY5k+fdZbuG7EAlwLD54xs2HPtA7q+XzpJuTiBxDQ
         euJQ==
X-Gm-Message-State: AOJu0YxTY4LGaQpJV42sIQ8L2GZPi23wVpgXhbCRHoJ3FjlAXDXzxL7F
	gTwkQ9RFJrnDxPKW7tj/GPTK8VQbKfQcOML6QrK8Ow==
X-Google-Smtp-Source: AGHT+IGTvcuBeDlMgkhzLj8lqGBgnlFB3pqQpnKuhTsP6Qer6RrLCbnVYfYNForjrvIxfAUhjOFU8Q==
X-Received: by 2002:ac8:5a54:0:b0:403:abf5:6865 with SMTP id o20-20020ac85a54000000b00403abf56865mr15110377qta.18.1698114933933;
        Mon, 23 Oct 2023 19:35:33 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b004181c32dcc3sm3144313qtb.16.2023.10.23.19.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:33 -0700 (PDT)
Date: Mon, 23 Oct 2023 19:35:32 -0700
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
Subject: [PATCH v4 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1698114636.git.yan@cloudflare.com>
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
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V3: https://lore.kernel.org/netdev/cover.1697779681.git.yan@cloudflare.com/
V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: drop feature RTAX_FEATURE_ALLFRAG
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 include/net/dst.h                  |  7 -----
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  2 +-
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +------------
 net/ipv6/ip6_output.c              | 45 ++++++++++++++++--------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 28 insertions(+), 53 deletions(-)

-- 
2.30.2



