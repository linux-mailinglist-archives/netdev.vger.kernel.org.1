Return-Path: <netdev+bounces-132150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9943D99091D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A450E1C20C95
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4C1C8312;
	Fri,  4 Oct 2024 16:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEB1C830E;
	Fri,  4 Oct 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059251; cv=none; b=G6s4YpX0ThmLqlOK+a3aIoooyQaoak+5l3+HDxtfour42oMbrUNS5PSWtFfFXQrLy1MzQMeu8/HnH06B8StOJxyVS3C9iN3QQ13AE1v0Cc3GH3QntmznTMN+eU34n7j+0zH6hRMBecqJAlLVIKKFf6g59g+OkML7fvK6f/evU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059251; c=relaxed/simple;
	bh=AQ/EgJ6tq7MJEVpBAAagxucu5sFd2Nf2zUA3Qw6JS7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEa+3dzoRsx1lQ3fyvGv284HdJD5tftMEUgOqSXHXs3TeCqmmYd+6XB/zZb8PdJVFU34PEMv9Mp0V66ss5WgdkVTI6r99TxOH7Jao5u0llbp0wBmIQrpd59IQVu/fD30lRz4PGngLXAwegG+rHx2eCs7PxcJAF0Z8ZN+AZa4960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so378620266b.1;
        Fri, 04 Oct 2024 09:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059248; x=1728664048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USu6Hcq3z9GShX+czzkzD+TC6h+OVCtZKe0Ir/51YE8=;
        b=ZwENhX9fZAo/eg1rBO5UhkAi3hfMEMs/9CeqwECPW/VQ9KYHCdQz7fTByV+n2Gyqv1
         l42I0J/xbX8J9Q6gj6ZKecOfw47pg3QWxyLosacCh3z+QPnH/lUbKJdlaWHX8Ks3Hn4/
         BnPeCUSPJRomLqZ682GNsgLLeNtTmeAH941s1QzqXHyzScds708u4yloLs+6YvgG5PpO
         tZG9QRFM8YDcgK8O/7WCmqzCxWan/MVWPXxUMY/KKgERGcrNwDOJ/dg27Zufmp62P47q
         hHj8AoJhyzg9g7CxobTZi1aMgJyDOC2YDUGXzVhe9ucrIJ2Iv37Z/05ZgaSyJst3rLIX
         JMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXaD6FqMOunGPCAh4HMliEIR5j/saHoDaVDfPuZocVa32uiqLRhHY1pivWMQM1hIrBc+R0nm+PAWSP/3g=@vger.kernel.org, AJvYcCVlQcZY25bzc/BP+6dVfiK1LVUdUgbA9tkdFOM00InNbt5CsFbvGIqRpCDl/Z/E0lGHmL3PttOx@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPm3aEq6+i7YLWar6EK/+qEjS8dstOdjYNV11j65ugy/Pp/xf
	223jw+d/wwllTlYPPnINp03NbD1yIWOMLHWidD5gEtCv6K9Lpr65
X-Google-Smtp-Source: AGHT+IGZmKQL68WpsOBDeUjeJ/Hp4B8J99ANAM8H3/fHBRrIRfe//mg+4K4roKqPp+8KtWs5DFbNFA==
X-Received: by 2002:a17:907:d2c5:b0:a90:349e:2465 with SMTP id a640c23a62f3a-a991bff93c5mr301488566b.65.1728059247404;
        Fri, 04 Oct 2024 09:27:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856bfsm11909366b.138.2024.10.04.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:27:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: rmikey@meta.com,
	kernel-team@meta.com,
	horms@kernel.org,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
Date: Fri,  4 Oct 2024 09:27:19 -0700
Message-ID: <20241004162720.66649-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Branch annotation traces from approximately 200 IPv6-enabled hosts
revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
mispredicted. Given the increasing prevalence of IPv6 in modern networks,
this commit adjusts the function to favor the IPv6 path.

Swap the order of the conditional statements and move the 'likely'
annotation to the IPv6 case. This change aims to improve performance in
IPv6-dominant environments by reducing branch mispredictions.

This optimization aligns with the trend of IPv6 becoming the default IP
version in many deployments, and should benefit modern network
configurations.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/route.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 1789f1e6640b..b90b7b1effb8 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
 	struct net_device *dev = rt->dst.dev;
 	struct neighbour *neigh;
 
-	if (likely(rt->rt_gw_family == AF_INET)) {
-		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
-	} else if (rt->rt_gw_family == AF_INET6) {
+	if (likely(rt->rt_gw_family == AF_INET6)) {
 		neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
 		*is_v6gw = true;
+	} else if (rt->rt_gw_family == AF_INET) {
+		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
 	} else {
 		neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
 	}
-- 
2.43.5


