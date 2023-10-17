Return-Path: <netdev+bounces-41920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DF7CC380
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B5A28195D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F633F4C4;
	Tue, 17 Oct 2023 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Alchtysp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EB3D994
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:45:35 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6095
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:45:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so86971917b3.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697546729; x=1698151529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrMhmvGp/H6j3Xg6VLB8FAox2ke+eSPgNnnniqEWCgs=;
        b=AlchtyspKmE3OnHIfpVoDV5f7bvX+PyE7lANVkQrTRhICQRAU9knygu8+k4EUMUVrg
         fkYmGYyWPBNO8auXmOn09coz8q/Yff4FlIJyYLskNOd5WYCObFRIjXUnVsBpxoaHmWxw
         a7iBtzTvS07RpJ58mRhn6PmjFlkFDKRfVeZa0qBKkrsbQqytjNSsQK4XM+LwE7rvNYZO
         d3dhUYtgUDWTidDMXxRNN5eWKGfYfF1ObJKPFBeFRgPdSxt/P5JO+aVJVCd3D6Fm1d16
         QdEleY7o9m6c1konpYQeiHPRBGLb5RVYQG8aApTrzLloiWeyUjSqB1bIucgXI7yJvD7P
         9g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546729; x=1698151529;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrMhmvGp/H6j3Xg6VLB8FAox2ke+eSPgNnnniqEWCgs=;
        b=w3BdkRBBRYFKXX5AeON9v4nqrCKihBPxR5aZi4siLxeblETb2Uam4aIwkWFt7TsmUf
         YXmU4AwlQI1Rgj5cdaFav99YNIIY6CMyc+a4GLry7RZB9GnxVvv/A69zIGNkJpNTNcIf
         TVYuzaaQU1VmFgsctQE59+Nbm2UqF9ewo/4sLlk2dYPi/oGyknehZpWCe0tQx2ilAC0i
         rBBppOjzQsy+rg1CiqIKhJW/PKJnXxqxuHHNk8j5A4vkamd+XQgIATbX17DU05LcOy1W
         mbPiM+TyBn2aZe8+URDNyBYjoCgV+z6MuQJayDb/i+AKeOZWvBFsJv2vqLVhSCFhRdSg
         XlXQ==
X-Gm-Message-State: AOJu0YwclFoinUGUPnu+wUMG5NZeS9y3YhzkTRjcgVwrTPV6SdTNIyUA
	xuH+AWyi1IoFaqa2cvGY4f77WmVT6Ol3Ow==
X-Google-Smtp-Source: AGHT+IHQKO4tBRmTolbzNRuzLZUJgfamZstDL3syDaIFgTtDNSeEcYFkol6DsEMJaSR7CFoNfEQaT0NTg5cB2g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:cccf:0:b0:5a7:db29:40e3 with SMTP id
 o198-20020a0dcccf000000b005a7db2940e3mr45365ywd.7.1697546729173; Tue, 17 Oct
 2023 05:45:29 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:45:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017124526.4060202-1-edumazet@google.com>
Subject: [PATCH net] tcp: tsq: relax tcp_small_queue_check() when rtx queue
 contains a single skb
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In commit 75eefc6c59fd ("tcp: tsq: add a shortcut in tcp_small_queue_check()")
we allowed to send an skb regardless of TSQ limits being hit if rtx queue
was empty or had a single skb, in order to better fill the pipe
when/if TX completions were slow.

Then later, commit 75c119afe14f ("tcp: implement rb-tree based
retransmit queue") accidentally removed the special case for
one skb in rtx queue.

Stefan Wahren reported a regression in single TCP flow throughput
using a 100Mbit fec link, starting from commit 65466904b015 ("tcp: adjust
TSO packet sizes based on min_rtt"). This last commit only made the
regression more visible, because it locked the TCP flow on a particular
behavior where TSQ prevented two skbs being pushed downstream,
adding silences on the wire between each TSO packet.

Many thanks to Stefan for his invaluable help !

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Link: https://lore.kernel.org/netdev/7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net/
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Tested-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 net/ipv4/tcp_output.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9c8c42c280b7638f0f4d94d68cd2c73e3c6c2bcc..e61a3a381d51b554ec8440928e22a290712f0b6b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2542,6 +2542,18 @@ static bool tcp_pacing_check(struct sock *sk)
 	return true;
 }
 
+static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
+{
+	const struct rb_node *node = sk->tcp_rtx_queue.rb_node;
+
+	/* No skb in the rtx queue. */
+	if (!node)
+		return true;
+
+	/* Only one skb in rtx queue. */
+	return !node->rb_left && !node->rb_right;
+}
+
 /* TCP Small Queues :
  * Control number of packets in qdisc/devices to two packets / or ~1 ms.
  * (These limits are doubled for retransmits)
@@ -2579,12 +2591,12 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 		limit += extra_bytes;
 	}
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
-		/* Always send skb if rtx queue is empty.
+		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
 		 * after softirq/tasklet schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
-		if (tcp_rtx_queue_empty(sk))
+		if (tcp_rtx_queue_empty_or_single_skb(sk))
 			return false;
 
 		set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
-- 
2.42.0.655.g421f12c284-goog


