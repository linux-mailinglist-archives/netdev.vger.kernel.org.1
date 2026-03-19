Return-Path: <netdev+bounces-269506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP3pIu0ZvGlEsQIAu9opvQ
	(envelope-from <netdev+bounces-269506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:44:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574D2CDE59
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 096883025134
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940023D9DD2;
	Thu, 19 Mar 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmmEbdoT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1828AAEB;
	Thu, 19 Mar 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934836; cv=none; b=QkjPyg1RV94ijlajfG/+xZtFStfJelwPpvuHYyw4znotLvn6yWglvM2PcmOWKIg6UZdb4AIYuluabFpZqneTk++v+pTAGX9Jeak+zcxeWekS1YqM7fYxzSeYvSMdcmK8CtfN2xiJT+JOcWDWGwwU4foNg45CdwQhxoFTcuInXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934836; c=relaxed/simple;
	bh=44kks2Hupy2PXIuwsM7N+ABSrDUKzV+bhx8Hz1JtAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU7ZjRLkaqaulnwAk1fdCa9+qJqGExPWHkYMcLHBFYPTm6GGZ61d3y0NF1ZtHQ2SxL5j9QiPUh77AkyfE02YCtjD6ZoUe82BC3FU4rj57ZcfmVA898v/5QXEdmi2mmIcEVYo3BL5kH8B/t/f3Wao5rB4bf+FEm4yXAQEq0imr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmmEbdoT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773934836; x=1805470836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44kks2Hupy2PXIuwsM7N+ABSrDUKzV+bhx8Hz1JtAcg=;
  b=PmmEbdoT5QjQtzmluPiQOUFEX0ZJA20q0jMDkEMr/qOXcm2nDR6cZ3Eq
   bw9qxvBzz7LQlPq5v0vw40GkREvc3g8xakcYRewzbP0QtsCAuzl0GQ6Co
   OfonIMyPkQxeEO5GZ2Gn1ojiJV14FFEn6XY7FqnGUtYMuy1rPANc5nFI9
   eHvx3L75hiwwf11Ov9Zjl63PRfHQBneFSH9zQKgTEWJUV/9XyLM0BIYNU
   6p6wWJ4bDAubtwsmxtLc2L16UB/ztTgcco6Y/60t/JtQ1Q/v+gzFfeTMe
   qEF79A0XJ4QlHoXVr2cNec2c6dpqbg+9AwS2LKwGAYR5eLXOaEJkWFsZb
   w==;
X-CSE-ConnectionGUID: 9zmYui9rT8CWL/HgchW6cQ==
X-CSE-MsgGUID: 9LpbgJtVRqGOWJBYkL61ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86487835"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86487835"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:40:35 -0700
X-CSE-ConnectionGUID: pYOl3fqVQ2GdrrcJSjCHNQ==
X-CSE-MsgGUID: mDSDeamBTyujJb/XeseE/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227694493"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:40:33 -0700
Date: Thu, 19 Mar 2026 08:40:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v7 02/10] x86/bhi: Make clear_bhb_loop() effective on newer
 CPUs
Message-ID: <20260319-vmscape-bhb-v7-2-b76a777a98af@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:dkim,intel.com:email,linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9574D2CDE59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a mitigation for BHI, clear_bhb_loop() executes branches that overwrites
the Branch History Buffer (BHB). On Alder Lake and newer parts this
sequence is not sufficient because it doesn't clear enough entries. This
was not an issue because these CPUs have a hardware control (BHI_DIS_S)
that mitigates BHI in kernel.

BHI variant of VMSCAPE requires isolating branch history between guests and
userspace. Note that there is no equivalent hardware control for userspace.
To effectively isolate branch history on newer CPUs, clear_bhb_loop()
should execute sufficient number of branches to clear a larger BHB.

Dynamically set the loop count of clear_bhb_loop() such that it is
effective on newer CPUs too. Use the hardware control enumeration
X86_FEATURE_BHI_CTRL to select the appropriate loop count.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
 arch/x86/net/bpf_jit_comp.c |  7 -------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..8128e00ca73f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
 SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
+	/* BPF caller may require %rax to be preserved */
+	push	%rax
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	/*
+	 * Between the long and short version of BHB clear sequence, just the
+	 * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
+	 */
+	ALTERNATIVE "movb $5,  %al",	\
+		    "movb $12, %al", X86_FEATURE_BHI_CTRL
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1556,16 +1565,18 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
-	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+	.skip 32 - 14, 0xcc
+2:	ALTERNATIVE "movb $5, %ah",	\
+		    "movb $7, %ah", X86_FEATURE_BHI_CTRL
 3:	jmp	4f
 	nop
-4:	sub	$1, %eax
+4:	sub	$1, %ah
 	jnz	3b
-	sub	$1, %ecx
+	sub	$1, %al
 	jnz	1b
 .Lret2:	RET
 5:
+	pop	%rax
 	pop	%rbp
 	RET
 SYM_FUNC_END(clear_bhb_loop)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 63d6c9fa5e80..e2cceabb23e8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1614,11 +1614,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	u8 *func;
 
 	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
-		/* The clearing sequence clobbers eax and ecx. */
-		EMIT1(0x50); /* push rax */
-		EMIT1(0x51); /* push rcx */
-		ip += 2;
-
 		func = (u8 *)clear_bhb_loop;
 		ip += x86_call_depth_emit_accounting(&prog, func, ip);
 
@@ -1626,8 +1621,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 			return -EINVAL;
 		/* Don't speculate past this until BHB is cleared */
 		EMIT_LFENCE();
-		EMIT1(0x59); /* pop rcx */
-		EMIT1(0x58); /* pop rax */
 	}
 	/* Insert IBHF instruction */
 	if ((cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP) &&

-- 
2.34.1



