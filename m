Return-Path: <netdev+bounces-301428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gwhD6rEOmpUGQgAu9opvQ
	(envelope-from <netdev+bounces-301428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7E6B9234
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:38:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="jH/sg/32";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301428-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD5A8311E7A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9B38C421;
	Tue, 23 Jun 2026 17:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65730BF69;
	Tue, 23 Jun 2026 17:34:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236068; cv=none; b=WvAdCfT/Y+DqL73zvPyJF2uW3uEFYAJeOIlSTvSLFVAag8ZfmEYNiEA9unZApGc95bAxmWSaZmixbrVP9gw7PimxDAvfvZdUKDf8EF0/elNwJ1GgW6XSN7ati+7Foe7AplHnGysyx6AhWO9d5WdTXZePNBUSqICVYfNoemu3zJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236068; c=relaxed/simple;
	bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEl58yX2sd6i7SztHdNlA79WI3bjUzwvWwtrVzrqHDIMoLHKLbjNsUGeGuaGHYvjxSEvzFLWkxIM0b66GKGJoS2JbZLDUBgEJqMDFLxaMmm5D4++S199v7UNpafNNtK+63ONqtEmGaIxnXvJriu4/m2Oost2mdSIcamfDJ6ERd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH/sg/32; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236067; x=1813772067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
  b=jH/sg/32qssJVc2slRAADa9uJoTxurohvvh6xGvk3rxpoEFe5z4aCfM2
   WDqZlOSluqUfrUUYyqsYRIZVmIseMdwGrpVaKY8+m316h3G9P5gUKvzkG
   2084DjHDEkbLEl98lW7BGWXZNQtpjC70UkPkJtBoqXTDVK4Agvxla02rM
   ZZXwNJYBcw5gpQpnutLtFIQhNiHLMxJ90Sewim7nl4nPwYJGIl4LbrnRY
   6Zuki8LXtMYx4E9wfLpjT20QEWp+FX2IdFmAHTKJpCtv7Q3R/9rYhzFSA
   ANFSgQM1bQfbQ5O2MpFMf+9DGKW3YsdQn82NSOxIp/1c/pj95Lp7f+RYJ
   g==;
X-CSE-ConnectionGUID: ohOXgrVxQJ6QeFVgsbFmjQ==
X-CSE-MsgGUID: o6V9ijYFQXeiWtL1+szp+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100414944"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100414944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:34:26 -0700
X-CSE-ConnectionGUID: 6wSkGP6/Sau1gn3LkRf6RQ==
X-CSE-MsgGUID: bDL9NoYfQhOpSnvbLMl24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249687588"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:34:27 -0700
Date: Tue, 23 Jun 2026 10:34:25 -0700
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
Subject: [PATCH v12 07/12] static_call: Define
 EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-301428-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,intel.com:email,infradead.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7E7E6B9234

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



