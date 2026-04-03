Return-Path: <netdev+bounces-275204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHRRCHwh0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 758473981B9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7DD3024942
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CB3D6CB3;
	Fri,  3 Apr 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMITC7ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E53D5663
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247573; cv=pass; b=LbW1/hkzMZXphTiTCFxWHve4nJ3zcCjSCdBliNfeBY2G+NMdBApd6Y7ky3Fp9eMjMftGEooUNv5YmSH5qB1P/+GUKm5DX+RgcotA6OqyjHHe5tVZLzcvnm3/9DmiCD2d0RrV1eWCLbnWhedyeMqbZdnAAzIdCLL1LVMt7jO3NZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247573; c=relaxed/simple;
	bh=aWs+wbzB0GD25tebd4FwDmf5Dg3ElXT3opxb3THYiXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVm9Dms+xcLSVW5hsYokYNHV21DBop7ASoJ4uLzj7kfho7HfKY+NsDhXFQ3H3tf0mylgw6WOhw9jGeJh/EebWCSIoyuFa01/PZloAhsh7kOG15dTZw5mQKDeJxz/iPbF6GBdxPyw30/dLujFv8Idm4tVlZjmZv5lMDnQUfAYgBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMITC7ng; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so10425a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775247570; cv=none;
        d=google.com; s=arc-20240605;
        b=jEk9mHThJghXNHkFShvADdaYCwsg4LRJVsbSjcNCT5O6R6+VEnIMxno9PL/E0btl/D
         NDU3h2voQqy8J39C4I5Z413dMXfTTewPnbDvoaY+L0fg+3ErnuhH4MKTqtfZ0UHE0MqY
         yCrgNSnbNTb8o0Vjw7pLe0OWyh/X9HLg+umH9N8R+KHtCM2H5CfnMZ0UWXfR7d7zKHGO
         9XPus9JtOmFUM/OnIpc8ojtvbQW2aiNKQ/FoRamf0uxCaDHlHKGLOAmZ3zVbejtL3PMz
         R0/78qla46NB/bb/XwdDLrSt8HK/Hj4Aag2k+a0HdtcYc9c350U5bETVPLVbFf+GYuQG
         jSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        fh=QnRoE9TblOoBSZJZc6+58Vxvj85UFdjleUwN3hi59Dk=;
        b=kph0ym7ferPlxZYd/VdgLL/Qmfrs18pZtt0P20YS1jB0rJcoRqBbTM5t/Wi1wjyXhx
         5BcRYfkTfhUos3NpAqm60lSF0JzwV3L46/x/DJT6bfBBmu7L4wjGXKNm/T+JX2zWDFu8
         5XgDFsC6mkdcHGMZ448hE0Sb+MT7gjS27qRmbginOey2+v29YjDzhPFhZb/pugNKqM9+
         I7TemMyqUe2R4621EsC54zr6q7yLS+RL77qlREPf0664CxB723X/spjZkxpQBR3qNJge
         cgiQpNaCchQmyC7YkaVSQwlX5eW88t0QB7qX0yZhRSEPZWZ1Ru4CILDpWoeL1FKn3LMt
         WEBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775247570; x=1775852370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        b=lMITC7ngnCxJn7Eoyngp9Eu7a6i11eeqAZgeB/czbkMFntTjkZE9q170y4WUBaN7gq
         7kssQ5e1DV4WdyFB8KfpYhMLOkDt6XeWzwmY6N0gZ9UUmbM5OfL+bdb9JKEnTZilQD4J
         o1bsb/cYoQ/tfXybIMPETAvO3PFBnOtJ9hZ0qlPvOrn/1LMjGhjfFgSc/gHtoHbVSbYX
         XPuWj3zXeTseCbQFGd6If+9VEporzDotAqlzDpFH0x/rYN7Q/KbbHhUZn2CFNp/+3o3z
         81a9Po8PsTgBoiPwZGC9yv5VtOZBN/mIuicvNRDSYJ7aaqYTVzIbLvedrfiTPSt/V5j+
         vfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247570; x=1775852370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9idyuVEhOac6q8zDvEM+VotLSRRsMcPfEh8o3j5eQSY=;
        b=npusTdtQ1eDyjBhxDfEsEwfJ43Oq0yWvOyM6teUHQ+0V/EYDhOxjHT6NBvYKiJkMJ4
         8VkazavRLZLJnjWb4khZ41b8rDmOAcJJvWXoHdrWIMVx59DfMp17GYcQgYNiFIbO0Wdc
         SSWZt39YNyDQ4byuPiMLEyGp8iRDItNc2m6LRNrDu2JkyKzgETei1dC7CpYk+h4eMtac
         tuxFmWJTLGdTz1T5TF4o9R9adgYEX0NGoRUuNynW6VUFHcC9ALl3Ad2+06o+PoL9sb7p
         P4c7FHvmpJATpX/Ne6HZ/Y5MbkqOz9Jb/DISjKLNrSWdkbqcBd0chjEvl+CSeQactg0N
         Jyzw==
