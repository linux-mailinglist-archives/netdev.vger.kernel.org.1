Return-Path: <netdev+bounces-274684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBT6FtrPzml/qQYAu9opvQ
	(envelope-from <netdev+bounces-274684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0138DE87
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47DB1304D3CA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620D38B130;
	Thu,  2 Apr 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oBNDmCN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918E3876C7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161258; cv=none; b=YuXprONSh8S+ji9QTuTTBI4Atu3HtqCrtmTRaprhN/bUNOmwJoHpBHcRAOvGnC8GI961X7igG6tZeC38UydaFKQSbCuVCxqrtpaHgMjdXBP9E6ecpSTesnyLTiAROJ9Bs7PeLL9ZFrjzRCr0Z9CgqMUdpeLHTg0g60n2LxlRIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161258; c=relaxed/simple;
	bh=zHSDf392FBH2t9Nrhm1eNRmcRLYHbca7AmwtdKxuKvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keDKhB5eXYtCcS0GwL/7s4YG+u+hbbZOmURyjJQvrpTi3dgW9egK9DXuI28zvNh6xItyPpU9B6Iuw/0l+4t6hNDhQ5NcVzotsVwW0YbigaLnv6/4GCuI9ac1FM0iDoFTYtucC5d8c3hVVhb+GY3jGgLtRfR4gJsM+XnQ7M5cny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oBNDmCN8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c757a9251faso435497a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161256; x=1775766056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G61P/m9u3BT/5+F8jusY0Eb6hWkK7ZCe5ypTAUB+ck=;
        b=oBNDmCN8JmMMoCVfA45sbKxLns+8+J2VmsJIegpUbO1QQthMYKjtcBxyxOTujVTN8h
         kZR8frOklInpuxfdYluf2wB8E38An+mUJOzOFcYazTAzQMPy4qPJq1iejK2rpQl3OBbj
         cTc2de297bplAoK/7r+hkx9ryvApYQ8jEh/wlykq7gmFPluiHwxY+mG8VR4TUCJPOXwg
         wYQpR+9sbBHvQytAGudgxXvhS+Qn5WRHWdddqmoIgttYwQILL8E+LldcdHN5VvOqR0oT
         +JHhvyQXqw9Wj85XKObbsq1vP/G5KTh2DTf51Y3ZFwu+s74b3H+9UIPkpOlA2dF5Xg8C
         h1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161256; x=1775766056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G61P/m9u3BT/5+F8jusY0Eb6hWkK7ZCe5ypTAUB+ck=;
        b=BUA6XT0QvrJkzFS/tHx/Breapbro+08dAyuYd1DQVzYMNagTrYzmyC8u6aVkT06lF9
         ctZ1LUWBsk6DbkSJLMB+vibL7b2HPUME049HE2mm6KB4V8aNGZN9BHIZl9LCroKiLCur
         QH6u+G9lk779NS5i4SJUdnX3RjQw10qHH5aXAD9sTFj3VJEoirbt6wdmcoR3PswEUkC6
         VBVj48gLapcZju61dbcXAi3yv/UlSXZrVII06+1E08YVNSgPfm26nW2VsAZzKFuOCubj
         IhwJe/o7akOrLPhzmpNoTKgpyOMNeOROEmGkYYYRyWheQAx6yBjFuQ0wf5AvnPKBKGJC
         5FFg==
X-Gm-Message-State: AOJu0Yy2AX5VubWbyt71P008nAEbqGZPZpu/8d2pttZV+y57UHf5x+UD
	37Ahe8NZ2UEYVQO0cC36L3rJEvxHy65/XRfaBDPnx+7+xhH1bzhKO6HvHLyXqbIdTxo+NbZ75+L
	pzVkQ
X-Gm-Gg: ATEYQzzH56Wl8kBsQELv6KjkFvGVLIQ56hRc+xn7ZPlUBk1l2JTWSeGvd7XM2wweytY
	E+wfgAv0VOeobdUGzHGkKS06tVfr5lmPL5GrHueMWzkcv2/7RWftYfhtYP9P/ONV6NRSr1irr7A
	VOfWNwZ2ZaXz3WmYMb0gt6XvjFdBK/aAoFEczIchrBVWYPB+irF1+ucjWMwo/PEpAU2BG9rhQ0E
	PS2QxWWkjaf8Q3BYY6tHEavvByRe8Q0eJoJxuqHhEEins39s5bpf2I/Wq69ftkBXu4ATPDstnMX
	z8MdvmYtm/NjYx4BEDoCZvqj4sU3F2nYRpXABXOZ5XdDlam7m09IwRAflO2n7kw9brVmMadJphZ
	IBOIkIn1akqnSRnzK0a3GwJBBrc5wujdrqGMMWupwt+TGnLIoVuKWZWW8/ESQZxwEp7cRLlq+Di
	bftRnPPKqDk+74oMUPuCUY3s0ILQaT0JRJw8NkKOWHXgc=
X-Received: by 2002:a05:6a20:7f97:b0:39c:2a9c:bbe2 with SMTP id adf61e73a8af0-39f2f112c9bmr269724637.24.1775161256553;
        Thu, 02 Apr 2026 13:20:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:20:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 2/7] net/sched: netem: fix queue limit check to include reordered packets
Date: Thu,  2 Apr 2026 13:19:30 -0700
Message-ID: <20260402202037.176299-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274684-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3AB0138DE87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8ee72cac1faf..d400a730eadd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -524,7 +524,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				1 << get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0


