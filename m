Return-Path: <netdev+bounces-84038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE57895599
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41A228974D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9DD86120;
	Tue,  2 Apr 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcCMCPMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B584A58;
	Tue,  2 Apr 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065317; cv=none; b=hmIyQT9Ek6wP9OTgwUAnVEKWf51oLHDWcfT80iP+nVvTdMOTDQjbvRySZUFOoxiuAXeZ0PR9djnmxbQjQwX21iF2963ue8+88PdsI+AbPdM35Kpor9FGgabeCJOSxQhc2LyhncvSLNQgSd2UFeGMc4eRgS2O+w6Ew+1fpCQUsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065317; c=relaxed/simple;
	bh=h261wTULooISsYtb6+TmMP33loVu5QDHmmBO7yc6Ggo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SwjzF2ICiRDuaigzQl7SumtLv2RT2eXYzV0xP/+pEp+EkHOJhPh0UCk1hPjFW0ejS8M73sM/WTsTzQVk25DF0jnpX+LsQY4oSi6EwdKOM+9wjWaSKStkxywd2OLOD/j2yhERHV94E/Wk+Yj9CdwS9lt/fhWBQK10oleiD6OkeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcCMCPMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0194BC433C7;
	Tue,  2 Apr 2024 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712065317;
	bh=h261wTULooISsYtb6+TmMP33loVu5QDHmmBO7yc6Ggo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IcCMCPMOf8zIl358tEnMsbCmxFeHbcpDV+e6r8KULCJpgOsp/YwF8/BTFb+BrSOoW
	 pyyg5ufFumXX5FtAbyCOyiC0GkfXWAvK1Xqdu+z2w3NlNZQrYvHwXiKOZ/H7hRukc0
	 iqRloDI+sBHF/55tPw9lEeHOoHbJANigyCJ7Lcjr7oVsG1AwZkS1yKTrvtw/kzSPk6
	 u3Y0mJ+whvFHbkF26tRfSOSksHQp0ne99KsFogfw8IdXmsNHPEAEWvmulXBX79pyXr
	 4YdR9pfekieTs0/BAUpxTeq+rUJwRrjrHsuDnd46NUA2Z390UuXZusWlA3g0oOHG2q
	 Rs+tljYe/g+gA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/2] Add 12-argument support for RV64 bpf
 trampoline
In-Reply-To: <20240331092405.822571-1-pulehui@huaweicloud.com>
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
Date: Tue, 02 Apr 2024 15:41:54 +0200
Message-ID: <87plv7rie5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> This patch adds 12 function arguments support for riscv64 bpf
> trampoline. The current bpf trampoline supports <=3D sizeof(u64) bytes
> scalar arguments [0] and <=3D 16 bytes struct arguments [1]. Therefore, we
> focus on the situation where scalars are at most XLEN bits and
> aggregates whose total size does not exceed 2=C3=97XLEN bits in the riscv
> calling convention [2].
>
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184=
 [0]
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769=
 [1]
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downl=
oad/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [=
2]
>
> Pu Lehui (2):
>   riscv, bpf: Add 12-argument support for RV64 bpf trampoline
>   selftests/bpf: Add testcase where 7th argment is struct

Thank you!

For the series:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

