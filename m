Return-Path: <netdev+bounces-278799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGylCOKh32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66580405553
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A4C312BBDC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182E3D47A9;
	Wed, 15 Apr 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="afValf8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC0930C631
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263317; cv=none; b=KTRZcpbUykUrDSyhdVQJlulYk+7bzjmGZmbAmBtZ5rb4iBxtyD65zgq2Q3gdcifjX/VqBWWloRfcChNkvYpyUyaKphCdpeA47tQTHQ9mi4lpL7gE8PzxCUU3LWFGLdh4vvwudxQaJJhceGyVBDm+54at0h5YUAJkFMoNfs8FXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263317; c=relaxed/simple;
	bh=FZvQ5dp3yny1rhDpsZzJK9XkQc0x4ErCdQQm08aaM6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7Ptj3KC+8oksyDq87GYJsTsmwHU9kWBWFPYuKNV0+oTA2z2i3sem2kBj6fHApcKxyBgMQGyUTmB9s/q4IWM7uiPfPXYCkSGjdPWlpHRzUsjhA/94SYVF9S2cHE/BC0Ulv3Vkq3d6qHV+KyE2Jg8Y1V5suEanOTkQHybQ/Rclqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=afValf8V; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2dbb4ad19a5so548755eec.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263311; x=1776868111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9vAI0tP5MX31d4eW36YGF4ATSl3Z0+fZABgVczZ6Ag=;
        b=afValf8VSDZepa3VK7GXg511rKqunqxTwd+PWSydGYaBl0RHHe6yL4owlkivUbeJHK
         djVAXa6xHNbFlPCWZFZZXf4SyP/yuq1gHC8vxC2U/ypvDL8lYw6XcqOf3vsVNzTpZGOt
         0MTtQgllkHud1fB9J3nCUYOZYV+kfuBsna2yv/Ru02m9rXYmphHcYQD7ELdveYSeCPuN
         pA7wR8MPXWdGm49M9zUysU0zHN0niEF53M5x5LqPOefPlhvwviUD6p4zM2o07cfwSd6I
         +t/boUa9xVRtmTRQ0N8FicZr392RkCW6bIkjuwp7HPuBSkNyitgOqM8njohZq6F7ACOQ
         /pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263311; x=1776868111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9vAI0tP5MX31d4eW36YGF4ATSl3Z0+fZABgVczZ6Ag=;
        b=VW0vMyn3Ua5Suotw6advvKzO/VyrQ9nfG39ltfyzM++qXBuUTwC6bjWjHWGPdakXKo
         O6wB+5fFGP+/V/YrpvQtnLNFHSh8VS/A8c0vyXxST6ThkfJfmtqU891JGLgjW4Mt2hLT
         N921QDkHQ51Jbj0Hm3lPb9UNNDmaWEjb8ywwG2E/4VJec+vkV8mHUc7FqQQ0Z9ayIBJL
         ydRcCz8Ja0oHGPmSGgo2x+xJVDfcEvSrcyuEwlK+mc1AAPB2J31+J+7pR11EL9S5DGaz
         c+dmsVVA/Q4EI7/jjL5OErZ8NJ7QFM+HCUpXw0kh0bhUmohV2tlAuT15GCglFq5gGtO2
         5bgw==
X-Gm-Message-State: AOJu0YwJPn0slePDn8GQ1mGgPALp4dpnOZU4ssaSyf9hG5oAK8S7mnas
	vb9ozuIW6Fv16oWSCp9KUh9FQsrt2UolBq6deez6UGMONtQkSc7YARbE+5xJ3spk5zgCVRPPttZ
	92aln
X-Gm-Gg: AeBDieuefEiTjjtZYJmXfP5B9WNGIxa7kSA2A8ep93KiBWBk1wW+O9WGvkLK+jwJN7h
	DgK7mex6+0lJLrPlTfNFRGt9YirT/0NkdsQ3vbKNPodRVOwYdPHZCEBBgqykhKilbxsCVu9Bu2r
	viV02k4PJtSfWW+7G115bygdhgQGrf4RxTq5Dto4PufHwJKN0emzboNLbj3FLbjMKFpsZJkOn/k
	2nWb8SobgFCFWiKl4D3OxuY/g2O3j7CmmJM72rN510uiNCqruL6BSLLUdlLb9ODijvyZKwfC5yU
	4kDYNKkbqRn15Y9nIwJitdWzjVESSrYXyzfQXzpBZaDLNi10CBUMdu67uu887kDYXnd5veGiHUb
	y4tbgp05b/8WFS8Uc+4qLiOUQIab88q1H30+XD+3HqnsNq0WocDMEyH6jZ78syUsxeFXI3eJenl
	Qv0msHSTJnazqJRH6p6gCvbLQAkQXiXFRkAjt5bwqxHl0=
X-Received: by 2002:a05:7300:e614:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2d589463d7bmr12192842eec.16.1776263311122;
        Wed, 15 Apr 2026 07:28:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:30 -0700 (PDT)
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
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 4/5] net/sched: netem: check for invalid slot range
Date: Wed, 15 Apr 2026 07:27:07 -0700
Message-ID: <20260415142822.133241-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278799-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66580405553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject slot configuration where min_delay exceeds max_delay.
The delay range computation in get_slot_next() underflows in
this case, producing bogus results.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 556f9747f0e7..8593e62f3c6a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -827,6 +827,19 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr,
+			 struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG_ATTR(extack, attr,
+				    "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1040,6 +1053,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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


