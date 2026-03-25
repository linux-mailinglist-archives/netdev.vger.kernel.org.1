Return-Path: <netdev+bounces-271687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH5YOm0hxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6532A24E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02BDB300F156
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C4405AC7;
	Wed, 25 Mar 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfl+pF2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F063FD13E
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461075; cv=pass; b=ivUDDVv3x9r+ykghrk+uCsYgYmDKmfQlvrVnIrsF3cSml2AKrE11wfmuwEdFA0pv6TyCfewfZEdlcyln5J60OdoMvQYJqfd8gn6Bmu5uB0H3ZQlVoBUBrjChWQ5l9iJAJqc1utMGteg0GhdZ+pmW+Iwzt9eKm2Py725ZZ7MldpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461075; c=relaxed/simple;
	bh=LfOHx404KK+zENd5k0iKvf2df8c1QUv6Mhd4nnrA2k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBwaJLkNYHJV5YEuxevIJXaON4NaAibN8ReSTa8QYqP4PbtGrI+QyZM86x2ztryzd1n5RwI+8VJDXzIpCZDvTXM3wM+BbWtFiQ3WX2LGOXcIUF2JCq5CjCx1gCHJ1kqcNRk+SHDueAQz8ED342ej2mthZLQ2puxR5UysrJ70I7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfl+pF2P; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so1100a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461073; cv=none;
        d=google.com; s=arc-20240605;
        b=R+J/oU0JSthUVaqkspprCbYnjGxzV0yBLCA9nrnXN3JJzymt82TCiETQhoqpLKM/RN
         Nj59mTidkQadGRcX6PIKooLOIDn5h7moWwtHZiukcbzg9Q3kwWHYl60BSRfTGjZwW3vx
         Gw0ojSIQSRJNkODV2S73NXZp4WTksY7xpxvToDmj5V8NcBD0hEIwdQWwd4iQb81UNOeA
         ns+R5xTpmS7Klj3IAAd+FVELgLPt6qnqaSPwfVyuqCpGHnN+eED5SOHtOf1tnHhl7b17
         VlmD/bgHEpdIi9F67vkClVqatuyph7J4Q616enjuSuHt6uTysPQD/0VRCbjUt1SrGhfN
         4zqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        fh=Sj/vgJIOApQ3a2jGOVAveLFFgG8zDYL52IF3l0t6ejo=;
        b=Lc8zIty0b+bwIoiFOTsFp1ClLH1pphd4QGfavEWH6mQRfD5rLHs86q2VaI9W9dCIjW
         1kmJpWnIzqN0rGvjRbHrBW1Zte/zgM+EIIL8e3eg3884XbZB2ulWzne6RiwOdAnZf2Tl
         GZfUoLPZumoanq5CYWsOjdOVfzk6wgn0UuYGtKm/e17+QpFTk97HRwd7iRR7DP4/skLz
         9JfyNgszmP8m51q10piOEuvGZNbs5kjVPiJrwZ7ikf9DgydFdmk9CadILxwhgiGYx4Yp
         24onjns5aeXeORLC+Th6Sug/941xSS2KQIpiSzEtIPVV06cGeM2ZVtqAQuBFyDRIInYy
         B81w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774461073; x=1775065873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=dfl+pF2PhlOSL6iG9cI/eNprk8ZTDAdh7yZPvVJoiii8dnxP4ffSAoPzCHcSK8l8xi
         g0SjFdBtNEhLpHKEoRwNjhffIvM9las8rkTkHvziL3Mxi5e1lewylzMVKDJptAQt9qKF
         yKSbWprn1zK4Ptp3sa6mcVOjhNuayGDqID88GN2qORDF6SlDDTCZlv83St0i0wMlOVtl
         4jd4feuZ0cdJBu2OlnDgnMkCKcM6u7ks/NDFcfkKmvuBTHbQs5uNFwbD5kNqiIHp9ZOR
         Xlv/jMtwtqM8d7p+tAHHgPxCuUIE1rkRhRt07M/Xbaxrew+Hveo7Vc9Is77855Lr6mhN
         JlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461073; x=1775065873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=YRU4kh9OGurahCLdvuUSzqksxEJ8c2mloIW9yo+L/G0OZh6er9fWPgHnSuzu/ofTtI
         8dIvRxwsod5s7NtuyBaPzumoOUt2uPgK/8ZWNXQEWNBvXe4uljehyCG+OZPYteLlLQCi
         zDoN7zvpLrgjhNotVkp0P9UggJNGLFEhSAt0p4n1W2iV0a1Qe9Fav82xj4YWuu0tX/Vx
         Y+XOItAQ3S2VKSSG+/cOzo9U91s7APttN/DxHHWrVFw0w69bNuSaEiCRcNVPP1lqoaI8
         +w2gECpU07yJHf4uBlWUrawYlv+2Y7cEL5oM7bCDNJDOIJ/vNG9o5dLOT7dnlFUTZpre
         4l5A==
