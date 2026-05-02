Return-Path: <netdev+bounces-283324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO7QLPpC9WmXJwIAu9opvQ
	(envelope-from <netdev+bounces-283324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0244B0764
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C8F3017506
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB31FE47B;
	Sat,  2 May 2026 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="MlpENwGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7F135A53
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681132; cv=none; b=ErLvzKO2JzxwwcBFCeMX03MmL8lKAL+jKCrCh3sSduSidS9ndFcVnSXkQhIrjNgk/baBwGQm1Gw6EboUkT1yufaLXpln6ezQuyIDL87ryrPwDRHpOFKdOEuWxWiN4vuFlHagunSl8ZWzeEJeHQedp641eukNurJrYadqWmUPAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681132; c=relaxed/simple;
	bh=E9wEo6syH1PWttcrkPOpenN4vX5pQAj24eTesfgIbhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubZPbczpm86xtgwZBuCio3sTZFhiZJ2KjmsgrT30FyJxLyxycBs1q/ZFY5otrszFTzSd03BdgV1xhM6ksrcz+yYgiHx5LZb4113BCJHdkzZW/RMXcFBMxJo2f9f6fRFFBW9zZGQyWM1EVNaHymbp/lKltQZ/gwxm2TX4jT0HIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=MlpENwGY; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3736772eec.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777681130; x=1778285930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG16SAs6qY8+d1IEL5w2M3uHZzdJBnb5y4P6QKEi0os=;
        b=MlpENwGYfKueoHPXS19o0SMkJucnq+IuYqEiISyPt/qOrNnHXpscazi3qUzbaU9Yeb
         B7EePqFEtHcYcv3wTT5iOD/jdpH8TuJt0AUGUmknAiOdiu0TVV5d70sq+grBF2rYP0vS
         zEAGR4Pb6nJN2nU/D5ebsob3k7eSVuiAC3YPo6sLNdHNdQ6E/vGxxdPAcsVDwz/f/CjU
         fA2J+S8ymgZpSPvnD3g2vD6DKLgLdV5/onxNyPz6Ckf2E9i+GbUKGKynW45Q//p5PoDI
         4LJ8Ykdt0ldE6fK+/tnlypJgv2svLvaSKpN90j/WaoEDWdsM3HntLv17m7ihMSxooZyn
         zATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777681130; x=1778285930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KG16SAs6qY8+d1IEL5w2M3uHZzdJBnb5y4P6QKEi0os=;
        b=ckIDhGGyGfK6g/xh6njQvYPAxGdl+wOYR3bWB6opGEBT//o6Nyxmu7N/82SlzCtNMS
         fIKevAz8hsWJurnmrjkwnCQb8aOTrfpAyLRBxDmwpbezwPM3zfGg6/60PXrsrBb2zqWt
         cXgcX68x6RGxrUvKcXhLLX699uYSj+OXWnEZaX4j7bCNWTT4XC6jR57u9WzABwGR2QMf
         rC0l0gVOrs4n1yneBrOQ0z6UV3X9Lw83qqlpor/ZumV+Mq4VfcGcDuEvR01ncA5gWOa7
         +3HuugRAXsVCW3Qdah4Mq5UJ6GXAbeitoJ5Qei22nX7BtNgw/XHh8g3P/5j2rqXbeC5v
         krwA==
X-Forwarded-Encrypted: i=1; AFNElJ+0m1qXReoWQccL8pH5VMZ8rqR15g30VqWV28MNugqRMd1y+iE7DhjDSzCti2rL3ZNN3P59ILk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcJK/AngnIi+Da95kcoqhKgXPF6HjLnMNlp36zGyaUU0qzRih
	7UFcpvyBE3Ihyn9HZphOsLzP6vhOdh6y74HIPaEhh1kjL7D4mLPCfyptnTdItHKWRH4=
X-Gm-Gg: AeBDietCRf+c5lIfBMUGLJn8JlYao0sp2Xamlyb2jQv6Ut5fR7nGsey28m/HGxB4GwC
	PFtASiNOuPtQA6k70dCptYktnM7wrm98JW0XHrRWXG3m5zRIAMJluhz4TucLFam9PY1T+3z5dY/
	xzxFfNRyhwisq3vgR6szRZJz7CCIdzDEZ238O8302g5+Sameb58ACPfaZ0gxhw1dAaMHtpqizPk
	/qqjQoLTZJF4i4Se6IjTylzjtl+y1IuaQCMhAnqqxwh5/++MjAjfxlz5CjYRz6aHDe+LrmHHW1/
	5nCG8sEUdHJXJsAmLkZWwA05oV0ripn6CrzdZwZBmcAKDUjVl9QcIb4R/NiEueWicR6V4BKADNo
	M5GDgT6ZQlZSOwvrF6yHkpUHDxiRzSnAhizsOtqnl6GX4YGMHjHX5el+1/TBfcbkA+tgm8YCdP1
	80Z9fBzPq1YN10CUAq2U+r9j6Rw9YBtg754HbWmewROUY=
X-Received: by 2002:a05:7300:5723:b0:2ed:cb43:39f with SMTP id 5a478bee46e88-2efbb091b62mr625355eec.34.1777681130397;
        Fri, 01 May 2026 17:18:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2e0sm6419484eec.16.2026.05.01.17.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:18:50 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net/sched: netem: remove useless VERSION
Date: Fri,  1 May 2026 17:17:10 -0700
Message-ID: <20260502001844.19107-3-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 1F0244B0764
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
	TAGGED_FROM(0.00)[bounces-283324-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email]

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 148b22fb3ca3..9ce75d9b8c54 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1410,16 +1408,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
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


