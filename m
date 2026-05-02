Return-Path: <netdev+bounces-283325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH0sDyVD9WmXJwIAu9opvQ
	(envelope-from <netdev+bounces-283325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C44B0782
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A88E303912D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312123D7E3;
	Sat,  2 May 2026 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="J7as3Jis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0020C00C
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681135; cv=none; b=USLczXJtk+TVeI780abBJl3K/xmC0P8i/HjJKOXhefBosJosfkDsmhRLdr1DZRXXpv7qtBG8Lynv0rJVEhu4HNKOAdG8jHIfgoDrHOdu+z7cN78AkPk5Xn8jlc6t+tcFlRmYG1O2Ri72FB3PGW1xU7UFGD4rLn63v/1ofJeY5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681135; c=relaxed/simple;
	bh=y1+1PgBpg/ncxoTXj6GazTBqlwA61vlKg3PHbzBD0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4WbR3sIBxPPw+R3hxRyLu+kDKJfz5CRg0qNEkMVf+aF/xeluOgT91PFqluYZj54zOCZAfJ7tJRfF0dm6lZcbtKcD8cidR3dX2pffuMB+/znUxn7Mso+2RVulODufx2gvu2GvNbrBl0pS9mpqBHfAcM9EcZkTgSd8Y6sv8KYr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=J7as3Jis; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12ddbe104ccso2521650c88.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777681132; x=1778285932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j0dQzsRSy6gRqEH0V0qrvXR4yldNaPgWZDBeR7Lu5c=;
        b=J7as3JisKmfr/xOQ+W7N2RRGmWE9MmLJZ3TY+/WkPx5ij5HoKvDtkjt4Tx2KOQYUtx
         04Oq0hP1GqNvsqcaLdSnZOgMGmuyGrnMwYjpijB/ruUyUSga7TUxu8RAylycQYlhMgcE
         GK8OfRMleUEZ723klKlQLRei2QlgWgsljcEzZ2f9W2WVwOddEtLrXbw9g/INCfsaWHoE
         J1iCuFS5Sm1cDofMMv4gOCR7JD/sZtqkdWPzVXo2xBbx2MAtHlFdSapm4XA64vWtPs8k
         GQjTgKCJCffer7hRdN3bEkPEPzTHIbqDlf5Jb+6yQ3knb66YN4k1kvXAtK5Kv2tXPpqi
         EImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777681132; x=1778285932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/j0dQzsRSy6gRqEH0V0qrvXR4yldNaPgWZDBeR7Lu5c=;
        b=CoeDc6uNdsD/mKR+CA1sgiOd8cMxqU3+MzBpB5LroDYL2IYmIujAdLHwV6VbtD6AoG
         ENbgfR4EF/mbFdde4UihoyE+Y42SqAJv2NCWI4I0Av2akhswxj6MBCQrOL6Sgu+RKUWB
         s9hth1II0UWlkKAusH7mAwBQOzl+iSIYNU1fdnqX8oxg67q5EgWwMlssyFzHAnepaU29
         16c1oYBemLL8TWuXW5zdXCmxpClXcjTfW8gjSRI2NjKbz0he3/cRRaB+4n4tOpx0dc3P
         BVsO5fKiRDkxnhJdvXzZFOSc3GEcSbKUYw+MpnrKd5rszUb8HywOZoPJqVtSvD69+z1C
         f/wA==
X-Forwarded-Encrypted: i=1; AFNElJ+laPB4StRHtiJYX3EA6jHJrH6+WARaaIevvwODULUvsOPBmnbGpSm75NvDIyIYLEW7OtKtiP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NfRcL7RQM6pdgwQ6TzkLm1iryaEfEAlnvRP9X+LuSKNxgAno
	7L6N1cBX/YCYYW2WcdTyC8nWavk9YMz3HM/PGbpZrciRg+Wyc/AAUhJbUvwHvkH0sr0=
X-Gm-Gg: AeBDievoEU0USIzM4t7MFSHOm2/2kk+pKxkYPeoErtrt719VHCca187cb2kelO9eCoF
	VBczd+B4aFySNNdPGkPAuE+DGqi1hoekXARVxPiWBIekte8Ic3nfNapXrX2bS7EiueFgw9LZD3l
	7VnimCHmWn0c6V62JZQlnolgPQoxUAvZ7ULKD2pIEPaSaIcKWjLiQ0cjv8TrtqTLnpzmdL5Ce9w
	FICgT8lwoYjpSi0VgLl6Rd9oRa3a0Hs1puNxohqujWXsBsTHUc8pLokJdg1p0CYlffeuLr8e5jB
	ZYjXy3bc5KZ3mWf83fTygOsT8gyzVLrvHh8TsuzTjQ2jE5P/Nc7L97fnrZJFGR5Y+DdQrtVZR7k
	KVXvJKSGmP243o25//gmaRhIS1MIOqx/Moo81C8ugFqz+pSOb582n5vsigrix+2d3DIDiK2VMy6
	aKpdXTkYSE6+1v3/Vm0TdLFI6P96yxotPsbXLMHl3EMo8RR08CG9AsTA==
X-Received: by 2002:a05:7301:9f05:b0:2d9:5cd9:b8ff with SMTP id 5a478bee46e88-2efb8aa1da1mr640154eec.6.1777681131741;
        Fri, 01 May 2026 17:18:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2e0sm6419484eec.16.2026.05.01.17.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:18:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETEM NETWORK EMULATOR),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/4] net/sched: netem: replace pr_info with netlink extack error messages
Date: Fri,  1 May 2026 17:17:11 -0700
Message-ID: <20260502001844.19107-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502001844.19107-1-stephen@networkplumber.org>
References: <20260502001844.19107-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A83C44B0782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283325-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

netem predates the netlink extended ack mechanism and uses pr_info()
to report configuration errors. These messages go to the kernel log
where the user running tc may never see them, and in unprivileged
user namespace contexts they can be used for log spam.

Replace pr_info() with NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT()
which return error details to the caller via netlink. Thread the
extack pointer through parse_attr() and get_loss_clg(). Remove
the uninformative "netem: change failed" message from netem_init()
since the error is already propagated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 9ce75d9b8c54..116e96d79ddf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -918,7 +918,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -931,7 +932,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG(extack,
+					       "netem: incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -950,7 +952,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG(extack,
+					       "netem: incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -964,7 +967,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_FMT(extack, "netem: unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -987,12 +990,14 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, size_t len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG_FMT(extack, "netem: invalid attributes len %u < %zu",
+				   nla_len(nla), NLA_ALIGN(len));
 		return -EINVAL;
 	}
 
@@ -1041,8 +1046,7 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
 }
 
 /* Parse netlink message to set options */
-static int netem_change(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
@@ -1054,7 +1058,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
@@ -1094,7 +1098,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1190,8 +1194,6 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.53.0


