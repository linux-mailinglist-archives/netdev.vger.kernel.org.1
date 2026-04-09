Return-Path: <netdev+bounces-277126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCGiFfEU2GmAXQgAu9opvQ
	(envelope-from <netdev+bounces-277126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:06:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 067873CFC26
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 431A8300D4C0
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A36F42D;
	Thu,  9 Apr 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5q5gE5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69629992A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768812; cv=pass; b=jjWXO2FAf83JC5z7h/ylNGU/2f5x4SPBlU/ExnAokovMLoXMbBXDlxZtV/gyTMwdagPBWbOfTZGgikP4Zfj3ko10nL5McI5sX5COVXjE27hVMZjeArXGu+U4FCLqUTndoZxitRfhR7vqSrKpWxo752usUAkVOSZ6IlwinixMDe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768812; c=relaxed/simple;
	bh=Jh9WA8x2awad3lmAqYVpxS5VOwXt/AnG9yTjUz42fhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4582g+f8xdIhR/Tg7a3AjsWTuqkzhb1VovtUsdIW4VMTUulOiBRvVwZdKL8dO5EkYutf7CK+E/apvUWrlOesdkO4+TEeARwfkJeE4tLkOHGeLoNB9qukTko5ZibJ8GHWFQFiCQi+InIEfWLbFptgsrSFTBWZsYmi37KisxHcfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5q5gE5X; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67070d9ba4dso2770a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775768809; cv=none;
        d=google.com; s=arc-20240605;
        b=Xr9XyeZI5nsLurlJCPhABmnOp5Yfv+x2CGgw8LmfSiY41lSKjjZH6Q1qYB2YyPFeNg
         ombi87+RSv52V1A5ja/c+FV3EkqO+LchooaZjRTYM9YGWPnLg2UpNVTL+7pYdUaKvbRO
         YP19Keww+T9RYVG2DrewlKnFAGhdBap1cc1NMN4bNBeN7fEUf1Umi6BbtvzCo7L6mPm4
         rkKAY21REXPohm1/1FWhpCv2CNl7ds4LQKWR/zTVOpUCmdZxVPtJ9xWdoIyMlg6bKkvr
         5X1lmxOyUIKW/m8rKEI+WZb9qndmDOYQ3Uy0TTlpTwLhcjGlDTT6xph7KeiKBjXQ9aon
         dgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        fh=jvVHjq3sjr4PJXqqp5RyX6RmazEOC/CagJJc0/hXhpI=;
        b=ZB8wp/S0tHF6f9o0mkA8O8LdHOqHRzGKraf4N1rjOEUexrLqoaSzZpfk/AoHN9YJsJ
         7Vl1S1h85O3VOCzHfA6Endlzuk2hA9t7aj2D6AjPIXCHp/urkXb14wd+MMoDepC/bzoX
         xoskVn4W8RSiAXySinzdWIBSKrzksoSBMiFOhclkaH3Uhy24RipGWlbiPREZhTQ1kXyM
         QvAT022JCzrDOShJeNhOpCewpSMFzHNu3tl39HWE0xzObzaufkkCSPYDXfEhhuGJYkAu
         75SGnpTfUfdw3L5KXHVLVXvnjbocLqjqgPWbubuvcyfBWmt+qBS1AKVn7l2AxbxtgEo6
         2Haw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775768809; x=1776373609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        b=N5q5gE5XZJ2yYNIdmYor+kWbrOcd8iEX7Ctpi0F+2Md0qQnWSA1Afc6qFcTrN8C3bQ
         TF5cjdXy1H10yJhuvM49JQQD5ggH4ThQr6ROst0afwNDa5tk9hVE7bQ6YOPqls8O+yG6
         WcmtBfFUXP71se+/R5rvKaRbYDDP3wr8/XvgsNzrzIQUQrD2vtEPUdmJwD8J4ynqSZ/Z
         z28bPGk2F2WEJwUHoPvrl3Bme3bX1jvtfexjmhpFhE1j8zWe0BEO8AvBLugxl+CLDQ5N
         hHOa02rBVavtPIT1buOtLr7Lb297cN9XYXi1s4jDVHWnIv0whud0PZFG+TfBiAAJhZBf
         KpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775768809; x=1776373609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6Io+TbgEInBUXr2ZZvVAjzS0NzLS5bRjm9qTjcDPeU=;
        b=JMGgPCjMJ2cZ2N+yyKbOZC4CF9rNwwniG2Wk8kVmdnIvC4jy7n6e4I4sZ1arQbGzjZ
         XeaSQpLMt9FNo/87cmSLZ4lMmyjr/aOQKVuAjf8EaaunJ16HAdxFvdcNdbNeSXrOzByj
         WH0FHdAjKWSp5jDNbwWjyUXih1QC+kRRvr9nQhXTUa6H2UImDDyAEZk5VZIIiJfOX6f6
         msiFn9N/KkO7UDeg9KjDU7ptcKJOnfFd7UlTz3HNby5ml5uCJbrhI4Rb5uIh1XYbTkcG
         LgitzKai02ryNfdHoysOHpHmMozq2fCeIvtL1iXf4h+6w8sSdkzgd4Ayj0IqaUsuu2St
         6yLw==
X-Forwarded-Encrypted: i=1; AJvYcCVWb4Wfm7qDYndepmpV5vnltQciDvQRaZwozaqDQKuGTPpFTpMTcunQFOspgY44RmmDEZofK+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hDl+I42EeKKF7vbEpekBHRuWsg+hswNrAEBBWzKx83sEHtRx
	nFAZzP9hYmwE9RBDyXf+AEPACc/vha4OTTwDljc+9CM/K0uYjwEdjM44hNu+Gluk6wfB44l7vik
	UXB37aa6U7pThfVDlKDPm16gplvMWhII4viPiz4AB
X-Gm-Gg: AeBDievLKqM9JGN4sx35v/Ge44SH5olnHgB3voyCeP70REKmoJQ6W43rMsh36el/1JB
	uD496lY2cATT2XWgRYEJ7ueIofIGD2TcExaOIoCQABy53D+A3XcIEaHFFZhviqxL9Dv2peFYVqV
	4FIkEf628tL5Mz3KMYrSC0YILU2756Lhoiyi4yxlC6BICmjpXArjP66SrF03Jh8En7layO3s/hS
	DlSiMbLriFKjE8cowvDx4n9lHZ8o04ruOyVk0crhq+AJrIeL5NcS1heGNGIoFJ+BlGelZBLDFMW
	xiFUGMjPlEes95KHwg==
X-Received: by 2002:a05:6402:26cc:b0:664:eadc:7262 with SMTP id
 4fb4d7f45d1cf-6701e2ad1e6mr79997a12.13.1775768808382; Thu, 09 Apr 2026
 14:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk> <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com> <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
 <410df9f6-69ec-483f-9009-0a9b8c9162a9@intel.com>
In-Reply-To: <410df9f6-69ec-483f-9009-0a9b8c9162a9@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 14:06:36 -0700
X-Gm-Features: AQROBzDpN1eCOiQJSVX_bZO_GJCCAd5QpgFXMhi42CoW97OvabZocFA88ATO2hY
Message-ID: <CALMp9eQx3H+n3V3dQh+ZafQZ6uNBjSYk8tZsvG6ffcY43YTrnQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 067873CFC26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 1:36=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/7/26 17:47, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >> On 4/7/26 16:27, Jim Mattson wrote:
> >>> What is your proposed BHI_DIS_S override mechanism, then?
> >> Let me make sure I get this right. The desire is to:
> >>
> >> 1. Have hypervisors lie to guests about the CPU they are running on (f=
or
> >>    the benefit of large/diverse migration pools)
> >> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> >> 3. Have apps in those guests that care about security to opt back in t=
o
> >>    BHI_DIS_S for themselves?
> > I just want guests on heterogeneous migration pools to properly
> > protect themselves from native BHI when running on host kernels at
> > least as far back as Linux v6.6.
> >
> > To that end, I would be satisfied with using the longer BHB clearing
> > sequence when HYPERVISOR is true and BHI_CTRL is false.
>
> If the guests can't get mitigation information from model/family because
> the hypervisor is lying (or may lie), then it's on the hypervisor to
> figure it out.
>
> I'm not sure we want to just assume that all hypervisors are going to
> lie all the time about this.

Without any information, that is exactly what we must assume. There is
precedent for this.

In vulnerable_to_its():

        /*
         * If a VMM did not expose ITS_NO, assume that a guest could
         * be running on a vulnerable hardware or may migrate to such
         * hardware.
         */
        if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
                return true;


In cpu_set_bug_bits():

        /*
         * Intel parts with eIBRS are vulnerable to BHI attacks. Parts with
         * BHI_NO still need to use the BHI mitigation to prevent Intra-mod=
e
         * attacks.  When virtualized, eIBRS could be hidden, assume vulner=
able.
         */
        if (!cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
            (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
             boot_cpu_has(X86_FEATURE_HYPERVISOR)))
                setup_force_cpu_bug(X86_BUG_BHI);

...and...

        if (c->x86_vendor =3D=3D X86_VENDOR_AMD) {
                if (!cpu_has(c, X86_FEATURE_TSA_SQ_NO) ||
                    !cpu_has(c, X86_FEATURE_TSA_L1_NO)) {
                        if (cpu_matches(cpu_vuln_blacklist, TSA) ||
                            /* Enable bug on Zen guests to allow for
live migration. */
                            (cpu_has(c, X86_FEATURE_HYPERVISOR) &&
cpu_has(c, X86_FEATURE_ZEN)))
                                setup_force_cpu_bug(X86_BUG_TSA);
                }
        }


In check_null_seg_clears_base():

        /*
         * CPUID bit above wasn't set. If this kernel is still running
         * as a HV guest, then the HV has decided not to advertize
         * that CPUID bit for whatever reason. For example, one
         * member of the migration pool might be vulnerable. Which
         * means, the bug is present: set the BUG flag and return.
         */
        if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
                set_cpu_bug(c, X86_BUG_NULL_SEG);
                return;
        }

The hypervisor could provide more information so that the guest can
determine when it's safe to use the short sequence, but that's just
icing on the cake. The default, out-of-the-box configuration must be
safe.

