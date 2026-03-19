Return-Path: <netdev+bounces-269664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EYCMlRsvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:36:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB872D2BA1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D024130BA395
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411863EF65A;
	Thu, 19 Mar 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK0j+6NK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319B221FBD;
	Thu, 19 Mar 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956073; cv=none; b=aSQQ9JW+9NNSKMeSzs1H5GW3AIRyqMGtX0bUVxUV5xjG+dK62/1Of5+CATo4hZjxzLAxeKKLtj0q9UgmATgngoEm4tgHVWsbnfsIN35kCFm00LpdK9T0XE4uI/aZ2Wum0qJFoENqhVoD82VYBMAaR64xns37l6mD7kXm2VG+hH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956073; c=relaxed/simple;
	bh=g+LqMrEXTH3sjaWpUEO2v9ZD3LohQOUKXpc2vxB0m0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGijl1i/sc+19JSrODRlMP+ieHw86kxmYMht0sFDWYNh4LuFwyTmNBKrtRP877SMj+lXOeWPljBYMhDJxzVhm60RqsJ2drhMhr1QqTU/LK1WTRUknMT9nMEOixRqOB99o1rThPaMNKRasSk6toHU4MBatwLrkz+s2wUnRjJ22xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK0j+6NK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773956071; x=1805492071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+LqMrEXTH3sjaWpUEO2v9ZD3LohQOUKXpc2vxB0m0k=;
  b=GK0j+6NKaO7GEKnbKQ5a3eVRIhnMh0jUZRDs4WLjeyjZWofLMSV4Zv+u
   bJCjbv5vF2WWqrQziMfnFWhQhQwfmPUjoUn2i5BofvfUHkCzoSsPQquwf
   I/4E/2gRxKpPHa7D+quEmnfE6jvrZo083PmS6aqQ/0J8Fz/J8J+CY2jLx
   dYxCnNcGDi4o0xl2KwTA0ZexBZAEM/Nk978yXoYSga4f+8gEjx3fkvcOM
   Vrfa7+vQtyi73ux3lp8JIaCe5yQLPYmR7siPVGlR2wlBaiuKvOaDTdpLb
   5ItjuQGd+gVeSNGD16kYHdPdWBvWh3TKxmr6mz35HsZiRjXFSlBiJKTj8
   w==;
X-CSE-ConnectionGUID: tNZnTl2iTsKAijnV6WehmA==
X-CSE-MsgGUID: gki98L1gSFSbo4QHcxYsTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75009559"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75009559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:34:30 -0700
X-CSE-ConnectionGUID: MHeiFwZpRga1OZ3bv96RyQ==
X-CSE-MsgGUID: cbMLbtEgQBWLZbGHGKjnYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227799513"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:34:28 -0700
Date: Thu, 19 Mar 2026 14:34:21 -0700
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
Message-ID: <20260319213421.br6na4dulrjm6eke@desk>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
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
	TAGGED_FROM(0.00)[bounces-269664-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.924];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EB872D2BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:58:02PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 19, 2026 at 08:41:54AM -0700, Pawan Gupta wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 68e2df3e3bf5..b75eda114503 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
> >   */
> >  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
> >  
> > +/*
> > + * Controls CPU Fill buffer clear before VMenter. This is a subset of
> > + * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
> > + * mitigation is required.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
> > +EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
> > +
> > +DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> > +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
> 
> Does that want to be:
> 
> EXPORT_STATIC_CALL_TRAMP_GPL(vmscape_predictor_flush);
> 
> The distinction being that if you only export the trampoline, modules
> can do the static_call() thing, but cannot do static_call_update().

Right, modules shouldn't be updating this static_call().

One caveat of not exporting the static key is that KVM uses the key to
determine whether the mitigation is deployed or not:

  vcpu_enter_guest()
  {
      ...

     /*
      * Mark this CPU as needing a branch predictor flush before running
      * userspace. Must be done before enabling preemption to ensure it gets
      * set for the CPU that actually ran the guest, and not the CPU that it
      * may migrate to.
      */
     if (static_call_query(vmscape_predictor_flush))
                   this_cpu_write(x86_predictor_flush_exit_to_user, true);

With _TRAMP, KVM complains:

 ERROR: modpost: "__SCK__vmscape_predictor_flush" [arch/x86/kvm/kvm.ko] undefined!

Probably one option is to somehow make sure that the key can be set to
__ro_after_init? I don't see a use case for modifying the static_call() after
boot.

