Return-Path: <netdev+bounces-269675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EhEEkFuvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:44:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232C2D2C6F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5996E300728A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461CB3AF671;
	Thu, 19 Mar 2026 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q46Ttql8"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF41358386;
	Thu, 19 Mar 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956666; cv=none; b=t5WEpoZ3bZ9W3hzVvAtttHkhlANR3YxGQ1zBArAX3eSzMspREMdMADNMg/yaiAmRz4MbRKMA+TbiqZ4NYdb3aGHCmlQNZWgG+80UgcOH2i5YrgntRAjGfFvlxFeolanth8k0SEFO0jtzWHSjHKGpOmvTaMf0P6pTm98Q9gl56TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956666; c=relaxed/simple;
	bh=234akr+Ka97N4g6taZhj/haAHNReEXhxPhTjA96Wyo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUw168AuSHhRKMxoJF919xeS9Cla4oWur5XOwunx59saqMCd3bCfwFgwld7rn3Pjulv9C3x5SGPFvnSMlS1vsgCRbzqbqwLgsD4xEZKe+Kr3cW4GSRdf8rEj0CxPES84qo8gxVNngX/+hYBUq3FCcgKucNyN5+wrfiQZ+GPl5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q46Ttql8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dqhK1ppaR1o4766EpH/+BuuHqDFJziNZ+fK7614TnvI=; b=Q46Ttql8DfVwwoCG1n5qcHsvge
	OzGT3xAwBKIQLAq/HsZZGlgaLTr7xnC+CD3//gyD1pByc0xZ6NjcVvN9MFPJ0ZLrCC0RJD0WFJ/2C
	7vHQOM8FdQQab8TdQj02pUBLbJOGZyS/K5NgfHguSoYK3j/OHIfZUfqcOSvfooF9A9wTQ7sKMU7Md
	3VbzcilGNkeAZym+helC8RCkaIPCWMOr2t0orM739zJPxhWHE4FvKkRq7+PmCjrZKbV8PTK8g5xv3
	XKEpy4Im6Cm9BD4ZFA5N+ZViuLLsK+zuy1Zq0C9peDINDQLZfQL/1x3FizYJiJqCzK6cKE/yTGaVi
	ySxDQuPA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3LA2-00000006kMx-3DSh;
	Thu, 19 Mar 2026 21:44:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F2483004F8; Thu, 19 Mar 2026 22:44:09 +0100 (CET)
Date: Thu, 19 Mar 2026 22:44:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
Message-ID: <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319213421.br6na4dulrjm6eke@desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269675-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5232C2D2C6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:34:21PM -0700, Pawan Gupta wrote:
> On Thu, Mar 19, 2026 at 09:58:02PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 19, 2026 at 08:41:54AM -0700, Pawan Gupta wrote:
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index 68e2df3e3bf5..b75eda114503 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
> > >   */
> > >  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
> > >  
> > > +/*
> > > + * Controls CPU Fill buffer clear before VMenter. This is a subset of
> > > + * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
> > > + * mitigation is required.
> > > + */
> > > +DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
> > > +EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
> > > +
> > > +DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> > > +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
> > 
> > Does that want to be:
> > 
> > EXPORT_STATIC_CALL_TRAMP_GPL(vmscape_predictor_flush);
> > 
> > The distinction being that if you only export the trampoline, modules
> > can do the static_call() thing, but cannot do static_call_update().
> 
> Right, modules shouldn't be updating this static_call().
> 
> One caveat of not exporting the static key is that KVM uses the key to
> determine whether the mitigation is deployed or not:
> 
>   vcpu_enter_guest()
>   {
>       ...
> 
>      /*
>       * Mark this CPU as needing a branch predictor flush before running
>       * userspace. Must be done before enabling preemption to ensure it gets
>       * set for the CPU that actually ran the guest, and not the CPU that it
>       * may migrate to.
>       */
>      if (static_call_query(vmscape_predictor_flush))
>                    this_cpu_write(x86_predictor_flush_exit_to_user, true);
> 
> With _TRAMP, KVM complains:
> 
>  ERROR: modpost: "__SCK__vmscape_predictor_flush" [arch/x86/kvm/kvm.ko] undefined!

Ah, tricky. Yeah, this would need to be solved differenlty. Perhaps wrap
this in a helper and export that?

Or use the below little thing and change it to
EXPORT_STATIC_CALL_FOR_MODULES(foo, "kvm"); or whatnot.

> Probably one option is to somehow make sure that the key can be set to
> __ro_after_init? I don't see a use case for modifying the static_call() after
> boot.

So we have __ro_after_init for static_branch, but we'd not done
it for static_call yet. It shouldn't be terribly difficult, just hasn't
been done. Not sure this is the moment to do so.


---
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..b610afd1ed55 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -216,6 +216,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -276,6 +279,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 


