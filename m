Return-Path: <netdev+bounces-147228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC99D8633
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F9B167935
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E421ADFF8;
	Mon, 25 Nov 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="NBNYps3J"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D21AAE39;
	Mon, 25 Nov 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540856; cv=none; b=MsgwQyykAb3bdDa1Vfw4tAPDQlwpQoiCup89+VkZTOhIvS5E4lzR9i15u26EB7mOs1urfqyqRJFJp6NkY9ekLFWesVNvk9JpnsGiLN3qbuo0nVkgXEJCBKRB4lYZs+5x0vDxYK9ZnPnRcf9s2oSkO7fk7JLkCU4Q/Y9qv6DxsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540856; c=relaxed/simple;
	bh=nEVLGdrVZPb6enKB7EY1THDhzmHqOu2kfzHjyYRrzkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8IG6CtVhaLcoiyAztFZxicbH6a53bjwVDoHHMGb4yfZ2RPdd/CoBxGQpVemTFjwGA+ovO5b0KeSrDggtart5JHoGTJk1kw8SyznvQJYELGeYElQaPKSI2Dkj/WggSSeUVtDP77u/VnAOBvfUUwYbQaktdteHM/DwIsx2dhEFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=NBNYps3J; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4XxmQ33NzRz8sgN;
	Mon, 25 Nov 2024 14:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1732540475; bh=s7L96CAwEKK5QfK2TjaVOwN2FZlsfrSEHf8b4H+HNBw=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=NBNYps3J6duIbL9N74MP7us9Tt+5PZZ7xnoiByEkX5+Ytx9KcVhPqgRrGkWnqhRLO
	 SbqWb8nX29JzxmEIAUzgj4T31iC8f+IdOLf4Me8nYBy86tF49Od4MAPW1FMXMJ+u0o
	 zOh4+YAijBJcGrlWRkQWJy9w2BZ9TUUgjdJejLEYbFzkhbOggpB2MZi/niRic0EOqw
	 GHxmuNlgWuCtYww5HJ5Kwc7Ch2J50FK3gXAyMtLbVbToEw9Zeaad/kIc8aKPJTsupq
	 GKgixmVprWU/c2+AKBibUPHE4ffxnQID7xWDyLaRFgryBEFtEypIEjZHajA9mhzaLo
	 leTnyyVXOnnkQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.47.107
Received: from faui76b (faui76b.informatik.uni-erlangen.de [131.188.47.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+XNSxb4JLlG+hslXpIVCWhXOsiQT88hzM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4XxmQ10rlfz8slJ;
	Mon, 25 Nov 2024 14:14:33 +0100 (CET)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: tbf: correct backlog statistic for GSO packets
Date: Mon, 25 Nov 2024 14:13:55 +0100
Message-Id: <20241125131356.932264-1-martin.ottens@fau.de>
X-Mailer: git-send-email 2.39.5
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

Signed-off-by: Martin Ottens <martin.ottens@fau.de>
---
 net/sched/sch_tbf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f1d09183ae63..ef7752f9d0d9 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -220,17 +220,18 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	skb_list_walk_safe(segs, segs, nskb) {
 		skb_mark_not_on_list(segs);
 		qdisc_skb_cb(segs)->pkt_len = segs->len;
-		len += segs->len;
 		ret = qdisc_enqueue(segs, q->qdisc, to_free);
 		if (ret != NET_XMIT_SUCCESS) {
 			if (net_xmit_drop_count(ret))
 				qdisc_qstats_drop(sch);
 		} else {
 			nb++;
+			len += segs->len;
 		}
 	}
 	sch->q.qlen += nb;
-	if (nb > 1)
+	sch->qstats.backlog += len;
+	if (nb > 0)
 		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
 	consume_skb(skb);
 	return nb > 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
-- 
2.39.5


