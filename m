Return-Path: <netdev+bounces-301454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dHyNIdXMOmorHQgAu9opvQ
	(envelope-from <netdev+bounces-301454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B46B960F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yoka7Gbq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 659B730443E6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0F3921CD;
	Tue, 23 Jun 2026 18:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394A38AC85;
	Tue, 23 Jun 2026 18:13:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238416; cv=none; b=kY59LfOWGac5pj//d4Rp70ZA60PvM44AoyBs0m3eZiV0YRV0jVWhQshXSQ5+Jd0jpxXjXAJBlOs3Pybk45CMzNzPLZwIY28e2sap9DRfgVfH+dk3imNei7e8e+549MYA3bKravxyqbqEpNfCx3rtPyV06ct5o+mxGLI9gBK1ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238416; c=relaxed/simple;
	bh=V071eB0OShAJcubanDUfinkZ4YVt3qy8HiCeWjfZSy0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dNjP9pRvX9M7aw6kY04mGOrTLS/5LzLVFh7aBexcFGUSihYdFk311gYMv1q3Lnm1vjZP27T8F5D5nIUntvmCL6ckE/MPXS5PXAm0L+m0Oo/Yxn8qJ+sDZQRHhaWLI8+JCkXJROzXcnhyymWgiA8VTtfvbWCPEyGqEJ/g8owvD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yoka7Gbq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CBE1F000E9;
	Tue, 23 Jun 2026 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782238414;
	bh=E/TuaqZp9SrAOm6ih2rrgSDiVa0hufYGsNwM/m76EDQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Yoka7Gbq2SraXyP6jmOdRcPoxXRj5V9Jw/b6qig6mT3ceLH6l9DURwZFj1iCDnHea
	 J63bsMKj9SqpBC8iHpQ5S8Eu+adrxmereL3A2pBEZR9ly50gJzv+YY0liyoefWF0Bd
	 y14TZjJuRQvuzoR7Iq7qR22xM3PjjCuxOPcYVkOauMXf2eK46MyFELeG+TMbjVz8Ex
	 jCFuhAK8Zc/s1e6Ob6hZevI9/OC94CHyWM7SJNd9OUOD8zFa5n617icoqA2K62bgLx
	 qFyrOXYum0SPZwRlLIdqMhnqQJyjleethFTB17Wqrs68MPGZafaGHSB09mslkW9CeA
	 CacWWJUyUZXTA==
Content-Type: multipart/mixed; boundary="===============2774573830481326885=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a9d5b1314956de19cdeebcf42f453a392b64019d9685aed93d1dced0e254e34@mail.kernel.org>
In-Reply-To: <20260622-vmscape-bhb-v12-8-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-8-76cbda0ae3e5@linux.intel.com>
Subject: Re: [PATCH v12 08/12] KVM: Define EXPORT_STATIC_CALL_FOR_KVM()
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net,jbaron@akamai.com,aliceryhl@google.com,rostedt@goodmis.org,ardb@kernel.org,skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 18:13:34 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301454-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pawan.kumar.gupta@linux.intel.com,m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:martin.lau@kernel.o
 rg,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[51];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 147B46B960F

--===============2774573830481326885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> EXPORT_SYMBOL_FOR_KVM() exists to export symbols to KVM modules. Static
> calls need the same treatment when the core kernel defines a static_call
> that KVM needs access to (e.g. from a VM-exit path).
>
> Define EXPORT_STATIC_CALL_FOR_KVM() as the static_call analogue of
> EXPORT_SYMBOL_FOR_KVM(). The same three-way logic applies:
>
>   - KVM_SUB_MODULES defined: export to "kvm," plus all sub-modules
>   - KVM=m, no sub-modules: export to "kvm" only
>   - KVM built-in: no export needed (noop)
>
>   As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override both
>   macros (e.g. to suppress the export when kvm.ko itself will not be
>   built despite CONFIG_KVM=m). Add the x86 no-op overrides in
>   arch/x86/include/asm/kvm_types.h for that case. To keep the pair in
>   sync, EXPORT_STATIC_CALL_FOR_KVM() is defined inside the
>   EXPORT_SYMBOL_FOR_KVM #ifndef block; an arch that defines
>   EXPORT_SYMBOL_FOR_KVM must also define EXPORT_STATIC_CALL_FOR_KVM or the
>   build will fail with a compile-time error.
>
> As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override
> EXPORT_STATIC_CALL_FOR_KVM definition (e.g. to suppress the export when
> kvm.ko itself will not be built despite CONFIG_KVM=m). Add the x86 no-op
> override in arch/x86/include/asm/kvm_types.h for that case.
>
> Architectures must also define EXPORT_STATIC_CALL_FOR_KVM when they define
> EXPORT_SYMBOL_FOR_KVM.

This isn't a bug, but the arch-override rationale appears twice in nearly
identical form.  The third paragraph (starting "As with
EXPORT_SYMBOL_FOR_KVM(), allow architectures to override both macros") and
the fourth paragraph (starting "As with EXPORT_SYMBOL_FOR_KVM(), allow
architectures to override EXPORT_STATIC_CALL_FOR_KVM definition") both
explain suppressing the export when kvm.ko will not be built and both
mention adding the x86 no-op override.

The requirement that an arch defining EXPORT_SYMBOL_FOR_KVM must also
define EXPORT_STATIC_CALL_FOR_KVM also shows up twice: once inside the
third paragraph ("an arch that defines EXPORT_SYMBOL_FOR_KVM must also
define EXPORT_STATIC_CALL_FOR_KVM or the build will fail") and again as the
standalone final sentence ("Architectures must also define
EXPORT_STATIC_CALL_FOR_KVM when they define EXPORT_SYMBOL_FOR_KVM").

Could the duplicate paragraphs be folded into a single statement?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28046221590
--===============2774573830481326885==--

