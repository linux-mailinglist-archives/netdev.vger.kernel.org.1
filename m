Return-Path: <netdev+bounces-275156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KXsHKv4z2lT2AYAu9opvQ
	(envelope-from <netdev+bounces-275156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E1396FEC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D5D3024CB8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684823CBE67;
	Fri,  3 Apr 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+pEtDRk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EA2248A5;
	Fri,  3 Apr 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237211; cv=none; b=uQS5JYSZ9ecAeixR8HWmug9E0zNIdGu3YqXrTzBlNSH4hAMa3QEH5aFw+d0i2VQwxHVl1X9en1qTkQ0mOV0282+l+RfY+w9+6+3dsyJPIJBRI+ewNlPFtr9RgC+ERG+7jnQrD/k/Bu704i64KhafhnzDSCXNCvEW6+B+/Smm8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237211; c=relaxed/simple;
	bh=M6p3JmmzQexUHfSoR1LIGJcF55doBeHtQAVLzRfQu3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4LV5dUQ4OTSInssWc7zSt/OLYf9C9kxJToJe+uBorYHs9BV6POEjgdS6dgkt8dJj65rekHKlJc9y/z3B2yWboQH6+XqqpjILD4JN5U8hlWKRd1aUAv5gqlqqL9auXLkMCcYOGC45++tMqfmoBs7oJIGC/MzQwPT5emkQIDoCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+pEtDRk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237210; x=1806773210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M6p3JmmzQexUHfSoR1LIGJcF55doBeHtQAVLzRfQu3I=;
  b=f+pEtDRkR/TJ/eJmCypB3iLE+2pnWMC8CkJ8RtyFaOr1NSz8iXNoB92c
   kMaPgjWeiCq06QIQJdrP8n/XgKLXE9yCbWKUnFMjATPDzypCI9xEtXrKj
   rIAzSrnFn8dm6oMNtAQM5KHOIipBAd2/cyASCWJSSrC+OHcLVO2KjRFVI
   rv3ViW754DeDWfTTA2XtHl+a1VJLCRpA/qAFcoQDJNEndysY3NyWkONbE
   KIqmwZlYi4rF7LAEkUBQ3gFY2y2mCQ5EdiNZNdpcHPShYFicev1nKREfb
   5jlkBeGMKZS2Bz+rgOVQOcm1Crb7QkCvzpqS0QypyNf4+Tlh3BbPsFYM3
   w==;
X-CSE-ConnectionGUID: F9RSWatfTRi45C3ENY46uA==
X-CSE-MsgGUID: WDZN+ZL2QG+S+DRiVQgSpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76192441"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76192441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:26:49 -0700
X-CSE-ConnectionGUID: 8aLnb5V0QhqxJSY99LLsvw==
X-CSE-MsgGUID: kWetgwjETliORgt530tEaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="257775807"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:26:49 -0700
Date: Fri, 3 Apr 2026 10:26:43 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260403172643.fs2voyiy2kk6yzcx@desk>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-7-94d16bc29774@linux.intel.com>
 <ac_UJx99kDJY8j3t@google.com>
 <20260403164432.ltnr5oupddscwaqu@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403164432.ltnr5oupddscwaqu@desk>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275156-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB7E1396FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 09:44:32AM -0700, Pawan Gupta wrote:
> On Fri, Apr 03, 2026 at 07:52:23AM -0700, Sean Christopherson wrote:
> > On Thu, Apr 02, 2026, Pawan Gupta wrote:
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -11463,7 +11463,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> > >  	 * set for the CPU that actually ran the guest, and not the CPU that it
> > >  	 * may migrate to.
> > >  	 */
> > > -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> > > +	if (vmscape_mitigation_enabled())
> > 
> > This is pretty lame.  It turns a statically patched MOV
> 
> Yes it is, this was done ...
> 
> >   11548		if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> >   11549			this_cpu_write(x86_ibpb_exit_to_user, true);
> >      0x000000000003c57a <+858>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c582 <vcpu_enter_guest+866>
> > 
> > into a function call and two sets of conditional branches.  And with mitigations
> > enabled, that function call may trigger the wonderful unret insanity
> > 
> >   11548		if (vmscape_mitigation_enabled())
> >      0x000000000003c575 <+853>:	call   0x3c57a <vcpu_enter_guest+858>
> >      0x000000000003c57a <+858>:	test   %al,%al
> >      0x000000000003c57c <+860>:	je     0x3c586 <vcpu_enter_guest+870>
> > 
> >   11549			this_cpu_write(x86_predictor_flush_exit_to_user, true);
> >      0x000000000003c57e <+862>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c586 <vcpu_enter_guest+870>
> > 
> > 
> >   3166	{
> >      0xffffffff81285320 <+0>:	endbr64
> >      0xffffffff81285324 <+4>:	call   0xffffffff812aa5a0 <__fentry__>
> > 
> >   3167		return !!static_call_query(vmscape_predictor_flush);
> >      0xffffffff81285329 <+9>:	mov    0x13a4f30(%rip),%rax        # 0xffffffff8262a260 <__SCK__vmscape_predictor_flush>
> >      0xffffffff81285330 <+16>:	test   %rax,%rax
> >      0xffffffff81285333 <+19>:	setne  %al
> > 
> >   3168	}
> >      0xffffffff81285336 <+22>:	jmp    0xffffffff81db1e30 <__x86_return_thunk>
> > 
> > While this isn't KVM's super hot inner run loop, it's still very much a hot path.
> > Even more annoying, KVM will eat the function call on kernels with CPU_MITIGATIONS=n.
> > 
> > I'd like to at least do something like the below to make the common case of
> > multiple guest entry/exits more or less free, and to avoid the CALL+(UN)RET
> > overhead, but trying to include linux/static_call.h in processor.h (or any other
> > core x86 header) creates a cyclical dependency :-/
> > 
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 20ab4dd588c6..0dc0680a80f8 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -36,6 +36,7 @@ struct vm86;
> >  #include <linux/err.h>
> >  #include <linux/irqflags.h>
> >  #include <linux/mem_encrypt.h>
> > +#include <linux/static_call.h>
> >  
> >  /*
> >   * We handle most unaligned accesses in hardware.  On the other hand
> > @@ -753,7 +754,11 @@ enum mds_mitigations {
> >  };
> >  
> >  extern bool gds_ucode_mitigated(void);
> > -extern bool vmscape_mitigation_enabled(void);
> > +
> > +static inline bool vmscape_mitigation_enabled(void)
> > +{
> > +       return !!static_call_query(vmscape_predictor_flush);
> > +}
> >  
> >  /*
> >   * Make previous memory operations globally visible before
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 366ebe1e1fb9..02bf626f0773 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -148,6 +148,7 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
> >   * sequence. This defaults to no mitigation.
> >   */
> >  DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> > +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
> 
> ... to avoid exporting the static key, so that modules (other than KVM)
> cannot do static_call_update(vmscape_predictor_flush).
> 
> Peter suggested changes that allowed adding EXPORT_STATIC_CALL_FOR_KVM():
> 
>   https://lore.kernel.org/all/20260319214409.GL3738786@noisy.programming.kicks-ass.net/

Sorry, this is the correct link for EXPORT_STATIC_CALL_FOR_KVM():

  https://lore.kernel.org/all/20260320062206.bdrnmnvho6lhmejw@desk/

> EXPORT_STATIC_CALL_FOR_KVM() seems to be a cleaner approach to me.
> 
> Boris, I know you didn't like exporting the static_key. But, as Sean said
> this is a hot path, and avoiding the unnecessary call would benefit all
> CPUs (affected or unaffected). Moreover, EXPORT_STATIC_CALL_FOR_KVM()
> somewhat addresses your concern of exporting the static_key to the world.
> Would you be okay with it?

