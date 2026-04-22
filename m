Return-Path: <netdev+bounces-280508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGMuCaT56GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D8B448C81
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD3530511A1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023543806C4;
	Wed, 22 Apr 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB8ohsHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F49381AF9
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875876; cv=pass; b=l5isgQ7x/zg7OblCQjMBuqZMeUkibF0rXMQ3HDStbvPY9zpfkyCrfgRQeLG9im9VuCo/w0iKyDujBnH3ha2IF57tSAu+K/FB4i8AiJ/oI2wQx5SvjSMUwR3z7sq+jAg3XIcabOmcv7Be3AFxo1ZaxpAspNIcD8TB8G4kihnlmkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875876; c=relaxed/simple;
	bh=rGjuzTnqffiAxIUz5jJ763+/vcX4tKbZXHk/NyqMxzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYAftsdt+P6SgrO9pGfCJpRiRYPf0/oN3GqCSK5CJBRNxG9lU6wCApIXNFa1EP4jsZYZ326KvtWpZgX/qV9fBXQOuxxCDB33ZcylGnOU9wIO86FDiOgPzWyoE8tWWAApnToaGpTLHEdtcCTHDMkd+vcVqDYnSOPUAEa1Wm08AKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB8ohsHb; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so9089910eec.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776875874; cv=none;
        d=google.com; s=arc-20240605;
        b=VCSjNCpdpP5evlRFYVSWsDXvl6tTwBUh31gRL6qTOL0RVU3W9s46eTqsnbTjBLAnYN
         fpBlrBgDOBEQWEagNMoRLkGyeeJWfTw+8rRXVyTd7jpL8K6mx/4Xj0dMNBUEt+tG6Zy0
         YTbVSb+l5UUQH13s1ChZvhNQ05eX6CnKWwI8W/07nL+4vlyEwaEAnQ6C1DH63SI0JidM
         6vwZnC1LdhSH5olMGvx9NfYJZPr5Uvu1zgSuakWK9abV/NGdbLgCDI5SDhwvkHkZFD+p
         FhFtMkELOIFIIJVe9xuoh806TKy0BzXzy3lMDsFnUMMPdDKOR7sGkqUnsvNkqeOB/+di
         AbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        fh=eEghWXaFewbhntCI1OlNuu2xOOPC8RIe6OmYbmnxAVs=;
        b=Wd0HyEjfrHUF1WsxUIHpr9kMTz6fAg/VsHzOMyQ7cjg2VJc8P0HsFZEBPVrnFWASMN
         p0i0CknmDZFLrVixwq5E8reM/sucb9g+srH53h1HNf5P8JFBE035kDWk1LqMCAYNMY0Y
         SiG5+Sfdb4YrjbUHEeDNB658/7jJXoH6CZX6tJV1TMlW2IzxiapybNFZmGa9lys5wRSN
         YsuW/Sqd2kvr+TejTcojjqogOQ4g717AacakjpAb4/G0p7TTikVkURhhudWX6T4YYK9/
         d6cObQn85A/0+kYsxKD9XyM4ZXWFd310RsHwKagtx6dOqe718IAyTJ6v9ga2XXNZGKPm
         O+jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875874; x=1777480674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        b=ZB8ohsHb3jpCaMzUxCzcMUOPdRWxPYzHwoAUUlUt8ZEJhLqQ9CNvuhS1GX3VfjSavR
         TfYcxGcO+Jxw/WkwHJjgciam+uVpnlDzTE7ZoJLTZ6uOiHNd1tLVTWa4ark8Ro1vsTH1
         yEk9LLAWPoZmDTuB67KU4MBcWbiLaFBNKXnq0V6Ojg+oDQWWnPlFVa5GG7FrokNMsA4J
         UhR4e8lXsKFuY8Y1OE5IOdvQkNhIdRSGVeqib7/guhK7T8k7b21TU1q6j+PxsfzFQCKn
         ELUbpdlapQMSCM7EyXtWqGwCjUKH0474+M2ADdm6UUBoIO7apI/Nt2zYxtU/c3Hw+Few
         x/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875874; x=1777480674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        b=h/7/p/kM2MT3K15+a/NQYzA5eki2i7x3ye+MTPuauP4c0qjrP8azPgJH2gvnizPAe+
         MdEgkOEuVX89U+kK/cZmOj1Vj18/vQxbDTQBUGcGKxgVqkam7UOKyOnc8gsTRKLAW0tv
         EhPaIHDLpZvPB9PxzUnPFIoKADhSRLsao5TzshCHYK714cyVCblIgMWytyDU5WN482c3
         cccn3lNWJYDr+nBuESWtvF8nq2hgd89Hwr0NvhpMdVNURzQ7Q7wqMtBs43HEiyNS78ZR
         ihgyxe7dvLBDMHCpggO/Y/+UWqDDIsmAVB0QFI0q39QAFXG9Or/dLF/vPfdugY9C/bcj
         +HpA==
