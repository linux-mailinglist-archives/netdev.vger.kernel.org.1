Return-Path: <netdev+bounces-274235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YATBAkxqzWlmdQYAu9opvQ
	(envelope-from <netdev+bounces-274235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C037F7F0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB35D3075C6F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05D47DD63;
	Wed,  1 Apr 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hou/2XiH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99C47DD50;
	Wed,  1 Apr 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069584; cv=none; b=ekyQm8GcfxchBVGPnINomACmJ7xMex9ipq2edn+klNM2n6RU6YC4uyHzgEuCyiJcuJh+TqBehhgCYxuMW19aXjwFimG5Fg9kEcBWk6kJpxofeCZPd/hFcJDaRZ1jbAQzIkcYZhcN8Sbkoti0lVovOQVWrDFA+vegf+edqunsOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069584; c=relaxed/simple;
	bh=ZdkptTRmZ1xWZy0UTX5CWn5xL1JL0Tsfe3zndQo+s+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsfGYQbEbwNDb/HecaC2F6Ztmytk+gxbz7Usv4SNlzN2JTLxkaNKsG5L8hzWbAICoi/gRVli4lAyvtnFj4cYBfc7bD57WHdocgsy7DJFlb9CCvzRdMtBXB+63S3AZlFY8KV+4TDzmnAaFAXFTOWR78J5ne0Hdj9GXL1NHc2RddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hou/2XiH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775069584; x=1806605584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdkptTRmZ1xWZy0UTX5CWn5xL1JL0Tsfe3zndQo+s+A=;
  b=hou/2XiHpZmH5ITGsz34cC+y3nFNyxbDX2Xcw5pdK1vGIhnWPWGyDxgT
   cDMJCym+uWCAD7LB4GWcU6DY78fa/BOJJt6Nzcp8eFz5v1gDqfOA1ipPw
   e2/4J85pTmOUEc44Xpio9grTXa1tHVhKGXjdq/sQJMgZVMHNjUyaCsXlP
   Ln8gsBnwRM5RMsvSFhYaNXP4niqQQ8e5BIUPlXgRfiIp1A+gjSC64I4Th
   T5t+An64U8dClbMDszvrMwI0CBeLkZCR6rPz/hPeMR1ZNo7r4IgHvNfuS
   LkwTKGcEZJuEHlwezW7eCdbNCB5MijDsdrOPTKa9iIo4irumtKgiGMti1
   A==;
X-CSE-ConnectionGUID: LPv6ZBgKQKKsNMN+Apkwbg==
X-CSE-MsgGUID: MHprvaz+R+qh4RaJxP4amQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="98733266"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="98733266"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 11:53:02 -0700
X-CSE-ConnectionGUID: OJBGm0UASVyXcsCQ/xRU2w==
X-CSE-MsgGUID: 2MDbFtqGQE2+9OO6MLo/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225749343"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 11:53:02 -0700
Date: Wed, 1 Apr 2026 11:52:56 -0700
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
Message-ID: <20260401185256.f2ostywtxzddnwm2@desk>
References: <20260324221308.7sh6afdy6r6tsf4w@desk>
 <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
 <20260326083934.fk4wyhe6rgiss34z@desk>
 <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
 <20260326104557.24295cbb@pumpkin>
 <20260326202931.wlggnd3nfj6hngpb@desk>
 <20260328004256.mm2ttj5iwvu5kdpa@desk>
 <20260328100837.7e6dc7fe@pumpkin>
 <20260401081236.3rjp2wigkr6w3nym@desk>
 <20260401100200.5b347628@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401100200.5b347628@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274235-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 691C037F7F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:02:00AM +0100, David Laight wrote:
> > > As well as swapping %al <-> %ah try changing the outer loop decrement to
> > > 	sub $0x100, %ax
> > > since %al is zero that will set the z flag the same.  
> > 
> > Unfortunately, using "sub $0x100, %ax"(with %al as inner loop) isn't better
> > than just using "sub $1, %ah" in the outer loop:
> > 
> >   Event                     %al inner      + sub %ax       Delta
> >   ----------------------  -------------  -------------  ----------
> >   cycles                    776,775,020    813,372,036     +4.7%
> >   instructions/cycle               1.23           1.17     -4.5%
> >   branch-misses               4,792,502      7,610,323    +58.8%
> >   uops_issued.any           768,019,010    827,465,137     +7.7%
> >   time elapsed                 0.1627s        0.1707s      +4.9%
> 
> That is even more interesting.
> The 'sub %ax' version has more uops and more branch-misses.
> Looks like the extra cost of the %ah access is less than the cost
> of the extra mis-predicted branches.
> 
> Makes me wonder where a version that uses %cl fits?
> (Or use a zero-extending read and %eax/%ecx - likely to be the same.)
> I'll bet 'one beer' that is nearest the 'sub %ax' version.

%cl didn't make a noticeable difference, but ...

    Event                      %al/%ah        %al/%cl        Delta
                             (inner/outer)  (inner/outer)
    ----------------------  -------------  -------------  ----------
    cycles                    776,380,149    778,294,183     +0.2%
    instructions/cycle               1.23           1.22     -0.4%
    branch-misses               4,986,437      5,679,599    +13.9%
    uops_issued.any           773,223,387    765,724,878     -1.0%
    time elapsed                 0.1631s        0.1637s      +0.4%

... there are meaningful gains with 32-bit registers:

    Event                      %al/%ah        %eax/%ecx      Delta
                             (inner/outer)  (inner/outer)
    ----------------------  -------------  -------------  ----------
    cycles                    776,380,149    706,331,177     -9.0%
    instructions/cycle               1.23           1.35     +9.9%
    branch-misses               4,986,437      6,089,306    +22.1%
    uops_issued.any           773,223,387    774,539,522     +0.2%
    time elapsed                 0.1631s        0.1482s      -9.1%

These values are for userspace tests with immediates. Next, I will test how
they perform with memory loads in kernel. Before we finalize these uarch
nuances needs to be tested on a variety of CPUs.

