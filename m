Return-Path: <netdev+bounces-280615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNG4JNK56WlJigIAu9opvQ
	(envelope-from <netdev+bounces-280615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623544D845
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBE4301953B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87F031280C;
	Thu, 23 Apr 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ/fDlZX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC6307481;
	Thu, 23 Apr 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924997; cv=none; b=PWgfPD556+SgzloEHdtRHNcbmyqjnmSaX9w7Nuemkl3a4T6G0gIbfuck9Kpi91jM7Q8e4Bzew+Q5apDyRKIn+4qD0b0ld3liRnaa0wBqIS8ZkDPk2AC2vhdNS7wz8TQWzmSJQxHOvz24p0NNvVjyr9AH4UXLeZ2Z+Bxd20gH7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924997; c=relaxed/simple;
	bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZDxxFEhcgGic5uIjhT3aZ5HFmDKdevUXQtS+7cmJ1O7Ep4tmqMcXIa9voz2D3kuReH/CXcB2F9jkIPFS6dasOI8gyGGGD6ugDqCszKaXEWz+Wi4hSRnzSfeUZm6N6qxw1Xu7UU2M/A2UmQRJ2Ovn5Dwo+abp8MnoXb/v3LsGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ/fDlZX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924996; x=1808460996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
  b=fZ/fDlZXcTiZJSn9o0187r7CkOtRXpI8NAnaSgQVQbdTI7U/Pm1EuYXL
   CVkPWbzmyc8+zBDVHz+Z9k+8ALXy/cvH88rJEqH8hbCMR+NVYZx8uY3cT
   EjYmaRtvPwQ4ogphU05po+8lVV0muP5A6k7rQbxFZcvsl/R6CI6+FvLEB
   buHWZWw1Bf/IwMGDAvTzla75XVzcUXWLqMjr3ypVOQ0Gj4rBEEwGR2CH2
   QygnmU/j24142FbBlhiFo+33ZKkQyoa4ZEToIdAz9bNpdKoVIQ7cGKJhF
   Ym7DrBbwRYnyNTruqIYM5CxZTMxkNSeo7aau9t9ZVS7mH6i1jQXicZozL
   A==;
X-CSE-ConnectionGUID: cLNLjd/FST6nxXG+osyhKw==
X-CSE-MsgGUID: Z3x7wzwCRL2YXQlBGnscXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80473325"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="80473325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:36 -0700
X-CSE-ConnectionGUID: DQ9toAe3RKe2uxdSk+RHtQ==
X-CSE-MsgGUID: vc0uzW6MSh6AQBEKp9IpbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237551256"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:35 -0700
Date: Wed, 22 Apr 2026 23:16:34 -0700
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
Subject: [PATCH v11 07/12] static_call: Define
 EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <20260422-vmscape-bhb-v11-7-b18e0cf32af4@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280615-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,infradead.org:email]
X-Rspamd-Queue-Id: 1623544D845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
restrict symbol visibility to only certain modules.

Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
set of modules to see and update the static key.

The immediate user is KVM, in the following commit.

checkpatch reported below warnings with this change that I believe don't
apply in this case:

  include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
  include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 include/linux/static_call.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..b610afd1ed55 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -216,6 +216,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -276,6 +279,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 

-- 
2.34.1



