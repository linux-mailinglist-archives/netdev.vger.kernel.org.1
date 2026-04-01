Return-Path: <netdev+bounces-273977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOJwM2nVzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB6D376AC2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E4A300A77E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0A382F27;
	Wed,  1 Apr 2026 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEG/4e9U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5B375AB2;
	Wed,  1 Apr 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031172; cv=none; b=WL3hR2ojWF9avXM2xkOyXwyJvma5SDtPbs8wFQesPg+Iq/8vvNwIz+ao9v7CJauQDVzQ001VQX0WZQX5yuxUImuwe4wPUerLKlpWyekgq0Nyf47AGG4deaCakc8ew6wiqRC+YnGCc/NpFuAhinMJBtjccZ6iKJnqEVVPKyFyWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031172; c=relaxed/simple;
	bh=8C75pF4ufa2nXsmgsc1kxnPOWcRm5xn+aaUG2usdOjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siLXC7jWViHBey6ktAgtUHDJd6suFBsr0vWzUPFlMnhnuGDRygNK9KRL4SRsos451xhQfcu7SlaUKpSwjSm0BqsNR9ulyul7NzONJH2fCDMqUpySncdldPBSJgBtr0VJrlEAOq0h4ziXhjQbc6PgkmNTwJ1BkoSeao0bXoLQKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEG/4e9U; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775031169; x=1806567169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8C75pF4ufa2nXsmgsc1kxnPOWcRm5xn+aaUG2usdOjY=;
  b=AEG/4e9U0CdVpbXBDG9edO7qAH3hZUqz96cynw80+uZTwvbDQFXCLJg+
   0XFJoekb5UsGGEWZjf99RMdaGQPeO9nRME8R/dMJoZVIMb3Zx6q6Xzje8
   JZ2YIvzHqwBCiuzttuGvDBB32tidbbO8+lPJy1xxzOoV2KXKm7VTBIHHE
   C5kdVrSQoXZha6Ci7tTBeU/hekE1AS3ymmc6DgnzaHU6vgnqe2n4SEuI9
   XRS8JqoTIud+XmODQh6CokqZHaUEt1c4PXGiMIQIOlNA32x6d44ABp943
   i/SwuBDmgk0Fa7Sj40LItTg95ebBI8aFtXgCINPPvALOh2HrW77W0mJCN
   Q==;
X-CSE-ConnectionGUID: vplyl0ZnR9Ka0yWWN3iigw==
X-CSE-MsgGUID: B0ngQWBHSSuTdHevg1WKvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76075476"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76075476"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:12:47 -0700
X-CSE-ConnectionGUID: UXspTpIlSE+1qXsGp2q3sA==
X-CSE-MsgGUID: shy62LvOTCql9rHS4cDP+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231027919"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:12:47 -0700
Date: Wed, 1 Apr 2026 01:12:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jon Kohler <jon@nutanix.com>,
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
Message-ID: <20260401081236.3rjp2wigkr6w3nym@desk>
References: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
 <20260324221308.7sh6afdy6r6tsf4w@desk>
 <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
 <20260326083934.fk4wyhe6rgiss34z@desk>
 <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
 <20260326104557.24295cbb@pumpkin>
 <20260326202931.wlggnd3nfj6hngpb@desk>
 <20260328004256.mm2ttj5iwvu5kdpa@desk>
 <20260328100837.7e6dc7fe@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328100837.7e6dc7fe@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273977-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[alien8.de,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,alien8.de:email]
