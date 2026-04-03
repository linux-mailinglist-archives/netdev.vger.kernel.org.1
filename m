Return-Path: <netdev+bounces-275261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ij8EkpF0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A922A398DEF
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0903007E24
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396237A4B8;
	Fri,  3 Apr 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="u0omt8JM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743C377017
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256825; cv=none; b=KpBgE+khRRXK5yCzrcZUvJ5gDxS7nTPwgy6Gul1hyHstFiNAzkDS1iG6cIiIVol0gm22t9GRUSeoCYMwOrKU7h1XwdFzdXP/u4hDXsWHWddvbWr9qaZ19Nj8p9fxrGpNCVvbeKK1xz7/I43XbyxC3ks8zftHt84yG0+W1Gdocz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256825; c=relaxed/simple;
	bh=DazR3nmtS0HoX1IcRr3ABnf9hAUO6b5MsAP71SELngA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAR5HsAJ47uctYzTjeG/W/QjgHr3ENJiAs65I5OlSERIA5sxJw/gHYxo4BxPV66mWh19Cbo3jBPh0fbePH2kx4qM1N67F41gDE/IjlXUUB0S3k7wGjYLUPbLnUExbxbUgpSATgQy/XM3419wxskHYYxg30HgENsECDyoSZ1toxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=u0omt8JM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1970601a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256824; x=1775861624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj90i1OLUysUJnJOI7X1YMAGhcqrF+r2wm1PBFH27Ao=;
        b=u0omt8JM06EqHwJyVxQv33QctUTpuiHtutNTVEs/q+3alXHMoIV24+V3CPPjmq3vp4
         oRIIC3lYOwelgah0eCwPCStp4bqH7BzGYQEnL/HVS4E0zDW5srQrJ/X2deEoGz8G2xdW
         OyhueIDKpccjQzftw8yuE1VUSe1uLVr9tljE8xQ4HSiWKUsGOZXW6BRLgkjdX4lT0gj5
         E6gwT6MgEohUR8YYGYfTj4Oe32rbLhxVfbzXM5g/X6S9uelAIlNUlbA+8dDswLWKj+5P
         u3cZ2Dq0gpT8VUDzbiM/bwUAAOHADDX2QNJzg4pCRGe22hjRdI8ApI6RYMg4DPigYodb
         k0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256824; x=1775861624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fj90i1OLUysUJnJOI7X1YMAGhcqrF+r2wm1PBFH27Ao=;
        b=ZY9W2vFaWokyD09cTs7Bhe1yUl2CubW3LmoyX9t9pt457ezE9v7jgkzrcJYZEFCBW0
         BeTGgoCxipVP7l55mOybUMd2XPX5D/tJ1sGgstJX6P59vRYvWHvlpEvjFyfP48KodvcF
         fKMjt4v36iQch4uz93g++9ZBxbkR4lmkNg3jpmhru9r8dfq7YAuucESDUdpVznFRp/yd
         yWW4i9pTc3BS6xW+Gysc0YKhROswY9oNTKR+xI8XiUZBEvIVyBykllsHOX3dfKmDB+mH
         BK3BZ7AfulWmfVtHxDf90Ot+QjJputxckgX+rsF5nmKIVMjefpn7NYfDAAII6CC6evnU
         d+DQ==
X-Gm-Message-State: AOJu0Yywp3yFh6YNG3IfGgEx6JpfMeLwuCsgK1oFXsmqHKjtmzDk6Ipr
	a2ClUqY7QtQM/IxSDcSvM2j/thE/2eOrVy1+TwefH0LWeXDAjMmT37gXJgArGYrHfYYPE+n7vyj
	TpNeZ
X-Gm-Gg: AeBDietjIOKHoUJxNqRcUivTe9M6lpqGSFG0y4+35OVYzT0weXFF239FvuuhjL7HYiX
	m9Vv59+KkuTjRVzVWrjUp77gka1HKzD0E9iWfalYFEcdKeGs3Bekd7HyrSa5RLLTVRmpF6KGE66
	pBCN/WHcuafY4MMJg3o6s0xN2sTziezQeCUQ75X3X/M6WUHIbtKynzooTw6s+dCpRal7Vs8fHLr
	M1GyHK70x+aaSeH2+TTYxmwjvxE25GgwjNy1nRai7gs5gAVGgI6W0okuPDG/sA1pfnqO62vMHkN
	plY6kuUbX6/AerogVVigjDJuqsdVXQ+S3aQrBHMcHjo0oq0SmvyG4qScP6JKj3eUJmVHLPsawvt
	/IpVuv0iGaAYou7tZScxhOsYeeA/MlxzIRQ+6nwyQDXmQowybuomV4Ad4rd+938mCXE0VuPt5EB
	/Zi/fzeK2vaj+vN7t+9OYejId/im8PENQe
X-Received: by 2002:a17:90b:53cb:b0:359:fd9a:c513 with SMTP id 98e67ed59e1d1-35de697ef49mr3761590a91.24.1775256824096;
        Fri, 03 Apr 2026 15:53:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:43 -0700 (PDT)
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
Subject: [PATCH net-next 2/5] net/sched: netem: remove unused loss model fields
Date: Fri,  3 Apr 2026 15:52:07 -0700
Message-ID: <20260403225324.476787-3-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275261-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: A922A398DEF
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
index acf92cc44126..6a234880d338 100644
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


