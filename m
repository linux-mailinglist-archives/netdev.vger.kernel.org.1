Return-Path: <netdev+bounces-84065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEE895689
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F1B1F22B6B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10786268;
	Tue,  2 Apr 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTMpo1PZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1E84037;
	Tue,  2 Apr 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067927; cv=none; b=mXAZ6mVZFMgyYtLkrn3a/5meHOPcCrFkOSP5nLQC87ZKhm/HjIU9XVfybN2kEkQU/KoAyeyd/Qpj/22w1Eu6+mR/29RzRc+nMOwJwrkXp00svX8M5SK9BhKz6DEBQn5Fjnp5/+UdLhMVw0vCjzE8uVLHmWf77/Toml2TmpRv6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067927; c=relaxed/simple;
	bh=05KPAcK7dAHejAqXCS3gStMEGMQcesXYI/mYO3QHKbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgHywx5MSREv/NCu7hGcC6HSVB8mKFKXo5JbhnSu2MwsIV/St0YMZ9MutXHaSfAd5QNhKK60OYHkCi7Z1EIVlH1wHHWqVqv+kkPOfDhWC9cicKSCkmS9LDw7imYL/Ss71rVGOoAtn4ew59U2CG9La6c3lRZA/UR3mbE2schXapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTMpo1PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FECC433F1;
	Tue,  2 Apr 2024 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067927;
	bh=05KPAcK7dAHejAqXCS3gStMEGMQcesXYI/mYO3QHKbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aTMpo1PZGrw4qjemIspGevm8YLHd2f/XrXbhGu3W9kgoM99qOUtJWV0Q8wTv7foSh
	 IxUF/IdqAwa09OU7wlFmkoL0wH1VLwZ1GjlU/FnLR3kODxIL7BcswcOFUNt/J8kL/N
	 1SCMR5XQxyX9jJvyECbCP3cuVoZq4T6iAi/CFNB9W1eonl2PZYx+sGPhB70uFlUsqr
	 FSHsrn9UzLA2ljcisrcmoyCiH8vwodEUACVpX8gDOpdT3yr73f7bbnu84lL4GLjtrb
	 C5u8/sWIZnRDlnKnUvP8M2sya7/64U8HFSKg0+OlrqPS6q16Y1euvumdy7mtWOA69f
	 0RmSF7TtmDAug==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, Stefan O'Rear <sorear@fastmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
In-Reply-To: <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <ed3debc9-f2a9-41fb-9cf9-dc6419de5c01@huaweicloud.com>
Date: Tue, 02 Apr 2024 16:25:24 +0200
Message-ID: <87cyr7rgdn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/3/29 6:07, Conor Dooley wrote:
>> On Thu, Mar 28, 2024 at 03:34:31PM -0400, Stefan O'Rear wrote:
>>> On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> This patch relaxes the restrictions on the Zbb instructions. The hardw=
are
>>>> is capable of recognizing the Zbb instructions independently, eliminat=
ing
>>>> the need for reliance on kernel compile configurations.
>>>
>>> This doesn't make sense to me.
>>=20
>> It doesn't make sense to me either. Of course the hardware's capability
>> to understand an instruction is independent of whether or not a
>> toolchain is capable of actually emitting the instruction.
>>=20
>>> RISCV_ISA_ZBB is defined as:
>>>
>>>             Adds support to dynamically detect the presence of the ZBB
>>>             extension (basic bit manipulation) and enable its usage.
>>>
>>> In other words, RISCV_ISA_ZBB=3Dn should disable everything that attemp=
ts
>>> to detect Zbb at runtime. It is mostly relevant for code size reduction,
>>> which is relevant for BPF since if RISCV_ISA_ZBB=3Dn all rvzbb_enabled()
>>> checks can be constant-folded.
>
> Thanks for review. My initial thought was the same as yours, but after=20
> discussions [0] and test verifications, the hardware can indeed=20
> recognize the zbb instruction even if the kernel has not enabled=20
> CONFIG_RISCV_ISA_ZBB. As Conor mentioned, we are just acting as a JIT to=
=20
> emit zbb instruction here. Maybe is_hw_zbb_capable() will be better?

I still think Lehui's patch is correct; Building a kernel that can boot
on multiple platforms (w/ or w/o Zbb support) and not having Zbb insn in
the kernel proper, and iff Zbb is available at run-time the BPF JIT will
emit Zbb.

For these kind of optimizations, (IMO) it's better to let the BPF JIT
decide at run-time.


Bj=C3=B6rn

