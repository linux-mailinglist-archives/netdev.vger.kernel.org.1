Return-Path: <netdev+bounces-274786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JHnG8cKz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784638F7E4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B010304EA4B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50286222599;
	Fri,  3 Apr 2026 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQhyQCyd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004920B810;
	Fri,  3 Apr 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176283; cv=none; b=NaqvGvWqtQJMLsJ+Rd2vJ434h9BKxtgBGlmGoKysKiyq03CjX7sFkiV9FGRHIU45Ig1arh6d5fC1hX7MJtJVTfh86DyyWeiLmVnDLZjtqB+hyXd8cGJucJg0O5+HTZZxgNrfvEy/7trp0IVB/HS1GA2V2OxFS+Z7MxoYrFy8bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176283; c=relaxed/simple;
	bh=Dc8CmE7nMp3oc4TVyDoXVNiGITwPjHDIoAHr8yLepJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKS4c+byBEbPCS5CGYihCMw+M6cNBA8S/j54oAlBnOQ9U1DCj9u0FBfL40xVeXMixBrmQ+oP/jItW1bgE6M4n0F0JrF4BT26O9b0lYvuDM1lwiypFzBcjzEwIatDelx5V1VuYn2e8F+snoylihMJOERJRIby9RqoioOQpTK01tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQhyQCyd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775176282; x=1806712282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dc8CmE7nMp3oc4TVyDoXVNiGITwPjHDIoAHr8yLepJY=;
  b=cQhyQCyd0JuhT/jsBORffKOTjd6iymVEgs/euxL8FapIWvKZkME01m6B
   Mjwc2asBbVWWaJeX6SfcjdKkqEMAM+NxQ+B6EhD/sgiudwnZaRsdlpDLm
   Hjv8Yl0VCoGWvP6P0XniV6Hx4b08IB5yi5vr0ArQMLeyyA+TE0lJdIuc3
   TwWqVFRuS6B32AXu/4Rr5pusB60aYAsGqF3ZaeB1Xe92SJdegv3FAwjiB
   E0yIr7HL+cODxoCFpZaYyCq8X0V3IlWGnYin62jHrwKBwm78YiuWwU0kR
   nNFsVdWOEqt0CTA4LVSn1CJ7GM10aVE7/tCl5EYx/h5Rgx9p1aOsszfg1
   w==;
X-CSE-ConnectionGUID: WhnIr8LBRHqAVMCYTussMA==
X-CSE-MsgGUID: Wz0YJOp7QzGaIjKgnf60WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76128732"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76128732"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:22 -0700
X-CSE-ConnectionGUID: PcWkzCncRMy8bSVLy2PQpA==
X-CSE-MsgGUID: 8LrTP5mCQ1u9dmp7UUTUBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="227059719"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:21 -0700
Date: Thu, 2 Apr 2026 17:31:21 -0700
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
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v9 03/10] x86/bhi: Rename clear_bhb_loop() to
 clear_bhb_loop_nofence()
Message-ID: <20260402-vmscape-bhb-v9-3-94d16bc29774@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,suse.com:email,linux.intel.com:mid,alien8.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nutanix.com:email]
X-Rspamd-Queue-Id: 0784638F7E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To reflect the recent change that moved LFENCE to the caller side.

Suggested-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            | 8 ++++----
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 arch/x86/net/bpf_jit_comp.c          | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index bbd4b1c7ec04..1f56d086d312 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1532,7 +1532,7 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * Note, callers should use a speculation barrier like LFENCE immediately after
  * a call to this function to ensure BHB is cleared before indirect branches.
  */
-SYM_FUNC_START(clear_bhb_loop)
+SYM_FUNC_START(clear_bhb_loop_nofence)
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
@@ -1570,6 +1570,6 @@ SYM_FUNC_START(clear_bhb_loop)
 5:
 	pop	%rbp
 	RET
-SYM_FUNC_END(clear_bhb_loop)
-EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop)
-STACK_FRAME_NON_STANDARD(clear_bhb_loop)
+SYM_FUNC_END(clear_bhb_loop_nofence)
+EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop_nofence)
+STACK_FRAME_NON_STANDARD(clear_bhb_loop_nofence)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 87b83ae7c97f..157eb69c7f0f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -331,11 +331,11 @@
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
-	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_LOOP
+	ALTERNATIVE "", "call clear_bhb_loop_nofence; lfence", X86_FEATURE_CLEAR_BHB_LOOP
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop_nofence; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
@@ -389,7 +389,7 @@ extern void entry_untrain_ret(void);
 extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
-extern void clear_bhb_loop(void);
+extern void clear_bhb_loop_nofence(void);
 #endif
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 63d6c9fa5e80..f40e88f87273 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1619,7 +1619,7 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 		EMIT1(0x51); /* push rcx */
 		ip += 2;
 
-		func = (u8 *)clear_bhb_loop;
+		func = (u8 *)clear_bhb_loop_nofence;
 		ip += x86_call_depth_emit_accounting(&prog, func, ip);
 
 		if (emit_call(&prog, func, ip))

-- 
2.34.1



