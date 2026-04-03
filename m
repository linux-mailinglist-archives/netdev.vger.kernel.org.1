Return-Path: <netdev+bounces-275228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHGkE4oy0Gl84gYAu9opvQ
	(envelope-from <netdev+bounces-275228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C4398780
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6461F3022F71
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2E36C0DC;
	Fri,  3 Apr 2026 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnUw3Wf7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57E239E7E;
	Fri,  3 Apr 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252095; cv=none; b=ssIKgg4da7BAHz8GOvvwz8l5uUkcf/UAf5bIigBwTHiA6yrmD2zlbZJkhVzzCVZPGfTh+/EZQyLv23IIyx+RGup37m38lUI3zc463+RDmb4Lm6kfEdztkgJ4IQkHslt+MP+zuSPgnEQrD1RbQNVvaQuT21uWjalBv1nlOZVtw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252095; c=relaxed/simple;
	bh=z8W2epKST2mjCiUgHohx5Bf+YaafQk44O9HWl7u4iLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ+3z2sQSMucr7DNpAZj/JPC58Ld5QNskk2EWeRNH+AhaQZAqZ0/u4wTM1YmH6o+UbG6BF3+yA5K3Y1EZNrq+kRtSo3jq3GZaUtLgO5sqKZtFlnJapI1jrMrGoAr13jVFki1/UsMKVyX94OCjHysbhkL9nOlcQqKsV5zOGMBv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnUw3Wf7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775252094; x=1806788094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z8W2epKST2mjCiUgHohx5Bf+YaafQk44O9HWl7u4iLk=;
  b=RnUw3Wf7r7Z1BO/9kntuVlAskFEW4pCmtN52XxrGjsJ9R7bZcnoUqESU
   o1weLVGWcPnaXvYzrWHLwH0wYb6T9WXTIsLxWBDkaCslPvT5kAiU6doOS
   4lC4wurRdu4vrGsTp5R6IOPOZE9VbGswdq7ZBTS9FV9FMFXdR7l9ktiTk
   ZELedJe4U8iljeZ8s3SrWIGB+qNZVKjYbzly9sw+qCdk1hvqj5rgyCL/H
   msHXdVo1/cR4/q+rE6vTVdlHq9ujU5lrUcdqA5Vgc867ERfDdMjmP00Mz
   8Z3qEuoU9R/IfDRGsFClxirGxplYgIzOuoej4rvinTP+mk8DUFmbd5N55
   A==;
X-CSE-ConnectionGUID: r4z6echPSrKFDhLpBZuWHQ==
X-CSE-MsgGUID: l9nU4J67QxmgO8gNgsnWwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87768988"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87768988"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:34:53 -0700
X-CSE-ConnectionGUID: mCCa1tHpQPm4rFRdtMD5dw==
X-CSE-MsgGUID: WU/4d/KZSqK+ovrcANNEdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250565689"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:34:52 -0700
Date: Fri, 3 Apr 2026 14:34:46 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260403213445.xzb4rxbfbg5un7li@desk>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk>
 <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275228-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B68C4398780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> On Fri, Apr 3, 2026 at 11:52 AM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > On Thu, Apr 2, 2026 at 5:32 PM Pawan Gupta
> > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > >
> > > > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> > > > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > > > sequence is not sufficient because it doesn't clear enough entries. This
> > > > was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> > > > in the kernel.
> > > >
> > > > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > > > history between guests and userspace. Since BHI_DIS_S only protects the
> > > > kernel, the newer CPUs also use IBPB.
> > > >
> > > > A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> > > > But it currently does not clear enough BHB entries to be effective on newer
> > > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > > clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> > > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop count.
> > > >
> > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > ---
> > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > --- a/arch/x86/entry/entry_64.S
> > > > +++ b/arch/x86/entry/entry_64.S
> > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > >         ANNOTATE_NOENDBR
> > > >         push    %rbp
> > > >         mov     %rsp, %rbp
> > > > -       movl    $5, %ecx
> > > > +
> > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > +
> > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > >         call    1f
> > > >         jmp     5f
> > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
> > > >          * but some Clang versions (e.g. 18) don't like this.
> > > >          */
> > > > -       .skip 32 - 18, 0xcc
> > > > -2:     movl    $5, %eax
> > > > +       .skip 32 - 20, 0xcc
> > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > >  3:     jmp     4f
> > > >         nop
> > > >  4:     sub     $1, %eax
> > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > > >  extern void update_spec_ctrl_cond(u64 val);
> > > >  extern u64 spec_ctrl_current(void);
> > > >
> > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > +
> > > >  /*
> > > >   * With retpoline, we must use IBRS to restrict branch prediction
> > > >   * before calling into firmware.
> > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
> > > >
> > > > +/* Default to short BHB sequence values */
> > > > +u8 bhb_seq_outer_loop __ro_after_init = 5;
> > > > +u8 bhb_seq_inner_loop __ro_after_init = 5;
> > > > +
> > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > >  {
> > > >         if (!str)
> > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > > >                 x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
> > > > +        * support), see Intel's BHI guidance.
> > > > +        */
> > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > +               bhb_seq_outer_loop = 12;
> > > > +               bhb_seq_inner_loop = 7;
> > > > +       }
> > > > +
> > >
> > > How does this work for VMs in a heterogeneous migration pool that
> > > spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
> > > it isn't available on all hosts in the migration pool, but they need
> > > the long sequence when running on Alder Lake or newer.
> >
> > As we discussed elsewhere, support for migration pool is much more
> > involved. It should be dealt in a separate QEMU/KVM focused series.
> >
> > A quickfix could be adding support for spectre_bhi=long that guests in a
> > migration pool can use?
> 
> The simplest solution is to add "|
> cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
> If that is unacceptable for the performance of pre-Alder Lake

Yes, that would be unnecessary overhead.

> migration pools, you could define a CPUID or MSR bit that says
> explicitly, "long BHB flush sequence needed," rather than trying to
> intuit that property from the presence of BHI_CTRL. Like
> IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
> by a hypervisor.

I will think about this more.

> I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
> friends, unless there is a major guest OS out there that relies on
> them.

If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspace VMM is
in the best position to decide whether a guest needs
virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM can get
BHI_DIS_S for the guests that are in migration pool?

