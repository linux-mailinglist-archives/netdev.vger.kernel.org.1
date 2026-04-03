Return-Path: <netdev+bounces-275262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULQbMG9F0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180B398DF6
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F493063089
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C042537F72F;
	Fri,  3 Apr 2026 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Os4OfPam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFB2D5432
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256833; cv=none; b=n2AQzo4zk/2ZZokwm9uzb8pbh2uemNlU9O9BHh4awE1f5K6WVJvg+lFJco+3LjiguTZd+7HprPW7iDI3hJpM850Kpsq91KyQlnDSdN060SawaGXBGwqf6/E0f+OH0mn/W5KN3Oo8NbIRbA401npyMOSF0k2GPCsBqkESN7HdGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256833; c=relaxed/simple;
	bh=Nr245NfnCCua4FMtffsWEkPui3Yp6kkr5ok4OhsPFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2Xmp4i7P/93haxxyLYGTcHobzPzT6qR0Y42VsTm6uJE/6BnZHohLpDywqz9iSR2R5nwv9o7ZLxUaqx7bxUvq5aWxX5gfntCljy12tgCaUynDu/KMIEia6pDHV0PPzFreBxwwDpjoo1TWcklZR3MQY62V0h3698Y7QlrBoYgDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Os4OfPam; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso1336355a91.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256830; x=1775861630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9telzi4bIw7si3zyOH0U6j749jvcPben5FLiwSUDBI=;
        b=Os4OfPamERnEgTcVyn0TCQC34u0pm+i1pKDZy1Mprx343ifPPlFpOPx6BbeuzkQ2NP
         QLKLHJfRbzm15+dlP+jxpRIbo/4OzXz02uNyExi1REPpoShtQ7DPA24drBkbeYYZqm+F
         1qpaYhsNbv1D5HBYeG6T1y5tEhkfcU+/+leiU7/wlXpO+IjTO9A71yV6F9cKglxvOAeA
         WGj2y1QfmFfxGpD+gDGrAKF5R4twRRK4hY2YzxQKSGet7Xs+yUPnmzaGn19qpED1OV7i
         bAKYBx5rCPj0J/OycNXBv9vvyWazfZ3HzVpgpRG0Xx0KDIxERRdn3JtP+GZpAY1OXj0w
         utpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256830; x=1775861630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9telzi4bIw7si3zyOH0U6j749jvcPben5FLiwSUDBI=;
        b=oa96UpVeWPXccpKBgs1uGDbod93WcwGV7llHdZnM9ytHRCp2E80T43BcZDtsXm6BEg
         7tQb1vw/u+28LTqDFU+abUxEo9JCH9Ty7cyGNQ2H/ejnErB5PPsx333oU0kvPjftOIA6
         BBZIcrbEgSEqy84OIIDUZeg420Qhdtx9DnluWJSujd/JFfoi/xZaRwpel73FdjyQ0wU9
         A8HQXGh+yepUQNI7d4vWPMVgoJKN92LhzjJ510srm9sSu7Tl0dTzW8atEtRa2JNGpZuN
         Zmes0dUTkM4eF0uNjIry3DyBgBogrW+XjHAB0TqLmLpWIviVefHmsYfTQIl7HN7TJAWa
         Lf+Q==
X-Gm-Message-State: AOJu0YyU0U7m8NqVlXwhWRBLvNv7LGRqUMDfiMfoJovZhsPgZrIwV1Vl
	ZY/CBhvPg4ff6jotn6iV2f5f8uCYbs+Uab+8H67TExpC6+NyblU7ZOvy+7E8TSkZmUKDttSXkH9
	jGFsz
X-Gm-Gg: AeBDietrxHfv13ruEGZCYoQByTNhZkwgPwv14BVmGh1GpOntkKFeBKbmXVhFdwNCzsc
	+ejddbpaYD2l7Zb0araxqCflDrOqF4lG58IUYoKu0aZEotE4Dj2GtG8FOuvtZRu4nYkYpnt8ij4
	WpB26jtW/9fY4aVy+B1S+Kcziy/O5+VqPgk8BIBpZLlaIGjDeKKKx51AuKhZPTP8ACTa6Bgx6rF
	lRZ96iAoT/D5cK9vWOBTCruaFDz0SP3LsuCJin7CEosrYWQWPYiUIqyYZVDbZQSXcR6MXLk/vDi
	fs6xqJduG4XyvULRO3lhipeLi9gbgzrTVlHu5m3Sx3BlLwpS/ZmahIEbWs3CN2fQndELNjQFUcu
	uDdJRV3S2PHBN3Nw4NpItHLy+aA/MQwc4kalfE1PmRiRkdlbxUMudGVZK6gXbpvbEuqmjhSwXuk
	vTcop4ET1s9S5Ys3dQyUq9/ZJXzsxjyoTc
X-Received: by 2002:a17:90a:d404:b0:359:8c89:d74a with SMTP id 98e67ed59e1d1-35dd672634emr6954209a91.1.1775256829857;
        Fri, 03 Apr 2026 15:53:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:49 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] net/sched: netem: remove useless VERSION
Date: Fri,  3 Apr 2026 15:52:08 -0700
Message-ID: <20260403225324.476787-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403225324.476787-1-stephen@networkplumber.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-275262-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 2180B398DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6a234880d338..76af9bd3ecaa 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1364,16 +1362,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.53.0


