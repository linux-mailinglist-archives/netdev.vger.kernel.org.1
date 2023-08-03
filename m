Return-Path: <netdev+bounces-23900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CE676E10A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5DC281F5B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59929440;
	Thu,  3 Aug 2023 07:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FE8F78
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:14:30 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405AF2D71
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:14:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58440eb872aso7156947b3.3
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691046868; x=1691651668;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lDdqPrRDqdMbZv149TiwZ7bESjJ5cNtj5K7U0z+veTk=;
        b=J0Woy586ugLmFBHtAm4fZr9oC+K7nUE9IiOVgEtL5IlPSlMyPdOQ0dAN7ZDgMKLObp
         YmQG1t/MtEv4LHpdilRg45hlz/zlbb6IS4IgjGw2fcqd4qCerBRuPhZfLIDZJnK6mrAw
         kvNNMCeVS+vJpa1qp7NQpDctVQLKzghQcI4Zlzbg/+gufgR1SZlky1RWDUHXbfkLvvi8
         UZm/bwJTOWhKNRHpiLhJpEIKzBrnpWWSiHCgIbPuYVOEpM93RgSQpbnmj3XaMr+bdCjk
         se4fUoBnCdS368CDNsdXsmYdpFvUvSe94BRd8XZW9knN8RcdAGHZbQaIZ6EVZCvZXE8m
         qwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046868; x=1691651668;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDdqPrRDqdMbZv149TiwZ7bESjJ5cNtj5K7U0z+veTk=;
        b=VJJq7hbg4n3TXTyJWP6JdUb8GAkGDzKC2NXSCNQDRZJBEP1mIJMwPhoHCPCsp/HEe2
         fmQPJ8LAkW74C1lJn0Cpm1cSA8eZ0foIg42W6wOqtebszvZhOB42hO3vWfsjQV0ypMOY
         W5Nft/3PjhykhJxewxHzh8dJp5wTd4AOHzGb+d4oc87CscBummZXhblkzagZKfLHlAd0
         en2LdjEOWQzF4dqeil4oMARGExfsYo7eD3s7vyfI3ji69fy4RpZ2ZYviSo3ifp7jqJyW
         OYdTK0j0Q8zl2Rh422oY7Q7SigbQpnELvP1aWIAnRQ0NdS3bpDRZeULAzCqOqjvDh1i5
         sSfQ==
X-Gm-Message-State: ABy/qLZ5KIt2msQrydwB3ir5Oo0rCbzFWq4abOmqq7NMkvmfKFfdyRIq
	Z2yG31KKKZeZ5e+5LMZs6T6Ux8/F1AufBg==
X-Google-Smtp-Source: APBJJlG/PF2P2WnrN72a9QuqnUxIj2HclxTotV5ItkJ9RlIVAsOvHkTFZesYwhWLQFN2NktHuhx2kJZ9YVnZcA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b104:0:b0:583:9913:f293 with SMTP id
 p4-20020a81b104000000b005839913f293mr161191ywh.1.1691046868440; Thu, 03 Aug
 2023 00:14:28 -0700 (PDT)
Date: Thu,  3 Aug 2023 07:14:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230803071426.2012024-1-edumazet@google.com>
Subject: [PATCH net-next] net: vlan: update wrong comments
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

vlan_insert_tag() and friends do not allocate a new skb.
However they might allocate a new skb->head.
Update their comments to better describe their behavior.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/if_vlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 6ba71957851e22829ec9f18cd29bea2d92dfa583..3028af87716e291cafcb4d67d89bc810344c9554 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -408,7 +408,7 @@ static inline int __vlan_insert_tag(struct sk_buff *skb,
  * @mac_len: MAC header length including outer vlan headers
  *
  * Inserts the VLAN tag into @skb as part of the payload at offset mac_len
- * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ * Returns a VLAN tagged skb. This might change skb->head.
  *
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
@@ -437,7 +437,7 @@ static inline struct sk_buff *vlan_insert_inner_tag(struct sk_buff *skb,
  * @vlan_tci: VLAN TCI to insert
  *
  * Inserts the VLAN tag into @skb as part of the payload
- * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ * Returns a VLAN tagged skb. This might change skb->head.
  *
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
@@ -457,7 +457,7 @@ static inline struct sk_buff *vlan_insert_tag(struct sk_buff *skb,
  * @vlan_tci: VLAN TCI to insert
  *
  * Inserts the VLAN tag into @skb as part of the payload
- * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ * Returns a VLAN tagged skb. This might change skb->head.
  *
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
-- 
2.41.0.640.ga95def55d0-goog


