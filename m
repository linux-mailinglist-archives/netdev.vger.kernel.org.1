Return-Path: <netdev+bounces-280561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L5E9Kstd6WmpYAIAu9opvQ
	(envelope-from <netdev+bounces-280561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286C44BD99
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF48305F812
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7399337110;
	Wed, 22 Apr 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEov8WDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E0280A5B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776901576; cv=pass; b=lz78DmSIs74LAKoNgF95EfZETYHzGClLGt52S6myjRswVfPLcrqSmbFYPP7D00Sx4XGlC1VjBpAcu49GVF9ixGZoQE0bzNQlFtVmCwNHJEejp5k/Ah/N+xP3rTNcIfdD+29QYCnc89j8nGKYuwxoiKwZQM4wKndPpE+UmXYpmiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776901576; c=relaxed/simple;
	bh=r85R57NVW8eSM/NE6sMPR1IjJ29w3fmDxqW/oYNi0ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnN55dadimAcs27Rj7XKSWNz3vj8sPlyta1y8vt8AXijUELW9hWEryi0j4Z9dHdoLuxEe+wCnOx5wxadZZRMEJXQeCMX6wsI67p+0tEbOn8NZbPlFxdASC2Vo35GNfg1CeQjpV4YvzWwPQ2voSZgHJLpsNHglEDeQiEGRtJg1cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEov8WDK; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so8263723e87.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776901573; cv=none;
        d=google.com; s=arc-20240605;
        b=R1tRjucOOp0NH2vRAE760qosisCrg+qWz33BT0m6J5rIlIDKou4N7/iPe7axO0qPg6
         o4ZKtw59ztoBN5naRqtoByQY9561s2BJSr4FMWB/xGFeOYXtJANHzxveJ9M3/YQAffcX
         MvJO+c4ooWZQuQZCycdefBR8OFOUVcmRWYM8POt4gjrWIfphy9/zQUCoe/fl71ThUpMz
         TGQMqeFsiyYzEFs2Uorp25hYueMRSVXebKkjjlFmHQa2JAtKwr95rfZwNC569d0DIa1H
         iwp4KjhmhdKJhOGxt/ZJl5MvF1+3vk3M27EjUUK3VHKBnlAfPg1WEVf1dCQmM4C+n0j1
         cG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        fh=etdBIslC9HzJHxzuDlspvI2iUE2k0njBXSxxDMiR+hA=;
        b=SJFU5btWm26dTG7LtiysSJGVrGWmK/9Dnm1nj1E0xVjV9XVn9wGTDP58HwrZ6LjE9h
         zbiuMwbZe8xDRkmiBMcXLZds5A6j7mMPIKBTFnE3KAEXdkoMLm1YxMgRHsIrGLqPwE6o
         gaQM/R+LqUug7aCKgo9UJ/lI2W2GjANCMks73wPV+VusiyWt+rmO2iZFykmRWf4o5uYW
         QKVDBCfp9RH2l4zLroGen0XBY5u+LpjIDrCBCWc1HqoWbXRxP4WNDd+R0p5elXh9OolX
         WULKq1GXb1w5nYMoLmS3J3a2mTViYbqMeY5x3H09+sJpOkD/S3IZUbqU5gjV5qQSymSW
         h+Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776901573; x=1777506373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        b=LEov8WDKj597klFA7bnqipJ0uFLax7RlRjwccd8yOQDCwp4xFmWBUf8jV3Zll5S13Q
         Dk/QDEozJVBofGP6kJa3rN7MOABT5x1R7rrQ8gANflGPQvuVjt3Fs7IQ+AXNjRhSf1xl
         vwy5GmEbqlM3Vt402SxXSR86FmGR58oZi4raKZwBBa5WR00A/W7nLAiSddSddYrMnqbh
         SZ07wLLNJcdYkvXRJ6MxNFSHKCUj6KSh9k3s/Dnx9jYO/vWwOt8I5aw38bCiWWL8P9ta
         GmDo7FQVRUHC9EZgg4joiWETeinHS5N7VD9O04mKxLQD3Tr08JFHW21547aDkQ3hq53W
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776901573; x=1777506373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        b=J0Ra/Boz2/GkfIH43f8t/d6bRBz6s7fo+s7C/+r7XwOTpTsuQhguijkrCKx8+rDZym
         G+0eI5Pck4oLs7+OKQX6h9paDnLtaL6+kO6x4JL7Rdku5tK3FMBAdYpFFniAKE0VTaV+
         9TN37+kNqWMYTqtMTS2tMVu1QA9s7NqMLphe6EtLHZ6MqOp3UgBfEnWclxip9TGyKQNc
         SiuDFo9Z3CmLBtfcVSnfOECUBgC3EGc4JPq0c7hLqGMTyl/kG0MebTyQYJxitQyuvJKY
         /Z2U/5YV2mNaN40OHVQF4QsO+h7ivG3Lsn8D1pUVB6icwAQdA075f7zYhFxKGvhKpdUW
         DYUw==
X-Forwarded-Encrypted: i=1; AFNElJ/etSIOt4I/kx9VO3gwf4ZnSJhguRKzjT+6z83LtsCqEEPMp3KjCLaAFHfxTw94Wsq1NnSh2c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40t4guuItP01HwOsubL/PARxCEpzCnAgg7DrZU/NqkKSSr1pW
	GgUVjCaNVtWP/OhIJWznKdJk7wguVI+kaOHqkM9fgePtYz3OBp6PwYfLL5cwIZzJ40pYPkJEx+o
	UYUg/ym43MxCfqBgmgYC1eR3ogFp0IME=
X-Gm-Gg: AeBDiesm701yx0Wxlmr0mkjL8ZotPm1HM2rT0U1H9d/LvBbG663wA2SMfCLt7vi8eNx
	5ValAxbpnZAiUbeB95k/8NZCbZtHa+gCtDEoUAmUFHPANYJdc7hNxYL86zFsEHxmOpwo1dM+syV
	7P4OFC4PfheN597wS3W0AlTtqpoDydSSljsJgJ3n8NMPvNGyMVfT4iC6SPPdytwDV01ZHsQrgpQ
	K5u2NEkB7r11iAxoWfpw1jOjOzOPRqceM4i591h6mhtj2XoG+NFMtigLClcdZ6jjHqN3f7ovMKa
	qShzSabvktczRlVrfA==
X-Received: by 2002:a05:6512:3b08:b0:5a2:afbe:4aaf with SMTP id
 2adb3069b0e04-5a4172f63eamr7151436e87.21.1776901573109; Wed, 22 Apr 2026
 16:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <20260422212741.50deeb06@pumpkin>
In-Reply-To: <20260422212741.50deeb06@pumpkin>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 07:45:35 +0800
X-Gm-Features: AQROBzDDuAl2OSnLbOvFaE-XlTSEU46HN_-vyDfaJxynGIzlHMZSeJrJj2JfxfA
Message-ID: <CAL+tcoCMrtYR=938roeQ-q4j8LKcsUYxm_qSTPLCdYjBhD_urg@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: David Laight <david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280561-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 1286C44BD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 4:27=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 22 Apr 2026 11:36:50 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
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
> I had a look at how this is used.
>
> I suspect that XSK_UNALIGNED_BUF_OFFSET_SHIFT can just be made smaller.
> The 'addr' isn't really a normal address of any kind, it is a really
> and offset into an array made up of pages of memory.
> The actual address (kernel virtual of dma) is generated by:
>         ptr->array[addr >> PAGE_SHIFT] + addr & ~PAGE_MASK
> (after removing the unaligned chunk offset from 'addr').
>
> It is actually quite likely that there are enough free high bits
> even in 32bit mode.

Interesting idea. But if everything is folded into a 32-bit area, it
means the size of umem is only 20-bit. 20-bit reflects that users only
put a max 1MB data into it. It might be too small to use?

Thanks,
Jason

>
>         David
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

