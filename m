Return-Path: <netdev+bounces-269898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLt+EBsxvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:35:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BD2D9AD1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1D13189238
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335A3803CE;
	Fri, 20 Mar 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FIC+zJsa"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6337B3F0;
	Fri, 20 Mar 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006348; cv=none; b=PEepSSH6w7jLf9SFgNAaNh01am5ZpxLz3fV8LXTjhwBxl9Bw+1LzDNgQcMv9jq1Puh+5+Lcw1P5RXXVF0YIAIRSVS4v8T+wl11d90ME10TXD5PIWpk7KpF1q3mc7YMz4QW4TkrwVNN5e2KaqII5IAV1toIVBQPjudAMPST4q5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006348; c=relaxed/simple;
	bh=SD0zMPdbCHRSu5dynsAxjF/5Yo4hGkU6mOhwbKNqSvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfDe+R0qwaepobVyHu3/z0GMeRD6XjswnLMBryWaULUPUYgHKQZ0TLTDbIvVNL1G/9MQGvPjP+O/L0VgTjBLOCkZ0ii5MIRBRSm0KgRYANRQqOpXKBmLxfkK+4g0SuJcnGF/BuVHvYAN33MG1Viv1EwiFALrXq+4Ow9ssCsFHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FIC+zJsa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EFE2A40E01A9;
	Fri, 20 Mar 2026 11:32:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jib5ah3yJCN8; Fri, 20 Mar 2026 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774006337; bh=eb8KDcq4gOieV0k+tw7u1jt0dzz7d5ZLktWlrQda5Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIC+zJsaEKChIBUTH8ESbHex4TyDU7HjjrqlwK9kDv0z2XWJfl+evZvc6UQBLCqxt
	 CSlfupCZQdvW3d1U4IMFre0axZyZMxjlyRF30O9ZddhHl1HP8WaT6Vfhp6d1KhBuHQ
	 pVRWJ0K45TIT8W7HnessO38xZDYclgu4YydseZTNsLxM7YWIZKojkDHdiCc+fmxy2L
	 s34qYYktPJfCVQ5vtPsuop19XV2znWZF9+n13T4XsRdgs9CtV9EAi5kSDmcc88jkDV
	 ibyJp14nKRY1gQxMEuTAet8GvFMfx1Vf5OEVRbmcMcxfz81MfFLquqWUogx5OKqgno
	 lhny/8eN2t455j05/Rr272/mrWZx6MOHRcis1rDdiKvY5JsMTaDcrToxR7xCv+lWe4
	 6YqyUBdWnRkEmMzyNHtW9pSufc/sXGAmyG+3s//Nj7+V76zcofh55Ehco01SUCoE4H
	 vfDiqoEkLQUPeYrHtqf+sZ54zonRSOE7IsdTYV8uVGOP5huBGDSDriqHhgcflrPmAZ
	 B9oM9GOQe7n+a2Ufp+EyFyLauVJl5GIRRZ43qxKIs/4yKkW1Kj9YHnzZd4iK2b4S7R
	 EAxsCcQcghkPgAeFS8n58Q/SazUhfrAtej5SLgrHXzQCX9rXVc0vkDHm4ZJsyPR3ux
	 fSsYCeOQOsa8qYUCYzb72lHw=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EC93C40E021E;
	Fri, 20 Mar 2026 11:31:40 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:31:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
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
Message-ID: <20260320113134.GAab0wFqe-hewZc175@fat_crate.local>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
 <20260320062206.bdrnmnvho6lhmejw@desk>
 <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269898-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.com,zytor.com,amd.com,google.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-0.940];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 922BD2D9AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:03:40AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 19, 2026 at 11:22:06PM -0700, Pawan Gupta wrote:
> 
> > This plus extending it to support EXPORT_STATIC_CALL_FOR_KVM() is probably
> > a better solution. Please let me know which one you prefer.
> 
> The EXPORT twiddling will do I suppose. I'll try and not forget looking
> at doing the RO static_call thing some time.

Dunno, but exporting a static_call sounds really really wrong to me. No matter
where. As in: we're exporting the underlying inner workings of it and that
should be a big fat no-no.

So definitely +1 on exporting the helper instead.

I'd say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

