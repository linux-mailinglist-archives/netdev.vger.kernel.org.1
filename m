Return-Path: <netdev+bounces-209758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A4B10B5C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C0B3AFD19
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66392D8367;
	Thu, 24 Jul 2025 13:28:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A062D77E6;
	Thu, 24 Jul 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363729; cv=none; b=Bhqpq7YEYN2dIfsDyHRsT7iqQ1Qb+9cq69/CxvHK0TPWPDYHpv5aTC4gbytwfzAO+dcwtC9zFZku6g7pwz42GiYoxhI2vZQ01s7gnSpSex/VnEpjAk/SSU7aQrrAW7V31o/rsx+XPEolg7Xp0yZecsYPoeV4G5YHUteSsX783ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363729; c=relaxed/simple;
	bh=fYPUXqFBbw0xpzxJxfrowRn/yVuViXf7gAOlAaYo8gs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=HcBALZI+qEO4ZPZQaFH6mTcT08zlYd/FyHQlSldv/PKg6NayruJBO/2sYu0lRi4P1uWj99Yo086giLes/JAgN0jdTT3maB6DtFbmCqtgZwL5LPbtwT94w65sb2wub/lCmON0zAdPPECz9o/FhIdmOuwMtKi2S6Ewb7IwBCEJGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bnsK26B36z501bS;
	Thu, 24 Jul 2025 21:28:38 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 56ODSYil097922;
	Thu, 24 Jul 2025 21:28:34 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 24 Jul 2025 21:28:37 +0800 (CST)
Date: Thu, 24 Jul 2025 21:28:37 +0800 (CST)
X-Zmail-TransId: 2afb68823505ffffffffe3f-08e37
X-Mailer: Zmail v1.0
Message-ID: <20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <dumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <davem@davemloft.net>, <jiri@resnulli.us>,
        <xiyou.wangcong@gmail.com>, <jhs@mojatatu.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSBuZXQvc2NoZWQ6IEFkZCBwcmVjaXNlIGRyb3AgcmVhc29uIGZvciBwZmlmb19mYXN0IHF1ZXVlIG92ZXJmbG93cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56ODSYil097922
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 24 Jul 2025 21:28:38 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68823506.000/4bnsK26B36z501bS

From: Fan Yu <fan.yu9@zte.com.cn>

Currently, packets dropped by pfifo_fast due to queue overflow are
marked with a generic SKB_DROP_REASON_QDISC_DROP in __dev_xmit_skb().

This patch adds explicit drop reason SKB_DROP_REASON_QDISC_OVERLIMIT
for queue-full cases, providing better distinction from other qdisc drops.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 net/sched/sch_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 16afb834fe4a..1e008a228ebd 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -740,6 +740,8 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
 	err = skb_array_produce(q, skb);

 	if (unlikely(err)) {
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_OVERLIMIT);
+
 		if (qdisc_is_percpu_stats(qdisc))
 			return qdisc_drop_cpu(skb, qdisc, to_free);
 		else
-- 
2.25.1

