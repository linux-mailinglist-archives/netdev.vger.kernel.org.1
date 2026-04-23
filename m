Return-Path: <netdev+bounces-280610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLn9BJi56WlJigIAu9opvQ
	(envelope-from <netdev+bounces-280610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762844D7E8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F93307921D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718A2D0602;
	Thu, 23 Apr 2026 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCi0kiwE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5012C11EE;
	Thu, 23 Apr 2026 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924924; cv=none; b=c1rMdzJruLykM3e0pbSIAlVCszd9QHJu78jEZYUAfhhXQG7ZJa++kHjYFm7FVC+dVdbfv9w83CTI7H7gK3Dwm0bp0VLZWWTseDFw/T1VT1zBBy8ltUWKLYgYPqpQ+pHqDd54y1VpcQAve7jorDcLCyUi699xCTDXq+SECfaCqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924924; c=relaxed/simple;
	bh=HoDN0XYx5hRbRHIiPcm/8zQ8DC0db38UWRcLtxFcyPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtyEC2vUq+gXlA1d2IuLkpBad3Ev9Mbcko4VV3KOy+KtUZejJ+dyXC97zf7nJvLghDQg00SLTah2sCgKs8v5lowHomEhELd2KobrA4Nfiun2ogwu63HXv2lyog6oVTLPKtca14Abe4bXc1KLh7MgonefS/pHSEeejgJ3ik8UVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCi0kiwE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924918; x=1808460918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HoDN0XYx5hRbRHIiPcm/8zQ8DC0db38UWRcLtxFcyPE=;
  b=fCi0kiwEjQBbu6SYVCc6X/0DeIkxetci3RIRcU6pANXhGK6xQP3ynn2L
   KrVqwX+Gw+cUffQZI5TYuS2NXkdkeqMUooUayHdM+UKkFhJaJXb6maLM4
   T6HBm4Su2MPW0vT/t46I15TY7c3KUg3nonocMUhqDEaeC491Z2cAyqcBw
   mx+jmjUSFrzzoDpiU7vPvp6WRJXExaFGmk/fzQy/XqBwJuCl3qKWJ7gGb
   JkT3rlXfZHFlUWFTj0AAFUqUFaiMgqC652ZBpB4RKEZGjKtUwR0SFHndv
   EaLvpTsWAEWcd9ihdruGFc2Fe3daomgVFFCswIhf6NZyujiDylo68nwug
   w==;
X-CSE-ConnectionGUID: O6xH4ksYSxmX13Rnuqv/Dw==
X-CSE-MsgGUID: DPscJwM1QTKYD9lo/WPwxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80473230"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="80473230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:15:17 -0700
X-CSE-ConnectionGUID: 5AIWqlXvS+SDVYuUFypdmA==
X-CSE-MsgGUID: MjoodSf/RCGKGPNN1H/snw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237550689"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:15:16 -0700
Date: Wed, 22 Apr 2026 23:15:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v11 02/12] x86/bhi: Make clear_bhb_loop() effective on newer
 CPUs
Message-ID: <20260422-vmscape-bhb-v11-2-b18e0cf32af4@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4762844D7E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
the Branch History Buffer (BHB). On Alder Lake and newer parts this
sequence is not sufficient because it doesn't clear enough entries. This
was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
in the kernel.

Now with VMSCAPE (BHI variant) it is also required to isolate branch
history between guests and userspace. Since BHI_DIS_S only protects the
kernel, the newer CPUs also use IBPB.

A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
But it currently does not clear enough BHB entries to be effective on newer
CPUs with larger BHB. At boot, dynamically set the loop count of
clear_bhb_loop() such that it is effective on newer CPUs too.

Introduce global loop counts, initializing them with appropriate value
based on the hardware feature X86_FEATURE_BHI_CTRL.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            |  8 +++++---
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..bbd4b1c7ec04 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	movzbl    bhb_seq_outer_loop(%rip), %ecx
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
-	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+	.skip 32 - 20, 0xcc
+2:	movzbl  bhb_seq_inner_loop(%rip), %eax
 3:	jmp	4f
 	nop
 4:	sub	$1, %eax
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 70b377fcbc1c..87b83ae7c97f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
 extern void update_spec_ctrl_cond(u64 val);
 extern u64 spec_ctrl_current(void);
 
+extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..2cb4a96247d8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2047,6 +2047,10 @@ enum bhi_mitigations {
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
+/* Default to short BHB sequence values */
+u8 bhb_seq_outer_loop __ro_after_init = 5;
+u8 bhb_seq_inner_loop __ro_after_init = 5;
+
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
 	if (!str)
@@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	/*
+	 * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
+	 * support), see Intel's BHI guidance.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
+		bhb_seq_outer_loop = 12;
+		bhb_seq_inner_loop = 7;
+	}
+
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	cpu_print_attack_vectors();

-- 
2.34.1



