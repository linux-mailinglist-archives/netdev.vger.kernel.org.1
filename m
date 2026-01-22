Return-Path: <netdev+bounces-252107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHTbEkhqcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-252107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAF5FCFA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 010FE36591C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4931E5B64;
	Thu, 22 Jan 2026 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPZTS1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEE19C553
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040433; cv=pass; b=RUUsmfgwNfcRzFFKGJU68drLGOKQasZh5tBm43taXRfJkQ6d5iMyE1D6O+Qb0h5KfN7Uz6s+jfELDHoqxw0iYo5myBQdKLWXht9CT6tB8pVZgMU3Kr/B2zclYjYsZPdAOKknMV4LrB0Dd40ZV3OHiXnsWvya0EuljwL1LINrEEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040433; c=relaxed/simple;
	bh=YDS2dEo5JUXKvqLS3U1b6s+W+s7l5ZragsnMIxIcL7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKstyeJHJPdfMgT4QcZkbvsCJTZmAwR8so5Iba3DVk6s6ZQqBxNGLJ0ipeMkku1lqReo2P2GSgX8FrXYpRORdgdfX94IaAJa1x0FonWHHIqKgiRkTYYoTrYovNjxEoUDefQfr1TYzGj8XqXzE9QtOJUkpK+qJQxAfpYCHRPmd8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwPZTS1t; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c613a0ca52dso169165a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040427; cv=none;
        d=google.com; s=arc-20240605;
        b=fprYbzs/AzOeT+HYuzZK9i/azRbE3gvLw0pNbcJ9wpqizFRag8OwWm/kXFA9OcRqQb
         hWl1lTXmnJzJUvCSuNvbMxl7T8sBsiApfsR35txrAQKqbhMBTSqG/n+mLkYBWAT8ticY
         l7JT6j+u8zeY78H2pD3pnehWP5tXniJZrx5zTLBSC+WXvmrp1tup/ecQAL1uDgryE4/i
         zTTEX5ETLaUkZMUsrGBkoXquzMYyNyOJvaIsWr79Jv6jomVy6M5jLGqW3SQFlt4AM51+
         gvkYdqLztowg8BQT4Tj11pt7PmcIN1xqntkMArTaykSe6OAhfGs0WMWnt+6fifpRFYML
         RGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        fh=8mU0dQ+8lWBA984azMwKaJK12AufEfFYVasXgKaB9PI=;
        b=F35LBwdmPYuHZRwAap3qfVeZN8rHZ/qKK5IqF8/afgbuY6/lJ83LKppBFWlX6COa1M
         jIz9y9Ik9nC9N6B6xIso10hLEDmiynyRijK48xIrpgH4epuZLHfCkGobFv1bofjarnBr
         w+rxajD9MSgacC9Fpbh+Di6PKtW9aBv6PTtVEvgkUh1/PbQrdJWyBX3KF1xUTlynyLQh
         Zt3oOa7hOnJCGDtG8EZ2VGN3AorqDJOf8Lv3l0gj9g9SDd8WU5htM2FzvZnANBFd/O8T
         sozOerXv1GvhiAlNcj5DkJkwmehxNECP8pQimt27BndVKDlJr6J1aWLOHv43oHqNv1aQ
         dZdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040427; x=1769645227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        b=fwPZTS1tybOQkAiB0vhUDeanxbxIMfuZGdqzW1tTunfabB9nq9Lo5YbDv0eahhSla6
         2Hfir8ql8n95v6qKqKq/HrKwqkrwBtKnFcYQIu9OVMKsx0o9QGdykkv+OM69SyNnd+J/
         +nnOw4gdyP0gOTYQ9hBMOvqTKYPKdJRFoEXsIX2d28HkeyHJg/CmeoqaijcCTjKg4HWv
         DuBqGNu5bj3t5YZ+kFaJPUToR3e6kP/VTyvmkSorUnhzXcROsLZQgTrO8669WmAgYWcq
         aH2swOvyUUiweODSDxVrJ8EH2jqPr1jvjEMS4xffoIUyXeO7epf4ca8zli/lbctyU1Sx
         hMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040427; x=1769645227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        b=fuYrUUTtHaafgnqr9rIege4Yhy0czXkJy0h/RXj5zFY0VEW0+A2yQaKP9zHOjbxbWK
         og3qMbpPm+Z3a5JRF3xu5Hw8gYpulKpjMYiKtTne6BcCTPUfF7fIBlp2KEnveFsaeUnO
         NqDpTUwDdlmtaz0c1zKaLgA7wxVE7l4hwsqE6FlecRD8+c687hN6PvO8Y21WAHXeJx8j
         cZk9UkhTOgQvlBXJHSYtTCHg3gAl2C2EDeT6cg8NMrdkH2AhMk9VbmSjJH6JSEi5l3jM
         tp3GqnxneEG5WZXkrPU0z10mRMIrEFGBwjDS8iPcly3PG3sAeg86Ay3D11T/CUhUG9ff
         pBhA==
