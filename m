Return-Path: <netdev+bounces-283323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIAlHfJC9WmXJwIAu9opvQ
	(envelope-from <netdev+bounces-283323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B74B0756
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDCAC30055F0
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E61A0BF3;
	Sat,  2 May 2026 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="NhFh9Uwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E117BA6
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681131; cv=none; b=ZpmyfmGs96bdWHYc7tyYGHTb9bDl6GRLUjlK2bYGrLw9am4rIjhoyh6YvVciE85RTXu7Oxk75t/ukqdLMCuzu3FLfqtV+R2DTSSyuRx7DKZ3rVBC+C8vGtsXMUhn2SVZSlJvrvz2mzCBV4ce6yHdf8CUbqFT4IrqtJ0N3dBKZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681131; c=relaxed/simple;
	bh=W7C+dBwfvQI7pyYUYr+zYeXuo8mjljpFj7hRJ1Euwcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfa4PQUy4D8AEQgAcpbQ3nw5olOleaMmnItb+0BAGkZjmhNkmdjQFUHPfnRFFqNNNUXl9lZ+7cKWTWL2bGVD3g1k/rF4UB70illNi2Ma6yyOBTpSBsQ0+IwKrITqePti0wJBHxybTGYpyr6oqhrp49uedPWEKijzo2/jYvITI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=NhFh9Uwx; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8cc7a77eso2481253c88.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 17:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777681129; x=1778285929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC/Ueu1kfnIjF0F9KEkQ0SHLAKKi0/ENPhtIGGkeBmo=;
        b=NhFh9UwxyXtt4nI5VjbPM/3A6oe8KN9rg+mL0xCaiJI+AuDmlQmQi0GMu0ttlWJgh9
         JZ9audO3SsNUuuY9aAZh0CQErUwqE97Z6IAMeMGsjxyAv0p0nXPKKwq/yTZ/k9OCNHVk
         yqQFzwODX6cFUuNVJcwZ639jtN1rPWW184WnzbkEehoQ7RYyX7lZsAOId3w7PhFiQ+3j
         RGCk2BjdMCHUPB67AsnNnT6/2KqUU26cIelK1zmlGUcstRPmEwGV4qZHgo744bURqL7s
         d7Z7XbZ1WmPpyqH2VMxSErCQltBdXlTy7PH7zWK6Clc7sy05jwjI3xXo7XFDYLJit6Uo
         mxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777681129; x=1778285929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dC/Ueu1kfnIjF0F9KEkQ0SHLAKKi0/ENPhtIGGkeBmo=;
        b=aLqXjJT95wyUVMP1zVwR8XgNnev6nyHPLi9I2sivM33K6MQICFWAWyLQfFHsU4agdW
         eoQG4ZgOgqyYj7IoCCDS93ZmpBn5RUk5dZGwpJKZyt5C/6vrVSXBCVeVTkBqMXN0P+gm
         TKLzR5/enU3pw48gj65EjyjeOLYI4ENvMSqZOro1mXq4+/Sq0VxRvYbamD7g2qwVMYLf
         DP30BHi61ezk5ErJUvcnD6qARMAnwuNotvUmNEYxQcmSSXFnvdx1GjtqERzsix6WaVIL
         zhi4Es/Vqky/xk987ki9dSvyUbXrbz4vDplT8pKKZI0tHwkESFD8mpcCAk2MqoI+2Cvw
         jhYg==
X-Forwarded-Encrypted: i=1; AFNElJ/j0R61Y+CdgrJOq2fvyqzStgISUGAiP6TCFLiJ6dy5WV8x1h+YuBATc7FZuHw7c+yF6voIwL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKWpN2u/5d85o6yM5Fn4NA26SnZHIeRSfjsllVIWVPav8Fnbt
	nPiTijkjAcQ9ESPeXeJmsSJK4q0uSbZnmDr0jwMfYApEQieExC40D9tezJXA0nZ76ss=
X-Gm-Gg: AeBDiesP+Xk3jVBub1kiVJmYwxqz8shWhUSlO0WbRV6wEkrSW3P6QkEgY425CUg9WIE
	noT0N64Uu79WadR/zwsEdMcpYsJeiRKFOQskwAs6tt+gyqtZFczEYds6c2cdBWYcTt/DmVWNOaq
	uEGruJiWj+mQUKcEUVQgMDzwG7YtsMnMxBgq6NMLtg21LfInUmANXhpz5W62QEoqwXX5dk8awcY
	O8wC4NcJreNs5a6ByJHqjP+ViIvhG2oYlrAMk/9DWQLrL6iOXkoCeT0ohH6xyao1LDm8xkVoTD8
	nSF3aCF7vgbocp1kDaJPLJlncHMbyA5lqyVA+Y6NjifNCZozSF3kouRf0MrlYzRPJAyCg+2MTTS
	48Itdzxr1t39a3I8IdscE/8HmsS3y9hh1jjSejFRr1J0wkqkWyIMqE+wGTaN9mPx+QCrvrrttj1
	vrGVZJU2ooauFd3QaWyNRt0rYObZokGDiyYO1r9EkHD/Fq1e/M4c+HwQ==
X-Received: by 2002:a05:7300:7244:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2ed4f1ba5f4mr3458868eec.11.1777681129058;
        Fri, 01 May 2026 17:18:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2e0sm6419484eec.16.2026.05.01.17.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:18:48 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] net/sched: netem: move state enums out of struct netem_sched_data
Date: Fri,  1 May 2026 17:17:09 -0700
Message-ID: <20260502001844.19107-2-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 5E9B74B0756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283323-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The _4_state_model and GE_state_model enum definitions are declared
as struct members but are never read or written. Only the enum
constants they define (TX_IN_GAP_PERIOD, GOOD_STATE, etc.) are used.

Move them to file scope as anonymous enums and remove the unused
struct fields, saving 8 bytes per netem instance.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index bc18e1976b6e..148b22fb3ca3 100644
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


