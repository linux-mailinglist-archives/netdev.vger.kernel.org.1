Return-Path: <netdev+bounces-301455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ltkfIubMOmo1HQgAu9opvQ
	(envelope-from <netdev+bounces-301455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173906B961F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:13:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kEJH9tDA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301455-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301455-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97C243049C65
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881F3955C7;
	Tue, 23 Jun 2026 18:13:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45283932E6;
	Tue, 23 Jun 2026 18:13:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238417; cv=none; b=NAwCvoOdePao6rPZUNGDfD5Zc7NmfIyS7esqJIsAos5vGyZSjikmiTqnrSQoJU+YomPgOvbaPe7BpeAHmac28plYNBAREtojcC0m2BhcxOY87x4W9KyTa/840F4c6CeU+bG3xfIsykU1fnD7ATdkz1Mc4QQHbitbVzqY85rhz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238417; c=relaxed/simple;
	bh=VJMOta+3s+TCmV62SJ0zB1Al0sUY6BAOjGA0zJa9hvY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=peLe1q4i7n87Wv4j8AWGaIfSqE49VWxtlcD1FOJBta7WDtMoH9w2sefLQ3V/A30CTZKp8RjcI4hcMb5cJFluTUnRn7seF132K1EMfXcJW8T/Tdl8KctJvgTaDmvdqYJTRUoEIAkMg75qFEB/mXjl0r0l2Bygs1lgrmCzxfQXNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEJH9tDA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E531F00A3A;
	Tue, 23 Jun 2026 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782238416;
	bh=aBLfufWEnFzGW+5SHTeI64dwwaybd6meHBhX9MvQwQE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kEJH9tDAef6hEfVMyPlLISgHEKD2zn31v7ikOtLIJxzEP8ItkhpFt0UpRr9I8w/cf
	 Jd0DUt+WTgTHhqKuL9hDXK3FZrXkFHVywk5TBFdXxS9F8TiaHavkl3rQioC30wsiYj
	 LECC/SU1e29Ay9D72JNgyfX74bwVMVo5gjUtzWZXYlf3QsRdWBHYBpFSytbuxpTTyN
	 4btRSuqWYaWdYZ4EgBwFFxNWtXGnHkbZuIp7SjQMAWYKSI1/c3tzTif+yHW2pQGNMy
	 NA5LgjDmBeU694oIfvxXnt7FDIWXUvXqL/dxV+Cj3mlN4d20jo6rTVxgZeuIaa1U3g
	 oE0GEHo5UlLCA==
Content-Type: multipart/mixed; boundary="===============2820250577695704451=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c1d327fa989f1eee142b13e5e7f5a514b03357239fbcaa5190e0d6180d7f8b0@mail.kernel.org>
In-Reply-To: <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
Subject: Re: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on newer CPUs
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net,jbaron@akamai.com,aliceryhl@google.com,rostedt@goodmis.org,ardb@kernel.org,skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 18:13:35 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301455-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid,alien8.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 173906B961F

--===============2820250577695704451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e..2cb4a96247d8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c

[ ... ]

> @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
>  		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
>  	}
>
> +	/*
> +	 * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
> +	 * support), see Intel's BHI guidance.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> +		bhb_seq_outer_loop = 12;
> +		bhb_seq_inner_loop = 7;
> +	}

Should this also consider the case of a guest running under a hypervisor
that does not expose BHI_CTRL?

When BHI_CTRL is absent the loop counts keep their short defaults (5/5)
and the guest declares itself BHI-mitigated.  In a heterogeneous
migration pool a guest may present as Ice Lake (no BHI_CTRL) while
actually running on Alder Lake or newer hardware, where the short
sequence is not sufficient.

A default-safe approach would be to also select the long sequence when
running under a hypervisor without BHI_CTRL, for example:

	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
		bhb_seq_outer_loop = 12;
		bhb_seq_inner_loop = 7;
	}

There is precedent for assuming the worst under a hypervisor, such as
vulnerable_to_its(), cpu_set_bug_bits() and check_null_seg_clears_base().

This came up during review and the resolution was to let the series move
forward and revisit the hypervisor case afterwards.  Is that still the
intent, or should the hypervisor fallback land with this patch?


For the missing Fixes: tag, quoting the full commit message:

commit a2a0812335ee19ae1df81f88e736da5210748c2b
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

>     x86/bhi: Make clear_bhb_loop() effective on newer CPUs
>
>     As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
>     the Branch History Buffer (BHB). On Alder Lake and newer parts this
>     sequence is not sufficient because it doesn't clear enough entries. This
>     was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
>     in the kernel.
>     Now with VMSCAPE (BHI variant) it is also required to isolate branch
>     history between guests and userspace. Since BHI_DIS_S only protects the
>     kernel, the newer CPUs also use IBPB.
>     A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
>     But it currently does not clear enough BHB entries to be effective on newer
>     CPUs with larger BHB. At boot, dynamically set the loop count of
>     clear_bhb_loop() such that it is effective on newer CPUs too.
>     Introduce global loop counts, initializing them with appropriate value
>     based on the hardware feature X86_FEATURE_BHI_CTRL.
>     Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

The short BHB clear sequence with the hardcoded loop count of 5 was
added by clear_bhb_loop() in entry_64.S, which is the code this patch
makes configurable.  Should this carry:

  Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28046221590
--===============2820250577695704451==--

