Return-Path: <netdev+bounces-275235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOzoOGU40GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:00:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B43989B2
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B9430060B5
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86F3932E2;
	Fri,  3 Apr 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq99ap1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352C2E8B6B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253590; cv=pass; b=kSfUg2ME0ROtWoijQ0oYs0uLLJav6hqojDCC9SNbMgLsvMr/e+gDVu9bZImqJsN5bTidygZHvnQ33xbId7gCrdrs4iRfgB1DFL3WglSs1WBubs0xglk94VgCJyPUb3fmeliuKqj+V+jS72r0SpEdluewOxgFhAPmOSxdmy43d94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253590; c=relaxed/simple;
	bh=OuHsJ0N8U4o8AF+Mf4uPjGJj7uKjFRFAftozElvC01g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srhAPVzBhWjWllcnTUxdZ7Fjm1k2zyD41w5AsZ1vkEYh4pS3LBe3vXM5zI8Q2F1g5hGuBVOhVg28M+bIA+KgFBZhn43Xk/kJEh32JR2Q/w03jlz5y4+yTBhGFmKnXB08T+CQYlyxg2tXqxIjTqTQyXUUPb12QthMWsXzQBt9iCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq99ap1I; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so14829a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253586; cv=none;
        d=google.com; s=arc-20240605;
        b=DPwX7nste5MaIzw2/ncsO5FUUhZDhiDEosykkXOuj8YMWqi7lcgoXf2EozZzG2Olee
         PukzYzFOHzza9upofx/3KDCYkLTGF2aV2dTvsS1syvdVMY9njikqlHoOsvpbok+vkJQt
         7ME85R4eWUAw/TTUzPyltTAiolqee4UYHgJwM3RndJt5UW6jMYBCvtRX0omCoofR8vDg
         Ph/1tjF+aBKiqOol1PskYtd+EmdsUncCa7eB7rSU/hSRFz417T4wPc5JWxC3y+08i8iY
         dmnYu2+lqnQfct04YWbe02OSC3OvY8e93VFVGOK78mnAmyqBcLwL3wiPRUTHhujm/DGV
         s6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        fh=FrpEnDW7V7vWtNNDg5KCnyxsB+86Bx/HK6yb5sTZdLc=;
        b=WEYHkgEaYNl/pRTINMXQ/MjrwdXeyBcKkCSvgAxAhmXz2zNx/wGLDfmmDSkLL3A1DG
         /ZGyYL0YRbsX8HPNZNjab1Nf0IdUQ950NGKyPnfkMs5jxDHWuymztQQHQtLJDbKPQmiI
         yE5dJMp8CWb+YtmF3TT+WaU2be5EsWyQjKeT2djVAyaNYr49cPWREd+cOZU2uOptywiu
         NSmRGvv2ONG2BB0hlxRZ12RcAFEc+F70JL5g2X8A3rP/j9S//T2h3vXuaFjRr5nDUr3H
         TeGMKub4xOGtKp2GzwudUHiFRCuedEiV7/NcxNwxz/GFSnN78hJ6zXl91180zDAeDzKX
         4MGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253586; x=1775858386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        b=iq99ap1IMXDPS1mgKbCPe5XiHYCPZXJf+TtBVlLBYdvWS3eiAXdoD0tQh+depgRoHG
         OLJ3R9z2Ci8iidTbXxWF3VDZdJsstT6s1rxVHUCw3/3/kbUZKFpePN7Vp6HGtB1aEp46
         HoVojKeLTWzRVYkCYtYLqPE+tW7E+EdzExyi3yeJPBBdV8L0sQteHPdegf20/qYoNqEc
         ZnwWetKO2guG6ik3613rRqO2pvoQ9Sl5AiP+cQt5ljvIhINXrmHDe61XPoHM/onVVovv
         WeZ3JtqgWniozHV2YhJTTNZkMZYdnCz+1lJkBXzbdXtG3Raz19dKajak+cNA8C8qoTju
         rCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253586; x=1775858386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4GkFSa2jrZzgbz/gqh1xwGH9rJ9K7aJcMA/+1N4wi5s=;
        b=hgRYTl45yajaKWAPhXDQ1OMPINgV9DH7QCOtujuzNp3LfsvEF4sUfKu8996plM6TX2
         Mt/hClT6OO37bqKHbk4rMEMRB6be/ddaJTGbrFnkf7Ypkk8iWUTWzHcPg+AqaNbtACmq
         hGMRew/kkC8B5qtpntozwhWfGRmx7bFIrIlGb+cM+QabeMk1x51nH4S83FLDG58YLuL2
         bPmayDGODyafgtzxhQkBzaq9cEwuNduewqpn1V26/Qrw2pBoEkREuRjIElXVQuqT43sd
         3fmWSUu/ibxMIM9roUq328xma6mkUEJU7qtYkp+lrEhDe4yfDlUQfLZey4rneEkDfJ4F
         xckQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1XUQQgSKTKCeP/0+Upu/mubmr2kErZoWgX6p9IbfjoUlbHG0Qt+3pDVfVg0XBONJCKJQNmUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZft4PM/CYq5lG2SFnQ0M2g8kEsX0uHX1Bs8YiQCzp45iflhkB
	BC/VnTilV8qiU/3Soo2La2Hwm+gUdbAg3YnmetouAObZH2xaARyIPhy+m6KZiuJ4/C8G8YrFfP7
	kHiImIDLV1fcVpBydp3htX294xGfrd/SmzZppEVO9
