Return-Path: <netdev+bounces-278554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHIVI/KB3mnkFAAAu9opvQ
	(envelope-from <netdev+bounces-278554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:05:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25E3FD6ED
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B8C7300E280
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34E2874FB;
	Tue, 14 Apr 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAGTSUYk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F004248166;
	Tue, 14 Apr 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189935; cv=none; b=mlEyw3vWEKXgwrz9PGgYVVl6+cBI96bQllImt16GB2jG31Z5QapS/hzvaQ8LA7PCQEHoFWiE+VlBOuGbfheEDTh2Q6zkSqQARBoqua3fb8kpj4fLV4V2L+LBbgUzcfzYiZyGTsVrxe/8gPa+8PhOSWOoGnUc+An0cunb5lmqN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189935; c=relaxed/simple;
	bh=q2DrsFnuxK1fHmNxOuRECS2OWVI0HZxW9voN9duT66w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC7RQ4BIU5k5FsSynqhC/jW1S4IlvJK9cKy0uXFp6Gjn9TY7Idy+8KIrq0gXw7wGv/ipj0Z6ZWbNopBKBwldZMMZTmsWoTh61SXifIaTyYXLEsY6nkFJp9r4E3i+XULbqZ9MNYXl+vNwJ4sOGHEKJK6koAuhvGZ/Vc4HOrTOzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAGTSUYk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776189935; x=1807725935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2DrsFnuxK1fHmNxOuRECS2OWVI0HZxW9voN9duT66w=;
  b=EAGTSUYkUJ758mdy2h8UrDVyHnUMN9shwpNX6JEty7mEMS3i1XGqrNpA
   k6LDouC1f8LLJ1KoKZyAGt63oZs7X9kYiA//Wx6WSJk1gHn62+QGBwk3J
   qv8b+7qTI5zObK7B2foun4U9NOjfoKe12pS+IAt+FHi9MZ3VZ2QbAuzrM
   0LhJRu7yODrcJiCngHf89UWEFJzbwiCWFkVymFVaHtt7NXGAvhu9Vcpq9
   niT5A7Fzqki6TmCI1rcifEiVtleWObiXP5f7B4Uq0y42uCxrDsGDiJvhM
   8go0720F84xmSgU2ezn5RXEHwVEXb5bp5ICMbN6LoeV5SQdPLvDuer2XV
   Q==;
X-CSE-ConnectionGUID: deWxrDmaRoe1bH65EFtpLg==
X-CSE-MsgGUID: 5a6cH/lmSgaZsTqq6ybFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="80751352"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80751352"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:05:34 -0700
X-CSE-ConnectionGUID: E6+mn6gRRpCxIi3eA8k+Gg==
X-CSE-MsgGUID: 8cAOYDHdTKawlZGUMUgCbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235119082"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:05:33 -0700
Date: Tue, 14 Apr 2026 11:05:00 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 01/12] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260414180442.gcio7h6zjwjcayrs@desk>
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
 <20260414-vmscape-bhb-v10-1-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-vmscape-bhb-v10-1-efa924abae5f@linux.intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278554-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA25E3FD6ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:05:28AM -0700, Pawan Gupta wrote:
> Currently, the BHB clearing sequence is followed by an LFENCE to prevent
> transient execution of subsequent indirect branches prematurely. However,
> the LFENCE barrier could be unnecessary in certain cases. For example, when
> the kernel is using the BHI_DIS_S mitigation, and BHB clearing is only
> needed for userspace. In such cases, the LFENCE is redundant because ring
> transitions would provide the necessary serialization.
> 
> Below is a quick recap of BHI mitigation options:
> 
> On Alder Lake and newer
> 
>     BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
>     performance overhead.
> 
>     Long loop: Alternatively, a longer version of the BHB clearing sequence
>     can be used to mitigate BHI. It can also be used to mitigate the BHI
>     variant of VMSCAPE. This is not yet implemented in Linux.
> 
> On older CPUs
> 
>     Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
>     effective on older CPUs as well, but should be avoided because of
>     unnecessary overhead.
> 
> On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> branch history may still influence indirect branches in userspace. This
> also means the big hammer IBPB could be replaced with a cheaper option that
> clears the BHB at exit-to-userspace after a VMexit.
> 
> In preparation for adding the support for the BHB sequence (without LFENCE)
> on newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> executed. Allow callers to decide whether they need the LFENCE or not. This
> adds a few extra bytes to the call sites, but it obviates the need for
> multiple variants of clear_bhb_loop().
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Jon Kohler <jon@nutanix.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

Sorry this is missing Boris's Ack, I will fix.

> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

