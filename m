Return-Path: <netdev+bounces-279457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN5TFTj54mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E663541FD70
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6635930C9B24
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DCE29B77C;
	Sat, 18 Apr 2026 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="d0CezURk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A731B824
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482444; cv=none; b=OgKIb7LEtg5uMmoi5e2Mbif7R2LJXGiD7czPVNCfaFHurpIKSvdoCI5OXANti+H/K/9jhpL5fuV2uBASFEx9eo5cbQYHD4VTQO1WIQsgQu3lnbuQFE3hg8KZS+6Z74oZKy3YmmJfkxj18pad6VCmo9HzYTleA30daPXzan+g31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482444; c=relaxed/simple;
	bh=vSplaqLkXmfo7TA77qEn58Hmsj+q6YE1iLyw26AGfVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOADBIdRB9plkB+mV2Xjc61qRW8mDPFfDNq88pqHhaKuy0uZP2soH0FY5OsHbwubIxmszXIbu9y0lOxAynJDkjZEvBs2E4SD0kbiZeEoUc5wVMSlfR8wN1k1BH0v2tIxJnRiKPiZUYHW3QWI90VlH/7kgb9isrr0uy8EQHtRWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=d0CezURk; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dc3d28e2f3so1323237a34.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482442; x=1777087242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF67GBst/gmun1bR7fYRDBK8/TSA+XE/bSbimdqCIoc=;
        b=d0CezURksw0OjY0kXaDo5u8aWdrlS+d0NlAEHc9jQJ+9HzqDwznNdU5gffsNwa3rpx
         px29/rZZRoD6ml78jSFk7892L1bXvK8P8cg7FPcpOi94fOLLsHj49tI6ilhcz61+A97o
         mk8Df/xEUEuqBUyxYiMhgZ5Kt0qprB/vSfIyswQh8sSGhJnktCsSapikHIxzeSp+2+0n
         dyBuNu3pv8cUjmR1HrEmAR8XqEJf5yZ8uiDa/zTIuUuose51j0GnSMbQPmjDUL/ZHyNB
         1J0HG8XtFKWHgqRV6rSMokLteh8zTYG+QVMR2Ao3Y0Uz6EDARmNMOYX2qpQ4Ep3d6woJ
         lzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482442; x=1777087242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lF67GBst/gmun1bR7fYRDBK8/TSA+XE/bSbimdqCIoc=;
        b=s3OHDJgkZpEQLDxDru2WWkDxys5QQTQ8zOtmNaCMcoLrA4R0dGoH3oThsO40MUodUk
         LyWKInyxa20tZv89oL7NLYdxJ4IHxW4bPZGM1rrIF3yaw+2PkExXZkOR+oxibcfKYtKf
         v/Lyo0+DIDRw81uxOHRwEgZfi1hriIh/vyfGvJJC/4NoTOhO/qH9wINthtE+oVJ+UkU+
         WE0uO+ouSSUfOEbl4oG6NPq0g1GsAuz2pyo3vDWGF3rG2TCxBHspXfGNkPwvE3UfePh8
         lWmmLtMtr3oSOErJn5hBvGo1hBFE78CK4OVaGxIliz3c+h64D7+Opo5PluTrB9BvzWOv
         exzQ==
X-Gm-Message-State: AOJu0YxSdawwzKohct4E+y3+k+m01x4+RTzYkVQ/C+DTVr4e7v+ytCwG
	8CQRiZ5QWrlfggoIcA5fNXEwrLLmE1kJjZ8jnd1OqypId49NIv9r6yjvdn5zrOImofSMVSWYQ3f
	Nmv/e
X-Gm-Gg: AeBDievorL3wA2gWzjX7QDK4AahJIvdXEyesafar87nodSHVHNhBis44MEwW8Xapg38
	SJrmgIWrQfgvRuxOcBCef/oSgtxBw5EP/WQErrMCUoV4WQaxJz94AJWEm5mulkez1zZbYSswwMk
	cf3i6Bzk8tosU6fVYlSVzsC/vfI/nDy3EDKPqvoeAsYFDBpyQ/wwLmZ4OBuFkUmQALEDLf9nmk1
	VED3C9vOPzpC4P5xDpI4GFBe5qkfvRxvCgh4fhF0BEgzPKIH3iCJsSmkHACvW1N8macd8SfJFHO
	4VgB+mEX+w7uYauB7tCFcyc8i2jXF2HwcMegCAmeumf23Xy7Z0beqlC8zjKtZilaS9LYpAAHFAf
	t1KDUVnTzXe4KNdYWl1YXeBQBzpAIFobZHuBMpXZJILE+SY4xsbVpx2TeEESWqQ1sBiUE1jbMfk
	Q2wSsy4pX106vbHxAFqfvSfT8wVyPoY17RzZXsRkG7C7M=
X-Received: by 2002:a05:6830:7305:b0:7dc:3e5a:64c2 with SMTP id 46e09a7af769-7dc950e38abmr3488520a34.9.1776482441778;
        Fri, 17 Apr 2026 20:20:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dave Taht <dave.taht@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 6/6] net/sched: netem: check for negative latency and jitter
Date: Fri, 17 Apr 2026 20:19:44 -0700
Message-ID: <20260418032027.900913-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,mojatatu.com,kernel.org,networkplumber.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E663541FD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject requests with negative latency or jitter.
A negative value added to current timestamp (u64) wraps
to an enormous time_to_send, disabling dequeue.
The original UAPI used u32 for these values; the conversion to 64-bit
time values via TCA_NETEM_LATENCY64 and TCA_NETEM_JITTER64
allowed signed values to reach the kernel without validation.

Jitter is already silently clamped by an abs() in netem_change();
that abs() can be removed in a follow-up once this rejection is in
place.

Fixes: 99803171ef04 ("netem: add uapi to express delay and jitter in nanoseconds")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 475c14b3dbdb..bc18e1976b6e 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -826,6 +826,16 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_time(const struct nlattr *attr, const char *name,
+			 struct netlink_ext_ack *extack)
+{
+	if (nla_get_s64(attr) < 0) {
+		NL_SET_ERR_MSG_ATTR_FMT(extack, attr, "negative %s", name);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1068,6 +1078,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_LATENCY64]) {
+		ret = validate_time(tb[TCA_NETEM_LATENCY64], "latency", extack);
+		if (ret)
+			goto table_free;
+	}
+
+	if (tb[TCA_NETEM_JITTER64]) {
+		ret = validate_time(tb[TCA_NETEM_JITTER64], "jitter", extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0


