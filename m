Return-Path: <netdev+bounces-301781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZkIMJhBRPGpEmggAu9opvQ
	(envelope-from <netdev+bounces-301781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FE6C1990
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:50:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hmL4E3Yr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301781-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E561300C0EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D526CE11;
	Wed, 24 Jun 2026 21:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290713B7AE;
	Wed, 24 Jun 2026 21:50:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337805; cv=none; b=Jj2eC1m5hjyXr13eOXT9J15P7bTc7v2n0QT0hwDtrYQ89ROuKz1sKNzmMZWvmnrbm8gWNR1Sw9e2fi+8aGMOGf6ap5z3XqddnU82gBvwwul6KL1ukuNNukSmyylHMl4FrEDvieyoOW7s8AXS8AnWkONAaE9RdKm5psOdLg9t6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337805; c=relaxed/simple;
	bh=iG783dtOhFEuzZOm/uX3mLYVGqFljne8fQtBXrV9r0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoxHAT3OoB+GP8ALa+qPRPzoN0IYUg71+yhpIr7DIMzLz9KeXP6k8QfIj0XDeswl98X8oMswlQ7od7mfJlcU7QK6p9ghH8ZzqFDj1GJav7Nmyt/mtaCCYbYx2xKsURIfu/sIg386Q4cOK7NN6wqwNcgav4t8BoDUQcwASPvPKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmL4E3Yr; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782337804; x=1813873804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iG783dtOhFEuzZOm/uX3mLYVGqFljne8fQtBXrV9r0M=;
  b=hmL4E3YriX7mrnIR/fpkCZVj7qBIxK13OyuXBFCbJWHqFdYrTKac3K0K
   du8C/9deFHtoaO+jBo+h6CkymU0tX7mdlm7BuWlMnrVhM5yHnCtT7PbuP
   9FDJkz7W4ltCY3LRLDqb0usDMk/JYoxyFPjVUBf6IoUWusqDKhq6ORBcW
   EUEK0dUmu+muYdJJRfdTXU/Bk4GUg2p4TFJysDnmqwGUHu+XkHLa0v/lo
   QfHzhAUkKC/bUE1neCc/rhb+FCQ6/jDa6h86XDEHa9dfDEZkN4ihf0LlO
   DW4GRvpWoXJnVHEhLVNV3K+e28IvfD/LfBVJnMx5hXirLEqBMA4i3bgrV
   g==;
X-CSE-ConnectionGUID: SuqTNehCTm6+ma9PhwCBkg==
X-CSE-MsgGUID: BFL+aJInQVO2XnAbAsVABA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82881635"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82881635"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 14:50:04 -0700
X-CSE-ConnectionGUID: 9k7nQU13RXCIold5uacmXw==
X-CSE-MsgGUID: ThShJhaySDOjX6gHyPEOPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="274230416"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 14:50:02 -0700
Date: Wed, 24 Jun 2026 14:49:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
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
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 07/12] static_call: Define
 EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <20260624214955.6kkivefeuapcocib@desk>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
 <ajvUp_kPJBRZ7k_p@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvUp_kPJBRZ7k_p@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301781-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:
 lists@lfdr.de];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,akamai.com,goodmis.org,linuxfoundation.org,vger.kernel.org,intel.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,desk:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A36FE6C1990

On Wed, Jun 24, 2026 at 05:59:19AM -0700, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Pawan Gupta wrote:
> > There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> > modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> > restrict symbol visibility to only certain modules.
> > 
> > Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> > the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> > set of modules to see and update the static key.
> > 
> > The immediate user is KVM, in the following commit.
> > 
> > checkpatch reported below warnings with this change that I believe don't
> > apply in this case:
> > 
> >   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
> >   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  include/linux/static_call.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> > index 78a77a4ae0ea..b610afd1ed55 100644
> > --- a/include/linux/static_call.h
> > +++ b/include/linux/static_call.h
> > @@ -216,6 +216,9 @@ extern long __static_call_return0(void);
> >  #define EXPORT_STATIC_CALL_GPL(name)					\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> >  
> >  /* Leave the key unexported, so modules can't change static call targets: */
> >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > @@ -276,6 +279,9 @@ extern long __static_call_return0(void);
> >  #define EXPORT_STATIC_CALL_GPL(name)					\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> >  
> >  /* Leave the key unexported, so modules can't change static call targets: */
> >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > @@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
> >  
> >  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
> >  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
> >  
> >  #endif /* CONFIG_HAVE_STATIC_CALL */
> 
> Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
> another conversation[*].  I had already put together patches to effectively default
> to exporting only the trampoline, and also to deduplicate this code so that the
> CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
> implementations don't need to copy+paste the same lines of code.
> 
> The attached patches touch a lot more code, and will conflict mightily with KVM
> changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
> them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
> then there shouldn't be too much juggling needed?
> 
> If we want to go with the more aggressive cleanup, I'll formally post the patches.
> 
> [*] https://lore.kernel.org/all/ahhoDGUz39KSGZ6o@google.com

Thanks for the context.

Earlier making the key ro-after-init came up as an option in a thread with
Peter. Does it look like a good option to you?

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index b610afd1ed55..ea56da8fb446 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -200,6 +200,14 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
+#define DEFINE_STATIC_CALL_NULL_RO_AFTER_INIT(name, _func)		\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) __ro_after_init = {\
+		.func = _func,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\

