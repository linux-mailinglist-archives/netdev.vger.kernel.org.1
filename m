Return-Path: <netdev+bounces-21043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F77623D7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53515281AAA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839626B33;
	Tue, 25 Jul 2023 20:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D121F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:45:16 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1301FDF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:45:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e011f45ffso872538266b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690317902; x=1690922702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wAxlkINBbNFBtVNpZoiQdhZS2vHcfIUKcWpV42FDkA=;
        b=5u7aC/4RJZIsOpklaQfDi3kpQYBAD0ULkUHZU2byz12ZdvuO1iZhkRIuStQBpH0ksc
         ICmmx1c9pVrtRQ/OEHVXMBTyFye7D8FqxgTXCwLqh/3VvEQ9o1FyBvY/h/LaC3znIBVS
         TfYQNuCHHRZ3WK+NY7LghraLfVna+xSvJrQEslyAyd3S27+uG/uMyN/IcaxRnzZYtEbY
         llMPZ7oMRkbJwHkoi4FiN61GuO1H1c+RD9N+RQOReJOzQaoKLsM+Xei763wFWFmKmqA3
         mbofhraaU1agKHbx43lxvUYc+DfwznIZy3H4B8tfv0AfFiFNO3TDxrKAWf8H+cBAPAXt
         az4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317902; x=1690922702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wAxlkINBbNFBtVNpZoiQdhZS2vHcfIUKcWpV42FDkA=;
        b=gTOzIFs1KNSot9xtYTYou9eVhAKiVcfCc3Lul/gqrD6G4ELHtGlxvQRS7wpCZ/C7Ci
         nHJgEL9HRrxZKP/Pu9MeB52XDw32DNzqobU3GICulIAe0Ex6d0itHqe/U08bGNy1/HEF
         ob7b0uiZEB2FNETZ2ixv3CSURhv76M66A1EZ/bvu/JehZJ4s5mc04PM8oOSZ419zWgZr
         JGxhlXnIdiOESpfUeisATjJ16nFrJZQGQARVPVyKWAqvB/ctSJ+NpTMfblq8Sv1Zj0d6
         K+jf3Urf9/1wYuhtMrmLA7sIIZP79Z2tZRwOLrdZrutRhOKZTHkca8r/8Z3/q4PbtsJD
         hGLQ==
X-Gm-Message-State: ABy/qLZw91an5/Rsi3GQsj72+ehE+amvXKGhu5TR6N1fdBo/bQZ8buP8
	sxMtHM2YlFk/8IJfe2B1PJp2xA==
X-Google-Smtp-Source: APBJJlGd2L69+S0wL7VA1fs6HKsMk7zV6jl0TrmeNQvRwf1IBDbnx7rBVnpU2qCythmanygFZqrplA==
X-Received: by 2002:a17:907:60c6:b0:99b:b505:eede with SMTP id hv6-20020a17090760c600b0099bb505eedemr1888507ejc.65.1690317902343;
        Tue, 25 Jul 2023 13:45:02 -0700 (PDT)
Received: from google.com (107.187.32.34.bc.googleusercontent.com. [34.32.187.107])
        by smtp.gmail.com with ESMTPSA id k27-20020a1709063e1b00b00982842ea98bsm8544779eji.195.2023.07.25.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:45:01 -0700 (PDT)
Date: Tue, 25 Jul 2023 20:44:56 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org,
	ast@kernel.org
Cc: davem@davemloft.net, daniel@iogearbox.net, martin.lau@kernel.org,
	void@manifault.com, davemarchevsky@meta.com, tj@kernel.org,
	memxor@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/4] bpf: Add detection of kfuncs.
Message-ID: <ZMA0SFhEDRp0UFGc@google.com>
References: <20230317201920.62030-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317201920.62030-1-alexei.starovoitov@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey Alexei/Andrii,

On Fri, Mar 17, 2023 at 01:19:16PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Allow BPF programs detect at load time whether particular kfunc exists.

So, I'm running a GCC built 6.3.7 Linux kernel and I'm attempting to
detect whether a specific kfunc i.e. bpf_rcu_read_lock/unlock() exists
using the bpf_ksym_exists() macro. However, I'm running into several
BPF verifier constraints that I'm not entirely sure how to work around
on the aforementioned Linux kernel version, and hence why I'm reaching
out for some guidance.

The first BPF verifier constraint that I'm running into is that prior
to commit 58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to
kfunc"), it seems that the ld_imm64 instruction with BPF_PSEUDO_BTF_ID
can only hold a ksym address for the kind KIND_VAR. However, when
attempting to use the kfuncs bpf_rcu_read_lock/unlock() from a BPF
program, the kind associated with the BPF_PSEUDO_BTF_ID is actually
KIND_FUNC, and therefore trips over this BPF verifier.

The code within the example BPF program is along the lines of the
following:
```
...
void bpf_rcu_read_lock(void) __ksym __weak;
void bpf_rcu_read_unlock(void) __ksym __weak;
...
if (bpf_ksym_exists(bpf_rcu_read_lock)) {
   bpf_rcu_read_lock();
}
...
if (bpf_ksym_exists(bpf_rcu_read_unlock)) {
   bpf_rcu_read_unlock();
}
...
```

The BPF verifier error message that is generated on a 6.3.7 Linux
kernel when attempting to load a BPF program that makes use of the
above approach is as follows:
   * "pseudo btf_id {BTF_ID} in ldimm64 isn't KIND_VAR"

The second BPF verifier constraint comes from attempting to work
around the first BPF verifier constraint that I've mentioned
above. This is trivially by dropping the conditionals that contain the
bpf_ksym_exists() check and unconditionally calling the kfuncs
bpf_rcu_read_lock/unlock().

The code within the example BPF program is along the lines of the
following:
```
...
void bpf_rcu_read_lock(void) __ksym __weak;
void bpf_rcu_read_unlock(void) __ksym __weak;
...
bpf_rcu_read_lock();
...
bpf_rcu_read_unlock();
...
```

However, in this case the BPF verifier error message that is generated
on a 6.3.7 Linux kernel is as follows:
   * "no vmlinux btf rcu tag support for kfunc bpf_rcu_read_lock"

This approach would be suboptimal anyway as the BPF program would fail
to load on older Linux kernels complaining that the kfunc is
referenced but couldn't be resolved.

Having said this, what's the best way to resolve this on a 6.3.7 Linux
kernel? The first BPF program I mentioned above making use of the
bpf_ksym_exists() macro works on a 6.4 Linux kernel with commit
58aa2afbb1e6 ("bpf: Allow ld_imm64 instruction to point to kfunc")
applied. Also, the first BPF program I mentioned above works on a
6.1.* Linux kernel...

> Patch 1: Allow ld_imm64 to point to kfunc in the kernel.
> Patch 2: Fix relocation of kfunc in ld_imm64 insn when kfunc is in kernel module.
> Patch 3: Introduce bpf_ksym_exists() macro.
> Patch 4: selftest.
> 
> NOTE: detection of kfuncs from light skeleton is not supported yet.
> 
> Alexei Starovoitov (4):
>   bpf: Allow ld_imm64 instruction to point to kfunc.
>   libbpf: Fix relocation of kfunc ksym in ld_imm64 insn.
>   libbpf: Introduce bpf_ksym_exists() macro.
>   selftests/bpf: Add test for bpf_ksym_exists().

/M

