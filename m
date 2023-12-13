Return-Path: <netdev+bounces-57015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C87811954
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46401C20D9B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890B34CFF;
	Wed, 13 Dec 2023 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Te9oJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D383;
	Wed, 13 Dec 2023 08:28:28 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e9e14a558f8ab-35d699ec3caso23524755ab.3;
        Wed, 13 Dec 2023 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702484907; x=1703089707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CcfbmiwEF2PybazuFYp0nQqrqWKIUzjRDwzmnZGXqk=;
        b=D2Te9oJHce3cSvC2dJZBbIhh8xYlb1bCwwAUvizWjmCD8FfRNLCMETxyKpYJhR+4Rh
         AEdOWubbEOwjw9oua3/9Luolkl92fKnTwYO3/cf3qsd10H8/a0YFckvo5hIA8du11/7m
         OELXFmiq0FKqlzak4LXAIZRmhgN5WhtUKhpRJOWi4fnK8VBuh5PYJmFqjqagnLKFO2aY
         q8dnPBBTDkqr76u6uER5Gfs0+0MjscoobXG81x07MVVVg8jBPjlTkZmheZYATdPg3/xn
         7QRe6hbFI0wzpeCKLzBHlkE+BgaB2F3vzXrKDz3ZfcaUvO9lyJ7Ucz6MkWWxTW6c7j44
         4UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484907; x=1703089707;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5CcfbmiwEF2PybazuFYp0nQqrqWKIUzjRDwzmnZGXqk=;
        b=TMh8IC33NHROA3ZHKhLdHlf0/IBVfYg6+Z27svXWd4ZUswSd5OajLNKMKAl27dReEq
         8EYn4ZCWA6PyWo3U1KSqWa2PO6DUEZ6Wf04IfWdGhgB6BRH5NiFCjVIRV/dFxSnZgYTZ
         YW6hqB/tlfkJI1tcgNLSjxMiwr9p4e9h4ZCvwmkgNS/BRMtSZS9yfvHh7xktelO2Zkin
         IOBxhRwg5NB9FlFkmYMp0Ugbs2p7RUX2fXIpcg/q2syn0/EbVlLrZZhF+nmVrc3/Dx7t
         Rs7RYoIINsJa773Mok6H6JM5gdEhJZ+ds5OMqz/lVOQArv4EXFKpK5TPV38gkVPZ+Jf+
         zB0g==
X-Gm-Message-State: AOJu0YypWld4JqYsxWXG2VoPqMWsbnkx+gab/S86Q+7Ljh7L9KFoMuv6
	UbvLRdxlfVp19pm/mc9NE1U=
X-Google-Smtp-Source: AGHT+IFO66itsyE25n+MAl0FQli35u9ZUkLXwdn05Z23diny4JXCyJ6oInwMWTf5nwiNH1wN0CSBlA==
X-Received: by 2002:a05:6e02:1ca4:b0:35d:6336:743e with SMTP id x4-20020a056e021ca400b0035d6336743emr10897832ill.61.1702484907612;
        Wed, 13 Dec 2023 08:28:27 -0800 (PST)
Received: from localhost ([217.212.240.69])
        by smtp.gmail.com with ESMTPSA id q4-20020a92c004000000b0035905b40621sm3694945ild.66.2023.12.13.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:28:27 -0800 (PST)
Message-ID: <63bd69c0-8729-4237-82e6-53af12a60bf9@gmail.com>
Date: Wed, 13 Dec 2023 17:19:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2] ipmr: support IP_PKTINFO on cache report IGMP msg
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 leone4fernando@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to support IP_PKTINFO on those packets, we need to call
ipv4_pktinfo_prepare.

When sending mrouted/pimd daemons a cache report IGMP msg, it is
unnecessary to set dst on the newly created skb.
It used to be necessary on older versions until
commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
changed the way IP_PKTINFO struct is been retrieved.

Changes from v1:
1. Undo changes in ipv4_pktinfo_prepare function. use it directly
   and copy the control block.

Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 net/ipv4/ipmr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9e222a57bc2b..0063a237253b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1025,6 +1025,10 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 	struct sk_buff *skb;
 	int ret;

+	mroute_sk = rcu_dereference(mrt->mroute_sk);
+	if (!mroute_sk)
+		return -EINVAL;
+
 	if (assert == IGMPMSG_WHOLEPKT || assert == IGMPMSG_WRVIFWHOLE)
 		skb = skb_realloc_headroom(pkt, sizeof(struct iphdr));
 	else
@@ -1069,7 +1073,8 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		skb_dst_set(skb, dst_clone(skb_dst(pkt)));
+		ipv4_pktinfo_prepare(mroute_sk, pkt);
+		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header */
 		igmp = skb_put(skb, sizeof(struct igmphdr));
 		igmp->type = assert;
@@ -1079,12 +1084,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}

-	mroute_sk = rcu_dereference(mrt->mroute_sk);
-	if (!mroute_sk) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	igmpmsg_netlink_event(mrt, skb);

 	/* Deliver to mrouted */
--
2.34.1

