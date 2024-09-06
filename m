Return-Path: <netdev+bounces-125878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE896F179
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574071C21C7B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7331C9DEA;
	Fri,  6 Sep 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="BK5+1c+o"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6C2D600;
	Fri,  6 Sep 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618564; cv=pass; b=XwawK7cKEfodTpbHm50iqCpjjHNWVwxQllShfog1D1f4qTjXw2aq9tx/np7PrVPKHrw1HzeFC8ghWM17Sujwuy5oRD8cVGLHMRJ8Y+xL266YeUeJWfGHiEbbem+/ibX8KjTFu4tN0Jpm5UmtZ1spv1KMDj/+h5iBjWZi8PEW3MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618564; c=relaxed/simple;
	bh=F/BQcxFsESJqmAt5OFrJwYn+x8O/EmPn/9RUu+d2WDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ITBxLrEDf0fpgZEAZ4ugq/LF5XGtHFRLrFFTcA25D6SDdcgAqoDN61mluvIYZNidTZkg5+b9yV10eps1rDx7rZOG6+2DkAmR4ICBgzR30sZmLDZ4c5lfocwzglW1P8Piz3OJzRnAqSSk17ws46KdCTnaqF4i0Ka0ryQZmxWNRk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=BK5+1c+o; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725618546; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QKpgkFb1cGQtZVOiLg+NKbfabgaCTC9KR2F6dNy2WM3rGx2jW3peNeuW8nA0im6xjEnJxdqkA+rT+fz98MH/sbdIiP0F0GC5iAT2kxHqyQ3xT8HodhW2qiHk/BKmasDCl74c93HiiA+AmcTvbRFEZ5fdXWi07Ie1k0/zYNh1rcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725618546; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2Gc38LrvxgbLYiaU/hFHkxF3fEAn8S+Hl2PRviV5ACE=; 
	b=HTWePX5KNKbw3vMf3h3bJJy+dJW306u2RCr4BAhknHX+JQL576x5i5plzUZKt3EeL0l6XYqJQWnSbKZeKa+mjNuR0V+IwtbltyixYFv2sHKlgFEFifHA/NL+euLizoIbk6a9SlYGgiqZsYgYtWqFByXTVL32KaIIio3DvYN6/20=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725618546;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2Gc38LrvxgbLYiaU/hFHkxF3fEAn8S+Hl2PRviV5ACE=;
	b=BK5+1c+ovhZJFGI4ub2kVPEMEKDaJja7xt5AErrfZ009niKBTbsF0X5Q4jDG1Pkn
	kk1XTe4PsDLxzsGkjAUztcQBKOmBMfsI0yicZp0ssoBqGxuAuhVHtGyY26ESVefxBa7
	+4qFQUlplA/sS/KQ8Kq8iwf1mfqYraU/CW4nFBQs=
Received: by mx.zohomail.com with SMTPS id 1725618544872621.9303265984904;
	Fri, 6 Sep 2024 03:29:04 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fou: fix initialization of grc
Date: Fri,  6 Sep 2024 15:28:39 +0500
Message-Id: <20240906102839.202798-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The grc must be initialize first. There can be a condition where if
fou is NULL, goto out will be executed and grc would be used
uninitialized.

Fixes: 7e4196935069 ("fou: Fix null-ptr-deref in GRO.")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 net/ipv4/fou_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 78b869b314921..3e30745e2c09a 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -336,11 +336,11 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	skb_gro_remcsum_init(&grc);
+
 	if (!fou)
 		goto out;
 
-	skb_gro_remcsum_init(&grc);
-
 	off = skb_gro_offset(skb);
 	len = off + sizeof(*guehdr);
 
-- 
2.39.2


