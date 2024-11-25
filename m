Return-Path: <netdev+bounces-147252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E3C9D8BB9
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EC0163E95
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B991B81B2;
	Mon, 25 Nov 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="PYVqhKnI"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D55674E;
	Mon, 25 Nov 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557352; cv=none; b=uThUk/m0UB8df0PKJ+r6N0cir6HGEhvXKnO/yDLWgFfeCc8W+3HZQD/5fvu7u0UXMCeNUB3Am4nXsDpDQ5sDg5BkDd9RkOQ0eZaDvNFko3e2nV4wzJyFLq8h4z+9Bes1LNx4IEYAdDwE3fKSBrWj7Vag5efzchOX1yjaMX/jrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557352; c=relaxed/simple;
	bh=2n5055K35rCJGA6l5kVZ2fbftr0hbqsaeRPtwaIRXo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iu+PhTBvnXp0C8FO5nrT7enBVZVwPJ5JAn2UPPcgKvAyEpvTfoLovhvM5qjiDCUsSSfgX0Y1cynwkNHmw5a5FP+wJ4xKG1D4RdG77u57SVzxDdTtEe9tJULe2/AV56vriUFZLJDjYWjbnKrG5RmWu5u/sLuFRqcW0Azacb26JVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=PYVqhKnI; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4XxtRk4CTYzPk0d;
	Mon, 25 Nov 2024 18:46:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1732556786; bh=dCo82lIXi3PYVdCoMwds1sZA2u28NqGxUqyKmul0O8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=PYVqhKnIwS7kuQp4OABHHNpyo4aNeBMCvqQ58mDq38OiXkN+4VHhRMiIzHPf0X+kl
	 5c5pwZYNDgTQ94KiMkeZmJInTS5txsM2mwaeaEvepO64+ri08MlGWBppj52Y2XQrPY
	 SC1OX3TwAYqWqedpPsPq8ZHay9M2/HcY+Tmot2Xuj1vqymJqEAwAPEwnq9DwZ0F0dG
	 s7/CwOacJLPdaztzOK0bIPczlpGkW7dZ7kjl2jB4k64OdRQQjjuu1/M7k7alGeP3CZ
	 4M+phd2MeWm5uIeBZxLssTvfELrYvBKISNkqOn0p2Il65i+OzHRMgkTH5BB2TFCTwL
	 KbsLpm2+zzvTA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.47.107
Received: from faui76b (faui76b.informatik.uni-erlangen.de [131.188.47.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19fnl6dDoLwzjSJCuyQ3La9nObZS0jylbs=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4XxtRh1Hy3zPk2Q;
	Mon, 25 Nov 2024 18:46:24 +0100 (CET)
From: Martin Ottens <martin.ottens@fau.de>
To: 
Cc: Martin Ottens <martin.ottens@fau.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net/sched: tbf: correct backlog statistic for GSO packets
Date: Mon, 25 Nov 2024 18:46:07 +0100
Message-Id: <20241125174608.1484356-1-martin.ottens@fau.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CANn89iJ7uOuDCzErfeymGuyaP9ECqjFK5ZF9o3cuvR3+VLWfFg@mail.gmail.com>
References: <CANn89iJ7uOuDCzErfeymGuyaP9ECqjFK5ZF9o3cuvR3+VLWfFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the length of a GSO packet in the tbf qdisc is larger than the burst
size configured the packet will be segmented by the tbf_segment function.
Whenever this function is used to enqueue SKBs, the backlog statistic of
the tbf is not increased correctly. This can lead to underflows of the
'backlog' byte-statistic value when these packets are dequeued from tbf.

Reproduce the bug:
Ensure that the sender machine has GSO enabled. Configured the tbf on
the outgoing interface of the machine as follows (burstsize = 1 MTU):
$ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latency 50ms

Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
client on this machine. Check the qdisc statistics:
$ tc -s qdisc show dev <oif>

The 'backlog' byte-statistic has incorrect values while traffic is
transferred, e.g., high values due to u32 underflows. When the transfer
is stopped, the value is != 0, which should never happen.

This patch fixes this bug by updating the statistics correctly, even if
single SKBs of a GSO SKB cannot be enqueued.

Fixes: e43ac79a4bc6 ("sch_tbf: segment too big GSO packets")
Signed-off-by: Martin Ottens <martin.ottens@fau.de>
---
 net/sched/sch_tbf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f1d09183ae63..dc26b22d53c7 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -208,7 +208,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	struct tbf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *segs, *nskb;
 	netdev_features_t features = netif_skb_features(skb);
-	unsigned int len = 0, prev_len = qdisc_pkt_len(skb);
+	unsigned int len = 0, prev_len = qdisc_pkt_len(skb), seg_len;
 	int ret, nb;
 
 	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
@@ -219,21 +219,27 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	nb = 0;
 	skb_list_walk_safe(segs, segs, nskb) {
 		skb_mark_not_on_list(segs);
-		qdisc_skb_cb(segs)->pkt_len = segs->len;
-		len += segs->len;
+		seg_len = segs->len;
+		qdisc_skb_cb(segs)->pkt_len = seg_len;
 		ret = qdisc_enqueue(segs, q->qdisc, to_free);
 		if (ret != NET_XMIT_SUCCESS) {
 			if (net_xmit_drop_count(ret))
 				qdisc_qstats_drop(sch);
 		} else {
 			nb++;
+			len += seg_len;
 		}
 	}
 	sch->q.qlen += nb;
-	if (nb > 1)
+	sch->qstats.backlog += len;
+	if (nb > 0) {
 		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
-	consume_skb(skb);
-	return nb > 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
+		consume_skb(skb);
+		return NET_XMIT_SUCCESS;
+	}
+
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
 }
 
 static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-- 
2.39.5


