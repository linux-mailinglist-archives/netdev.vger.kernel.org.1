Return-Path: <netdev+bounces-53414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D13802E66
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E190280E52
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042B171C5;
	Mon,  4 Dec 2023 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQgfYref"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F0103
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso3067490276.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681558; x=1702286358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Arb8i5vAdWOSXn81AEoSvLDIp1fjLyYHYObNvnjaI/8=;
        b=rQgfYrefRKUQWXN2LiF8syDNKTL31S3fW8On2mz54IBjmgX24SvUxLA1p5cZ0Rcj7h
         +Ux+I7MqxtQAECOXufa9M1pNVE5xdk+hpfv0Z9HUJ1H6bm44uUH9VYZem0/srv0A74HN
         lNm6tNoV1Dz1ta29K/cE3ELJiTSBjjxJFv+Aa6c4FvR4cazxDRf583zcz0akza+XteXy
         FvCYTB+in604aBGQ3pyGiKLwu52Ib+IC+fLhXH8/3HG2oL6tJSN36f4PWLXHkBZ2giZh
         o3Nvh6mLotHejw49nsWXK/ofQ4shCUSTK1DsrcOhae1fNu8JD57T3aTHkgHUELkkQM/S
         0/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681558; x=1702286358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arb8i5vAdWOSXn81AEoSvLDIp1fjLyYHYObNvnjaI/8=;
        b=ASSAZ/qq49WmsoOrc7UvlaoS2qv1v+e3EBzLWlQJq5EdG2RBbF15LjAfnBCwO8vFLF
         X9KjUA1KWX0ShIDz4w2MbipI5PI+rp93fizUHagFLdkPN/RF0LhKHgupb9ggniO3DQvH
         lKy0mt54GYGFhMgYZfDJ7WH3Ximb1oijxG04IS3hx0sTRN/sF3hEtG0CAsBRVFF23pcp
         YyRKANWNd0u+WMRgBH20KGFTF9TQNj36ecaJfEjjBIiorNm/NyGFK3kCgPJ51xgkuLga
         wrOubZJeHtwB1H5eZDuTlSYLFBKVyc6ISXgGiCyVmU5ozjzKWbeCHxQhN+Rgrs5YUiWA
         MFxw==
X-Gm-Message-State: AOJu0YxdzDgjYeHgoIrYU7tdcWWiYcNeV+Cuu7ur0SCQiFggWTBeEWA4
	genj9eK49E8dINpknVx5EhHHH/TZORasnw==
X-Google-Smtp-Source: AGHT+IHc0s5ChGKWHCulCFiVI8NG7vo63vH04kpubDsXcose2FlVM7F+jcjFVUgzXAeN65v7i/es9BtcbddbIw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:a01:0:b0:db4:7d21:8cea with SMTP id
 k1-20020a5b0a01000000b00db47d218ceamr887607ybq.5.1701681558549; Mon, 04 Dec
 2023 01:19:18 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:09 +0000
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-4-edumazet@google.com>
Subject: [PATCH iproute2 3/5] tc: fq: add TCA_FQ_PRIOMAP handling
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

linux-6.7 FQ packet scheduler gets 3-bands, and the ability
to report or program the associated priomap.

$ tc qdisc show dev eth0
...
qdisc fq ... bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1

$ tc qdisc change dev eth0 ... qdisc fq ... bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tc/q_fq.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tc/q_fq.c b/tc/q_fq.c
index 3277ebc7c43702dfd663eb90100954c44e312fc3..d6f724569932906515cd012d4d7f815966523934 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -25,6 +25,7 @@ static void explain(void)
 		"		[ quantum BYTES ] [ initial_quantum BYTES ]\n"
 		"		[ maxrate RATE ] [ buckets NUMBER ]\n"
 		"		[ [no]pacing ] [ refill_delay TIME ]\n"
+		"		[ bands 3 priomap P0 P1 ... P14 P15 ]\n"
 		"		[ low_rate_threshold RATE ]\n"
 		"		[ orphan_mask MASK]\n"
 		"		[ timer_slack TIME]\n"
