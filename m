Return-Path: <netdev+bounces-277664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP0ELoDa2WlOtwgAu9opvQ
	(envelope-from <netdev+bounces-277664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D333DE699
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293CC308A95A
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC32ED16D;
	Sat, 11 Apr 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="s/A92jkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F0189F20
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884665; cv=none; b=MFuVZGrRhAzlZcCzpQuz/W8BorXaS3CbCoU4HQyoTbsm3qHlQg24Z7J8oIFw6EX2MsuNKY/43QH/y553VYCEVYiSXlUbCbaqBySHnGwXXiSexlyYnlEUlnt84AmGsC0Gmv4F1oKeZe0iB1jdASJ0Dyc5E+6qYfn20+17LTOaVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884665; c=relaxed/simple;
	bh=ZTNxYcl4br40HpvemEVYTm0MazZv42JwgYPDPSJKJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBgu6Gg85AwKAtfW5H6XqcmvCiTF9Or2biQFnT3MKHcAxIJDw95C9j5ChW+YJcFrH1vS1bOL4mNoXMggqNDMEs+aARf05nnWdznFBjlMEZcRpJT6Zfba72PskQaCVQUJq/AOqNiyk6xzasZlHLQYJxLZMt5DU8kbe6zMyMKUlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=s/A92jkW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f1f6103afso153682b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884662; x=1776489462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwHnbYKH+TONFDehgHpQ+nIp48wdb6f+qWIpTgXdCQ4=;
        b=s/A92jkWuFsKO9WfXH6CSvrGX36BozV8gY+uHgmNvIrfsA8whkjhY5iO3yfTpywUdJ
         6l6w2SUMRpLLnHBRdoG/YYL/nhcn93+X75brjoLgxw9M/y3FEWeU8DhGbhxzwULq2Lov
         /7YJyWOX+NLsMiSXcSeSyJZ8F5InJri3l5nsIGJuunYhK4hDLOl+FaJG6Ac4vd3uoln5
         kJ+xciauX/0JPdYJOuzsPDOH3SGAfIFucHBZvNRjp2bcbudSy9W157aJdVrQpP8gOBbK
         69+xmkcb8DqfeWZPFnsdNaWW4Ipzhquf7AjIBKS1z4XuXBOtf5LLbb482eOBvQy1yBTb
         4gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884662; x=1776489462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwHnbYKH+TONFDehgHpQ+nIp48wdb6f+qWIpTgXdCQ4=;
        b=K+zTGbms0bTkzz83L0gS5IHIgJKegD88CmgcSbfawrTPeff6Rtm7F3HGd0PpNv+YAb
         fa9UqSX84VORnqnxSQhJ/NmgtFtJ8ba7As9ambaQP5DDzITZ+QV0SpHVnLQpESLR3eCa
         KzC1mV4BtGMz3r0h9gpTUQfSNQ2HFkS9cMkIXgJImxXOfmABDtUn30inN/wdYLEruM2a
         M1ouYRdDdxDZP0r3XIIBzv9lKFaDfMHckllUwNAlL16nPp23f0kHQmts7sIoWBoQqrr9
         yeELh+ipCUat8Eb5KXGfkRsQum8nq+c7LtXtpiY0vSTdq8+s6WdlCmFpUVrDm8++9a6+
         kYQg==
X-Gm-Message-State: AOJu0YzY6b9WqbynfeiHOyhkY6JQVlOV3KsfE5txJpSBRicnll9HXyaK
	6tNlQKll7ek/gjsOaEwZQ3zGYlM2jtovLvAxYaOE852YB0A+Lvn/J+2JLKfk0cdzWdZgEWf5c8s
	l9SoX
X-Gm-Gg: AeBDieun2qwfWnfFGcX/vJwtfD+GlfCZzxhy7lAZZuf2yf832392pCuY73suuRgJEWS
	WKxK71OU9oEG7wDm3Q9hc1n5fyH284iUbi/yOcoAtJDZY28HfwQlVIqZiHjBx2hh9oA1mMZk8nG
	1amWbs4A78TDk7esg4kWyEamRbKXC5Ck6maU4O8Uz/8gUqrLnfq/IY7zo+LhRtmmh2Wo6lksUaI
	OBdxOcErx26wfez72s7TSxAVEUrtwECm6ryE7qxtgC0adTFmIE23zbSBDWQStTKKuTQyR3j1DJg
	p486QIeU5WTgkNadNi7kdujRT1AhqCflRIcTr/2Q6cA3wCSjrSy+b0qY7zePLl2LC7rD87fpwRc
	qisX5ghpI+Qyg9cCzBjt2Uw4LARa6Zp1DFezzUnwxYW54JCt0OGChz2nUAhzcgq0SHm2acc+ymX
	om9wS629DrY87Ug0CJUl750ZjxAE6oWEVH
X-Received: by 2002:a05:6a20:6a1d:b0:39f:461f:be7e with SMTP id adf61e73a8af0-39fe4002686mr6865742637.44.1775884662436;
        Fri, 10 Apr 2026 22:17:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:42 -0700 (PDT)
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
Subject: [PATTCH net v5 6/8] net/sched: netem: null-terminate tfifo linear queue tail
Date: Fri, 10 Apr 2026 22:15:55 -0700
Message-ID: <20260411051700.311679-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277664-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 12D333DE699
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
index 98931bb4354b..14d22fc7365d 100644
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


