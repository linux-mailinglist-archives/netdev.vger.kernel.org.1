Return-Path: <netdev+bounces-275161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKpNIZcC0Gk/2gYAu9opvQ
	(envelope-from <netdev+bounces-275161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFA3973C5
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D13C303B157
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C8330B0B;
	Fri,  3 Apr 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEkp1iN2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEA27603C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239825; cv=pass; b=Vz+qvIKYZYz077wZ6dpLe0OOdqVeOpD5D2Ex1MSd+vZn9mrDJ04RjA0vLRZXpDmqN6yijA1nU4488TXvRIeExY2Z7I0N4tYaMbdsb+1PLdN8WSCCF/yTAfK2qdR+XjiezyIMcXjJ7S7I7Q2JDJsXtlGDy7TgIS03gt/Qv+jpprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239825; c=relaxed/simple;
	bh=4wnkiw01drsb1mOeb4vmjM1GYWviZqJrvrwioV4gc0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okwsfGAUKIM6y+AfwrbIW5rO0pZFzV5xVXdshdIlQZ1hjUboaET9i3Lc/1gXMEW34Yc/oXQIebxphIGcEsfLrrIegT4grRdhQJpfx2jFRs/LrpnyxII33+HpI1i9LMrngAFSFRW9TZwb93sROV4A8jHCrzxxwk7HF7rzvNoEM8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEkp1iN2; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509062d829dso532541cf.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 11:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775239823; cv=none;
        d=google.com; s=arc-20240605;
        b=F40lsmU9/7OdRaMXAs5mXGPkShgEoP5yfZ6HA9fhgWlMSTUF+dW1wv9T0IAfO+9gIY
         ocxQIK+R0zyNCEnw4hSjbhsv4Iv0j7nhQ+jSrkO4nA+r+t59t0dG1JMHrBsVatWpYJbX
         UcKoxw8LLqsELYkwXbN5xZBu0QM7nZeolp0vo8x4x0w+zJtlUmw9GSijxUMqnKs4cvNH
         RpWjMbay9tuoKMrhheyjOhmFxVTXcOGVJMmvyrPcsfbqmPk7+MjCGxzekU9ZuzqwIiU/
         czIHSUO9ssw2jhlbaZImGKvBg/APW9bTCcLtzWTDXJL2BhArN4roUqwfBN7o6BJy/ThI
         4MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        fh=vTFJU1lByFtNwDux6cIWtYZGx3MLJTKuLQn+wO8XYd0=;
        b=ADGDpouM7GbOe7I2eI9trrQ4K+dBanuH2hDECgYFjzuAGyqDaqaeJqtqEqTYFQo73e
         qWbWUYljcuVk78WCHGXf0N9teL8AqdSlphcmxyALagtCtGlyJ/FCykaoiBBPEEa/ZGTH
         VwSiXzLQL7ca7Uxo0L6ms+2K0XylI52YYaEK5rRrAaEOuKFUxxmlJ81RQlPkj2MEeOXt
         MgQWJhgcyBUKQxJoWVJkjq3lTmjZwa8G6uRzzDcCAz1NhLsn+qSMKzF9q28AQORgvQeP
         6xUwcU2amj7JvHWhnKw7Kzjc5Vihop6daj7pmvUSWVyPcWqgJ378kUbJl0r482hrlPKh
         cCOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775239823; x=1775844623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        b=nEkp1iN2jyvw0DdQVmSe7j7ZXK37mB9ritAXbGlVoKn373Hph2yg3uVQpgw/kAv5jJ
         QfqwJ0yAoPwN4aoHjuvxrhas9rm3bgGR8FtX5CRpF0PMcF5mjX53WBKzLCKp6E/K/tWO
         pCENK0HP63nEta7+7Cu0f0FApSDOdCES8fRsJMVP73Xg+aJDuOkTzDyt70+f+aM2uuyg
         MFCkgM/RZJBsfbYoLIQX36HHq+PsL6gbq31R9pNDbn+6jHXUMYaRyumxYhMyZxnN58AB
         YQV200Wu2HfzoFSbxrj69c+B/9V/cl9pAejHgyFAlAAnrOBa9RrpYqZr/DH2FzJNvws6
         uIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239823; x=1775844623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3wHWIST+Psa9goPXbHlA48/ILBuz3wG5otAi6JiaL0=;
        b=cFZboXFKsshY54IhcgyXOnXIi8f0cTSucH/IYpvxryGvvXVXYN+fwY62oJSFrg9qVF
         NIpEG0TsPCuShm4Sp6ff5fdpFZFgSxR8PW4jYY1xgv8rn5PzSUtXebo2BsoSBJAvq08U
         YK7AMMfUPyllJpteMuYLk/GPclilHbkPp+3DGyKv6vEFd1NcgQCWZWBA7jVYmZ2jA8PZ
         87buZ2kZB6yGF9FScEsRIkZGEPa0dy2zKg4mqaLbDaBNRfaFitStp3+D92Z2b6Mbo5N+
         +6MESSZpzDmZwn2WjqjmHGsItbvNSPUWo4DtvxWdQFLNsEM4DtJDfURe6c4020ag3155
         1WEA==
X-Forwarded-Encrypted: i=1; AJvYcCXwAP9Di/tE6gNGQ9Mc4Bx5SIfzacaDjToGU17z2xINxkOU/yIawTt6aKcor3LH60gdyWXqeTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIeebwcdLjsitkIIOupwVL/nGc4k2DjMMMD0+P85EvWFpq3eF
	Sm7uaV62bKvMszSfyHGrNfN7k9LELaMzSb3GMIW8nitqprC65UpUfWVnPEv+hnneQMTcCh6aqli
	kKqfkA+CzV225oAZL6dz81qEgG6nOktBHuyrtRcqk
X-Gm-Gg: ATEYQzwGcZ+U7JET2snbrYUIW8ZBS4842iI+DictVtKbls+8ZIY88NLWRFPvz+1XoGl
	D0G+2zBxsTIetULBtFJ+xCZ5xDondh1Y3448vQZsVA+IHsk8bxcbA9PTWIKQvAGiS8AaGxeS5uV
	l/+n24JJfvcBkSahfc63oCnK5mRYBLvtdXZlM7nfsbsvhATqIjEVb5QcZ+QlA2GZInBzsHpBBOG
	HrUI7xBTrFnCR08fwg4zhrfhftwzrA3f0BQcgNu2eapytPpKbbuV0+zzXYK8NXG7B6JLHSjHeww
	dvtvzvI=
X-Received: by 2002:a05:622a:5c9b:b0:509:15b6:f69f with SMTP id
 d75a77b69052e-50d63eb1e2amr16678631cf.2.1775239822510; Fri, 03 Apr 2026
 11:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com> <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
In-Reply-To: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 11:10:08 -0700
X-Gm-Features: AQROBzCyrNR-vZ6JoZC9tdSShIePKIwW7s9m_Ym-DzdZtKevzbTyUKkIE4TY_-E
Message-ID: <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275161-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 44EFA3973C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 5:32=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrit=
e
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> in the kernel.
>
> Now with VMSCAPE (BHI variant) it is also required to isolate branch
> history between guests and userspace. Since BHI_DIS_S only protects the
> kernel, the newer CPUs also use IBPB.
>
> A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> But it currently does not clear enough BHB entries to be effective on new=
er
> CPUs with larger BHB. At boot, dynamically set the loop count of
> clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop count.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S            |  8 +++++---
>  arch/x86/include/asm/nospec-branch.h |  2 ++
>  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..bbd4b1c7ec04 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
>         ANNOTATE_NOENDBR
>         push    %rbp
>         mov     %rsp, %rbp
> -       movl    $5, %ecx
> +
> +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> +
>         ANNOTATE_INTRA_FUNCTION_CALL
>         call    1f
>         jmp     5f
> @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
>          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
>          * but some Clang versions (e.g. 18) don't like this.
>          */
> -       .skip 32 - 18, 0xcc
> -2:     movl    $5, %eax
> +       .skip 32 - 20, 0xcc
> +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
>  3:     jmp     4f
>         nop
>  4:     sub     $1, %eax
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/=
nospec-branch.h
> index 70b377fcbc1c..87b83ae7c97f 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>  extern void update_spec_ctrl_cond(u64 val);
>  extern u64 spec_ctrl_current(void);
>
> +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> +
>  /*
>   * With retpoline, we must use IBRS to restrict branch prediction
>   * before calling into firmware.
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e..2cb4a96247d8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
>  static enum bhi_mitigations bhi_mitigation __ro_after_init =3D
>         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO :=
 BHI_MITIGATION_OFF;
>
> +/* Default to short BHB sequence values */
> +u8 bhb_seq_outer_loop __ro_after_init =3D 5;
> +u8 bhb_seq_inner_loop __ro_after_init =3D 5;
> +
>  static int __init spectre_bhi_parse_cmdline(char *str)
>  {
>         if (!str)
> @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
>                 x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
>         }
>
> +       /*
> +        * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
> +        * support), see Intel's BHI guidance.
> +        */
> +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> +               bhb_seq_outer_loop =3D 12;
> +               bhb_seq_inner_loop =3D 7;
> +       }
> +

How does this work for VMs in a heterogeneous migration pool that
spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
it isn't available on all hosts in the migration pool, but they need
the long sequence when running on Alder Lake or newer.

Previously, I considered such a migration pool infeasible, because of
the change in MAXPHYADDR, but I now predict that I will lose that
battle.


>         x86_arch_cap_msr =3D x86_read_arch_cap_msr();
>
>         cpu_print_attack_vectors();
>
> --
> 2.34.1
>
>
>

