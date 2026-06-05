Return-Path: <netdev+bounces-295943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NHIcGlwYI2o3iQEAu9opvQ
	(envelope-from <netdev+bounces-295943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD064AB15
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LE2po7YG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295943-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 566143080D49
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A423FC5A8;
	Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700013F9F23
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684556; cv=none; b=uR/f2lhf1QWTMO1KHIzCpwsnixEL9OqTJ2lxff9m87Jyw30Y95w3ZkBEwTYfFblpyhB4JxnG+Jj8UP3g8/RVC2ZaSl3x0I+9EgcNHbXbDkR/kctKp/NCDvKPYBhVQxI6xHmaquJ1lvg4XfCIJ5Y3hRAAtXq1KwuDI+MNXxX/HbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684556; c=relaxed/simple;
	bh=bdDero+XyXIqJKT2CcYDDlJxAtQ+MlH1wwcGYYvKqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw6/qvTKhYfrADyqffPNFFxrnczHX8zW5OoX3FhQZStvOMeM4cPPIYCi0y8iB3vgWKDtz8OTUeBhpR+LUyacJM2IFvZadQLN2lFBegKK/AuyVozoanGSEtnB++yAeKuugkBP3Laxz5gdo3j6jodWB6Shs6auGPWNNSkTYvm1wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE2po7YG; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso16488785ad.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684555; x=1781289355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCQYih7Qu6X9/MRoiGqCVzcGjRebs+PoxLmTpVbEJQw=;
        b=LE2po7YGuv7kVfch2jy1Fg9WIwTZRQZuQ4udv7xX0jTjMtSaPY7L8DAfv9Ifs6lKW4
         EYRNhWW3yR/qOWYnVeDzmaeEmxD9Y+XHWUHOaTf2znZs20nBflEXNaDR5UHvhN2Rz7B6
         0K3AAFtCafO7rAUkUbqy2cGWv8dJC3u1wKxN+FhFAowB294me3+CWJXzg/6OV3U5a0Cl
         XLk+82JNW7+WK/vhuxSNsWWbuxFnC74awk9ju660xhvHqOHiSCqZAE2WPCXuD40tJuXs
         DacHKJa/tXlrhPLaEx8uUoZzGQdNHzOgTHh9UjPgcKCs2ClQ22bv/wNBWklSYSE8H7A+
         0zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684555; x=1781289355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCQYih7Qu6X9/MRoiGqCVzcGjRebs+PoxLmTpVbEJQw=;
        b=LzlhCRqEOdzvTVcM5Yn4HwAHW0GCqh1PALXF2Pm2eKMLXoo89WwqUmjIWe549yRjuW
         1xcjpHv245kLp+mxdh46zFAi3+w3fI9geb3p3WZeJ0Lh393K/2qvAyo4h+pfWyD+I+hs
         ou/6QmaEIhULRbdg4zse7U3UF8jb5oatPF3b27HbNMSnTpIt67qvTfxrW6e0YzTP87y/
         0P6i1QrARETuErQiYnmSnUJ8IRUoEAswEzgTcTxzHIkiToukH7gWVNYCP/g6VlTQXc9C
         7PTw7XeueEVdsF/JJWHPLMWmyBFDk+vp/rRdnm7Qaa6JpXB56MOlTp8UB4ZyDjaF1TYQ
         TXlg==
X-Gm-Message-State: AOJu0YwQ6MC67Fv0LcTYdR/S0rcPzlh1vyQIGYLuEuAvQPBOYSGP2M46
	gtP+BNLwntEEYEubO26lfbsEgqg+KiLbqEpWMxpj4tjL/aHYsHwnP2Jv
X-Gm-Gg: Acq92OEYfgBvc3YSKw2YwCAFRlzP9/fbguH7k3eRS9Ke7TfT71ukELn6fKPK0/04eeq
	lrcPUH9oxIIs+Y/XOlkf7pJJExCR301aqMm5e4gZTSr57WAOXA6C2DpmPNPwHzZxV6JFxE+++B8
	fkK50zpiHtW6/CzU2YAzinVeZqLfzZprMOO8krMFWzCGYLGdVzoNkpDyEsYSE9hvzWDlcw1plG8
	sDBLHHcwH9zQ8TPtCYSCGTWFn0KT0QevVNu1nHEeBgclMjngosRl50EESvcSVeZvg16a/70PzIU
	lGUlflKHJrggjqUQDsgiJ8rZuPnAz7kVsG4poKT9q77lCkhuZQLFIMSZfqtDnDNJ0+Lp9GxpO9b
	sYk2PbogLrHlwCxanXZS6xyoMNLCGPTh40MCP9r0ShyPKhoV1ChqMeO+Po73PQsd2E3kxopnOJZ
	MuLJXDH2nTv45/NcbhvS3GPTHd
X-Received: by 2002:a17:902:ecc3:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1e8339808mr52702625ad.33.1780684554636;
        Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm142698675ad.9.2026.06.05.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
Date: Fri,  5 Jun 2026 11:35:48 -0700
Message-ID: <20260605183551.969144-3-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295943-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07BD064AB15

When acquiring references for struct_ops program arguments tagged with
"__ref", the return value of acquire_reference() was stored directly
into u32 ctx_arg_info[i].ref_id without checking for failure.
acquire_reference() returns -ENOMEM when acquire_reference_state() fails
to allocate, so the error was silently stored as a ref_id instead of
aborting verification. Fix it by checking the return.

Fixes: a687df2008f6 ("bpf: Support getting referenced kptr from struct_ops argument")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6446db9628ae..2a18b8aba14d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18362,9 +18362,15 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
-		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
-						      acquire_reference(env, 0, 0) : 0;
+		for (i = 0; i < aux->ctx_arg_info_size; i++) {
+			int id;
+
+			id = aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0) : 0;
+			if (id < 0)
+				return id;
+
+			aux->ctx_arg_info[i].ref_id = id;
+		}
 	}
 
 	ret = do_check(env);
-- 
2.53.0-Meta


