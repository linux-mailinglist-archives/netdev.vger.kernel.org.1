Return-Path: <netdev+bounces-301432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bld2CH3FOmq6GQgAu9opvQ
	(envelope-from <netdev+bounces-301432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB36B929A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gNHRSJxU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301432-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22B13317E144
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136138D01E;
	Tue, 23 Jun 2026 17:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AA38CFE1;
	Tue, 23 Jun 2026 17:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236138; cv=none; b=LMZk4OpSNq57es+jpcQ9zLy3INR8W6pacPkmJAb7LO/26COYZ/gKvNiL6of/x23fthXH6VHs6iMVuQNY0EkIR5zUTkuHwDpC41mYDEOh9A8d+UAhn6vTUnl29zMACEwDil4XOrIaAwj1AcGxQVm2blqpZcSwhuVFBgAf98BPlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236138; c=relaxed/simple;
	bh=6gK4EmiJjoxMBErZvB2QlG52OKl4TSLVAd68WmRFl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MviVngm70s9Eck3TW6IVrcoZTtrpzk36WYTbgVmyHwHFILN/a/K7QUbV8IPhw1YQn03gLf6fKTiJ6KqE4DpF0MJHpk/8ZgYhxLd8IDQnm1GQS+EWk4RKcRxO8+27grc+IMPsGWYYF7WHgUKh0qMHaGy9BvaQ0QplN4D+PgJPYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNHRSJxU; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236137; x=1813772137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gK4EmiJjoxMBErZvB2QlG52OKl4TSLVAd68WmRFl3s=;
  b=gNHRSJxU6pyB9n7ydn/QK0YAeAfhG88RIP7ttz6x4pA4uOC36XY1f16E
   bke7DyC+Q32csClN2cD60rk+BbFFy6luq5mLSShuMGP9t+/imloenEQ5N
   l5NP548pulUhf2HYCMWAiiFNpYHqgo8094yOaWsKBdPNK5xpMPNrXXH1/
   sFzs41ng9YE2klXBkvZ4PRIaJ2VbM93+LfSF38htlKwv2BbcGhhgLNnCT
   h7C01JV9twuLJIxUXlK6UeF2sl9wHyLvqtqgpj7x9cx/mm1OMgA8pj5u4
   qYDBcwbn+70KEaMEgTkyMdSZVV9FWpXGEsDUXroBnB0v8v8oPu3vpKPoQ
   w==;
X-CSE-ConnectionGUID: JK06WcvBSoG4HxxOWp7nKw==
X-CSE-MsgGUID: vT4xlU9IQCCx0+NYkUriZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100415107"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100415107"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:28 -0700
X-CSE-ConnectionGUID: Dhetkyr+QjCOyeyKNFgC3w==
X-CSE-MsgGUID: Y1eBjy8nTYOOBHTanUVvyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248700606"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:27 -0700
Date: Tue, 23 Jun 2026 10:35:26 -0700
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
Subject: [PATCH v12 11/12] x86/vmscape: Resolve conflict between
 attack-vectors and vmscape=force
Message-ID: <20260622-vmscape-bhb-v12-11-76cbda0ae3e5@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301432-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nutanix.com:email,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75CB36B929A

vmscape=force option currently defaults to AUTO mitigation. This lets
attack-vector controls to override the vmscape mitigation. Preventing the
user from being able to force VMSCAPE mitigation.

When vmscape mitigation is forced, allow it be deployed irrespective of
attack vectors. Introduce VMSCAPE_MITIGATION_ON that wins over
attack-vector controls.

Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1082ed1fb2e6..fbdb137720c4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3058,6 +3058,7 @@ static void __init srso_apply_mitigation(void)
 enum vmscape_mitigations {
 	VMSCAPE_MITIGATION_NONE,
 	VMSCAPE_MITIGATION_AUTO,
+	VMSCAPE_MITIGATION_ON,
 	VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER,
 	VMSCAPE_MITIGATION_IBPB_ON_VMEXIT,
 	VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER,
@@ -3066,6 +3067,7 @@ enum vmscape_mitigations {
 static const char * const vmscape_strings[] = {
 	[VMSCAPE_MITIGATION_NONE]			= "Vulnerable",
 	/* [VMSCAPE_MITIGATION_AUTO] */
+	/* [VMSCAPE_MITIGATION_ON] */
 	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]		= "Mitigation: IBPB before exit to userspace",
 	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]		= "Mitigation: IBPB on VMEXIT",
 	[VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER]	= "Mitigation: Clear BHB before exit to userspace",
@@ -3085,7 +3087,7 @@ static int __init vmscape_parse_cmdline(char *str)
 		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
-		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
 	} else if (!strcmp(str, "auto")) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {
@@ -3117,6 +3119,7 @@ static void __init vmscape_select_mitigation(void)
 		break;
 
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		/*
 		 * CPUs with BHI_CTRL(ADL and newer) can avoid the IBPB and use
 		 * BHB clear sequence. These CPUs are only vulnerable to the BHI
@@ -3244,6 +3247,7 @@ void cpu_bugs_smt_update(void)
 	switch (vmscape_mitigation) {
 	case VMSCAPE_MITIGATION_NONE:
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		break;
 	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
 	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:

-- 
2.34.1



