Return-Path: <netdev+bounces-252724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD3LGZo9c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:21:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B374732B4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D8830080AB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786D32B9A6;
	Fri, 23 Jan 2026 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlm/mnyR"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6E3164D3
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160084; cv=none; b=WtHyYVuh8vDrUD7s8KmwRNWOi2A3Ygsy/jFbYFZDtRtKENvyt2vym49qMUcK2MNgOt7SkQS465JBm4kR6c/ILxg3c45RV40TNXSG/oJKC1M6eSyQWXkQ2ffw8mD2QabmoXD3ZFoG75xcRN3FLoiX6TwCFnkEIFWaOTHFmJaEKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160084; c=relaxed/simple;
	bh=/qBBaxWhukWs4qJg+J65MwAsyajsVQ45yyS5jCwBNIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzkWWHzG9xErgAstfgpK3rFf2ba6vKIlYtYs33C3ItBEzS5KMYl0I6Z5xD7pwjEvI7DgdjqckvF1JQmxogONDYCncT6PIsECIjIddjoEkAvMn9yQAi7bKluuiiqdwxVuuy2VFCcFoWYDfqDofSxpNHQ2ixyn3uR4Bl9uXZx7PNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlm/mnyR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769160079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie5xJzmkxgG8lABACs468KKiagQngHba9qY5Hp3s314=;
	b=jlm/mnyRCmcsgiGagpUpgQ4MBZmziSqt6uQfpWP8SmNqjWD3De58XH7O8A/zaaOci5pEQE
	25DRGUR5DWUqw/xMMK+bynuy92kLBQ5l9cIXRrqHVS6X2B0+wRBMUgVIV0CSUekzYcDAx9
	635MTGLq1jYF/120nlROHPmByeg7C2c=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the
 nr_args in trampoline
Date: Fri, 23 Jan 2026 17:21:06 +0800
Message-ID: <8632406.T7Z3S40VBb@7940hx>
In-Reply-To: <2250332.irdbgypaU6@7940hx>
References:
 <20260123073532.238985-3-dongml2@chinatelecom.cn>
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
 <2250332.irdbgypaU6@7940hx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252724-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B374732B4
X-Rspamd-Action: no action

On 2026/1/23 16:29 Menglong Dong <menglong.dong@linux.dev> write:
> On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 41bbed6418b5..b3f912ad18ba 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > 
> > [ ... ]
> > 
> > > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >  			    eatype == BPF_MODIFY_RETURN) {
> > >  				/* Load nr_args from ctx - 8 */
> > >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > -				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > > +				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > 
> > [ ... ]
> > 
> > > -				cnt = 6;
> > > +				cnt = 7;
> > >  			} else {
> > >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
> > >  				cnt = 1;
> > >  			}
> > >
> > >  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > 
> > [ ... ]
> > 
> > > 			delta    += cnt - 1;
> > 
> > Note that the bpf_get_func_ret block above correctly updates delta after
> > patching.
> > 
> > > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >
> > >  				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
> > >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
> > > +				cnt = 1;
> > >  			} else {
> > >  				/* Load nr_args from ctx - 8 */
> > >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > > +				cnt = 2;
> > >  			}
> > >
> > > -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> > > +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > >  			if (!new_prog)
> > >  				return -ENOMEM;
> > >
> > >  			env->prog = prog = new_prog;
> > >  			insn      = new_prog->insnsi + i + delta;
> > >  			goto next_insn;
> > >  		}
> > 
> > Should there be a "delta += cnt - 1;" before assigning env->prog in this
> > bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the program
> > grows by one instruction, but delta is not updated. This could cause
> > subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> > 
> > The bpf_get_func_arg block at the beginning of this patch has:
> > 
> >     delta    += cnt - 1;
> >     env->prog = prog = new_prog;
> > 
> > And the bpf_get_func_ret block similarly has delta updated. But this
> > bpf_get_func_arg_cnt block goes directly to env->prog assignment without
> > updating delta.
> 
> Ah, good point, I think this is a valid problem. The selftests didn't cover
> this case, and I think I'd better to use bpf_get_func_arg() and bpf_get_func_ret()
> in the exit path of fsession to cover it.

Oh, the problem doesn't have much impact. The only impact
is that the verifier will check the "r0 &= 0xFF" instruction redundantly.

I'll see if there is more comment before I send next version.

Thanks!
Menglong Dong

> 
> Will fix it in the next version.
> 
> Thanks!
> Menglong Dong
> 
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> > 
> 
> 
> 
> 
> 
> 





