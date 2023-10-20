Return-Path: <netdev+bounces-43104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8907D16CC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BD1F22A5F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C91241EF;
	Fri, 20 Oct 2023 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePgaLfsD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D81DA59
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:12:58 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230471A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:12:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c5708ddbeso1662708276.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697832776; x=1698437576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tbRANV19+SY7JN536voJGVh+vsBlHz05Qke7b00EmIQ=;
        b=ePgaLfsDXD0z95LoDZ6bM9YEMO8xri4037KFPbQoEJH17efsuUhDdo4Fz41WQVuACv
         qzhtyRp/qeViwPvQkGDHaClHh7aeZiHOwhS8Of3UpuuhfE1qMcxW/Dkv19o/aCqKmOmx
         HZAMEmDB9GffkpUhpVwjnm5vDq0UW30BFoPew08pd/aDaQqhL0R8dLLYC67HTGMQ1XuL
         MDHQQ8Rc+pruq++iLKIo3ReMZkodPX7CaqhJOIF6b1JHDJvo7O7NlHEBGmM6Hlo9dtrn
         LbM0cWU/TaoYEDBcqWL15JtzIRpy9hek9UUENc7CZltgQR4cfL/N+lM+QZGrw4erZ9i5
         q4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832776; x=1698437576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbRANV19+SY7JN536voJGVh+vsBlHz05Qke7b00EmIQ=;
        b=DdFteeBYL34GND2qNedfjHX+lzodDXD27a7R8LYppDQ1EQq6XzUciX0X50ZK6FtVoS
         PflQ7NDYmtf8VFxN/h0r6Sp83f51PDAAIE2FathcQr8kExTIv03KoJVw2rGjVCr7olQm
         n5rS9Mrmw5sCPPdFdwYYkjxurHPLvbB1wOZ1kE/rHbFn41C1qmcfFjsWFFSNhG+lm+pj
         TnW+Pi/ISC/dAPq4TbdZGL1RoZjSx/d6WAUSuSHaHhq7/kApfHgu2rWVEjyyfMC+ZQEc
         dSKuGQTpuO9pgoy78VePZBXu6VK3Q4I4xVTOibfZ+q42QW8PyAfUTg/ehMx44u8HV/iY
         TDjQ==
X-Gm-Message-State: AOJu0YyJFKDb0EEd5zYCLSlRt4qMIOWkJUTIclhPxO5RYNX5MdeoILYF
	IeYm14/rNiFzwSz7pJrAuhB9NNEGkk+XAA==
X-Google-Smtp-Source: AGHT+IF/+JMl7OLJQcXfITXML4wv+vYxLOwEmvOB8Hlp6+M8i//Zo9TNPSU2yTFi90KHtzaAvR86XbqyguNQFg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5c1:0:b0:d9a:b957:116e with SMTP id
 184-20020a2505c1000000b00d9ab957116emr61569ybf.3.1697832776137; Fri, 20 Oct
 2023 13:12:56 -0700 (PDT)
Date: Fri, 20 Oct 2023 20:12:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020201254.732527-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: fastpath needs to take care of sk->sk_pacing_status
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If packets of a TCP flows take the fast path, we need to make sure
sk->sk_pacing_status is set to SK_PACING_FQ otherwise TCP might
fallback to internal pacing, which is not optimal.

Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f6fd0de293e583ad6ba505060ce12c74f349a1a2..bf9d00518a60853b27910c47738509c09d53bf19 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -383,6 +383,10 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 
 	if (fq_fastpath_check(sch, skb, now)) {
 		q->internal.stat_fastpath_packets++;
+		if (skb->sk == sk && q->rate_enable &&
+		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
+			smp_store_release(&sk->sk_pacing_status,
+					  SK_PACING_FQ);
 		return &q->internal;
 	}
 
-- 
2.42.0.655.g421f12c284-goog


