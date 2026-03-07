Return-Path: <netdev+bounces-265096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHqhKwbKq2nggwEAu9opvQ
	(envelope-from <netdev+bounces-265096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:47:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAB22A732
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A93DF3055448
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6037AA8D;
	Sat,  7 Mar 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abd1hSoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F23793AD
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865886; cv=none; b=nKjsg3aJtoSAOn0K3mH9JuskkVW4fzYBwNjWGl+Usc68+6lZyPBCq4aim9Tizpj3PCtlPrWTKsoNq3hYgzDg4XY1ox5PFgDK0hm/aAyn59D17mB71fPN1DAj1rRtPNTo/OvHvYCG23UATB4dkcpx6rEJHR6vr24B3j+Iq1tVA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865886; c=relaxed/simple;
	bh=24Rp4W/jPdWtc1camvuiV4VBUwdYMUtcAtN4Dkl0gNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwpDj1ZoZC+9goAfYCSgUq5ljoSmY+QVvVmOObMig9f41bJDc8NJz4P3VEsZc8BCYruEp40qw+xVqxNqA8T1bt5AekpBvGnjDhp5L9B2PAwozdDAajt6v7tpQiA7je/XiqOFQAIY7yWmGVgDtyBluX9fS4pSeICJpHg0y0vM3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abd1hSoq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598df39444so4027354a91.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865884; x=1773470684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFAMMEwYySoxyVlmBbqN4trFShpF/9uolHKdyzjp7ro=;
        b=abd1hSoqG6aEw2aMajyQc8wcQUF3PP3h+m/VCkF4ZQRZPKKHsrMjvTm1wOpqNb9tQT
         t9EIeeMVKJ8+pgDMUrkIzb2xxosbg5ukgV5+He4ydrWeCw2Zm9XJLnD7OIQiaEQmpsIu
         9Y4PGcGDFaQMCcJCiV2q8oVw5jHqREhFHJ5YkK6lnjiEgtIKg0LUZlZR/CdObuXJ+iP3
         795tWlTngqo9KBnOeJx+3QsqltmBvM8UCgzhOqaA7lz6/uE9eM9WcTMbG0QkBFLKiQ0G
         TDdJXL/CJrrvqlAXUkhrEMAFf1yb67Ei1SoiuXW02vQ6CL6Ub9J8pq8lxr7AJTOujdIq
         qw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865884; x=1773470684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFAMMEwYySoxyVlmBbqN4trFShpF/9uolHKdyzjp7ro=;
        b=PP69DJqRoLf8w+rMqS6LLfre5IrutuIygfFY8TbX5qqAD91dRSSsTnCfrFn52Tdh50
         +GvSpNYEvP1ha2RNsRkPTc1z+4zXZX8qa+cIWckI1lV+652jk4l6UQmkHmoP1WIIGQps
         ZyjWt36emOF6fgjDmRlepi926dnrBOBAd+lUe0Raz+BMmZ+aPiGLGC9Xhz+EfJ9GK73k
         kpMXsVPyFjbNrrFIKlyL4sQhr0idOtrySILsAWojYBqA24mJlQsJGul5okfl2Ubv1bx9
         AZa4uQvllrRR7YuHytWow6kIdwc4U/VwU2N6Bhw288LWGtSMnat/58nHZa/RZKSaJTK+
         kwXw==
X-Gm-Message-State: AOJu0YzCkqEma7u5O9W+DHOO9mJ8yLNnNU/z5LSfzvziglwdKC9iVWfJ
	oQzm1ElWyfHOvEjOyhZ1H28Mo0jh5opfWVhWpAeEUf6X8oZiF5pbrz52
X-Gm-Gg: ATEYQzxs/ZW87kXzEOzx3jgiXONjNMS6Kgx/Z1Nnvp6ilyJCFEMmulRypjaJI1k7prz
	gNihSnCkulRoTLv4b5PXcAOwfsAVoOAV++/r9Gu0NxY+1npLPykVNGrTt2bGKnu0M6/SOBOFCgf
	pwOUtLtgeRSkYPxaeAOoO4Rc60xYIxz//xDQOHH9P4PhSsyxVOoKf12yYJ0Gq/n9jePcXgNUugl
	g/S/UPGliA/xOeOOhIXBYcGrPjNkQ9MPkvXcrYa6seArW29ijmHNepxNy6J+CxVX7Vx5O97UhgK
	AwUbebG5902UksTcbQWO7tR7QnIWDty2xlySVSBt+RHUiVeDqYArjfVzj9Y4OcFFEAL1A7CdH4Q
	VuSaGRjgvYLHAHh0EhF48r6ldjYHhZ3tJJn0T29ex7aRpDGxep30Lu/wD+WyFH3tNGqE5KABEf7
	L/YK6JELKt6urL
X-Received: by 2002:a17:90b:4d88:b0:359:c7ef:97c0 with SMTP id 98e67ed59e1d1-359c7ef9a15mr1891332a91.19.1772865884425;
        Fri, 06 Mar 2026 22:44:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2dffbf2sm7279899a91.13.2026.03.06.22.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:44 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
Date: Fri,  6 Mar 2026 22:44:31 -0800
Message-ID: <20260307064439.3247440-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 97CAB22A732
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265096-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplify dynptr checking for helper and kfunc by unifying it. Remember
initialized dynptr in process_dynptr_func() so that we can easily
retrieve the information for verification later.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 179 +++++++++---------------------------------
 1 file changed, 36 insertions(+), 143 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f77c4c5b510..d52780962adb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -277,8 +277,15 @@ struct bpf_map_desc {
 	int uid;
 };
 
+struct bpf_dynptr_desc {
+	enum bpf_dynptr_type type;
+	u32 id;
+	u32 ref_obj_id;
+};
+
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc initialized_dynptr;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
-	int dynptr_id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_rbtree_root;
-	struct {
-		enum bpf_dynptr_type type;
-		u32 id;
-		u32 ref_obj_id;
-	} initialized_dynptr;
 	struct {
 		u8 spi;
 		u8 frameno;
 	} iter;
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc initialized_dynptr;
 	u64 mem_size;
 };
 
