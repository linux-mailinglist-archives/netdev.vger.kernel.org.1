Return-Path: <netdev+bounces-275668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKMICaXt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:30:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0D3A5B33
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4FBC302C6C7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB763914FE;
	Mon,  6 Apr 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="W8jAAFY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156F390980
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496432; cv=none; b=OuELn1nS6Xh0qxQvrLh8AZyiT3azW6cterMMRpZefVSmF4MTecsw83Hq/gVicS57E74UUZlT9Fi46SaNOJjar59V8lWuEg6bpNFjoYqzfVqt2/XIXL8UV8iATs3fTnFhU4uE/ZWtZ/uCpNT1c6tCzdPKKioKYzcfq93T2FmXiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496432; c=relaxed/simple;
	bh=5YCXEnHRJFYjEy7V9jKNKGempavY6ywCBEhhVcF1uv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IT54i95jqeliGEAkg8MWm+bMmco7jFv9nA69hYv2QPAGeCYbzE9oG4HPIMy3wPGpwgsWrSs/jk1rH1LrzKPpIb2noQoKYYO+aBODcFsi2QYeDnmPvhaCVP403acCrdtLmBzxbpyxWUNfXLBiPWa5cSio130NMTaAn2LaWxn7X5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=W8jAAFY1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2addb31945aso30587305ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496430; x=1776101230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP9KeWLmEV2l4kAT/5/4FqG1QmB6/9SDBcYliDxWRQM=;
        b=W8jAAFY10nh82h2NX2iBiAY7H/G3D12KOn7yj5tjxZka1zIrivLQpSiGQaQq/bah0F
         1sGX2zvUtzuxxRc4Y4YzXix4Fiz6PzOWlK3rplFLYFrlDC62/NLI5YKitbR/fAq7Wr/X
         k9nhdxz01qwq3S+O+k1Ea6YhIsvPmYUTo8BbpVfOHFubdohdB30Bk4y2+sDgixoaB0Tb
         CPSSyL0u52zjCEXmNhyCnWds3P5T4ydCqn49U9NXEmNuzQn6GuFzxqmSJXUWJ1hjIEtx
         x4e8KxRwyTcQ8uhnJFXrOwBxuW/NJpLLmfrjXIVp8OspgUCQHz/ZGj9Tx0/b/Aj113qp
         jwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496430; x=1776101230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TP9KeWLmEV2l4kAT/5/4FqG1QmB6/9SDBcYliDxWRQM=;
        b=fXROUN5VRd9Kd+YlMUXskeB9Qb/CORbd8uWWIFRhY2UGDdr/fog0urqZsTxVzKvHOd
         loTazLCqaDlz0+gabgpk8Q4urdZVQU+vsz/hJMGZwuNnwp7HDELPMwR2vnZJmcUE55xY
         wt/ZipW88jKwUJZtcMFk/NNuOGK3sH00fgPu1EBzD0cKZF+544i+p3LNAB93Jy3APcOc
         nykNekNrrz3rGTHsS8eXS21LUTO/XgbLN64h9NIrZcksadaJFlMbvk1ChupEDqtTgZJl
         h0q1wzZtNtOQVL+Vs+cfQjaj3K+KjGliceFv6jzOvbGcjvpgjSMPYom9m9YUIcN16JK9
         5uqQ==
X-Gm-Message-State: AOJu0YxgaNHiWSuOXN7rhC0j3Fb4MWvk0WGY0zONJXuKZ/8DendMl0oi
	MKXZy89EXtsIkK33txiB/WaBu8OSndwXrT7d2eFqk8C3cyIcl/Z4fve+g4efDGX6EZOGF8WsDZc
	NV7VA
X-Gm-Gg: AeBDieuPvKb7FR8szFxnIPRddXCuXMZoP2n8vUBLavpp/OF7GPf8XAOZ8BUy/tRYXDr
	6DmN1dbfxXhfEvlK3zVv5sYFTfq98g6WhUcV1WtLjusQtui+3p89Ye1DX33uV4DDBX+rj10EUnJ
	C1/m/aHHqAJMddNbYcklwXfzE2KO65ryGxFiG2NFTMrjJD0Vr5G701ABjyRVfiVMga9LrcgwzyY
	vS6V6pTSSoYqTg9m/0F6+SjNjxLoUpjebQ6d9OyfZbxDW9o9ZptI2TyczNJK8tk8DnGbZ7BkAx1
	PBKOkg8hS+RYdn4rUJldOJ+4O6DAkb/F5iQe22HbohZkDrhRCQg/kyj25NxEElVADl1jbSfF0YQ
	DUg0BmcIGV2nzOJaBCv9xnH+QSLVqcROEfo/CY6YhQEtvy5OkOz99o3zDThoG183gsX7WbyibqY
	mbqJWjcxZamjdjEktgTY8+24hxCwS2nzn2
X-Received: by 2002:a17:903:acc:b0:2b2:5042:dd22 with SMTP id d9443c01a7336-2b281935ddamr144960925ad.34.1775496430598;
        Mon, 06 Apr 2026 10:27:10 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:27:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 6/8] net/sched: netem: null-terminate tfifo linear queue tail
Date: Mon,  6 Apr 2026 10:25:14 -0700
Message-ID: <20260406172627.210894-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7BC0D3A5B33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index b93f0e886a2b..e405bf862163 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -398,6 +398,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.53.0


