Return-Path: <netdev+bounces-284879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGvQAHNQ+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB44DC344
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB08E303E430
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39B481A82;
	Wed,  6 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlF9vbv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A147ECEF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077649; cv=none; b=H2Y6NcvBdS5oyEQ5GQ3avSr/2jBfyWD3RzJsZtft/MpP8gyXob5tSdUDqzpAAVFsB68tSGsutjBLUoILzpbqA1vph/mtPMP9anJ4WOVFgncOjsZeYqM1R8z4qRe76k4nwpNXyLYCycZ/VlmJDYJB9A0vfwI2ZnX49GDSno0AacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077649; c=relaxed/simple;
	bh=X8MSybBFOkR6ALrhCC/ifL8fTtYZy9KgNxNDtH+RHWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRCPU11ipHXhncGVq9kBgM694PvBWy51ozUZCp5IH7X1a17S9TbW6KNQHHUQ/P8fkwIXA0VTFqsmgVwpSF78sEwrYaAcO61zfzWJsU4ctIC91vNCRmmkGhLH+N5VvXtX7ctxAg3S5F8uYZK4Rq+ViSlYaGIpJlQI1UV4KgM9M/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlF9vbv7; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so1740311241.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077642; x=1778682442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DejvmNUIGRf0twN+horCVPXU2liyYcsRca0rGZrb+EQ=;
        b=JlF9vbv7T9Df/nx9YvSZ0SjnY1yhwz5fcOf7diEoontq66CZqaJbuP4iNZbCwVHvAX
         xEiPTXWy1EGdiHF0SKMzzvlG6UvGustDUUPyXfWNIKX9tbZQX2DjQhDdsY44B2GcAVxz
         UpD49Ks+eljH/iOvw47Pw+WnVCSmfJQFRF9Ky/t2dogvTk/LZ6VXmRduZGdQh0rmFXBg
         zriEOaziLj9iWzbmQM9UBtWH50Q6tytFHg3FJSblSIclJ+k+b3y5bnMZPLIt0ldh4Tqd
         IwVTL2hI4SrdlB2MPSuqp+EUV63OqTAMPHduC9vfw4DAxVxQ62H/N4R8OSmRXBwRgARr
         KkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077642; x=1778682442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DejvmNUIGRf0twN+horCVPXU2liyYcsRca0rGZrb+EQ=;
        b=U/sB15if3IuWFcmXuwbpLd82JFp/AvurNOzwb//ZxSljVHrrd/ncVOb/99VoDxnhrm
         q9BO8DgdbjLbNQQWvaqsq9t3eWq2+jTzF8iIyiKkJuqrwBN6AZGIz3Bmv+wKqtSl2ZRu
         aCnB69ipzQFlPS4C3n4faQ77/wBg1KY2E54JuNsK4HKsJklfTlMm7rZRex/mK5lskGat
         ZrxNJjrBHhzIZn5JSoLTIKyjS7zPQISCFsVAYmXakcQ8r0i+kj0/tNwA8Sk6nWiOewO4
         ZH+k9OWDzLeV8tHPvdbs4c9jfb99royDL+iINnuNXLkZAVM3lWSZM/Do60HYlQQ3R86o
         JuYQ==
X-Gm-Message-State: AOJu0Yy2FaGC1RJOPxaNMYZfb+1+BlfeUy5HIA+vX59bLgnsbuBEKVVC
	B/Jnj3QkYJkOFtnEU71yQtmw53WQH6A63aoGSiQS3kuKKfe9earFpK4h
X-Gm-Gg: AeBDietUVopwuO/Jq5cOCKzRStY1Ud+U+nLmA1uknra2vGOhPPsDUDAr2+N+oA9AI1v
	N+029JSb016HVOu7/jd/AqVo7+n1mlzzQXAFOY7AAA0ohwsvloDNc7XSNEWwiVMhAFt9bC9N8NS
	grijssZXZqR3V7zhn6+K7sJriA2uOvL9Gl3bSU2salw3SfkYYrLCQwB7mmcAXsIiVYVW+o6P+Og
	R4Kwr2xb8T5fVli+PMOgTg9bQm3LxdSKbe+vw05f60qHgcd+PENI3GUAJJ01C/OBNSC/X8w4Tgp
	6wPqVdON1HlPM90SPYyFevGxsWC7ynEBPG7kr/9YfneaZLlVIQDlSd+MjW+kmOq1kCN7LaPruKF
	qu2edAbfYHPn9h4fuQ8z9WerQ55wXal3s2Xxj8brIaJlW+rkqoiSEsy96BC88zgquOHfXKVWRtC
	4Y+sjWVaGaR0V6kvrrQ4HF23pl
X-Received: by 2002:a05:6102:26ce:b0:62f:549d:ad1b with SMTP id ada2fe7eead31-630f8e9ad0amr1517196137.7.1778077641782;
        Wed, 06 May 2026 07:27:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d833sm204428156d6.10.2026.05.06.07.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/12] bpf: Remove redundant dynptr arg check for helper
Date: Wed,  6 May 2026 07:27:02 -0700
Message-ID: <20260506142709.2298255-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7BB44DC344
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284879-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
cannot be released. process_dynptr_func() also prevents passing
uninitialized dynptr to helpers expecting initialized dynptr. Now that
unmark_stack_slots_dynptr() also error returned from
release_reference(), there should be no reason to keep these redundant
checks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 21 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +++---
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  4 ++--
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7eeb3d8fc817..792e61e07b06 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8015,26 +8015,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = bpf_func(env, reg);
-			int spi;
-
-			/* Only dynptr created on stack can be released, thus
-			 * the get_spi and stack state checks for spilled_ptr
-			 * should only be done before process_dynptr_func for
-			 * PTR_TO_STACK.
-			 */
-			if (reg->type == PTR_TO_STACK) {
-				spi = dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
-					verbose(env, "arg %d is an unacquired reference\n", regno);
-					return -EINVAL;
-				}
-			} else {
-				verbose(env, "cannot release unowned const bpf_dynptr\n");
-				return -EINVAL;
-			}
-		} else if (!reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b141cf75cc6a..60324d68b349 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 54de0389f878..c0d0422b8030 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
-- 
2.52.0


