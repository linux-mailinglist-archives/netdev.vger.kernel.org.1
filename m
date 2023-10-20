Return-Path: <netdev+bounces-42872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382127D079D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34B32822EF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A46111;
	Fri, 20 Oct 2023 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DOiEkaj/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA326A41
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:32:50 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1DD4C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:48 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66cee0d62fbso3190046d6.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779967; x=1698384767; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIgRMVZRHWuc6XXVkWqSeW2ex2b1ilZhxXYHLgoWugw=;
        b=DOiEkaj/uhP6PcnrvTJGVIXCo55WXYXvwiU6o//9FErDjmw/BxHAnBrux42mxyLm5n
         8uVB90n8O5iDM/YuauzEK3I/dL0LmeL/wSepWeshU3Tp8Ec4i89wCALMXjakNZOHFMFw
         YZAhtF7Ai0XgIdkUIe3DTLH9WzRtwca8VHdui0UwGolpRucGmeVnhjGduVzd5C4pTYrN
         PR0htwUij43npmf2puO5NDd380CrOVgIF20Uv/A5hLu6dKDNtzQec8Ah5z8PEWVIm5j9
         62DD01Hvm7Qqy0mGhayJyPy/OOGM8njkOrwJ0tbprfAxiqBYFQW1/lsmjZXFaC4+1D42
         v7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779967; x=1698384767;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIgRMVZRHWuc6XXVkWqSeW2ex2b1ilZhxXYHLgoWugw=;
        b=fUk26vZc5+M9uqNQ2dVhFrxu2cd5p9WHOP2Q2IG4yq5ZRxJCgY82SWFVuldXUOpoB8
         Q4kpmA6HBQoKThAlnU/eOhCe452qNvbOD9GhsM1KMHTe61IrL5KNbmjynB1rn3C96Eha
         DHQgN9Ex5az1RuijvSv89i5v83VZcDl/K274iBfe8Xzt0fB39WMcV/x889vHOG+q3QDi
         KoX6egihM7tx1gHbBnjCKD9ObEWknV8IAwH8AqiJtgl+owulrvdVnRfUpYwaeC8dF/Pv
         ZrdFSSdo6z0IzEn616iAwdT+6dXewS1DtBm8jDF9pHaKch4qZ+RvIIvKzIx5S6C5oCtM
         hBKA==
X-Gm-Message-State: AOJu0YyMGy4UCGQnzkwBbohVDVCtSpqmbH7R2IoyLZ0aJf7+Zw1VQTHw
	yNSywb24hBoBFqtg2bzJlypljatA0cwTMe1u1xsMNg==
X-Google-Smtp-Source: AGHT+IGZE4svkFMX0jE6J9baXiN8oiOP9Hxbn+8YqaUYtgXBkU7gYhDSTBIVnKXkCxtDung2ZRsS4g==
X-Received: by 2002:a05:6214:2a8e:b0:66d:51cd:d7e9 with SMTP id jr14-20020a0562142a8e00b0066d51cdd7e9mr874539qvb.43.1697779967702;
        Thu, 19 Oct 2023 22:32:47 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm359050qkn.57.2023.10.19.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:47 -0700 (PDT)
Date: Thu, 19 Oct 2023 22:32:46 -0700
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
Subject: [PATCH v3 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1697779681.git.yan@cloudflare.com>
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

The series contains following changes on IPv6 output:
* drop dst_allfrag check, which is always false now
* refactor __ip6_finish_output code to separate GSO and non-GSO packet processing,
  mirroring IPv4 side logic
* avoid generating atomic fragment on GSO packets

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]

change log:
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: remove dst_allfrag test on ipv6 output
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 net/ipv6/ip6_output.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.30.2



