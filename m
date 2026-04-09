Return-Path: <netdev+bounces-277025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+BFoW412l0SAgAu9opvQ
	(envelope-from <netdev+bounces-277025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533823CC0FF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD78B3010724
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A43DC4B6;
	Thu,  9 Apr 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+6sNB4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0B3DBD5E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745005; cv=pass; b=NYzsImgk4zfZdDCrVDvkqRcvvMmk9X4coGTE8FrrSDHAK92aHgf1mvauBrxORadXEMeZS4aHaxxGMWmwa7CmPB1la1DR1xWMcdmbRlge6S9VGC9P8REqGrqyWQ9gfyHAt4DGYW9+np96PamKhuB0+LYiJ2bTA1+G0gqT0HdttEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745005; c=relaxed/simple;
	bh=aiz98qC5uuUB98pxDGSrJs8vIwp/65s1qr19/1CjLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFpvkuxIpQSIe95pfoA1YqRA9VyH8OLWeBLy2Ve5ZCFK1rM0FyJYCCIR9e0ySliFf6KtTrW0NNep2JdVgPff90D6F75/jVB9pLdm2XoIH+xMZZ3Sh7msa+diuO2G2Uob9Qat3HfU7GbCSik0Jfi+QHA1ddzegck9mMWH0Lb35ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+6sNB4o; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfce3a195so607808f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775745001; cv=none;
        d=google.com; s=arc-20240605;
        b=fzTAiQqEtjPnCA+VzmoJBTytozc5itpeaPujS7U27pn6A3Jm2x1s5X2rNQ7VRb3HTd
         Tiycw/mQIkeWZ1+/pRBk2oYOw212dtJcO4Eg3q3oOWsTCI+OBCOYsFG3KECITQeMhUzM
         w2PB/BhKQCt8dRnqiVOgotXzpI5jJGMW0oyc6yGTXmkH+53DSYqcnBAmrDbY4k4Ea1Bm
         wMAM31n2vy83BTYuJ9AM0oQ/CwlVq6fkNTiRI/p/eby/anPvLwUJ6uQQZ3j2/XY88r1c
         kwCM1uu7Gt0Z86Rw4vZumQlqeV7EImXGmvBUerebCvUGr032ACFS/kU82nK8IUKPyxhp
         lyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        fh=XrFq7Lw3+0AV0JgD/AyIwfeHlYpTiIYXl4vasiq/jCo=;
        b=NTjauhuHsoQZWuMUwk81UyNqkkDMR2uXKn9WXOry+aylZ3n9Sl5wdxSjmdwH/Uu6WC
         a9iVZBSuCmBZ7KMt0FYHqfPTiBtLQZnSpIVxmNATfbeA/TbFGrh/ga1OfHty9QdwHDcu
         VBVpuwk5l3zXy5tOFH1vZBElaA5YPpDpDW9XJyP2RDt31Yihq70w+AX+yZwqCxuCTJuA
         WoHWtVZZMfMn6hqcWh8YHej/bxuMqCwE53Qsg4kgU+ZGtkJIpfHfL9ggmPgJr2SdGl2n
         qxXPiRAqglffRRuWTwUXMvedBtpFzy+AezqATk2UjqpnxsFZZQYXqAXGP1hSzHORZiqA
         uJDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745001; x=1776349801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=R+6sNB4oNQPK9IWW0WP6NZ7e8XKcqazpLb3HQLzI979uJShdR1bjPiXVh+GiQwdAfi
         7qIwrp9BWtIu2WMvND9WRKEEnUdC+ulFYCeuEh4laRTdvrHkesN7dV+wlCUOXfbjpEeE
         DBNnjiN3Z3CLR8lsh5+8GXW4GYAvc/vsumJbCNVANiGJI9lDhraIDa9f9h2Ckpd7QnrB
         PREjGjBWYHTT3k5OEyD/jCciY8Ko7DECj0E8Ve2r3CeyY/B31gVqMn637CGnjvpJPrjF
         qnvRUUyy96BEmnhfYozGX7NLCf9bGfxR+NYR+YuziVmRnAZCgnadA6TEnjYUvnAlP/OM
         epqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745001; x=1776349801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=g/09pTMBopCaunefIyQOgiedG5FAxO5KxNF5BOX8JFv+YoCJ9j8yLSzeKfzTZxqRuh
         vSx/83DnLW6wIUhMBAsLWMUjRBy4MwqI8iOnMmN04ICJJrAKGdhm72+QnAY15Yw4j2hV
         +AiBw2XFnP+njsmgynzVVpbnxcGUeYL8cmslsGrK7xnUBwT+SUIlbygYzkOCOF4cQixY
         U58KmEOCSfKQ8Ua445DwVbyZunRAXC1SnmDmVKSgk1AsqRhOi9ysIhen6DWLi02qM//O
         z8UcdaAdyrwSAA9l1OiccIqIYC0dHUTWgmkBxWhdniilovnWcRx31Jfju+91tvahHumD
         odBA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8XdHkzExRbLh+GY7HEhPjQW10yCJK/04ygW6Vx7pVmpHVZBp/PXU1EgIm6m0Y175MPnF6/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/vShOLrzwb9hZCYZQ+kT2FP3BefoVVCCWLLTSEqKxAkPUXWF
	1OQt1avjbIyCLyhD9IKBVpFXEyyrVKLhsq95JUUZlEBedby0nKcRteIBEOZ4j6gafu9NYbhSoxL
	i2KvbrhaukMet0oc3tNWoT+SZ++a54nI=
X-Gm-Gg: AeBDietEvoZXeJDJO1nWIkLUHdQlrQDgWxZj2HKgdylFZvQjFfXSPIJR36OVIV8Pe3b
	w4GF5UyGBP4TEFLEbPs1Z4TZVsxX6HeIpBRiJjpZo+CmM0Mx6ZHxv9k44zz5KP2YDnCaKenv6Xo
	5rHAIQb9sAu9KvSpGbNySwrwj4UnlA7dlTyr/PZTm7vPftOFCAMUCQYBl8CiwWc/qQMpgXPyH63
	HYFJ11i5RxL6X2CkoeE3/yAJi91wDaeQHH4/lmlIlZgS0/sqcRPdxY54wWWYsw/UnyYmOwJJGM6
	8Fb4TexaqfrCqVokTkKCqslnAEEeZIyoiRwBwaI3JbQnb3I/jj4gFCINRAEZ92qv42um9mgFjkA
	e/2ZjuASFVc8AOzVlt3PHhPmRBQ==
X-Received: by 2002:a5d:5c84:0:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43d5a089c3amr5137406f8f.0.1775745000893; Thu, 09 Apr 2026
 07:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406224953.2787289-1-werner@verivus.com> <20260409061026.3926858-1-werner@verivus.com>
In-Reply-To: <20260409061026.3926858-1-werner@verivus.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Apr 2026 07:29:48 -0700
X-Gm-Features: AQROBzA77CgnGz0GMfcb6aUuD-xSsenSGs755KZkihl8giw17FumU7yK1I768zo
Message-ID: <CAADnVQK0Toai=KZ3BggnR33DK20Oks1VcjphueRShCWuyuh3pA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: guard sock_ops rtt_min access with is_locked_tcp_sock
To: Werner Kasselman <werner@verivus.ai>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277025-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,verivus.ai:email]
X-Rspamd-Queue-Id: 533823CC0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 11:10=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> sock_ops_convert_ctx_access() emits guarded reads for tcp_sock-backed
> bpf_sock_ops fields such as snd_cwnd, srtt_us, snd_ssthresh, rcv_nxt,
> snd_nxt, snd_una, mss_cache, ecn_flags, rate_delivered, and
> rate_interval_us. Those accesses go through SOCK_OPS_GET_TCP_SOCK_FIELD()=
,
> which checks is_locked_tcp_sock before dereferencing sock_ops.sk.
>
> The rtt_min case is different. Because it reads a subfield of
> struct minmax, it uses a custom open-coded load sequence instead of the
> usual helper macro, and that sequence currently dereferences sock_ops.sk
> without checking is_locked_tcp_sock first.
>
> This is unsafe when sock_ops.sk points to a request_sock-backed object
> instead of a locked full tcp_sock. That is reachable not only from the
> SYNACK header option callbacks, but also from other request_sock-backed
> sock_ops callbacks such as BPF_SOCK_OPS_TIMEOUT_INIT,
> BPF_SOCK_OPS_RWND_INIT, and BPF_SOCK_OPS_NEEDS_ECN. In those cases,
> reading ctx->rtt_min makes the generated code treat a request_sock as a
> tcp_sock and read beyond the end of the request_sock allocation.
>
> Fix the rtt_min conversion by adding the same is_locked_tcp_sock guard
> used for the other tcp_sock field reads. Also make the accessed subfield
> explicit by using offsetof(struct minmax_sample, v).
>
> Add a selftest that verifies request_sock-backed sock_ops callbacks see
> ctx->rtt_min as zero after the fix.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  net/core/filter.c                             | 53 +++++++++++++++----
>  .../selftests/bpf/prog_tests/tcpbpf_user.c    |  9 ++++
>  .../selftests/bpf/progs/test_tcpbpf_kern.c    | 21 ++++++++
>  tools/testing/selftests/bpf/test_tcpbpf.h     |  6 +++
>  4 files changed, 79 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158..5040bf7e4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10827,16 +10827,49 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>         case offsetof(struct bpf_sock_ops, rtt_min):
>                 BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
>                              sizeof(struct minmax));
> -               BUILD_BUG_ON(sizeof(struct minmax) <
> -                            sizeof(struct minmax_sample));
> -
> -               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> -                                               struct bpf_sock_ops_kern,=
 sk),
> -                                     si->dst_reg, si->src_reg,
> -                                     offsetof(struct bpf_sock_ops_kern, =
sk));
> -               *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -                                     offsetof(struct tcp_sock, rtt_min) =
+
> -                                     sizeof_field(struct minmax_sample, =
t));
> +               BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, rtt_min) !=
=3D
> +                            sizeof_field(struct minmax_sample, v));
> +               off =3D offsetof(struct tcp_sock, rtt_min) +
> +                     offsetof(struct minmax_sample, v);
> +
> +               {
> +                       int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG=
_9, jmp =3D 2;
> +

please de-claude your patches before posting.

pw-bot: cr

