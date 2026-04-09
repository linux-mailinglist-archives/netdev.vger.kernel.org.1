Return-Path: <netdev+bounces-277175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG6JJs062GmAaAgAu9opvQ
	(envelope-from <netdev+bounces-277175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC23D0926
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E973017251
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6239DBC5;
	Thu,  9 Apr 2026 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehSjIiDX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EB23BCF7;
	Thu,  9 Apr 2026 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778504; cv=none; b=bzSM4TDOkuUFnlbcsca8yJgdvQPpJ5UzxnY6OvwdSIhszLT56o7SDxgWrkJpPiX0KpRvubv+0irDiaNqK/3STQshfHe5oqDKAMF6YM/RbdYkProze3Q/uwdm2Z9Q3Ob7xYG7fcBH4Qyv8aXOXXDpKhdWDhfX4eQN6zPScQli6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778504; c=relaxed/simple;
	bh=cNFp5/1e4fflXeAwMOdQ4yhvA6vVAfsBV7gzMHKdgUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFGX0UE55G3CZAvE4R6KVcUbBVNnTwaGAPw+YmWerNNZK69Vp8YqDp3X+7LI4M0fOXS8GvKOzjsIG0l+cGT1DoaxQ1cVpKAzS/052T3XhdIrrXp3oGGzQYlU2av6dHqHIUwSNSfagDJX7x9AcLNfdTi3tuYytTFypKATok8eKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehSjIiDX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775778503; x=1807314503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cNFp5/1e4fflXeAwMOdQ4yhvA6vVAfsBV7gzMHKdgUM=;
  b=ehSjIiDX6GyqBGCAeLqDViqq94t2QrkiCYTcuI9hkjntfEUD3/uLrCfn
   9tRBYv2/+orA9IOF9neAVyWgw6OtSUN6VM8YwV1sa4TebVmqe0Tt/UPUb
   +YXmyeuZzozysT+uqyCzn516pbEhsawQyRqth1+bTDVB0npegjn7G1JXE
   dLuGYC3RmXHaqOi5oc4rPVREfl1ivJ9P/Oio/RMavEvCW1GqchMK3H9v+
   OCaCS54LdGEdubRrqqFe8CCchs/dPY2wc/NxP33xXqYCnJ96MSqb6ZE4g
   su3a5DY5y1ltusVu14ihslFkiMQ2sohRSi6lrqJCuSDRYyrzHfpxUIp24
   A==;
X-CSE-ConnectionGUID: qVlXWNoJSwKQJGsg0S4B4g==
X-CSE-MsgGUID: eaZ566buTtamiZWgEkXYlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76980471"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76980471"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:48:22 -0700
X-CSE-ConnectionGUID: hMuKyc7STvW/Ezaqo1PRrw==
X-CSE-MsgGUID: TwJTTwWUQ7Gjw+Ved6vQEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="230658220"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:48:20 -0700
Date: Thu, 9 Apr 2026 16:48:12 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	chao.gao@intel.com
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260409234754.e5mhhg3z36uwv36r@desk>
References: <20260407171151.2gf2idjbmph35ypb@desk>
 <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk>
 <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk>
 <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
 <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
 <410df9f6-69ec-483f-9009-0a9b8c9162a9@intel.com>
 <CALMp9eQx3H+n3V3dQh+ZafQZ6uNBjSYk8tZsvG6ffcY43YTrnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eQx3H+n3V3dQh+ZafQZ6uNBjSYk8tZsvG6ffcY43YTrnQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277175-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 39DC23D0926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 02:06:36PM -0700, Jim Mattson wrote:
> On Thu, Apr 9, 2026 at 1:36 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 4/7/26 17:47, Jim Mattson wrote:
> > > On Tue, Apr 7, 2026 at 4:41 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > >> On 4/7/26 16:27, Jim Mattson wrote:
> > >>> What is your proposed BHI_DIS_S override mechanism, then?
> > >> Let me make sure I get this right. The desire is to:
> > >>
> > >> 1. Have hypervisors lie to guests about the CPU they are running on (for
> > >>    the benefit of large/diverse migration pools)
> > >> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> > >> 3. Have apps in those guests that care about security to opt back in to
> > >>    BHI_DIS_S for themselves?
> > > I just want guests on heterogeneous migration pools to properly
> > > protect themselves from native BHI when running on host kernels at
> > > least as far back as Linux v6.6.
> > >
> > > To that end, I would be satisfied with using the longer BHB clearing
> > > sequence when HYPERVISOR is true and BHI_CTRL is false.
> >
> > If the guests can't get mitigation information from model/family because
> > the hypervisor is lying (or may lie), then it's on the hypervisor to
> > figure it out.
> >
> > I'm not sure we want to just assume that all hypervisors are going to
> > lie all the time about this.
> 
> Without any information, that is exactly what we must assume. There is
> precedent for this.
> 
> In vulnerable_to_its():
> 
>         /*
>          * If a VMM did not expose ITS_NO, assume that a guest could
>          * be running on a vulnerable hardware or may migrate to such
>          * hardware.
>          */
>         if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return true;
> 
> 
> In cpu_set_bug_bits():
> 
>         /*
>          * Intel parts with eIBRS are vulnerable to BHI attacks. Parts with
>          * BHI_NO still need to use the BHI mitigation to prevent Intra-mode
>          * attacks.  When virtualized, eIBRS could be hidden, assume vulnerable.
>          */
>         if (!cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
>             (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
>              boot_cpu_has(X86_FEATURE_HYPERVISOR)))
>                 setup_force_cpu_bug(X86_BUG_BHI);
> 
> ...and...
> 
>         if (c->x86_vendor == X86_VENDOR_AMD) {
>                 if (!cpu_has(c, X86_FEATURE_TSA_SQ_NO) ||
>                     !cpu_has(c, X86_FEATURE_TSA_L1_NO)) {
>                         if (cpu_matches(cpu_vuln_blacklist, TSA) ||
>                             /* Enable bug on Zen guests to allow for
> live migration. */
>                             (cpu_has(c, X86_FEATURE_HYPERVISOR) &&
> cpu_has(c, X86_FEATURE_ZEN)))
>                                 setup_force_cpu_bug(X86_BUG_TSA);
>                 }
>         }
> 
> 
> In check_null_seg_clears_base():
> 
>         /*
>          * CPUID bit above wasn't set. If this kernel is still running
>          * as a HV guest, then the HV has decided not to advertize
>          * that CPUID bit for whatever reason. For example, one
>          * member of the migration pool might be vulnerable. Which
>          * means, the bug is present: set the BUG flag and return.
>          */
>         if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>                 set_cpu_bug(c, X86_BUG_NULL_SEG);
>                 return;
>         }
> 
> The hypervisor could provide more information so that the guest can
> determine when it's safe to use the short sequence, but that's just
> icing on the cake. The default, out-of-the-box configuration must be
> safe.

In the above cases there was no practical way a VMM could have mitigated
the guest. So the only option for the guest was to take a conservative
approach. Secondly, in the BHI case, real world scenarios of migration
between pre and post ADL CPUs were unknown.

Nevertheless, Intel guidance covers this case by having KVM deploy
BHI_DIS_S for the guest using virtual-SPEC_CTRL. I understand that support
is missing currently, I am working on it. Hopefully, I will be able to
share the draft after this series settles down. We can workout the details
there.

In retrospect, it would have been ideal if this discussion had happened at
the time when virtual-SPEC_CTRL series was introduced.

