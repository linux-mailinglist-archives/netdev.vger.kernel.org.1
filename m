Return-Path: <netdev+bounces-269797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD2qOCLovGlS4QIAu9opvQ
	(envelope-from <netdev+bounces-269797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:24:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0332D63AF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D97304C105
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909C30BF67;
	Fri, 20 Mar 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4EfhusW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8C28468E;
	Fri, 20 Mar 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987743; cv=none; b=Ltrfd4mLLWR1HiPufPZqeAv2FAMeDr/MMg4xfLS3bKCPXu72MbhIe0lh3nwo/c/5hkeXcNGM2BMWWoIas8N9+YqtSwXalQP53zucFElMVYvzQ5okr8/vCEspGIVOeuOikQGkH0n0vDzTR4txgV6D8HGv9hU3PCXuC89iGhQzI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987743; c=relaxed/simple;
	bh=Y8KK2D24mfTh3VP389qPc6aHnaY65d5tmzYY9bbkot0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeK1XEF/YOkH23I9LPEOcLFzqOjP0ipmaqg1Vw1WYaly89Xuz0Q51UX/593HXVju6ac8kMlvZrkPabux8+STUcJzqT4H1aPCA1FeSO2qmKOnuVromqxvlLamLOfrx3l2RsLwQnS+ABm460pBkO1a99jOlYIod6DEkW0/7Otqjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4EfhusW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773987741; x=1805523741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8KK2D24mfTh3VP389qPc6aHnaY65d5tmzYY9bbkot0=;
  b=h4EfhusWG7Xv5n5jNGAfLkHsFTHf2c7uDvDcZxTt9ny9wd/0F7vwXL3e
   DYS5nGUaVsov7XYXMmbCw1cX9xblmbqQ5kCWhbgLcqTS5WOOfU3uMVYye
   So2n28/S9yafKo0lpurjuDV33zF+zRpp2x2D07r7FB91g37VmBRpB55/p
   FoaywztCp98Jwo+JEDC4zDlrl0rHPxlKwPIxurI1R6xuj0gWZJe7ZVyp1
   h4Bnk+VSe2niCekwubKP50VwtpBOBUaOEM4acEHh50AjZnLxRcSjsczSV
   rnpMi5XxhW2oiDDQdbt/rHtEPgSFq+vqkFQhe4TPWBijWtDfRlmDRd4Fk
   Q==;
X-CSE-ConnectionGUID: 6usCPMfqTsmFWAotCy6zPg==
X-CSE-MsgGUID: 1q2oHitgQgqjwXnQ5VmalA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77676620"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77676620"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:22:20 -0700
X-CSE-ConnectionGUID: 3ZKtYmxhQTCMSaPmGSYtPw==
X-CSE-MsgGUID: UvuJIwaHSy2DE3wUa67I/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218576883"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:22:19 -0700
Date: Thu, 19 Mar 2026 23:22:06 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260320062206.bdrnmnvho6lhmejw@desk>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269797-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.907];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8E0332D63AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:44:09PM +0100, Peter Zijlstra wrote:
...
> > With _TRAMP, KVM complains:
> > 
> >  ERROR: modpost: "__SCK__vmscape_predictor_flush" [arch/x86/kvm/kvm.ko] undefined!
> 
> Ah, tricky. Yeah, this would need to be solved differenlty. Perhaps wrap
> this in a helper and export that?

bool vmscape_mitigation_enabled(void)
{
       return unlikely(static_call_query(vmscape_predictor_flush));
}
EXPORT_SYMBOL_FOR_KVM(vmscape_mitigation_enabled);

This is definitely simpler option, but adds an exported function and an
unnecessary call to it.

> Or use the below little thing and change it to
> EXPORT_STATIC_CALL_FOR_MODULES(foo, "kvm"); or whatnot.
> 
> > Probably one option is to somehow make sure that the key can be set to
> > __ro_after_init? I don't see a use case for modifying the static_call() after
> > boot.
> 
> So we have __ro_after_init for static_branch, but we'd not done
> it for static_call yet. It shouldn't be terribly difficult, just hasn't
> been done. Not sure this is the moment to do so.
> 
> 
> ---
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 78a77a4ae0ea..b610afd1ed55 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -216,6 +216,9 @@ extern long __static_call_return0(void);
>  #define EXPORT_STATIC_CALL_GPL(name)					\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
>  
>  /* Leave the key unexported, so modules can't change static call targets: */
>  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> @@ -276,6 +279,9 @@ extern long __static_call_return0(void);
>  #define EXPORT_STATIC_CALL_GPL(name)					\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
>  
>  /* Leave the key unexported, so modules can't change static call targets: */
>  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> @@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
>  
>  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
>  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
>  
>  #endif /* CONFIG_HAVE_STATIC_CALL */

This plus extending it to support EXPORT_STATIC_CALL_FOR_KVM() is probably
a better solution. Please let me know which one you prefer.

diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..89c4964c8560 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -13,6 +13,9 @@
 	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
 #define EXPORT_SYMBOL_FOR_KVM(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol ,"kvm," __stringify(KVM_SUB_MODULES))
+
 #else
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
 /*
@@ -23,6 +26,7 @@
 #ifndef EXPORT_SYMBOL_FOR_KVM
 #if IS_MODULE(CONFIG_KVM)
 #define EXPORT_SYMBOL_FOR_KVM(symbol) EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm")
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol ,"kvm")
 #else
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
 #endif /* IS_MODULE(CONFIG_KVM) */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5f102af4921f..0abdb54f7510 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -145,7 +145,7 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
 DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
-EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
+EXPORT_STATIC_CALL_FOR_KVM(vmscape_predictor_flush);
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"mitigations: " fmt

