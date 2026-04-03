Return-Path: <netdev+bounces-275292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFW3HN9P0Gnr6AYAu9opvQ
	(envelope-from <netdev+bounces-275292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA1399174
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F5FD301DC21
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F039098A;
	Fri,  3 Apr 2026 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPanP8/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017F38A72F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259611; cv=pass; b=Wy5emZkXdrxvQ3d2tPCxget7w1dkW6idXIRlTTYJMFp5BQPf1xPRxWbzsrpDMl3CeBrQKMmjBG4wl/cRAqXvtepvzDjv30M2aOf96kV+RxIlkpa9+G9fq3L22yCp1QfTOoIpAfATajlg1USEL/0UzhdIPXbdxh23oMHAKRM+kfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259611; c=relaxed/simple;
	bh=HcrCXVEhPGMRQ1VVj2TU6WqtVF29jKazA7i8frKk+vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXRjSLOKkuqdUxMT6VV3K5btAun180+vattiGBlgA0uga398r9hecfS8Jyu+bTT77KJxMqMIGfVAet+JcS+PLfXNEdrFi0tradD2ms1zJjT3geNvcHKSZ6FIjbUVVQe3Qj1wQ/Meuw+2wqC3f+nMrM2JXosVzIh5fZlDi+5BIG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPanP8/W; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso12164a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775259608; cv=none;
        d=google.com; s=arc-20240605;
        b=hgJ4my+2ljwljmmhNnT2lpWDxknRtjw2qU8CcbFM0GQwFaxqXjVvDWZ5Db6XeM6pi6
         JPuiOqcAF0AOZJY9XARREvbL2XQJgsDhBHUW8yyvkZ4sIivQ8z1e94F5OYX3R5G4+Xg1
         8eXsqflL85fR7ypGaP6Gn0rL+mCVCRTKBc0lnWPVn67a+Dta8CWyRCPK4bQRi3JDkVC/
         R2oO239f8F8KLvk6qPpdge3MVmZjT7jubPvJsr7cUAbxWmOCEzSfi6JDAfpj8G4uWlUD
         7hWvS6B+/6KGMAf6qCqaiD0GzhIC9y2eP0qpBpnRs9+6+WLmO96ok7LzR91DUzvZ39tT
         ZiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        fh=IthdQietEMWqe7Xk95WffFVwFsOzzMzuY8hkQPJA9qI=;
        b=ZfzVTKzx1fURzyyPTWh+XfJXYKpu2zOCIqbbbhw6Vx2AUXFewexQQUmyHPa3QCUdyt
         A2h24gsHVD/sAoKMhiHXy7IP8tcsnDMRbf6HHTCm4cp4H4IxmPqZMmTA+2m3Q3RH1Tj/
         X4Z4owmeMsdp8iuEu6Xt4+f+GueuCg+vQ8F6Xp77kdILwh1KVflYd75ol1mIzfkPn7jR
         jmk1kI1ErE8EHBfksqPDZ1BljtBBV6MN4ePKb7y6nG6kplTX3mhmONJyJ1y4lrhl/FWz
         KsUObhwsX9+yEiJhEFzKEoBh3abL+t4p1ND44JVk2RIzDP+Tpc4sG1UO3HVagOuANunX
         /eBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775259608; x=1775864408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        b=tPanP8/Wku52brNPPJwPSZ7ayet4DtoZHU8ZMSUVvGWK4hbJ2OtYnX/WzSppIgy3Kb
         3v9I0XshJpQT0WvAU884LYUDA9Jk8RhvCfWUX+WDHPg6RedVYkHYGULMlSJn0/7swctc
         ogwj2rlrk16nZK5TZmRc4h/NeipJ3+xUF7FuUxQ9K2sa8R4CG1QaAbkryFPosDChlvpY
         /F6RI9WJPvIVYmPsuvGXsJDiMNLkCAf0A84C6eamnhBohLUwJ5uMqSXssJBxjYDMWxTO
         igSkphxX1OBLfajl6P53c0eWv6T+D7f+1e7FcCQJZGxD4xl4XRCDvzNBsBpBtBak0nVu
         q+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259608; x=1775864408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcQ7pBBGQdT00MFQFDOu6XZRzM8maojAqkD2FxkveKM=;
        b=kdTWq4OpiO2ZodRHdbQDfdzlllPOv3qBXSw7KSu/gmQtyFScFJryAqrjeTvH4cCcj/
         QDYUEFp+++TAAviC8n5rnQIeVZ5HZiGP/eWV9dyB416/EuDKsTHQaqyBVf3//T4D6SGT
         MBKeQOUSBwG/gRqeesuO+23dcrOM6x4/L/bZemzY0d9F6PmoYBPdSTMxOdlT543nZ0Qg
         MSxKW6MxFg0gnkT4TkURQJdv/UsyrqL35PucflvRjjtBBaAInf5VEasn/Zbyh2riuxxP
         ykH2XRAHz/FkQUtFcCxxZWqWWio5Hf5KlLWsnqq9wjA97g0Z2nKFSpIIUJC72fzjf2iV
         ebAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMVs5DsrC4KeLziwO496AUF8AhtOpQOfru9UOjl6BUacBzxhLKXFujudiRgRPKhjVSHkzacpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oo/b/Ul4//6YKguo3iM+W/ZKzzn85QtCBEmH+jU27PvRYds3
	u0q6ghZe97wME+H0U0twpzDBuKr21ILY2b8B3uZ424CN9PRaRLHkScLa6Pp07vzMjnLR5qG229g
	SITQIRVivE/k3AHNmGvPMWjvRs8Q17HhXQuCzBiF/
X-Gm-Gg: AeBDiesAvhMwZEKXDYxOmlJ+hlhcCorcp5j9dacJmAZqpkiFoM3nC0r3abAKb3PbOAH
	rYsypbTHui2IIihYugXRL3OAt6M6aRvugzxrnrpCiSITzhnBXLLXCRgZnCwo7XkvCAIxPficze+
	eEfYEOPpdsrV8iBUBpsuHYFw4GzUq5IIbLzyXuj5hR5D7gfC5ReHBQb1S0ngtxDK9vdY+Q40tVX
	jFOuzw88uajzPxmryPToH7okWC3ZebcYsQ/nqtoxaDxhZp/O+RrTqDl4dhruozhxgg+7wf696Xa
	rTyJyHzdQ6IHqVZdLQ==
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr57100a12.8.1775259607451; Fri, 03 Apr 2026
 16:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com> <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
In-Reply-To: <20260403233329.fb2ppifgwm3um6ny@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 16:39:54 -0700
X-Gm-Features: AQROBzBwB-MmiVC9qntaiDO7zONP8-AQ5DjQ5a_dZ86oZYEi-UAJgB7XA5W8Af0
Message-ID: <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275292-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E6BA1399174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 4:33=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 04:22:28PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 4:16=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 02:59:33PM -0700, Jim Mattson wrote:
> > > > On Fri, Apr 3, 2026 at 2:34=E2=80=AFPM Pawan Gupta
> > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > > > > > On Fri, Apr 3, 2026 at 11:52=E2=80=AFAM Pawan Gupta
> > > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > > > > > On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
> > > > > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > > > > >
> > > > > > > > > As a mitigation for BHI, clear_bhb_loop() executes branch=
es that overwrite
> > > > > > > > > the Branch History Buffer (BHB). On Alder Lake and newer =
parts this
> > > > > > > > > sequence is not sufficient because it doesn't clear enoug=
h entries. This
> > > > > > > > > was not an issue because these CPUs use the BHI_DIS_S har=
dware mitigation
> > > > > > > > > in the kernel.
> > > > > > > > >
> > > > > > > > > Now with VMSCAPE (BHI variant) it is also required to iso=
late branch
> > > > > > > > > history between guests and userspace. Since BHI_DIS_S onl=
y protects the
> > > > > > > > > kernel, the newer CPUs also use IBPB.
> > > > > > > > >
> > > > > > > > > A cheaper alternative to the current IBPB mitigation is c=
lear_bhb_loop().
> > > > > > > > > But it currently does not clear enough BHB entries to be =
effective on newer
> > > > > > > > > CPUs with larger BHB. At boot, dynamically set the loop c=
ount of
> > > > > > > > > clear_bhb_loop() such that it is effective on newer CPUs =
too. Use the
> > > > > > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropria=
te loop count.
> > > > > > > > >
> > > > > > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel=
.com>
> > > > > > > > > ---
> > > > > > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > > > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > > > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > > > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/e=
ntry_64.S
> > > > > > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > > > > > --- a/arch/x86/entry/entry_64.S
> > > > > > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > > > >         ANNOTATE_NOENDBR
> > > > > > > > >         push    %rbp
> > > > > > > > >         mov     %rsp, %rbp
> > > > > > > > > -       movl    $5, %ecx
> > > > > > > > > +
> > > > > > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > > > > > +
> > > > > > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > > > > > >         call    1f
> > > > > > > > >         jmp     5f
> > > > > > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > > > > >          * This should be ideally be: .skip 32 - (.Lret2 =
- 2f), 0xcc
> > > > > > > > >          * but some Clang versions (e.g. 18) don't like t=
his.
> > > > > > > > >          */
> > > > > > > > > -       .skip 32 - 18, 0xcc
> > > > > > > > > -2:     movl    $5, %eax
> > > > > > > > > +       .skip 32 - 20, 0xcc
> > > > > > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > > > > > >  3:     jmp     4f
> > > > > > > > >         nop
> > > > > > > > >  4:     sub     $1, %eax
> > > > > > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/=
x86/include/asm/nospec-branch.h
> > > > > > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_cu=
rrent);
> > > > > > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > > > > > >  extern u64 spec_ctrl_current(void);
> > > > > > > > >
> > > > > > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * With retpoline, we must use IBRS to restrict branch p=
rediction
> > > > > > > > >   * before calling into firmware.
> > > > > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel=
/cpu/bugs.c
> > > > > > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > > > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_in=
it =3D
> > > > > > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_M=
ITIGATION_AUTO : BHI_MITIGATION_OFF;
> > > > > > > > >
> > > > > > > > > +/* Default to short BHB sequence values */
> > > > > > > > > +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> > > > > > > > > +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> > > > > > > > > +
> > > > > > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > > > > > >  {
> > > > > > > > >         if (!str)
> > > > > > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations=
(void)
> > > > > > > > >                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGA=
TIONS_MASK;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > +       /*
> > > > > > > > > +        * Switch to long BHB clear sequence on newer CPU=
s (with BHI_CTRL
> > > > > > > > > +        * support), see Intel's BHI guidance.
> > > > > > > > > +        */
> > > > > > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > > > > > +               bhb_seq_outer_loop =3D 12;
> > > > > > > > > +               bhb_seq_inner_loop =3D 7;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > >
> > > > > > > > How does this work for VMs in a heterogeneous migration poo=
l that
> > > > > > > > spans the Alder Lake boundary? They can't advertise BHI_CTR=
L, because
> > > > > > > > it isn't available on all hosts in the migration pool, but =
they need
> > > > > > > > the long sequence when running on Alder Lake or newer.
> > > > > > >
> > > > > > > As we discussed elsewhere, support for migration pool is much=
 more
> > > > > > > involved. It should be dealt in a separate QEMU/KVM focused s=
eries.
> > > > > > >
> > > > > > > A quickfix could be adding support for spectre_bhi=3Dlong tha=
t guests in a
> > > > > > > migration pool can use?
> > > > > >
> > > > > > The simplest solution is to add "|
> > > > > > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition a=
bove.
> > > > > > If that is unacceptable for the performance of pre-Alder Lake
> > > > >
> > > > > Yes, that would be unnecessary overhead.
> > > > >
> > > > > > migration pools, you could define a CPUID or MSR bit that says
> > > > > > explicitly, "long BHB flush sequence needed," rather than tryin=
g to
> > > > > > intuit that property from the presence of BHI_CTRL. Like
> > > > > > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only b=
e set
> > > > > > by a hypervisor.
> > > > >
> > > > > I will think about this more.
> > > > >
> > > > > > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION an=
d
> > > > > > friends, unless there is a major guest OS out there that relies=
 on
> > > > > > them.
> > > > >
> > > > > If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspac=
e VMM is
> > > > > in the best position to decide whether a guest needs
> > > > > virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM c=
an get
> > > > > BHI_DIS_S for the guests that are in migration pool?
> > > >
> > > > That is not possible today, since KVM does not implement Intel's
> > > > IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTR=
L
> > > > to the guest after the first non-zero write to the guest's MSR.
> > >
> > > Yes, KVM doesn't support it yet. But, adding that support to give mor=
e
> > > control to userspace VMM helps this case, and probably many other in
> > > the future.
> >
> > But didn't you tell me that Windows doesn't want the hypervisor to set
> > BHI_DIS_S behind their back?
>
> Since cloud providers have greater control over userspace, the decision t=
o
> use BHI_DIS_S or not can be left to them. KVM would simply follow what it
> is asked to do by the userspace.

I feel like we've gone over this before, but if userspace tells KVM
not to enable BHI_DIS_S, how do we inform Windows that it needs to do
the longer clearing sequence, despite the fact that the virtual CPU is
masquerading as Ice Lake?

I don't think the virtual mitigation MSRs address that issue.

> > > I will check with Chao if he can prepare the next version of virtual
> > > SPEC_CTRL series (leaving out virtual mitigation MSRs).
> >
> > Excellent.