X-Rspamd-Queue-Id: 3AB6D376AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 10:08:37AM +0000, David Laight wrote:
> On Fri, 27 Mar 2026 17:42:56 -0700
> Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:
> > > On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:  
> > > > On Thu, 26 Mar 2026 11:01:20 +0100
> > > > Borislav Petkov <bp@alien8.de> wrote:
> > > >   
> > > > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:  
> > > > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > > > ALTERNATIVE. Please let me know if I am missing something.    
> > > > > 
> > > > > Yes, you are.
> > > > > 
> > > > > The point is that you don't want to stick those alternative calls inside some
> > > > > magic bhb_loop function but hand them in from the outside, as function
> > > > > arguments.
> > > > > 
> > > > > Basically what I did.
> > > > > 
> > > > > Then you were worried about this being C code and it had to be noinstr... So
> > > > > that outer function can be rewritten in asm, I think, and still keep it well
> > > > > separate.
> > > > > 
> > > > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > > >   
> > > > 
> > > > I think someone tried getting C code to write the values to global data
> > > > and getting the asm to read them.
> > > > That got discounted because it spilt things between two largely unrelated files.  
> > > 
> > > 
> > > The implementation with global variables wasn't that bad, let me revive it.
> > > 
> > > This part which ties sequence to BHI mitigation, which is not ideal,
> > > (because VMSCAPE also uses it) it does seems a cleaner option.
> > > 
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> > > 
> > >  static void __init bhi_update_mitigation(void)
> > >  {
> > > +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > +       bhi_seq_outer_loop = 5;
> > > +       bhi_seq_inner_loop = 5;
> > > +   }
> > > +
> > > 
> > > I believe this can be moved to somewhere common to all mitigations.
> > >   
> > > > I think the BPF code would need significant refactoring to call a C function.  
> > > 
> > > Ya, true. Will use globals and keep clear_bhb_loop() in asm.  
> > 
> > While testing this approach, I noticed that syscalls were suffering an 8%
> > regression on ICX for Native BHI mitigation:
> > 
> >   $ perf bench syscall basic -l 100000000
> > 
> > Bisection pointed to the change for using 8-bit registers (al/ah replacing
> > eax/ecx) as the main contributor to the regression. (Global variables added
> > a bit, but within noise).
> > 
> > Further digging revealed a strange behavior, using %ah for the inner loop
> > was causing the regression, interchanging %al and %ah in the loops
> > (for movb and sub) eliminated the regression.
> > 
> > <clear_bhb_loop_nofence>:
> > 
> > 	movb	bhb_seq_outer_loop(%rip), %al
> > 
> > 	call	1f
> > 	jmp	5f
> > 1:	call	2f
> > .Lret1:	RET
> > 2:	movb	bhb_seq_inner_loop(%rip), %ah
> > 3:	jmp	4f
> > 	nop
> > 4:	sub	$1, %ah <---- No regression with %al here
> > 	jnz	3b
> > 	sub	$1, %al
> > 	jnz	1b
> > 
> > My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
> > inner loop, which is executed more number of times is likely making the
> > difference. A perf profile is needed to confirm this.
> 
> I bet it is also CPU dependant - it is quite likely that there isn't
> any special hardware to support partial writes of %ah so it ends up taking
> a slow path (possibly even a microcoded one to get an 8% regression).

Strangely, %ah in the inner loop incurs less uops and has fewer branch
misses, yet takes more cycles. Below is the perf data for the sequence on a
Rocket Lake (similar observation on ICX and EMR):

  Event                     %al inner      %ah inner       Delta
  ----------------------  -------------  -------------  ----------
  cycles                    776,775,020    972,322,384    +25.2%
  instructions/cycle               1.23           0.98    -20.3%
  branch-misses               4,792,502        560,449    -88.3%
  uops_issued.any           768,019,010    696,888,357     -9.3%
  time elapsed                 0.1627s        0.2048s     +25.9%

Time elapsed directly correlates with the increase in cycles.

> As well as swapping %al <-> %ah try changing the outer loop decrement to
> 	sub $0x100, %ax
> since %al is zero that will set the z flag the same.

Unfortunately, using "sub $0x100, %ax"(with %al as inner loop) isn't better
than just using "sub $1, %ah" in the outer loop:

  Event                     %al inner      + sub %ax       Delta
  ----------------------  -------------  -------------  ----------
  cycles                    776,775,020    813,372,036     +4.7%
  instructions/cycle               1.23           1.17     -4.5%
  branch-misses               4,792,502      7,610,323    +58.8%
  uops_issued.any           768,019,010    827,465,137     +7.7%
  time elapsed                 0.1627s        0.1707s      +4.9%

> I've just hacked a test into some test code I've got.
> I'm not seeing an unexpected costs on either zen-5 or haswell.
> So it may be more subtle.

This is puzzling, but atleast it is evident that using %al for the inner
loop seems to be the best option. In summary:

  Variant   Cycles     Uops Issued  Branch Misses
  -------  ----------  -----------  -------------
  %al       776M        768M           4.8M         (fastest)
  %ah       972M (+25%) 697M (-9%)     560K (-88%)  (fewer uops + misses, yet slowest)
  sub %ax   813M (+5%)  827M (+8%)     7.6M (+59%)  (most uops + misses)

