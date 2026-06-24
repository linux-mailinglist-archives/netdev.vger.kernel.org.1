Return-Path: <netdev+bounces-301744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5UXKtgYPGpGjwgAu9opvQ
	(envelope-from <netdev+bounces-301744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3E6C07C6
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:50:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HAEjwEuR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1F733016EC2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FB3DD536;
	Wed, 24 Jun 2026 17:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F83CF673;
	Wed, 24 Jun 2026 17:49:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323402; cv=none; b=hBcBXakCflAg71E9e2n+uhSBWeWFvtxHIvd4xcmkvisEsTNMgkXnERlWel9T12p5dwlvU9Bw8N/Bz4j0jA2JyJwW+3t8v0yIV3mb8MbMtl4eOZFve2be2X321cs49jQYwZGnJUTrCvYLICW0uIOf0um8+1VWHdeqxBS8/3ybZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323402; c=relaxed/simple;
	bh=pvnvhqZtttLgUh/iGaCD+Nf+Eujn/MfYhSCE8ekvYsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PATWUdP2VYfb/X4V2zxVRnr33HqJgXod+BgI7jT9QQce6kE09IgMU9nYpiZAC1cHe6t3F+vLX0bGchKjbXB7U24X8c2DxPVFMi3g1lBAElH9VTT3MA7fRTVBcJE0I9Uky2CHynJbWDyL/KOQrBuGiIqkAJgD/NY8o9GoG+SDRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAEjwEuR; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782323401; x=1813859401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pvnvhqZtttLgUh/iGaCD+Nf+Eujn/MfYhSCE8ekvYsM=;
  b=HAEjwEuR/Aw56lJysbJSZY2/VAJTF4NZZ9OtcVVd4u+mMctWZUELGFmX
   CqNnJpP7caFUIs3JpNgJzO/h/ozYi3E4md+OrUcuypW4xoRmT2nzG1IaE
   fiocqT2gGd3gp+FXwC8ML8is7rWYiz5W9sGVb+UDXfwz71j+Lf79reTKJ
   2iGO8vS2wUl1XR98oKXnf1Uk+d3J9wgEAv20Gzh2vrRdPtweZ5dGhOmbR
   bLRLqZFiWwMbKMM4/wouZk5gNye/KtoJXQMr/xgNptYh4rGw5fhZ3sGVL
   E1UjN9ntN+U5idm6IRvBIvjcXeZCKLAAm85TfAQK3CM04VTGGL9kIucvG
   g==;
X-CSE-ConnectionGUID: 5pkuWLGnSAm1AGtRZ+Wfeg==
X-CSE-MsgGUID: hOjwPh7iTkqB4Q2B5IukQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82864226"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82864226"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:50:00 -0700
X-CSE-ConnectionGUID: yQf/hKEzTpyJ5iZ4NKPyOg==
X-CSE-MsgGUID: ErkjsEOgSnmTKFZsTBza9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="249796254"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:49:59 -0700
Date: Wed, 24 Jun 2026 10:49:49 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260624174949.zdcawcbjnlqsimo6@desk>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
 <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301744-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nik.borisov@suse.com,m:x86@kernel.org,m:jon@nutanix.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:
 lists@lfdr.de];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org,vger.kernel.org,intel.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,desk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,alien8.de:email,linux.intel.com:from_mime,intel.com:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05F3E6C07C6

On Wed, Jun 24, 2026 at 03:12:28PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.06.26 г. 20:33 ч., Pawan Gupta wrote:
> > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > sequence is not sufficient because it doesn't clear enough entries. This
> > was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> > in the kernel.
> > 
> > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > history between guests and userspace. Since BHI_DIS_S only protects the
> > kernel, the newer CPUs also use IBPB.
> > 
> > A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> > But it currently does not clear enough BHB entries to be effective on newer
> > CPUs with larger BHB. At boot, dynamically set the loop count of
> > clear_bhb_loop() such that it is effective on newer CPUs too.
> > 
> > Introduce global loop counts, initializing them with appropriate value
> > based on the hardware feature X86_FEATURE_BHI_CTRL.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Although AI brings up a valid argument about whether guests should be
> pessimized and fallback to the longer sequence ?

I don't disagree, but at the same time BHI mitigation for guest migration
is a different beast that should be addressed separately. A series that
adds virtual-SPEC_CTRL support is in the works. Expect the RFC to be posted
in a couple of weeks.

