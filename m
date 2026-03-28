Return-Path: <netdev+bounces-272797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J3+J/gdyGlHhAUAu9opvQ
	(envelope-from <netdev+bounces-272797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:29:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBCE34F976
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA7403044368
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB51F872D;
	Sat, 28 Mar 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2zMUKeKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154038A70A
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722430; cv=none; b=S202oDu/HY50Y4D9cAMlF41AjlNZ08lIwnjED0ZAqXcIVR9XW/UQiVbd9sCp3PTPHCrQ8rmx7jP6Stisp1Emj/a0AGtk5JYrwzJlT/gXk6mAz5rcdc9mB+KXz26vln9OzRZiDuzWTwCOVAgW1VMz2qaDsGgQ/GLPodFeIaAKkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722430; c=relaxed/simple;
	bh=SbMycr43Tt7EpMnNW1TruZRz6ajQXZ0jSvvdx15ehwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byEg22GAxLeD89Ut9KtULqjKKyeVpyvxWDiO7v5Ohhdx1wLOV2v6kT+TlAI17DbxC1EQp60JcvInJMl/thta1UCX6ChE3vjO5zxDQwAt0UyEbYVuXEYJFCiFBs/bq2b7KRIdwXkCZVGCxLD2HsaK86HYnNqval7Hfvs5iFbBqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2zMUKeKU; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1279eced0b9so4605802c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722428; x=1775327228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EutCInN6F4yXnCa6BJHwvrx6dCvJ5s79x5UPAQy+HBE=;
        b=2zMUKeKUWVzUuaUJLJXEHf0AqUcA5QaCA3JagtwnvNz6KGAeHzI+wLfG7BMyWkHCCs
         S3Plxxm9qKu7Hjx+dNce+Qz29qyuV5LbvOE1l7XM6sbWjGngJc5xZC6/XAsvrby25hB9
         OrbirKWzspeREXx5OIic7fVeCA7LMtq9zpbWSmO7okXx4FCaPZhGwHNCmCNn8RfJpLPc
         Fto6Lfh6rI+fnSpt/TP6SUtilq+NI3V/H48KmxC6rnxFVJwJTOQ9hJt9Gg5xnfd7Q0nU
         fi5lDKxP74LW8En9oegHW5T6LD5EzqojrmDBbmkWvRzW/ETNS2gRNWaIe7hY6n3l2VrJ
         ZGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722428; x=1775327228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EutCInN6F4yXnCa6BJHwvrx6dCvJ5s79x5UPAQy+HBE=;
        b=psJAvO9CqxjTcidqNyVwvDu/Zi9mMs+8XS4YsK0rRFjeaY5/WCY4hITsGYtF5aq3z/
         JU4K89PPisZdyRMRHIj33HI2m5DJJIFip5+zQBeMEjbZIQAXYnBWuS9DTW3/grY6ios2
         lZTCx0hgLzt8liMxtOu0PXPKB/cTXtshdNW/8K0NZZIACIFBOSSAy1Vp+jT/gPV4Mq29
         zUugnQuny1bG4zn5UwcHf5S4/Q4cL6lmQD1abaChcHJNyxmaVkEqx21SB+jcvXZQUaEk
         QLTqVkbvQzbY5ygqXtmUqRAhBTBvh1FGT9MXEJm/hruJvYAHbVz1Kfi/zH1GuIBt1gTT
         rOwA==
X-Gm-Message-State: AOJu0YyO73UrlqOpMzcIGlZAOI9ystn9zEsF7W0gMRuMq155s2ctJ8fI
	UUCbjUTaglAQnDzb39ZAwNJfx2tw+vcd0qXfnIXtLlXfFCBMqrhfsOVpXbx6JCqHUIyj0Ant7Rt
	+IdTV
X-Gm-Gg: ATEYQzwlxna0vusvYAxc4uc+q98bRPzvPA0yWtZIb2wwp3/2B1aj5ib90rjk9sy1gkh
	7ToqaI5aYbLEEpbO/ISkXtNr5MjdiaCqEHSFoxsVuSD1wJTgNgWH/0JygE2R5QVD0brd71/jBoT
	k0YMER7gWEt4AoQhRRPIrtizEvfzK1Op3wbeCEq3KihKHFDDhnweVvi1o1MDm+TpkvTGl8ePeVO
	3tfa3PbQPATAWAp0m7jtD6Etcu+2Q4zYWxnTNt/Z7kuvwb5Avk+y9UQPO+JyO8FwEdD2Qk+N9SO
	K+eK2qZyZu7nksIC6sM21YLFBzsb2ietwdFbvEi1PSl3X2mo7gIVhDKoEYpf8lG42py9aWnSqz/
	3qVI7hgKdtApUV7Im4vhbbiSFE1+f8/dYjraoKrExSbQiscfPtGa89BYQmsCiVEeeVP3WQLX9LJ
	TExSgzW+X9pF3Yc0gaOq4y9bPESNzoirEf
X-Received: by 2002:a05:7022:128b:b0:11b:b3a1:714a with SMTP id a92af1059eb24-12ab2853bfemr4066306c88.12.1774722428087;
        Sat, 28 Mar 2026 11:27:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:07 -0700 (PDT)
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
Subject: [PATCH net-next 1/6] net/sched: netem: replace pr_info with netlink extack error messages
Date: Sat, 28 Mar 2026 11:26:02 -0700
Message-ID: <20260328182704.456993-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272797-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BBCE34F976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem predates the netlink extended ack mechanism and uses pr_info()
to report configuration errors. These messages go to the kernel log
where the user running tc may never see them, and in unprivileged
user namespace contexts they can be used for log spam.

Replace pr_info() with NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT()
which return error details to the caller via netlink.
Remove the uninformative "netem: change failed" message from netem_init()
since the error is already propagated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..73d0e85eeadc 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -804,19 +804,24 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr,
+			  struct netlink_ext_ack *extack)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
 	struct disttable *d;
 	int i;
 
-	if (!n || n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX) {
+		NL_SET_ERR_MSG(extack, "invalid distribution table length");
 		return -EINVAL;
+	}
 
 	d = kvmalloc_flex(*d, table, n);
-	if (!d)
+	if (!d) {
+		NL_SET_ERR_MSG(extack, "allocation of distribution table failed");
 		return -ENOMEM;
+	}
 
 	d->size = n;
 	for (i = 0; i < n; i++)
@@ -887,7 +892,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -900,7 +906,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG(extack, "incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -919,7 +925,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG(extack, "incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -933,7 +939,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_FMT(extack, "unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -956,12 +962,13 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, size_t len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG(extack, "invalid attribute len");
 		return -EINVAL;
 	}
 
@@ -1010,8 +1017,7 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
 }
 
 /* Parse netlink message to set options */
-static int netem_change(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
@@ -1023,18 +1029,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
 	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
 
 	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
@@ -1045,7 +1051,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1134,13 +1140,13 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 
-	if (!opt)
+	if (!opt) {
+		NL_SET_ERR_MSG(extack, "missing parameters");
 		return -EINVAL;
+	}
 
 	q->loss_model = CLG_RANDOM;
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.53.0


