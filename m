Return-Path: <netdev+bounces-273261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIR8CBSkymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:25:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942835EBB8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9751430BCFE1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2B375ABD;
	Mon, 30 Mar 2026 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8EoFdtS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1C40DFC2;
	Mon, 30 Mar 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887070; cv=none; b=aBB59iuYmY8Lq1Fq2S/FRA7IcTbqR1UAjoj9SkpnBEY4GgxFT4B1fE8ypxTg1BiViCPZbxgGaspwjYmBWSultxEDNgZUS4BJARqC9ei3LbB7iXxqgnrtSSSJMgp4p3K/hjc01y3V5ANRgxtSvfa8qL/Kk2uKkVmBPprf+1ur3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887070; c=relaxed/simple;
	bh=oJZrTPyIRvOFXqPNud3LjOv7VsxDT9058WiuK6PlqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObfDW7eX4v5/2BNN8B8fTB/dIXDDiM5aGXRM4dVpeaMmx5x5UrUjex9RJy8NAakAuDDpGFOrdd5WjOHjUV04dRMjRronqv3JuwThdnKoj9VpDTQ5GddnaPG1WAUTp6Pi8mH4x6fcsdnHjowgkAp/Pgopnw1i0gsH0pqIcRr9fUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8EoFdtS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774887069; x=1806423069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oJZrTPyIRvOFXqPNud3LjOv7VsxDT9058WiuK6PlqMc=;
  b=g8EoFdtSrkc2lf0VsKoo5IyNvqhPnn3m4deXNfDmz2K2rtrewlshixto
   mDzWQtQqiBmVdlreme+EFDrL55ysV7Y7enFUo7kaO5EBzJBtD7b/6ZQOL
   Ely5QlH0AAkfGXmUO7FI5sIXeEW+WXb6ygYjJopHs8wwN1gSVTedEW0+k
   izxhNw9CUNv57WjZtSBAuVA1klPCXM8W/eueuxpWLT39Nm89CdWiG4LNP
   ABAuwUyfGwWn8qRUHIxoTKLHiVqwFxVi+a81mggE5xJwWbXevayyykee4
   He8vXvwB/z1Q4DFqNHagAea9UUak3yDEl41/VzhSZMEf0TiqiRRuwKzvT
   g==;
X-CSE-ConnectionGUID: 3DT7oglHTRiCIR827smxVw==
X-CSE-MsgGUID: 1poIhZzPSsqK+miPkXojXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98495918"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98495918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:11:08 -0700
X-CSE-ConnectionGUID: VjfuB/m5RQGKMHXVvw3MXg==
X-CSE-MsgGUID: kJhyq0RwQ2q99LagssHCYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249148231"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:11:06 -0700
Date: Mon, 30 Mar 2026 09:11:00 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
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
	Jonathan Corbet <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260330161100.conyluyigj322gb3@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <3B7BF368-4A3A-4853-A7CD-6F17E7982546@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B7BF368-4A3A-4853-A7CD-6F17E7982546@nutanix.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273261-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,nutanix.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7942835EBB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:16:32AM +0000, Jon Kohler wrote:
> Tested the v7 of this series with 6.18.y and one of our performance
> suites, where we had previously bisected a significant regression to
> the enablement of the VMSCAPE mitigation. This particular suite looks
> at synthetic performance using KVM virtualized Windows guests.
> 
> Long story short, this suite tries to derive what end user experience
> would be in these virtual machines while performing a standardized set
> of synthetic tasks on real apps.
> 
> VMSCAPE hits especially hard when enabling Windows HVCI, which drives
> a much higher VMExit count, all else equals. 
> 
> Tested on an Intel Xeon 6444Y (SPR)
> 
> TLDR, we're really happy with the results. The following was with 
> Intel MBEC *enabled*, so even with that speedup (and drastic reduction
> in VMExits), this optimization makes a significant difference.
> 
> - CPU‑ready time drops ~70 % across all steady‑state and log‑on metrics
> with this series, indicating more efficient context switching even
> though overall hypervisor CPU rises ~14 % (steady) to ~12 % (max).
> Basically, we're getting more actual work done.
> - Read/write IOPS increase by ~18–37 % and 14–20 % respectively, while
> average IO latency remains largely unchanged or slightly lower in
> steady metrics.
> - Power consumption falls 5–11 % in every category
> - Login times improve by 4–6 % on average.
> - Application start‑up times are generally better (Word, Excel,
> PowerPoint, Outlook), especially Outlook max time drops 67 %, a clear
> win for end‑user experience.

These results are promising.

> Tested-By: Jon Kohler <jon@nutanix.com>

Thanks for testing, Jon.

