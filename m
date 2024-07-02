Return-Path: <netdev+bounces-108478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE04923F28
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0915E1C21C4C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03C1B47A5;
	Tue,  2 Jul 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYHVcnak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E814F135;
	Tue,  2 Jul 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927621; cv=none; b=eIfbgNooS1/KE11dLtsFTjZM+5afrNjuTDciuXW126hDeQn51v+2DGeG6HaYi70j6rjd1SUk0vLUMWOXaxrnACK/Rqi/cxb8KlVJ6XI3Lg8X7KMFBYLQZ8NTVIHB9eIxEtjYcmN1OkHl05f0r0TshDlTDGOpivyFW651dA+Qxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927621; c=relaxed/simple;
	bh=/GVZeyDyQK8AXbMqTZiufCNDNqS1Z4p3Wb4mdqN502c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+2XNxyrmXZy6FETrSLW3dubTajoGWetpi8XDeDLAS8WiF+HMaCC2u5xVHSE+LllLDdXwPRfYbt5eRtFuljZhO2oB+yUVrI2tJixlxUaPbYTLVbD5Yr0aX6qOoiAFO/N6+M17oSdl5LTXJvQD9OXxCjL+y6sMOLUd9+Fh1e8FGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYHVcnak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55ABC116B1;
	Tue,  2 Jul 2024 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927621;
	bh=/GVZeyDyQK8AXbMqTZiufCNDNqS1Z4p3Wb4mdqN502c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qYHVcnakAG4sRMAo3JTbas7o8n17yRD/nZuJ1NgivbBobs1otqujnKkYxtKxI/GSJ
	 sCsBmkjTg0/gEdsAFSJzIeGCkz73UVOArNxlMnoA4MvbdS0qf3VbGlTPQxwz6b0cVv
	 eHfj0CEcrplKTBEd5UziGc+4Tj75dsFsIbdV9npAI+iLVuNNxOdXXZojy/8tt7OADo
	 rFtS6qA5/nDbiztqdJugvEiljupR9AIKqmdRihLA2Z5pqyPPhWd2EuTUUH6ae/RjMx
	 aSPOrAA0Ja4EY7UXpZ8siBometN+7HGvwRqyeGBfMkLlBDxoNKc0+nQ59KKoUgDM28
	 1Bx1XfwzDqIIA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v6 1/3] riscv, bpf: Add 12-argument support for
 RV64 bpf trampoline
In-Reply-To: <20240702121944.1091530-2-pulehui@huaweicloud.com>
References: <20240702121944.1091530-1-pulehui@huaweicloud.com>
 <20240702121944.1091530-2-pulehui@huaweicloud.com>
Date: Tue, 02 Jul 2024 13:40:03 +0000
Message-ID: <mb61pfrsrdia4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
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
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoQDNBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nflEAQCjAe+AxuQrgIDgc1bxgHeB/tv8iUpO
wMzYeE99NEwXSgD7BAY3XDTU5cNevHTPXgOmwwAXJX8st3eeEEzoBlhRzgU=
=SI05
-----END PGP SIGNATURE-----
--=-=-=--

