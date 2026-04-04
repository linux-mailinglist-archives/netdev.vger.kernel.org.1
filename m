Return-Path: <netdev+bounces-275318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHWbEtJ10Gmt7wYAu9opvQ
	(envelope-from <netdev+bounces-275318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 04:22:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4693999E5
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 04:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB9A304C7F4
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B2272E56;
	Sat,  4 Apr 2026 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFZ5CNRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AF224B05
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775269278; cv=pass; b=FNiLFqnjo6zDge6A2+ppAFsY8e9eVkp269UqE/nnBHU4guy7Pj3y7UBdxODGf2aEArsrVrBlxKxPn+BDqnzVVkAbRFSXoCKt/u6D9b9eHweNKoXwM3wkvxr3abtSwmAEM2f5qXM95GbIQoiSaRk7Uo9lXIXZs24GUBcpPzglwLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775269278; c=relaxed/simple;
	bh=QKK3vfyE3OByfcbnSQwgv55pP7KZYyyoT/ZClNEydVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISmBQfNNinRElbkC6qnVt8b8zSAFoz9LpZWkGEgWW1zhLi/mCJ9NnXOIqh/roceBEuA9rqClTx6esFKfibAwpihp3MsU0IgVQTCpID+lC9q3HtorGMhxUdK9P0LGuQENhQCIB3BGPPPHyS1BrrFE6juni5A5FWQP+SSoFfc+vu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFZ5CNRz; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso12922a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 19:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775269275; cv=none;
        d=google.com; s=arc-20240605;
        b=OjWV/DSARGeYeVBLgRuScUjc/sYt2evTdN9GkboCC8o6kUMp+RNITZcxhf2Yt7thYX
         Oqln3qiK3XtSrEqrfQNj/4JEJOvu9l1T6pvOe8pf2tqwyE/SyETVUO12UX0m+wBsfcz2
         v/Bzd8GwDA4WP5kMQ5O70jlKrFkAiLB29L4Z4SffdJDxc4t2Bc0Mqf0BLerCajd9yJhR
         uI2a+dW6BcFulQzKNYZGFyKPlgA1HF1NeZxmctS24eFUTiDrp7JN41jgRk/sj1QlFNgh
         XGxNY5UxqQDOIaVwZkYxJt3a9XYICF+JWzDWbqj3s7QSycEi/Vl3C1j96AjYiMH8zmMh
         elPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        fh=OyVrXFzz4CMs/j+WpegwuSEUu67J2Jn6qEtE82qCz0k=;
        b=PxXIZB/dpHFge2p1cYgfZN7HOvpK1e0Oj4JlgESF9qwDDIzTQvtugYVrC/87Ji9Vhl
         O7vEwDyEZgzBd4lJIuQtmp8ApVGPpHaSQYA9V9W0TdccMnWtl7atZJJYJGVyUsraGHun
         /NRjubmyi9ywYMFAtbMkvXYTwKeOt3DTGicTLGO/CrhWWWowSA9xsqPyLDscBrda8MqD
         zCAkvqqzHOmW10cUARaeulwOHHxjNItL3T48vWKZev/cfwlRBYFsv2cp7vvB9rpUXAX+
         Gv+DG+uat8/uc6x6Al2KxR/ol+J4qvaUBzIFIi3K2fAx31YZR0r1N1cvJn38lo/CT8gA
         9StQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775269275; x=1775874075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=mFZ5CNRzhSAbWxV9qEwfLjfxOOP7DEerPOJ44lwZkjp5L0uoXrsRQWWpXvSSDN4Cwo
         k3qLye3m7czPV1KRG1YwJLNmVknn90IHrEFd+SEYT83REKPPEDEF27RQJWOaYm8vr5Mc
         ARt2SMt9qNbsDFnF1i/h13uotWnRYenua3pnrUqy5O1F/7zThm1qfGM5Fc55s75pWyY0
         q4FZWGS8Xs928aEmrZOHOfrCI6S7QgmhPn0SlpxVv8Cq7JNHWWU4jT8KhFsVsqaifCqU
         8LTPEk17nAIKfFlYGH/o2e/+7vrvBzxwJc9f4mXHfqtkt9b3pw64CSnJbIhLfgpHkhBS
         4zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775269275; x=1775874075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=EXa0ST7MN1rUmHwfT1vys+6xQjzgYZ7wmqcKNNEHX0UM3OHQThbqbLmTXzmHI4smLB
         H4Rt0c2POY0SKRULs3Wgq6hvbCRVdOwYqxNPN7ykPecyDsjd/uUlnqALyzVxnj4Vd5hx
         tzyNwvCEhDS5or9vosfXFfWs2EefRRK/eMANGqNyRE6pn+XyeySxGWPzvEWFUD5VzCyR
         qXJfC1bZT4CFYkmNlJC0Kpj28EXsbSWKxciztkn7kaybhfl42Q6PQZNihXWsOOZvl3Qo
         4fAgs/OIeKY/7ZzxBViGMk/rWec8Lv5hXS8mSLHESrN7HV4/LUsSY0z3cEGabCcmG58v
         acfw==
X-Forwarded-Encrypted: i=1; AJvYcCWDUaI+h5392AhfyTg1XIkWMH952lbKgXOYAK1UIGi7BOWpFaCyrZGsob/B9gJyDXRkt3rwXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4TnoEvpbwa33Fo7yF4eGzDyTn9Nvx8pCbCgLmdBwGoMEeClq
	VDFOv8VJAM5OhW7pJlAXUJbWt37STTQwA9BiYaB9ki+pcgz6HKfW+Q24fhwMdGN6LC4Sb+BXgTr
	5Zqa82XvPN4bQ6AorJCT7hyumMTAxugu42HJBEkEU
X-Gm-Gg: AeBDieur2EM7Bm7ffLkhQnz191um7O7G3zkW7JdLu4ZIk/F3j4qO60EJd04xHgKq2hN
	7j7hARfDmoqLYMQ53VQ2K+pc3mK6uE2mH7pGN/ubib7UwX3zrrwQq3bLgbswFR5DiRNVyDZ/m+z
	x+hCE4YQeuD5vWjLaPiOIcYLPoEgvzYmXtFFfnCDHKXqgqK5N0dJsjlgZcvSBcqy8W9nVE9FcGv
	Jzrrbjl3PE8alXLwpaaOfyqvXKtqgq4lT2acBjsl9rPtyDqW1MZXlV3ZyKrU2/CJ6qVP6jYE/4L
	n84EY1r4XGpYbdkZvw==
X-Received: by 2002:a05:6402:1804:b0:66b:ed69:a85c with SMTP id
 4fb4d7f45d1cf-66e43f22b75mr45332a12.7.1775269275001; Fri, 03 Apr 2026
 19:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
In-Reply-To: <20260404002149.wtayv6a64vzuppgp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 19:21:02 -0700
X-Gm-Features: AQROBzBosyujpEg2ULZMen-BYMNgkEIJxtpk1WSLwb-MqoCqV3Cx2KzliC39bhw
Message-ID: <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AA4693999E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > Since cloud providers have greater control over userspace, the decisi=
on to
> > > use BHI_DIS_S or not can be left to them. KVM would simply follow wha=
t it
> > > is asked to do by the userspace.
> >
> > I feel like we've gone over this before, but if userspace tells KVM
> > not to enable BHI_DIS_S, how do we inform Windows that it needs to do
> > the longer clearing sequence, despite the fact that the virtual CPU is
> > masquerading as Ice Lake?
>
> IMO, if an OS is allergic to a hardware mitigation, and is also aware tha=
t
> it is virtualized, it should default to a sw mitigation that works everyw=
here.

Agreed. So, without any information to the contrary, VMs should assume
the long BHB clearing sequence is required.

Returning to my earlier comment, the test should be:

+       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+               bhb_seq_outer_loop =3D 12;
+               bhb_seq_inner_loop =3D 7;
+       }

