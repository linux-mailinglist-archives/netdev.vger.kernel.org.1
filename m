Return-Path: <netdev+bounces-275611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMCbLVrE02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:34:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F53A421C
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C5830CDD44
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B374381B0A;
	Mon,  6 Apr 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeoTYTd5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE63806BE
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485425; cv=pass; b=EKOtATtKMM9potuWyHG74nwapcDymvuv2zFg4baIDRZV3M3TUK0U1+MkOCLFNCxQvwWojYshE4LiPm/nmaTVfYPmIV0cbUrWkjP/n5oqOsBlEDg77PiwcPlFIOECGrXZtiY4Lav+Pf/GpzONYZO4g8/swAKbX3xNHRXHfnsEZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485425; c=relaxed/simple;
	bh=0oshv46xLuQzPLIPdH9A0EvaVpAKTWV20KUKhaXBiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEm7Crs8KWtPY9dA00angU+TsGzFBB+9llrTOve4WvFV9Lqsxg0UXTJHHpgP2Cm44kGIQYsM/MARKmHZgLR+G05erADeWI1sAGthPyRlmCAFDHW4oYxlfYg2A1M7/vwHFbxCOEQEKjz7tWr9PMJ2r0o21WjVCOHTTT+WZ2q8+OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeoTYTd5; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso21593a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485422; cv=none;
        d=google.com; s=arc-20240605;
        b=ew9zcP53hxlLPVIwruf0u8d1QDSPbkFZY/xu0fRYlJL9M8VX7tlZwA+YfY12GnezzM
         wCoiS+F6xxTscBY5ZihsdyfbHXaUBBiP4RC3e7gdU2Ad8o8DGJgD94i/au0KAShP2W5p
         FGsbob+N06E8Oa3Sw29xOXQnvdHOV9xiUIzYrJYVSYmM1IcDG/zMqK0/Gu5VMjucaToS
         W+okQpWyAp5biB3dynUD1lQlQfUDjwvgNSa2i9jlb+A3z/6hu6NaP2OCgPOc9P3Jonpg
         IFaRa2y6do8yeNV7W50vXBa4Wl9KCCnuMomjnqhF2igjTv0CTu/48d2f5pOyK6SbAknC
         CLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        fh=jje992HB1mwLu0u8Ly2JCfMSJQFsn3kg8g1N8eSszSo=;
        b=MR6TwpOXRJnyxXflfi2HJAULoeMi94ZqBmze/HFgN0L9jwFdDgAJu60hU6kA+znxKi
         V/+CaQSJtXd8of8dOayQhOw8LQR/1MXIYlHemvQ71dmURXJUfuWAqBCZ4cURgPrlJO3e
         qIoeOBLo59e2XwWgkjbJdz0/a5Ea6FNONYaMOBg8kH2pb8h05HPQtutYtu0/HbrSSgDQ
         Z7mG8PGWvf4aJu5j42jf75mVlEDcq9mGCv5aQB0RZpOpammQzWAWDsHkTridjWHVlJJq
         vEpyo7k6WKjOeMPWZxfxazagB/Zu+xuY1Uxa2mwT0JcGJk3Gq2PB1Ho4GH4RHYe56nLO
         SONQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775485422; x=1776090222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=XeoTYTd5wSE48JW8kaM0qv3ycrSE9eyeuCIskQwqlA84Ij2A9Xf6y3+NEG1J8FRvIQ
         t6bHLyFisYQzufw6dVUDCO8+C3SQMB2M3WjdVqRea1tMTT1qZ12ijqURJCW5YdMxgO/U
         0iX1FKr+yUwYvrYESOPuxPlwn8N0qKaPS2HrSIaYdfALRFDkTWB6DFUsYj2vLBsIzzdt
         uxeS2dppQQhcpnblsFY4Z4BNYMbYJ5yQSZk4VljRhDO6MTvR1NaxLYhYgKToGQoccHBJ
         uk0Miz7PmU3O0o3kStbFvFjYl8NPwzt9LvF2y0FdSXBEcd20f/V0vddkkgTmfWnI5ZQF
         agZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485422; x=1776090222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=V5EEB0owdobKMTGIAgHO9Dz3jcff8NopIXvO+XgwMeVEKJGw+0sLDnWVT2vesbRekt
         H26f4eyu1LsQ2+CxIGabtG7omNNqk8Oye+ZLpJ1mgUHa36gNyWepNz/L/4YGFB3OtFfW
         7Bc0StbCh4S2eUP8vQjVzlL1eLg9LLPMKaIPqYs7c0Nd/iFtvjh4iecixmR5GIbvOKyL
         c1gx1qWrQm2MKTWIGiWoYwo6Q6afbB0nsbELv0nVJRjuesGxpy8/sAhStAp66j//ycmS
         GhSmxEKXbi690WNSjEjDYlbNv2/TU2rz+wbUQoqsPzyiF533iMmukjFLY7s87VhnVBiz
         f9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu/622w0I8ycKKNMCHFrl4VqCcyR95degqAMmnX4+lpBxilHLXtTMIsF05Bp+Tt5m8hMsgr9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+KwfulKIPrtRetaU5B8NZvL+Km/46wzgYGv6SJkpdv6QBJkO
	HdYGnlrFuWrL4oRDMAdtmyWd1oLiHNGDcEkVcJOX/H49+crPbUSvE5kK+wThNHr4uVCCC+h31N3
	XVye+iH+ACj7o5M/zSC7U7bKFdg+2RVJsbNteTcI2