X-Forwarded-Encrypted: i=1; AJvYcCVyXvTOd+kOrTRxKIzPWcoK99gjb/CYviWLt3bd+cz+64KJ7pqVlh+fWy/PjV5FTIzCoybuaoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVO8/84nE4vUhUYYDXJ5Vn6mkTTH9zqv+W2f+9PQsxb575JOH
	dlH3MaJPxb55P84M4Arqyq6tsm8P1sbYBCtNvbdWXj841xdhpHwhew9nxQWCTLq+nD3Lz7CIvS1
	YeUCnHF51BmDUGHMY8o9/gJ2pb7Qplxw=
X-Gm-Gg: AZuq6aIkKEDinsJmHvclybjW9CO57JoI2oE5yfxfFeKjXpuWHgcVD4Vpqd4Hw7maij9
	JsWvBxPSuewifSBrV0S54Ik+P6EtAL4LdAHQThi1+raRBrNf/Wq7w8dLFHSR9nYt2Kmbyh0Ne5e
	uub1jjbUGOV5u+wQIYLtHioHfnDbH40JoouoDPvkXFBS8lVKKF1krWKtXncYjywA59n4A4L6Sv1
	skawuTLNX6i19pf47qAU9ffW9uTDE8IlS2XWTLzbeAfLKJLL4ZOIeUfmGvLRun9V9QY1piSjAjB
	b3EM2a2n5FrskvPs0eQ=
X-Received: by 2002:a17:90b:1f91:b0:341:b5a2:3e7b with SMTP id
 98e67ed59e1d1-35272edae77mr15190946a91.4.1769040427195; Wed, 21 Jan 2026
 16:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn> <20260115112246.221082-8-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-8-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:06:55 -0800
X-Gm-Features: AZwV_QhSGxLIIP5f5im61MFlVXddfZPY1u3-4m3Mb5vdt2iGWTCVRB0Cnsxp4Lo
Message-ID: <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 50AAF5FCFA
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_FSESSION supporting to x86_64, including:
>
> 1. clear the return value in the stack before fentry to make the fentry
>    of the fsession can only get 0 with bpf_get_func_ret().
>
> 2. clear all the session cookies' value in the stack.
>
> 2. store the index of the cookie to ctx[-1] before the calling to fsessio=
n
>
> 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
>    the fsession.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v10:
> - use "|" for func_meta instead of "+"
> - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
>   computing it with "stack_size + 8"
> - pass the "cookie_off" to invoke_bpf() instead of computing the current
>   cookie index with "func_meta"
>
> v5:
> - add the variable "func_meta"
> - define cookie_off in a new line
>
> v4:
> - some adjustment to the 1st patch, such as we get the fsession prog from
>   fentry and fexit hlist
> - remove the supporting of skipping fexit with fentry return non-zero
>
> v2:
> - add session cookie support
> - add the session stuff after return value, instead of before nr_args
> ---
>  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2f31331955b5..16720f2be16c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
>
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>                       struct bpf_tramp_links *tl, int stack_size,
> -                     int run_ctx_off, bool save_ret,
> -                     void *image, void *rw_image)
> +                     int run_ctx_off, int func_meta_off, bool save_ret,
> +                     void *image, void *rw_image, u64 func_meta,
> +                     int cookie_off)
>  {
> -       int i;
> +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;

not sure why you went with passing cookie_off and then calculating,
effectively, cookie count out of that?... why not pass cookie count
directly then? it's minor, but just seems like a weird choice here,
tbh



>         u8 *prog =3D *pprog;
>
>         for (i =3D 0; i < tl->nr_links; i++) {
> +               if (tl->links[i]->link.prog->call_session_cookie) {
> +                       emit_store_stack_imm64(&prog, BPF_REG_0, -func_me=
ta_off,
> +                                              func_meta | (cur_cookie <<=
 BPF_TRAMP_SHIFT_COOKIE));
> +                       cur_cookie--;
> +               }
>                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
>                                     run_ctx_off, save_ret, image, rw_imag=
e))
>                         return -EINVAL;

[...]

