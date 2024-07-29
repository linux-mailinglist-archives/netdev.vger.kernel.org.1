Return-Path: <netdev+bounces-113592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09093F330
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1FE2827AE
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D91448F3;
	Mon, 29 Jul 2024 10:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983C144317;
	Mon, 29 Jul 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250287; cv=none; b=kHQHdpTO3LA+hc1b00H8boQOMJuvoiiUUhsxtuQ/RyOLCyXgJW6rPETTMfvogkpAiHwxPHTm1c3DQjNDJ+qaOy6chgMTsSsUCHt8GzB1e+7nf0ESWpG8hzRtcYgIbP6CZRR/7LdpldE36OZVqU+eof0L1MpDp1zLta0oSAiPeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250287; c=relaxed/simple;
	bh=zGJnGWYZ7EWY8CVbBpCUAQmjpZmDiSPSQq4l1T54FLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUX9lCQ+LxBYYXHJ5OeRSg9ceG408eqqVb0LJ5SU8I+Xj/Jy7frwGPE1FdmOx/WBVyrnbsnoQbruuzj6RjjXu8JjoZyZx2ciiL+22+OgmkvLRpprWJ7ZmHK8lZqLq83wZsinAqszTKfAaYWALVjBrcl0T7rsEYXwiRivd5kawdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f136e23229so13663331fa.1;
        Mon, 29 Jul 2024 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250284; x=1722855084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pP0Lh+laS6unIhE0krPz6Y+HdhVEFBvDP/EvaPXHqM=;
        b=SdvsN4e8Aw88hgN6Tb9M0PT9ExT16OaVmrbrDt7d2lUlvE65Yom+49CnC9R9ZNnOFM
         x6ndbbV4nfvyL1Ct/bWIgVgagKCPEye30Uu+4WhTo7zM94492Sm6B9NbopD4jHW0mjyN
         CX7gyJNnOVT9fRejFlGp+Sm7zoJyzJk6S2hwKaL8/cgNBWDplt0T65C9pg3+y67YX1Hq
         3cNGlC6Yv0km67jZE3SjiaYc0gyN9DmHru5Zts0Olq6vV3EC7sPYMmSVrqaQFkHXhSxV
         lBgsm1Nwb2/IR0A4MXEbYn+4X9RRwobiQtbKEHkN+wuE9t6Wp2iPqOpvdi10AcARFdIh
         Hm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRElpix06cdYdB4r9hVwsrG9ZDIlvKB3uWRPdV6fA1jXPPdJMhft+S1wjGEUYcUX5XMCSLwRnoNq7dLkLSAo+pRHU12mxKezFeVdpsJzcnk8J72MDK508ygOOVIn7v6sHyeOaM
X-Gm-Message-State: AOJu0YyZAp17dTjTvUua9XMSrs6EVAvUjABLrbwdoi5reqB2vZXQ8h3w
	JtqfMc3bBcaQjVy4YrhRi/Am+0ZkafS5ZUrOSrq9SCWU/E3/wyP4
X-Google-Smtp-Source: AGHT+IG7DOXpnGVrzl8yFanT4BJ+eg0ZYAuTgZEhIZ6CNxYaTxh67tq81+R+cYS5e81s7KvWjozq/w==
X-Received: by 2002:a2e:a271:0:b0:2ee:88d8:e807 with SMTP id 38308e7fff4ca-2f12ee066e5mr43440681fa.16.1722250283627;
        Mon, 29 Jul 2024 03:51:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6578344fsm5572264a12.91.2024.07.29.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:51:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	Chris Mason <clm@fb.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: skbuff: Skip early return in skb_unref when debugging
Date: Mon, 29 Jul 2024 03:47:40 -0700
Message-ID: <20240729104741.370327-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the skb_unref function to skip the early return
optimization when CONFIG_DEBUG_NET is enabled. The change ensures that
the reference count decrement always occurs in debug builds, allowing
for more thorough checking of SKB reference counting.

Previously, when the SKB's reference count was 1 and CONFIG_DEBUG_NET
was not set, the function would return early after a memory barrier
(smp_rmb()) without decrementing the reference count. This optimization
assumes it's safe to proceed with freeing the SKB without the overhead
of an atomic decrement from 1 to 0.

With this change:
- In non-debug builds (CONFIG_DEBUG_NET not set), behavior remains
  unchanged, preserving the performance optimization.
- In debug builds (CONFIG_DEBUG_NET set), the reference count is always
  decremented, even when it's 1, allowing for consistent behavior and
  potentially catching subtle SKB management bugs.

This modification enhances debugging capabilities for networking code
without impacting performance in production kernels. It helps kernel
developers identify and diagnose issues related to SKB management and
reference counting in the network stack.

Cc: Chris Mason <clm@fb.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 29c3ea5b6e93..cf8f6ce06742 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1225,7 +1225,7 @@ static inline bool skb_unref(struct sk_buff *skb)
 {
 	if (unlikely(!skb))
 		return false;
-	if (likely(refcount_read(&skb->users) == 1))
+	if (!IS_ENABLED(CONFIG_DEBUG_NET) && likely(refcount_read(&skb->users) == 1))
 		smp_rmb();
 	else if (likely(!refcount_dec_and_test(&skb->users)))
 		return false;
-- 
2.43.0


