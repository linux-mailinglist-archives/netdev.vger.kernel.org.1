Return-Path: <netdev+bounces-285571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLYHMTlE/WlDZwAAu9opvQ
	(envelope-from <netdev+bounces-285571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F6F4F0ADA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156563051C77
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9824E4B5;
	Fri,  8 May 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Kc2UWfMo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE002475E3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205597; cv=none; b=FYAi402Y8CMcX/G89nICzBKd/5XRmNwPe6AbOQutKIapc6yW2dXi05pOz2FOyTDkoAJBgIU4wcXbSobuThr1vYO+ReaBG2LJ2KS25O9O/gQ88JjXE4atDZe9VLlLArtxWtd+HIIE4qx6SXBs5DNqEe3MujQjAlXMF84l13x+PgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205597; c=relaxed/simple;
	bh=n4p8Wazm5mRWef7fULkKI12PxnYi9537npSj+nYtDv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luY2I9Ice2/MJgmG8Jgqz94/wsKm8wzETdT2LC++ZNN46Hu3rJk95yyMFEAYDcNtAObzUPnDNKMjSbWbdiJtb+zjpNciilugRKkgJaxAWOq9NFBljhLQr8Vza75dQLJFckLpDr2akb8Moj93yIz1r1SqX9NrpdfeVrGaAou69rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Kc2UWfMo; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so947409eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205593; x=1778810393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO7r/0+4S0y4yz1yQOkpBoCSLB5Ya43l7K/dBhK3N5U=;
        b=Kc2UWfMoUBNLu57oSFa+ZAlwM6bHEPIKAPGIT6MkGdRsEHOxdLsuOJ4V44VEzNzCaO
         MfY0r5CxII1B7B+VcWDRJNgCGJKEA+RG5iNORECxJt/DZa2AY1RsxM8NlI+k7sC/c6Ei
         Y94QW4oY2ftW3JaTgpzQLT9wqoR+wleBpYCfpZPlYFEZZ42vtiOKT01tS8OEhUdMf3NL
         X4xTbMMNfTM/OUPAvO4Jn2Y7cRFGuSmPspFSvBWfdLcgEvOe1cnPsVJbLGEFicNtEA8A
         tcQ3TBNKyFVYAQxBxfbG/l7N6ZqCqJG7xpZIHQlb/fTaaoCsE5Tqu/uVyxU9SuzztJia
         8AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205593; x=1778810393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TO7r/0+4S0y4yz1yQOkpBoCSLB5Ya43l7K/dBhK3N5U=;
        b=KZY9XD/ltY2VdTTbMYbS+2CiX+0GbrMYcXKm9uvTzh2j2A6X3kKFcYrOJVIHQKHdjS
         Lpi7y9ky9av1mEVetuaBeluMA0PQW52Y/I7033ocz12axLB8kV3tVegpBGeKEXMfQRWt
         W2XGBPiztzktQ627cNzDfolGTDi6xa4kN6OdciqXPnBhLpQnn6ErVowFfUJFoLRkGuju
         2FkMlbN+Rk0k0jl15Dq0FnI7X9kB/PvZ6BsPBj2iZh20GMDFqxgFwfPWNwzjHgzNDxdH
         qJYsUhL7HKfxmtkxCzsprbhMusFi+iLrX4BZsUkuSmCr2RojsLZ05pJWnz7yp7xzqU/F
         3ZHg==
X-Gm-Message-State: AOJu0YxW9wCNZYlU2CJaAaxgXe8sadxH+ZyhsM95f+0aA3CunjQqfGcp
	ayHbcJHliWxcMbFcNn4I917Je3GNKglWyCFMa7HFt3RU3vtqTqRzWU4VLgVgjtyZz2m31TPMujo
	3lRpz
X-Gm-Gg: Acq92OH0qRigRgcNPUFVvPLJmSycLlsuUyDik8wI9y1J+3jK9olxbxmEy4PEYj8ZlGu
	fHo4T79Lp1s6z6+2puHag8vBIAzL//GoZTqz7v2P+kgR2FbLYs0egOGcQNXNvKRFzDDkVcBPaB8
	+vGrhyTHRCuRIFjSVhxVPy801DnR2UyKmJSVhhj0ooJ4//drrVAlnxzxhlguKBKJ0WnNvT0T9Xw
	L75uzvwF3iU0HUFaXeLTVw/ekX2cKhfB1zzLwFXe3EkWdXU4ERKzic9yxm1IeEmPcV6oIz0s/1e
	jbwRaI/uEvKh2rwvtImmQza0kHFCW/y1BdVfO9PnEsq1Kft+KA4Nofl3QNOtxuvcYE1X/+J1qM0
	86AtgsTTv1s1+fg91hLtqFHttqW5fSLpOVOcaNJSChak4YRnqUTnQ4Q0pvzo0nguADYEncHWB+/
	UTybOud5xyejdJP7pfQj9UbGMuZfPyMeiF
X-Received: by 2002:a05:7301:168b:b0:2ed:e14:7f54 with SMTP id 5a478bee46e88-2f54e47ec98mr4509673eec.30.1778205592917;
        Thu, 07 May 2026 18:59:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/5] net/sched: netem: handle multi-segment skb in corruption
Date: Thu,  7 May 2026 18:55:20 -0700
Message-ID: <20260508015940.554462-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508015940.554462-1-stephen@networkplumber.org>
References: <20260508015940.554462-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30F6F4F0ADA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The packet corruption code only flipped bits in the linear
header portion of the skb, skipping corruption when
skb_headlen() was zero.

Linearize the whole skb if necessary before corruption.
Extends d64cb81dcbd5 ("net/sched: sch_netem: fix out-of-bounds access
in packet corruption") with a more general solution.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 53bdfa77ee2d..37df05bf43ee 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -513,16 +513,17 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qstats_drop(sch);
 			goto finish_segs;
 		}
-		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-		    skb_checksum_help(skb)) {
+		if (skb_linearize(skb) ||
+		    (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))) {
 			qdisc_drop(skb, sch, to_free);
 			skb = NULL;
 			goto finish_segs;
 		}
 
-		if (skb_headlen(skb))
-			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-				1 << get_random_u32_below(8);
+		if (skb->len) {
+			u32 offset = get_random_u32_below(skb->len);
+			skb->data[offset] ^= 1 << get_random_u32_below(8);
+		}
 	}
 
 	if (unlikely(sch->q.qlen >= sch->limit)) {
-- 
2.53.0


