Return-Path: <netdev+bounces-301422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oyMCOU/DOmqvGAgAu9opvQ
	(envelope-from <netdev+bounces-301422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796316B914B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YB6SiHm5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301422-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 185CB3046412
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352CF38B7DD;
	Tue, 23 Jun 2026 17:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358338B7DC;
	Tue, 23 Jun 2026 17:32:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235975; cv=none; b=fVROdJNbI9ZyUQ48wsbzsx9ab9QnipCPVLke0igXkeuV3zSsYLOc9j/ebSqLAIVmUyg5VAhEzMnPFs+VvS7S6fcPLIDlF1mv1ze2gX6jpWmgmRJdNuOgecHhqU4rofszjNs/dhacVHXvaZWOzt9VpbY3DrMBD8mR04O9kSXFOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235975; c=relaxed/simple;
	bh=6DVBrnCq5bmt+ll0ZWJey6dNV/vHdCzXNW0bHcIz61o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3Z3avbCMnUhr6VB0fe/gmFclv4MD8hSWwjFpw2cH8/1DYEzOOwaSFgDefP9QLQqkgwrCgMPVB7rGSXMTha6sdKERwZuUrx56WSUh+lphUHTwyTBqxFDGzfLKO9Z9QAElls1Lov2+FFA4qZC+V/q0t1volBXY06s4ooCQi/RuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YB6SiHm5; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782235973; x=1813771973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6DVBrnCq5bmt+ll0ZWJey6dNV/vHdCzXNW0bHcIz61o=;
  b=YB6SiHm5scIuXyIrOG7oDLgBz9jNWn/0hRPhYxkAQUSp3Qitu9Hye+4V
   ikLrp81OyC62DCVb7WeTwuNv905YwOfL6D0IhS4NyMViPfSjPV90V0xy0
   h9Ms5kBzzC/JglMOVH7V8VTNaAD9gfEWs/aLy0SjmY0ZfH5FznLUaug6Y
   SAwwIb0GxR3mXosU2crumT5W3wpk6IcmaRntrgt79kv1xIgYa8RLIyrcz
   u0KhJpPkexfrlvZvofLswpMolvYvHdbl57yDdSSQ6/Hbsy+MGlyZwauJJ
   AGphHH75idzVTl46aY48NU5jaBaJiCnkXhzyQbqB9Q1HWt5eHgdTYCRrr
   w==;
X-CSE-ConnectionGUID: cH6IhuWKT4+x/kM+gS0WEw==
X-CSE-MsgGUID: +csoSylsSry3jXwYWJQUHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100414772"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100414772"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:32:52 -0700
X-CSE-ConnectionGUID: 9oXY0NbYT6iPJFD0nsnnAA==
X-CSE-MsgGUID: U20VLWv6Szal0E2YC7K6rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248700399"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:32:53 -0700
Date: Tue, 23 Jun 2026 10:32:52 -0700
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
Subject: [PATCH v12 01/12] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260622-vmscape-bhb-v12-1-76cbda0ae3e5@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301422-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:
 lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,alien8.de:email,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 796316B914B

Currently, the BHB clearing sequence is followed by an LFENCE to prevent
transient execution of subsequent indirect branches prematurely. However,
the LFENCE barrier could be unnecessary in certain cases. For example, when
the kernel is using the BHI_DIS_S mitigation, and BHB clearing is only
needed for userspace. In such cases, the LFENCE is redundant because ring
transitions would provide the necessary serialization.

Below is a quick recap of BHI mitigation options:

On Alder Lake and newer

    BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
    performance overhead.

    Long loop: Alternatively, a longer version of the BHB clearing sequence
    can be used to mitigate BHI. It can also be used to mitigate the BHI
    variant of VMSCAPE. This is not yet implemented in Linux.

On older CPUs

    Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
    effective on older CPUs as well, but should be avoided because of
    unnecessary overhead.

On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
branch history may still influence indirect branches in userspace. This
also means the big hammer IBPB could be replaced with a cheaper option that
clears the BHB at exit-to-userspace after a VMexit.

In preparation for adding the support for the BHB sequence (without LFENCE)
on newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
executed. Allow callers to decide whether they need the LFENCE or not. This
adds a few extra bytes to the call sites, but it obviates the need for
multiple variants of clear_bhb_loop().

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            | 5 ++++-
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 arch/x86/net/bpf_jit_comp.c          | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 42447b1e1dff..3a180a36ca0e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1528,6 +1528,9 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * refactored in the future if needed. The .skips are for safety, to ensure
  * that all RETs are in the second half of a cacheline to mitigate Indirect
  * Target Selection, rather than taking the slowpath via its_return_thunk.
+ *
+ * Note, callers should use a speculation barrier like LFENCE immediately after
+ * a call to this function to ensure BHB is cleared before indirect branches.
  */
 SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
@@ -1562,7 +1565,7 @@ SYM_FUNC_START(clear_bhb_loop)
 	sub	$1, %ecx
 	jnz	1b
 .Lret2:	RET
-5:	lfence
+5:
 	pop	%rbp
 	RET
 SYM_FUNC_END(clear_bhb_loop)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4f4b5e8a1574..70b377fcbc1c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -331,11 +331,11 @@
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
+	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_LOOP
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..f58ff2891d7d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1624,6 +1624,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 
 		if (emit_call(&prog, func, ip))
 			return -EINVAL;
+		/* Don't speculate past this until BHB is cleared */
+		EMIT_LFENCE();
 		EMIT1(0x59); /* pop rcx */
 		EMIT1(0x58); /* pop rax */
 	}

-- 
2.34.1



