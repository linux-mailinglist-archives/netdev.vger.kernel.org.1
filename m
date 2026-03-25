Return-Path: <netdev+bounces-271772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B20EihixGkuywQAu9opvQ
	(envelope-from <netdev+bounces-271772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:31:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398032D04D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E02F300F7BF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073335DA76;
	Wed, 25 Mar 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSwGPoPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9630BB83;
	Wed, 25 Mar 2026 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477789; cv=none; b=haI3taLRk5l7vao+sSY/ZmAjIL6Ew8qIw7pzFa5faU3w4AXwk+FsUCvApRHhzAV9Pzbyo699dGVhErmx10LBCVDS+iW1p8Xv7+isEV7HEFuxVAUCb0eg+CrSDxxn0DYYAtiUl+G38voc/w5kvQ2m5caxDTgejkdBH83Wu+s9C8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477789; c=relaxed/simple;
	bh=PET/LcJ+wCLVXomHztA2wEteUGs91Pd6YIYx+AGMjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa0XcVtWOg7YXkKvbtzcrMZBCpie+crkyekcrTM+zn9DxToMnLqqO/iS1saGa+LVWLf+85TzR0y+anZY3h9NEJ3kRDpPryC8fQLKfucmm121UrehnkcXUckcDbH/JFuBTVu9h1viz8jHU4Rzs/ODQ5SpdjNA7DLAfyjazns46Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSwGPoPZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774477787; x=1806013787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PET/LcJ+wCLVXomHztA2wEteUGs91Pd6YIYx+AGMjCs=;
  b=eSwGPoPZjPQi55n9UcO0QOXcOH040QYUgRquCoKAjc92//Ku23UzhoL6
   d+vTgBtuRSFnn0Qk+mjXI5rs5O3Ci4/oJRXre8hV5Hglx3x/QZf7azyx9
   dZ47VljYoZtZ2cp/6HZYovz3OyqWm4fxerJlQhRRpWbC4t6FUdGpNIB5f
   xHScoDmOXTSpNLyQEi/b+TyOuNWa34SZHgLEnv4d3uZrveTPNCX/M6pGS
   txta3GB/6wqWI7c52OST5S3Ba5eI6pVAUWkMvjSpSM+xyrpENeMlbhoRK
   nzYsOLitAsPK2jA5n7cVg9SClJsxYmhwgePG3sF0ZdOjmJYIS2t6nyS10
   w==;
X-CSE-ConnectionGUID: a+ou29qOQc+9WqYwru5zqg==
X-CSE-MsgGUID: 7SGNR1Z4QF6Iw+5n0NkeIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74708550"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="74708550"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 15:29:46 -0700
X-CSE-ConnectionGUID: ZgKlkhnDRFqKfoPFzVLOjw==
X-CSE-MsgGUID: AB98rcckRju6E1ifnnlFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224762324"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 15:29:47 -0700
Date: Wed, 25 Mar 2026 15:29:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jim Mattson <jmattson@google.com>, x86@kernel.org,
	Jon Kohler <jon@nutanix.com>,
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
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325222939.gv4secbatf5vaqsb@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
 <20260325194146.29c91953@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325194146.29c91953@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 6398032D04D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 07:41:46PM +0000, David Laight wrote:
> On Wed, 25 Mar 2026 10:50:58 -0700
> Jim Mattson <jmattson@google.com> wrote:
> 
> > On Tue, Mar 24, 2026 at 11:19 AM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrites
> > > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > > sequence is not sufficient because it doesn't clear enough entries. This
> > > was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> > > that mitigates BHI in kernel.
> > >
> > > BHI variant of VMSCAPE requires isolating branch history between guests and
> > > userspace. Note that there is no equivalent hardware control for userspace.
> > > To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> > > should execute sufficient number of branches to clear a larger BHB.
> > >
> > > Dynamically set the loop count of clear_bhb_loop() such that it is
> > > effective on newer CPUs too. Use the hardware control enumeration
> > > X86_FEATURE_BHI_CTRL to select the appropriate loop count.
> > >
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
> > >  arch/x86/net/bpf_jit_comp.c |  7 -------
> > >  2 files changed, 16 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index 3a180a36ca0e..8128e00ca73f 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
> > >  SYM_FUNC_START(clear_bhb_loop)
> > >         ANNOTATE_NOENDBR
> > >         push    %rbp
> > > +       /* BPF caller may require %rax to be preserved */
> 
> Since you need a new version change that to 'all registers preserved'.

Ya, thats more accurate.

> > > +       push    %rax  
> > 
> > Shouldn't the "push %rax" come after "mov %rsp, %rbp"?
> 
> Or delete the stack frame :-)
> It is only there for the stack trace-back code.

Hmm, lets keep the stack frame, it might help debug.