@@ -48,6 +49,7 @@ static unsigned int ilog2(unsigned int val)
 static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 			struct nlmsghdr *n, const char *dev)
 {
+	struct tc_prio_qopt prio2band;
 	unsigned int plimit;
 	unsigned int flow_plimit;
 	unsigned int quantum;
@@ -74,6 +76,7 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	bool set_ce_threshold = false;
 	bool set_timer_slack = false;
 	bool set_horizon = false;
+	bool set_priomap = false;
 	int pacing = -1;
 	struct rtattr *tail;
 
@@ -193,6 +196,48 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 			pacing = 1;
 		} else if (strcmp(*argv, "nopacing") == 0) {
 			pacing = 0;
+		} else if (strcmp(*argv, "bands") == 0) {
+			int idx;
+
+			if (set_priomap) {
+				fprintf(stderr, "Duplicate \"bands\"\n");
+				return -1;
+			}
+			memset(&prio2band, 0, sizeof(prio2band));
+			NEXT_ARG();
+			if (get_integer(&prio2band.bands, *argv, 10)) {
+				fprintf(stderr, "Illegal \"bands\"\n");
+				return -1;
+			}
+			if (prio2band.bands != 3) {
+				fprintf(stderr, "\"bands\" must be 3\n");
+				return -1;
+			}
+			NEXT_ARG();
+			if (strcmp(*argv, "priomap") != 0) {
+				fprintf(stderr, "\"priomap\" expected\n");
+				return -1;
+			}
+			for (idx = 0; idx <= TC_PRIO_MAX; ++idx) {
+				unsigned band;
+
+				if (!NEXT_ARG_OK()) {
+					fprintf(stderr, "Not enough elements in priomap\n");
+					return -1;
+				}
+				NEXT_ARG();
+				if (get_unsigned(&band, *argv, 10)) {
+					fprintf(stderr, "Illegal \"priomap\" element, number in [0..%u] expected\n",
+							prio2band.bands - 1);
+					return -1;
+				}
+				if (band >= prio2band.bands) {
+					fprintf(stderr, "\"priomap\" element %u too big\n", band);
+					return -1;
+				}
+				prio2band.priomap[idx] = band;
+			}
+			set_priomap = true;
 		} else if (strcmp(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -252,6 +297,9 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	if (horizon_drop != 255)
 		addattr_l(n, 1024, TCA_FQ_HORIZON_DROP,
 			  &horizon_drop, sizeof(horizon_drop));
+	if (set_priomap)
+		addattr_l(n, 1024, TCA_FQ_PRIOMAP,
+			  &prio2band, sizeof(prio2band));
 	addattr_nest_end(n, tail);
 	return 0;
 }
@@ -306,6 +354,17 @@ static int fq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 		if (pacing == 0)
 			print_bool(PRINT_ANY, "pacing", "nopacing ", false);
 	}
+	if (tb[TCA_FQ_PRIOMAP] &&
+	    RTA_PAYLOAD(tb[TCA_FQ_PRIOMAP]) >= sizeof(struct tc_prio_qopt)) {
+		struct tc_prio_qopt *prio2band = RTA_DATA(tb[TCA_FQ_PRIOMAP]);
+		int i;
+
+		print_uint(PRINT_ANY, "bands", "bands %u ", prio2band->bands);
+		open_json_array(PRINT_ANY, "priomap ");
+		for (i = 0; i <= TC_PRIO_MAX; i++)
+			print_uint(PRINT_ANY, NULL, "%d ", prio2band->priomap[i]);
+		close_json_array(PRINT_ANY, "");
+	}
 	if (tb[TCA_FQ_QUANTUM] &&
 	    RTA_PAYLOAD(tb[TCA_FQ_QUANTUM]) >= sizeof(__u32)) {
 		quantum = rta_getattr_u32(tb[TCA_FQ_QUANTUM]);
-- 
2.43.0.rc2.451.g8631bc7472-goog


