Return-Path: <netdev+bounces-84284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB68896657
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0083C287ECD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6758AA4;
	Wed,  3 Apr 2024 07:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCD5788B;
	Wed,  3 Apr 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129176; cv=none; b=PK4hoRLSb+bEnFIyMb1tLWznmRVM1U3BaFAgO6dimSk59KuPBA0cEy3fcNKRrWz9NjKhNAX0zVbaSgiSFPQqJJ2TpxEkCRTbKpwNB3zs/fGI+Z0Syv0UrMMrsdcGQIPDo8IX9+AIdoSusTNQTGcv5aJ6QwlK/WZEcXBDrqJ1gaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129176; c=relaxed/simple;
	bh=TgfH9Jl+6MRhgbG0+tHBR2+Mtqe5D+c6XHR6VYv3C9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRzzSKNdynz6sJEb64cIzDQQbFUleIGakFIqWCbsZD2WWd3TiucpkgiYQTW25MZY1AjlFrGa4G2Hv0nDMriQz814BcLX1Q2gzHYZfU/lR/li3ZDxbXq2AZFahXTP93o7xpywiQTekdZru8ceZz18D29jqFrYdT8Bo4BGBeyBQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8brm38fPz4f3nJd;
	Wed,  3 Apr 2024 15:26:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C921E1A0572;
	Wed,  3 Apr 2024 15:26:08 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgB3OKCLBA1mSLIeIw--.49947S2;
	Wed, 03 Apr 2024 15:26:05 +0800 (CST)
Message-ID: <ea97fb1b-be81-4a18-b505-cab08617ece8@huaweicloud.com>
Date: Wed, 3 Apr 2024 15:26:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] riscv, bpf: Add 12-argument support for
 RV64 bpf trampoline
Content-Language: en-US
To: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240403041710.1416369-1-pulehui@huaweicloud.com>
 <20240403041710.1416369-2-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240403041710.1416369-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3OKCLBA1mSLIeIw--.49947S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF45ur4rWrykuF15ZFyrZwb_yoWxCw1Up3
	WDKanxAF9YqF47Jayvqa1UXF13Aan0va43CFW7Gas5uFWYqryDGayrKF1jyry5Crn5Aw4f
	Ars0vF90k3W7JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2024/4/3 12:17, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> This patch adds 12 function arguments support for riscv64 bpf
> trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
> scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
> focus on the situation where scalars are at most XLEN bits and
> aggregates whose total size does not exceed 2×XLEN bits in the riscv
> calling convention [2].
> 
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 65 +++++++++++++++++++++++----------
>   1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 77ea306452d4..7e2d6e8c60c2 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -14,6 +14,7 @@
>   #include <asm/cfi.h>
>   #include "bpf_jit.h"
>   
> +#define RV_MAX_ARGS_REG 8

Sorry for the noise. The macro and variable names look really weird. I 
will send new patch for the name alignment:

nr_reg_args: number of args in reg
nr_stack_args: number of args on stack
RV_MAX_REG_ARGS: macro for riscv max args in reg

>   #define RV_FENTRY_NINSNS 2
>   
>   #define RV_REG_TCC RV_REG_A6
> @@ -688,26 +689,44 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>   	return ret;
>   }
>   
> -static void store_args(int nregs, int args_off, struct rv_jit_context *ctx)
> +static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
>   {
>   	int i;
>   
> -	for (i = 0; i < nregs; i++) {
> -		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> +	for (i = 0; i < nr_arg_slots; i++) {
> +		if (i < RV_MAX_ARGS_REG) {
> +			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> +		} else {
> +			/* skip slots for T0 and FP of traced function */
> +			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_ARGS_REG) * 8, RV_REG_FP, ctx);
> +			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
> +		}
>   		args_off -= 8;
>   	}
>   }
>   
> -static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
> +static void restore_args(int nr_args_reg, int args_off, struct rv_jit_context *ctx)
>   {
>   	int i;
>   
> -	for (i = 0; i < nregs; i++) {
> +	for (i = 0; i < nr_args_reg; i++) {
>   		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
>   		args_off -= 8;
>   	}
>   }
>   
> +static void restore_stack_args(int nr_args_stack, int args_off, int stk_arg_off, struct rv_jit_context *ctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_args_stack; i++) {
> +		emit_ld(RV_REG_T1, -(args_off - RV_MAX_ARGS_REG * 8), RV_REG_FP, ctx);
> +		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
> +		args_off -= 8;
> +		stk_arg_off -= 8;
> +	}
> +}
> +
>   static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
>   			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
>   {
> @@ -780,8 +799,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   {
>   	int i, ret, offset;
>   	int *branches_off = NULL;
> -	int stack_size = 0, nregs = m->nr_args;
> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
> +	int stack_size = 0, nr_arg_slots = 0;
> +	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -827,20 +846,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	 * FP - sreg_off    [ callee saved reg	]
>   	 *
>   	 *		    [ pads              ] pads for 16 bytes alignment
> +	 *
> +	 *		    [ stack_argN        ]
> +	 *		    [ ...               ]
> +	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
>   	 */
>   
>   	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
>   		return -ENOTSUPP;
>   
> -	/* extra regiters for struct arguments */
> -	for (i = 0; i < m->nr_args; i++)
> -		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
> -
> -	/* 8 arguments passed by registers */
> -	if (nregs > 8)
> +	if (m->nr_args > MAX_BPF_FUNC_ARGS)
>   		return -ENOTSUPP;
>   
> +	for (i = 0; i < m->nr_args; i++)
> +		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
> +
>   	/* room of trampoline frame to store return address and frame pointer */
>   	stack_size += 16;
>   
> @@ -850,7 +870,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		retval_off = stack_size;
>   	}
>   
> -	stack_size += nregs * 8;
> +	stack_size += nr_arg_slots * 8;
>   	args_off = stack_size;
>   
>   	stack_size += 8;
> @@ -867,8 +887,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 8;
>   	sreg_off = stack_size;
>   
> +	if (nr_arg_slots - RV_MAX_ARGS_REG > 0)
> +		stack_size += (nr_arg_slots - RV_MAX_ARGS_REG) * 8;
> +
>   	stack_size = round_up(stack_size, 16);
>   
> +	/* room for args on stack must be at the top of stack*/
> +	stk_arg_off = stack_size;
> +
>   	if (!is_struct_ops) {
>   		/* For the trampoline called from function entry,
>   		 * the frame of traced function and the frame of
> @@ -904,10 +930,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
>   	}
>   
> -	emit_li(RV_REG_T1, nregs, ctx);
> +	emit_li(RV_REG_T1, nr_arg_slots, ctx);
>   	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
>   
> -	store_args(nregs, args_off, ctx);
> +	store_args(nr_arg_slots, args_off, ctx);
>   
>   	/* skip to actual body of traced function */
>   	if (flags & BPF_TRAMP_F_SKIP_FRAME)
> @@ -947,7 +973,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_args(nregs, args_off, ctx);
> +		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARGS_REG), args_off, ctx);
> +		restore_stack_args(nr_arg_slots - RV_MAX_ARGS_REG, args_off, stk_arg_off, ctx);
>   		ret = emit_call((const u64)orig_call, true, ctx);
>   		if (ret)
>   			goto out;
> @@ -982,7 +1009,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_args(nregs, args_off, ctx);
> +		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARGS_REG), args_off, ctx);
>   
>   	if (save_ret) {
>   		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);


