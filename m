Return-Path: <netdev+bounces-182150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CAA8805D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880123B117E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E929B215;
	Mon, 14 Apr 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vE5ERu/Z"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA841DFCB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633782; cv=none; b=MbJdpxqK9qNe5S8qFous5PXTMpApHwO3Vv8OlXgZcOhsqN0X0bDTQs9F9q2EHfNzy5Nx92vLKuCP7ousPhQgbAOBcVRNI9NLEuyJWrG5fNg1h7fbic/+8l6rw1SEodU7AkCOfqMzjdrzb9B7eFSd/rKAF0nejut8o0cuddCk4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633782; c=relaxed/simple;
	bh=OiYVXkZSfdT6nhBT2tfGSCxBMvJ7xMsZXCDnusianr4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=h3MSa45plabxR7CtOMFYSi3fAfmjWqJxIypj85pRg2+D0e/ZSAGF16miTzD55xWpPZdUFg1lWRYGjPkRidJWCg5kC5Id1JdDlYuyPGpms1JC1hPf7a3DE04MEhs6lor8d67aq5AX2aKwsnSGlciu8Pb72VZbJSz6prboOdelisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vE5ERu/Z; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744633777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvai2S/0OVjs1P8gmT3IZRMvxpZzuZvGIu5Rcie6gGc=;
	b=vE5ERu/ZrIA7g80vZ+sKYzWIFlzlKhHC5X2/X03m8g+9hGUeAkU4HoJoUh0f2+fkukd86g
	TZPGQdhxxuiZHyln89OnTXjvO/qGheV4XMeHVq9d5m5ccxtfX6juhcuhXcmvO9aygjXhDK
	HICqXuHd3K+1tSwdHhnZLJhvscPtKoM=
Date: Mon, 14 Apr 2025 12:29:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <bab35a470addc4d3d32551c6776d4d4884def193@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2] bpf, sockmap: Introduce tracing capability
 for sockmap
To: "kernel test robot" <lkp@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mrpre@163.com,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Cong Wang"
 <xiyou.wangcong@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <202504141925.PFNOfZzb-lkp@intel.com>
References: <20250411091634.336371-1-jiayuan.chen@linux.dev>
 <202504141925.PFNOfZzb-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

2025/4/14 19:54, "kernel test robot" <lkp@intel.com> wrote:

>=20
>=20Hi Jiayuan,
>=20
>=20kernel test robot noticed the following build errors:
>=20
>=20[auto build test ERROR on bpf-next/master]
>=20
>=20url: https://github.com/intel-lab-lkp/linux/commits/Jiayuan-Chen/bpf-=
sockmap-Introduce-tracing-capability-for-sockmap/20250414-093146
> base: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link: https://lore.kernel.org/r/20250411091634.336371-1-jiayuan.c=
hen%40linux.dev
> patch subject: [PATCH bpf-next v2] bpf, sockmap: Introduce tracing capa=
bility for sockmap
> config: arm64-randconfig-001-20250414 (https://download.01.org/0day-ci/=
archive/20250414/202504141925.PFNOfZzb-lkp@intel.com/config)
>=20
>=20compiler: clang version 21.0.0git (https://github.com/llvm/llvm-proje=
ct f819f46284f2a79790038e1f6649172789734ae8)
>=20
>=20reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20250414/202504141925.PFNOfZzb-lkp@intel.com/reproduce)
> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504141925.PFNOfZzb-l=
kp@intel.com/
> All errors (new ones prefixed by >>):
>=20
>=20>=20
>=20> >=20
>=20> > ld.lld: error: undefined symbol: sock_i_ino
> > >
> >=20
>=20 >>> referenced by sockmap.h:70 (include/trace/events/sockmap.h:70)
>  >>> kernel/bpf/core.o:(trace_event_raw_event_sockmap_redirect) in arch=
ive vmlinux.a
>  >>> referenced by sockmap.h:121 (include/trace/events/sockmap.h:121)
>  >>> kernel/bpf/core.o:(trace_event_raw_event_sockmap_strparser) in arc=
hive vmlinux.a

I see, CONFIG_NET is not set...

