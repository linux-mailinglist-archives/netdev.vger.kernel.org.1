Return-Path: <netdev+bounces-271313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDBwA80Cw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:31:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265431CE06
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E11C30B4CC2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7C35EDA4;
	Tue, 24 Mar 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4fZnumA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264C259CB2;
	Tue, 24 Mar 2026 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387829; cv=none; b=kbGsnd8QNuAWt9MHA1Er6XnXPH5a3Y1rRXHpJnWUJQLJ9m67xH7herup6dTAmfv0zKsJVB3NHzXJ6sNveTwe7QmNzvgFXIFTc+EwywJpVE35++ehGgMEN21p1g6P9MxgFeb4EDuxNRCJE8lOnRA7b7br0dE6iwWUCVCChRGlCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387829; c=relaxed/simple;
	bh=39nUMyQfFEeGngy8KGNJdNCVECjoLlu165d2ANouZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsdBewUcmuhhY0MwpbflEjXFiR34IXi5dhnTPqYh0/EkzwjCgQ8l1Ih2SHhnrXcnrbeBlohN0kT0Q/FbqribJ024slnyDK8N9rNfYUIptGKRKDtdmzG6Mai6TE2vWXNZdNhfTlq+28yq0LRLP9D+Zdr701SNtaCNPTdq7/mLqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4fZnumA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774387827; x=1805923827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39nUMyQfFEeGngy8KGNJdNCVECjoLlu165d2ANouZ6w=;
  b=k4fZnumACOTWWTWTiRlp/+TbFH8VDFhyjOpGpcMV/GlTWw+cpk7Y8K5c
   WT1SLq8mQc9Nk5CjLmlIaocd+LY84/fgmteVsSXUeDMrElaqy+lZYiLZc
   84pySkLLVMbctla/WYD/YV8PD0fQfueXyQJXwi/Sqncf0iHB1wEQrnPdr
   0Dr82e/ywlQzbK4JntAbfZApmvRyrJI95e9fn2al0Xb8BoMfeXqUYxb1i
   iTThJX7klf7GzPURk+UOEoRRywlemiVg6SQUTbPDxsFeVC//2odk3dHTM
   hEL5/fBvyMIfjLTiFZUT/KzDPaHBpnesZBXf0sevPl+hHAMB6AuoK1vHL
   w==;
X-CSE-ConnectionGUID: 9/wSp/wvSEePXmlofbfEEw==
X-CSE-MsgGUID: RqlTbL/MTzmQgFe6IDDWVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75443169"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75443169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:30:26 -0700
X-CSE-ConnectionGUID: zWvkSUbgTmWNxtbAjjM07g==
X-CSE-MsgGUID: lrHMiJ4aSoue0x0v96PqWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="226111963"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:30:26 -0700
Date: Tue, 24 Mar 2026 14:30:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
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
Subject: Re: [PATCH v8 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260324213021.c73ibiekw36xhd6x@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-1-68bb524b3ab9@linux.intel.com>
 <20260324202251.GPacLym_7HV9IBbLaz@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324202251.GPacLym_7HV9IBbLaz@fat_crate.local>
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
	TAGGED_FROM(0.00)[bounces-271313-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6265431CE06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:22:51PM +0100, Borislav Petkov wrote:
> On Tue, Mar 24, 2026 at 11:16:36AM -0700, Pawan Gupta wrote:
> > Currently, BHB clearing sequence is followed by an LFENCE to prevent
> > transient execution of subsequent indirect branches prematurely. However,
> > LFENCE barrier could be unnecessary in certain cases. For example, when
> > kernel is using BHI_DIS_S mitigation, and BHB clearing is only needed for
> > userspace. In such cases, LFENCE is redundant because ring transitions
> > would provide the necessary serialization.
> > 
> > Below is a quick recap of BHI mitigation options:
> > 
> >   On Alder Lake and newer
> > 
> >   - BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
> > 	       performance overhead.
> >   - Long loop: Alternatively, longer version of BHB clearing sequence
> > 	       can be used to mitigate BHI. It can also be used to mitigate
> > 	       BHI variant of VMSCAPE. This is not yet implemented in
> > 	       Linux.
> > 
> >   On older CPUs
> > 
> >   - Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
> > 		effective on older CPUs as well, but should be avoided
> > 		because of unnecessary overhead.
> > 
> > On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> > guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> > branch history may still influence indirect branches in userspace. This
> > also means the big hammer IBPB could be replaced with a cheaper option that
> > clears the BHB at exit-to-userspace after a VMexit.
> > 
> > In preparation for adding the support for BHB sequence (without LFENCE) on
> > newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> > executed. Allow callers to decide whether they need the LFENCE or
> > not. This adds a few extra bytes to the call sites, but it obviates
> > the need for multiple variants of clear_bhb_loop().
> 
> Claude, please add proper articles where they're missing in the above text:
> 
> "Currently, the BHB clearing sequence is followed by an LFENCE to prevent
> transient execution of subsequent indirect branches prematurely. However, the
> LFENCE barrier could be unnecessary in certain cases. For example, when the
> kernel is using the BHI_DIS_S mitigation, and BHB clearing is only needed for
> userspace. In such cases, the LFENCE is redundant because ring transitions
> would provide the necessary serialization.
> 
> Below is a quick recap of BHI mitigation options:
> 
> On Alder Lake and newer
> 
>     BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
>     performance overhead.
> 
>     Long loop: Alternatively, a longer version of the BHB clearing sequence
>     can be used to mitigate BHI. It can also be used to mitigate the BHI
>     variant of VMSCAPE. This is not yet implemented in Linux.
> 
> On older CPUs
> 
>     Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
>     effective on older CPUs as well, but should be avoided because of
>     unnecessary overhead.
> 
> On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> branch history may still influence indirect branches in userspace. This also
> means the big hammer IBPB could be replaced with a cheaper option that clears
> the BHB at exit-to-userspace after a VMexit.
> 
> In preparation for adding the support for the BHB sequence (without LFENCE) on
> newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> executed. Allow callers to decide whether they need the LFENCE or not. This
> adds a few extra bytes to the call sites, but it obviates the need for
> multiple variants of clear_bhb_loop()."
> 
> Reads proper to me. Use it for your next revision pls.

Sure, will use this.

