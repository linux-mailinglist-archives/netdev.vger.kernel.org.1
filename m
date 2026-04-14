Return-Path: <netdev+bounces-278479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDyQNbRR3mlUqQkAu9opvQ
	(envelope-from <netdev+bounces-278479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:39:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A6B3FB66B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C3E307C7FE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A08218E91;
	Tue, 14 Apr 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1uY4nFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6091327C08
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177216; cv=pass; b=Gl+sEbFhnVyHxiEcyslLP9UTsJqG6fDxqHFsVtDcHm+H2ttDRNLWFHzUPPb4rVFsGJK1hMkFhtQ0AETQ+fopzYcMxb5amImF2RwTw8TGzl3ytsJ8Swt96PXFIFjgzJPZWkyySijLCSQ0R0pfiiX2bS+UftmKGF2+fpw8qhzHBZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177216; c=relaxed/simple;
	bh=z+r8cADNJ1goFXqiFxfvrucLp8szq64XSfMHf/m9FPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF+Uv2L7qJMfJSkSc02+JRAuf7bS8CzgAqRtnACpZ/OIXRlmh5EZHgcyXzHA0d1RWALVrf8d3C5rPbbsqk7n0VIE7sWds+C+uNcY1XSoEHeXnS/kp1GhU+FjxkXy/uMwmrR/WwakNBMw7d3LRrDtQZgW5kJDBcsW1koNtAAHFHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1uY4nFb; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d74086e5bso1923453f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177212; cv=none;
        d=google.com; s=arc-20240605;
        b=d1wqGPvFuq5e4MVR/NFJmnV2fPOZTWVQVEehgZkNj/HoL3/ne5h4Y0H3Dq+iA8CiY7
         3JXrZiPZ/9LAvXmLecVVLEdcUgmLEk7WWXEdDDfn/Rxsu82KQLjbHJlFxCdshmm37OJz
         QVAue8K6g13ysG9m64xBNP55wL3qvy79vh9im0uUEPV8I2cwDCcf6bdFQK/BXhN55yBf
         ieZc6U0oDTcZ26iNm7H968jV7zfTLAgeOzt0Q3KWCggG8Bj4U/QzHv6lXFDFM/loM+y1
         X/rznmGDbVA+YbKq7sEIWHsM7nk2sgHP7froRclU9EiwjYm1Cnk3iXtJhHHevfc6cnm/
         lqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        fh=HWd2tpV17KArpdHe4kHDr7a6HSo+Edq4Qbq/gnYmG60=;
        b=ZBwvOwtgTOlZgOGM7iUNl2tB7kYv0d+PAymN579zMqoOgaAgAB2wLtJOHXYy8EcefN
         AupAykfyJaTC73eF9YyTN7ohtZSbezo9N9FlomqaUJF3jaZOPeQs31GhqFafl0Ma/ufU
         +bjRdMTW4yYEm7AnzLRPEHOFSZKEpS46aPuNUyM6LN5vueJbq4Tipd74sCJL5MdD6R53
         mlpiaoPt7Z3uqZfJZSFpxOXS3FeXQJiJblBAJS4V3zfoUniiZo1dWWeRhHphxN7UjK4r
         w5+Uz53aI6grBkISS1Rzs1mdqE7RyD9tAONJSrWky4diVibleZATXHBMKv7QADpI8TtW
         HMyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177212; x=1776782012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        b=m1uY4nFbY48r/Xpf0dgmOPmB9DkzFeJODUf2P/v9awivH5M9bJI+kaZ8lUv2TJJ7w6
         60+c6MD4hliooPY6i0iKklgtYsS6WEt6MJ3Yu0yjgNgK0u2qWZYDGPeu6KzpS+qV9SN0
         Hs1ZIWxifj3I2qEIwWCszVmZ3+WA8yapSNbrCejSe1+OEChdvyzgAk2W0FvskJoFRfKO
         5qbqExof2+YjkvyZ+bZhz43P92nF99wqvr8HT1itd+kbrtU7EkwGkIsT+OnpqUb67aYC
         SoxavYpjJbVYYA09w9m8REuOuwbtlPLHmBQjitN0f1D4QT3yhFjKy7LFHlqymcP0gaVm
         QgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177212; x=1776782012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bw6f7AXQLyB14/caIw5kD86MDDHBEfPYqQSR/5hoL5E=;
        b=HVl6PSpw0mLff/LZCBS4yk4cBE6urMWGeipUTHoqz6m5F/x36cGIeh29cyURuXmtD4
         qBT9SiHaJ+qZsx/SAw8Ar02P8vt0m1V8x5Kye0N1QFDgAV+54eLOE1zMAzJDG1xsPWdG
         8D8l+shz5HR1/BmbBKduJseSXff5R4nuc22I2Htw4hlsdZ9alZr2SCu9xYemjqBdopEa
         6FbI5Y0yYxbVHs8L/EJz1p7z0UGRNC9ykWVzLZP4qS0+O5a1FrpGWBboDje2M0vRos0P
         4+nMTdBDWmRjggDXsVNosFSJTreh5/MKZOWvwPHVBSMcgG0F/FgQJzNWxOiBV0vxeilc
         c2pQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SdNAMDJ34qiwAjaiRyZZ4R+lDyl3XPk+OgoNpLmzHE7LpqqfN39iEvQUOYIqwuflGr1pEA+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdtXnfCC7n124em4dOjCnFplflE7KNfbfQEvV4kiEdKR82/G4
	AHJzKR6UKSnuYZ7WJsOEK2FeZmTa5qq0TJP7BWXrADJyHEzEcvGh3+Y6fd452O3o2QvOmSXJZPX
	2LBR1RPSBsffo+WKPhbblMmptdo2r8wg=
X-Gm-Gg: AeBDievDioH+YFq7QcyPncUeW+rxp/NwJTJvoyk+R3rtWNZa0wBjL7AUuE+ZvM93WpL
	0eLEJPXzW5few+LWcR07p6kV3vVpFxrTTC2Or3f6CsnuRNvmKPLmN3Em/ZRrIrpJ63smK27TBxm
	l1KE4BNIdnZzs78DLtYOk0pNOq15+JBKhJjKJeiMnLfqN93/mqAwUm/H1VNu/x+rXrs+hIlvnLr
	6oY//iOGocJJqnB4YgSuI/k9SOT8kWX8t2vjKVR8rgfiGAb8ODT2QspDn1Xnxj1F0lm66RiiL33
	rc1qTmZvC2ZProGgNbn9wBqWpk8tGvGwPXUL44QAr0fYaOTXTESVnArsmLLaslJcdI+Hr6TbFY7
	cPPp9FRQT+BnRPpDk2myweBlG6lUKkP6+Y1iz
X-Received: by 2002:a05:6000:2dc1:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-43d7af03e24mr10264101f8f.29.1776177211931; Tue, 14 Apr 2026
 07:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260414105702.248310-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:33:20 -0700
X-Gm-Features: AQROBzCkbw5ADLWM4k0dOh5Z9WgXj9bNTMtPKcV-DzogX7CuHh-4xfxWUg3Ty-U
Message-ID: <CAADnVQKZC5hrfn1+7BJXYnemWT_AR6ODYH5OhmpRaAWOosTxDQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in BPF_SOCK_OPS_HDR_OPT_LEN_CB
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278479-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,std.uestc.edu.cn,hust.edu.cn,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,hust.edu.cn:email,mail.gmail.com:mid,uestc.edu.cn:email]
X-Rspamd-Queue-Id: 59A6B3FB66B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 3:57=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FL=
AG
> to inject custom TCP header options. When the kernel builds a TCP packet,
> it calls tcp_established_options() to calculate the header size, which
> invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN_C=
B
> callback.
>
> If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callback=
,
> __tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which calls
> tcp_current_mss(), which calls tcp_established_options() again,
> re-triggering the same BPF callback. This creates an infinite recursion
> that exhausts the kernel stack and causes a panic.
>
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>   -> bpf_setsockopt(TCP_NODELAY)
>         -> tcp_push_pending_frames()
>           -> tcp_current_mss()
>                 -> tcp_established_options()
>                   -> bpf_skops_hdr_opt_len()
>                            /* infinite recursion */
>                         -> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>
> A similar reentrancy issue exists for TCP congestion control, which is
> guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduce
> tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback in
> bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
> bpf_setsockopt(TCP_NODELAY) calls that would trigger
> tcp_push_pending_frames() and cause the recursion.
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@=
std.uestc.edu.cn/
> Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP hea=
der option")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  Documentation/networking/net_cachelines/tcp_sock.rst |  1 +
>  include/linux/tcp.h                                  | 11 ++++++++++-
>  net/core/filter.c                                    |  4 ++++
>  net/ipv4/tcp_minisocks.c                             |  1 +
>  net/ipv4/tcp_output.c                                |  3 +++
>  5 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Docum=
entation/networking/net_cachelines/tcp_sock.rst
> index 563daea10d6c..07d3226d90cc 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -152,6 +152,7 @@ unsigned_int                  keepalive_intvl
>  int                           linger2
>  u8                            bpf_sock_ops_cb_flags
>  u8:1                          bpf_chg_cc_inprogress
> +u8:1                          bpf_hdr_opt_len_cb_inprogress
>  u16                           timeout_rehash
>  u32                           rcv_ooopack
>  u32                           rcv_rtt_last_tsecr
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f72eef31fa23..2bfb73cf922e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -475,12 +475,21 @@ struct tcp_sock {
>         u8      bpf_sock_ops_cb_flags;  /* Control calling BPF programs
>                                          * values defined in uapi/linux/t=
cp.h
>                                          */
> -       u8      bpf_chg_cc_inprogress:1; /* In the middle of
> +       u8      bpf_chg_cc_inprogress:1, /* In the middle of
>                                           * bpf_setsockopt(TCP_CONGESTION=
),
>                                           * it is to avoid the bpf_tcp_cc=
->init()
>                                           * to recur itself by calling
>                                           * bpf_setsockopt(TCP_CONGESTION=
, "itself").
>                                           */
> +               bpf_hdr_opt_len_cb_inprogress:1; /* It is set before invo=
king the
> +                                                 * callback so that a ne=
sted
> +                                                 * bpf_setsockopt(TCP_NO=
DELAY) or
> +                                                 * bpf_setsockopt(TCP_CO=
RK) cannot
> +                                                 * trigger tcp_push_pend=
ing_frames(),
> +                                                 * which would call tcp_=
current_mss()
> +                                                 * -> bpf_skops_hdr_opt_=
len(), causing
> +                                                 * infinite recursion.

Let's not add new bits.
Reuse existing and test/check all in one place,
like commit 061ff040710e9 did.

pw-bot: cr

