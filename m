Return-Path: <netdev+bounces-271266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JxVBo7swmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:57:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7231BF52
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88692300B464
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22830DEDD;
	Tue, 24 Mar 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY+c5yQU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85383093BB;
	Tue, 24 Mar 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381914; cv=none; b=R7ZFhKm7DyDwr//WxUsGebNuKPEspc3jcsil2W8Mccd2vcJI1csyja2ebnIlb10dFwHHI3WVCHcXkQpmFvSF1CjSz+WeOOqulE40qBnPAY2h6CE0Uu8WSL7ufChbGrtNbwp637wHspJmOVl7TQPg6BZ5YP3VAoC+cKGnyrHCBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381914; c=relaxed/simple;
	bh=9qUWq3HG5BEdyJlujwZ0hO/tBuUYXEGWeEuH09n4QVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKMzWgwhkrjISRrfS+dwpm1kvVATURoC+C5dImkfKwwfg9ivpYM3yAb4X6MsZo/GKVtxsQIsg3wANA9Wp/Byv6PoYEr7oOmhxLK1/wbfSYpH4/q0ejejj+WJ0gMq4DUbJH41I80/OHdoN3ZvNrGyQXNja/Xhz6SCqmDBRtbIAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY+c5yQU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774381913; x=1805917913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qUWq3HG5BEdyJlujwZ0hO/tBuUYXEGWeEuH09n4QVk=;
  b=VY+c5yQUoG0jO1mBS1gx9NQvgEUSd64ZoX/oQPmJQBEIOnRkyv77nQoh
   ZCl0rn8ssyDR5XHEf6O3gQ5RYFli0QeXfrDmYwCK/ZTPLqRG438cAxv1l
   UmpUyNBdor1VT2HBavNsKCuWH7Qr0CZnYWFz72UKnDkpWVCIxMaDBlC6F
   YhWLzvcy2cd1wTbWQKUCXwg2rkhu0CoUOmIT2wj64+Ina9dxdLcP5HQ9W
   e13Hf9ONGdyeLQVRS4Vd8tgum3DPCkl6SKycc8GtV53q9p6kzQT8vd7cQ
   tl56++IL118ITKH4wl+oBik8CNtuZOOH6bPpty0LHl6nl3nAVHhMxmxC0
   w==;
X-CSE-ConnectionGUID: KoQjtg0eQGK4QEUZ3YKFzA==
X-CSE-MsgGUID: trUSNI2VSRCxEzX3yvJcYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75381408"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75381408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:51:52 -0700
X-CSE-ConnectionGUID: lU4K3NZTS3i673fsg3OZhA==
X-CSE-MsgGUID: zizVKckFR4q2TH6ISfKkQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221568862"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:51:50 -0700
Date: Tue, 24 Mar 2026 12:51:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: x86@kernel.org, jon@nutanix.com, nik.borisov@suse.com, hpa@zytor.com,
	jpoimboe@kernel.org, david.kaplan@amd.com, seanjc@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, jolsa@kernel.org, davem@davemloft.net,
	david.laight.linux@gmail.com, luto@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dsahern@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	pbonzini@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, asit.k.mallick@intel.com, tao1.zhang@intel.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v8 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260324195144.c6gaxewnyojsev2q@desk>
References: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
 <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>
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
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41]
X-Rspamd-Queue-Id: 6CF7231BF52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:09:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index dbe104df339b8..b4d529dd6d305 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -503,7 +503,7 @@
> >  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
> > -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
> > +/* Free */
> >  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
> 
> Should the corresponding entry in
> tools/arch/x86/include/asm/cpufeatures.h also be updated to match?

No, because:

  "So its important not to touch the copies in tools/ when doing changes in
  the original kernel headers, that will be done later, when
  check-headers.sh inform about the change to the perf tools hackers."

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

