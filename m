Return-Path: <netdev+bounces-274688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNWpBDrQzmmRqQYAu9opvQ
	(envelope-from <netdev+bounces-274688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B038DE9F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C12F307502F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D138AC69;
	Thu,  2 Apr 2026 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="II7DUCSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091D38C2CC
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161283; cv=none; b=ZTbNnHahZppjL2Jvf0oWfcjNodkPXGVoWINvGOpV87XjpteozKSqXMDrjwKLwpASEG0O1dJkJKYEkRkOCbDdNpW3eauZtb4tiSWrzG+hUj2bdq+PV5EWu5v/VWygQ5QqQLo9M3NYOmPffEa4SGWIGN/1Xm+9MN6u3PaEfVYGE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161283; c=relaxed/simple;
	bh=veoDLJv1nd00MNEo4Smqa3x26YINozGh+A8TpR9ek4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnECyITol7I46ZW2jh4XPJxTEO1Dz+3rCg9ny2Dpt8gQvIK6ThFxtkWc50L6dhqhdaymKAvzHJxYLAMOo5e+K8/5jvFTAmGdCWOv57jeg4I3c6ukA2ct5NvQ8BTcyTFtfRMVr7uasyfw0LalgsKWKEAg8zm9EoqsDXBmK3l1xPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=II7DUCSh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so374379a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161282; x=1775766082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Keo/S1XwwCUSey2BG9UA8DLrSOYQ1fHXb5rrdPGEzJc=;
        b=II7DUCSh6nkJ262gal4TQFhtgGD84T/AE0X0clKzdEvX8I3Cgbh+Cp1Xw/JlbXOlSg
         v1OXIW6NMQYc43xiRK9EBqJzP9nSWyJektnhQ8Bi0vts3lzPSyoicvVGsEM3qki7+Lzt
         RtzLiyS7DZu8sgJ18V+SiMrZRXFZlEAw3ccLu9JK/E96inxA+FZ1Dsd2mRU00sIlQgNc
         5LNGsukHgH725E29ZEwswDU7IMtsloyOlRqfSTTzfEt7aqCEj4pacjVoxT2VVrxlV0XQ
         mEd0paLAmtX0vXx8gF/kezbt3s+xB1KkFHYJi1y9QzCOcFL5mufWH2wrOOoayQu6QAh1
         hJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161282; x=1775766082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Keo/S1XwwCUSey2BG9UA8DLrSOYQ1fHXb5rrdPGEzJc=;
        b=izSPLMgJUeRoeUGC8JbRpK8gzOFOhGZoxTSIzoQ2rthqTgNNJ+TvPs6gjO/Vmuu1Nr
         IImqJ3mBpAVArToE8mQ+HY1EGACau4/NEPT6c1PDQuJMPtz0ADA5/25gi51kEIB8hWKP
         cqIsX7klMBNXcynwc6FWeFe9xWwLpTx1ZFRQTFe/KofBXOPj5ErtpfwlBSmIUmyPrd/m
         dKu23tFZoIi/X/Lvx1IySFUueJu3+s+yRhRSJALksGxWIKRp1NvUKdwpVB5aAj0ORO6+
         H2CllVv+1cE1kApIeozGckYNUVfkfHQdHwdNq6wLFPM2nlfXSEv0NBI1Aalkax3fwBRX
         DREQ==
X-Gm-Message-State: AOJu0Yxv7hRzF4eA22nOS+jDpZB/N7Baq73cbyFVtU0ujqE/RsUXn39F
	LNRzZyaRSXKpR0027wjLbz+zh+f4uHM5dTaLGsdz2PQcZExPoFoRChT3UENjwvnA7S1BK9+Wdqg
	yXT86
X-Gm-Gg: ATEYQzx/2DPxtVlLzQdv0Bh7WZgbTlPWsT1aYErTbayY/dzO5aQkjFe3IQ06LJ7LU/c
	EZwcyeD8crXa/txX4dC+W3orAkRT9kzoY+qYJ37H5qf0ntyN9FZNPfSnR+hayGPeYuoPzU3CC1P
	7rWADPWgLyoxJOUTrOjgTGpDhhN04iEca0Nvdu47rU0N8JQ98sSW6yCOIkrSYWxS6zrqE4gONDm
	+pL56htIyghze+R5r0XDIzM9x2uI2OnXDYzWM071PY5Wl7Lllky1IEk9XpMhsv0jTLfCwHbM8Oe
	OUW1Q6Lg2l8NiB+SbrICL+3L2Zp/y1I2aoeCK613FpLUcjJ3lKq3DIuoVJ1vCS119fNRhtXecYS
	rM7u/tkSISi3YHzPUYLsZs+08XjQg9adQ+M2f8Ehl2LziH3mbrxUNS0M/Sq9zlZBIjmm9xDNHfT
	ktMReZ7fNEzPvdIK7Zd189j7X9gDnl+akP
X-Received: by 2002:a05:6a20:2e0f:b0:398:ae03:722f with SMTP id adf61e73a8af0-39f2f0a28e5mr193011637.45.1775161281806;
        Thu, 02 Apr 2026 13:21:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:21 -0700 (PDT)
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
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 6/7] net/sched: netem: check for invalid slot range
Date: Thu,  2 Apr 2026 13:19:34 -0700
Message-ID: <20260402202037.176299-7-stephen@networkplumber.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274688-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A44B038DE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e405bf862163..c82f76af41aa 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -883,6 +883,18 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr,
+			 struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG(extack, "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1096,6 +1108,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_SLOT]) {
+		ret = validate_slot(tb[TCA_NETEM_SLOT], extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0


