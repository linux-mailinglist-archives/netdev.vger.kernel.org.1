Return-Path: <netdev+bounces-265631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBf8JZvzrmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:21:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FB23CA25
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A2D6300795A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DB3CC9FB;
	Mon,  9 Mar 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0W3ncEka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D91925BC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073299; cv=none; b=Xq2zGfY9Dc9j3bbgxs/24MzrabRE4ufrgUWID2nBOn9YLSnL/f2n4849nqCN+oqypaXJJWKEQEULDASm1SvJg4h3ONrpkXbZqqxY0a6FxUudSHw1u7el0ycdp2DUb+dhzfVw9RugvQ6Ig5wuzhR1fHG+r2nVc/Ogomse5PW5yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073299; c=relaxed/simple;
	bh=td74bMx8ZXiHQfNV+QzmTZxdoVL+td/b5gqEqpcrNW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tBszx9DpHBQRscA/Uj/fKFAg0vuLNroyD3HOxMFB1g9JVX7XceJyxF8S0nXJR4nE4SNLNk+6i+I+oQKGM/40BoEDCRXLh7vfbZUmZbxx4U+getEICM6V9bUzqkof6yDl47Bk2cHIFKguOdchhKtikb6kD78A2h90z+XmBUnLR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0W3ncEka; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso134023896d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773073295; x=1773678095; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k907me6g0lW0BSeww/pGmw3mgtqq3eewfWPpggfLHN8=;
        b=0W3ncEkak6FmKdEAn7axM9i9i9wM5esprQoKh2aufozwfj0y74EEcJcTJ214MYhQwq
         CEzSD4TVDx5sc/bPeyA5h4mc2Ac+e/F1zTsU4TUizNErQqKh83Uuo7ghiSXTIUrR/Gaw
         j84Q93kWQyx7iDLtuKl5gpYdhwPKVONGZaz+f7NJ0c6H/wm/ZEbPsKp4sdsKhhauAfiM
         KFSfR4UxUi7VDLVEslX6NJ01a9qtoclhy0KFnhR5y+Y7VMIL3RqXS0nyoL+f5da+nvhD
         7TjCdKqP8ZUr6ZKuVcknIH09oP379ZBdhMNI2qHoDv97wRqrwiIjJPdDoCqsLhCI1MIV
         Fv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073295; x=1773678095;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k907me6g0lW0BSeww/pGmw3mgtqq3eewfWPpggfLHN8=;
        b=s5m/IrjlYP+ANxrlPq9FdlSyPtKBVvO8p2ejZpPAwHecXtZgm9KXY0kZIS6APOx+Oz
         DUCJYSP1FhEIzx2wINtlVZ3i3vp0nR9o6u9mSRgTrXXsyATSfJGs/2c+7YDS7kJijIXD
         MwcfAG6nm9cWxRzHaKihaxBNPbHg2owx7+01Ps6gZ9N7gphVmvyJEWtnGNmuBEjDkzDi
         so9o6Oh9dbVMU9yR/OAQ+2Fmbzzb8wZneMJ5GaWWum4JWtu8i0uUKOjNeyAggRq4/vDg
         0g1HGhGWwN7ahL6pJYjqvVe3+drt/pPEr+ScCg+6YcSJXvv3a5OkrP7sECtglGZN/ESj
         MQKA==
X-Forwarded-Encrypted: i=1; AJvYcCWUJUTKdFLgDsfwxom5Lz3O3xukDb7sW3EVjA7s9R37skJJK3V8+ZnWrFvyJfL9Z9/f9dakP8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfKzxHNdxpNt4Dsbb9Hq5ewu+XKzmpaOV3rcvuEAUym0gEwtp
	HgotSQaQUQZS5hXJigBZm0ALl87h34ToBbaA1uneirTaiPsGk5IMHjAqrMwmboKZ5dKMopIZolu
	MjqcH
