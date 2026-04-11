Return-Path: <netdev+bounces-277665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD0wOqna2WlOtwgAu9opvQ
	(envelope-from <netdev+bounces-277665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:22:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2083DE6A1
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354443093376
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF292E5B09;
	Sat, 11 Apr 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="DFOrQShK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AD1C84C0
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884671; cv=none; b=ltL3YNvx1CrMH75uKv5Q0OYsuAYEOo9llseDsq7Yoq6iFpG8MTcacGJKe/2cChoVKgmwaV36MosU7ezZ04afX3nmi3iAT9jl4aBLPGQHW3MTYVNbZIgR+Gnty+dJD5K2RpBL/ONfK5/sbjHsCaKwsS1h7mYQQmGo01e3zMaUi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884671; c=relaxed/simple;
	bh=79RnsSDlOuyKR9FRmS2O236CyV1bUaKZUHE4y+VD0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE2O2c8K+MvlIBswlYOMvzYHaOM+fpDpVVeF62bcAzWsVl0ruD8FRvO0SNfBIB9wofji2Ot0oKcD4+KGT+vwniALqzIgksAil3T9b8r0UuFLgRdo2mTB+DaPlcnvRfUEuAHmlgma1Z1JaoXkAoq3jeOj9TaVXwwbZkEmuyhg5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=DFOrQShK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76ffd06593so1878362a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884668; x=1776489468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXu+gMqY1PxnFCDMjvZJOrz1nU7krWad/cy1/vfx/AI=;
        b=DFOrQShK2TBg4T1RlY7o/+iceXZcpU7NXKbFUFPOtUo9g7TOQFRt9dA7LN324fXnFq
         78AJmC+u7YrGBdyZ4gtKWRn183sZm9Nxp+LXFoYXVtLFT6uK4LZ6FOYoKyLzKBaJ84A3
         yzdyyPkcpPEqtmJv0Ryl7xmElVteDQj1dJJ8EbXcAQlnHbfnZK2jnm2xflji3dRNNqKd
         0o1HZQsxyrm1BZH/d51YK46V3IocQB3p1oyD3Oqt041hBsz0CqbAFOInu1YHF8SJsW9w
         U2Fp24VdizzCbfV0ZPbdAgHEATJICALxSBs3Bw5EWz9o50FtPGkvzvdNa9Ler0yB/uAJ
         OdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884669; x=1776489469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXu+gMqY1PxnFCDMjvZJOrz1nU7krWad/cy1/vfx/AI=;
        b=XJ/zxxI4Wx0GEqeEzKj1F/lc3BcXkCbFb7MVidiZjpb8fUnk3+l7s8bAC7dBkrchrV
         Rl5hBJsf6Lyv7u8ym8WzXOeyPfBL9h/ZZ9UxlIuRl+7MQGneEirxZ98SDhm3EQFZpFL1
         JrgVHmncqyUdTr7DJZ7NkroTlhi4roAGypQ0XfkNHxjS++kZFNL//adOn0Qr1M0Kwmx4
         JnS1XDyPRgdchyrjYvaK6O9awcI2C9DP8XVVxfZdlixXXj7BV5TRtCEpgVu03AFA9Slh
         n1A9aOZfz1VMB/Td4D0M97TBHO/H3e4n5862VT6tfRiFjuA4D/aLLRmTba/QF75hv1Wj
         nH+g==
X-Gm-Message-State: AOJu0Yz1G/hbmhBPk/nz6mNE22ahWwoK5dVE+KsjHepyovWe/UNxoGYR
	m1D9zcfzuGErnPJ+thMegjwOce6t8ue57beFcMP4qR8o2hKN9P3l5VzlcOvbMpua0X68AiWRLls
	2uc8S
X-Gm-Gg: AeBDiesHTCwFUmmm/mU6EZENfDglndVCreOssllodRLx4GoCAoqvedY0WERSt1WJGkT
	8PnMu8NIEL0lLwFU2n9NPkv8hqL+akbwMIkxf4X/vbAFJS8LgSHNqr+/MaRDD3howLDD/JjW0jY
	+zzyKsZcn6ERxFLBpnWu9h74qImG3X1WQ0gvbI+gpx2s9w4fRk2UgTJNAEsX7hzpqbRH+ek0GYq
	Lmuqv4OrAxwa54dKZS+uyNX77wSdrwuS08CAxLIFayFvEY0VoSSfB/hZnvNOXrBbkCnToW80LRI
	LsQAbz/OzgKbmSCoeWZmNttuqgKEWdPNs8bn3r6sUzGxZI4/eyPpp3Qh9D6TlTUf+0mbGougN54
	gurvBbxeTXD8FIkFSzmNz/ZBMySaoXnWmJneTgBB9l+5fxBP9xSX6ey3+DZrWZ0GfppzVf0ODTR
	tVJOVJYVteZUGBvsmOB8e29Z9+MI4hIvtt
X-Received: by 2002:a05:6a20:2450:b0:39c:8c0a:d09b with SMTP id adf61e73a8af0-39fe405752emr6399589637.49.1775884668652;
        Fri, 10 Apr 2026 22:17:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:48 -0700 (PDT)
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
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 7/8] net/sched: netem: check for invalid slot range
Date: Fri, 10 Apr 2026 22:15:56 -0700
Message-ID: <20260411051700.311679-8-stephen@networkplumber.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277665-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 3E2083DE6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 14d22fc7365d..ef4965f20f17 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -888,6 +888,18 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
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
@@ -1101,6 +1113,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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