X-Gm-Gg: AeBDietpAX0cyeF27ibHocXQdTDK2AiQ9fHJ6JwW/CgBgzcmxgU78iYMmbYNTKQ1tRo
	FOsXzSvlLZVdepRtCjmwNX32F/FbZf4m/qGeBUzhTb1mxR9eMyYLfx3xeUQkA+bnQlCs//+5F2r
	xe2C2FklrCjcC9036fcUViSlpMSY4iYqYf26V3irETo2J9aF1QfvOwjw/dzlRQs4UXBFJ06vAmM
	FONJDBizcC/XenVnNrv9aNDWmYV6fn5slCTFX+5wpMYmDMdYySYdTlg3p1IuO91vOGo8DGosWP2
	a3U4PlrLBqrCRtxA9Q==
X-Received: by 2002:aa7:c383:0:b0:66a:7b3d:f43a with SMTP id
 4fb4d7f45d1cf-66e43cdc3d3mr75635a12.1.1775485421479; Mon, 06 Apr 2026
 07:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
In-Reply-To: <20260404034954.t7iapenzvhdpagxp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 07:23:25 -0700
X-Gm-Features: AQROBzBKIPcP_H1GwuJoXUrRRJVPGk443GCqm_WEh0Cd97H-YqzPVn5MR8nDNUU
Message-ID: <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-275611-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 3C6F53A421C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 8:50=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 07:21:02PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > > > Since cloud providers have greater control over userspace, the de=
cision to
> > > > > use BHI_DIS_S or not can be left to them. KVM would simply follow=
 what it
> > > > > is asked to do by the userspace.
> > > >
> > > > I feel like we've gone over this before, but if userspace tells KVM
> > > > not to enable BHI_DIS_S, how do we inform Windows that it needs to =
do
> > > > the longer clearing sequence, despite the fact that the virtual CPU=
 is
> > > > masquerading as Ice Lake?
> > >
> > > IMO, if an OS is allergic to a hardware mitigation, and is also aware=
 that
> > > it is virtualized, it should default to a sw mitigation that works ev=
erywhere.
> >
> > Agreed. So, without any information to the contrary, VMs should assume
> > the long BHB clearing sequence is required.
> >
> > Returning to my earlier comment, the test should be:
> >
> > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
> > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
> > +               bhb_seq_outer_loop =3D 12;
> > +               bhb_seq_inner_loop =3D 7;
> > +       }
>
> To be clear, my comment was for an OS that doesn't want BHI_DIS_S
> under-the-hood with virtual-SPEC_CTRL. Linux doesn't have that problem,
> hardware mitigation on Linux is perfectly okay.

Today, BHI_DIS_S under-the-hood isn't offered. If the hypervisor
doesn't offer the paravirtual mitigation MSRs, the guest must assume
that the hypervisor will not set BHI_DIS_S on its behalf.

> Without virtual-SPEC_CTRL, the problem set is limited to guests that
> migrate accross Alder Lake generation CPUs. As you mentioned the change i=
n
> MAXPHYADDR makes it unlikely.

I have been unable to make a compelling argument for not crossing this
boundary. The only applications I can point to that are broken by the
missing reserved bits are (nested) hypervisors using shadow-paging.
Since both nVMX and nSVM support TDP, the niche cache isn't a concern.
There are compelling business reasons to support seamless migration
from pre-Alder Lake to post-Alder Lake. If you know of any other
applications that will fail with a mis-emulated smaller MAXPHYADDR,
please let me know.

> With virtual-SPEC_CTRL support, guests that fall into the subset that
> migrate inspite of MAXPHYADDR change would also be mitigated. Then, on to=
p
> of hardware mitigation, deploying the long sequence in the guest would
> incur a significant performance penalty for no good reason.

Yes, but the guest needs a way to determine whether the hypervisor
will do what's necessary to make the short sequence effective. And, in
particular, no KVM hypervisor today is prepared to do that.

When running under a hypervisor, without BHI_CTRL and without any
evidence to the contrary, the guest must assume that the longer
sequence is necessary. At the very least, we need a CPUID or MSR bit
that says, "the short BHB clearing sequence is adequate for this
vCPU."

