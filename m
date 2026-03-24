Return-Path: <netdev+bounces-271283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN+IBMzwwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:15:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC331C306
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3520F302883B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E868332EAC;
	Tue, 24 Mar 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHAiURWq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A892E3397;
	Tue, 24 Mar 2026 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383253; cv=none; b=gbTbhOA+DwM1BSBsHitlzoCQWRDVfW6w0OErSQkqiDcYY2ox0y2ZRB4VJSpP5MJVBz0Jfdl3lJXApV1d1uO5ZRvq/q3+LCi120ezzrQzyQ7BRIHJWbel3+MIlRTJsDXLgsICgkkzwW5FLTKkdhHsICuXlA4ww+/EVpsbdQu5GlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383253; c=relaxed/simple;
	bh=cFuFU8YE7cEVhEQVQCkzUpXv5UGSTwcmnJReRP9FaAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFNB10pCo97b3qY/SdufDwEqbxLJ/AxjdcNxO1ZqWljmfTinqxu+XubNA8z/47Obv5r4sif+ofGQAz7ANx9THnh2FXQeXATYKXIR+v38aqNBFoTSKEBZlmWr8dcVvH5v59Vn1UnRoXEPZDAqdwjgcDAokgcRYciyY2H+WzZsu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHAiURWq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774383252; x=1805919252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cFuFU8YE7cEVhEQVQCkzUpXv5UGSTwcmnJReRP9FaAU=;
  b=EHAiURWqB+3ybVog7RIm7LsHnIT9RZmtDIydQ3m72JoYvxm4TBPZzO+o
   yn04ZkEyv9+HiG/lxVyuNWcYsolERO33k5BdKvF73MA0+jP1snYNpp1Kq
   OxDtxicFP4hurIU/WT1EV3ZB/Rr6b0hg79VZz/jh9eiOKLlAGJ8qXF2u2
   663HwUnbbO6g+n3ZFvLfk5ZXWFQaKqIGDnIp6ecQBuHrDY/et/I9VA0Vc
   DZFcpeFzPsoVs8TjDwmOUagww+h8gb4DlFf2nRxqDzmp+hoXIZUp/6Tcz
   //S/ovEClJSBDP2ETzZ2BJYPynwoqnaKbu5OLnpBhdMNwrnR7lkNbiPPY
   Q==;
X-CSE-ConnectionGUID: usTPGGUcTseB1Tq79WRRtg==
X-CSE-MsgGUID: CmLNsXrkR3CjoxA5UeYDQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86109686"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86109686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 13:14:11 -0700
X-CSE-ConnectionGUID: AXhwVh04RBOwotUDZEP6Kw==
X-CSE-MsgGUID: WEL3bLXtQZKCcEqSV3OuxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219588789"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 13:14:10 -0700
Date: Tue, 24 Mar 2026 13:14:04 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
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
Message-ID: <20260324201404.pi45c5anflqdrkgm@desk>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
 <20260320062206.bdrnmnvho6lhmejw@desk>
 <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
 <20260320113134.GAab0wFqe-hewZc175@fat_crate.local>
 <20260320182308.ahynqzuswlv34wf6@desk>
 <20260324200026.GCacLtWmhGVOmz832E@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324200026.GCacLtWmhGVOmz832E@fat_crate.local>
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
	TAGGED_FROM(0.00)[bounces-271283-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,suse.com,zytor.com,amd.com,google.com,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 80DC331C306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:00:26PM +0100, Borislav Petkov wrote:
> On Fri, Mar 20, 2026 at 11:23:08AM -0700, Pawan Gupta wrote:
> > I am curious, what problems do you anticipate? There are nearly 50
> 
> What's easier when you need to change the underlying implementation: unexport
> the static key and touch a bunch of places in the process or simply change the
> accessor's body and all the callers don't notice a thing?

I see. I switched to accessor in v8 I sent today.

