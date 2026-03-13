Return-Path: <netdev+bounces-267613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NCNLmB/tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:19:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0528A1AB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BD9323AC8B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6CF3806CF;
	Fri, 13 Mar 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bg8PrJ+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68D377013
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436643; cv=none; b=Au+wiU+8sb0zxJQ+r54TCpTxcMlu+fDQExwGWkjv1coCw5gu28Szd4cBbMoUyc/tIxycmrBz//eM8wCe0xwRoqm2QuYzZqrqAk2dSLTPs+TloijQlChJBpG2I/r9aURrMTj0I6g4SNyOdV8Vww9Ne+/Eru4lgmA3eKJwRJrFS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436643; c=relaxed/simple;
	bh=5q3hlhiVVt8CjZ5pTzx8Farvqv20v8KVeIBHvkBPDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE3Mor9W6wUK7FkIHzhXXkdz1Pxs619n97UuXpimn6j7x1pg/qZAkQH0P9iuI3eR/xhqX738VRgsyVDSwZI/CSj7OkK2fSc3vF3wCc3RgkTc06K3alrgADRNcSIjzxKD7t4sUdbe7GJSz3sRYeV0lB88ViC1/qVGkqVvCExH6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bg8PrJ+w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad617d5b80so19795495ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436642; x=1774041442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6QtASiosKv5GbaXIxuh9hIQ79t5ZGx2qnyCMYRQ6vc=;
        b=bg8PrJ+wuexa75UEYCxw2Ajy6XHJ7w0hzEwlDrMnO7eLs1Tm1+hv09Xf5UUwvpNl69
         Uba931u1yJJV+kQzGeUgAuF8ncBleNANbZOdf2F/wueOlPZkT0rIksfg/KCUDKoDWqix
         j46ShiZ3+3PiD1moFg0hPktroRd+NihoOi32rrT7ad2L0t/lo3MsbqNggxAdtddJTOcy
         305PRVSOiJKQe2+Qo0amBnKiugJ+p5vI2yXH1vd63wkfQy9BCxgtsOlaOfEf+tW0AdQf
         l7/RC540byEifUgC0RXX8F9X0bTbp69uQr/Uo8e+2V6MoKSTyX7Q95n6L1mVjSVkPoEC
         Sizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436642; x=1774041442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6QtASiosKv5GbaXIxuh9hIQ79t5ZGx2qnyCMYRQ6vc=;
        b=pgF6k70Vo+GVcy5NpJ72hhSG5W54Z3zWP2h/WskOFGM9Dh+KWIzAYhK7XChcQyLln6
         IXCVpio4oOxz7AwHosek8gOnNx6RxJg7ZkUzYAmjbhCmVrsbWf5mKADP8ag9ZPU5HWKD
         fZ1zMLlXIdJCYHx3wOA1lIMsABSzKGc9nfC2SXNiqxGzAEwv5X5WFyKsMAKNlJGBpn9O
         chjm0OYj/hBx7pMScnuoDzYpK6fU1YwfbmPT+d0r7e902MFex1qI4DSaK1Lr0jSpD2tR
         45t2JptAK0N0W5qcx5Rx1AHNIPOIh5z2EaC4VdL/lUrGQAvjQDe0kcrHmNW7TbFmKHw9
         8hjQ==
X-Gm-Message-State: AOJu0YztjZ+N4yTAPNhNx5Xi9C6w4JLEiOoeCnqcRng2UttXc2YBqiL8
	dSlormr7hDMG0MOD3E10G9g1giFaneipt5H5NlxJTgv1EqZajPMGF/4FmpY1bYQtik/INJDMOB2
	uvSCQmD8=
X-Gm-Gg: ATEYQzyFy4sn9p65kS5oSOLBEM/5jYFIOT3RRcX74MnFdU5056LceXJNW7A3sykCMN5
	sbwTJIvKHOU1L4N0OQORl7mPox5A1eNQdpPpQne63YbDwX18753uSIknhFUZSREXPTkUhvmJWl/
	g4nmF9Q6w/z/GXsUEqWu/Cahpv02HlA854rg9SBY0PdjbmZsaFM6fkjXeM6uGvZUmqmzrJsWQp8
	nXmNQ4dhz3+PHwlxQyKFfL+77QFr/MxkhUaVGSJP1gKDMynac9gfG+edwUEUV4RLmwqadh81CWU
	4UzfMxG6CBYEdHf35ruYTqljBBJsUrfXZ9O+zrhIoZ0z+nX1bZuZkoJ4PxKOTIARVA8QJMZUEi3
	w1EIowxqYVGNFQRXSaLRB8X0oN+XpYQMl4HSpxrqa/X9wyEYlqtnbtAtollS2y08hWq97z0Srjf
	shVgSv/ORiVR9JRdO5Ear6YM75PZO78J+x
X-Received: by 2002:a17:903:ac7:b0:2ae:5a58:ec35 with SMTP id d9443c01a7336-2aecac85436mr43864325ad.53.1773436641754;
        Fri, 13 Mar 2026 14:17:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/12] net/sched: netem: move state enums out of struct netem_sched_data
Date: Fri, 13 Mar 2026 14:15:10 -0700
Message-ID: <20260313211646.12549-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267613-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 20C0528A1AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index dd98778ebbec..1957a15f6d1a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -81,6 +81,18 @@ struct disttable {
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
@@ -131,18 +143,6 @@ struct netem_sched_data {
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
2.51.0


