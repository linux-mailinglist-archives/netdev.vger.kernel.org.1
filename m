Return-Path: <netdev+bounces-272800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLU7BMIdyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:28:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A431234F948
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0D223010791
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0C1F872D;
	Sat, 28 Mar 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bvRP+5PF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17473A75BB
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722435; cv=none; b=aErvfOwtZV2CXzEvNMXUXgR14sLj3zbfqQlZ6sCyNJBPIfHPDOQsTFJQDRPRKY3Je+Li2hM5ec1A/pXpZGtbq9dFEhiGrZx4vfs13vV+n4t75kc8o9MDGmsc9AKm75EvURMMXSmB+cRTmtJK9jJ8p8Z2wcTEVzLYSnO8zagjl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722435; c=relaxed/simple;
	bh=+31NpaGE8kW0GrKPQtz436i5le0stBTpMgGR8A3yQhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGA5lyMzz/4nkXw1MjEgpTUMjCJticilehbNEEoYHvnV6tQiPu4MU+90sgQpYz2vd1y1htIvj4uvsxV8jWWCV+HJTRFLdUdD/qGRZzzxy3aNnQI0fY0Yi+4z6wtS2AluAAOibtA5r6YOZhYPYbHnsY3DoKinWF+WwOKHjTXILPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bvRP+5PF; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128ebee22caso1576065c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722432; x=1775327232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iZPEM9dTgY8krOHC7x5O4n96kewoQZvqn/bWoDSOhQ=;
        b=bvRP+5PFeO7Vb4VQBlWfjHyLBmshtkhszAL4z1cp2Uqtk8gyv+cGI+DGReisVKsMpD
         mpM1U8zF1SvBGX8hIfb62synGKfDGKgXKSPeusdK6kOTYx+x3acNJqrGMwCb4udX4E7a
         oa1Az4u+62pBZigHy/tN9RZ4huPwa449jzteyqcloDZHLH2JHhO8WDt4VcUcnbrZ8HJ0
         Bp/w6flDdQtbMLmX/Q3gbJkm7A7irtjdDKebAI+pu7URwzlrz4Wap8Qc3U+VFGDVoNys
         EQbzfB1auPG4y8sZvaUlBmUa+NegVmHIYVbb7cm2OOZOIed1mcEUwI1AljMgmZn4TD7I
         psog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722432; x=1775327232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iZPEM9dTgY8krOHC7x5O4n96kewoQZvqn/bWoDSOhQ=;
        b=DDBL3xVE6aoRDAEyLDT70a86jUr2E7YN0tlFH5tFZ+qejgI1LnqNTgzjngTUHIPAkq
         DRvq+E4JZ1zNDBapKVVRFmQGNZlaXVWD7UBSC6arROvg7LbRnW2p6vDg3uSmvKFtjX+6
         oD/AsXe5K68VkpX26YRt3Tc3707gMwg9R3RZQr8IArSarcQE8gC1UCmr25dlyl868/QQ
         VUoJK5wGK+pEJJthWUreipWU01E4jtfEa2pz5cftiy7ZTsPEcs6Gr5JMhJfz2Haq9HPJ
         Ezb4/w89tzQWa0qQ6yJOeXXA0By+KbQNxT37PgMrLG4X9Lao0nPfKu5PjGxPw4jAxBbp
         Pg9g==
X-Gm-Message-State: AOJu0YztwyPt5/0Cnm91w0Kuqhzv1BgaB6iiScIc3XY7hOplqVmu0SFp
	BKFM5QRhCl1u+D+Q0gypt5O84nYwCIZQLGMaDoLCRUCoHBVCrEotsQmzb5b4CG1MzUxFfJD4TbK
	ec8m6
X-Gm-Gg: ATEYQzyFIsSgLIVWNqZj25OXb4hH3UpvdkFXRhSX5UX5lTIXQ3PQ49cbDAccaOXNNOa
	pvQlF/3y9Od+Jt1vk72RC3PBy5yz7C4c1ShoZUysQhqi5kBWdN1nhclSCGemUIMRBFISG3y10se
	CjcXg5Dlgf1xRIV1h4K4PdqfFA04/+j3iaAfv9cUdO12lmo4z2IOPTzZOnTIShvHtkw2G6wv/oQ
	2JL97rESP7HK/eMT+Qpl7pFnZLsMSSIMjOpeg3TzBlNn4hoAF090W5vPofA+x9yz/Dp2Qgzlr2A
	NrbmyuWQ3oo6c0klmx3fWYwrlkuT/TZtpIdiGc+UJvq8kFB0gwJfpCCLOYZMoX2gGWeHj2d2kog
	AvVr07lfzFW1DrATNd6jjNu5UNUIE+CIk/iz08a6NotZIxRI7LHzb1xLLwEMj7oU8BO654LVR6Y
	nqunIZSKH2KlNqWYfP8rPrGxNbYludo6VX
X-Received: by 2002:a05:7022:f8b:b0:12a:72af:83d4 with SMTP id a92af1059eb24-12ab2857ea9mr4008750c88.8.1774722432540;
        Sat, 28 Mar 2026 11:27:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:12 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] net/sched: netem: remove unused loss model fields
Date: Sat, 28 Mar 2026 11:26:05 -0700
Message-ID: <20260328182704.456993-5-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272800-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A431234F948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The _4_state_model and GE_state_model enum definitions are declared
as struct members but are never read or written. Only the enum
constants they define (TX_IN_GAP_PERIOD, GOOD_STATE, etc.) are used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 69c93f7ade62..87caf1b9a4a7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -71,6 +71,18 @@ struct disttable {
 	s16 table[] __counted_by(size);
 };
 
+enum GE_state_model {
+	GOOD_STATE = 1,
+	BAD_STATE,
+};
+
+enum _4_state_model {
+	TX_IN_GAP_PERIOD = 1,
+	TX_IN_BURST_PERIOD,
+	LOST_IN_GAP_PERIOD,
+	LOST_IN_BURST_PERIOD,
+};
+
 struct netem_sched_data {
 	/* internal t(ime)fifo qdisc uses t_root and sch->limit */
 	struct rb_root t_root;
@@ -121,18 +133,6 @@ struct netem_sched_data {
 		CLG_GILB_ELL,
 	} loss_model;
 
-	enum {
-		TX_IN_GAP_PERIOD = 1,
-		TX_IN_BURST_PERIOD,
-		LOST_IN_GAP_PERIOD,
-		LOST_IN_BURST_PERIOD,
-	} _4_state_model;
-
-	enum {
-		GOOD_STATE = 1,
-		BAD_STATE,
-	} GE_state_model;
-
 	/* Correlated Loss Generation models */
 	struct clgstate {
 		/* state of the Markov chain */
-- 
2.53.0