X-Gm-Gg: AeBDiesyxaLABJGHnMkIZm81UmpMpOsiR/Iz4bmuDeTP4jZmx44y2BiXYum0GdWPpfb
	+8aah/A8/Br3Gj6szXfxFeXWPDhSw3pPf3A6VnVOFWp6q5aGjpNwpsTMAgKkjPxNrmWsaEAUKER
	CEue+m614mgwBnN3MTbXF7urvricoorzqqusSHpE7q2UFiAiWI+Z03Wawt0Di5zOIbvd/Jn/9cs
	SBqQKrThB8ZqE2X3vQcn3X6SIMwR1fXMEBauv4ZN2MDixL0OGVADSoF/GbSBgGRoEj8p+23s9vF
	t5gni2c=
X-Received: by 2002:aa7:d44a:0:b0:66b:860f:3799 with SMTP id
 4fb4d7f45d1cf-66e43f30587mr33112a12.9.1775253585816; Fri, 03 Apr 2026
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk>
In-Reply-To: <20260403213445.xzb4rxbfbg5un7li@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 14:59:33 -0700
X-Gm-Features: AQROBzD0pWuUvo6f_qTeW8GqTUWeF8BA-rGgdoyaTcRNJP0Ubn7CVfR-kLNpTZ0
Message-ID: <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275235-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: E80B43989B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:34=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > >
> > > > > As a mitigation for BHI, clear_bhb_loop() executes branches that =
overwrite
> > > > > the Branch History Buffer (BHB). On Alder Lake and newer parts th=
is
> > > > > sequence is not sufficient because it doesn't clear enough entrie=
s. This
> > > > > was not an issue because these CPUs use the BHI_DIS_S hardware mi=
tigation
> > > > > in the kernel.
> > > > >
> > > > > Now with VMSCAPE (BHI variant) it is also required to isolate bra=
nch
> > > > > history between guests and userspace. Since BHI_DIS_S only protec=
ts the
> > > > > kernel, the newer CPUs also use IBPB.
> > > > >
> > > > > A cheaper alternative to the current IBPB mitigation is clear_bhb=
_loop().
> > > > > But it currently does not clear enough BHB entries to be effectiv=
e on newer
> > > > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > > > clear_bhb_loop() such that it is effective on newer CPUs too. Use=
 the
> > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop =
count.
> > > > >
> > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.=
S
> > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > --- a/arch/x86/entry/entry_64.S
> > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > >         ANNOTATE_NOENDBR
> > > > >         push    %rbp
> > > > >         mov     %rsp, %rbp
> > > > > -       movl    $5, %ecx
> > > > > +
> > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > +
> > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > >         call    1f
> > > > >         jmp     5f
> > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0=
xcc
> > > > >          * but some Clang versions (e.g. 18) don't like this.
> > > > >          */
> > > > > -       .skip 32 - 18, 0xcc
> > > > > -2:     movl    $5, %eax
> > > > > +       .skip 32 - 20, 0xcc
> > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > >  3:     jmp     4f
> > > > >         nop
> > > > >  4:     sub     $1, %eax
> > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/incl=
ude/asm/nospec-branch.h
> > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > >  extern u64 spec_ctrl_current(void);
> > > > >
> > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > +
> > > > >  /*
> > > > >   * With retpoline, we must use IBRS to restrict branch predictio=
n
> > > > >   * before calling into firmware.
> > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bug=
s.c
> > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
> > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATIO=
N_AUTO : BHI_MITIGATION_OFF;
> > > > >
> > > > > +/* Default to short BHB sequence values */
> > > > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > > > +
> > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > >  {
> > > > >         if (!str)
> > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > > > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MA=
SK;
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * Switch to long BHB clear sequence on newer CPUs (with =
BHI_CTRL
> > > > > +        * support), see Intel's BHI guidance.
> > > > > +        */
> > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > +               bhb_seq_outer_loop =3D 12;
> > > > > +               bhb_seq_inner_loop =3D 7;
> > > > > +       }
> > > > > +
> > > >
> > > > How does this work for VMs in a heterogeneous migration pool that
> > > > spans the Alder Lake boundary? They can't advertise BHI_CTRL, becau=
se
> > > > it isn't available on all hosts in the migration pool, but they nee=
d
> > > > the long sequence when running on Alder Lake or newer.
> > >
> > > As we discussed elsewhere, support for migration pool is much more
> > > involved. It should be dealt in a separate QEMU/KVM focused series.
> > >
> > > A quickfix could be adding support for spectre_bhi=3Dlong that guests=
 in a
> > > migration pool can use?
> >
> > The simplest solution is to add "|
> > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
> > If that is unacceptable for the performance of pre-Alder Lake
>
> Yes, that would be unnecessary overhead.
>
> > migration pools, you could define a CPUID or MSR bit that says
> > explicitly, "long BHB flush sequence needed," rather than trying to
> > intuit that property from the presence of BHI_CTRL. Like
> > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
> > by a hypervisor.
>
> I will think about this more.
>
> > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
> > friends, unless there is a major guest OS out there that relies on
> > them.
>
> If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspace VMM is
> in the best position to decide whether a guest needs
> virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM can get
> BHI_DIS_S for the guests that are in migration pool?

That is not possible today, since KVM does not implement Intel's
IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTRL
to the guest after the first non-zero write to the guest's MSR.

