Return-Path: <netdev+bounces-278159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ5CDrst3Wn1aQkAu9opvQ
	(envelope-from <netdev+bounces-278159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA03F1B23
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7199D3034B14
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49929372670;
	Mon, 13 Apr 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG7J4EKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB4375ACB
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102165; cv=none; b=Sj9asG0Dhow4vWqVJEsK0hR4TFgpz0kQ34mqXbuPPNwiPisJMT1kvWYNlUzeJMbNZSpVfaM7ivtsHQD53ifBQY9zBtg0TJYhwT9VOKxTwiK6b2QN1eiZaVyP2WCzAbk36o3wOAdcpX/DvVUR/rgMrqL0/Ar5E/7ZqIHvsdfLKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102165; c=relaxed/simple;
	bh=pdoX2MLEvejM5bPSuGFepVTuhjVGnBZH2TLsHDge3VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5wS9r3UdV6H526OA+coBFNfXMbc962vZ+TDInZH3xxBA5F3ZPgflSWjhaG+34KVaN85lzZ1srO1AY19HxLQgFJQ5iC0w3zoQ8G1//xwPaCGjNy/pR64+NvLwC0lgfn4QxPp6kYcKdfWpXcI1vXvLjI55HRBn2mx246sgAbDN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG7J4EKO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso45023685e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102162; x=1776706962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncBfyn7ZmgBmJPdYm4Jd+RScDpN642VH/yxjfU7zB0Y=;
        b=SG7J4EKOouJFzn5JI2k+Nl7m4iRsUz/Sa4hx+RRPL2lmuVE0xIhf9jcuVuUaa+VPEM
         96eugj0FDb46JyxtRe3b/JPE4sdJu3uZc+Pfy/gylBtGQQZx6C+qiPbl+E2rnhD5TcyE
         d0gbYBlQUNuvb9kRQ7BBY50lPaearlL9f4Yiln7WOpU4GbjJOMmvOSGNmh5sYOsxRk39
         +9+pEXWeGAbZ2Y3ZJ7+8zan8kmVCezSnnzUxJWZnUluTwgxeXVm2L5ZdxxNMtQWWUZ9q
         rXq2+QC7XcaROznP7KK8oNBlLekLjpILk89OhT2eHOq7jx8LQ0EVMNE8poP40y6Tb+nf
         HVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102162; x=1776706962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncBfyn7ZmgBmJPdYm4Jd+RScDpN642VH/yxjfU7zB0Y=;
        b=ItGEV81MRXItoLMn9KoVCsSC6XE8jKyJ7ShsRM8ImE2aXJBCXFzms3LuSQtiNgeJK0
         EOIMBQTQ40SugxYLJX8BrsM0RbgthkkRfatRW6+lQ1Ndmrxn8QxkFtsxXngQ3ctrVT8E
         eq3Y2dBZamPPgTSnS3OfkA1cEOQJEQ3zNX7ch76cqf3VEn018e2XxT6AS8VlirJR11nw
         j7/c6KjZ9+MRpCEYUlNP3W/dohZEeDZiyS0Z6rt06A/h0PmN/f3+7EtyulJerZ/aSkL/
         VSwHQr8LDDHF1ux5VzdL3D9akHJolz33dCXp1LF4PdBxHHaAXfTY6VirqEvHtLGLW+FP
         bHVw==
X-Gm-Message-State: AOJu0YweWIB6Z3fwduPPLgQWqSLEDUqiPKnG1u5rXcJomy3B+JX/2Eld
	6qGD+J4PHd9/8LAJzBCN9IrbNm25Ct4OZr3whtOp3Uq32elAOzg/pWQz
X-Gm-Gg: AeBDiesanQY9nXbB+9rIGRoTc+DDYGRNo2S2+VEAzylvrl1QghNdOuD1ovPB2jjhWGp
	nnBZWCYU2GJHN8IjzWTpGaKVZ2qRfLi+GE7VlucXpD3/ZX24iBDHUQZ+kAl2JSFXyj+/xSCwx7/
	1vYDc4AwC/tqmDB2y0o0oc9NgfLpUNb+3QJM+vIK4FWyTVh14jxYaYEX7UXc9lCHlRndCKofjNJ
	RYzZ62HzYvJr0wbV2Mp38Qu7x6hqgecoYd1UUgPDRTnTr68C+d0wEyd0Pt/tErnPfhdKc6Kw/H3
	ziW9L2XD6v1p00uSL/J7kA65/yBnZqrdtQlVdEeWvITfD3qGXRpmBs2OEeaFUj0OLKO7fv2LfbB
	qYhR1wkKrWQQKmDfd+63VPqvsfecZsWCPsAYeCjS6x/u8262QSm11vT6tKTaK+H/kT2ZnV6eFDP
	8Ws6Sa156AHR6mAxxVzBWvRB4r/nWDVbHLH0qpIRdPQr+0LWB2SYiELejylK35CecoRx+7GT0MC
	81P
X-Received: by 2002:a05:600c:8883:b0:488:869c:eda4 with SMTP id 5b1f17b1804b1-488d689b4edmr142634005e9.21.1776102162312;
        Mon, 13 Apr 2026 10:42:42 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm34922778f8f.29.2026.04.13.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:42:41 -0700 (PDT)
From: f6bvp <bernard.f6bvp@gmail.com>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	f6bvp <bernard.f6bvp@gmail.com>
Subject: [PATCH net-next 3/3] rose: guard rose_neigh_put() against NULL in timer expiry
Date: Mon, 13 Apr 2026 19:42:38 +0200
Message-ID: <20260413174238.112418-3-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413174238.112418-1-bernard.f6bvp@gmail.com>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
 <20260413174238.112418-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278159-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83EA03F1B23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rose_timer_expiry(), ROSE_STATE_2 calls rose_neigh_put() on
rose->neighbour without checking whether it is NULL first.  The pointer
can be NULL if the connection was already being torn down by a
concurrent code path (e.g. rose_kill_by_neigh()), leading to a
NULL-pointer dereference.

Add a NULL check before the put and clear the pointer afterwards.

Signed-off-by: f6bvp <bernard.f6bvp@gmail.com>
---
 net/rose/rose_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index bb60a1654d61..d997d24ab081 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -180,7 +180,10 @@ static void rose_timer_expiry(struct timer_list *t)
 		break;
 
 	case ROSE_STATE_2:	/* T3 */
-		rose_neigh_put(rose->neighbour);
+		if (rose->neighbour) {
+			rose_neigh_put(rose->neighbour);
+			rose->neighbour = NULL;
+		}
 		rose_disconnect(sk, ETIMEDOUT, -1, -1);
 		break;
 
-- 
2.51.0