X-Forwarded-Encrypted: i=1; AJvYcCULo5tn7mCEQQlYhxG0AXPgOrVt/dTGPP6hFJ6PVWDP7EnRDoEefOqIftnJZByx1bGh6KG7cP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qtJpXDMH1h/0efFHIIOAsEHRDVyk8lPEmleaEkqDeHKvpf64
	vJE7YDgZjfYzvJUl2zyGSPw7wu5kP6vTBgdp53ZZsPsgNkyXqhdo3YaLIOsiYKFu/NZOf/Km2Vr
	a154S7VQuzKgUFNQ9SSDUnhy89y6Oo2Vyjdvp6Mde
X-Gm-Gg: AeBDievXutWuA0c+wlfnw+O3ahOTueNPs1/BQl0E4n94av1iS51TFTNhqUtIr3xi9i6
	R2IZngp0rCL2cuPr2yuB1cvQe6PfsI9qNtgNeBVIqDGw59GEUdfx7fxWMaWsXBMikB9aSZ+ILd8
	4EJOVRKVzyhf8WWFz0nlBuUDgPB+xgVES5nIJZtziweiEukM82ioCv3La7M4nY3cRE3F+IWLEua
	+phtqbBoyCTPArLhVwkczElrABUjZoCcYHhKAXwNuxV4UOT+pBeODUGlODLQhiY7p4LiU7sqXNA
	jCh8Yj4=
X-Received: by 2002:a05:6402:20d5:10b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-66e432e10demr28487a12.10.1775247569545; Fri, 03 Apr 2026
 13:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk>
In-Reply-To: <20260403185236.sjgetnkha3o3a4d3@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 13:19:17 -0700
X-Gm-Features: AQROBzBN2T9-HOthaRcY0Ldmz0x4J6ZHvMaPV916MYhPQfL9BOlln2WWIsxXzW8
Message-ID: <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275204-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 758473981B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > As a mitigation for BHI, clear_bhb_loop() executes branches that over=
write
> > > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > > sequence is not sufficient because it doesn't clear enough entries. T=
his
> > > was not an issue because these CPUs use the BHI_DIS_S hardware mitiga=
tion
> > > in the kernel.
> > >
> > > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > > history between guests and userspace. Since BHI_DIS_S only protects t=
he
> > > kernel, the newer CPUs also use IBPB.
> > >
> > > A cheaper alternative to the current IBPB mitigation is clear_bhb_loo=
p().
> > > But it currently does not clear enough BHB entries to be effective on=
 newer
> > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop coun=
t.
> > >
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > >         ANNOTATE_NOENDBR
> > >         push    %rbp
> > >         mov     %rsp, %rbp
> > > -       movl    $5, %ecx
> > > +
> > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > +
> > >         ANNOTATE_INTRA_FUNCTION_CALL
> > >         call    1f
> > >         jmp     5f
> > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
> > >          * but some Clang versions (e.g. 18) don't like this.
> > >          */
> > > -       .skip 32 - 18, 0xcc
> > > -2:     movl    $5, %eax
> > > +       .skip 32 - 20, 0xcc
> > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > >  3:     jmp     4f
> > >         nop
> > >  4:     sub     $1, %eax
> > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/=
asm/nospec-branch.h
> > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > >  extern void update_spec_ctrl_cond(u64 val);
> > >  extern u64 spec_ctrl_current(void);
> > >
> > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > +
> > >  /*
> > >   * With retpoline, we must use IBRS to restrict branch prediction
> > >   * before calling into firmware.
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
> > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AU=
TO : BHI_MITIGATION_OFF;
> > >
> > > +/* Default to short BHB sequence values */
> > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > +
> > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > >  {
> > >         if (!str)
> > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
> > >         }
> > >
> > > +       /*
> > > +        * Switch to long BHB clear sequence on newer CPUs (with BHI_=
CTRL
> > > +        * support), see Intel's BHI guidance.
> > > +        */
> > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > +               bhb_seq_outer_loop =3D 12;
> > > +               bhb_seq_inner_loop =3D 7;
> > > +       }
> > > +
> >
> > How does this work for VMs in a heterogeneous migration pool that
> > spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
> > it isn't available on all hosts in the migration pool, but they need
> > the long sequence when running on Alder Lake or newer.
>
> As we discussed elsewhere, support for migration pool is much more
> involved. It should be dealt in a separate QEMU/KVM focused series.
>
> A quickfix could be adding support for spectre_bhi=3Dlong that guests in =
a
> migration pool can use?

The simplest solution is to add "|
cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
If that is unacceptable for the performance of pre-Alder Lake
migration pools, you could define a CPUID or MSR bit that says
explicitly, "long BHB flush sequence needed," rather than trying to
intuit that property from the presence of BHI_CTRL. Like
IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
by a hypervisor.

I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
friends, unless there is a major guest OS out there that relies on
them.