@@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
 
-static bool is_dynptr_ref_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_dynptr_data;
-}
-
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
@@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 		ref_obj_uses++;
 	if (is_acquire_function(func_id, map))
 		ref_obj_uses++;
-	if (is_dynptr_ref_function(func_id))
-		ref_obj_uses++;
 
 	return ref_obj_uses > 1;
 }
@@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
-			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
+			       enum bpf_arg_type arg_type, int clone_ref_obj_id,
+			       struct bpf_dynptr_desc *initialized_dynptr)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
@@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		}
 
 		err = mark_dynptr_read(env, reg);
+
+		if (initialized_dynptr) {
+			struct bpf_func_state *state = func(env, reg);
+			int spi;
+
+			if (reg->type != CONST_PTR_TO_DYNPTR) {
+				spi = dynptr_get_spi(env, reg);
+				reg = &state->stack[spi].spilled_ptr;
+			}
+
+			initialized_dynptr->id = reg->id;
+			initialized_dynptr->type = reg->dynptr.type;
+			initialized_dynptr->ref_obj_id = reg->ref_obj_id;
+		}
 	}
 	return err;
 }
@@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
-static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env *env,
-						const struct bpf_func_proto *fn,
-						struct bpf_reg_state *regs)
-{
-	struct bpf_reg_state *state = NULL;
-	int i;
-
-	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
-		if (arg_type_is_dynptr(fn->arg_type[i])) {
-			if (state) {
-				verbose(env, "verifier internal error: multiple dynptr args\n");
-				return NULL;
-			}
-			state = &regs[BPF_REG_1 + i];
-		}
-
-	if (!state)
-		verbose(env, "verifier internal error: no dynptr arg found\n");
-
-	return state;
-}
-
-static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.id;
-}
-
-static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->ref_obj_id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.ref_obj_id;
-}
-
-static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
-					    struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->dynptr.type;
-
-	spi = __get_spi(reg->var_off.value);
-	if (spi < 0) {
-		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
-		return BPF_DYNPTR_TYPE_INVALID;
-	}
-
-	return state->stack[spi].spilled_ptr.dynptr.type;
-}
-
 static int check_reg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
@@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0,
+					  &meta->initialized_dynptr);
 		if (err)
 			return err;
 		break;
@@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 		}
 		break;
-	case BPF_FUNC_dynptr_data:
-	{
-		struct bpf_reg_state *reg;
-		int id, ref_obj_id;
-
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
-
-
-		if (meta.dynptr_id) {
-			verifier_bug(env, "meta.dynptr_id already set");
-			return -EFAULT;
-		}
-		if (meta.ref_obj_id) {
-			verifier_bug(env, "meta.ref_obj_id already set");
-			return -EFAULT;
-		}
-
-		id = dynptr_id(env, reg);
-		if (id < 0) {
-			verifier_bug(env, "failed to obtain dynptr id");
-			return id;
-		}
-
-		ref_obj_id = dynptr_ref_obj_id(env, reg);
-		if (ref_obj_id < 0) {
-			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
-			return ref_obj_id;
-		}
-
-		meta.dynptr_id = id;
-		meta.ref_obj_id = ref_obj_id;
-
-		break;
-	}
 	case BPF_FUNC_dynptr_write:
 	{
-		enum bpf_dynptr_type dynptr_type;
-		struct bpf_reg_state *reg;
-
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
+		enum bpf_dynptr_type dynptr_type = meta.initialized_dynptr.type;
 
-		dynptr_type = dynptr_get_type(env, reg);
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
@@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (is_dynptr_ref_function(func_id))
-		regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
-
-	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
+	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
@@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
+	if (func_id == BPF_FUNC_dynptr_data) {
+		regs[BPF_REG_0].dynptr_id = meta.initialized_dynptr.id;
+		regs[BPF_REG_0].ref_obj_id = meta.initialized_dynptr.ref_obj_id;
+	}
+
 	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
 	if (err)
 		return err;
@@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 
-			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id,
+						  &meta->initialized_dynptr);
 			if (ret < 0)
 				return ret;
-
-			if (!(dynptr_arg_type & MEM_UNINIT)) {
-				int id = dynptr_id(env, reg);
-
-				if (id < 0) {
-					verifier_bug(env, "failed to obtain dynptr id");
-					return id;
-				}
-				meta->initialized_dynptr.id = id;
-				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
-				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
-			}
-
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
-- 
2.47.3


