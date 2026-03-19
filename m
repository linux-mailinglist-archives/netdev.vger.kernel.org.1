Return-Path: <netdev+bounces-269678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOJbAWFzvGmZywIAu9opvQ
	(envelope-from <netdev+bounces-269678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:06:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8D2D2DB7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42C630A757B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81003AA1B0;
	Thu, 19 Mar 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky55Gxzk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312728150F;
	Thu, 19 Mar 2026 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773957981; cv=none; b=HMH/255dW37hn9+rcC/lUpB8DGw1QRBqilhrXBcqOyftAS62jWZuxiPbn/5mz3A1b3/4WrWtQ+J1YBnNl6a+MhkNTXV50nylNXIZPx2/Bm4l/gtwI3VBJ6sx59tMMfu3NJ4W3D0y+19L1MQzxjTfLs+PvN9xUhsGaCfrWHGA39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773957981; c=relaxed/simple;
	bh=5dOQ4EmFm5o6Z6xX15MRA919kToNc/Is8WZhcTPbDnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqBmTX108JMAdHN2G5ozvLUIyBHV4nF1e1K53VA4+a04Jg0KSbd5EvvZFLKTezfwHL3HENkPdg1aCP6Wp4m1O+c2AjPvsmWIcrEc6nBgPZJ3V0qgxwHYyzMtii7j8kAliQfAxwyvgoaWo4NCO6yBhCMVZeb0AFEuigKK7uHweP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky55Gxzk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773957981; x=1805493981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5dOQ4EmFm5o6Z6xX15MRA919kToNc/Is8WZhcTPbDnA=;
  b=ky55GxzkDIq7TpqO1EcwH8odUlIZSLYvSCHaebUAaVeT9Kj3NHiQNMr0
   1zEZZLHjC5y80AXDzvplUc+wEuh3w9Dq5MtT83vhrEfvDTYW+nHGXBFz5
   u1FCN0pglIKEaKIozcontjvHS7kE/sDvWK6P+HDIJTSetEZ2S/6M9I/uR
   IEIZph53up9khwUZIRs42vurXuBStS9CjfugI26b3dlffaL3x/c6kGwgm
   bni40AVpTMH7Z+PCSrdCmn14vvovT8CzgG4DvOPAimulM9MruvbhXnvVg
   CyhzRdG2Ijg2Sc3zyV/6llPwjW6Fjhk3ZSLd0AyDPhLW3KdAIXhUdS4z4
   Q==;
X-CSE-ConnectionGUID: 1kSiYqffSFGFiP+LFiaBCA==
X-CSE-MsgGUID: Ghe8l9d4RiavZNWw4ylwcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86520510"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86520510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:06:20 -0700
X-CSE-ConnectionGUID: u7cK1ri5RPigX2sawiLgfA==
X-CSE-MsgGUID: b9yMyTfiRiG38gQURNwKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223073156"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:06:20 -0700
Date: Thu, 19 Mar 2026 15:06:14 -0700
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
Message-ID: <20260319220614.tejwx7ei2ukkljsw@desk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269678-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.805];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 9FC8D2D2DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:44:09PM +0100, Peter Zijlstra wrote:
> > With _TRAMP, KVM complains:
> > 
> >  ERROR: modpost: "__SCK__vmscape_predictor_flush" [arch/x86/kvm/kvm.ko] undefined!
> 
> Ah, tricky. Yeah, this would need to be solved differenlty. Perhaps wrap
> this in a helper and export that?

Wrapper seems to be a simpler option.

> Or use the below little thing and change it to
> EXPORT_STATIC_CALL_FOR_MODULES(foo, "kvm"); or whatnot.

This would be nice if there are other static calls that would benefit from
exporting to specific modules only. At this point, I don't know.

