Return-Path: <netdev+bounces-275308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNNTItZZ0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3B3994E4
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E723011C7B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE31F12E0;
	Sat,  4 Apr 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EizX9mIU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F414B977;
	Sat,  4 Apr 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262120; cv=none; b=Uqj4vgPoor/5aGszZTW8K8k+U7fny5ksLG8dpIgs3McIYn7GJaGeG0O+ZEWDG/gkVqvbW0kyiI6RSRS9D9tSNBwywJvm7Hs8Cccl6KMHGoskypoTe+m8srj62auimkGuR1lgD0Nr1wrzkMzq7RnA2OPwsPH8eBX1bXHF0GUTDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262120; c=relaxed/simple;
	bh=K4fQ8Le81jwgc4RkE1ZtctQHn7HYlHeLdMGdNNR+9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVqH0PD/bAtZ+j/R5WADcLnS6o2qoCsHXThyZWyrxKSzqieMTtIHK6/WJcRnAjz0PaQY8BWcJYI+E7RXw/Z+MCM7B3Rd6Wpnv5O7Yuj8IcLI3enAaRLGPCQYPzqqJgLRnfnBu7W/P/Gd1mUiUFAyF5f9Eri4irFLtvQQM7ouHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EizX9mIU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775262119; x=1806798119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4fQ8Le81jwgc4RkE1ZtctQHn7HYlHeLdMGdNNR+9jI=;
  b=EizX9mIU+O95Qd0kn3+ufYfJ9tFv5bW44b383gGAYemtepzomUyF5K4y
   Gc/EtITakYaLCGMZdeR6/i3o5IcQkkl7x7GVk83jCc3QCGUt5YLLr7lNm
   S+zJSJt4tBFDggs6qubU+n2/AxTqvEDal5906Rh+Ls+0E4sCqFW1nghsD
   BKpDvtHRFPDZCtXb9u0wPkwaRqODbrN9A5fzsK0YTwqMnZNLGatKmTzDh
   xkVPwEeeMFJISHPaEmQ5pE2yB9WiM1pZRB1L8JjWtF1W0jrnYwL/Rj/RU
   JkcIuEttkBnMBBtaTqqvimWjmUcVmfN26CB7V81f2YkyVvxUCkix+KTac
   A==;
X-CSE-ConnectionGUID: Iw4rPuOFR/mio6cRZbFRvw==
X-CSE-MsgGUID: Y6r86Y3xQ76qprrJPqiyaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="75368382"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="75368382"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:21:58 -0700
X-CSE-ConnectionGUID: Gjpti8vKSNWPaml6JO+/3A==
X-CSE-MsgGUID: Wal5rm5WRziZs8ottwMk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="226377012"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:21:58 -0700
Date: Fri, 3 Apr 2026 17:21:49 -0700
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	chao.gao@intel.com
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260404002149.wtayv6a64vzuppgp@desk>
References: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk>
 <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk>
 <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk>
 <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
 <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275308-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[39];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EDF3B3994E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > Since cloud providers have greater control over userspace, the decision to
> > use BHI_DIS_S or not can be left to them. KVM would simply follow what it
> > is asked to do by the userspace.
> 
> I feel like we've gone over this before, but if userspace tells KVM
> not to enable BHI_DIS_S, how do we inform Windows that it needs to do
> the longer clearing sequence, despite the fact that the virtual CPU is
> masquerading as Ice Lake?

IMO, if an OS is allergic to a hardware mitigation, and is also aware that
it is virtualized, it should default to a sw mitigation that works everywhere.

> I don't think the virtual mitigation MSRs address that issue.

Virtual mitigation MSRs are meant to inform the VMM about the guest
mitigation. Even if there was a way to tell the guest that it needs to use
a different mitigation, it seems unrealistic for a guest to change its
mitigation post-migration.

