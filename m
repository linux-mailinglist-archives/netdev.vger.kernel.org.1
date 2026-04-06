Return-Path: <netdev+bounces-275641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAP9DAva02nVnQcAu9opvQ
	(envelope-from <netdev+bounces-275641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A251A3A5126
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6BDA30182A8
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31C38759C;
	Mon,  6 Apr 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcrVEnSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230833A9F3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491583; cv=pass; b=lzsKaOuaGefiLq6njf15+MphjhmdlHPWsVeHnjxfxUsm5dTUtwqMj4qqKRjvv+WZyvfR21yaEJj5ZY5EbwJGWOqjUMENGF9m1hstNVKevirKu0Kf7xSq3Z1tPfUgjRepHE4suQQqBlJDcR0O1HpGpzAHvC5gbd0A+Ic2IEqMgOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491583; c=relaxed/simple;
	bh=1Ao81rLLMJ9T3ZhPayNjrIz+C2kFvFVa1w9KQcaOTbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNKj6HzukWW0SZVoPxyQsBOJTytRU+q2EUGgGAy+9c/2b3DmEG9deF0qZrdcnAN0qPoHyXHLmF+swQRD3Ul0pH23S5WSk1y5Zw9p1LmsRGjGG6kz/U7NVwunzjvBTrV1CAGvcHSc1m0LFSd4uNugWssJPm/lTMkWox0CskFv6Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcrVEnSB; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64eaf8aa893so3376471d50.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491580; cv=none;
        d=google.com; s=arc-20240605;
        b=XH5vTeoQD4CEzkttE3/7kU3/mJT9FESR1resjSZjfR2XGPwh6hPcIJXZug9axeAHI8
         4cHI5BgxXMqwLdRZTn7RXoVhBEFUPdD0y5Zg+GaGPYL5B7m8pUzlQvuwPSTXt1OZLfr2
         JBq3chNZaSGOwBmfMbK3nRbFbqCtTri58cyNcjj6jvyWkbj1DlJwTB+i1lIab7uznHW9
         NXG94D96025kuO3tHtk2fNBNujzg2g5xGFXHRI85N92DFI17dXKQvEXsvAnOrMr84/ix
         TiOPSs9BpWSQ4uV9dJ1GFD5MNfhvq/+B6u5elWZ0UvH5tPkJtNrJ83upru7gNzmzdrIm
         /aCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        fh=lv5rb3tGS3cxo0zoIsNLN1Sxn/X8xHeOZ/UQEf7wlFE=;
        b=OcOakXXceY5tL0hSKoCWpbVR4AT0QxCYk6J8zHepIhRtHORSGLc/DpD1iJ+PCnOWCi
         vhNm389GAT32zRWF15FWU/HQkO5jIfikGdD3EqAtkQjlgMDQTLD/lX8T0CcuL5pnZM3p
         Z/h8qRZcfLPgdnEmhkrOTpXf+UEfJNCI1A0AKEzTksQNxbC+leDhn5WFRc2f1YfQsSvM
         rrAaHH1qRYFDHP93e5gMo8GLykw+RNiSRF2bGZLMlthLhW51yWZL8IPOGJyrcdpLyuxk
         PY7Z3i+Qj3U7RVOtygHT12uk+N4HAVEHYWojL1MYy6oU87WYuEVGRC5lKj7JIbM6+Gxo
         Ns5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775491580; x=1776096380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        b=XcrVEnSBzqObcxdel+GHkgInMaZKgb3qUAZaCNqoARA3InJt/2N/OC5rL6XKpYm30H
         i4YjqyZTeAMeo4dMFr7uqDKq4cNp5CqMNBRf3d07RJONWe4xqXuyJhkH6DZiAEaztuDo
         9DyW4Otfiv2xAv2T571/F3hVwN4iWYnL5zJof1XJgf2E7s27OLCozFIeJ4VHNyQ6uXIM
         XLIWxCvaKhE3OFnCM4ZLO59m+Rv6rylnv7j1YOeFyuOFFJDtxVgrpQ431EDpzTOfdjmc
         0jQs2XdHPp/6GxV947NB9N0x5dS3oGCkR9kZnyKPLcNh53mbSKg5CauAouJJEruZJjDw
         /MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491580; x=1776096380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        b=QAU+4OtrvQzJzuUk+Zzf6Uee007YoYqGCvX+Os5JfAZ2+AH0bKGsJO34lJCnyGdjm8
         ZkIT6o3UHWT8h/97uj97r5Sdg6hOjAD11vBF6JzaJg0Q0J5KS65O22bHgF9/WWECX16W
         vYncf6jj6BRKdBXGibQBLfyaSC6GkPSwmyHpv30vU8xWenitdbrHECA2rOAV937npdB+
         dXeXA0nzt48iENWQswlQ7Xuk8k7M2HC51/seMh7/z7SOFzTbGQv2fSrSx5zCxjb/Ya7M
         47wdKLokJA33jPUl3YbCfpU0NdypM0UnXc2/9LxYhRblVFN98WHKAVnBj2OvIQP48xqt
         mY5g==
X-Forwarded-Encrypted: i=1; AJvYcCW/uv86IYZmErw58xB9OJuwZ9pOusBpR6sZoSmvGsMSDsnpIXQ9v916Z5wjMl67j2RPmpOFL3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYGezK3ZRczsmiIyyTzIO7BglENyxJJiuOCQDvrF0b+4FJjMR
	HfbQoFIGyqckc1qk4U5VLcQ/bQaMDoQy8pDnH3BsIY2kc0VxJ9LviIQRfk3jVvIpg80mhAit0Ha
	uixzmAX2TQFQstmXOEqDbfj7cgHRuHrw=
X-Gm-Gg: AeBDiet2+GqAu68wULSMt3G0b4uJF4oSmYp0TXTO/DMfcw3gqaSEm9GQobkzQpDXIND
	h4lsci34awsNv4JAlCO4U0VsVrNuaZ/uUuExCnqz2F13o9Br0kbVm+8CPn3WqA6H6sKik3MB7qB
	W1f+AprTpQRNgtWoUX7aF5YoTSIj78hjKFXqESqAC3wjRrlPbvAKGbhISYPYKBKamBSCE9cmFir
	YKuFZ1SvV9XUvjS2juE7HJdhYqZAqFXGgAfnqkpe4Hm3o3df8kHLpDB75E99k07BN6fYecAsusM
	mnz3rHOEmIoHWFskGvhN3nr4uxV2TZVQC5J0Jh9Sk6qlaqoK+mc=
X-Received: by 2002:a05:690e:4853:b0:650:39d6:69a1 with SMTP id
 956f58d0204a3-650486f2bedmr9450184d50.4.1775491579797; Mon, 06 Apr 2026
 09:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 7 Apr 2026 00:06:07 +0800
X-Gm-Features: AQROBzDlDluK28vEL2sKAYGrEn54l6_RzgjNnCFfO8DMO8cybYxLjy0EB75dedU
Message-ID: <CABFUUZHFHFy8E11QVPxgkpdS16-f8ieTmHzJmEU-6pLUy2hWjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-275641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,std.uestc.edu.cn,hust.edu.cn,etsalapatis.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: A251A3A5126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 11:14=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> When a BPF sock_ops program accesses ctx fields with dst_reg =3D=3D src_r=
eg,
> the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
> destination register in the !fullsock / !locked_tcp_sock path.
>
> Both macros borrow a temporary register to check is_fullsock /
> is_locked_tcp_sock when dst_reg =3D=3D src_reg, because dst_reg holds the
> ctx pointer. When the check is false (e.g., TCP_NEW_SYN_RECV state with
> a request_sock), dst_reg should be zeroed but is not, leaving the stale
> ctx pointer:
>
>  - SOCK_OPS_GET_SK: dst_reg retains the ctx pointer, passes NULL checks
>    as PTR_TO_SOCKET_OR_NULL, and can be used as a bogus socket pointer,
>    leading to stack-out-of-bounds access in helpers like
>    bpf_skc_to_tcp6_sock().
>
>  - SOCK_OPS_GET_FIELD: dst_reg retains the ctx pointer which the
>    verifier believes is a SCALAR_VALUE, leaking a kernel pointer.
>
> Fix both macros by:
>  - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>    added instruction.
>  - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>    restore in the !fullsock path, placed after the restore because
>    dst_reg =3D=3D src_reg means we need src_reg intact to read ctx->temp.
>
> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when ds=
t_reg =3D src_reg")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@=
std.uestc.edu.cn/T/#u
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> ---
>  net/core/filter.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..53ce06ed4a88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                                       si->dst_reg, si->dst_reg,          =
     \
>                                       offsetof(OBJ, OBJ_FIELD));         =
     \
>                 if (si->dst_reg =3D=3D si->src_reg) {                    =
         \
> -                       *insn++ =3D BPF_JMP_A(1);                        =
       \
> +                       *insn++ =3D BPF_JMP_A(2);                        =
       \
>                         *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
>                                       temp));                            =
     \
> +                       *insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);       =
       \
>                 }                                                        =
     \
>         } while (0)
>
> @@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                                       si->dst_reg, si->src_reg,          =
     \
>                                       offsetof(struct bpf_sock_ops_kern, =
sk));\
>                 if (si->dst_reg =3D=3D si->src_reg) {                    =
         \
> -                       *insn++ =3D BPF_JMP_A(1);                        =
       \
> +                       *insn++ =3D BPF_JMP_A(2);                        =
       \
>                         *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
>                                       temp));                            =
     \
> +                       *insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);       =
       \
>                 }                                                        =
     \
>         } while (0)
>
> --
> 2.43.0
>
>
Reviewed-by Sun Jian <sun.jian.kdev@gmail.com>