X-Forwarded-Encrypted: i=1; AFNElJ+QVz69eN0fIBf9DJ0Yiat0h9e6kqT8idnYX/YcMZt1bfhE2x/S/E8hCuTVd4yrxJuPl9WKQk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LZD4ZAann8/18SDbW+j4ox9YUIFKT5j7YWqTLJfZ4U8iwIfi
	MEFmhF5cSo4g1KgAoqs6fU6BnjvScMov7Wm66/KnDtQQpq8ftEjJQzpTEfJlHFUcq+rBPDK3bB3
	xpjJn7f8b8jpyfyJe5t+m+rY9rCGOxao=
X-Gm-Gg: AeBDies0LMtUlYpAyMeErppWt3aRVVH+WgI/2xmaIzS78F/LmOqNfqlxekiCFcB3J/c
	Ot8PD9s9KCyPII+ZvgjiFyneeISaHkhnE95SNKY/SI76i67jr4nHybtJOdPPdiZnWpcat5ePHt+
	d1PR2ElEafZ2n3qEMy07j8yzHMszmq6tEZN/gxj05em4oO9owYfRlz8jFkBzm6Fl+Bg93+cfRKB
	25m3WINk8KT0bOtEvHTb+m+RyQXFgaqViQMyKgZdgSiLapdQ4/fTWpW3ZSjq3Xr9RYgwjWEKoj9
	sOCzOACIEayk4S2WFg==
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2e47873bd2cmr13631932eec.17.1776875873645; Wed, 22 Apr 2026
 09:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
In-Reply-To: <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 00:37:07 +0800
X-Gm-Features: AQROBzCJb-hsse55EN9VHp2l2OXgryyt-OS9eWVzC4SgEK6a_JBN4N7SWbH5hI4
Message-ID: <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280508-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 93D8B448C81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Wed, 22 Apr 2026 11:36:50 +0800
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is
> > lost entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
>
> What if we relax the restriction a bit? For example, refuse to configure

As to the bug itself, yes, It only affects the unaligned mode.

I wonder if we can support this after someone requires us to support
32-bit arch and use it in the real world, then we can use the previous
patch to complete the full support (which doesn't harm the path on
64-bit arch).

The code looks like this based on your suggestion. Just for the record.
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 58da2f4f4397..03417b04592f 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
struct xdp_umem_reg *mr)
if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
return -EINVAL;
+ if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
+ return -EOPNOTSUPP;
+
if (!unaligned_chunks && !is_power_of_2(chunk_size))
return -EINVAL;

Actually I'm fine with either of them. Right now I'm not so sure which
direction this patch should take :)

Thanks,
Jason

> an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
> under CONFIG_32_BIT like it was done in Page Pool:
>
> skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL);
>
> #ifdef CONFIG_32BIT
> if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) !=3D addr)
>         // WARN_ONCE or whatever + error path
> #endif
>
> I never used XSk on a 32-bit arch, but back when I was working on 32-bit
> MIPS 1G routers, I wanted to add native XSk support to the Eth driver.
> Sure, just for fun, now that we have cheap AArch64 and other 64-bit
> embedded chips, 32-bit embedded networking SoCs are almost dead, but
> OTOH, as you can see, other subsystems like PP still try to support 32 bi=
t.
> Especially given that this issue applies to only to the skb XSk path,
> not native in-driver implementations.
>
> >
> > Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> > strictly stop supporting it at compile time.
> >
> > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.ker=
nel.org/
> > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor numbe=
r")
> > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> > index 71af2febe72a..819aa5795f50 100644
> > --- a/net/xdp/Kconfig
> > +++ b/net/xdp/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config XDP_SOCKETS
> >       bool "XDP sockets"
> > -     depends on BPF_SYSCALL
> > +     depends on BPF_SYSCALL && 64BIT
> >       default n
> >       help
> >         XDP sockets allows a channel between XDP programs and
>
> Thanks,
> Olek

