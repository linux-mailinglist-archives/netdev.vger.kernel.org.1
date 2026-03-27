Return-Path: <netdev+bounces-272684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMkhEVjuxmkIQQUAu9opvQ
	(envelope-from <netdev+bounces-272684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:53:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934934B57A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3FE0302BC3E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400A938F932;
	Fri, 27 Mar 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM/BfZ+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D638CFF5
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644122; cv=none; b=b3AHMjJYXXWfz3VHxhRL2vu66bIlVkNnWb1UTO6X6SMH1rpVrUEqXHsM8K1WTX9kvADlJmmeTBTFyPCaq43VM5lPo1Y9n6xME3+PdzLlUto2PkFSna6PwKgIEaDH7egtbLTsbgjSnCiKTcNiyeWunhyoROe9SrPadlJ2KKwBvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644122; c=relaxed/simple;
	bh=OseZgolmzhAr4jFqxBRNN1L/7ggRloDkt++YOQpR2p8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9q+p9fff2LcrY/GmJbZrxgxxJlVUmDr317kiM886itzd6yXP2HmPjX7f2Znas+CUWXcCM5vHj9cjDa+Lu5B/LWn/zicfleQKQ/BXx8hyD7Gq0IMu4/bx0w+Iix4bnWHzorcjLUI76b6xIgIs7GxuI+oiTixxMkKT+f6hl5VT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM/BfZ+Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso20746135e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774644119; x=1775248919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ/7XD1rJXQYlW2CUYI9bsXyEYg+8UaYCRyEmTmJK34=;
        b=nM/BfZ+YLMVvk5P3x54GwdFqdhKmNJ1Hx2r4zooAmkk5jyqty65BG5Z/uNElRCb6iY
         atigMkijN16Bg0MggWKJdpuEJizIgzzsHp8uWkf3jKGObwBow5TmIAnkXXrqS59Y+HyE
         hUaDJeb7L7MvoygWrNTlThnWgcILNdnwFIxHBmdrUObxwmUefmvY23WjhAsY3hLEmf3V
         rONqyr8uPLBAQt0hOQm9zA/WPdl8mxXYOXcdgzOLm3g5YAip4rEMTMXdKxwYDbKtdNF+
         59EkTsbwaWxSa4pz4TXedRnJ3xpRtQwB741vQE2mzx7GXYus9zCyOz5xX/f6uYz16fe6
         I6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644119; x=1775248919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZ/7XD1rJXQYlW2CUYI9bsXyEYg+8UaYCRyEmTmJK34=;
        b=ZYgddooMe2FLxOGFYiMn0RP/0X69yfVW1wgArH5sx+PwmtFQ+iVPeHRHWBDTEZQvMB
         +pierlRj108zo9kecip056YcyAYwe9D4omBssfYLwo0W9DDfHN2QvVG+NywtPGBQg5If
         vYEscQb9+VZSQNbm2kYE78sfT3hboMndNFf5U28FrdNXZldFJQUkeQ55/7TlyDfcyw/D
         o9LXtGKU0OeyPAo8cEf5BUjVC+b6rSP7X+sBAAuObxlj7uHwYhsUWRD7v1v5meZrP+iH
         s2qZ0uWlCD5nkp3GSZz/fo39c7N/EoaOnIdQSoys4Gt4z+X2ltymaEYqSkIWu0HoMzZe
         I+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVIdJpIRQyKnpJnF0jwPzxlS9Iyzi6VyyU1D5aljuvgnccp9ArscNIfNzLQ0DbBQV+Ffn/4poE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVSjIHXwhS+GVQCVBxnSMC+1hULkhi3sjwxl+C8enPgtWd5Vx
	dfOufOKQSSfxURIK4vO+6OdX4AIS6mqZBRRelzy+izffc+aUBAy0QPIE
X-Gm-Gg: ATEYQzxWwjj2im4bIAEpevmRvB5GMjpUqp7ubNZmYjKOC/Ax2c7Dgt/Fl4tbqQ0SM5y
	7cZz60Hf3/oQCQ6FAeCDlW0Cy7MOAZI1GUPxSXo0qtkUTH2Rn6W4/qUQWoMhSjKO8lCNn+DZtrs
	IDO177nCSQgpIvzj/k0oBby2VWaH5pKgWD2nS0IQwY0lWcf/EzOn+AGmMzkvchCnVXNBA9ljBiO
	2l0aG2e12WSNaBVgzD/8NicIyF8WMPnEtEqq6TxM1JQozZeg73bVYvWxj3JGNmPH1e5iuJCzXSY
	c2GkKZKqOPhc51Zb2nlAnDKwyNiLYHH/LUYR7vpDt5QGDNXHLTADeS2kB3rn4AeupnkI0xHh09h
	pqfW2N2f7LIYmechgpFkpR9sNAK2SdOA5/Q8lBDxf1kPpXiP5xUeGKupzAnqcvNLkt42BzIB0tB
	KFsK04MmpfMKbr/bLIuck0dzLxFy3jl6ClfcFiltK9PI9oGU16pwekWJ9LGw==
X-Received: by 2002:a05:600c:1d15:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48727edf4f5mr64539105e9.26.1774644118896;
        Fri, 27 Mar 2026 13:41:58 -0700 (PDT)
Received: from krava (cust-west-par-46-193-1-135.cust.wifirst.net. [46.193.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712b3ebsm20378445e9.19.2026.03.27.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:41:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Mar 2026 21:41:56 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
Message-ID: <acbrlN_n4Z684h9e@krava>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324150444.68166-3-leon.hwang@linux.dev>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272684-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3934934B57A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
> uprobe programs are allowed to modify struct pt_regs.
> 
> Since the actual program type of uprobe is KPROBE, it can be abused to
> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
> kernel functions.
> 
> For example,
> 
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
> 	return 0;
> }
> 
> SEC("?freplace")
> int freplace_kprobe(struct pt_regs *regs)
> {
> 	regs->di = 0;
> 	return 0;
> }
> 
> freplace_kprobe prog will attach to kprobe prog.
> kprobe prog will attach to a kernel function.
> 
> Without this patch, when the kernel function runs, its first arg will
> always be set as 0 via the freplace_kprobe prog.
> 
> To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
> freplace on kprobe programs with mismatched kprobe_write_ctx values.
> 
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 12330466d58b..f8257bae6081 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6404,6 +6404,14 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
>  		/* remember the offset of last byte accessed in ctx */
>  		if (env->prog->aux->max_ctx_offset < off + size)
>  			env->prog->aux->max_ctx_offset = off + size;
> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
> +			struct bpf_prog *dst_prog = env->prog->aux->dst_prog;
> +
> +			if (env->prog->aux->kprobe_write_ctx != dst_prog->aux->kprobe_write_ctx) {
> +				verbose(env, "Extension program cannot have different kprobe_write_ctx value with target prog\n");
> +				return -EINVAL;
> +			}
> +		}

would it be more clear to check this in bpf_check_attach_target,
instead of depending on actual write to context

jirka

