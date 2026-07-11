Return-Path: <netdev+bounces-306814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6RPBg0eUmqkMAMAu9opvQ
	(envelope-from <netdev+bounces-306814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1A74144C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jqVxRcO2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306814-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B874A3017CA0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20DF3BB9E3;
	Sat, 11 Jul 2026 10:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3D3B7B84
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:41:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766467; cv=none; b=eO8kVKAdH2dTKNnfmdoQBi47H+NlejCnkoBdQun6KAj9oPQwA5RhjLniDxGtK0tu/da8nfNsaaYfKWee8tLEGRjoNL5uVB3yF3BwrxBC8aW8uCjbSoKQFLZh2BPklBchEnfUJa0DBOEN7mn1HNUbT66wGYUqpPLOzc3D9/BB9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766467; c=relaxed/simple;
	bh=XcwPk/xz4rph3atCxJxjVPf0kH5YBWVnQhnf5gTxLeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7WRwrsQP7gbP5D8hBYBSwEhBR/BV6+o0WavBNLIKr/mf/UuMvVayGtfxQnCiD7n4TQlrLFNO/MjJwfcsePQw0cCEhZCXGuerPr7EsfjqIDoZd8iTOxDiC2zJcccGXS1+G40zHRu/FYtEB9CgDSjKhxFWlpPioa/oKuHq03AwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqVxRcO2; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so3137029a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766465; x=1784371265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAT9Ipoiha/afQJ9Xt4cvUQUYBf0y1hE71aqbx/vl+E=;
        b=jqVxRcO2beiHeGqIK7kLY8pPEd8NxN1RwGVqV33vQakilL6HaHbYMuC0QL8aUmT/Wr
         w/wGpOfg6spR5oxmmgXIDdFequYUJUz7KeokiJDIKTX+XhBu3OluZHVOGkiLlzrNvIIO
         YrC4f14pMdcv7FMl3/MXIyFoABXnIdsYROjQ8l6F7jeQlSlhWhOBbw1Sq0TnneIw4N4b
         vn7yolmkZO79qwOM3HZL8Un5mLvudyX+QW8DIuPqcq1ovAK3DtaDpBpEb6Tl8Tgmk7jz
         u6l3YyeroLNwBmkeNEIGSk7j9Jpg7ssOcsqdt8CWJX1IVsi8ajncCTwuvy7EiIuEybRE
         R1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766465; x=1784371265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAT9Ipoiha/afQJ9Xt4cvUQUYBf0y1hE71aqbx/vl+E=;
        b=niLntrOoYLxqP+ofHRu8v39cb0TCrszslEwDCh+5HLJdWmulEPvoNHOLCzp00wOg4l
         xzeCYXXn9Si+JaEZwX2VXPev68skdVl6oYsFVWFLdU34EHbcAhApJ3RawX3Frp0mWCyV
         N3DdmPMAmoB+q+Lk6zHKlsoqzm9TfiXYcbWbu/x20oKn5Fsicy9uDhp3zDQm36m8s72a
         yLuVJu/38OEdjc9Zjp0PDMc2417mXkLQi1diVtp6pw+1TMGYgJo7YGtqMp5xEqP+e9Mk
         VcH9LQb2zgnf/bBXu6D0DS6rhrFd41wb9nFFDq5/K1xiuFCdBjFoAh8FJ7r79wnQjVon
         L4Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0NyJLnTt7p3kRT3e2e74tKgHPx6yK6tg+uQOwEpTr7XaZl8sdb/efAolix3ycEAEuSViqi3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSkrmeVe35DMo3gReIW1HvMjDpPpxLgTq+dc+u1EiANvg/YK9
	D4XMBfA3iLHxSxTqf1iPhWktvUQ8u6Gahh9ypHs3BIT6+Xp6ocvbSKVp
X-Gm-Gg: AfdE7ckHvs99iy04sY0DhvrZgGHhpSIuy024EpUZdznqTDiTU7GEJXPubuRqhC8hd+e
	3YlWCmBkkpprJgMKfhgp2jN0s+Wx3rLTgMzJU6H/z+641XgHy6Y4AL08mNTD6n7t/CVULrxY9XE
	DByNk4idLF+wLpsaDrMep6Bf3B6afxEOE4JX3BNVN0urka5h7KoC9saGXB3aS/HqcSQehpLBtEd
	+cHi2sGgGMNyvpp800xO1HWCxzaoXlwVL8hxYGE8Ol4pBMDc9gfUMbhHAF2KWlkJBnJWhZEtKom
	tkT54jdN87RiqHFso96RO1EYCSsU5eLH6sM6NGIcBtbdHfGVawCAeg6rZhy3Qmx8uptISZhJfH8
	GDeCpsAF4zpPX98HLJDP81/LC7+qaX/aBRzrnWTD1IBryzeNk8Epi92cRtz0seQ6vn5089YPSeY
	/TkjUcJGvbhaQJZgXXJd6UdEajD6ci4sZSCus+vQGM+tMEfefCC6J0RmU/wOPcqllYHj7MHNUjX
	Mxn+p2+pgUN8L59U5LgkZHfyTHbWIwoYvbwpwhH3VUMz6SG1A==
X-Received: by 2002:a17:906:fe01:b0:c15:c3bb:c90a with SMTP id a640c23a62f3a-c161f3cff37mr90002966b.35.1783766464499;
        Sat, 11 Jul 2026 03:41:04 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:41:03 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 11/17] io_uring/zcrx: split append out of area creation
Date: Sat, 11 Jul 2026 11:40:04 +0100
Message-ID: <62a444a72bf8574c92e4e97751fd8b39b5f17082.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D1A74144C

A preparation patch, move appending an area from __zcrx_create_area()
to the caller.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 4936d92f6339..40cabf4384d1 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -471,6 +471,7 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 
 static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_zcrx_area **res_area,
 			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
@@ -544,10 +545,8 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	area->area_id = 0;
 	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
 	spin_lock_init(&area->freelist_lock);
-
-	ret = io_zcrx_append_area(ifq, area);
-	if (!ret)
-		return 0;
+	*res_area = area;
+	return 0;
 err:
 	if (area) {
 		io_zcrx_unmap_area(ifq, area);
@@ -560,7 +559,19 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
 			       struct io_uring_zcrx_ifq_reg *reg)
 {
-	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+	struct io_zcrx_area *area;
+	int ret;
+
+	ret = __zcrx_create_area(ifq, area_reg, &area, reg->rx_buf_len);
+	if (ret)
+		return ret;
+
+	ret = io_zcrx_append_area(ifq, area);
+	if (ret) {
+		io_zcrx_free_area(ifq, area);
+		return ret;
+	}
+	return 0;
 }
 
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
-- 
2.54.0


