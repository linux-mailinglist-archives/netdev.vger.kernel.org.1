Return-Path: <netdev+bounces-271774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDSdAtFkxGmBywQAu9opvQ
	(envelope-from <netdev+bounces-271774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:42:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A632D23E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A466306DCC6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F8377560;
	Wed, 25 Mar 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF/z/bkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B435AC3A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478425; cv=none; b=Vp4Jmt6sI8dhrcGTEmetdmB+qPMnf7Fle5R6Mz5NUrzHSjyB8udQYIvPZkwk97u7w1EC3aqoAie9dMsXudl2kE0FaQzjfMYWlmYvzYdPcd6PgTTZtMUG/nULOSc8qSmhgN2bY1ek/YgAooWZTYb0oKvKyB3/jpZf1TQ+S7bSYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478425; c=relaxed/simple;
	bh=ZaZzTXMztz4BsrTjEetn5WiYeq1UcdFaHBBkV9D77uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JORF+hsQjv26uktUJKq4jm+6dVNCnKSgpYy91tP/BqXVKxJPYdLd/av/FkksYaNDpCzpzRI+uy7B6j/RPm0d4jX77m39ranWRJLI+bt6eQD3yKeQ8lSFJUSMv3TUKISXzopOgjZYXvDGZs+uP7JSunTSFiEZQQe+EI6HQRYXVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF/z/bkj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso4884435e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774478422; x=1775083222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX3VfcRobzAAPxO9qiWCisTs8vMckyJXXZiebELxbNI=;
        b=KF/z/bkjpjUHw64U3XS+R73TuCv+VhuISeiZNyWCXuvwekFlYSOpJ0rfGo/l9bdSWI
         5vwDZAdMcNnputxdNrUTG6pEKKCJBD4Cvy6qJXCmz7ZBWy27atDhqfyVerDQBwKn7jZ2
         nNUMIOlGseveQBvXrSHJlYCyjmlV2SD7kE+ShvizP3t75rgnteyT3sSbM1NqqXr5WewA
         dxW9nMz3lpOKDPU764Sr5WqUUcMDOX2OczbDnqm16lCyaukE60XpiHrb7ck2EIxi7xUu
         IIhnrWT9icYMgLpeUsnrynAP3bnxRrj7kxAclWHznlnI0RcahBK90cObpnqNaD7HtygV
         QUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774478422; x=1775083222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NX3VfcRobzAAPxO9qiWCisTs8vMckyJXXZiebELxbNI=;
        b=FQJeMgK3OplbWNEnJ7a4oD7bdj1WUQxyQWtNt64hMMHRcMQWSTB8mu86RlBfb/o4TR
         yugEy8VAMvoITKa+Nz7ynzl/ahSi3yhpGCRJL6vfH3eOjShvDMLZReKNJRZZ+zds1mos
         Y8quxoa39ct0w19pbaURXIK3P6vnv9VuCr9MWmPKW/VdCXuvy5kj73AVyhIla3eRvmQ/
         FBf2Y5gyf79zPdXiQyTH2MGBZfAXIbYzjd/A+kkrSYifUnkmI22EATjy6YBiBzp2aH4t
         9n3e6EbpdSn+bBvo3CjYyvQtSyV66vFWxkTiIPwU8QI3AAz88NJbMFQhaReXusa/Daip
         86Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgvm1KU82FBCMUx8YaHENnI4wV7aAjuV5f6QMFx2IgqZMJCeUD/0xSoIVbFsAEvfMk1mKK+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/78RTLPQlmTYanqnV1f5+2z9KN6eSYAvDx0oiiIqZmJJBlwH
	AVLl+shx6BCzEe36X6ctfa80zLkYRe+TaQnPJ9JvKZUf7lg/BUjXA/ih
X-Gm-Gg: ATEYQzx8FJpuRBJ+splGPX7b5EREEIRoSX2BLxFsDnWqBQfUhJV0CQIMWMzRzMCrHn6
	EE56ya0RJPMAy4n1mQoW7U536ZRm4c2OWkZ54TCx9dR2/LuCWZpe+TgVZhGW1LQGdLQ3kXWyyO6
	gb3v3DcTDyYZ3nDYZeQY7XrQ/xrBZo6JWMEnZ7hgiKrv9DnU4o+Ib2RhIt0Az2vwWI/HThIZZRa
	iuim/BdYvTjpeIUoIi3x3S7kI0BWwWVItVN/sSSfZUm5Bh/Ou3vGA7zWIZze3uoaYjHQTcz2drW
	/wDAV1YTivSPj3uxGheVQA34WRwq+ccsmf8+BdBA/h2gibuACoDvRxTOnUZ0/La5skPTj/El/ss
	jZBN3+RW6uFmoOVx5YWdneHfumGL4dE9/yiROwXu0j+DA6a8eT1bjPFHK79L1P68z0EqFlwzG/X
	mCfjyDtfGoOIpfGmYNJ7sxfRmw2tYiOg29uu8UNHw17xdssWxVR4Jz79SpGRRiNRZe
X-Received: by 2002:a05:600c:34ca:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-48715f0369fmr78201225e9.0.1774478421934;
        Wed, 25 Mar 2026 15:40:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487208ca5b0sm5779385e9.2.2026.03.25.15.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:40:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:40:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325224018.34714c6e@pumpkin>
In-Reply-To: <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271774-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: 7A8A632D23E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 21:37:59 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 24, 2026 at 03:13:08PM -0700, Pawan Gupta wrote:
...
> > Although call to clear_bhb_loop() will be inserted at the end of the BPF
> > program before it returns, I am not sure if it is safe to assume that
> > trashing registers in the path clear_bhb_loop() -> __clear_bhb_loop() is
> > okay? Especially, when we don't know what code compiler generated for
> > clear_bhb_loop(). BPF experts would know better?  
> 
> The compiler would preserve the regs. If you write it in asm and you adhere to
> the C ABI, you could preserve them too. Shouldn't be too many.

The BPF code that calls it doesn't use the C ABI - it just puts
a call instruction in the code it generates.
Hence all registers must be preserved.

	David

> 
> Thx.
> 
> 


