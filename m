Return-Path: <netdev+bounces-295946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0QAtMCcbI2pHigEAu9opvQ
	(envelope-from <netdev+bounces-295946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B487364AC1F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:53:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nWjgTfNA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295946-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295946-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55FD6304DF9F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA103FF889;
	Fri,  5 Jun 2026 18:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FD3FCB37
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684558; cv=none; b=tzOpY0QI5gfeW5FuKwvvDMOiPVbqPzDCCnez9yl9ZvtosXtRQTIkcmmVI/ME3foXgpN0+Qg/H5kSX1b/hQ3CBkRK0rsbqI+pjAzn+Gd2JPmrbKr8ha+2kQGY9AUmJbSokXGvoT00iyr+dq+Xp4H9KRe0PQUmWr+GsgguEVfVyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684558; c=relaxed/simple;
	bh=qV4hSRgYCAlZ/cX5eOLisIxPMgz7Jx59zHgWJ0fU8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN87ZuJbKTNCoCtx64ZKjWGL7Qz4Uc0yq6/PTp01XzaNl6LRo9TqmOvxAjiiH4M1ttvnjS7w52NnEN5749n+sEJ54NkHD9u4i/iEIAdABZmtj1U9B+tfSblOjSN6GbeSOtg6TQSVyvnDo45DVWsjjTtFPRyVpKO4PDuPy+HKGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWjgTfNA; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c132ac5ec2so22347005ad.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684556; x=1781289356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=nWjgTfNAYOxBscmkX8lS3VvhPsTJfZVyKbOgVo+rIXN0NIOtNDYh9G4pBRjm4azDR9
         zGGLmPfaJlS470uE1YFTy4IIBDxPNY6SHPwtFp00JEtQazDD8V2HqaKK1+Qd0Th0g5fs
         2STNu9B18av6EyDY6/t/cv8PSzzKbxF7Rf0uMy4srintEOOZUU/fvdULES2JxbwO33OV
         r1ftOaSl3P6ANb6eQZl5EMQaAfUkjoIuPGTZnXDYTCQge+e0KmVciFyhfFaK2rsHhCXZ
         LmVT2wZhLGOFYMHxE5jmzdY6YV656t5c1Oua665DnN/VRnMXjQ8m60zqM+OQyII51a0a
         qmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684556; x=1781289356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=bSbKBPgMY6zpraY4EkIwCbuF+zpC3fJx9u0k3K3GFSBJGeo8dXWL/ZiHohKgNqqkRd
         Y3VaCPF4sFU+DowsKjxINafFPyX81uakwjQKnKU9R01w0ufOfhri4AXuJqNK1NZOozae
         iOZWDG4mbUbWsJuT/oL+r/tO6XHL43/IlASJ0mOZ2AyStR37yIgadZHmQ24ujMGffrDH
         ObNlUrqJIsYK3dwJsXGKk5v3FEbruxvjjxKNmsBeFeJPfro6X76cEZ8kCpXUQEznFRYv
         rlyOHR6TlvjXB8o5oDWVtquy3lT9U0CdwRCwIFrPl21hIGSmBm5KSca1UWtcJTcUS24g
         XMbg==
X-Gm-Message-State: AOJu0YzjlNJIn8hBiWpSdHC7nB1R+mdCYC98VkTSa/UQ3FBV5fP6gdB1
	StNEdr20Ql99BR31FqEhgYXAH568I60uxNxeJ9K7a3da3Y4qKW7FfnW6
X-Gm-Gg: Acq92OHi0X8J1hWBfp53ZgAkpxdzHGTZGUPjVPMq7zTKGzai0EdKlzU8d64EhQeC2cc
	otp5cYS3xNQMPKkj9D/akVTWyjsa46VY2u7NLHfCgZIuVfD68YiEh3INrauVuIwcrg3Ezpe441F
	9Vlgd54RcmP3adk63f6BL1wyrSyS6UeAA/+2rmUIm+zw2drDOBnUOk09I/Ev/bsXyDHWKs6nwqa
	3ZHovTpQR+HRgM+gE/AVToXqzlNY4VdE/R+jNRlffyJZMkiCL1Y+tEegcWLAkvbx3lqRjJR2EOo
	Y/te/7bskHK0BoLs+17rxIxo918bnqr4wWqPRcU6b5iIlF81TgPprILowwQN7Ljlhb0MlbRj//t
	FFfFoZZoX0i3IheA6SC2yRPS+qDdowZ2ayDewvNoPIUqN3Om4erZEofdp4HQaulCnPVYB+n3kmb
	pWVcwF69wFcD9jJ2ucdhMvqXc=
X-Received: by 2002:a17:902:ce8f:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c1f2624b85mr37613955ad.20.1780684556576;
        Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2d7sm100260565ad.39.2026.06.05.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
Date: Fri,  5 Jun 2026 11:35:50 -0700
Message-ID: <20260605183551.969144-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295946-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B487364AC1F

check_ids() warned when it ran out of idmap slots, assuming this was
impossible because the slots are bounded by the number of registers and
stack slots. That assumption no longer holds: referenced dynptrs acquire
an intermediate reference that lives in refs[] but is not backed by any
register or stack slot [0], so a program can accumulate more reference
ids than the idmap can hold and exhaust it.

Exhaustion is fine for verification correctness. check_ids() already
returns false, which makes the states compare as not equivalent and
prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
noise, or a panic under panic_on_warn. Drop the warning and keep
returning false.

[0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 06d9ae24f006..32f346ce3ffc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -343,8 +343,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 		return true;
 	}
 
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
+	/*
+	 * idmap slots are bounded by the number of registers and stack slots.
+	 * Since referenced dynptrs acquire intermediate references that do
+	 * not live in either, so the map can be exhausted. Since it is unlikely,
+	 * fail the verification by treating the states as not equivalent.
+	 */
 	return false;
 }
 
-- 
2.53.0-Meta