X-Gm-Gg: ATEYQzzXWeUtt8WelF4D6OzbuT6Od1+laPGhEYIXiF4LP/Ny0AtHzi5NNcTlbUZEFMN
	QPgPXzo2JmXpvM+jQF1cAtH3dI7zv2+Tds6oS4oeIugAccv2dG6GIMbvSKXra5JVdSzGO8PY1PU
	IgAujTUcCMzcurDFBDoY6VRr8vc7epZr0h3HpBMXoDLiIw8Wk1g+I6RGYjPRmtM3bTenp4y4EOW
	5m8m/xOG40okPhO2JwB5xwLAngv5uFP7lV6YiE4tTXwzcUysw8Rt8JGsiPcKA58ucLaACGrKX91
	cqdDlEZ44Shka4L8D2GKSDbKmaBpWwFi7PuA53TYLm8BhPi0/weCivPnpnjXaV331cqPpEx5Bss
	UR4SWdwYdwysnstGbhW8EwWWNhO10n+be4QxZgBNpDj63+9Jkm7TVBqgTBhHzSRAV/cgkGrtq0e
	7+KMbbdHnm0Wj7CvqTGf5m8k4QA6QzwjfHGw==
X-Received: by 2002:a05:6214:262d:b0:899:f601:788b with SMTP id 6a1803df08f44-89a30a1799bmr185913076d6.3.1773073294650;
        Mon, 09 Mar 2026 09:21:34 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57bf772csm988956d6.24.2026.03.09.09.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 12:21:32 -0400
Message-Id: <DGYE0XY2UKQV.2COXLK9T9HG9S@etsalapatis.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org"
 <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: fix constant blinding bypass for
 PROBE_MEM32 stores
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "CyFun" <xcyfun@protonmail.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
In-Reply-To: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
X-Rspamd-Queue-Id: 110FB23CA25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265631-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email]
X-Rspamd-Action: no action

On Fri Mar 6, 2026 at 4:03 AM EST, CyFun wrote:
> To: bpf@vger.kernel.org
> Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, netdev@vger.=
kernel.org
> Subject: [PATCH bpf v2] bpf: fix constant blinding bypass for PROBE_MEM32=
 stores
>
> BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
> bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
> survive unblinded into JIT-compiled native code when bpf_jit_harden >=3D =
1.
>
> The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
> to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
> before bpf_jit_blind_constants() runs during JIT compilation. The
> blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
> BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
> unblinded.
>
> Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
> existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
> load the blinded immediate into BPF_REG_AX via mov+xor, then convert
> the immediate store to a register store (BPF_STX).
>
> The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
> the architecture JIT emits the correct arena addressing (R12-based on
> x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
> BPF_MEM mode; construct the instruction directly instead.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Though:

> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
> Signed-off-by: s4ch <xcyfun@protonmail.com>

IIRC pseudonyms are not allowed on the SOB line so you will probably have t=
o update it.

> ---
> v2: Rebased onto current bpf tree (commit 56145d237385).
>     v1 had a malformed diff header that caused CI to reject it.
> ---
>  kernel/bpf/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55..bb2fa75de 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1422,6 +1422,24 @@ static int bpf_jit_blind_insn(const struct bpf_ins=
n *from,
>  		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
>  		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off=
);
>  		break;
> +
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
> +				      from->imm);
> +		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
> +		/* Cannot use BPF_STX_MEM() here: it hardcodes BPF_MEM
> +		 * mode which would lose BPF_PROBE_MEM32 and break the
> +		 * arena addressing in the architecture JIT. */
> +		*to++ =3D (struct bpf_insn) {
> +			.code  =3D BPF_STX | BPF_PROBE_MEM32 | BPF_SIZE(from->code),
> +			.dst_reg =3D from->dst_reg,
> +			.src_reg =3D BPF_REG_AX,
> +			.off   =3D from->off,
> +		};
> +		break;
>  	}
>  out:
>  	return to - to_buff;
> --
> 2.53.0