X-Forwarded-Encrypted: i=1; AJvYcCXaIBSNjN0EZUnYr+JoEnpWXI3GNDw1j0zILXUfnxtejEbqn60XULJHhrjGdvl0GsGLDROpdpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+eTal05K7u2+IPcVlLqzDUFhND51j6gG9oyRMSO7ggPOAA1K
	+EmMCroPICZlrktrPv0IWy1aPX7o7TybB25k6vbX/BiCuUqoxV5gsDwX4tn50RPQvQHLPcyHy6Q
	84HNdmL+eKiUioZlFObuXvW+AHYXS0NsKL8JGidH0
X-Gm-Gg: ATEYQzwtSGRwdypJEIEPT1WJGQeh1q4utas6K+xfOFjk0akcvwyLuT6DH4Y5VTnAtD9
	Lr5R/87Czbe2413mSzo4GX5hTn4/txLZRxmXhI59X+P+86Y6GCJlE/YVugknrDt2L2jdcV2Wh48
	3jZXpABgG0F70FBds4e250RKhaB5S67zhxH6hPQ4o7dlrwp959cS8u8pfey5fW3pVQsgRWPb2+K
	nzOby6oY+8zynMkzpyoBQVWH2A0uAVl4hqcJsKcFXdSb+g1OjFHXWhSQGkBKO436XMuVJL6ZEQB
	d9gcJT4=
X-Received: by 2002:a05:6402:1451:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-66ad9575059mr2781a12.7.1774461072029; Wed, 25 Mar 2026 10:51:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
In-Reply-To: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 25 Mar 2026 10:50:58 -0700
X-Gm-Features: AQROBzDwHlJH5nkrozA8k_jCaaxMY2azgH1uzVE_N9olWzdVjI8yDoxoWPHYtxY
Message-ID: <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
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
	TAGGED_FROM(0.00)[bounces-271687-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93F6532A24E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:19=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrit=
es
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> that mitigates BHI in kernel.
>
> BHI variant of VMSCAPE requires isolating branch history between guests a=
nd
> userspace. Note that there is no equivalent hardware control for userspac=
e.
> To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> should execute sufficient number of branches to clear a larger BHB.
>
> Dynamically set the loop count of clear_bhb_loop() such that it is
> effective on newer CPUs too. Use the hardware control enumeration
> X86_FEATURE_BHI_CTRL to select the appropriate loop count.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
>  arch/x86/net/bpf_jit_comp.c |  7 -------
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..8128e00ca73f 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>  SYM_FUNC_START(clear_bhb_loop)
>         ANNOTATE_NOENDBR
>         push    %rbp
> +       /* BPF caller may require %rax to be preserved */
> +       push    %rax

Shouldn't the "push %rax" come after "mov %rsp, %rbp"?

>         mov     %rsp, %rbp
> -       movl    $5, %ecx

